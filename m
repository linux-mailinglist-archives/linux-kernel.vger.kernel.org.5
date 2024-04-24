Return-Path: <linux-kernel+bounces-156777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A8B8B0801
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0567C1F2146B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B40715A4AA;
	Wed, 24 Apr 2024 11:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dy1mFqOz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78814142900;
	Wed, 24 Apr 2024 11:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713956800; cv=fail; b=jd/TvKr3zG8AiRIXiLKsL8GMTunIhbKdkL2kqzq7GUMkeRTHVvkqWla21j48mwVRFD+i7EIxgCswKR+WQQEUWVYgJYtT/hwrl8T7ae/FFIC+SDLmviF3lYOzktgwhI4SJ1bnHYhy3sqZAO2Ld3SSYS7hzKg7+U4H2Hi6MZckwOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713956800; c=relaxed/simple;
	bh=SfrY0MzDGC7dY2cW6Dx2E9fCw/qha4TZYb/NHPhg36Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GnrxFXEliUR0ykeAtH+OBHW35oBer6U6lduv9EUy21OuyUVBPX1hBBdt3XnVOmdQIkCW3+w8HRLu23Nhkmko3zes+I+uSn41LEqBjnfWW73LnStool9j31JudPt5iQMkSp3/ahBeDydISvNsmIpio/TN8RfwswhcqFblbTKpIDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dy1mFqOz; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713956798; x=1745492798;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SfrY0MzDGC7dY2cW6Dx2E9fCw/qha4TZYb/NHPhg36Y=;
  b=Dy1mFqOz8TAI8HlPXh+3q37CmSJREnnbLGDLZ0arTxjagYpNL6xmnjWB
   PPm9ULHR+JjX6NMj5Wm1Vph5KDIZeU0g/qlBSMoRpAOIMexbkBusNe0nk
   xZWZF1gFZOyZdeD7sIpI6DROabGGCcL885EFGLJygNaxuZPLbrN64zqL1
   GCIcCJq4KXkzxavYsc1QuUVNc90QS1f48sN5dcFz3fnyvT3pZ8bjpEBdY
   XM9wGlr1fvxJLgwq8zv4FumLhb15NAI57JiLKi8SGOQVl+e7IX0VJYAr+
   4jRKA2+padzMIfZDYE52NAkT3GIANvTkbNNxjG5u5iYKnn22U2cIjcgwh
   Q==;
X-CSE-ConnectionGUID: 1ZC15d51RnqBL3NytTLPug==
X-CSE-MsgGUID: BIbV2drUT1yuqpz7XVq1QQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="13368422"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="13368422"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 04:06:37 -0700
X-CSE-ConnectionGUID: 9v2R4nzgQVWb2m7aniOK8A==
X-CSE-MsgGUID: eUXBTgqNSqm8Mem3sxcSsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="24721230"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 04:06:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 04:06:36 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 04:06:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 04:06:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 04:06:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpRde6RwuRHd5eFO4tyjuDcQL8Fyj4FsosHlmogJ0xcPfu/GmWVEiCGvILIxzHsdsgxq0Hua0W7z5G4sOthDOewYTyl0yltQv5MEfP3HuVky9gkLvMcvVteugLq77scDFV3CcvhNo0lJNKGsh2t+7FA919IIpajumb4ldBpajNAvF0P3HeCsJZBO1FciwYxw0HfkNvkOo7RrM7/C0GgbR7DQI/jRPvGglhjDUleb5l2mZv5Uxmrw9P/rhoHdNw00p6G4zI0za084iCkN2QhB8/ySro3iopeb6RiIMqHQHoalA9eoGn/W3kmfUDq4dOuMhPrbFWQZcJdKIvbOLAAqyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=In3SU6vL/TErXQqpkh8DAtDt0GNiL93RQymfs6yIETk=;
 b=KMu6kRDiGHfp5ZJjxPkabmIeB4/ry/ihNntEPxOlN+x0MBALWUNbs/IlWGDlKufh4XUteGOtPcwB3MoJ+1W5GrfR1Hq20WxxHLjZ5sUBwKI7IyVTOHK8elrZUWfHR7jZpuh/9pKNOSnjuf4gyPrS5Znu+lhwxRtOcpfPH/j+ZKpFFaGOLYdEiatinhnK6JHSyGtZtOUw2/O14X3YDt+U/RtTHRMZj7CXc9+HR7mpluavVWMuSnqLu84hpgZqNUPveW1A8S7p6aze/VZPfi0n06Bj8p5OU3VJH3YUXaXEdObdR+PDcwzoSZTECEwGp+3KeJc6MIYRiAkixKV2jsbA2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MN6PR11MB8172.namprd11.prod.outlook.com (2603:10b6:208:478::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Wed, 24 Apr
 2024 11:06:32 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 11:06:32 +0000
Message-ID: <8cb7f43e-0ee9-423d-ad27-93b3c69809f5@intel.com>
Date: Wed, 24 Apr 2024 13:06:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
To: Yuntao Liu <liuyuntao12@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-kbuild@vger.kernel.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <masahiroy@kernel.org>,
	<nathan@kernel.org>, <nicolas@fjasle.eu>, <peterz@infradead.org>,
	<jpoimboe@kernel.org>, <leitao@debian.org>, <petr.pavlu@suse.com>,
	<richard.weiyang@gmail.com>, <ruanjinjie@huawei.com>,
	<ndesaulniers@google.com>, <jgross@suse.com>
References: <20240422060556.1226848-1-liuyuntao12@huawei.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240422060556.1226848-1-liuyuntao12@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P195CA0023.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::7) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MN6PR11MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: ec0a9944-201c-4ba0-f2e9-08dc644e996c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkNHY2xOQlBtbHFocFV6K29NUTdhQnlrYmFFYk5tSnRKbm8xLzBwWW9UUDlu?=
 =?utf-8?B?Y2srRGo5ejJ6Mk16SWdKM1FOOWdPb2dyL01uSU5ZNmN0Y0ltejFZSlh1QTRK?=
 =?utf-8?B?VTJ4L1FUYlMvYkJFSGVMN2QxYzRQVWxiQmd6dStCaTErYlF6c3pDUk1Va1Yz?=
 =?utf-8?B?VWhseTFqSkV5N3lFWU5ib0FOTGdlWjBYSXRZeWFSQUI1WTNGTlArU3FRRUlz?=
 =?utf-8?B?Z3FrZFh1bkVMSHUwSHNpMUZrWEhZcDYxeGdXRGFVU0tVS2kvTFdwdTR6ekcw?=
 =?utf-8?B?UUtRM3RvZjR5WjlwNSt6bkJtL3lKMDU2WUNLQUpHRWQrUnpYZWpudElrbUVI?=
 =?utf-8?B?YTZrNk1PYWJaREtNdjUvUkxLOFJMTDdWbjZuZnVIakFBOCs2bHI3d1Fpd1pU?=
 =?utf-8?B?bkJ2dVNqaTFiVlNnQndYTzFZWHpqS0p2a2dmQUM3dlVqdStoNzI1OWozQURw?=
 =?utf-8?B?RGpOQXlpVklheVpRaENZdThWYlZ3Y2RRRFlQNmprN3Uwdm1jVGFSNEo2MGNt?=
 =?utf-8?B?bExOb1plNEhseW0vSE9UZ2NWRkhwMzM2Sm5pb1pDRHBsNzdVQUsvYjU1ZlRJ?=
 =?utf-8?B?Zkg5cGN5cFJ6U2xlTFF6bTRGVWdLL0RuQ01wSHlCSzBVSGEzZElkajVZdGgw?=
 =?utf-8?B?cmZENTUzbWRFR0x5dkF1MHJvT2g1dDlETklXRmZ1Z3dMTHVldytVTlA2OXd4?=
 =?utf-8?B?dnRuTUlWbGhVbEpVL1JjeUVMbHYvZjlYY0d5M1d1ZlpLUnJyWVhzcEJmdElw?=
 =?utf-8?B?SGEvSkNYNk1RMTBaWjR3TXRvelJpcHJRSEFIVkc3TU9XQ0xXVG13N3BBYnhC?=
 =?utf-8?B?ZDZUWWVPQmNKOW5TQlFnZXMrRTlhVmNmV0M3QkV0WHY2d3k5ckV4T01XZytm?=
 =?utf-8?B?T1FOTk83bUFEQ3RjQ2YvQ25xKzJnSWI4QjhBUWlBRkZhY0ZrckZLZUVWZmJ5?=
 =?utf-8?B?MW1FZUdFSzVodit2V2ZMSGdQbnFwWURaTngzMjlhbkMyS2JlcDV4K2tEcjRq?=
 =?utf-8?B?Z2dxZ0xRY0I1bkFFdEFPZmg3TGVKdEgrZ2F0NVZkZ3U2bGVqekxSQ3RIOUt0?=
 =?utf-8?B?MlhHNmNqZnRVT2gxZHlxVTQ1OGErMjRMNTNEUjJ3WVpIb2ZiVVV0MnpsaWpD?=
 =?utf-8?B?SVZOUk5xUVhyeVZHSTVmVmRqQUk1cm8wdUpXM0RpS2pudUNDQjBjMTdKWEt1?=
 =?utf-8?B?SHhzU0JPVHV2TGZ1emwwYktkTDduME9iVHlSUnZ2TmEwcEh4bkQ4ZFhBSWNx?=
 =?utf-8?B?TTk0T0hxL0VKS1BjM1l0RWlab21HMTF4YWgreWVFT3hHd3A2TnA1Z1NHOHN0?=
 =?utf-8?B?Z3VjTmVUOCtkZ2dxM0o3T2Q4SnVnN3pScWx1QTArcmR0WEV0MmpxM20zanhZ?=
 =?utf-8?B?azRwWDhyQ25HbXZOaFhYZlJJRkRCOTNLQ0FrT1l2WmpjRXd5bmZ0dDhKWGd3?=
 =?utf-8?B?YW5HRm1abmVnVUdZaDc5SVp5TDZ0QWRKSnVJY21FSUtaUEpMM0l2Y1ZNWmE2?=
 =?utf-8?B?MVpPQlRnMkwwemtqUTNFSUpiaWNnVHdUbXVRbmlkVlhIb2t4bENwWHNwanl3?=
 =?utf-8?B?UUVqbHdoY0dMaElmUnFnUk1aMUczanA3WmZCbWlqaVAvREQ3ZVdWcFRXWE1E?=
 =?utf-8?B?cEpjY3lJdmJ6aG1MbDMyN24vSTlwMytzb2N3cjRLY0t2bnlYa3FUemdRemFy?=
 =?utf-8?B?ZVRFVGQ0U2tqUUJTTEJ1RkcvdzFtUnYrRk5OSUV4RTN6YzU1bzc3MXp3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTIzd2NaU2NPUGxqY01pV3pRM0c2Q09JVG9aOGo5SnJMOVRTUm9NTjlTS2tT?=
 =?utf-8?B?d2xvNDhVQmhFaXJ2SHAwWWxqb0RaUjhtU0tVTlMwL2F4Rm4wNkdvSVpMOTFu?=
 =?utf-8?B?SVFqUmplUjQ5SjV5K3RXVE05TEFYeU1zbXZoVENVZU5xZVNza2p0QVpFM0xz?=
 =?utf-8?B?TGJWTGo5Wmh1UnhEN1l6THUwUko3WUd3bEdiZlJmNmZYK3FtbVZEWDZRaVlG?=
 =?utf-8?B?T1JheXJmUjRub29mME40YXgyTW9RRFJKaUVxVTFqUmhZR3NVb0VyaTAwV05M?=
 =?utf-8?B?M2U4bTR3SVhBNWxjVWNlWlo4M0FYaWt3azNVRTNWcTFGMGh2STltcVFlRFBi?=
 =?utf-8?B?Y3pBRzhBYzk2RkFZb01rVDdRM0hqOFNFK3ltY2xXM2hTMTlQamNZNGxhaGJw?=
 =?utf-8?B?eHZXZ3hma3ROSzZSVTVDV0g3TnVQajJiZ0Vod1cveVhOYXQwdmI0UTRvOWhU?=
 =?utf-8?B?SlhuTlJmbytUQXlBTXVzcWhDc1VjNlF0TGJBYXF2MllYRGtKVWc5aDFuTWNK?=
 =?utf-8?B?aU5Ea2FnNHZuWkxQZUdMV01ob0hUOHFmaWNDenJ0aW9uQXpVdVZ5YmQrSGhZ?=
 =?utf-8?B?aVRGUi8wdlAxcWVnM0ZYUGF0SXBPZ1YvZVorV2h5RHBVKzdYRmxCYi93WG5w?=
 =?utf-8?B?UXBNdzMyTkVpcFVKclhOM3pCVkhKQ2dBMGk4RDFNUHpiMGVlbFZDcGZLanUv?=
 =?utf-8?B?dWx1Y3VISXhvV2x5Q1NGN21QdWNOd1ZweGpUVWtkZUNpYmxKdU43eWdtR3B3?=
 =?utf-8?B?MG5yYnN3ZmJjNkt3c3Q5RTBzRGQ0ajJwdW94UjhML01SWlFTNWdLVzJwb2FV?=
 =?utf-8?B?ZC8zL2l2WExRVUVpaXI3cjBBS2xKUSs1dGUzRE9vZDJJVmNlVG9wWFpTdVAr?=
 =?utf-8?B?RWRXeGR2WUIrUlo2V041WTBLRXlDOGxSNm1WTncxalo4aHFQTUl5TFlkUC9j?=
 =?utf-8?B?cUo5bHZHSUFqZDlPTzd3NGMrRmpYL1MxTHQ3Ni94QVlORTVmZm8zaFdydmM4?=
 =?utf-8?B?b29QMEVkUFdIM0ZJLzYySzJJM0pINlE4Zi9rSXdNSGlzRFh1RHdtMDFNekJT?=
 =?utf-8?B?azk3aG5hWWVWeEN1MW9SUTFpVVgwa0xvaWdWWTFZaWhYZjloYW4zZGR1Rk05?=
 =?utf-8?B?T2k0Tk94dVN0VmpuSUZWQ2psMm1SbThBRUoxTnBQbG5QcTFyY3JYeGk3TDBt?=
 =?utf-8?B?QmhHRS9vbVB0azRtaldNbzhMVnp6OThvMWVuS2RoVm1XTjhRVk9FcVVOdk8r?=
 =?utf-8?B?ektaNGVtaGhWMno3T3hVY1k1VnpiZzNuazFGci8zN1dDRmxObzRocmhKNmJw?=
 =?utf-8?B?VUsva05IaFVnQU8yWXFmL2U5WXVYWC9xV0ZRbjZEbEEraXNNK01FU2FBU2V3?=
 =?utf-8?B?eTd3Wjg5Wi9CVWgrWlhXN2J5bS9ReW1mSGRRckJJWm9zZTVwM0ozc1BxZEl4?=
 =?utf-8?B?a0pVYzAzSC8xOG94Y1JacVp0bUs1cWttcUliRUF0ZVdRUmNoakNLSXpRLzR2?=
 =?utf-8?B?SGtkMzFNOFR3R2h2YkpKeVFXRWNzNVd1eHlLUWhscnYvUEtaSUs4dEo5Y0t6?=
 =?utf-8?B?ZGV5REFsdmhTNm9kcHNCOGVocGpNTmdZUG0vUW43VXI5UDZrRXljejhuYTM2?=
 =?utf-8?B?WVlXWlFFL0F4S0Q3NHZUKzdCMzUxSzNjOHkwTndnNGNnNmUwekpkL2lKYnQx?=
 =?utf-8?B?clpmOUlXWXVBL2NPS0J2UnZsVkVwbkQyWEZlZnZqK2FtcDQ1bmpmTktmTWw2?=
 =?utf-8?B?Q21JaC9PNk5ZL0lvT291aFF0aHl3RmFJTm81VnlweFd1TlExVlhzSUF5NDh0?=
 =?utf-8?B?RnI4UnVnTmQ5K1gzY2wrbGZtR08vUGF2K3lwaUdvSnFGR2VTeGdrUmdQSXlw?=
 =?utf-8?B?N2FuaVZSYTNnTENwSityc1pIK2V2WkR0Q2NYYTdDV3hCTjFXNVBmOVo3QTZY?=
 =?utf-8?B?M253T1hFMTNSMnlpeURGV3FCVXFWVjZ6c0lQTm5VMmt4bUd4MkRVNFV0M2tm?=
 =?utf-8?B?Q1ZZVjhuUVBDeHhZR2c5cnhlc0pRcjAxaUZ2M0NZMngrNkVDV1dJQWx4L1VB?=
 =?utf-8?B?MlZPeWNoeEhkNXNEQ3pIWkZYM3ExVCtIV3NHY3h0R2EvRjduY3pKZnQ5Snlq?=
 =?utf-8?B?SDM2REU4VENERmF0cmVjVkpSaEZjWEVNNzc1QW1Hc1lGdm5mdm00TE90cnNZ?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0a9944-201c-4ba0-f2e9-08dc644e996c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 11:06:32.5834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wkc7Ut3hNA7wLkZkYihAolpiL/X7vzvGy+LKxISkF8gsFCTgAuc4efS4UtNPLnQWf4DVXJMu3fYH6CoF1REktUMWxoPw6zsOT+QgsScjy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8172
X-OriginatorOrg: intel.com

From: Yuntao Liu <liuyuntao12@huawei.com>
Date: Mon, 22 Apr 2024 06:05:56 +0000

> The current x86 architecture does not yet support the
> HAVE_LD_DEAD_CODE_DATA_ELIMINATION feature. x86 is widely used in
> embedded scenarios, and enabling this feature would be beneficial for
> reducing the size of the kernel image.
> 
> In order to make this work, we keep the necessary tables by annotating
> them with KEEP, also it requires further changes to linker script to KEEP
> some tables and wildcard compiler generated sections into the right place.
> 
> Enabling CONFIG_UNWINDER_ORC or CONFIG_MITIGATION_RETPOLINE will enable
> the objtool's --orc and --retpoline parameters, which will alter the
> layout of the binary file, thereby preventing gc-sections from functioning
> properly. Therefore, HAVE_LD_DEAD_CODE_DATA_ELIMINATION should only be
> selected when they are not enabled.

Dunno, I have DCE enabled for years on my home kernel, see commit [0]
with both ORC and retpolines enabled, and I didn't have any issues.
vmlinux still shrinks well, even with Clang LTO.

> 
> Enabling CONFIG_LTO_CLANG or CONFIG_X86_KERNEL_IBT will use vmlinux.o
> instead of performing the slow LTO link again. This can also prevent
> gc-sections from functioning properly. Therefore, using this optimization
> when CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is not enabled.
> 
> The size comparison of zImage is as follows:
> x86_def_defconfig  i386_defconfig    tinyconfig
> 10892288           10826240          607232          no dce
> 10748928           10719744          529408          dce
> 1.3%               0.98%             12.8%           shrink
> 
> When using smaller config file, there is a significant reduction in the
> size of the zImage.

[0] https://github.com/solbjorn/linux/commit/25c4953ea73d

Thanks,
Olek

