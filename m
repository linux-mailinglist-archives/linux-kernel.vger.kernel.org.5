Return-Path: <linux-kernel+bounces-154978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6688AE3D2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A35284DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806AF8004E;
	Tue, 23 Apr 2024 11:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CGqhr8wT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6312685636;
	Tue, 23 Apr 2024 11:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871534; cv=fail; b=jSwNDYtvt3dxFd3PYeMlD9iz8kU1E3HlRB/vNrohFWgUYzvKz0oZ0Ev/2hHDN2sf2BqpFNK/WZ/ip/XUr+sgQgKRBR/+narEdoa5X3syYdZ3s3x7w21pjGo9Z3H6+NoryZy0P9bIBU0aJPlaBPSz3RuIc2NZ+XIoKwoF2R8l8kE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871534; c=relaxed/simple;
	bh=YszNSoo5jW2IJ1MlK+eRwqQAizilGdkCneIqNjGWimk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KidH6yEHsQCx865lCU2kH9NHtVyQTYiBD99h3KOZZfpqSNa0cGQAhNYHy2SgPGKJmYyAkp2RdqvcBeplnPpne5WbGYrs7YdM94+bhNwUL0MQ8PM76CccMdQmOlzynppccQniYvHjnllJnarkbw0b33CaovVqHyp0h1E+O+uaDmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CGqhr8wT; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713871533; x=1745407533;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YszNSoo5jW2IJ1MlK+eRwqQAizilGdkCneIqNjGWimk=;
  b=CGqhr8wT4qbvWUYdwmtw8CnuG971VugE/54OjwFcChhS4NZPUmAvBM/9
   bzrNy8Q0rw1qK4bHD7ZKeK7Yyx9zNBUJNkriec3iFF5HuxBCfUxRrzKUr
   7OKgQx85EJ/22Ye/pM1TM3xav3N8KZmgCrZ69vWsh3msTZdHAknxV8aye
   5J4sordxJvtsHur2JLrZL+MEKFOgFyO42ERS93OKCpT0haxycdWvL8H55
   k90SLDHPAcDfLhdYrqeFpXS5qhgV4Z8cKdv8bNft6udIPYvMBF5YpqBXz
   yfyL7xk4NqZSX7IwfUBGGlxNOygoSubR7+0VKt3QtCfSlFpv+eY7m0Qrn
   Q==;
X-CSE-ConnectionGUID: FYVi4dXkSJm9yWirRQ/Kbw==
X-CSE-MsgGUID: sORLvleuSxCNVtT9asT1Bg==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="34847620"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="34847620"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 04:25:29 -0700
X-CSE-ConnectionGUID: sa0rC04tSa2KoMaNy7PYrQ==
X-CSE-MsgGUID: L/5v082yQSG9xWVTMNXAMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24946903"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 04:25:28 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 04:25:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 04:25:27 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 04:25:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWBc3PhONv3ew5u9SpVBEaNMLt2R8gskzZAJcD54F75Iho9w54K7EEKSzbmsjPa29MpiFV25fofjpWlnwjweNdYg0zaTw2NIBAyOQrXKOMPOSV81JCOovuvaag8T2d53xWr0oNJK0Zag7eToXvUIlqiFVXuHjvx8mrBHLvnO2CfjTFCCVZ48YCSjE2Z/vZrnFsY6rPidk+jT0iMnsUNLCak/1Brq7ycVng+G51OEZJ5ef9P+xc5DStT5CxaU4NAHQfQtIPIEO8Qnc9rNxjrHtyBQ5QBxFpfCmTVWEi/JyYgQyhW+zf/+6bkRtCxT+D4Ce/uc0Nl+T8bF8ddotckaug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqjwspKpRqGA33K7tSNDoe+mppXFLEXejXhCt5uhzvY=;
 b=QQscZiRgSVZcosABDUb870lT8U7/DWFm5qi9qHEjSh0QI10SLa4FUdvL3ubHBG0rj0pWJQjYpIN/JmBhXmjUeJQcjlkrSzdf3l3Dty3XjZsKsHVJHEJw9Z0z2zd0X96n3kNbtY8BUsxe1q9yd4NO+SML3b2+4HJeZbqdRR4/J+Zwz8RQMnQAeJbymNpO0z/8P74+ZuTvblz5fnmrcQee+iUi7Are46dekRMhkGU2ncMYz0dWO0kZJ4jlcWWg0LQqGRwO9jtutQobDz93DcJED/Qrg/JyKtGQ4Dchn+fTtnX/hL0kfGo4vYH0PcFC34XMSH7APu89UhVnHT0wjkx4Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8)
 by SA2PR11MB4922.namprd11.prod.outlook.com (2603:10b6:806:111::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Tue, 23 Apr
 2024 11:25:23 +0000
Received: from CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3]) by CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3%5]) with mapi id 15.20.7519.020; Tue, 23 Apr 2024
 11:25:21 +0000
Message-ID: <f4c18446-e0f9-4f32-8460-2e885a673ce6@intel.com>
Date: Tue, 23 Apr 2024 13:25:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH 0/5] Ensure the copied buf is NULL
 terminated
Content-Language: en-US
To: Marcin Szycik <marcin.szycik@linux.intel.com>, Bui Quang Minh
	<minhquangbui99@gmail.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Paul M Stillwell Jr
	<paul.m.stillwell.jr@intel.com>, Rasesh Mody <rmody@marvell.com>, "Sudarsana
 Kalluru" <skalluru@marvell.com>, <GR-Linux-NIC-Dev@marvell.com>, "Krishna
 Gudipati" <kgudipat@brocade.com>, Anil Gurumurthy
	<anil.gurumurthy@qlogic.com>, Sudarsana Kalluru
	<sudarsana.kalluru@qlogic.com>, "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Fabian Frederick <fabf@skynet.be>, "Saurav
 Kashyap" <skashyap@marvell.com>, Javed Hasan <jhasan@marvell.com>,
	<GR-QLogic-Storage-Upstream@marvell.com>, Nilesh Javali
	<nilesh.javali@cavium.com>, Arun Easi <arun.easi@cavium.com>, "Manish
 Rangankar" <manish.rangankar@cavium.com>, Vineeth Vijayan
	<vneethv@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>
CC: Jens Axboe <axboe@kernel.dk>, <linux-s390@vger.kernel.org>,
	<linux-scsi@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>, "Saurav
 Kashyap" <saurav.kashyap@cavium.com>
References: <20240422-fix-oob-read-v1-0-e02854c30174@gmail.com>
 <eb54c7bb-db63-4361-b42f-dc02e2c37fbf@linux.intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <eb54c7bb-db63-4361-b42f-dc02e2c37fbf@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0016.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::21) To CH0PR11MB8086.namprd11.prod.outlook.com
 (2603:10b6:610:190::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8086:EE_|SA2PR11MB4922:EE_
X-MS-Office365-Filtering-Correlation-Id: 377a3a23-b695-443e-c583-08dc63880ffc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007|921011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWk4aDkySUNhcXZhd281SWd3TTlCajY2Z0NDZ2NRanVRVElQZXBhdHloV3Yz?=
 =?utf-8?B?SzFwalk0Y09vM2syb2dHdmNBL3BVaGJMOWhKc0JyVTg0YUdXT2JDT2gxMHBM?=
 =?utf-8?B?OVgvalN4OWFsZnJwRDVtV0VsbFlxWlBObHpQWnhjMTFNV002eVI1OEs2Uitk?=
 =?utf-8?B?Y1NWV0ZWVU1LODkvYXJNY3crYWxZYU1OMU5aTDN6cGdjR2p2cGpTK0VhUXZk?=
 =?utf-8?B?SFB6Q0lnbzBjOHZqdFdwcklYOHZncXlRT3RpQ1kxTmJhK2N5YzZCSmllT3RJ?=
 =?utf-8?B?WkdFWXZpQUxqZWtFWmJjdUp5ZWtSUmJZWVFhSkJ3RTVXMEEwR2JvdEF2ZHM2?=
 =?utf-8?B?eWRWUHJZU0FXemFOZ0tuK2VyUlg5aU5DckwrRnNCSDlPTTNzVnI1MnZYTlNP?=
 =?utf-8?B?SURIY2gyWXBrNmFLWUwrNXhrQnRmTW1rOEdKNUZ4NExJcXRJS21vREtTVnk1?=
 =?utf-8?B?V3pxL1FtaUJIcmJuR1Nib0F6ZmVraEFOUnJPdFg2VHEyOTNRQk96bkhRZit5?=
 =?utf-8?B?SDMxNDZLbi94bTRjak90bFJBOG1velAzakxyYjlURmRxQm9xMDM1SHpuUWJH?=
 =?utf-8?B?YlRTWFM2eDJMZjBHeHVzMUZHY05sMmw4UkQ1RGs3R0pKdURidm5ab3BVVWlR?=
 =?utf-8?B?WFBIVDE4anhzSWs0UnoreHUzZEttWndSQndmYmw0ZkJJSDBxUUwyOTdxQytk?=
 =?utf-8?B?SlIyVHVjcWY0dlBkUHR1N1VYQkVMR2tjR1JHVnpEYyt1WGZjWmQxazJqSXZ3?=
 =?utf-8?B?eFF2RHJrbVQ1S2NxQkRVUlE5TnU0RmF3UWd5WVpCZ1o3ZTJmNzdGd2pPdVZU?=
 =?utf-8?B?dGkrOTg1SjAvZTRxcXBBQmdnS0pwa3djcTdCQVRSWXptZjY1bVNPQnprNEdp?=
 =?utf-8?B?Y3ptWUF5eXlEMW5kTTNZNnJFUERkTnM5NTljNXJGUDFjQkhOY3VuRGhJVGpy?=
 =?utf-8?B?ekdMdzkvQUJoNGpvZUFLSGUrcmNtRit5TGxqT3lVM2hKTzkvQnBFME9zekxT?=
 =?utf-8?B?eEw4VHp0d0xySG9tSFB1ZEJQUTRpZnpGQllPWHdVTldRYzRVR28rWEN1OHdp?=
 =?utf-8?B?RWJpNEtvWGl2V2tWOUdhcWN5VEMyeUFEeVpZQnRxTTlDbnFxM01nYjB3MXI1?=
 =?utf-8?B?Mnp3V2VlYmpKVktzV3QrTWpVMGUvK3VIN0JRL0N2VnFVUzQvNHVLYXlxbnJ3?=
 =?utf-8?B?anZ1WjlYT0I0a2hXRHk1Rm9YeFM3amlvMlJMQW10OC9YQ3ZtVmRwLzk5R2xv?=
 =?utf-8?B?WDM2cllYcTh2NVF2MC9LZ1VKSlNBQmNNSXZhTlFmN2pDdkljSFNkUDdZME5D?=
 =?utf-8?B?OWo5aFB2eUNpKzJFYjZWQzM1bC9iQzAvdDJCK0VaQUI4MDhldzRuNjdIWFNs?=
 =?utf-8?B?NE5Yc2htdXY5QW95YktHRGNoNEkvMzNkVVEwdzFiWFY4QVhtN1dRRkNFWEV1?=
 =?utf-8?B?cnYwMWh1dmFncHlPMEg5WkxRbUowN2FYaGx1TU1GTnc5R3JCMTdHY2NQbWVw?=
 =?utf-8?B?ZE56RmpLdnJEQWluL3RVUFRleFJaUTVjbUpSNm93SlFXZ1pwUkVkVm8wMEhJ?=
 =?utf-8?B?OHNXMStMdUR2L0E1RzU4a1l0d1lXYUtiS1BWNC9LWm1MOVg5NVluS1J6cnkz?=
 =?utf-8?B?SmhvVUVNU0RteU9PMnVrallJZ3dtQnlmSmFjZlhaZGUzMUJuSnhWTGRGeFRK?=
 =?utf-8?B?bmEwY2I2Z1pMelZ2QitCQytkV0dYb29sNS9VMVNLdlY3czI5THcySkE3RTk2?=
 =?utf-8?Q?h5D27g8Tt7IaEyNYbs76mG4NJxCEBeErvwPgWWm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8086.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1l0WUMyM2diU0J4RURzVC9rVDNXN0ZETVFNNnZTL3FVK3hBTmQ3QW9SK2kx?=
 =?utf-8?B?eUl3VHVqZ3pmMVVBUElUTEV6VVBaY2EvemJTUlNTb3dDMFVGaVI3bFBYRjN2?=
 =?utf-8?B?ZTN3azV6VEV3U01UbGhBSW1teUhZUnpnam13M3QvT1ZuRUtNcEV4RlVEc2VU?=
 =?utf-8?B?NEpNekx0ZERJbnl5aGIwYUlaQkRQM2RwSkdXb3FlNnJWR1A3ak9HQWlPSHV3?=
 =?utf-8?B?YjA1aTJaLzljR2JXVGtZRHZ5eEQ1NVRhVFROMVQ0ZXA5NDdHVmVDOUhza2JV?=
 =?utf-8?B?V2RMYmIzaHVoelU4ZXNHTEdvL0N5M2hZaExQek9qcU1nVTBHRHo3TkdQdmdU?=
 =?utf-8?B?QjQ5S2o4ZEZRRzQ1aCtvUE9xc3Bza2pqTHFVVW9scStzblFMWUl6QVJqaS85?=
 =?utf-8?B?eUdjMmorZW1WTDNKOGZHMXpzQkcyOXlyek5jV3gycE5OeVJZa0ZnMVpyYlNO?=
 =?utf-8?B?NUJUeERFdWtJRmtwWU5VT1BhQXJHKzZneDZiVW9MdVRHK3FObUtaQnl5WGw2?=
 =?utf-8?B?QUJrblNBNU5VYkliYnZEcTZOQm80aFVjYnlsc1YyVkpaU0lkMy9lMTdieGVH?=
 =?utf-8?B?SGhKclpRYkJCdjd6dU4zSDlGMzVQWWdtS1dwOXAzSmh3RlhvS2lrbFZrdWNn?=
 =?utf-8?B?Z012SDBZZjVVOU5EbkEydmc5TVdxMHd0T0IzQ0tPdzEvUXFRYThUUUJxaTFu?=
 =?utf-8?B?eFBrMkNmLytMVGRxZHdWTmlUUmRMeU9Bc3ZRNUVCM2JvbXc1UWpKeUMxdVFw?=
 =?utf-8?B?OUpPeTdqL0VkbTg0NVNHL0pHcUxwZGQ2Z0Q2VDJCb2NlWU42MUJVUTRnelhI?=
 =?utf-8?B?aEk3RldUMGx3R0pRMUlTOEMvbm05Z25CRWc3ZjFNR256ODAvVTg5WExjMndz?=
 =?utf-8?B?RmFrUmJuaVJ2MTFmc3BXT0tlSzd2ZElVT09mWmFrcTFvK3dSd0ZiZG5ON2l3?=
 =?utf-8?B?czIrQURGOEhFZGREcko5ZFg1M0ovQUdrQy9mQkhCbDBKc2w2TkprS0RDSyt3?=
 =?utf-8?B?NHA2WkozNGJsdFdpUlVZSzA2a3dWMjFrcnRjS3FFeG5jSnlqaDVqTHc5N242?=
 =?utf-8?B?dGRPdS9UYVJ2RW1MMFJtNVhGUkIwZE5PQXUxRDZZNSs5dGlPUFBpOEdDTWMr?=
 =?utf-8?B?d1pXMW5wbFpuUy81NW82VXp6dmVuekFvTFdjOWVqQktrcWE0YVBCOXlrTzIz?=
 =?utf-8?B?RHdOMjJUZWtwYlFLVFZtemw5M3ZCTXhnRlgxdjRvTDFXOVRqNEhISUFoWkFL?=
 =?utf-8?B?cU9IRU11aHVnams1M2JJVWVJYUZmTDRrV2s0ZlJueEtEbWQrNzAvYU1TT3Vo?=
 =?utf-8?B?c29RODI4VC9SeFFURE44NVdTZjdERWkvcDBPdGxxSm4xbDdmQTQwdlZhU1hw?=
 =?utf-8?B?RFVMdEt4OW5ocTI1eVY5V0Q1UUJlOWNwZEZxWS9VZ2xPcUNjSDhSRHEzNzRL?=
 =?utf-8?B?dFJsbUpydzUvSTg1T0NNZUh0di9iYVJFWjRWdFYwK3liVjZLK2dVY2IyeUVD?=
 =?utf-8?B?b01FRzNjaUJvNnBhY3FVRC9jb0RCb21JdmMwc3EwNjlMeEZVQnZEc1drSXM3?=
 =?utf-8?B?MW8rVEVEaEU1Qm9VRUFFUGZPdGF6b1pFSkJOZXdYWVM5WWVQUDVvQ0k5RWdI?=
 =?utf-8?B?VWFVZGRPWWtLaExJQXBteW54SWV6WW13dk8vN0hOU2RBUUlLMHlqTlJucTFL?=
 =?utf-8?B?dVMzR2NWUWRQb2xmbUhkd2dHTGFBNVNjaVM4Tk81RjNRcnVoelVMZVZxeXA5?=
 =?utf-8?B?N2x5dGxyenkvbk9PMXF0THR3S1RMMVMxOGNRMUJzejJlSytuYTNsS2dKT2tk?=
 =?utf-8?B?RmQzZ0w4YlZhSnFsaHgzSUZLQUNsTTBqeitlRFFNYlh2K3RNSjk5dW1sdVFL?=
 =?utf-8?B?Y0EySVFkSDJzMXBsU0JXZ3doWExDbW9hbU5lZkxHbWJKd0ZybnYybk1zeGVj?=
 =?utf-8?B?VXhSb2FNbE5GZmYvQlBPWUUvVTRIUXBScldlTkJrSEtjRHQ2MlNJMEtlV2Vq?=
 =?utf-8?B?VHhieDB2aDJkWlc3dm5nVzJhVDBSelcwaDF0RFI2Y0xSUUN2dVRkak9DbFFw?=
 =?utf-8?B?ZzlzZzVjUGRLWVFFUzlCMTFYVlNUR3J1RS9HaERmRThpb3lhODdhSENCYk1V?=
 =?utf-8?B?UjBJUDRPbHNvbVdLSUZxcnF0TTZnR3JJQkNtUVU5a24zVlB6bjhjNGlPMDY4?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 377a3a23-b695-443e-c583-08dc63880ffc
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8086.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 11:25:21.6358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6ihMREXiL86w0nSn2YjyVjH2ZwgEdagAgkjcYWNr0SKPR7S2ebHjd3/EVGCGBvt+xg4kyUYvTuk6ARnN0U3T3m1xneBgA4e0otgc9+vrH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4922
X-OriginatorOrg: intel.com

On 4/23/24 13:10, Marcin Szycik wrote:
> 
> 
> On 22.04.2024 18:41, Bui Quang Minh wrote:
>> Hi everyone,
>>
>> I found that some drivers contains an out-of-bound read pattern like this
>>
>> 	kern_buf = memdup_user(user_buf, count);
>> 	...
>> 	sscanf(kern_buf, ...);
>>
>> The sscanf can be replaced by some other string-related functions. This
>> pattern can lead to out-of-bound read of kern_buf in string-related
>> functions.
>>
>> This series fix the above issue by replacing memdup_user with
>> memdup_user_nul or allocating count + 1 buffer then writing the NULL
>> terminator to end of buffer after userspace copying.
>>
>> Thanks,
>> Quang Minh.
>>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>> Bui Quang Minh (5):
>>        drivers/net/ethernet/intel-ice: ensure the copied buf is NULL terminated
>>        drivers/net/brocade-bnad: ensure the copied buf is NULL terminated
>>        drivers/scsi/bfa/bfad: ensure the copied buf is NULL terminated
>>        drivers/scsi/qedf: ensure the copied buf is NULL terminated
>>        drivers/s390/cio: ensure the copied buf is NULL terminated
> 
> Typically you don't include path to module in title, instead:
> ice: ensure the copied buf is NULL terminated
> bna: ensure the copied buf is NULL terminated
> etc.

good point,
if you would respin, then the character name is NUL, not NULL.

> 
>>
>>   drivers/net/ethernet/brocade/bna/bnad_debugfs.c | 4 ++--
>>   drivers/net/ethernet/intel/ice/ice_debugfs.c    | 8 ++++----
>>   drivers/s390/cio/cio_inject.c                   | 3 ++-
>>   drivers/scsi/bfa/bfad_debugfs.c                 | 4 ++--
>>   drivers/scsi/qedf/qedf_debugfs.c                | 2 +-
>>   5 files changed, 11 insertions(+), 10 deletions(-)
>> ---
>> base-commit: ed30a4a51bb196781c8058073ea720133a65596f
>> change-id: 20240422-fix-oob-read-19ae7f8f3711
>>
>> Best regards,
> 
> Thanks,
> Marcin


