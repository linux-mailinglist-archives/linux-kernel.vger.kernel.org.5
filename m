Return-Path: <linux-kernel+bounces-163303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA748B68F0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E1F82812FC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E314311CBD;
	Tue, 30 Apr 2024 03:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fdZHpc/J"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D21F101CE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 03:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448135; cv=fail; b=LjnOcjGSXgUK81Yusjn9igYb/mIPnxhDbGjPlZwetvw8dRgud8+HSaFgRf1XlcI1eAVsTwh5JgyTD4JBmsy6Ut1piIIPPvLesDJtYNsFV8j4H0ZfNY/3UCnkG0ol0peGywxOukSwfjZnY6pZO/WSQY6R1xiMXqQFs2OpczF0Els=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448135; c=relaxed/simple;
	bh=nwI2ds1m4eQQGQE3Rf+F75w1BBN81BmdBwfuUxoL+Kk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=qvCPaB04kvXtIBRQ89FT3MeUcefc0aVdQSAMwxK406LTEpf8CwuMqHBX5RmPuWp8NhjqXTkdOU5Bau0FKhiiLIoT1F4MQ1sMk0RXZUrIqXAVnGDbpqSEAnE3NyQxPFhTizAEGpU6BNxvJCWbdppSZ3HZE2JB1IMo3xWr6dabzV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fdZHpc/J; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714448133; x=1745984133;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=nwI2ds1m4eQQGQE3Rf+F75w1BBN81BmdBwfuUxoL+Kk=;
  b=fdZHpc/JqdTBJNGMCJlc78fTpShbcZqG5gq9CnJrVwjyFUVQnH7HW/l0
   5qCYpj85ZssgEV+7igTZWUjkX+WrJNycn3Wy5nBeOGDg7HpD/d7RNgMfy
   AG/MM7bz7JpjvX/OYAzCQY48u1Cq/R2/FFV5DdXJqUJYcujxnCsiHZcdi
   kiTWocphUMFJcyVMCGSoLi+cjkONkYrXKtx4ELn4PW+npHdw3ZPJqnaBJ
   fZ/J2pO/0T/uFdcBbQGmm6FgJaWNOLfED6ba0ILyuKQj9zV1WiOaVFAFS
   hvGIVaO8n60fXxuJowTy5xGMrAEeZbxQ6s//CU+jT7Ylnf0EUPHwBjxGz
   w==;
X-CSE-ConnectionGUID: lucmm5riRw6f20pcvqHzNA==
X-CSE-MsgGUID: K2pskozaTe+r7C+sAydERA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10257528"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="10257528"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 20:35:32 -0700
X-CSE-ConnectionGUID: 8zy2AZuZRPKW15q7LeqHUw==
X-CSE-MsgGUID: GWpLD31GRFanUR/qU/Nx4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="49519550"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 20:35:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 20:35:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 20:35:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 20:35:30 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 20:35:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnA2uZ4u67E1oUNRgGVy8KNHENVan+25A83jtCgROM32/UnnSpQ40Jhsnlz/W8OSsDNDosyiTR62WPeqaBNnyhhRi72ZI2OoW0QSEpPOmvJRtONlOAji9t4pVjH+dFTFaoBIzVJrfKkDDjdRUrysYtL7lcIlQio7qzL12y3AKnNZxtlgrnlRsGrZDzEn/kmpYqummQALHdpLOtEjGtBvp/6UfByVvFifQ1O2t/Y4gXJSn5xSREovY9MEl7irTWMUSxivSn4uy3V3AOBRWQEDTMTgOW4QBaaPxKGLb7HCB9yTbfSFDij8ee0bVGl59pMFEZ4HRvfVLffaJAjYSkojRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rq9+3HTV9iDXT3xei2OTU9AwMGxK915xqCeozxeKm5U=;
 b=SDpeYSHGSCnWeAKXSLgtD2QVqs2B26wFr+45WURMm8TMJFUrMmwhH0644RECsfyED7q0bZdC6dxSlKgahFC699HOJCB3QxJJ/SdNKui1a1D7ghR2oXNltVXk4rdpXX8S/glo5MI7Drr25YRyOZ+g0D9B8CgAtUiQh4hruiIuQOVa1bKE2RNm64Bd2cmIign/iBMgi6iemilXPEUDQGfnfsJGd4qLr9qgE0S/AzgjDaZyv57aleoD18KCeQSrAqsYgYR55y0ZPvkFj7mY4vnSMTCp/S4u0NWJ6cVmp866RdMkXKfsPdYVia+Beool7dcHjDg1v7BxahDy3QVRqMLezw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB8346.namprd11.prod.outlook.com (2603:10b6:a03:536::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 03:35:28 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 03:35:28 +0000
Date: Tue, 30 Apr 2024 11:35:17 +0800
From: kernel test robot <oliver.sang@intel.com>
To: David Hildenbrand <david@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, "Darrick J. Wong"
	<djwong@kernel.org>, Hugh Dickins <hughd@google.com>, Jason Gunthorpe
	<jgg@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, <linux-mm@kvack.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [linus:master] [mm/madvise]  631426ba1d:
 stress-ng.shm-sysv.ops_per_sec 8.2% improvement
Message-ID: <202404301149.2850aac-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0062.apcprd02.prod.outlook.com
 (2603:1096:4:54::26) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: 78287ae3-4b85-4043-84b5-08dc68c693f7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?PBKCyfv79WZI1OgejGzJHvTVHkj2x9HrM4fCgYEwvBeuBbuDPXzT/eU9mv?=
 =?iso-8859-1?Q?3iC5s0oH5BOZt63wfgiLhDualzgTy1nDvtXL4BFxqAO14aIG5uvYoK+98R?=
 =?iso-8859-1?Q?sNlEdSzqYFC40m0C0njqdeWYB/QHSOx5vUjiDsEosieFaHSifj2XJzJ8sP?=
 =?iso-8859-1?Q?r2fBP3KQEhY4dDGCaihuOVLsf82HmKNu47V9wkg6S6eBm/HiVpEzzG2GYo?=
 =?iso-8859-1?Q?3jYIlHwnugdDMROw6vHfnOCh42MLOljYYJGfbkasJVMyTv0WR0+NxOgkDB?=
 =?iso-8859-1?Q?z9EES5GPeztaR9+j3Ipa5MfVFD8OPGQGRPLGyL6NaQvXOcO9eyj68jk6IZ?=
 =?iso-8859-1?Q?Yk4FnPoWW9kQXep8AnNEwFxWCrh3xsc+qq6uR65toT/smiFEOVRPeU2D79?=
 =?iso-8859-1?Q?Nigd09XGffZSNk2L0sLKKhjXV1CyYK2DuOaex6SOv+FiXd0XzhgAtT8VOd?=
 =?iso-8859-1?Q?1QPiNQKoxD/W3Yn2gmDKubBXvT8jTyrr6LQv2GfFvcKw2E+9tMcTjvC92m?=
 =?iso-8859-1?Q?KtmigWnAcXT9oU95p7cHGYHF0w5qK6SUb64bOrOkVskDjz9wJNMIthhygU?=
 =?iso-8859-1?Q?XBbcuLKHX/jvwyWsR83UYcXl9j+kyRr9EYTwcc1kCUCNRJGY1kMmgsN0x+?=
 =?iso-8859-1?Q?IulmMIzJRWaIq8XRLcyxvaIFq2VMDwCfLwxkKbwR6obpFe2mTnogt6GoUI?=
 =?iso-8859-1?Q?J5gcD4hd+QNy1Q5cox+f9kJjuyinlCOpq574+neS/I8a7vDScv/8Ae+cMt?=
 =?iso-8859-1?Q?nb0Nj0LLRfkMdw8xDCUEjtZb8gDUFIwgnTl1Ex/IWOVXy3dfZ90O8ocPYt?=
 =?iso-8859-1?Q?AkTdktOy/41PBkoifeiLXb1ob238U6zBOcFP77aklU8j4J6pYbiTgwTqk+?=
 =?iso-8859-1?Q?UrjA60hGGcJ3Z3lnLFKYnn/ETUWkcYfrlCIl0tPavAtOewBQgvdJjkCRa0?=
 =?iso-8859-1?Q?XsjxOpIXFd+5z1yD/M/TpAS/SqYUGwRaZdU75bLgW017ZZBPAfedCdGBx5?=
 =?iso-8859-1?Q?2tScIm4LGVHqiEZwZJNXTAWKOQWNwc5oobjHbeZb0XTs37yahclL9zVnU7?=
 =?iso-8859-1?Q?LZqdMXxpSCdG2Ce1Co8Wu9Y1lilVNIWVQXpwhrhW1sLQL4CT1zQZ5pL+li?=
 =?iso-8859-1?Q?h7ut0Y1unR6D9USAV21V6gsoacm++c2ycD7sqbCxk/c3D0frWgEtmMvZcE?=
 =?iso-8859-1?Q?gyPe3rbaeYW8d5casncV2wOQQtHBIpSC+PMol9m5bOENcUISGVfkkBxk4N?=
 =?iso-8859-1?Q?z7D3HR0aEhiz+ck5Mu1gVa4m/ah9aqv4Ls/FGGVDk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?NaNco+OA4LGUZ0cBQR6gpdyKN0mz4R1e13PSrapB3zsqXH8fDyTvJrkxYC?=
 =?iso-8859-1?Q?Vf4RpLKtXw4RsgLghmqPdw9Dfz/xV0CAPDbCDuv0mWRZGEFE4KWxAuu8xO?=
 =?iso-8859-1?Q?XK0fZVbF7TdTFt3y1Hw+9oNg2IniQufS9soisTWxK1yS6jlv8Ap8I80W6h?=
 =?iso-8859-1?Q?uXHpetGa3MqxyYnHfurXlzRl7VtodRR0GSp4HjIdpXMHcYXrise4c/DFDg?=
 =?iso-8859-1?Q?hgOZvNW2XoEIj9ksG8O8zv7QBwgM31Djb1dS/zRl8lefc51+JxhYAYrcxO?=
 =?iso-8859-1?Q?cgJ2RgqRTuVBhTuDvnngwMDHThyBvWy1Du2IpLwnxVgqOq7S9nQn+qjNZd?=
 =?iso-8859-1?Q?qEy5wTThzHyHiLr0kaSRqrVf5QtQbfhntty8MB4LmAtEyVWF6uMTkWY43+?=
 =?iso-8859-1?Q?45T4VMo3We9zyW5IG9bTjzAjB1Dj+/PEFgjwmAfIyit5sapadjzNjEYePF?=
 =?iso-8859-1?Q?FQnpRYGAiRcm7tH9/miuLLeqODcoFEMFk7NU+Ryy6Ul1FRo+pEGFWcKaEk?=
 =?iso-8859-1?Q?kVdc/xHJn4PJGD5ArOLz0VmEycx3kOOOiGSmNMeHwEmi/LSRnQ8wWIs76a?=
 =?iso-8859-1?Q?NnWaeJCDzT7Ehy6O4Qu7I+Aj7+/hMj8KiADO8F53lAssdrGnl9qj7CSY1i?=
 =?iso-8859-1?Q?rTn+kJze+h3po8Uf2v0+3RaDpASK1j586q0fbF/Fs3cv351hmdofU6NVgz?=
 =?iso-8859-1?Q?wuuwJhOsHrGM7FubKARLKMx9oiPlaCqemIMlEMla7mSkXsR2LUyFfnOUkL?=
 =?iso-8859-1?Q?QKAXlOoYEMIBRBwVxB0gavzhP5E+McAHmmeSX7meVNCHji3hjmtnpawyYh?=
 =?iso-8859-1?Q?dR1IcJsoZY/wxE2F9GFBYdCYQ+y16vX7Fx6dqiOTo8hDYdujJrkgZnAM7u?=
 =?iso-8859-1?Q?XkJw1nKCTQ1HAXnSwYsimtadOlMCpp3CxBCSEjH7U09qopKqa3idP6hYAW?=
 =?iso-8859-1?Q?GPneoQz80oY/0yhxuWI4SdsalqUs9tIgUbFhnchMToBPhsGVjF2NLe3rGg?=
 =?iso-8859-1?Q?KPlQLRaWJjKOOPVdKVphURIF64dDs3SoidUKXrmzXdT1OpN9xgoi86DWgh?=
 =?iso-8859-1?Q?cUslGPn0d0g83OauRvybODr9Qei7/P5XWSYaXAha7wPxE4lJV+BOjdkr8r?=
 =?iso-8859-1?Q?tKlxMP3TBpI9AKy/TdiB8egVpRq1R+w4FJTbLpqimTsekbNtBiLGmylVOu?=
 =?iso-8859-1?Q?zn2/uHAdIZ/hO3+5BnLduLe7KLhZhFiUkybhIa/ojI3fO61KePyWG9kl1S?=
 =?iso-8859-1?Q?10chJpeApd09wy9NK0Kt0a2VAOfRgfu0mc30sTLxl3GW1JieKoOmmWMrAt?=
 =?iso-8859-1?Q?re+DztAaTSdTNxgG6FcLg1+nLxt0NMAgHJiWGeaW+rPbkeVOKKwtGEMAx3?=
 =?iso-8859-1?Q?9smpVSIj7e+ZqTU2bQ4ASRaarBGXf+XQRh4lLKHC6/wnWEFbCt6hRG+Izo?=
 =?iso-8859-1?Q?0qEjo60ZH4Z7RWd66EHCTH/WgEiP8WhX0Jb21HGnxgSUlJ2RHXBi+Nmfmv?=
 =?iso-8859-1?Q?mUJCW7vtgtllPXtT2d/nsEuWcqpyRg6yQsGLEY6499IzXSxzuaOAb9gpFX?=
 =?iso-8859-1?Q?BDklw0lg1ESo/qXCLKi+5SGiEIfuKVdZn8a6tQ/g9ZVw1yPeZpiEWv0f38?=
 =?iso-8859-1?Q?RHcAIVhucRTZHTTJXiNxbklFOrHuJqxJIUR7fRo8vx6lhlapZ5295Vpw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78287ae3-4b85-4043-84b5-08dc68c693f7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 03:35:27.9029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orB8m3hTAwtTVr/Tvj8xNJRExh97croOA14UmdLq3UIy9rqpJFO9KifawcIJwOgrO1sLgsh+LyVOMkuvOwnvWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8346
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 8.2% improvement of stress-ng.shm-sysv.ops_per_sec on:


commit: 631426ba1d45a8672b177ee85ad4cabe760dd131 ("mm/madvise: make MADV_POPULATE_(READ|WRITE) handle VM_FAULT_RETRY properly")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: shm-sysv
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240430/202404301149.2850aac-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/shm-sysv/stress-ng/60s

commit: 
  v6.9-rc4
  631426ba1d ("mm/madvise: make MADV_POPULATE_(READ|WRITE) handle VM_FAULT_RETRY properly")

        v6.9-rc4 631426ba1d45a8672b177ee85ad 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   5394576           +12.4%    6065916 ±  2%  cpuidle..usage
    301458 ±  8%     -15.9%     253467 ±  5%  numa-meminfo.node0.SUnreclaim
     75427 ±  8%     -16.0%      63343 ±  4%  numa-vmstat.node0.nr_slab_unreclaimable
    155389           +12.6%     174982        vmstat.system.cs
   3610346 ±  6%     -11.0%    3213619        sched_debug.cfs_rq:/.avg_vruntime.min
   3610346 ±  6%     -11.0%    3213619        sched_debug.cfs_rq:/.min_vruntime.min
     22086           +11.9%      24711        sched_debug.cpu.nr_switches.avg
    185.25 ± 10%     +59.6%     295.75 ± 44%  sched_debug.cpu.nr_uninterruptible.max
     84.67 ±  6%     +33.7%     113.22 ± 22%  sched_debug.cpu.nr_uninterruptible.stddev
   1800984           +17.4%    2113826        stress-ng.shm-sysv.nanosecs_per_shmdt_call
    478970            +8.1%     517685        stress-ng.shm-sysv.ops
      8047            +8.2%       8706        stress-ng.shm-sysv.ops_per_sec
    208527           +22.4%     255186        stress-ng.time.involuntary_context_switches
 6.355e+08            +8.0%  6.864e+08        stress-ng.time.minor_page_faults
     19049            -1.4%      18777        stress-ng.time.percent_of_cpu_this_job_got
     11326            -1.5%      11153        stress-ng.time.system_time
    156.02            +6.3%     165.84        stress-ng.time.user_time
   4855836           +10.3%    5358096        stress-ng.time.voluntary_context_switches
   1329171            +2.0%    1355214        proc-vmstat.nr_file_pages
    702918            +4.8%     736877        proc-vmstat.nr_inactive_anon
    560179            +4.6%     586223        proc-vmstat.nr_shmem
     43521            -6.0%      40920        proc-vmstat.nr_slab_reclaimable
    132019            -4.7%     125797        proc-vmstat.nr_slab_unreclaimable
    702919            +4.8%     736878        proc-vmstat.nr_zone_inactive_anon
 6.371e+08            +8.0%  6.883e+08        proc-vmstat.numa_hit
 6.363e+08            +8.0%  6.875e+08        proc-vmstat.numa_local
  60980733           +30.1%   79334617        proc-vmstat.pgactivate
 6.367e+08            +8.0%  6.875e+08        proc-vmstat.pgalloc_normal
 6.364e+08            +8.0%  6.873e+08        proc-vmstat.pgfault
 6.356e+08            +8.0%  6.863e+08        proc-vmstat.pgfree
 6.158e+08            +8.0%  6.651e+08        proc-vmstat.unevictable_pgs_scanned
      5.96            +3.5%       6.17        perf-stat.i.MPKI
 2.937e+10            +3.4%  3.038e+10        perf-stat.i.branch-instructions
     64.43            +1.3       65.77        perf-stat.i.cache-miss-rate%
 8.295e+08            +7.5%  8.921e+08        perf-stat.i.cache-misses
 1.281e+09            +5.3%  1.349e+09        perf-stat.i.cache-references
    160399           +11.6%     179016        perf-stat.i.context-switches
      4.04            -6.1%       3.80        perf-stat.i.cpi
 5.634e+11            -2.3%  5.505e+11        perf-stat.i.cpu-cycles
     31426            +7.9%      33916        perf-stat.i.cpu-migrations
    675.36            -9.3%     612.68        perf-stat.i.cycles-between-cache-misses
  1.38e+11            +3.9%  1.434e+11        perf-stat.i.instructions
      0.26            +6.7%       0.28        perf-stat.i.ipc
     83.99            +5.4%      88.56        perf-stat.i.metric.K/sec
   9516734            +4.5%    9947225        perf-stat.i.minor-faults
   9524443            +4.5%    9955476        perf-stat.i.page-faults
      6.02            +3.3%       6.22        perf-stat.overall.MPKI
     64.24            +1.6       65.86        perf-stat.overall.cache-miss-rate%
      4.08            -5.6%       3.85        perf-stat.overall.cpi
    678.05            -8.6%     619.59        perf-stat.overall.cycles-between-cache-misses
      0.25            +6.0%       0.26        perf-stat.overall.ipc
    217255            -8.1%     199679 ±  3%  perf-stat.ps.cpu-clock
 5.393e+11            -9.3%  4.891e+11 ±  4%  perf-stat.ps.cpu-cycles
    217255            -8.1%     199680 ±  3%  perf-stat.ps.task-clock
     21.82           -21.8        0.00        perf-profile.calltrace.cycles-pp.faultin_vma_page_range.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
     19.69           -19.7        0.00        perf-profile.calltrace.cycles-pp.lru_add_drain.faultin_vma_page_range.madvise_vma_behavior.do_madvise.__x64_sys_madvise
     19.69           -19.7        0.00        perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.lru_add_drain.faultin_vma_page_range.madvise_vma_behavior.do_madvise
     19.68           -19.7        0.00        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.faultin_vma_page_range.madvise_vma_behavior
     19.54           -19.5        0.00        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.faultin_vma_page_range
     20.37           -18.8        1.59        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain
     20.35           -18.8        1.58        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu
     21.84           -17.6        4.26        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     21.84           -17.6        4.26        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__madvise
     21.84           -17.6        4.26        perf-profile.calltrace.cycles-pp.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     21.84           -17.6        4.26        perf-profile.calltrace.cycles-pp.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     21.84           -17.6        4.26        perf-profile.calltrace.cycles-pp.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.84           -17.6        4.26        perf-profile.calltrace.cycles-pp.__madvise
      0.64            +0.0        0.67        perf-profile.calltrace.cycles-pp.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault.__do_fault
      0.67            +0.0        0.70 ±  2%  perf-profile.calltrace.cycles-pp.alloc_pages_mpol.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault
      0.62 ±  2%      +0.0        0.65 ±  2%  perf-profile.calltrace.cycles-pp.__alloc_pages.alloc_pages_mpol.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      0.52 ±  2%      +0.0        0.56 ±  3%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.alloc_pages_mpol.shmem_alloc_folio.shmem_alloc_and_add_folio
      0.71            +0.0        0.75 ±  2%  perf-profile.calltrace.cycles-pp.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault.__do_fault
      0.55            +0.0        0.59        perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault.stress_shm_sysv_child
      0.73            +0.0        0.78        perf-profile.calltrace.cycles-pp.clear_page_erms.shmem_get_folio_gfp.shmem_fault.__do_fault.do_fault
      0.57            +0.1        0.63        perf-profile.calltrace.cycles-pp.truncate_inode_folio.shmem_undo_range.shmem_evict_inode.evict.__dentry_kill
      0.60            +0.1        0.67 ±  2%  perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exit_mm.do_exit
      0.64            +0.1        0.74        perf-profile.calltrace.cycles-pp.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm.copy_process
      0.88            +0.1        1.02 ±  2%  perf-profile.calltrace.cycles-pp.anon_vma_fork.dup_mmap.dup_mm.copy_process.kernel_clone
      0.83            +0.2        1.05        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.unmap_region
      0.84            +0.2        1.06        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.unmap_region.do_vmi_align_munmap
      0.84            +0.2        1.06        perf-profile.calltrace.cycles-pp.lru_add_drain.unmap_region.do_vmi_align_munmap.do_vma_munmap.ksys_shmdt
      0.84            +0.2        1.06        perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.lru_add_drain.unmap_region.do_vmi_align_munmap.do_vma_munmap
      1.64            +0.2        1.88 ±  2%  perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
      1.79            +0.2        2.04 ±  2%  perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      1.87            +0.3        2.13 ±  2%  perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.95            +0.3        2.22 ±  2%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      1.95            +0.3        2.22 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      1.95            +0.3        2.22 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe._Fork
      1.95            +0.3        2.22 ±  2%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      2.01            +0.3        2.29 ±  2%  perf-profile.calltrace.cycles-pp._Fork
      1.48            +0.4        1.85        perf-profile.calltrace.cycles-pp.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault.__do_fault.do_read_fault
      1.72            +0.4        2.11        perf-profile.calltrace.cycles-pp.__do_fault.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      1.72            +0.4        2.11        perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fault.__do_fault.do_read_fault.do_fault
      1.72            +0.4        2.11        perf-profile.calltrace.cycles-pp.shmem_fault.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      1.76            +0.4        2.15        perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.__get_user_pages
      2.06 ±  7%      +0.4        2.51        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages
      2.06 ±  7%      +0.4        2.51        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.free_pages_and_swap_cache
      2.07 ±  6%      +0.4        2.52        perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu
      2.14 ±  6%      +0.5        2.60        perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap
      2.18 ±  6%      +0.5        2.64        perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput.exit_mm
      2.18 ±  6%      +0.5        2.64        perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput
      2.18 ±  6%      +0.5        2.65        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.exit_mmap.__mmput.exit_mm.do_exit
      0.00            +0.5        0.52 ±  2%  perf-profile.calltrace.cycles-pp.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput.exit_mm
      0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.exit_mmap
      0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.exit_mmap.__mmput
      0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp.lru_add_drain.exit_mmap.__mmput.exit_mm.do_exit
      0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.lru_add_drain.exit_mmap.__mmput.exit_mm
      3.88 ±  3%      +0.7        4.60        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.88 ±  3%      +0.7        4.60        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      3.87 ±  3%      +0.7        4.59        perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.87 ±  3%      +0.7        4.59        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.87 ±  3%      +0.7        4.59        perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.77 ±  3%      +0.7        4.48        perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
      3.77 ±  3%      +0.7        4.49        perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      3.77 ±  3%      +0.7        4.49        perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1.93            +1.1        3.00        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_activate.folio_mark_accessed.zap_present_ptes
      1.93            +1.1        3.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_activate.folio_mark_accessed
      1.93            +1.1        3.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_activate
      2.02            +1.1        3.10        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_activate.folio_mark_accessed.zap_present_ptes.zap_pte_range
      2.02            +1.1        3.10        perf-profile.calltrace.cycles-pp.folio_activate.folio_mark_accessed.zap_present_ptes.zap_pte_range.zap_pmd_range
      2.22            +1.1        3.35        perf-profile.calltrace.cycles-pp.folio_mark_accessed.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range
      2.54            +1.2        3.72        perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      2.97            +1.3        4.25        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
      2.97            +1.3        4.26        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vma_munmap
      2.96            +1.3        4.25        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
      2.97            +1.3        4.26        perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vma_munmap.ksys_shmdt
      4.86            +1.3        6.20        perf-profile.calltrace.cycles-pp.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.shmdt
      4.86            +1.3        6.20        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.shmdt
      3.82            +1.5        5.34        perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vma_munmap.ksys_shmdt.do_syscall_64
      4.04            +1.6        5.59        perf-profile.calltrace.cycles-pp.do_vma_munmap.ksys_shmdt.do_syscall_64.entry_SYSCALL_64_after_hwframe.shmdt
      4.04            +1.6        5.59        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vma_munmap.ksys_shmdt.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.08            +1.6        5.63        perf-profile.calltrace.cycles-pp.ksys_shmdt.do_syscall_64.entry_SYSCALL_64_after_hwframe.shmdt
      0.00            +1.8        1.82        perf-profile.calltrace.cycles-pp.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault.__get_user_pages
      8.96            +2.9       11.84        perf-profile.calltrace.cycles-pp.shmdt
      8.95            +2.9       11.84        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.shmdt
      8.95            +2.9       11.84        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.shmdt
     15.46            +3.8       19.31        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.shmctl
     15.46            +3.8       19.30        perf-profile.calltrace.cycles-pp.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.shmctl
      0.00            +4.0        4.03        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.__get_user_pages.faultin_page_range
      0.00            +4.1        4.06        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.__get_user_pages.faultin_page_range.madvise_vma_behavior
      0.00            +4.1        4.07        perf-profile.calltrace.cycles-pp.handle_mm_fault.__get_user_pages.faultin_page_range.madvise_vma_behavior.do_madvise
     21.28            +4.2       25.44        perf-profile.calltrace.cycles-pp.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.00            +4.2        4.18        perf-profile.calltrace.cycles-pp.__get_user_pages.faultin_page_range.madvise_vma_behavior.do_madvise.__x64_sys_madvise
     22.07            +4.2       26.29        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     22.46            +4.2       26.70        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +4.3        4.26        perf-profile.calltrace.cycles-pp.faultin_page_range.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
     22.75            +4.3       27.02        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_shm_sysv_child
     23.28            +4.3       27.59        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_shm_sysv_child
     23.32            +4.3       27.63        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.stress_shm_sysv_child
     25.52            +4.5       30.01        perf-profile.calltrace.cycles-pp.stress_shm_sysv_child
     26.13            +4.5       30.66        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.stress_shm_sysv_child
     18.50            +5.0       23.47        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.shmem_undo_range
     18.50            +5.0       23.47        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.shmem_undo_range.shmem_evict_inode
     17.84            +5.0       22.82        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.folio_lruvec_lock_irq.check_move_unevictable_folios.shmem_unlock_mapping
     17.87            +5.0       22.85        perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.folio_lruvec_lock_irq.check_move_unevictable_folios.shmem_unlock_mapping.shmctl_do_lock
     17.88            +5.0       22.86        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irq.check_move_unevictable_folios.shmem_unlock_mapping.shmctl_do_lock.ksys_shmctl
     18.65            +5.0       23.65        perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.shmem_undo_range.shmem_evict_inode.evict
     18.08            +5.0       23.10        perf-profile.calltrace.cycles-pp.check_move_unevictable_folios.shmem_unlock_mapping.shmctl_do_lock.ksys_shmctl.do_syscall_64
     19.17            +5.1       24.23        perf-profile.calltrace.cycles-pp.folios_put_refs.shmem_undo_range.shmem_evict_inode.evict.__dentry_kill
     18.76            +5.2       23.92        perf-profile.calltrace.cycles-pp.shmem_unlock_mapping.shmctl_do_lock.ksys_shmctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
     18.78            +5.2       23.94        perf-profile.calltrace.cycles-pp.shmctl_do_lock.ksys_shmctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.shmctl
     20.29            +5.2       25.47        perf-profile.calltrace.cycles-pp.__dentry_kill.dput.__fput.task_work_run.syscall_exit_to_user_mode
     20.29            +5.2       25.47        perf-profile.calltrace.cycles-pp.dput.__fput.task_work_run.syscall_exit_to_user_mode.do_syscall_64
     20.28            +5.2       25.46        perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dput.__fput.task_work_run
     20.27            +5.2       25.45        perf-profile.calltrace.cycles-pp.shmem_undo_range.shmem_evict_inode.evict.__dentry_kill.dput
     20.28            +5.2       25.46        perf-profile.calltrace.cycles-pp.shmem_evict_inode.evict.__dentry_kill.dput.__fput
     20.31            +5.2       25.49        perf-profile.calltrace.cycles-pp.__fput.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     19.09            +5.2       24.28        perf-profile.calltrace.cycles-pp.ksys_shmctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.shmctl
     20.52            +5.4       25.95        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs
     18.42            +5.5       23.92        perf-profile.calltrace.cycles-pp.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault.__do_fault.do_fault
     17.33            +5.5       22.87        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru
     17.35            +5.5       22.89        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp
     17.35            +5.5       22.89        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio
     17.76            +5.6       23.38        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault
     17.81            +5.6       23.44        perf-profile.calltrace.cycles-pp.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault.__do_fault
     21.20            +6.0       27.16        perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fault.__do_fault.do_fault.__handle_mm_fault
     21.25            +6.0       27.22        perf-profile.calltrace.cycles-pp.shmem_fault.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault
     34.55            +9.0       43.59        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.shmctl
     34.55            +9.0       43.60        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.shmctl
     34.57            +9.0       43.62        perf-profile.calltrace.cycles-pp.shmctl
     21.82           -21.8        0.00        perf-profile.children.cycles-pp.faultin_vma_page_range
     21.15           -19.2        1.94        perf-profile.children.cycles-pp.lru_add_drain
     21.36           -19.2        2.16        perf-profile.children.cycles-pp.lru_add_drain_cpu
     21.84           -17.6        4.26        perf-profile.children.cycles-pp.__x64_sys_madvise
     21.84           -17.6        4.26        perf-profile.children.cycles-pp.do_madvise
     21.84           -17.6        4.26        perf-profile.children.cycles-pp.madvise_vma_behavior
     21.84           -17.6        4.26        perf-profile.children.cycles-pp.__madvise
     41.38           -12.4       28.96        perf-profile.children.cycles-pp.folio_batch_move_lru
     61.27            -6.9       54.34        perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     61.71            -6.9       54.82        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     72.45            -4.5       67.90        perf-profile.children.cycles-pp.do_syscall_64
     72.45            -4.5       67.91        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     79.47            -1.9       77.57        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.18 ±  7%      -0.1        0.10 ± 12%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.17 ±  7%      -0.1        0.09 ± 15%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.22 ±  5%      -0.1        0.15 ± 10%  perf-profile.children.cycles-pp.kthread
      0.26 ±  5%      -0.1        0.20 ±  8%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.26 ±  4%      -0.1        0.20 ±  6%  perf-profile.children.cycles-pp.ret_from_fork
      0.26 ±  6%      -0.0        0.22 ±  7%  perf-profile.children.cycles-pp.rcu_do_batch
      0.30 ±  5%      -0.0        0.27 ±  6%  perf-profile.children.cycles-pp.__do_softirq
      0.14            -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.__dquot_alloc_space
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.inode_add_bytes
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.14            +0.0        0.15        perf-profile.children.cycles-pp.handle_pte_fault
      0.14            +0.0        0.15        perf-profile.children.cycles-pp.lock_mm_and_find_vma
      0.10            +0.0        0.11        perf-profile.children.cycles-pp.pte_offset_map_nolock
      0.10            +0.0        0.11        perf-profile.children.cycles-pp.try_charge_memcg
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.folio_mark_dirty
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.page_counter_uncharge
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.find_idlest_cpu
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.xas_descend
      0.12            +0.0        0.13        perf-profile.children.cycles-pp.__mem_cgroup_uncharge_folios
      0.18            +0.0        0.19        perf-profile.children.cycles-pp.__slab_free
      0.08            +0.0        0.09        perf-profile.children.cycles-pp.__vm_area_free
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.fput
      0.09            +0.0        0.10        perf-profile.children.cycles-pp.up_read
      0.08            +0.0        0.09        perf-profile.children.cycles-pp.wake_up_new_task
      0.07 ±  6%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.intel_idle
      0.12 ±  3%      +0.0        0.13        perf-profile.children.cycles-pp.do_mmap
      0.12            +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.13 ±  2%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__free_one_page
      0.10            +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.mmap_region
      0.10 ±  4%      +0.0        0.11        perf-profile.children.cycles-pp.select_task_rq_fair
      0.21            +0.0        0.22        perf-profile.children.cycles-pp.___perf_sw_event
      0.12            +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.14 ±  2%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.filemap_map_pages
      0.08            +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.shmctl_down
      0.14            +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.tlb_flush_rmap_batch
      0.14            +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.tlb_flush_rmaps
      0.11 ±  3%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.__count_memcg_events
      0.24            +0.0        0.26        perf-profile.children.cycles-pp.__perf_sw_event
      0.19            +0.0        0.21        perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.14 ±  2%      +0.0        0.16 ±  2%  perf-profile.children.cycles-pp.mod_objcg_state
      0.16            +0.0        0.18        perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.30            +0.0        0.32        perf-profile.children.cycles-pp._raw_spin_lock
      0.21            +0.0        0.23 ±  2%  perf-profile.children.cycles-pp.vm_area_dup
      0.24 ±  2%      +0.0        0.26        perf-profile.children.cycles-pp.xas_store
      0.10            +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.wake_up_q
      0.12 ±  4%      +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.try_to_wake_up
      0.17 ±  3%      +0.0        0.20 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter
      0.17 ±  3%      +0.0        0.20 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.23            +0.0        0.26        perf-profile.children.cycles-pp.folio_add_file_rmap_ptes
      0.27            +0.0        0.30        perf-profile.children.cycles-pp.filemap_unaccount_folio
      0.18 ±  4%      +0.0        0.21 ±  4%  perf-profile.children.cycles-pp.cpuidle_idle_call
      0.17 ±  2%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.__shm_close
      0.28            +0.0        0.30        perf-profile.children.cycles-pp.kmem_cache_alloc
      0.09 ±  5%      +0.0        0.12        perf-profile.children.cycles-pp.workingset_age_nonresident
      0.16            +0.0        0.19 ±  2%  perf-profile.children.cycles-pp.rwsem_wake
      0.30            +0.0        0.33 ±  2%  perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      0.25            +0.0        0.28        perf-profile.children.cycles-pp.filemap_get_folios_tag
      0.33            +0.0        0.36        perf-profile.children.cycles-pp.set_pte_range
      0.26            +0.0        0.30 ±  4%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.30            +0.0        0.33 ±  2%  perf-profile.children.cycles-pp.fault_dirty_shared_page
      0.26            +0.0        0.30        perf-profile.children.cycles-pp.__mod_node_page_state
      0.27 ±  3%      +0.0        0.31 ±  3%  perf-profile.children.cycles-pp.common_startup_64
      0.27 ±  3%      +0.0        0.31 ±  3%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.27 ±  3%      +0.0        0.31 ±  3%  perf-profile.children.cycles-pp.do_idle
      0.56            +0.0        0.61        perf-profile.children.cycles-pp.native_irq_return_iret
      0.26 ±  2%      +0.0        0.30 ±  4%  perf-profile.children.cycles-pp.start_secondary
      0.23 ±  2%      +0.0        0.27 ±  3%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.35            +0.0        0.39        perf-profile.children.cycles-pp.__mod_lruvec_state
      0.57            +0.0        0.61        perf-profile.children.cycles-pp.sync_regs
      0.10 ±  4%      +0.0        0.14        perf-profile.children.cycles-pp.workingset_activation
      0.27            +0.0        0.32 ±  2%  perf-profile.children.cycles-pp.find_lock_entries
      0.32            +0.0        0.36        perf-profile.children.cycles-pp.ipcget
      0.25 ±  2%      +0.0        0.30        perf-profile.children.cycles-pp.remove_vma
      0.32            +0.0        0.36 ±  2%  perf-profile.children.cycles-pp.__x64_sys_shmget
      0.45            +0.0        0.50        perf-profile.children.cycles-pp.finish_fault
      0.33            +0.0        0.37 ±  2%  perf-profile.children.cycles-pp.shmget
      0.75            +0.0        0.80        perf-profile.children.cycles-pp.shmem_add_to_page_cache
      0.36 ±  4%      +0.0        0.41 ±  5%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.activate_task
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.follow_page_pte
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.48            +0.1        0.53        perf-profile.children.cycles-pp.__filemap_remove_folio
      0.13 ±  4%      +0.1        0.18 ±  4%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.34            +0.1        0.39        perf-profile.children.cycles-pp.__x64_sys_shmat
      0.34            +0.1        0.39        perf-profile.children.cycles-pp.do_shmat
      0.27            +0.1        0.32 ±  2%  perf-profile.children.cycles-pp.up_write
      0.40 ±  3%      +0.1        0.45 ±  4%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.51 ±  2%      +0.1        0.56 ±  4%  perf-profile.children.cycles-pp.rmqueue
      0.50            +0.1        0.56        perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.35            +0.1        0.41 ±  2%  perf-profile.children.cycles-pp.shmat
      0.47            +0.1        0.52        perf-profile.children.cycles-pp.unlink_anon_vmas
      0.38 ±  2%      +0.1        0.44 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.42            +0.1        0.47        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.82            +0.1        0.87 ±  2%  perf-profile.children.cycles-pp.shmem_alloc_folio
      0.61            +0.1        0.67        perf-profile.children.cycles-pp.filemap_remove_folio
      0.61            +0.1        0.68 ±  2%  perf-profile.children.cycles-pp.free_pgtables
      0.66 ±  2%      +0.1        0.73 ±  3%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.85            +0.1        0.92 ±  2%  perf-profile.children.cycles-pp.alloc_pages_mpol
      0.79            +0.1        0.86 ±  2%  perf-profile.children.cycles-pp.__alloc_pages
      0.76            +0.1        0.83        perf-profile.children.cycles-pp.truncate_inode_folio
      0.84            +0.1        0.93        perf-profile.children.cycles-pp.clear_page_erms
      0.39 ±  2%      +0.1        0.47        perf-profile.children.cycles-pp.__folio_batch_release
      0.24 ±  2%      +0.1        0.32 ±  7%  perf-profile.children.cycles-pp.tlb_flush_mmu
      0.88            +0.1        0.98        perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      0.64            +0.1        0.74        perf-profile.children.cycles-pp.anon_vma_clone
      0.30 ±  4%      +0.1        0.39 ±  6%  perf-profile.children.cycles-pp.osq_lock
      0.88            +0.1        1.02 ±  2%  perf-profile.children.cycles-pp.anon_vma_fork
      0.57 ±  3%      +0.1        0.72 ±  4%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      0.81 ±  2%      +0.2        0.97 ±  2%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      1.05            +0.2        1.24 ±  2%  perf-profile.children.cycles-pp.down_write
      1.65            +0.2        1.88 ±  2%  perf-profile.children.cycles-pp.dup_mmap
      1.79            +0.2        2.04 ±  2%  perf-profile.children.cycles-pp.dup_mm
      1.87            +0.3        2.13 ±  2%  perf-profile.children.cycles-pp.copy_process
      1.95            +0.3        2.22 ±  2%  perf-profile.children.cycles-pp.__do_sys_clone
      1.95            +0.3        2.22 ±  2%  perf-profile.children.cycles-pp.kernel_clone
      2.02            +0.3        2.29 ±  2%  perf-profile.children.cycles-pp._Fork
      1.91            +0.4        2.32        perf-profile.children.cycles-pp.do_read_fault
      2.19 ±  6%      +0.5        2.66        perf-profile.children.cycles-pp.tlb_finish_mmu
      2.42 ±  5%      +0.6        2.98        perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      2.42 ±  5%      +0.6        2.98        perf-profile.children.cycles-pp.free_pages_and_swap_cache
      3.77 ±  3%      +0.7        4.49        perf-profile.children.cycles-pp.__mmput
      3.77 ±  3%      +0.7        4.49        perf-profile.children.cycles-pp.exit_mm
      3.77 ±  3%      +0.7        4.49        perf-profile.children.cycles-pp.exit_mmap
      3.91 ±  3%      +0.7        4.62        perf-profile.children.cycles-pp.__x64_sys_exit_group
      3.90 ±  3%      +0.7        4.62        perf-profile.children.cycles-pp.do_group_exit
      3.90 ±  3%      +0.7        4.62        perf-profile.children.cycles-pp.do_exit
      2.03            +1.1        3.11        perf-profile.children.cycles-pp.folio_activate
      2.23            +1.1        3.37        perf-profile.children.cycles-pp.folio_mark_accessed
      2.75            +1.2        3.96        perf-profile.children.cycles-pp.zap_present_ptes
      3.22            +1.3        4.54        perf-profile.children.cycles-pp.zap_pte_range
      3.25            +1.3        4.58        perf-profile.children.cycles-pp.unmap_page_range
      3.23            +1.3        4.56        perf-profile.children.cycles-pp.zap_pmd_range
      3.28            +1.3        4.61        perf-profile.children.cycles-pp.unmap_vmas
      3.84            +1.5        5.35        perf-profile.children.cycles-pp.unmap_region
      4.09            +1.6        5.64        perf-profile.children.cycles-pp.do_vmi_align_munmap
      4.04            +1.6        5.59        perf-profile.children.cycles-pp.do_vma_munmap
      4.08            +1.6        5.63        perf-profile.children.cycles-pp.ksys_shmdt
      2.13            +2.0        4.18        perf-profile.children.cycles-pp.__get_user_pages
      8.96            +2.9       11.85        perf-profile.children.cycles-pp.shmdt
      0.00            +4.3        4.26        perf-profile.children.cycles-pp.faultin_page_range
     23.56            +4.3       27.90        perf-profile.children.cycles-pp.do_user_addr_fault
     23.59            +4.3       27.94        perf-profile.children.cycles-pp.exc_page_fault
     25.36            +4.5       29.84        perf-profile.children.cycles-pp.asm_exc_page_fault
     26.09            +4.5       30.62        perf-profile.children.cycles-pp.stress_shm_sysv_child
     17.90            +5.0       22.88        perf-profile.children.cycles-pp.folio_lruvec_lock_irq
     18.08            +5.0       23.07        perf-profile.children.cycles-pp._raw_spin_lock_irq
     18.09            +5.0       23.11        perf-profile.children.cycles-pp.check_move_unevictable_folios
     18.78            +5.2       23.94        perf-profile.children.cycles-pp.shmctl_do_lock
     18.76            +5.2       23.92        perf-profile.children.cycles-pp.shmem_unlock_mapping
     20.28            +5.2       25.46        perf-profile.children.cycles-pp.shmem_evict_inode
     20.28            +5.2       25.46        perf-profile.children.cycles-pp.evict
     20.27            +5.2       25.45        perf-profile.children.cycles-pp.shmem_undo_range
     20.30            +5.2       25.48        perf-profile.children.cycles-pp.dput
     20.32            +5.2       25.51        perf-profile.children.cycles-pp.task_work_run
     20.29            +5.2       25.47        perf-profile.children.cycles-pp.__dentry_kill
     20.36            +5.2       25.55        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
     20.31            +5.2       25.50        perf-profile.children.cycles-pp.__fput
     19.09            +5.2       24.28        perf-profile.children.cycles-pp.ksys_shmctl
     20.73            +5.4       26.18        perf-profile.children.cycles-pp.__page_cache_release
     21.51            +5.5       27.03        perf-profile.children.cycles-pp.folios_put_refs
     17.87            +5.6       23.50        perf-profile.children.cycles-pp.folio_add_lru
     20.09            +5.8       25.86        perf-profile.children.cycles-pp.shmem_alloc_and_add_folio
     23.21            +6.1       29.33        perf-profile.children.cycles-pp.shmem_fault
     23.24            +6.1       29.36        perf-profile.children.cycles-pp.shmem_get_folio_gfp
     23.25            +6.1       29.38        perf-profile.children.cycles-pp.__do_fault
     24.26            +6.2       30.49        perf-profile.children.cycles-pp.do_fault
     24.73            +6.3       31.00        perf-profile.children.cycles-pp.__handle_mm_fault
     25.04            +6.3       31.33        perf-profile.children.cycles-pp.handle_mm_fault
     34.58            +9.0       43.62        perf-profile.children.cycles-pp.shmctl
     79.47            -1.9       77.57        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.14 ±  3%      -0.0        0.13        perf-profile.self.cycles-pp.lru_add_fn
      0.10            +0.0        0.11        perf-profile.self.cycles-pp.mas_walk
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.__mem_cgroup_charge
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.filemap_remove_folio
      0.07            +0.0        0.08        perf-profile.self.cycles-pp.folio_unlock
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.do_fault
      0.08            +0.0        0.09        perf-profile.self.cycles-pp.down_read_trylock
      0.12            +0.0        0.13        perf-profile.self.cycles-pp.xas_store
      0.16            +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.___perf_sw_event
      0.09            +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.07 ±  6%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.intel_idle
      0.15            +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.shmem_alloc_and_add_folio
      0.08            +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.dup_mmap
      0.15 ±  2%      +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.check_move_unevictable_folios
      0.09            +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__count_memcg_events
      0.13 ±  3%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.13 ±  2%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.11 ±  3%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.folio_mark_accessed
      0.28            +0.0        0.30        perf-profile.self.cycles-pp._raw_spin_lock
      0.19            +0.0        0.21 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.22            +0.0        0.24        perf-profile.self.cycles-pp.down_write
      0.17 ±  2%      +0.0        0.19        perf-profile.self.cycles-pp.zap_present_ptes
      0.11            +0.0        0.13        perf-profile.self.cycles-pp.up_write
      0.26            +0.0        0.28 ±  2%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.14            +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.anon_vma_clone
      0.25 ±  2%      +0.0        0.27 ±  2%  perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
      0.22 ±  2%      +0.0        0.24 ±  2%  perf-profile.self.cycles-pp.filemap_get_folios_tag
      0.25            +0.0        0.28        perf-profile.self.cycles-pp.__mod_node_page_state
      0.09 ±  5%      +0.0        0.12        perf-profile.self.cycles-pp.workingset_age_nonresident
      0.30            +0.0        0.33        perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      0.23 ±  2%      +0.0        0.27 ±  2%  perf-profile.self.cycles-pp.find_lock_entries
      0.56            +0.0        0.61        perf-profile.self.cycles-pp.native_irq_return_iret
      0.22 ±  2%      +0.0        0.26 ±  3%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.42            +0.0        0.46        perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.57            +0.0        0.61        perf-profile.self.cycles-pp.sync_regs
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.free_pcppages_bulk
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.84            +0.1        0.92        perf-profile.self.cycles-pp.clear_page_erms
      0.30 ±  4%      +0.1        0.39 ±  6%  perf-profile.self.cycles-pp.osq_lock
      1.54            +0.1        1.66        perf-profile.self.cycles-pp.stress_shm_sysv_child
      2.20            +0.3        2.47        perf-profile.self.cycles-pp.shmem_get_folio_gfp




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


