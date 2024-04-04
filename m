Return-Path: <linux-kernel+bounces-132251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 086F7899209
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF531286BB7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5721013C3F2;
	Thu,  4 Apr 2024 23:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c6Yj5hsa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE7070CC2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 23:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712272744; cv=fail; b=osi1tORYQ9GoQpwZAyLEQ8Pbu+72lT5iXBQdjyCRMGGlP7I6xGsvHjgTnZvkmpeu9hwKR+PUWQCCEGWLT/ZOL4Tjy5Em990N358eEuOV5cBN6D6ZPlV6hcLeHv/+t7p9Js0aRPE6HRnsDn6IWdjx4ofCS/jFfColv67zksz0d14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712272744; c=relaxed/simple;
	bh=ofLuxqXMnUoDTRvYa2QvwSXZFeGIvzrpeBpxF+v++FA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S12DmX2gQGpHDtCxn8JTMey/PsWHvMVB58/x4D5aHQ2woN9cC5IM9D9bDluwTA1VHlGFeRIciNLvWQZtRzQ+tHm8CJ+3r6UluiXhD9MKOsoJiCBOAaBhMT2EE2TAqw+dkwloZt8sIgjhMZhnwP5ziGO4stpwH/HHCl8Qm7YNFe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c6Yj5hsa; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712272743; x=1743808743;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ofLuxqXMnUoDTRvYa2QvwSXZFeGIvzrpeBpxF+v++FA=;
  b=c6Yj5hsaTcy1LQbO9PlBaEpJSDvolTpdiYcvzBIPmjsyGfEsB0dtIWsK
   jMcm5YjTrcdbKmjmPcf/OBr9w2Gnnn0SdSGGtNYJNpNcIxwzy8TANfkmm
   LUX81VofkZ49szpQ0sf6xZpgn4eF0voyaubqkyB9SU+FncxjC6g707n9+
   CjRGMJNuFll/A9oHyPs7GNPqlyyCs6WLwD/o7PwrZywtExJeU9Yi/MBd2
   yHWt0ohSe24gXoZJAGe3AXj4iVFW+FMKKalKocFD4SkiYeGzU4KiEQ5Xa
   PY/ENNTj6I3A1YLcLfdHUDZhcJ6RTZWnt/Dy1uW9qg80enzHmbnAa1LwL
   w==;
X-CSE-ConnectionGUID: JtKUnWhVRB6C25V74KfqxA==
X-CSE-MsgGUID: 7WLmDEyyTKGJGPtXWeU8CQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="30061134"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="30061134"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 16:19:02 -0700
X-CSE-ConnectionGUID: 8wpuPUOTR7SqrgcF48ZpzQ==
X-CSE-MsgGUID: fkBxv0ZcSUCvdqKmyBdFqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="23651562"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2024 16:19:01 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 16:19:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 16:19:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 16:19:00 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 16:18:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xlbpw8yBofn+S0RkMTRgCFOfWpP4b4WLX9HMSLhAPygz+Iqod0wQtsyfyvdm55UX1eWZxGFRAUc/heqohWQ1ldQnaCe6bfV7f+Kib2u72tTHkHt1pRbNt4HCNf67XPib6pDTRK06kp9HYFGomhz+pEGGzKMJQtsc+zow5XFMFG3qCFmnVw3CFMyRwJyFkmVwDeLC3AV76CiETtbBuch4gB6kl9l77k2ICVYzSo4iWdXgGJ6mxFyKgnC+Auz+n8mmp/rkeS7tt0K4BqkJMM3FoCCQqTx+cZm+dJOvdMrPWROiFpWeb7ZIKDhI8hun9n3950Z2rnJ5r1iX2TLLMLAeQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMsJBj7leKnRYiWbG5WuLIzggzJCCvqNpsdEeMDRwQo=;
 b=k+5gxVateqUNxuKqAf89GB7Ff3dD9IAZYPwyhIFwS5Ic+eN2oYlJTEwqzzrXMdLqU7hPNBV6a8raUFfKBAM4OOCw1ZbHurJGAFcMUt1JAUWPb/QRlKJSmKwSn9GsQi7n3Hl3eu+GJaJpAS2+x89uIdzn69Be3sTpo491WeW9C0rRkPvDvO0GGQQyF7dt93rb44f0mIjp1ikYc0t1j7r5xCItThjhClHKng+KiFIciwYZknpzPqk1m8twmm+97PEzKJlUhFX22kzB/E/s6rbGewShYZpxgVaCVZIK7LYOn7Rs2O++Hjwc3h5Mk7mWMvTS5V51G9QU0cLhOwd69cxMIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB6570.namprd11.prod.outlook.com (2603:10b6:303:1e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Thu, 4 Apr
 2024 23:18:57 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Thu, 4 Apr 2024
 23:18:57 +0000
Message-ID: <52d0116f-8fa1-4ae0-8012-8f6cf2765cc6@intel.com>
Date: Thu, 4 Apr 2024 16:18:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/6] x86/resctrl: Don't search tasklist in mongroup
 rename
To: Peter Newman <peternewman@google.com>, Fenghua Yu <fenghua.yu@intel.com>,
	James Morse <james.morse@arm.com>
CC: Stephane Eranian <eranian@google.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel Gorman"
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin
 Schneider <vschneid@redhat.com>, Uros Bizjak <ubizjak@gmail.com>, Mike
 Rapoport <rppt@kernel.org>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Xin Li <xin3.li@intel.com>, Babu Moger
	<babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>, "Maciej
 Wieczor-Retman" <maciej.wieczor-retman@intel.com>, Jens Axboe
	<axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, Oleg Nesterov
	<oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Tycho Andersen
	<tandersen@netflix.com>, Nicholas Piggin <npiggin@gmail.com>, Beau Belgrave
	<beaub@linux.microsoft.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240325172707.73966-1-peternewman@google.com>
 <20240325172707.73966-7-peternewman@google.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240325172707.73966-7-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0193.namprd04.prod.outlook.com
 (2603:10b6:303:86::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB6570:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EcpElFMQaCOQkO7ErjBVlWX0MZfVqYbT+r+HTE1x7D4hkMPXIrwiE1O/BORQZbX8bEBSllQtRSNEhN+avyodaA7D6AMhBRawnezsgAomNvMKSKUd4NyO0W3OzDi1b4+4ztCbnfTuem7vqwusz13PyR1xZ1A7fmpPOn46V0NiG2stp71NxMaRpYpwOb3vYiuovfb2WzIT8/ngAnUeupWB7uD7e9cbQEB5BSQ6p4QSr1bX39/6BlDnQ36IsNypQOqwTFvqf9wMUSyF85t49dfv0+1gh8MI8qfY2fmlI5VVC8xRq1W/vflenZZfJBtas5OGrYspFJbQCDxjIQml1CpEm1O2ihmwxOSUTQ6wJ8Y4CdfOPId864SHXJRMR4X0ciM0MaOcnlSxuTjeA0r2DwvqLsv2drsDw56YvkcCu9y1deW0/ssC3cf2GN4A5uRJZWAYQcEvBNrLPPcXhpHhNcSsgv04d3KuqKm7LY8DAl29LDNorK55E/aREQKT5vi1fNxqNJxHppresc7LnhDJFJPzmYXYtu/6zwsZA9bYW3Gs0dGZ7KRTKD4oiGxyQt4EpU2yLCjV72m7NkoDIMsLxSdfOCVK90Nr86daKia8ssfTVOlWffrSlQjnP2DaWbM2vjHcNEDod85zDqO35wn9W82HDnW7UtM/XXIm7oTHwl9ZqzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnVyQVg3YjdKSktmeWo2OUpkSnNIdVFIdVZCRklNdTVGdWFud3IxS0JMa1FO?=
 =?utf-8?B?S1hjMTFzdWRjN2w1UE1PL0tRNFUxcllGZmQwbjBhbFgrMlRSRFFKMjUrMit4?=
 =?utf-8?B?YThiUTBjU0pUZDU2eW5mRHZzUExZRUlGNVlIeURmMFlrVitQbVZFRU1SdHBJ?=
 =?utf-8?B?aFlLanVIamVJeFlXN1Qwd1VrM3VMZ2x4djNzL1NZSExNQXlDcm1IVnZOVWc3?=
 =?utf-8?B?d1RCT1F1L1RDNjE2cGVXM0doSFcvVEttKyttL05acjRCd2xYUDhmZUFHQkR3?=
 =?utf-8?B?aUZteEc1cmZCemhNb0wvV2QwbXg3TTlIWW05c0U5aWJOSkRSS1Z0WWZaMWt4?=
 =?utf-8?B?V2VyL0d2THZFWG93Mkd6RFM3a1dkVW5XUnJvMytrM2J5MkxiQy9KcTRWNWpK?=
 =?utf-8?B?VHFUNHE2KzFSQjYxTmdHK1A2c3VFWUs1aUFONEpmTkZic1dRempObkV5OHFT?=
 =?utf-8?B?bTdzRldpTUpKcEFwNG9kY3pqTnVyOG0vREZXSDVaRDJmU3U5VUFEaWhQQnpr?=
 =?utf-8?B?eEZmMjhVbW1wT2hIL1pTSFQzTzVEWXp4anh5NjEydUJGR1pOcTZvTVIvV2Nr?=
 =?utf-8?B?c3QwZTY3MTYzSzErQXNya0JjKytYYVVMOG85Y0xhTE42SC9RL09Pc01maE1o?=
 =?utf-8?B?MTBpZHpTYlA1eE1jaS9RRlhCY0w4eWtoWVY3cWNHUzYzL05Xa0VmZDFhSjVz?=
 =?utf-8?B?SjFrVFVMRDJ0RnlkczFCWUUvVFZmS0xkM1RnSU81b1Nyc0t1c0syQlo4N2p6?=
 =?utf-8?B?SC9PUTBrY1U2Yy96aVp2YkNSa0UwQWx4LzFCQUUzR1NnMjlNdFVhc1kxZ0x5?=
 =?utf-8?B?TFh5MHBaekoxNWFJcWV5TVI5NWFEcjRWNnVLeUFkUzlFQ2grWTh4MkxKZW9w?=
 =?utf-8?B?WFR5ZWk1REQreFBHV3JULzlueS9IOEp6RW53WFZzMExQR0VCUUphMm9NVUFE?=
 =?utf-8?B?ZFY1UGpRYlBEYXVuUHh3VGJ4WWtxcHVNRHUwTGIyU25wY0kvSG1jY1c3anhV?=
 =?utf-8?B?VFdHY3NmdVpmQ3g2MFlxVWxVT2ZGT01XUHJpMUM0SHViSWxSRFlndmtVNFRN?=
 =?utf-8?B?OXZaT3JiZ3EvZEZxRDJVbHptWGlxaHc3LzRkSnB0MVV3aXZOTWtNdWhJU0JV?=
 =?utf-8?B?MVRmd3V1bXpaaWkwVGs4eUlZNjJ5ZFJSeVRCM0FrSm1BQTdlVnZJYU4yUTBM?=
 =?utf-8?B?K25yaXBlT25FRHlKOForOHN4WDM2U3UxOVVmRGJCWkZGTjJGamErY1RiQzg5?=
 =?utf-8?B?SGRHN2YzZnR1S0NPUnR5WmNucVRaelpCNWMzOWxPMkdWcHFUTlN1N3JibmVp?=
 =?utf-8?B?Qkd0WDJKN2N5UVNOSTFZaEN2Znd4ZjJMUzRNTEF3bWdsb2YxcHB3dEQ1WVIx?=
 =?utf-8?B?WjcxSkJGakJvOGdkSlgxb1RpcVZLbXRKZVJQS3IvSDdnVlgzbDZUSkFLTHcy?=
 =?utf-8?B?eXgzalhvZkkrcCt3OURoR1l2b2x2anRkUVlnSGxFNDgvNVRRbmFOMVgrbUs2?=
 =?utf-8?B?VFZLQ05aTXdTTDVIcEhLV0svMW81N0NaODRUQVduTVZSWFlZUmhhME9FeGox?=
 =?utf-8?B?ZHVUYUN0QzJWMFkrbmFlKzlkWE4wUzZYRGVnRDV5UkxWMERCOVdzZVo2cERF?=
 =?utf-8?B?eHNmdjQ0eUgyTHYwUEtsUnYwbzQ1N2JCeXA3YjdPc1VJZ0hiT2k3bXNyOTRt?=
 =?utf-8?B?WjlOR0tYUEdueFZNRlVBTFNBTzlIQ1hyRDlYZVdWdlJUZ0VYOFNabUdTVEZn?=
 =?utf-8?B?dW1ZUkNaQ2ppV1hKYXNnNUFrMjQ5a2RaTVp2OWJQcEpMc2FsSjFjYVQ1WWth?=
 =?utf-8?B?N1hxNC96MTRUTGdLQlUybWJIRS96c1NXUXdqR3g2VEYwSndHdnh0V29aVnBy?=
 =?utf-8?B?N1g2UTQ5ZnF6R3lLb2luc2tDYkdOOGhRQ2s4Um16MElHYkZ6TDY2K3BrK1dw?=
 =?utf-8?B?VkRQMUVpQXZVem9jamdqSTJtS3JiT1M3TjUzbzBHL0tYRUdqNFJhOUJmVVM0?=
 =?utf-8?B?NWpvTXlaVkpEYnZNQ2VLaGxFZ0ErQ1o1RTFNdWVXeFZGREl1Sm5BSFJyL3ZE?=
 =?utf-8?B?UDlGeVp4Q2dkMkF2WTlOeUd1Q0RIYkVucU5DRHAwcHE4MHJ5K3J4cDdCdGtT?=
 =?utf-8?B?N3dzdVdSUTEybEtXa0IxTFhTYUsvbXlrWWNYWUkrNGNXTzI0czVkN0YwUkps?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 029ee531-6d20-4720-bf4e-08dc54fd9a82
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 23:18:57.7112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQGptaPkUOzYx83K2t80g5cJXvGsDtUTs1PEtOvoRjSneYoqoGD6Ie6k5Bux9k7L4VsLP0V7R0SPTWg8xLtUuaU7sB9C8K8cKpfWh2Q1FQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6570
X-OriginatorOrg: intel.com

Hi Peter,

On 3/25/2024 10:27 AM, Peter Newman wrote:
> Iterating over all task_structs while read-locking the tasklist_lock
> results in significant task creation/destruction latency. Back-to-back
> move operations can thus be disastrous to the responsiveness of
> threadpool-based services.

Please be specific with claims.

> 
> Now that the CLOSID is determined indirectly through a reference to the
> task's current rdtgroup, it is not longer necessary to update the CLOSID
> in all tasks belonging to the moved mongroup. The context switch handler
> just needs to be prepared for concurrent writes to the parent pointer.

(insert text explanation how context switch handler is prepared for
concurrent writes)

> 
> Signed-off-by: Peter Newman <peternewman@google.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 30 +++++++-------------------
>  1 file changed, 8 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index bd067f7ed5b6..a007c0ec478f 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -388,8 +388,11 @@ void __resctrl_sched_in(struct task_struct *tsk)
>  				 * by a full barrier and synchronous IPI
>  				 * broadcast before proceeding to free the
>  				 * group.
> +				 *
> +				 * parent can be concurrently updated to a new
> +				 * group as a result of mongrp_reparent().
>  				 */
> -				closid = rgrp->mon.parent->closid;
> +				closid = READ_ONCE(rgrp->mon.parent)->closid;
>  		} else {
>  			closid = rgrp->closid;
>  		}
> @@ -3809,8 +3812,7 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
>   * Monitoring data for the group is unaffected by this operation.
>   */
>  static void mongrp_reparent(struct rdtgroup *rdtgrp,
> -			    struct rdtgroup *new_prdtgrp,
> -			    cpumask_var_t cpus)
> +			    struct rdtgroup *new_prdtgrp)
>  {
>  	struct rdtgroup *prdtgrp = rdtgrp->mon.parent;
>  
> @@ -3825,13 +3827,10 @@ static void mongrp_reparent(struct rdtgroup *rdtgrp,
>  	list_move_tail(&rdtgrp->mon.crdtgrp_list,
>  		       &new_prdtgrp->mon.crdtgrp_list);
>  
> -	rdtgrp->mon.parent = new_prdtgrp;
> +	WRITE_ONCE(rdtgrp->mon.parent, new_prdtgrp);
>  	rdtgrp->closid = new_prdtgrp->closid;
>  
> -	/* Propagate updated closid to all tasks in this group. */
> -	rdt_move_group_tasks(rdtgrp, rdtgrp, cpus);
> -
> -	update_closid_rmid(cpus, NULL);
> +	update_closid_rmid(cpu_online_mask, NULL);

This deserves a mention in changelog.

There is a section in the documentation, "Resource alloc and monitor groups"
that describes moving monitor groups. Unless you receive better ideas to address
the concern about this impact on CPU-isolated realtime workloads I would like
to suggest that you add a snippet there about the consequences of a move.
 
Reinette

