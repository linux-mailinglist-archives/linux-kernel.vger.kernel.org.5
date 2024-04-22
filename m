Return-Path: <linux-kernel+bounces-152901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6D78AC5ED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19BC8281192
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239F94E1C8;
	Mon, 22 Apr 2024 07:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hXDQ1Wwj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AB54D11D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713772090; cv=fail; b=eAZBCOx50m2c0zCLV7lCKzMOokC19l9moeDP6FWKZ/dnKdhM7PZq7gUAUoaEqUi1zv5voMxjMLLJS/ZEgWV9IbHRJmvRby42M5MHQJTNqiHp/WCeNV6csqebI984iiBqKf8/aSfORrNJywAEeC6t5Gj5knxlYMDyQLE5c3G3Acs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713772090; c=relaxed/simple;
	bh=Xbl+uG2GhGdvFHKTzAytHepqJAj1S0nwt9iAze2ZdYY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tBtdw79EhYH9RkBdtGYY7c3qhuxgJ+vsCbVRGziIdWg56SXtWCwlvKV8QJqblJf4I8uXCgHDBIrOg52Rj6adEhMrsuKoD+6ZPTcXhqkS5AgRH4hrNEwzeSlQ4vQ9ST+OMzEsQZkHekOMbQIGu/De4n0RM581NCZ4XhIsAi46Ed0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hXDQ1Wwj; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713772087; x=1745308087;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Xbl+uG2GhGdvFHKTzAytHepqJAj1S0nwt9iAze2ZdYY=;
  b=hXDQ1Wwj44vywF3b9chBCt9EirzQi9wv5b0AfQzyFsaStgtRDEYHBEFI
   DTmK99NBuwzc2BLaBXEc+yUgTjt1o7KbvM/ZTCfuzqibA5DMYwVBB6I1o
   2N0jvjJ+MB3K3jztdA1+/iPNdI1EaLuE/A5A9BnTLe4ucNTygJ3j8qTy0
   pHf+6lmXmpRbeVQujHPIvgRtONA6pbgFZYMx9MW7MKRbc6+EfqWVPTQRM
   vyrvafN2qdAWNbNbp+Ou3GSiYEpoxjusrZOXzOxbW0gEJlAZwzRF+mCuT
   xLDVRMiGz+QugsM32uyT3aLiJLzx+rPz9AD8A9AfXtPHY2tR+aBIKqEdi
   w==;
X-CSE-ConnectionGUID: H5O64D66TZetwqxzWXctFQ==
X-CSE-MsgGUID: msb9kWv0TAO5uI1oG0HQig==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="9161545"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="9161545"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 00:48:06 -0700
X-CSE-ConnectionGUID: OnEZIHDxSzGpBD1exuaq1g==
X-CSE-MsgGUID: 8q0RCnmiQHqi8fPupgfjfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="23985025"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 00:48:05 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 00:48:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 00:48:04 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 00:48:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJw+9LTrhdTc0FNUE7gSOKmnUSYKGK/qyf5UnBNY5B362SnTPbktowF76FsTNZ5DJUhaO0ekrWFLjsNWtp/7kNCeU5Qh7OAdOj7Iztno+BUb3Jh2bh+A9H43cddLeyEbO7sOG69DTfMdXopsj6Ou6uSV5Gk5oQsRkkvnba72Q1mIrwxL+hJRZZ1u6Wtxix99CvnmxzpK+DKUdcxYotgGX/iLgya7scKDUTf15UOLP18RmJAAVIi+7lCoYgmNu4pk0YC6wKN0MbpP2r5HYoCF1z8/f0vTQU6RM5HTBVUDAYje+6kllWYdB9JzS5Cj5/imIVL47zWMup5Z9bu0Q3OFZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nX3bANmC968AzxiQBpIFjhCb3E5SSmYmWaZDs5nnB3s=;
 b=KYqMWI5ZefXTT8lSQLVqbSW6wDGKjsr+KRXnOih3O612bFq34KnKCXOLBmVjOebYGC+Mr4364DLjPeN32JHsZXrlNfHcaNmkXMYcwaB2rT2c0i9f6KvtuJ4vye2VDjYA4wjvv+9F9PegRdTd5MOh69km1xG5yHs+jDsfeNwgbB2Mb5vRX27e7DdDqCLwzPzI+p+0mH7tb0IkB7lUP1n+y0ZF4LyUbbFhH6ubCWV4O3Riq4VDRL72A1ii6lNSPIzgrfmt9X6ryvw7EITqmhMpvT6/I67QQ0Qsr+UWjol+aJoofnMVcPaDsrmnKufroOkFQk8UQ3OzRuCQ7XtBxfFATA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by DM6PR11MB4753.namprd11.prod.outlook.com (2603:10b6:5:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Mon, 22 Apr
 2024 07:48:02 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::c0cf:689c:129c:4bcd]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::c0cf:689c:129c:4bcd%6]) with mapi id 15.20.7519.018; Mon, 22 Apr 2024
 07:48:02 +0000
Date: Mon, 22 Apr 2024 15:41:27 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>
Subject: Re: [linus:master] [x86/syscall] 1e3ad78334:
 will-it-scale.per_process_ops 1.4% improvement
Message-ID: <ZiYUpxCTyh1uEgeO@yujie-X299>
References: <202404191333.178a0eed-yujie.liu@intel.com>
 <20240419073346.xlpx4qaocbo6bhip@treble>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240419073346.xlpx4qaocbo6bhip@treble>
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To SA1PR11MB8393.namprd11.prod.outlook.com
 (2603:10b6:806:373::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8393:EE_|DM6PR11MB4753:EE_
X-MS-Office365-Filtering-Correlation-Id: 72af61be-fa08-4c39-adb2-08dc62a08956
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?J6MtV6+kAEeAgCxa0y3qsnLC2Bp/6L7M0SgzeYvcHpTHxrLn3TBcywcSPA?=
 =?iso-8859-1?Q?9/R6fcnZAHBJPEBLjo1NSmkg+TE1PxiGmhmJePik7/MzPldsGeRWtNt4hy?=
 =?iso-8859-1?Q?fCqW48QL2dnJkpgGnI6atglJjfX3/lRd3o1u+K2mjC4o8/WdaI2NjKP56o?=
 =?iso-8859-1?Q?mm9Qq4WhD4g4Cy6pg/B2YZrtS8wRMM1XN/V+ER7DuCTQKAYSCXQQQXm+v/?=
 =?iso-8859-1?Q?xa4QVdtkaGrNCueHVsjN8QSeZhMCS5+fmYTUr8ikCbN/lAz5tjGRAqiVsT?=
 =?iso-8859-1?Q?59yfU1izDfoqE7x30JaRLLRqtv6IUbbzORTns2zwERM/JY5EIBmx3NqjQc?=
 =?iso-8859-1?Q?T4qBIwoFgDzHgEoC4XoXYvc6EUMdQk5jFwQQKbJ8aTx7LhsTDh3nh+HsY4?=
 =?iso-8859-1?Q?h2E8wzmOx3A6+wbWhFO2/boLFmCkKKy1h88PGAYV4YDb0RENMfZNpBgmfV?=
 =?iso-8859-1?Q?fPzbq1z+00DWznBYXjiW6qm3y/hXVdl2ZbmkzM95qZuYzv1MHiX0NVvhzB?=
 =?iso-8859-1?Q?BiwADokx2AMPI7hoT5LOpGaFn3uj5Tg1w2mlU3kri0RnRCCMIUWjPniwNj?=
 =?iso-8859-1?Q?kZDReu7q6NIdLpIGjpGCQIAowW1XDjTEJOdy7qnd/igVda9SjPveScKgNu?=
 =?iso-8859-1?Q?1YhTAVu7PVC9CIXQf75LXRPJBV89qB4po/ZFhDaeloXbooScY3V9vC7Qxq?=
 =?iso-8859-1?Q?INTuE/bDoQLxCnYV854S2qXY++Rkjdv3fmcCvRIwCtu/cyK6L88uYCNoCk?=
 =?iso-8859-1?Q?FVGmSuXqIXC/OJaymxE9640rWJd3Sr+1HsuxMWYpchbwD+0NI7Yor4j39C?=
 =?iso-8859-1?Q?3Cgw38eiKW+WCiP3812Ak0Yfb7RIlCl1AyiAHLgHxgYhHTBQU5/4el2Pra?=
 =?iso-8859-1?Q?L/P2gMEH0kPFoc+oplE718SAhI0UY+g7/rVqefin0hdd2QCK4oh6zsKfku?=
 =?iso-8859-1?Q?pnZHmRbODlNirUvyD5Vq9TcGVDZ/j14CbltxMWUECnnISrqL4m91Rj8oCH?=
 =?iso-8859-1?Q?ZHRxb+GA7jxi5AAMHpnKQiCSU7BxO4X5/ukOgEtkrJsRC0lfj8VIDTVoN3?=
 =?iso-8859-1?Q?MdGFJYEHeYOSKoJdsv5wh7/XY+MDSKKvG6SOohoIpke03jxJjfTf5e7txD?=
 =?iso-8859-1?Q?6WuhYi+fCCoGmqWo8kc4ZCxP+Cy2wcimgk5VZofQdHnZIVu7ZzgwUIx2Ym?=
 =?iso-8859-1?Q?+2GO77wHBeaoT7uGEELVJ/5MT3jzJZIBdf603CwMtzSf8Z/bah090ILG09?=
 =?iso-8859-1?Q?U9tff9GlE5ubTp+rVwzhDOvt3Lsdoif4ATEQhHUo73qkq2joqcDtLFOlny?=
 =?iso-8859-1?Q?oM25MFi67Db7sNUpj+KJWxtgsA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?YfFE90Njw64KXfwuhwcoqCiPnDCSKimpJ4Fn29EU63Rrk6/q1RdA5U1voO?=
 =?iso-8859-1?Q?4yuZRUwgdv/Em6oPtqgN38Xv7/LQM3ZHD2DV+mE3ofVuCqFle5kQpAIebo?=
 =?iso-8859-1?Q?V0jNryjGrtw1fZ6P/QRotKgsTHD+bhLBK41kPrBTMsRU3LYjo+iJ4E2IvO?=
 =?iso-8859-1?Q?bgJOrok9ePcVjGcM9m6F0qevrzTgXlCaeZfA+4CwVMqunvDxshDSkoEpgY?=
 =?iso-8859-1?Q?g7i5tSKsiz1g/10j3q3hvFazuMdpfkTZi0W+EoFnieQPn8vTfmLMuu+Kxn?=
 =?iso-8859-1?Q?Y2V0X6qNAuvfUgyxNwrDQfahE/Zm/7kF3VUuTPdFruGKaXsq+H79kG3J/W?=
 =?iso-8859-1?Q?gXdUCY9eXTO5R8ebQImq62awVURh5OxPLUq3uiNblkI+c6Gdd3xugZZ5a0?=
 =?iso-8859-1?Q?gvHdU7NedxyUySwGWnKQKoj8KdWTNKIPH27vZlbdC/AI3D3wFxib0b5apV?=
 =?iso-8859-1?Q?FnFvC5h99msp3m4d0lProVCKzUIoDNRtIuXBY6F+4NlWVgjEl+L+9Rd14e?=
 =?iso-8859-1?Q?hwNQqenO4DlwTUr8RdVuJV2mkRJeJ9jZD5G5mvuJYxwWU4CfutSpDmhYUr?=
 =?iso-8859-1?Q?YsUft7GGtD+R9TH/n/8oI0b2mqc87djExTDNVuV12Oz6efUB2+73zeBxiA?=
 =?iso-8859-1?Q?Iey8rEUJcDiQHoVcw8cxIiJLYbhWjbGGPvpw3RXAs8bDSMc4ZC0LjiCcqm?=
 =?iso-8859-1?Q?WI//gvlUuhLA0C8UEu/bMFFsvr42dgpHmPEpRn/tPWVDMFxdjaT4CbODhE?=
 =?iso-8859-1?Q?/sXZ4qEmW8XlTnv7PbuCiMp4Aw7yAA9vW22pBeWqsGE/OWkdgRvH4waq5Q?=
 =?iso-8859-1?Q?sf4trT1oGZu4JfXhtHGIqTSR3Easm1EhyAt9/F8u9zp1XOwXkEaw15Vm2s?=
 =?iso-8859-1?Q?TcP/a9ZeoHf4WnL29ViE0qhgjk+NzuNUqQXhQSgO99e/YV7DswJWZct4/6?=
 =?iso-8859-1?Q?U9mfGN6YaZmfRX5L53y5r3DM0ZWMvxWQ036BHtoCHYfwvNdukGJFCf0gRN?=
 =?iso-8859-1?Q?TWST3B8Q4M5WFZVdSCk70vAg8jwDYffysgzI8tpJCizdZXscGLo1Zu1uc2?=
 =?iso-8859-1?Q?7DgRGmyDjroEnZ1EJ2rYcaMkzNXYdirf4n210quCIZjNZmnzTWG7aWkjME?=
 =?iso-8859-1?Q?0pMvxh4I3f+rSc/Ogjgo8prxaRnJAc1IwFNbvUkSbJfAHdXMLV9K2pHAgL?=
 =?iso-8859-1?Q?nDAkLr/NOUYfhvoxSjRI2zOlUeoEo29b650N/m1IdeMES2IMtyOKZNn3Is?=
 =?iso-8859-1?Q?FHvbwwyWHw/9MSGKB9V6MMbMZoyZf6PRpgft31LWAXcvvS+u1GHN9EY6D5?=
 =?iso-8859-1?Q?/SgA3eKr0aT73+ianofnLzf930cfnJqumnGFwU9l64Qtvlz513HXo0fyg+?=
 =?iso-8859-1?Q?Zqox/0ffwdgV8FDJsG6ey2kNloqf6u5b6w7Cn64p0dRe50nK0Ae1Jqw012?=
 =?iso-8859-1?Q?Gvrs8HD0hgOLLm5srfvw42DsmOu3r+ymE7lHXQX66K9ziddK5Ht6nIaQU1?=
 =?iso-8859-1?Q?LxHkxYU2Y3dgPGel4HDs3xhoEP++b81L4Llq+KizKv3OPAyaRrldAj0sa9?=
 =?iso-8859-1?Q?JJic5N+PzlAEVse3x3oUzVKQz3v7591P6N5o7mGkk0AhTQj0rE2QQbWTGv?=
 =?iso-8859-1?Q?6JnLAN9ngm5aQAGwD375lTNz3NUtV0kTVq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72af61be-fa08-4c39-adb2-08dc62a08956
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 07:48:02.2012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQm0SHtYQTmRhnv87JQEDyXfRh7bdDpZBvQmb3ipyBhi1FkMUnB5aqqGDyjOcuKctc3BfZzm/JWATBkNDNJfaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4753
X-OriginatorOrg: intel.com

Hi Josh,

On Fri, Apr 19, 2024 at 12:33:46AM -0700, Josh Poimboeuf wrote:
> On Fri, Apr 19, 2024 at 01:49:26PM +0800, kernel test robot wrote:
> > Hi Linus,
> > 
> > We noticed that commit 1e3ad78334a6 caused performance fluctuations in
> > various micro benchmarks. The perf stat metrics related with branch
> > instructions do have noticeable changes, which may be an expected
> > result of this commit. We are sending this report to provide these data
> > and hope it can be helpful for the awareness of overall impact or any
> > further investigation. Thanks.
> > 
> > kernel test robot noticed a 1.4% improvement of will-it-scale.per_process_ops on:
> > 
> > commit: 1e3ad78334a69b36e107232e337f9d693dcc9df2 ("x86/syscall: Don't force use of indirect calls for system calls")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> Thanks, these are significant regressions.

First we need to clarify that by running this specific will-it-scale
futex4 benchmark on a Skylake machine, we observed a +1.4% performance
improvement, not a regression.

> Since this is on Skylake (with IBRS enabled, presumably) I'd expect that
> these regressions are fixed by my "Only harden syscalls when needed"
> patch.  I'm planning on posting a new version of that tomorrow, but v3
> [*] should be good enough to fix it.  Could you run these tests on the
> same Skylake system with my patch added?

The v3 patch [*] cannot be applied on commit 1e3ad78334a6. Seems the
code base has changed a lot, so we are not able to directly compare
1e3ad78334a6 and 1e3ad78334a6+v3_patch.

The patch is good to apply on v6.9-rc4, so we tested v6.9-rc4 and
v6.9-rc4+v3_patch. Here are the test results for your reference:

Skylake
=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/nr_task/mode/test/cpufreq_governor:
  lkp-skl-fpga01/will-it-scale/debian-12-x86_64-20240206.cgz/x86_64-rhel-8.3/gcc-13/16/process/futex4/performance

commit:
  0cd01ac5dcb1 ("x86/bugs: Change commas to semicolons in 'spectre_v2' sysfs file")
  1e3ad78334a6 ("x86/syscall: Don't force use of indirect calls for system calls")
  v6.9-rc4
  v6.9-rc4+v3_patch

    0cd01ac5dcb1                1e3ad78334a6                    v6.9-rc4           v6.9-rc4+v3_patch
---------------- --------------------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \
   1362315            +1.4%    1381406            +1.5%    1382652            +0.5%    1369778        will-it-scale.per_process_ops
  21797058            +1.4%   22102512            +1.5%   22122442            +0.5%   21916453        will-it-scale.workload
      0.04 ±  7%      -7.4%       0.04            -6.1%       0.04 ±  2%      -4.0%       0.04        perf-stat.i.MPKI
  1.98e+09           +19.2%   2.36e+09           +19.2%  2.359e+09            +1.7%  2.014e+09        perf-stat.i.branch-instructions
      1.47            -1.2        0.30            -1.2        0.30 ±  3%      -0.0        1.45        perf-stat.i.branch-miss-rate%
  30820475           -70.4%    9118612           -71.0%    8945551            +0.5%   30985854        perf-stat.i.branch-misses
   7767463            -1.2%    7676829            -1.0%    7686158            -1.3%    7664542        perf-stat.i.cache-references
      3.45            -4.4%       3.30            -4.4%       3.30            -0.4%       3.43        perf-stat.i.cpi
 1.504e+10            +5.1%   1.58e+10            +5.2%  1.582e+10            +1.2%  1.522e+10        perf-stat.i.instructions
      0.29            +4.5%       0.31            +4.6%       0.31            +0.4%       0.29        perf-stat.i.ipc
      1.01 ±100%      -0.6%       1.00 ±100%    +104.1%       2.06            +0.3%       1.01 ±100%  perf-stat.i.metric.K/sec
      0.05 ±  2%      -4.2%       0.04            -3.9%       0.04 ±  2%      +0.4%       0.05        perf-stat.overall.MPKI
      1.56            -1.2        0.39            -1.2        0.38            -0.0        1.54        perf-stat.overall.branch-miss-rate%
      3.43            -4.3%       3.28            -4.4%       3.28            -0.5%       3.41        perf-stat.overall.cpi
      0.29            +4.5%       0.30            +4.6%       0.30            +0.5%       0.29        perf-stat.overall.ipc
    208138            +3.4%     215312            +3.5%     215474            +0.5%     209279        perf-stat.overall.path-length
 1.973e+09           +19.2%  2.353e+09           +19.1%  2.351e+09            +1.8%  2.008e+09        perf-stat.ps.branch-instructions
  30729762           -70.4%    9109071           -71.0%    8918595            +0.6%   30911752        perf-stat.ps.branch-misses
   7745419            -1.1%    7663567            -1.1%    7663740            -1.3%    7647834        perf-stat.ps.cache-references
 1.499e+10            +5.1%  1.575e+10            +5.2%  1.577e+10            +1.2%  1.517e+10        perf-stat.ps.instructions
 4.537e+12            +4.9%  4.759e+12            +5.1%  4.767e+12            +1.1%  4.587e+12        perf-stat.total.instructions
     12.23            -0.6       11.60            -0.6       11.64            -0.0       12.21        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     10.09            -0.6        9.51            -0.5        9.56            -0.1       10.01        perf-profile.calltrace.cycles-pp.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     22.31            -0.4       21.88            -0.4       21.94            +0.0       22.36        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
     19.15            +0.2       19.30            +0.2       19.38            -0.1       19.04        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.syscall
      9.25            +0.2        9.43            +0.0        9.25            -0.0        9.23        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.syscall
      8.79            +0.2        9.02            +0.3        9.07            -0.1        8.72        perf-profile.calltrace.cycles-pp.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      7.13            +0.2        7.36            +0.3        7.41            -0.1        7.07        perf-profile.calltrace.cycles-pp.__futex_wait.futex_wait.do_futex.__x64_sys_futex.do_syscall_64
      8.37            +0.3        8.63            +0.3        8.68            -0.1        8.28        perf-profile.calltrace.cycles-pp.futex_wait.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.38            -0.6       11.78            -0.5       11.84            -0.0       12.38        perf-profile.children.cycles-pp.do_syscall_64
     10.12            -0.5        9.57            -0.5        9.63            -0.1       10.04        perf-profile.children.cycles-pp.__x64_sys_futex
     22.63            -0.4       22.20            -0.4       22.24            +0.0       22.65        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.48 ±  2%      -0.0        0.46            -0.0        0.47 ±  2%      -0.0        0.46        perf-profile.children.cycles-pp.get_futex_key
     19.34            +0.1       19.49            +0.2       19.57            -0.1       19.24        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.00            +0.2        0.18 ±  2%      +0.2        0.18 ±  3%      +0.0        0.00        perf-profile.children.cycles-pp.x64_sys_call
      9.11            +0.2        9.29            +0.0        9.12            +0.0        9.12        perf-profile.children.cycles-pp.entry_SYSCALL_64
      8.88            +0.2        9.11            +0.3        9.16            -0.1        8.81        perf-profile.children.cycles-pp.do_futex
      7.13            +0.2        7.36            +0.3        7.41            -0.1        7.07        perf-profile.children.cycles-pp.__futex_wait
      8.43            +0.3        8.70            +0.3        8.75            -0.1        8.34        perf-profile.children.cycles-pp.futex_wait
      1.20            -0.7        0.47            -0.7        0.46 ±  3%      -0.0        1.20 ±  2%  perf-profile.self.cycles-pp.__x64_sys_futex
      1.46            -0.2        1.27            -0.2        1.26 ±  2%      +0.0        1.48 ±  2%  perf-profile.self.cycles-pp.do_syscall_64
      0.51            -0.1        0.44            -0.1        0.45 ±  2%      +0.0        0.52        perf-profile.self.cycles-pp.do_futex
      0.38 ±  5%      -0.1        0.32 ±  4%      -0.1        0.32 ±  5%      +0.0        0.39 ±  7%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.48 ±  2%      -0.0        0.45            -0.0        0.45 ±  2%      -0.0        0.46 ±  2%  perf-profile.self.cycles-pp.get_futex_key
      1.21            +0.0        1.24 ±  2%      +0.0        1.23 ±  3%      -0.0        1.18        perf-profile.self.cycles-pp.futex_wait
      0.09 ± 14%      +0.0        0.12 ±  8%      +0.0        0.13 ±  6%      +0.0        0.12 ±  5%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.00            +0.1        0.15 ±  2%      +0.2        0.15 ±  3%      +0.0        0.00        perf-profile.self.cycles-pp.x64_sys_call
      7.97            +0.1        8.12            -0.0        7.95            -0.0        7.96        perf-profile.self.cycles-pp.entry_SYSCALL_64
     19.28            +0.2       19.44            +0.2       19.53            -0.1       19.21        perf-profile.self.cycles-pp.syscall_return_via_sysret
     10.43            +0.2       10.60            +0.2       10.59            +0.0       10.46        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.72 ±  3%      +0.2        0.94 ±  3%      +0.2        0.93 ±  4%      +0.0        0.74        perf-profile.self.cycles-pp.__futex_wait

> Also it would be helpful to see the same tests on Cascade/Ice Lake, or
> some other system for which the 'spectre_v2' sysfs vulnerabilities file
> shows "BHI: SW loop".  On such a system it shouldn't matter whether my
> patch is added as it won't disable Linus' syscall change.  But it would
> be very helpful to see the performance impact of that combination.

The test results on Cascade/Ice Lake are as follows:

Intel Xeon Platinum 8260L (Cascade Lake)
=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/nr_task/mode/test/cpufreq_governor:
  lkp-csl-2sp3/will-it-scale/debian-12-x86_64-20240206.cgz/x86_64-rhel-8.3/gcc-13/16/process/futex4/performance

commit:
  0cd01ac5dcb1 ("x86/bugs: Change commas to semicolons in 'spectre_v2' sysfs file")
  1e3ad78334a6 ("x86/syscall: Don't force use of indirect calls for system calls")
  v6.9-rc4
  v6.9-rc4+v3_patch

    0cd01ac5dcb1                1e3ad78334a6                    v6.9-rc4           v6.9-rc4+v3_patch
---------------- --------------------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \
   3237910            -0.3%    3229309           -10.1%    2911031           -11.0%    2882769        will-it-scale.per_process_ops
  51806565            -0.3%   51668961           -10.1%   46576504           -11.0%   46124311        will-it-scale.workload
      0.02 ±  7%      -6.4%       0.02 ±  3%      -9.5%       0.02 ±  2%      -2.4%       0.02 ± 12%  perf-stat.i.MPKI
 4.649e+09           +17.4%  5.459e+09           +76.1%  8.186e+09           +75.4%  8.156e+09        perf-stat.i.branch-instructions
      0.72            -0.6        0.15 ±  4%      -0.6        0.12            -0.6        0.12 ±  2%  perf-stat.i.branch-miss-rate%
  34188248           -74.0%    8872232 ±  3%     -69.9%   10285664           -70.0%   10244122        perf-stat.i.branch-misses
      1.70            -4.2%       1.63            -8.0%       1.56            -8.3%       1.56        perf-stat.i.cpi
 3.326e+10            +3.6%  3.444e+10            +9.1%  3.628e+10            +8.2%  3.599e+10        perf-stat.i.instructions
      0.59            +4.3%       0.61            +8.7%       0.64            +9.0%       0.64        perf-stat.i.ipc
      0.18 ± 16%     -11.5%       0.16 ± 22%     -33.9%       0.12 ± 46%     -58.6%       0.08 ± 49%  perf-stat.i.major-faults
      0.02 ±  7%      -6.3%       0.02 ±  4%     -11.0%       0.02 ±  3%      -2.3%       0.02 ± 13%  perf-stat.overall.MPKI
      0.74            -0.6        0.16 ±  3%      -0.6        0.13            -0.6        0.13        perf-stat.overall.branch-miss-rate%
      1.70            -4.1%       1.63            -8.0%       1.56            -8.3%       1.56        perf-stat.overall.cpi
      0.59            +4.3%       0.61            +8.7%       0.64            +9.0%       0.64        perf-stat.overall.ipc
    193210            +3.9%     200708           +21.4%     234594           +21.5%     234812        perf-stat.overall.path-length
 4.633e+09           +17.4%  5.441e+09           +76.1%  8.159e+09           +75.4%  8.129e+09        perf-stat.ps.branch-instructions
  34084869           -74.0%    8860998 ±  2%     -69.9%   10274305           -70.0%   10220106        perf-stat.ps.branch-misses
 3.315e+10            +3.6%  3.433e+10            +9.1%  3.616e+10            +8.2%  3.587e+10        perf-stat.ps.instructions
      0.18 ± 16%     -11.5%       0.16 ± 22%     -33.8%       0.12 ± 46%     -58.6%       0.08 ± 49%  perf-stat.ps.major-faults
 1.001e+13            +3.6%  1.037e+13            +9.2%  1.093e+13            +8.2%  1.083e+13        perf-stat.total.instructions
     18.55            -0.3       18.23            -1.1       17.45            -1.1       17.46        perf-profile.calltrace.cycles-pp.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      1.82            -0.1        1.74            -0.2        1.60            -0.2        1.57        perf-profile.calltrace.cycles-pp.futex_q_unlock.futex_wait_setup.__futex_wait.futex_wait.do_futex
      3.58            -0.1        3.51            -0.5        3.11            -0.5        3.11        perf-profile.calltrace.cycles-pp.futex_get_value_locked.futex_wait_setup.__futex_wait.futex_wait.do_futex
     17.39            -0.1       17.32            -1.1       16.32            -1.1       16.30        perf-profile.calltrace.cycles-pp.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      0.68 ±  2%      -0.0        0.66            -0.1        0.60 ±  2%      -0.1        0.60 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.syscall
      2.73            -0.0        2.72            -0.3        2.40            -0.3        2.40        perf-profile.calltrace.cycles-pp.__get_user_nocheck_4.futex_get_value_locked.futex_wait_setup.__futex_wait.futex_wait
      0.60 ±  2%      +0.0        0.60 ±  2%      -0.0        0.57            -0.0        0.59 ±  2%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +0.0        0.00            +6.3        6.26            +6.2        6.22        perf-profile.calltrace.cycles-pp.clear_bhb_loop.syscall
      0.61 ±  2%      +0.0        0.61 ±  2%      -0.0        0.58            -0.0        0.60 ±  2%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
     72.70            +0.0       72.72            +0.1       72.78            +0.1       72.80        perf-profile.calltrace.cycles-pp.syscall
      1.78            +0.0        1.80            -0.2        1.59            -0.2        1.58        perf-profile.calltrace.cycles-pp._raw_spin_lock.futex_q_lock.futex_wait_setup.__futex_wait.futex_wait
     16.67            +0.0       16.71            -1.1       15.61            -1.1       15.59        perf-profile.calltrace.cycles-pp.futex_wait.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.50            +0.0       20.55            -0.5       20.04            -0.5       20.01        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     21.76            +0.0       21.81            -0.5       21.22            -0.5       21.24        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
      2.07            +0.1        2.13            -0.2        1.90            -0.2        1.91        perf-profile.calltrace.cycles-pp.futex_hash.futex_q_lock.futex_wait_setup.__futex_wait.futex_wait
      0.76            +0.1        0.84 ±  3%      -0.0        0.74            -0.0        0.74        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      5.09            +0.1        5.17            -0.5        4.60            -0.5        4.62        perf-profile.calltrace.cycles-pp.futex_q_lock.futex_wait_setup.__futex_wait.futex_wait.do_futex
      7.85            +0.1        7.94            -0.7        7.10            -0.8        7.07        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.syscall
      0.91 ±  2%      +0.1        1.04            +0.0        0.92            +0.0        0.92        perf-profile.calltrace.cycles-pp.get_futex_key.futex_wait_setup.__futex_wait.futex_wait.do_futex
     39.86            +0.2       40.02            -4.4       35.46            -4.4       35.48        perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.syscall
     14.13            +0.2       14.35            -0.9       13.20            -1.0       13.18        perf-profile.calltrace.cycles-pp.__futex_wait.futex_wait.do_futex.__x64_sys_futex.do_syscall_64
     12.44            +0.3       12.70            -1.1       11.33            -1.1       11.34        perf-profile.calltrace.cycles-pp.futex_wait_setup.__futex_wait.futex_wait.do_futex.__x64_sys_futex
     18.62            -0.3       18.30            -1.1       17.57            -1.0       17.58        perf-profile.children.cycles-pp.__x64_sys_futex
     17.59            -0.1       17.46            -1.0       16.54            -1.1       16.52        perf-profile.children.cycles-pp.do_futex
      1.82            -0.1        1.74            -0.2        1.60            -0.2        1.57        perf-profile.children.cycles-pp.futex_q_unlock
      3.19            -0.1        3.13            -0.4        2.77            -0.4        2.77        perf-profile.children.cycles-pp.__get_user_nocheck_4
      0.68 ±  2%      -0.0        0.66            -0.1        0.60 ±  2%      -0.1        0.60 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      3.58            -0.0        3.57            -0.4        3.16            -0.4        3.16        perf-profile.children.cycles-pp.futex_get_value_locked
      0.80            -0.0        0.79 ±  4%      -0.0        0.76 ±  2%      -0.1        0.75 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.81            -0.0        0.80 ±  4%      -0.0        0.77 ±  2%      -0.0        0.76 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.46 ±  2%      -0.0        0.45 ±  5%      -0.0        0.43 ±  2%      -0.0        0.42 ±  4%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.35            -0.0        0.34            -0.0        0.30 ±  3%      -0.0        0.30 ±  2%  perf-profile.children.cycles-pp.testcase
      0.66            -0.0        0.65 ±  4%      -0.0        0.62            -0.0        0.62 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.38 ±  2%      -0.0        0.38 ±  5%      -0.0        0.36            -0.0        0.35 ±  5%  perf-profile.children.cycles-pp.update_process_times
      0.14 ±  5%      -0.0        0.14 ±  5%      -0.0        0.12 ±  4%      -0.0        0.12 ±  5%  perf-profile.children.cycles-pp.amd_clear_divider
      0.00            +0.0        0.00            +6.3        6.32            +6.3        6.29        perf-profile.children.cycles-pp.clear_bhb_loop
      0.28 ±  6%      +0.0        0.28 ±  4%      -0.0        0.25 ±  3%      -0.0        0.24 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.90            +0.0        0.91 ±  3%      -0.1        0.80            -0.1        0.81        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.88            +0.0        1.90 ±  2%      -0.2        1.69            -0.2        1.68        perf-profile.children.cycles-pp._raw_spin_lock
      0.17 ±  4%      +0.0        0.20 ±  2%      -0.1        0.12 ±  3%      -0.1        0.12 ±  7%  perf-profile.children.cycles-pp.futex_setup_timer
     20.64            +0.0       20.69            -0.5       20.18            -0.4       20.21        perf-profile.children.cycles-pp.do_syscall_64
     21.90            +0.0       21.94            -0.5       21.41            -0.5       21.43        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.07            +0.1        2.13            -0.2        1.90            -0.2        1.91        perf-profile.children.cycles-pp.futex_hash
      5.13            +0.1        5.20            -0.5        4.64            -0.5        4.64        perf-profile.children.cycles-pp.entry_SYSCALL_64
     16.84            +0.1       16.91            -1.1       15.73            -1.1       15.71        perf-profile.children.cycles-pp.futex_wait
      5.30            +0.1        5.37            -0.5        4.79            -0.5        4.80        perf-profile.children.cycles-pp.futex_q_lock
      0.91 ±  2%      +0.1        1.05            +0.0        0.92            +0.0        0.92        perf-profile.children.cycles-pp.get_futex_key
     42.79            +0.2       42.98            -4.6       38.15            -4.6       38.18        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
     14.13            +0.2       14.36            -0.9       13.20            -1.0       13.18        perf-profile.children.cycles-pp.__futex_wait
     12.58            +0.3       12.83            -1.1       11.44            -1.1       11.44        perf-profile.children.cycles-pp.futex_wait_setup
      0.00            +0.4        0.41 ±  2%      +0.6        0.56 ±  2%      +0.6        0.58 ±  3%  perf-profile.children.cycles-pp.x64_sys_call
      4.04            -0.3        3.77            -0.7        3.36            -0.7        3.33        perf-profile.self.cycles-pp.syscall
      1.03 ±  2%      -0.3        0.76 ±  2%      -0.0        1.00            -0.0        1.02        perf-profile.self.cycles-pp.__x64_sys_futex
      0.88            -0.3        0.62            +0.0        0.91            +0.0        0.91        perf-profile.self.cycles-pp.do_futex
      2.50            -0.1        2.42            -0.2        2.30            -0.2        2.31        perf-profile.self.cycles-pp.futex_wait
      1.74            -0.1        1.68            -0.2        1.55            -0.2        1.52        perf-profile.self.cycles-pp.futex_q_unlock
      3.18            -0.1        3.12            -0.4        2.76            -0.4        2.76        perf-profile.self.cycles-pp.__get_user_nocheck_4
      0.54            -0.1        0.48 ±  3%      -0.1        0.43            -0.1        0.44 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      1.48            -0.0        1.45 ±  2%      +0.2        1.69 ±  2%      +0.2        1.67        perf-profile.self.cycles-pp.__futex_wait
      0.68 ±  2%      -0.0        0.66            -0.1        0.60 ±  2%      -0.1        0.60 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.35            -0.0        0.34            -0.0        0.30 ±  3%      -0.0        0.30 ±  2%  perf-profile.self.cycles-pp.testcase
      0.00            +0.0        0.00            +6.3        6.26            +6.2        6.22        perf-profile.self.cycles-pp.clear_bhb_loop
      1.33            +0.0        1.33            -0.1        1.23            -0.1        1.22        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.44            +0.0        1.44            -0.1        1.30            -0.1        1.30        perf-profile.self.cycles-pp.futex_q_lock
      1.03            +0.0        1.05 ±  2%      +0.2        1.22            +0.3        1.28        perf-profile.self.cycles-pp.do_syscall_64
      1.80            +0.0        1.84 ±  2%      -0.2        1.62            -0.2        1.62        perf-profile.self.cycles-pp._raw_spin_lock
      2.42            +0.0        2.46            -0.2        2.19            -0.2        2.20        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.38 ±  6%      +0.1        0.44            +0.0        0.38            -0.0        0.38 ±  3%  perf-profile.self.cycles-pp.futex_get_value_locked
      2.00            +0.1        2.06            -0.2        1.83            -0.2        1.84        perf-profile.self.cycles-pp.futex_hash
      0.21 ±  6%      +0.1        0.28 ±  4%      +0.0        0.25 ±  3%      +0.0        0.24 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      1.11 ±  3%      +0.1        1.22 ±  3%      -0.0        1.08 ±  2%      -0.0        1.10        perf-profile.self.cycles-pp.futex_wait_setup
      0.90 ±  2%      +0.1        1.04            +0.0        0.92            +0.0        0.92 ±  2%  perf-profile.self.cycles-pp.get_futex_key
     42.61            +0.2       42.81            -4.6       38.00            -4.6       38.02        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.00            +0.4        0.41 ±  2%      +0.6        0.55 ±  2%      +0.5        0.52 ±  3%  perf-profile.self.cycles-pp.x64_sys_call


Intel Xeon Gold 6346 (Ice Lake)
=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/nr_task/mode/test/cpufreq_governor:
  lkp-icl-2sp9/will-it-scale/debian-12-x86_64-20240206.cgz/x86_64-rhel-8.3/gcc-13/16/process/futex4/performance

commit:                                                                                                                   0cd01ac5dcb1 ("x86/bugs: Change commas to semicolons in 'spectre_v2' sysfs file")                                       1e3ad78334a6 ("x86/syscall: Don't force use of indirect calls for system calls")                                        v6.9-rc4                                                                                                                v6.9-rc4+v3_patch

    0cd01ac5dcb1                1e3ad78334a6                    v6.9-rc4           v6.9-rc4+v3_patch
---------------- --------------------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \
   7907214            -1.8%    7763496           -15.4%    6686457           -15.5%    6678350        will-it-scale.per_process_ops
 1.265e+08            -1.8%  1.242e+08           -15.4%   1.07e+08           -15.5%  1.069e+08        will-it-scale.workload
 1.112e+10           +16.0%   1.29e+10           +67.3%   1.86e+10           +68.0%  1.868e+10        perf-stat.i.branch-instructions
      0.06 ±  2%      -0.0        0.06 ±  2%      -0.0        0.05            -0.0        0.05        perf-stat.i.branch-miss-rate%
   6858604 ±  2%      +0.6%    6900573 ±  2%      +8.4%    7434422            +7.7%    7388238        perf-stat.i.branch-misses
      0.72            -2.0%       0.71            -2.7%       0.70            -2.7%       0.70        perf-stat.i.cpi
 8.004e+10            +2.1%   8.17e+10            +2.8%  8.231e+10            +2.8%  8.232e+10        perf-stat.i.instructions
      1.38            +2.1%       1.41            +2.8%       1.42            +2.8%       1.42        perf-stat.i.ipc
      0.06 ±  2%      -0.0        0.05 ±  2%      -0.0        0.04            -0.0        0.04        perf-stat.overall.branch-miss-rate%
      0.72            -2.0%       0.71            -2.8%       0.70            -2.8%       0.70        perf-stat.overall.cpi
      1.38            +2.1%       1.41            +2.8%       1.42            +2.8%       1.42        perf-stat.overall.ipc
    190470            +3.9%     197929           +21.7%     231786           +21.8%     231973        perf-stat.overall.path-length
 1.108e+10           +16.0%  1.286e+10           +67.3%  1.854e+10           +68.0%  1.862e+10        perf-stat.ps.branch-instructions
   6893534 ±  2%      +0.5%    6924998 ±  2%      +8.3%    7462919            +7.5%    7410265        perf-stat.ps.branch-misses
 7.978e+10            +2.1%  8.143e+10            +2.8%  8.204e+10            +2.8%  8.205e+10        perf-stat.ps.instructions
  2.41e+13            +2.0%  2.459e+13            +2.9%   2.48e+13            +2.9%  2.479e+13        perf-stat.total.instructions
     48.06            -2.8       45.31            -9.9       38.20 ±  3%      -9.1       38.94        perf-profile.calltrace.cycles-pp.__futex_wait.futex_wait.do_futex.__x64_sys_futex.do_syscall_64
     42.93            -2.5       40.41            -8.8       34.12 ±  4%      -8.1       34.84        perf-profile.calltrace.cycles-pp.futex_wait_setup.__futex_wait.futex_wait.do_futex.__x64_sys_futex
     56.45            -2.4       54.10           -12.0       44.44           -11.4       45.05        perf-profile.calltrace.cycles-pp.futex_wait.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe
     58.78            -2.3       56.48           -12.5       46.31           -11.9       46.86        perf-profile.calltrace.cycles-pp.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     61.14            -2.3       58.86           -12.9       48.20           -12.5       48.67        perf-profile.calltrace.cycles-pp.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     71.08            -1.4       69.71           -12.1       58.96           -12.1       58.95        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
     68.07            -1.2       66.88           -11.8       56.28           -11.8       56.26        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     17.13            -1.1       16.06            -3.8       13.38 ±  7%      -2.9       14.20 ±  5%  perf-profile.calltrace.cycles-pp.futex_q_lock.futex_wait_setup.__futex_wait.futex_wait.do_futex
    100.03            -0.8       99.22            -1.0       99.01            -1.4       98.60        perf-profile.calltrace.cycles-pp.syscall
     15.22            -0.8       14.42            -2.7       12.53 ±  5%      -2.7       12.52        perf-profile.calltrace.cycles-pp.futex_get_value_locked.futex_wait_setup.__futex_wait.futex_wait.do_futex
     12.02            -0.6       11.37            -2.1        9.89 ±  6%      -2.1        9.92        perf-profile.calltrace.cycles-pp.__get_user_nocheck_4.futex_get_value_locked.futex_wait_setup.__futex_wait.futex_wait
      3.12 ±  9%      -0.5        2.61            -0.9        2.22 ± 10%      -1.0        2.08 ±  7%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      7.38 ±  2%      -0.4        6.99            -1.9        5.44 ±  5%      -1.6        5.76 ±  5%  perf-profile.calltrace.cycles-pp.futex_hash.futex_q_lock.futex_wait_setup.__futex_wait.futex_wait
      5.12            -0.3        4.78            -0.9        4.20 ± 10%      -0.6        4.47 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock.futex_q_lock.futex_wait_setup.__futex_wait.futex_wait
      4.99 ±  2%      -0.3        4.66            -1.0        4.00 ±  5%      -1.2        3.79 ±  6%  perf-profile.calltrace.cycles-pp.futex_q_unlock.futex_wait_setup.__futex_wait.futex_wait.do_futex
      3.02 ±  3%      -0.2        2.80            -0.9        2.17            -0.8        2.25 ±  3%  perf-profile.calltrace.cycles-pp.get_futex_key.futex_wait_setup.__futex_wait.futex_wait.do_futex
      1.58 ±  3%      -0.1        1.51            -0.3        1.29 ± 10%      -0.4        1.22 ±  7%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.syscall
      0.94 ±  3%      -0.1        0.87            -0.2        0.75 ±  9%      -0.2        0.70 ±  8%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      0.69 ±  3%      -0.0        0.65            -0.2        0.47 ± 46%      -0.3        0.36 ± 71%  perf-profile.calltrace.cycles-pp.amd_clear_divider.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      0.68 ±  3%      -0.0        0.66            -0.3        0.38 ± 71%      -0.2        0.45 ± 45%  perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.syscall
      0.00            +0.0        0.00           +15.2       15.21 ±  2%     +14.8       14.83        perf-profile.calltrace.cycles-pp.clear_bhb_loop.syscall
      1.04 ±  2%      +0.1        1.13 ±  2%      -0.1        0.96 ±  3%      -0.0        1.00 ±  5%  perf-profile.calltrace.cycles-pp.testcase
      1.57            +0.1        1.70            -0.1        1.48 ±  9%      -0.0        1.54 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.syscall
      0.00            +1.3        1.29            +1.6        1.62 ±  8%      +1.3        1.34 ±  4%  perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     16.18            +1.6       17.80            -0.6       15.63 ±  7%      +0.0       16.22 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.syscall
     48.52            -2.8       45.75           -10.0       38.57 ±  2%      -9.2       39.30        perf-profile.children.cycles-pp.__futex_wait
     44.20            -2.6       41.60            -9.1       35.12 ±  3%      -8.4       35.84        perf-profile.children.cycles-pp.futex_wait_setup
     57.11            -2.4       54.75           -12.1       44.98           -11.5       45.58        perf-profile.children.cycles-pp.futex_wait
     59.22            -2.3       56.91           -12.7       46.54           -12.1       47.10        perf-profile.children.cycles-pp.do_futex
     61.79            -2.3       59.51           -13.0       48.74           -12.6       49.19        perf-profile.children.cycles-pp.__x64_sys_futex
     69.05            -1.5       67.59           -12.1       56.90           -12.2       56.85        perf-profile.children.cycles-pp.do_syscall_64
     71.36            -1.4       70.00           -11.9       59.44           -11.9       59.43        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     17.82            -1.1       16.70            -3.9       13.94 ±  7%      -3.0       14.79 ±  5%  perf-profile.children.cycles-pp.futex_q_lock
     14.54            -0.8       13.76            -2.6       11.96 ±  5%      -2.6       11.98        perf-profile.children.cycles-pp.futex_get_value_locked
     13.16            -0.7       12.46            -2.3       10.83 ±  5%      -2.3       10.84        perf-profile.children.cycles-pp.__get_user_nocheck_4
      3.96 ±  3%      -0.5        3.46            -1.0        2.95 ± 10%      -1.2        2.78 ±  7%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      7.61 ±  2%      -0.4        7.21            -2.0        5.62 ±  4%      -1.6        5.96 ±  5%  perf-profile.children.cycles-pp.futex_hash
      5.35            -0.4        5.00            -1.0        4.40 ± 10%      -0.7        4.67 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock
      5.22 ±  2%      -0.3        4.88            -1.0        4.19 ±  5%      -1.3        3.97 ±  6%  perf-profile.children.cycles-pp.futex_q_unlock
      3.26 ±  3%      -0.2        3.02            -0.9        2.35 ±  2%      -0.8        2.44 ±  3%  perf-profile.children.cycles-pp.get_futex_key
     98.50            -0.1       98.40            +0.1       98.60            +0.1       98.55        perf-profile.children.cycles-pp.syscall
      1.81 ±  3%      -0.1        1.73            -0.3        1.47 ± 10%      -0.4        1.40 ±  7%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.17 ±  3%      -0.1        1.09            -0.2        0.94 ±  9%      -0.3        0.87 ±  8%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.93 ±  3%      -0.1        0.86 ±  2%      -0.2        0.73 ± 10%      -0.2        0.70 ±  8%  perf-profile.children.cycles-pp.amd_clear_divider
      0.16 ±  2%      -0.0        0.15            -0.0        0.15 ±  5%      -0.0        0.15 ±  4%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.16 ±  3%      -0.0        0.14 ±  3%      -0.0        0.14 ±  3%      -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.hrtimer_interrupt
      9.15 ±  2%      -0.0        9.14            -1.5        7.65 ±  7%      -1.6        7.54 ±  3%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.65 ±  4%      -0.0        0.64            -0.1        0.54 ±  7%      -0.1        0.54 ±  2%  perf-profile.children.cycles-pp.futex_setup_timer
      0.00            +0.0        0.00           +15.4       15.40 ±  2%     +15.0       15.01        perf-profile.children.cycles-pp.clear_bhb_loop
      0.62 ±  2%      +0.0        0.66 ±  2%      -0.1        0.56 ±  5%      -0.0        0.58 ±  5%  perf-profile.children.cycles-pp.syscall@plt
      1.45            +0.1        1.57            -0.1        1.33 ±  2%      -0.1        1.39 ±  5%  perf-profile.children.cycles-pp.testcase
      1.59            +0.1        1.72            -0.1        1.49 ±  9%      -0.0        1.56 ±  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      9.45            +0.9       10.37            -0.3        9.12 ±  7%      +0.0        9.45 ±  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.00            +1.5        1.51            +1.8        1.81 ±  8%      +1.5        1.51 ±  4%  perf-profile.children.cycles-pp.x64_sys_call
     12.90            -0.7       12.23            -2.3       10.63 ±  5%      -2.3       10.64        perf-profile.self.cycles-pp.__get_user_nocheck_4
      7.38 ±  2%      -0.4        6.99            -1.9        5.43 ±  5%      -1.6        5.76 ±  5%  perf-profile.self.cycles-pp.futex_hash
      5.09            -0.4        4.70            -1.0        4.11 ±  8%      -0.7        4.35 ±  6%  perf-profile.self.cycles-pp.futex_q_lock
      5.11            -0.3        4.78            -0.9        4.21 ± 10%      -0.6        4.47 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock
      4.86 ±  2%      -0.3        4.54            -0.9        3.92 ±  5%      -1.1        3.71 ±  7%  perf-profile.self.cycles-pp.futex_q_unlock
      3.68            -0.2        3.45            -0.1        3.62 ±  9%      -0.1        3.56 ±  7%  perf-profile.self.cycles-pp.do_syscall_64
      3.02 ±  3%      -0.2        2.80            -0.9        2.16 ±  2%      -0.8        2.25 ±  3%  perf-profile.self.cycles-pp.get_futex_key
      4.33 ±  3%      -0.2        4.14            -0.9        3.45 ±  6%      -0.9        3.45 ±  2%  perf-profile.self.cycles-pp.__futex_wait
      4.17            -0.2        3.99 ±  3%      -0.9        3.32            -0.9        3.32        perf-profile.self.cycles-pp.futex_wait_setup
      2.09 ±  3%      -0.2        1.93            -0.4        1.64 ±  9%      -0.5        1.56 ±  7%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      1.39 ±  2%      -0.1        1.29            -0.3        1.13 ±  2%      -0.3        1.12 ±  2%  perf-profile.self.cycles-pp.futex_get_value_locked
      1.81 ±  3%      -0.1        1.73            -0.3        1.47 ± 10%      -0.4        1.40 ±  7%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.94 ±  3%      -0.1        0.88            -0.2        0.75 ± 10%      -0.2        0.70 ±  8%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.46 ±  2%      -0.0        0.43 ±  2%      -0.1        0.37 ± 11%      -0.1        0.34 ±  6%  perf-profile.self.cycles-pp.amd_clear_divider
      0.43 ±  4%      +0.0        0.43 ±  2%      -0.1        0.36 ±  7%      -0.1        0.36 ±  2%  perf-profile.self.cycles-pp.futex_setup_timer
      0.00            +0.0        0.00           +15.2       15.22 ±  2%     +14.8       14.81        perf-profile.self.cycles-pp.clear_bhb_loop
      8.92 ±  2%      +0.0        8.92            -1.4        7.47 ±  7%      -1.6        7.36 ±  2%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.20            +0.0        0.22 ±  3%      -0.0        0.18 ±  8%      -0.0        0.20 ±  7%  perf-profile.self.cycles-pp.syscall@plt
      2.76            +0.0        2.81            -0.4        2.38 ± 10%      -0.5        2.27 ±  7%  perf-profile.self.cycles-pp.__x64_sys_futex
      1.90 ±  3%      +0.0        1.95            -0.7        1.23 ± 11%      -0.7        1.22 ±  8%  perf-profile.self.cycles-pp.do_futex
      2.50 ±  2%      +0.1        2.61            +0.1        2.56 ±  8%      +0.1        2.60 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.24            +0.1        1.35 ±  2%      -0.1        1.14 ±  3%      -0.0        1.19 ±  5%  perf-profile.self.cycles-pp.testcase
      1.59            +0.1        1.72            -0.1        1.49 ±  9%      -0.0        1.56 ±  5%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      2.72            +0.2        2.94 ±  2%      -0.1        2.61 ±  9%      -0.0        2.69 ±  6%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      8.15 ±  3%      +0.4        8.56            -2.0        6.18 ± 10%      -2.1        6.04 ±  3%  perf-profile.self.cycles-pp.futex_wait
     11.95            +1.0       12.92            -1.0       10.97 ±  4%      -0.6       11.35 ±  4%  perf-profile.self.cycles-pp.syscall
      0.00            +1.3        1.30            +1.6        1.62 ±  8%      +1.3        1.33 ±  4%  perf-profile.self.cycles-pp.x64_sys_call


BTW, we did observe some regressions by running other benchmarks on
commit 1e3ad78334a6, but these regressions are on Ice Lake, not Skylake.
Please kindly contact us if you are interested in looking into them.

    stress-ng.null.ops_per_sec -4.0% regression on Intel Xeon Gold 6346 (Ice Lake)
    unixbench.fsbuffer.throughput -1.4% regression on Intel Xeon Gold 6346 (Ice Lake)

Thanks,
Yujie

> 
> [*] https://lkml.kernel.org/lkml/eda0ec65f4612cc66875aaf76e738643f41fbc01.1713296762.git.jpoimboe@kernel.org
> 
> -- 
> Josh
> 

