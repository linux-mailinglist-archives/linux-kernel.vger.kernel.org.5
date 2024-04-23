Return-Path: <linux-kernel+bounces-154429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D56788ADBFD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04EBB1C2110C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E28817C6C;
	Tue, 23 Apr 2024 02:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RAlQspjh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E57F9D4;
	Tue, 23 Apr 2024 02:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713839622; cv=fail; b=LpJJiBhbRLBPUrHSwjHB4sV0ogROJABCrXCHwpba21vvEK5Kjn5sEDQ8OdgUYGlPxzmd270Fo2KEFg+G5MoSGpPpcRFpStNsY8jcip35FtlSPmimTrP6jqvNpj8Zv/4evvvXurs30w7ZC402QyHIzgxjCX1yJkKqBnN9VxqWRhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713839622; c=relaxed/simple;
	bh=0B1E7Wn3pdRmC9TyrgOoDjQAazghAW9SR3XUEzFMZKA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SSWlQqFtgAOCFcFUxycbrCOOlauoTvjCiY4WHeYlVA44Za/+pfeQ5kGwVitkc/6/uXCZlHyZ7PZCaF/I5WlYbfxsoGM45DB56LbEvQfLw1xh+Tiw0DmJI1HngF6DJw+A8oT+AF7r7ZbzVyh6b16Zh63wGTDR3XW7JuAzu/jXG5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RAlQspjh; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713839621; x=1745375621;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0B1E7Wn3pdRmC9TyrgOoDjQAazghAW9SR3XUEzFMZKA=;
  b=RAlQspjhJsvrGjil9nzQkgPx21sdPnwbW7R5heSATtDv1ghUqLAkiaJh
   3zk+w82tk4MxbNSZjcj6ztitIx1fBbcgjgNwoynzIQlIWBi4IyQOOnsOy
   y8cwCgnCovSDwOMHpl6HnaL4aaorxncZhEWl3BoyYXCjJPPEvcHtv1nGQ
   kbmOQgas9P3YhZQa82D+rBM4rgCqAEEKbZ/Sj1lrvf6/UUb5nqJobsqcE
   DwvsW0GsYNZA50vaIER0bn0DcBKm94UfjdDZjVCrw2OrCNF1BglPUP/6Q
   uUnsePhqjqtz7u0xwoNpxMLnm++zX+rGJwwUn3CfSZWGEhRFotLrirU5Q
   w==;
X-CSE-ConnectionGUID: on5TxN7LTISGqaTuRTjMPA==
X-CSE-MsgGUID: 1GbAlvloTYGXilJ1n60Wrw==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="31896242"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="31896242"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 19:33:41 -0700
X-CSE-ConnectionGUID: 5mkBwricR1yzai9bHa9iFQ==
X-CSE-MsgGUID: MJ8n/KJNSiCHP16mP0OSHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="29026557"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 19:33:41 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 19:33:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 19:33:39 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 19:33:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/oYT/Ss0kTWudIhMPU//hOfB98Mk+WGPpGzGBA0AQ1n94bON1hETSOoy6uRSNWXc3dCQrRmezKM9TV4AtyWjyTSPx6HMvHkxIbBPUBx5vc5BROZnv64jKC15+y0hJ1DxBhP9L9brFuOIKpZJ9cddlnrbJpXZDYW8tcNydaoklyZBbSYFD7pCsa3S+ioL6iPQ+wZpBs1E2OTNU3dsfglujV2dt9LQyOKBUJY7kUZZyFzqySwlzYq0dUMdmr2p6SEwlc+9oc3PGQoOi5LgLq+AOtmb3vKsexBlQurgxv6co88o1jhENp+7amtK5XZj8aMuzWt3sAYWd4oXLEvrxGQfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrfzKcSg8i+dLBZXOY3fYxVJhStmDqoq8bwyZEGI2Ew=;
 b=anzCK4euT7bSCrXWUtm8SZdG5aMW06FfGiSu9mXhhywvyBFStuKw5gFeoLVYvhg70dCwoh55/U6j+JiGJUBo/loi87jPMid12ZwvP1MK5csq7zcegRndDT4B5InE2/AN8AARcHOq3ZZEHREU7NsM3scgdYYTDncTjabG2JoGSz/l7BTma8/6t3z13RYYpRJiryJxLiaiAtUHl3tG3R8XXJY4ACgZb5KItPaxIvU2mpnhVA3GG4TsPKaj7Dm3Qs4QAue8PzC0IakWe3ytmCYFXB9K439/xdvG6xQP6UiNTj5lSZle8FNN+aXYv63286TAMBSdUexFBnuJ5OKq4Bvtwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by CY8PR11MB7876.namprd11.prod.outlook.com (2603:10b6:930:7d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 23 Apr
 2024 02:33:32 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::c990:5065:ed39:c165]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::c990:5065:ed39:c165%6]) with mapi id 15.20.7519.018; Tue, 23 Apr 2024
 02:33:32 +0000
Message-ID: <9f23dd31-e7ef-4599-a13c-932ac288266b@intel.com>
Date: Tue, 23 Apr 2024 10:33:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/6] PCI/RCEC: Introduce pcie_walk_rcec_all()
To: Dan Williams <dan.j.williams@intel.com>, Terry Bowman
	<Terry.Bowman@amd.com>, <rrichter@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240313083602.239201-1-ming4.li@intel.com>
 <20240313083602.239201-2-ming4.li@intel.com>
 <d69c2157-a0da-4d8c-8684-d42afd285191@amd.com>
 <661e00eb808e4_4d56129429@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <84eb39a1-60dd-40cb-8c7c-dfd9a988732d@amd.com>
 <6626ecb93f752_690a29483@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <6626ecb93f752_690a29483@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|CY8PR11MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: c9514bfa-54ab-4a1c-c77c-08dc633dc45d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L25UMUxndVFOL0phN0pMOXFsS0Z1QnVhNHg2YW5IaDlDVmJsL244SmhLNVFS?=
 =?utf-8?B?Z1Boem1xSis2eElzRzRtTmI5bG04MkVYOEJnanNveE1EeG5PeDVtemJDS1BW?=
 =?utf-8?B?Y0xtTjZMNUZJTmN1ZVhNWGNqcHBsbk1STlFEcGc2WHNlbnU1ZUZ5RFdHMm84?=
 =?utf-8?B?UEFUQ25xeXQ1MWJOTGI0RkdpSUEzQXJicWwvVjNaYXBjbnlENE9HZTZYU1BP?=
 =?utf-8?B?RkFFc1ZOdk5xbDBHclltZUx1WEJIYm1aUndSZFp6Q3pVR2pJeSt3ZkFzNXFT?=
 =?utf-8?B?MUQ0UmJWR2R2WWF6clV1bmovZXZreU0xR0x2bjBzRmlXSnhEQmg3Lzd1SmRB?=
 =?utf-8?B?aGU3bnNTUVRUSUNSeUNJSHFBaEVHZjhpQ3pYTVVTYWUxYkNSdnp1eTBTdTBG?=
 =?utf-8?B?RjlIYlZQVzNYaTJ1cWx6WlBYUmZxNzBoa090TThJUU84SDA2bkNYbU5JYTFr?=
 =?utf-8?B?bDFBQkVZRk9vN3g4dlh6SlUvTzI2SjFoWXF5OXdlK2pBN0p1OC9yNmM4VVMz?=
 =?utf-8?B?L3gwRHcwNWR6dFdzSnhQL0ZFQW1GL2h3Tkk4UzJDa0l0ZnJaQ3N2ZUtoYkpk?=
 =?utf-8?B?bjg0WndGMWJyWlNyRTR1Y0cvRFVKZWRzeHZ1Q0pta05WQU5waG9hMFhUTzhZ?=
 =?utf-8?B?TllwN0lENXF1cGpMc2k2NUExN0hSMG0vMEMxRXNKUGs5aXdYb1BSWWMvR0Vl?=
 =?utf-8?B?SU5XUm9rYkpZRG5nUmlRZFJuOXh1QUV4YTBGY1RaZzhmVy8xVVhJaUNkbWVX?=
 =?utf-8?B?RFhyMXJRMUNIRi9ESktGNHp6clJNZmROcEpab1hzbDZnM3pRd1c1dUdOb00z?=
 =?utf-8?B?aWlNeWxOMFhXRHBzZ1EzY2twc01uL1VGKzlFMDNSUEI5SjF3L0ZuQS9oZ3By?=
 =?utf-8?B?TnlGVi9KdEU2RHZBZ1k4ZjZXMFF0bE5paDRWT2hDVEtOL1pkNitlL1JRUVZs?=
 =?utf-8?B?dGFlTUpnOXBmWmErTXowTVUwaFYxeE4vZER2c1gydzloTnFTamxLK1BQaUp1?=
 =?utf-8?B?L0hsdnF0QmZTMGYySEdDLzh6T1hnNmJQMDlDRVdoc29Fa2R5N3dYSG82cFM5?=
 =?utf-8?B?aUZzNHY0a1VKY2duenVPSUxXeTg1K3hpUE1sbFZHa1oyMVBHK0EycTFQbERr?=
 =?utf-8?B?QzU3ZGJOMXNSMDhnMGhvdTN5S2RRSWdjakYvUlUvc0tNcmd6K2VxdVozWDBO?=
 =?utf-8?B?amd4N3JNc1V5TG1BZGhrdnFGZFQyaEZ0ZHF5STRqWWRxV0hSdzVEMW90amtQ?=
 =?utf-8?B?R21iZ3VnSjd2SzVLRGkrS3VPZ25IdHdtYVQwRHBFcnV5cWdsVWhxMVdVMXhu?=
 =?utf-8?B?bFh0WUJVbDNZUjVBQzFCamVHbDlXaGFPSlFTN2JxYVRJZjEyVFpkbCtER2tj?=
 =?utf-8?B?MjRndXJ1YkprTEhDVk5VTXNkQjdORlAvMEtuZjhINGZyVkpkVkJXekF1ZnFa?=
 =?utf-8?B?NDhjMGdPcldkZ0RraG5ZR2RrZXJxSVh2RTBVdURNYkhDSFlwT3c3enNRa2tP?=
 =?utf-8?B?R3h1WXhZWW5RMFlOdUhGcno0NnBwbVVSbzJnSUVOeW56QUFPUG5IZWFJQXdI?=
 =?utf-8?B?Mk1hSWRjUTVFeGFtUDNuM0JrQ1BPZEU2ZmNzSVpBaDNnMldJZXBTbzB4RXRl?=
 =?utf-8?B?YTNVWnJ5TFh3QTZzeHFaYmlkRGlKWTBFaHlTQmkxWHpDYUtHcHF4WkJYTng5?=
 =?utf-8?B?M01xUXdYdFdWMUZzRVFIUUFENkxjeWZJdEkwVlNHd3M2eGx2a3pwdTl3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHVQMnFxY3JYWXBYN1ExNHNaVW1QQWdReGhmTnhiRjlNbVNtZW5rT2tQOUtG?=
 =?utf-8?B?R0pJRGZEeG5ndFk2MTBPeUpST2xvVHNXK3BnVmRSRy9TS3hwZkVBNkNxT0J3?=
 =?utf-8?B?N2U4UnJXWGpQdHQvMUZjZkRCdUFKWG94c09Wbkkvb05KeWRDdzRhYmwvaVR0?=
 =?utf-8?B?K1Irei9rOTNJQ29yOGhaUzNpckZNZHFwNk1HTU4xeDIyZVg0YVFwaitYbmRt?=
 =?utf-8?B?ZjZ0V2hjNXc3VjVDc00wc2xXRTFJQW9URksyVVFNOE1iWm9ReGFqb2JrNHhm?=
 =?utf-8?B?emNMTHJVT1QzdFN3bnduVGtOVlN0ZmRsTkx1aTRqR1ZCSTRLSUQrck56SG1M?=
 =?utf-8?B?eXNNaEtzcEVHbGV0UmRIbjhBTnRUdGI1bG4zWThGdHZLZllBdC9qYTMvWmRN?=
 =?utf-8?B?ejUxWXdHOTBsbFd6TkY4Sk9QMTFRTUZLa3dSZzZoR3o5YTdFbjgrLzBqdW9U?=
 =?utf-8?B?NEpWd0VEM2p1YjRDaTBkdGthOXd0clBvVjdHcG9VbDF1SjJ1YVRrSmI2V1Jv?=
 =?utf-8?B?Wit0T3VpRnVYZGFHT1RJL2RrVDdMc200T3lYYS9wQ21ncE54ZVBpQVpNMlpV?=
 =?utf-8?B?ZFEyQlFNMHJEUW54WHR0ZXM1YkgvRi9VNktlOUJKQlF4TzhRR0VKek1GTHpz?=
 =?utf-8?B?cWhWazU3djh3OXVEWTRFaVJLaWY0bVRxSXZydENrQnRpTGRqdDVSelhtWEdW?=
 =?utf-8?B?bG5RL0p1aDlSUmlicG4zQWd0WG9oT1NSM3gvdmxxb1dsMm9JdEFmTmluK0ZC?=
 =?utf-8?B?N1NxL1l2RFJ4OVJPRlRYdnBGTXFXYVQvZkwvVjQ4enRHTVhKZjZKSS94NDIw?=
 =?utf-8?B?R0llRkZvY1JUbk9KK29seFU4MCs3aFI0ZGVWNXdSMDhpUzJ2VVR6ZG9xaU5h?=
 =?utf-8?B?YitZRklyc0theG9zTlhvbFpwNElLVnduRGRhUEc1SExnd3gyVyt1TG9UeFdL?=
 =?utf-8?B?TXR0Mlg1QWkvNVJERitDbTVjZ2I0M3N4eWFnVVdTTlRsR2llTWc4R3J6N2J3?=
 =?utf-8?B?WVd6ZkdEcXNYSGZYazM4VUpZd0Flc1VabDNLWjcvM2w0YjRiOS8vMmQ2MWs5?=
 =?utf-8?B?cndIeXBsRzBsYVpMSXNadm5jRG1nVDlpcEhVdTNZQjRZdkIvVmY1bU5qbkhE?=
 =?utf-8?B?bDJCV29WOW9lYkJzVXB1OGs5OEJmSk9mWjhCeHpjMkpNY1JvanIydTA2R25H?=
 =?utf-8?B?UkdMZFhFL1I3SGRiUnZUNDdHV2F3V2hUVWZmQS92a0JSaUpjcXpvVFZVeHlE?=
 =?utf-8?B?eFVMOXEvQXVBUndic0Z1UDdvRmZtZTZGMHdEbUlsTHNuWlN2S3B4VS9velM0?=
 =?utf-8?B?aXFjWUlWQ3BpSTlPdW5xRFhreEdSR25reCt5VzRJRXhFb2tGUjJyOFBCRCtS?=
 =?utf-8?B?bDFMTHp0eXpvOXo2Y0xSOHFHbmJzbkhBVGVySFR6cUNFWEpuK1NzdjVUK01h?=
 =?utf-8?B?Y1NRUjUyL0Z1WVVZT2JPN1BwTWN4cXZjR0VwS1R1QUtGN3JDUGgwNnFDajlM?=
 =?utf-8?B?ZFRPSVVhMWd5UXZ1MkFOTFB0aHVhM09YUmE1OVpIUXRGQStLQmhOQjVxNk1x?=
 =?utf-8?B?YXdwY0RMd0RMdFlvUjRVQ245SEwvSVJYSTlYU3dTbndxbkI0c0t3MWVJSHg1?=
 =?utf-8?B?cTBzNERNamcvQ3RjT2tBdnZxTGU1RHc2MFMzYjZZdW1EaC9LUGxyTjBtU21U?=
 =?utf-8?B?T3V5cUtnUDFiYjhydmhXMXJZbmVsMFJhNWxGcFFKV2NwSTM2eGU5TjJLN2JG?=
 =?utf-8?B?SkdhWjFMSThCa0FiQ3laK3B3QlRFclY3RmczSExHbzdUWWR0ZnhSWjFtZmty?=
 =?utf-8?B?cXhZaE1FVGNCU2J4NDRmZkVURkNHQlE0aVlMNEFVSmFMdEY1NlJlQU1uNkk0?=
 =?utf-8?B?VkdLVXhldmMxU2lFbHF2a0JFWlB3R3ZHa29DdHU3YXhERkk0dTlQT0NmSjkx?=
 =?utf-8?B?dmVNV2RjWGlNOVNRbnA0TEdhdkVQS3FIQ2h3aXZMMUozejV1SXpLcWYxaXFK?=
 =?utf-8?B?QlVsdzVSdmxtcEpiN1BIRS8ydWRVZ0hZa1RQOG5zZ1V3OTNqNVYyNndkZ005?=
 =?utf-8?B?QmFURWsyWWtZbUlQdk5PaWgwSGQwTkY0OXZhbFdEVG1xUUdHT1U1YTliaU4z?=
 =?utf-8?Q?m08ZZHAky4tfTBQL6vcdmzo+5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9514bfa-54ab-4a1c-c77c-08dc633dc45d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 02:33:32.3264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8YJKZ2T6pU1M3BE786i1/6BX5g82wfXKL89fLpBm0M7JJ22nIxciTz7avh+2zHOAKr8spq5fN/dMISxK3YY7Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7876
X-OriginatorOrg: intel.com

On 4/23/2024 7:03 AM, Dan Williams wrote:
> Terry Bowman wrote:
> [..]
>>> Hi Terry,
>>>
>>> This patchset is responding to the implications of the implementation
>>> note in 9.18.1.5 RCEC Downstream Port Association Structure (RDPAS).
>>> That says that CXL.io and CXL.cachemem errors in Root Ports may indeed
>>> be signaled to an RCEC. Do you expect that implementation note to cause
>>> any issues on platforms that do not follow that CXL spec behavior?
>>>
>>> My expectation is that it may just cause extra polling for errors, but
>>> not cause any harm.
>>
>> AMD platforms in RCH/RCD mode consume protocol errors in the RCEC's AER driver. AMD 
>> platforms in VH mode consume protocol errors (including root port errors) in the 
>> root port's AER driver. The exception is the VH mode host with CXL1.1 endpoint and 
>> RCH downstream errors. CXL1.1 endpoint and RCH downstream errors in a VH host are 
>> consumed in the RCEC.
> 
> I agree that's the most compatible path for existing software.
> 
>> I don't believe these patchset changes would affect this behavior. But, I will need 
>> to test to confirm.
> 
> As I wrote to Li Ming, I think any potential conflict can further be
> limited by the fact that this extra scanning is limited to CXL.cachemem,
> not typical PCI AER flows.

Agree with Dan, but I think that software does not have a chance to know if the error is a CXL.cachemem error withour RDPAS(only knows it is a uncor_internal_error/cor_internal_error reported by RCEC), maybe we can limit this extra scanning for the RPs working on CXL mode?


