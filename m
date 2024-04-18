Return-Path: <linux-kernel+bounces-149482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB978A91A8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3D01C20CF8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A57554770;
	Thu, 18 Apr 2024 03:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZDNk3Ua"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0366954BEF;
	Thu, 18 Apr 2024 03:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713411886; cv=fail; b=SH/DWkqlV9JFBE2AtOuupK8CRLpa5AEXG16feAwZqptH4G0L0NIeQOIfkwgEBjUcXARGaUK5X3hS/5kFTfjUbGtO+47nPQ1PXtCjwQvqgtAaQJCTjd8zMHQh1eg2iHBZW21vTxHqWhelBXYPwj6wCfBQwcgOr0K00qt6PwwR6h4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713411886; c=relaxed/simple;
	bh=TVhCRlgFEnJuDpkuK5sY8Y9dUUD+u+GwDfSIyrECGzQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KEq6oMbA1Dej8hTDSN6EZ6jADvtYc1YjVhRNot314FwpWkMA+98JmOr2++u8HeZkOEFJ/F4PpzAyyhxOLaI9Yb+TupZ2/OZ8Qn/cLrhza1E52VIwuR37QdIQTIB55VLfCkaQW7/cEZ8OSc2yKfJB9bFCCLR35VijDM5L62Z7hD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZDNk3Ua; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713411884; x=1744947884;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TVhCRlgFEnJuDpkuK5sY8Y9dUUD+u+GwDfSIyrECGzQ=;
  b=WZDNk3Ua6NEPrCfkcslLH5U9KMDWjho5FyjppvGcJzKxHO7uWTA93CEq
   0fl5swTHePbl4x0V1wPy8aj18UGSz0Nu09ZRHZQrFZdEmaDnpV3VcWsi7
   iO/jhJLT3t3adaz5QlhsVoPCspqzaLubVooaT0Eu2uWreWJ2JQbx2++7V
   l2N/yQGzlImnPCdiJtYDJ0uWlwSXmeqGze6lotxv1GWK1B/fV7n14a+hv
   nR2IVzCbMXDyXoYF3IoJSh4vzdnc3xBKA/0c+SthGu58o6rLWZH35/sM4
   7QED44Sghp9Kvcm4+WCvehpeUEceNagenDnGUEEh8phie5pZgZxx1F1a7
   w==;
X-CSE-ConnectionGUID: ZgliBZy3RGKznRBoqHN3BQ==
X-CSE-MsgGUID: v+9pZyXMSAKScxdBHVlsiQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="19495078"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="19495078"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 20:44:43 -0700
X-CSE-ConnectionGUID: eYYJxri6QCiG1XCKr67HJQ==
X-CSE-MsgGUID: hHrIn20oTpa3cI3WJT5neg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="22717227"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Apr 2024 20:44:43 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 20:44:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 20:44:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 20:44:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 20:44:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/ehggqOlpYvq3bxsDriWb64YvmzHQAIsI9q8jylPfsBICEGe7iuBtLUaXnkEBZE7Q7AZBGNBKhaCznkRwPbRyrITherGmIwxlgLoMDkRerh60UKNv0+mWJnNy4NMVK9NuP3F5punXTCgTN2vKoGhvnf4DlkiiqxEQ9pG0X5W3+lUZCe+kaN5VDxB7oo6/xbsyyxis4h88OXcFOUEYUTnusNpG1lFeiyxcDvZFJLM3w9pYDIW1QtPUMXc9DsS8doi3TUbC3ZInR1BzPXuXiRMq4p3GaQbCGSpBC9jq9/TXEggpTT+8S96ZovrYjwqAoHhJYs3B/ZoucTZqgljxTkbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9zWGSY3PGdLBSUDs53EKlsYwfFULC8cc9015mTwAKg=;
 b=fsm7zyxzcYl4tmjBtOpaP/AdsE7Ir5KUUfXbnf432Dz+3vUwqXXs+lurmuS+51HDFdQmgfADj7N7Rd9hvy7ZtlElcM/8uCPIMBXFFLTZgmPUE1EcYuTHnubPxT72bF5sftT7H81KGCxnzjrGJ2T0a+5s/TfrMAZS9tV0lun+F+9daCZTDnkmYoR8Ol7d9fZA3vM1n1GyjA71EFVXZTh4n3jcOHkaM9/zZEVE3W9oIWyEY4m4OgjOANwa192MIs3FM/tAlNql70TDH5GU32YaaOlxQhF3dZIP9nzkSlpmn00n3PYdjEP3QgTZA0p8gnM0Hvw0YMgN7QVAfNTrapCtqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6738.namprd11.prod.outlook.com (2603:10b6:303:20c::13)
 by DS0PR11MB7560.namprd11.prod.outlook.com (2603:10b6:8:14b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.29; Thu, 18 Apr
 2024 03:44:35 +0000
Received: from MW4PR11MB6738.namprd11.prod.outlook.com
 ([fe80::416d:2690:e006:8f50]) by MW4PR11MB6738.namprd11.prod.outlook.com
 ([fe80::416d:2690:e006:8f50%4]) with mapi id 15.20.7519.010; Thu, 18 Apr 2024
 03:44:35 +0000
Message-ID: <dff8729b-3ab6-4b54-a3b0-60fabf031d62@intel.com>
Date: Thu, 18 Apr 2024 06:44:25 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [BUG] e1000e, scheduling while atomic
To: =?UTF-8?B?SsOpcsO0bWUgQ2FycmV0ZXJv?= <cJ@zougloub.eu>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, PaoloAbeni <pabeni@redhat.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, John Stultz <jstultz@google.com>, StephenBoyd
	<sboyd@kernel.org>, "lifshits, Vitaly" <vitaly.lifshits@intel.com>,
	"Ruinskiy, Dima" <dima.ruinskiy@intel.com>, Hui Wang <hui.wang@canonical.com>
CC: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<linux-kernel@vger.kernel.org>
References: <a7eb665c74b5efb5140e6979759ed243072cb24a.camel@zougloub.eu>
Content-Language: en-US
From: Sasha Neftin <sasha.neftin@intel.com>
In-Reply-To: <a7eb665c74b5efb5140e6979759ed243072cb24a.camel@zougloub.eu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::9)
 To SN7PR11MB6725.namprd11.prod.outlook.com (2603:10b6:806:267::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6738:EE_|DS0PR11MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: f287d7bd-eee5-4f83-970c-08dc5f59dc3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JA+nu86jermLba9lRg3twPgiwYWjKMkhp4DLlLIOt6KruzQiic7BK57pxAT/Bb8FXJEaLjnRDxZ3diFfZF4UrXr2Wt+fTyevYo6kxuQRXcMEAgqsMQrHlTcacmm1c03jgBD6wrVyc0ayCe3cyR/iKs/Rpy/Oa7SR/za0bf7NNll5Dci6QZozZp4/EjGQdsFFoMFNCerBMiW1HMyEgC5HxS69lxbXbE2pV0WqiNonQvS3da9egt07CQLTP3bmDPFQaDPnLT/5jUjU7/RWPEiq7dHpK0nnvxbqDbALluqyG3s2WKDkEU7Dzsi1Azfx8/IloebZShWMrWHgPri+Wv9PoU0Mq2i/ShVlhlV4hqo+i3J1KX19zmiXYwJEfygfszv6HhqNpt+NtmCBxNWGdKlcUmmDyDW6uXBdbbwYmyC/UaDJ+MpsLiwm81uQpjVXgFckb9oTDNR21A0bcA2Tq+/XwridMwVDPYWpvezyQoAvNwcJfYNsW8DwuQgBUtS6v8cAgGB4rfRZsjIft3ULIUbitHaZkDOLnLdqzhqQFnpRf75DY0tiqBnh8wCuIz9bq6aZSP5FKKtTao9Gz50CTD9wVV84stIehnS2aKUIeQrQGC93hIo2cgsu0ddXD20dAPBEJzQAVQvToQal3vq/5yj1L6tRLMAWAE65Bu+9TTKqZUOEHckSO6IdQI3u8obRsL/y8yOW+NKHZf+I07UaajYPxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6738.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVpCVCtZemY3LzRBK0RQOG9wVUhPUkhxbnhNN2I5QzVPVlRIY3Y0V0tMZ1Mz?=
 =?utf-8?B?Wm1GKzFQYkNMRGRTbmlyMnB2QVQzUUswN0RsUHpYTkhieWhKN3VEcDdkRkJZ?=
 =?utf-8?B?Q0FtSGdibEJSVERKUHpVZEI5TElCVVBoLzZHREY1djZxQndTNU1oTjdjNmpj?=
 =?utf-8?B?SW90SHo0MHY0eWN3VHR2aUZGUlp2S0gybkduVG9pNFhlb2dQSTYrdmVpRGMr?=
 =?utf-8?B?dVVZVkhUYWdPa2ZtcWk0SVc5NzRZUEtYR21YazZwSzdLYWlQUFJobUxTS1I1?=
 =?utf-8?B?VHVST1JIdkdQczUwMTRXY0s1aHFlem1LTElZZFhxU1JKUU5WTVo0WWplWUxi?=
 =?utf-8?B?Q1UxbTBCMWd2SnBSdTkrcE9LengwTVRQNHpRWjdqZjdqaERBdTRuSFRiVnZx?=
 =?utf-8?B?MHUrZUFiS2hxbVBLbGt1N2pUaUU1S1JWYzlEdE1OSXA2YWQrNFJsM3oxRlha?=
 =?utf-8?B?a01OV3ppQmdXeEE1VGpBbHA3bmNzdHRhVmY0V3VyT0dDVTg5blFDMk8xV0gz?=
 =?utf-8?B?OHBSRlJCbVdpWHdKMGdkV3R6M2I0RGpKWm0rNmZvL2N5ME0ycG9yb0lSaWli?=
 =?utf-8?B?dWR2SlVzeE9GSTJidEhyaWlPaVFXQzdzUFZJOUIvTEsvREhUbE9QWW9Hbmln?=
 =?utf-8?B?OTdxSW0yNC9SL0FyTDUrV2xENFdXRWVVZFAvY29UUzQvM093aG1ESGJhd05J?=
 =?utf-8?B?OG5TSHVQQktvREQvOEtFYnVMK04vUEpjQStwQWcrUGVTR1ZXWEN4blZCRi9M?=
 =?utf-8?B?dTJVdlNjeUdFdkJlQkZ1WVVGOE1HVnZhdWRabUpVOFF0VnN4bUh1aFVPZFdv?=
 =?utf-8?B?aE04d2RkSzJPeGlrZVpRREQ5amI2RndueXN4cFpEaWEzalRXblVFaUdLQU9G?=
 =?utf-8?B?RlFCYmM1MlpGTnRqeGxkUk02a28zcDRHUk95TmpIS0ZjbjNxOEFZaVJRb1dI?=
 =?utf-8?B?MEcvWWtjNUZ1cUZIU0wvWkNVYU9rTWN1aFMwZ0VoRVhMYjB6TkU3b2lhS0tP?=
 =?utf-8?B?KzJzbWFQelFKNzV2K05qNFMxM0FRcGJhdk9nWUM2T1Z4ZTh2ZkxadXROekk5?=
 =?utf-8?B?N0RVdHNNM2VqZkdaWFhVd284c01iQjh2NkJOd095alptV1M0TWhGZE51UE1I?=
 =?utf-8?B?MTBhWXJtNmQvMXdWWUdkWkVwSWdCNDFCN3czeFNoK0NSWFFuNDI3akdrczRs?=
 =?utf-8?B?WjdSbUlKZ2c1ekl6Rk5ENVlCYmJmbGNmL2VqRzlERXJ3cDV0ZW1nem9nbVJZ?=
 =?utf-8?B?a0tVR2tJM3g0VnRUeFBNYTl6eklrbFJnMDNZYjVPWmVzUE1GQ1lPKzA4Nksr?=
 =?utf-8?B?WENPaFh6YXpCdFhUMDBmVU1Tc0NkNUgydkgvYytLb3ErOUNva1p4U3h4c3NM?=
 =?utf-8?B?dWxYWlB0a3oydVJiaWo3MkFBOTQwK2FPakNQeFNhSTc1VFp4ZXJGL2duL00y?=
 =?utf-8?B?WktBRnU4dnlyTTdybjJkWWxsZ01HVVZWckEvRlFrS01SQ1EyZENaNVNYOHR2?=
 =?utf-8?B?c3NiN25DaUhabS9BZmFhSXQ2UGVlTlpYS21OMHFpcTJCRGRMRWpxMm1aNnRU?=
 =?utf-8?B?bUpaaU9tNytPcGN1dUJxd2xzekt0b1dLaEFjZ3NBV25zUjFiM1o0OGc2cGJW?=
 =?utf-8?B?NkZlS3UvUTJLb2pGYm9HemZSWUJmSnBEdHVNTWJMRVA2SDdYd1VmeFRuRTVt?=
 =?utf-8?B?aDEycjdZeDJYZTFxcnNFamJNV1pHQk9IMFJvY0J5NVJNV2JkOHhZR2RxdUlm?=
 =?utf-8?B?NlFrODNHYUlwZmlnQzFTcjZkSEEzUDA3VnE2UVJiTEF4MWVxWjY4ZDFYRDZD?=
 =?utf-8?B?M0hoRzdVMnlyVFRES3FCWWpWQ2FTekdjMmFzZ0ZwYWdHUjdNa3VkT1MrSzFs?=
 =?utf-8?B?TEZ0TWpzM2NtQkM4eHo3b0Q2MlJUQUlqWnZkYnA5MFNsSCszUGUyZ2ppWXZo?=
 =?utf-8?B?RVF2MUl6d2g0TjZldjlCRUtLNW91UFZkYWJEdW51bFcvb2lpRXc5Z2wvL05X?=
 =?utf-8?B?L3oyWWdiVWoxQXBONlVSbHNrT1hzTkI0dVlaSUpESkR3LzdvUE4ralgxZG1v?=
 =?utf-8?B?b0FxK0lidnpZbWdzcnY4NlFmN2pzc3VXNzB6QlAxUWtjVm5TNlNKTGE1dXFX?=
 =?utf-8?B?RkNLeU1VVUJVdGJyZTM4cTJQSUFOcWxUa2R5UVRkOWNNa3NrQk1xcmd5LzhR?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f287d7bd-eee5-4f83-970c-08dc5f59dc3b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6725.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 03:44:35.0005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQ6TecR5lUdTpjm2BUUcrQeX+SxlIwhwwaAM4EyzQCrExf2GZ5z2O26ejNRbUEoQQ8t5PnQLj+b0GBQRcXAy0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7560
X-OriginatorOrg: intel.com

On 17/04/2024 21:46, Jérôme Carretero wrote:
> Hi,
> 
> 
> I opened https://bugzilla.kernel.org/show_bug.cgi?id=218740 because I'm
> not quite sure the culprit is e1000e or some timer stuff.

Hello Jérôme,

You hit on regression introduced by 6dbdd4de0362 (used the wrong timer 
during code running in atomic contexts)
Please, incorporate 
https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20240417190320.3159360-1-vitaly.lifshits@intel.com/ 
in your latest kernel.

Thanks,
sasha

> 
> I just verified that this happens on the latest master.
> 
> 
> Let me know if I can (quickly) help,
> 
> 


