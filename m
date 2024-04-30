Return-Path: <linux-kernel+bounces-163173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B288B66C2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2341F22FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B41ECF;
	Tue, 30 Apr 2024 00:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NPtmIOcY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D51C161;
	Tue, 30 Apr 2024 00:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714435847; cv=fail; b=PVDMrIbs+SmMHKOIrP79xAitkkXIOG3qhUJP2S+IZ5cqpCd/BlTTUuXRbiQUjuN8Aq3f2YAoXQV1Q2Zt3KiUtgm03AY4FxUKPjSJ/u/aOHarnbKoP2J3jpyEpK36wV2eYgPlfmLq+3WaiFLvJCX77wdZcvDjHElN4uwLUhqPcpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714435847; c=relaxed/simple;
	bh=opJbChBDMeijWq1UftWkUPesb/QlWDEVIRCqU1t7qj0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M/OGBGfpTYmbm+9MAyqVwCC9bIMTlFsKRiO3B6BowgVgzHOA7NG0HlThKmfSNKtvYtpON5xjuqbmMvcoKAYCqLQYaBkZZsE7GWRGlxgNn0V81MMRr31Q0aKyMlZBJoEAzQF0BsTyu8tyvEitSL0MCMLUW6NkdiN3Dw4UvKCkTjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NPtmIOcY; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714435845; x=1745971845;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=opJbChBDMeijWq1UftWkUPesb/QlWDEVIRCqU1t7qj0=;
  b=NPtmIOcY1GoT7G6XPNXRi4urKUl2wo6f8RsHBwhlU1m1npE6dXF8F58C
   TmfjbHRaSNzOgcqjWXKAWaZfiUVcVeCs+QMFQfkm887gGVwrJu+PoPR5j
   RzLFw50nLsdKs+unJceDjyZixaxukmUByBVaP/8b4IegLkgJJ7xb6QskH
   3SeUbIcxbGczKydE/a+4gdnxFofOGY8xmPaP/+H6nXrd6Jzam9IAAlTfs
   kWRKzWx7VXt9txmpZW84fxC8uuuZ0hTj+qofVyy2eI4Yehy3BNyHL+tsM
   fjVFJqaa8rJw2K2mx2FIpHzPFZq695o44vNDdpsoHm/CTTzCfc1UqP+vh
   Q==;
X-CSE-ConnectionGUID: JrF7PwQFQHyQuqvMV66UKw==
X-CSE-MsgGUID: X0ThxGNGRQGg3CZeaaFO6w==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="13911215"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="13911215"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 17:10:44 -0700
X-CSE-ConnectionGUID: odkBVJ+8Tyq65hhrw4Eghg==
X-CSE-MsgGUID: hDAY5D+3Qlu9r1y3FYwo2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="30727989"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 17:10:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 17:10:43 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 17:10:43 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 17:10:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lh1QkId7hvUapA5HjpkQzFxi1FfH+jvE+TtmjJLrvQnIQ3Xj8gF1ssaMG8pc1xi0LPn1F8kIvnZ4zgMQHn/4x68f/1rG/OjN0/wnroCOZybxEtZCZEpRpdYqOeAHcEdP9nF6QyKdHNuoNiWyFTCX5x7JFr6w96tmHCOzrUYm/mo7wEo3V/Z9GhCJaG3iUE9a9yyIG0g0yeMyVNadguBJR643G/TxAdFSso/kGLBMGeo4K92boGsoBekcRag/Qdh2EtDS2R/dhkymSaYs0y3yiemT4GKhWL7M5EBnMEvIruZhcZ5JcHCb1/XElRPUnO39YAHBhH+KAWcz634wdEDtcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kw/qt/10Lo06duWq9S1hma/aoFonJsztYC2q/agMhnE=;
 b=WjRI62WXL8gscynpyaOcMwrCszkadAtuI8vBTzK1oRDJspNM2D8Lr4fDpH/yq97eazAIzYhFBqXHg4ZceC6/wBoPZ4Xt6LKfslUhwC2sLoKao3fMWgMy5MQhayB84Do7dd5sn8T+sUB6OtJpek861XLsIMluybpT4DTHcUcm1qJUPMnfqI63HSDay3QPh98wToNoLdwqgbePyibWacIp2jbSeUhYROBZFNMSVmawi2JN75WGmrbOfs7Kforz8rAwcmT+LTAkO6mSSatjxhumeHdPrV8DnBU2RMlatAFdd/v4Y/2ZGbidMcYbJh8EOqR1qQZ8RJugwOXGOSSLnIBsfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6883.namprd11.prod.outlook.com (2603:10b6:510:202::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Tue, 30 Apr
 2024 00:10:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 00:10:33 +0000
Date: Mon, 29 Apr 2024 17:10:31 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dongsheng Yang <dongsheng.yang@easystack.cn>, Dan Williams
	<dan.j.williams@intel.com>, <axboe@kernel.dk>, John Groves <John@groves.net>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Dongsheng Yang <dongsheng.yang.linux@gmail.com>
Subject: Re: [PATCH RFC 0/7] block: Introduce CBD (CXL Block Device)
Message-ID: <663036f72b643_148729418@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240422071606.52637-1-dongsheng.yang@easystack.cn>
 <66288ac38b770_a96f294c6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ef34808b-d25d-c953-3407-aa833ad58e61@easystack.cn>
 <66294a9a8e9a8_b6e02947d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <539c1323-68f9-d753-a102-692b69049c20@easystack.cn>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <539c1323-68f9-d753-a102-692b69049c20@easystack.cn>
X-ClientProxiedBy: MW4PR03CA0296.namprd03.prod.outlook.com
 (2603:10b6:303:b5::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6883:EE_
X-MS-Office365-Filtering-Correlation-Id: af90842d-1233-437d-f402-08dc68a9f42e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWorV2dxS0hmcGxvZFFoQlF3Qzk5SEM3RHUrK2dMeDlmUlhnY0VaQzhvb0JP?=
 =?utf-8?B?aWgyVmVIUUZJWkRXMERzS1YvQlNiWGNZQ00xcFlKMndOY0RreEZ6TWtodVVs?=
 =?utf-8?B?ckE2SGlPK2tzcEVBMmFoOWJ2R3JocnpiVlp4U0lLajlRak5vRlRHaisvcmVJ?=
 =?utf-8?B?SGpqbEFxZ2x5UmhONzg0bEdCa2hzTGk1eDdKczZDYlF2cUM5Vk5ocSt6UFE3?=
 =?utf-8?B?UGhxN3pYRG5tdG02TXdXTXNYZk1LTk1HYnU2VWsrUVlDb0V4Smc5cUcvVHpE?=
 =?utf-8?B?QncvaWUwcDJnSDVqRFhjSTNVQmpkdzNiVGdoMko2M21rYUFVVXRlcndtaVFP?=
 =?utf-8?B?OHMzMms4MnpEWVJYaHlmcFZCTGswb21PcEFWV0R0QUsyVGdZeVgrZk9ua0V6?=
 =?utf-8?B?WG05NlVuSGZxdlB4M1lLNUs3RnlDRlp0SjJjeFVwRWJKbkJUNWl4NmdKcnIv?=
 =?utf-8?B?QTNIeDFVLzJxbUpKUllGbkdZUzhBZHJoZmdud0tPeHRJZmNsOGlybndIdTNK?=
 =?utf-8?B?OE1tbC9vMlYycDd0eFl2dVpibTU5TjdzMnRUWENpT2Q4TGN3SXM0aXEyQ3Rz?=
 =?utf-8?B?bnFUcUFaT0hkWnNYeFlVOW5RWHIveW45VStnOGRUNmcwc2tQcnZhTFEzc0JT?=
 =?utf-8?B?cVZDdEZkdXZ3L0hNRHRkVUVIdnhNc2xLRGdJMGo3VkM3V0dpKzBQWG1lZkRw?=
 =?utf-8?B?OFAwYTRhZzE0ODB5NXpVU1FoYzZqcWR6RXVwYUcrSlp5U1lZaUcvbm42OTF4?=
 =?utf-8?B?V3c5Mk9EdEZyWTJLbmxGakg4OGR1aFNiY3B6WmoveVVybXAvb2pGc21vdkVE?=
 =?utf-8?B?OXZveGJJdG5GcE1BQ2RwU3dnTmJjZGVsL2xxWUxGM3d3SEluamhQclF6ckdW?=
 =?utf-8?B?ak1oSUhZbk9QZDF5am9iYnIvd3d1MWxwTmF3VEpvb3lFOUpKV3V4aWJpbUFC?=
 =?utf-8?B?OWRDaGl0cjd4ZmRnekdCWkpmV3FYRkl6MGhoVE1RTzV4THI0Z3oxY3BxVjBV?=
 =?utf-8?B?OVJnRjR2UUlhdHpSU3NXZU1uamhUNGtFM3RiMnhBZnZOQW9uMFFoYmdVL2F4?=
 =?utf-8?B?MGZQS0JVU09RUW9DK2IyeWxzTnJyY2svWlc2clpNTFBYcXNJaHRXcmJBNkRN?=
 =?utf-8?B?REQxTzU1b0lzTjJKdXNnR2V2Ri9BeGJ0NC9yWm1tclNxMXE3VExGaG03ZUs4?=
 =?utf-8?B?VVN5U0ZtODN0OWorMzE3TW05aG1YcEROaDJQcHNpd2ZqTUc4TDNDU1g2elhV?=
 =?utf-8?B?VzFZMGJkekZlQlhxcEltMGdwTDhsVGpJQnB4VW1wRUNqUDB0K2IzeHA2SGYx?=
 =?utf-8?B?bk9Id1ZzUDFiVFFkSHdoNWRySHlQczRtYWkvTFRKYzJqZzk3NFI3c3dxNkln?=
 =?utf-8?B?RERTWFlWYytNUkFDTkFSSnpwYkJrcDVkMVEvb1ErRjdvZjdlaSttV0RmRlhN?=
 =?utf-8?B?NytPK3pBTm5DTUVsbHVBVHZ4bkFUeDZHM1F4TW5za3ZsRmNEV1ZaUE11UG9v?=
 =?utf-8?B?eTBSR1JrbmZld3B4Nk13dlVxcUM1ZXMvcW9XWVNMODdZSENuVDFHR3VzN2RP?=
 =?utf-8?B?cVgrWEU2c1hFNSs0QlAvRmxpbEFjb0tlRVd1UjRlUTByTkZoZ3pib0p1ekJV?=
 =?utf-8?B?bjFBS1I4UHZMc0RGRmhQQWJIMFhuMWNIMytPM2tDMm91dzhMeGh1N1FYRTNr?=
 =?utf-8?B?OG4yTVlUS0lpMWdEZk9haG1OU2dPcHN4cWk4VG4vR042TUFFdU02S1RnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWE1SVhPbC85UFpqRE9qN2MxV20wL0I0dEFkR3BIQU1XRFUwanE5WmpabzBq?=
 =?utf-8?B?V2ovNjZRY21RdGVQRmJ5ZmRHNzJtWUpOL0Z5VlJIZFFtRFhDdkRMRUhHSU82?=
 =?utf-8?B?Nnlrb0JBY0RzdWp0bzZTMEtxMVlnc3hYRC9UMVkrUks4T3ZDNDJ1bkVCazZ6?=
 =?utf-8?B?TWNuQkVvVERxSzYvR3hPbVhUY2JKMVhFLzhZQzlYdDBEby9HYW9NU1VFMTU2?=
 =?utf-8?B?ZnhvdnljZGVPNTIvY0JFRmV0bnZUNjQ1S3FpMG5oK2VtdjUvOXZZNG15S0F4?=
 =?utf-8?B?UUFyUHAxUUd1TllYUC9DRDFmRkV3ckJlQ051KzRvNXhsbllKN2tweEF5UlY5?=
 =?utf-8?B?aFYreHBmMXVJd2N6OXlwUDgzeDZra2ZvQWErZEZTQVFjcWFXQTlpODBaNE14?=
 =?utf-8?B?TGJnS203WnFwTkErOExOdmJhODRVR1FZN1RGTCthajhGeGpaYzJ2MXZ2aDVB?=
 =?utf-8?B?WHlEZTlSbWhZbG14dHZMUVVYUmUzWi9jUXhLajVYeFdUUEpxQTMrdVBHcldX?=
 =?utf-8?B?OUtnL25JN0d5N3EzcWYzUEJ4ckR6SUU1Q0NKSlZYSVloRm5OSzRuRllOeS9y?=
 =?utf-8?B?RFk2TThWSVBsWFM1WkpKd2NXZC9aaEpka0hJWnM2Z3dEZWJJRkhpS2FiWFd3?=
 =?utf-8?B?UEVuSW5rMDF4K0lXNEtpeFBvZWNmRURPdDNmdkxodDR4V2VLUDFjWVN0MjRV?=
 =?utf-8?B?Nk0reGNmYnFRZEhjRHhyWjh0NVBpSlVkQTNHZURzMzVyUkFNcG9iS3YyRUFY?=
 =?utf-8?B?eEpyVWg3bUhuSnRCREVIbUxGeWhBSVowb0cwRHdmaXh1bzhwdnZtTVZOUGMz?=
 =?utf-8?B?Z2NWZlV5YmdweGs3dXRkdWtpdnZ2emUwY21yTGVyaXNjYk5VdjVjMlZwdjR5?=
 =?utf-8?B?eGoxNmRyT1pJeDRGSnNBb0p4MUJMaXNTbHNsV3RQR0tSV2d0Z3RXTzhQNUs0?=
 =?utf-8?B?VzNGT1pBWVVrZXl2bGxuSTFKRUpVSGlaREFyVXMvRVdvWjJhK1p1bU5vUDJK?=
 =?utf-8?B?UnA0T2FhRGhNS3MwTW83d0dCbWlDUWQxUVp0WnBwd3hEb3JuS085ejloZlM3?=
 =?utf-8?B?QktSMDNpLzZlZmkydHZiQUg4YXVTYURUVERuZTcyWEF1eDVIeXVPVmErVjBB?=
 =?utf-8?B?TDFtRGppVHZQUWVITTZicWFlMXRhUWJSNFBrVHU3bnpQZ21jZFZDQnA5OFpJ?=
 =?utf-8?B?SkQrOUM2K2p2YWRwZHZVQVRCbEtield3NkNYUXVMTk92eE1iMGlKOXFnNjhD?=
 =?utf-8?B?ZW9Kd3JoNzYzN2tYd3NGS2N0c1RDbGxxS1R1elorN1I0cEJqT1AyV3dIL09L?=
 =?utf-8?B?emJCUU1HSm9Nd3FDblE5eDBBbGYzZW45M1FhMTdQWElzYlBpTXhHMGFUd1hG?=
 =?utf-8?B?V2x5WEZocm5pZHM3b2pkOVdEcGV6Z3k3dFJ3RjZVYk1mOUZ3OXQxdkEyZ0Vo?=
 =?utf-8?B?QndXRGpDaSs3dnMxZjFuclZoTmxMUHhmc0pBYzZPd1VqOEFEa0FBWGtvbTg4?=
 =?utf-8?B?Q0pRNWRJdEl2cDA0VUpKZWsycVJHVXM3U3k3RzRBZndxYlVQdkw4elhicito?=
 =?utf-8?B?WGtZN05jekJhKzROeTdOMytYeENHTVBGeG1PbFBDVzdaM1ZwdDYzb0h4QzVp?=
 =?utf-8?B?anRySTBiSmhlOUFiN1poRXVOd1FBQXJOdzdTSXRXQ20wQzJjNnJxaklYNUF2?=
 =?utf-8?B?MmJMSHovSU15cmg5elkwMjh2TVhwRHVFajdObTZ0bmZXRlRjL05sOXAwZGlG?=
 =?utf-8?B?SXBKZkVlR204bGdsTUZjZG83TFl0QUR4VHpCSjJ6YmVEMGwyMmlvYzdPTSt4?=
 =?utf-8?B?Y1R4SXRpN2FkbStiQ3VLV1Z3MVR2eHNDVURxTkk3dW80a3Jpazc5czdvNDN2?=
 =?utf-8?B?Rmp5RXBOS2pnN3l3WG45MVBJa1F4MXI4dk1jaVVrYXlWYUYxSG11SUlYcGds?=
 =?utf-8?B?Y0FvM3NJekUzYTJtQXluN1N4RXllb3ZIYzNyVkl1dXhqaXRtMWVZc3YxOHZC?=
 =?utf-8?B?VkhhY09mKzYvV2ZJUEhRZWRmVytZcUlEcVovR0Z4ZkkxYmNEbjNuSEJEREQv?=
 =?utf-8?B?UnlqRjNPbnBkRzJvL1AyK0EzYytXcGYyK0UrQStSWnNWTEdUSk5Ec21wNUdZ?=
 =?utf-8?B?TUJwc0dJcVJyMXZEaVRsWEJOczBZNWpydkljOXVaSEtvbm5sUk9HMFFLV2t1?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af90842d-1233-437d-f402-08dc68a9f42e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 00:10:33.7228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RkQfMpOs/AwSCjXm3DiSZXzmYyNih8DiI1fm3fQ7UvA+Bka5/+oSfmDSPnRcBeY9nnfys8ReFaYWKKRNee4IF3ziMIlsGUhVILXIEcTs6M8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6883
X-OriginatorOrg: intel.com

Dongsheng Yang wrote:
> 
> 
> 在 2024/4/25 星期四 上午 2:08, Dan Williams 写道:
> > Dongsheng Yang wrote:
> >>
> >>
> >> 在 2024/4/24 星期三 下午 12:29, Dan Williams 写道:
> >>> Dongsheng Yang wrote:
> >>>> From: Dongsheng Yang <dongsheng.yang.linux@gmail.com>
> >>>>
> >>>> Hi all,
> >>>> 	This patchset introduce cbd (CXL block device). It's based on linux 6.8, and available at:
> >>>> 	https://github.com/DataTravelGuide/linux
> >>>>
> >>> [..]
> >>>> (4) dax is not supported yet:
> >>>> 	same with famfs, dax device is not supported here, because dax device does not support
> >>>> dev_dax_iomap so far. Once dev_dax_iomap is supported, CBD can easily support DAX mode.
> >>>
> >>> I am glad that famfs is mentioned here, it demonstrates you know about
> >>> it. However, unfortunately this cover letter does not offer any analysis
> >>> of *why* the Linux project should consider this additional approach to
> >>> the inter-host shared-memory enabling problem.
> >>>
> >>> To be clear I am neutral at best on some of the initiatives around CXL
> >>> memory sharing vs pooling, but famfs at least jettisons block-devices
> >>> and gets closer to a purpose-built memory semantic.
> >>>
> >>> So my primary question is why would Linux need both famfs and cbd? I am
> >>> sure famfs would love feedback and help vs developing competing efforts.
> >>
> >> Hi,
> >> 	Thanks for your reply, IIUC about FAMfs, the data in famfs is stored in
> >> shared memory, and related nodes can share the data inside this file
> >> system; whereas cbd does not store data in shared memory, it uses shared
> >> memory as a channel for data transmission, and the actual data is stored
> >> in the backend block device of remote nodes. In cbd, shared memory works
> >> more like network to connect different hosts.
> >>
> >> That is to say, in my view, FAMfs and cbd do not conflict at all; they
> >> meet different scenario requirements. cbd simply uses shared memory to
> >> transmit data, shared memory plays the role of a data transmission
> >> channel, while in FAMfs, shared memory serves as a data store role.
> > 
> > If shared memory is just a communication transport then a block-device
> > abstraction does not seem a proper fit. From the above description this
> > sounds similar to what CONFIG_NTB_TRANSPORT offers which is a way for
> > two hosts to communicate over a shared memory channel.
> > 
> > So, I am not really looking for an analysis of famfs vs CBD I am looking
> > for CBD to clarify why Linux should consider it, and why the
> > architecture is fit for purpose.
> 
> Let me explain why we need cbd:
> 
> In cloud storage scenarios, we often need to expose block devices of 
> storage nodes to compute nodes. We have options like nbd, iscsi, nvmeof, 
> etc., but these all communicate over the network. cbd aims to address 
> the same scenario but using shared memory for data transfer instead of 
> the network, aiming for better performance and reduced network latency.
> 
> Furthermore, shared memory can not only transfer data but also implement 
> features like write-ahead logging (WAL) or read/write cache, further 
> improving performance, especially latency-sensitive business scenarios. 
> (If I understand correctly, this might not be achievable with the 
> previously mentioned ntb.)
> 
> To ensure we have a common understanding, I'd like to clarify one point: 
> the /dev/cbdX block device is not an abstraction of shared memory; it is 
> a mapping of a block device (such as /dev/sda) on the remote host. 
> Reading/writing to /dev/cbdX is equivalent to reading/writing to 
> /dev/sda on the remote host.
> 
> This is the design intention of cbd. I hope this clarifies things.

I does, thanks for the clarification. Let me go back and take a another
look now that I undertand that this is a "remote storage target over CXL
memory" solution.

