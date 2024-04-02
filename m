Return-Path: <linux-kernel+bounces-127890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FC4895259
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71C03B24E65
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DBD78297;
	Tue,  2 Apr 2024 12:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F5SbL9Be"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768C76A8A8;
	Tue,  2 Apr 2024 12:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712059341; cv=fail; b=Auy4o/l0cKIg0QdoLV0cTZqw5lwNvlxorzklrWc/eFT04m9i+OPH2YAj8Ue0p4GML6irz4V+nV9I6li+GqkdzAY0g8Wi8ZChjAR70vPNM7vWcvbuhJkZqmHD1AdgRPrlhvtxUqk4HiuRgjMXj2HvS79oy0a54O/42/HF0NzgL6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712059341; c=relaxed/simple;
	bh=O8chSc4EjJpi5Q4nyYua+u+KxG0B0+s9MubOAENzya4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jbqGGp4NZhn5wQk07vl1d5o3GOGcJiD/HeiGOKl/FpVFldgZs5MqaS5l9FBfcWI6BxDqDe1BfhT1nT29PiloRYonSbbvxX549VO07nAwbWI3ZADBNqpestJuRaq+7G4loMUHCwoTfOMl/ns+sHUhbrTc848awBPHDZmZkXyZoY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F5SbL9Be; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712059339; x=1743595339;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=O8chSc4EjJpi5Q4nyYua+u+KxG0B0+s9MubOAENzya4=;
  b=F5SbL9BesqCSsBbVVyyqhTQpgv/QNRCFI69A3/vhI/jHA3G8VBYsSDiC
   Gchs0iPInlpQlESZOrO1YMj4rmKY39USE6Ca9wFpY56/4lHmXyYara9yk
   VzQUy2e2nlEsp9fI+qhiRC42WADUTPjWKjTW5NIktOGYTpJ5s7PhXM7d3
   CX1mjyJWkmQ0MDM6stB++NkeKOU1XY9hShO0d5stHBgwzCoEEqGvuByPk
   wXMsoroMc3DR8gqBeNv12ZPMaNNrQQJtFGTZgTFRrwMlqaFrzR2kmeGGy
   mYxiM3d6hqxel4cWOWov1g4/t53RLsAFbnMRCxPjaD0eGG0Xs8Srl07b9
   A==;
X-CSE-ConnectionGUID: JehDHc+GRiCqHcmmpJfXGg==
X-CSE-MsgGUID: /o29wsQgR9ylmQZMhnHLhw==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="11056737"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="11056737"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 05:02:18 -0700
X-CSE-ConnectionGUID: MtY2c6CET/aV51bl4SrOjw==
X-CSE-MsgGUID: wOoj33t5T2endtictThZxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="18119683"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2024 05:02:18 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 05:02:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 05:02:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 05:02:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Apr 2024 05:02:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lX9IaqGHMpUJMTRf40AGyAn8A/MvrwBO+yryOHvjjugNQSa16gppdsORCGjNwulV/OvGpSdH9VsH1k26K9O6J9lZggQVbqRFzCgBrazWL809LNqJlB5q5+HoX6lVOggWqKTlcgRM8JxJ739guC4ud2HRcw7scdfNLVCag9nxGg/byNem64L2Zi7ibRkunMIPa6/hx+MD3axk9NblQRrZG+jXBjcP22IDoC9tv68VZpfZWH8LwAld2SIE2C4aNBLJAbmuNpKzKsiejnq3zrupXfJLqM2ySjxAPQtdZYHJHwDCur0NoGJfJYbzasy+X1CUXauUOFSNWKA0WPc/smNRXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8chSc4EjJpi5Q4nyYua+u+KxG0B0+s9MubOAENzya4=;
 b=YOYu2rxmxNWGcJMJKUm9r+KDfmUIXG4+UzZOy7oui5R+lCJaJneLLLhYIdT0TMEZnD0QeuctO6dXFu5Rqpa3xGk2chaZ47Eqf/t2b/ClabG2ZjyLmx40ltLwsDrjjKcVznLeSId1LGKvesAfYMhdHkn2bFkYNtDyRr0NI53BwRFAk+p3g4s3gwhS0ZuQhJ/YopmnvbET2GBlJA68AR4uBN7OKR2sbNI88j/at1M6/nnrgGQtlGtUBWBo+7CCUDrB4m6KXSvbnZMo0qAh28rHOv8wGo2PsH1b1x2dH5UJ+WtDGSPOmhhM+l1XR8wP2jKVhkupbYZNBW0j2TJAv/CGaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB6007.namprd11.prod.outlook.com (2603:10b6:510:1e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 2 Apr
 2024 12:02:15 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 12:02:15 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>
CC: "masahiroy@kernel.org" <masahiroy@kernel.org>, "mingo@kernel.org"
	<mingo@kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [tip: x86/urgent] x86/build: Use obj-y to descend into
 arch/x86/virt/
Thread-Topic: [tip: x86/urgent] x86/build: Use obj-y to descend into
 arch/x86/virt/
Thread-Index: AQHagop9JcOMYN2GuEKqGlkn0Ny+G7FU5hWA
Date: Tue, 2 Apr 2024 12:02:15 +0000
Message-ID: <fbcde3d79f6b94447d31b5fac1be7d380605fe10.camel@intel.com>
References: <20240330060554.18524-1-masahiroy@kernel.org>
	 <171179263581.10875.12577077230652188795.tip-bot2@tip-bot2>
In-Reply-To: <171179263581.10875.12577077230652188795.tip-bot2@tip-bot2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB6007:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rFleMgS5eOZF6a1ctU7+8Kloi4b/9T4e0foc4oHZSrfk06RYIc1Mupb44upaHl87JmMVt/GJiSQjA4Lonwdg4pj59wSQkiS+5Up1krvhYmymK9KZ1oXekCEyhijwz+TnXkmxHJf8D9z1Orj+uOhxrRXJxv7mqJ/OQ8X7b9wnZqhOZK0v1jWRv2y1cciMgUzRtTB15BK690bAIaF0P4bQjoFFvn8k9FabsHB9t7FOp4joyl7ogWt/NWDPZ63pFyH1pFw2+xwzhIVZBeu0khvos9ZiIgYuFwTUa+0ABe5KveoR1RwAGuzy3jp+5hlRY4hpnf7c0KA7ia+PXNqwTu4izy22PhSYyZ1WHzOE6poeeLd7GgurWtE03MCoKaojzIBHd+lGENHrGSG0otrrTB8BH0sJ0GTAbVTggvYiRAIoXrMBZYjoXhuavCKKx39CVmPwEVo9EB4eQg1/3Msfuq28lEf/pIrLdoEFvyYQQQzni33llZWQC9n9tdtv6Tgs1Mu18MPGVMvVRjjjyQayY61xIfXAt+4/FNe34e54F/qO6FWblfQTVy6/iN5H5hlKIe1iWNlVqGCENEgT7pYCQVpyquB4U5sgTZ1s3Ie7miM3btDR2IUYLpdFEOCM+7k82y9s
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnRzL2NZakI1cm92UXZ5cUFkZUpHTWU1UHc1OGtKci9OOWpma2d3a0hKTmJD?=
 =?utf-8?B?aDNyK2dGUGZkSEZRNVp4V1NjVkNGOTZGQmlvOVNabUJ3ano2QlVYTk83STBk?=
 =?utf-8?B?UE9lTlFpR1BFMlJvVkZvU3NYWk1IUHJldUpxN1pHUWpkL0JocVBySkIxWnF2?=
 =?utf-8?B?Q3JTQmRCMkJ5R0c4aDg0ekdnSkVJdTNMZkZNTDZVMnFiV3FxMndsR1NuT0tE?=
 =?utf-8?B?T3pRWmdNSVB3QW5Va1NSMkJIejRwYWpXR2dtN0s1RGxXcWxzaVdVNGV4cGQv?=
 =?utf-8?B?aDVvS1BjZ2Z6MDVhNjdVTUlra1hoQVAraXdJTXh5ZWY2azkzeTFRMUlNSkk3?=
 =?utf-8?B?aWxuYVJ3UFJVeGVKaVB1eHUzRGJ1VlZTRVEwZWRMMCtFY011c094Qkc1cm0z?=
 =?utf-8?B?NzZzOUJvcmpNbWtCMVVHVDZ3d0dJRnIvYzUxZ1FHTzBGWllqcUpNSkZqWEs0?=
 =?utf-8?B?NDlBdi9HWXZnZm1YL2FuRmh1N1J0VVl6MUp0OWs5emp2RitGaHR3VCtOUmFs?=
 =?utf-8?B?WHJ1MlJ1R0lDOXh5aVB3U3lWRGNLbzErWG45MG5McmpINlNEdXg4S1F1NGZ3?=
 =?utf-8?B?Q3lyZ2VvVXV4bTJoM1RXYVpBTXMraWVNUU9BWmNQNFZpd2pZbFhudXNDeitQ?=
 =?utf-8?B?VjJxS3NOa3JUbFAvWGd3MytZMW9WbjdSZ3hJMTJmcjlGQ0pLK3YxRXp1YUVk?=
 =?utf-8?B?bFZzWkZvMTMwR1JuZ2ZZTzFSZDN2Y0N5SE9LMlZQbXp0R3NKYVgvNElReWM4?=
 =?utf-8?B?alhVTWpOKzVtcWdiWE9CNm9YdzVHRG1qN21Xc0gyMUlEV3BBSzNRU1cxcFFD?=
 =?utf-8?B?SERUTU1kM3hrRVF1d3VQZzJneVBBTXZnbVU1RmFlRVBBTWNoU2ZWbnlGSjdp?=
 =?utf-8?B?T001c3RPQVdXeXJxZDFGNUN4Y1V6Zi9sRWxzTndYWXpacDJFSHJkYmhlWGx3?=
 =?utf-8?B?MEdWM1l4VG13RlQ3djFBaUF0ajJ0TXFVWldhVlpoNk05Sm1RWWJYS0EvbGV1?=
 =?utf-8?B?aFBqejcvdk1WdkpybUwxaTZJd2N6dWNYNlJaOFZta1VyMlZNNlBMV0EvcWti?=
 =?utf-8?B?VEFtV2tFNTFpQlpWKy9XWndsMmVEWm41RXpEVTlacGVxYTFHWjEwQXlCNkxL?=
 =?utf-8?B?SGQwbWpuZlRtRWwzcU1lelBHaEVveDRUeE1HVlcvNGI3Q295QkhGMVloank5?=
 =?utf-8?B?QVBtcXhtaG4vV2cxcE9iMmlpNEpiamhjRGM2UFJGRXJJbUx5NGtYYjFPa254?=
 =?utf-8?B?STJEckRHK2RjWmQ4OGRTaTdVSEltN1JmRzZGdHNpZVVwcDNZdWJTcEFSUm5T?=
 =?utf-8?B?UnN3aFZLYnlVOTJ5blhNOTlRT1RVbGRXRVc2UVh1aGtFOWZTYWN0NWp0SGF6?=
 =?utf-8?B?dHNrMkkxYzZFeUhPc1NLZ3pRZ2M5eDRtTHNoZEN2U0E1OE5oMmp0K01QdzRV?=
 =?utf-8?B?czEwb01aWXZsSUNsMERlOEhwQVg1QmVBZTBVNXpxL1V3eTd2citjbzMweTVu?=
 =?utf-8?B?cWs3RVkzUkZRTW5DN2ROb3diNStxTlFRRVIrTHpmSiswdmdLSWVva0lqc2la?=
 =?utf-8?B?b3hDbUlpY2d0blhXL2xRTWp1U096eFZmSmdTTE1MVnU2c3JHNWpKWXoxZ2Vn?=
 =?utf-8?B?TjNrTERUWE1OUit2WkJyYnhlbGFBOXVVSUNsZ0NyTUR6QzF5OE02b2JRSkNR?=
 =?utf-8?B?bXdsUmY2enpKdlEwM2FYWGV2OU93V216SE9aL09Kbi9oS1pmdFNRTnp1SUFi?=
 =?utf-8?B?MzZucFlYN0FRNWtucTVpRUdDL1loSUN6c2ZQaGZad0ttWXFPemVaSmYyWHpy?=
 =?utf-8?B?OVNaeGpXZDBIVk54ajN0a0twOWhiT0ZKSzVoNGRUajFWREw2UE9MLzVKMy9q?=
 =?utf-8?B?NitoWVJYVFVVc0tiSXA2ZG9CN25IbVFhT29oTTBvYUNCSzdzWFJ5RnRGRERR?=
 =?utf-8?B?SkNFQ0p3QzBienlwRnJnajYvdGtKSVhIZ3pjenhXWmxqd2lHZlN3SG5Zd2xy?=
 =?utf-8?B?bnF3OGxjRTFwV3hZdmpQU2F3M2NuY2syVVdlQW41MXpoRGl5VWtnbDh1Vm4x?=
 =?utf-8?B?cHBKSEt0THoxcnJPRW9UbWhGT1Y3V2tiTUduMjFwUjk1NWpzd3daWXFORWUx?=
 =?utf-8?B?anlxc3VYT3RHMzNUMVlPYVFxNnZ3WFNrWHI3SFI3ak01YVl5dlgxZUlMVHBr?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE355457F3BE40478FDEBCD3F4DB1CB2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a06970a-3148-4c50-52f9-08dc530cbcf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 12:02:15.4342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZiN9nvRsS8jVzRuCNA4SkJbOLD8INCxL+7lDod5qP6KAFP7w3EFSOKN5Z26wvgIEW+9ZYxLzDEBFndnkco7TLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6007
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI0LTAzLTMwIGF0IDA5OjU3ICswMDAwLCB0aXAtYm90MiBmb3IgTWFzYWhpcm8g
WWFtYWRhIHdyb3RlOg0KPiBUaGUgZm9sbG93aW5nIGNvbW1pdCBoYXMgYmVlbiBtZXJnZWQgaW50
byB0aGUgeDg2L3VyZ2VudCBicmFuY2ggb2YgdGlwOg0KPiANCj4gQ29tbWl0LUlEOiAgICAgM2Yx
YTliYzVkODc4MDA0ZWQ0YmMzOTA0ZTVjYjliN2ZiMzE3ZmJlMg0KPiBHaXR3ZWI6ICAgICAgICBo
dHRwczovL2dpdC5rZXJuZWwub3JnL3RpcC8zZjFhOWJjNWQ4NzgwMDRlZDRiYzM5MDRlNWNiOWI3
ZmIzMTdmYmUyDQo+IEF1dGhvcjogICAgICAgIE1hc2FoaXJvIFlhbWFkYSA8bWFzYWhpcm95QGtl
cm5lbC5vcmc+DQo+IEF1dGhvckRhdGU6ICAgIFNhdCwgMzAgTWFyIDIwMjQgMTU6MDU6NTQgKzA5
OjAwDQo+IENvbW1pdHRlcjogICAgIEluZ28gTW9sbmFyIDxtaW5nb0BrZXJuZWwub3JnPg0KPiBD
b21taXR0ZXJEYXRlOiBTYXQsIDMwIE1hciAyMDI0IDEwOjQxOjQ5ICswMTowMA0KPiANCj4geDg2
L2J1aWxkOiBVc2Ugb2JqLXkgdG8gZGVzY2VuZCBpbnRvIGFyY2gveDg2L3ZpcnQvDQo+IA0KPiBD
b21taXQgYzMzNjIxYjRjNWFkICgieDg2L3ZpcnQvdGR4OiBXaXJlIHVwIGJhc2ljIFNFQU1DQUxM
IGZ1bmN0aW9ucyIpDQo+IGludHJvZHVjZWQgYSBuZXcgaW5zdGFuY2Ugb2YgY29yZS15IGluc3Rl
YWQgb2YgdGhlIHN0YW5kYXJkaXplZCBvYmoteQ0KPiBzeW50YXguDQo+IA0KPiBYODYgTWFrZWZp
bGVzIGRlc2NlbmQgaW50byBzdWJkaXJlY3RvcmllcyBvZiBhcmNoL3g4Ni92aXJ0IGluY29uc2lz
dGVudGx5Ow0KPiBpbnRvIGFyY2gveDg2L3ZpcnQvIHZpYSBjb3JlLXkgZGVmaW5lZCBpbiBhcmNo
L3g4Ni9NYWtlZmlsZSwgYnV0IGludG8NCj4gYXJjaC94ODYvdmlydC9zdm0vIHZpYSBvYmoteSBk
ZWZpbmVkIGluIGFyY2gveDg2L0tidWlsZC4NCj4gDQo+IFRoaXMgaXMgcHJvYmxlbWF0aWMgd2hl
biB5b3UgYnVpbGQgYSBzaW5nbGUgb2JqZWN0IGluIHBhcmFsbGVsIGJlY2F1c2UNCj4gbXVsdGlw
bGUgdGhyZWFkcyBhdHRlbXB0IHRvIGJ1aWxkIHRoZSBzYW1lIGZpbGUuDQo+IA0KPiAgICQgbWFr
ZSAtaiQobnByb2MpIGFyY2gveDg2L3ZpcnQvdm14L3RkeC9zZWFtY2FsbC5vDQo+ICAgICBbIHNu
aXAgXQ0KPiAgICAgQVMgICAgICBhcmNoL3g4Ni92aXJ0L3ZteC90ZHgvc2VhbWNhbGwubw0KPiAg
ICAgQVMgICAgICBhcmNoL3g4Ni92aXJ0L3ZteC90ZHgvc2VhbWNhbGwubw0KPiAgIGZpeGRlcDog
ZXJyb3Igb3BlbmluZyBmaWxlOiBhcmNoL3g4Ni92aXJ0L3ZteC90ZHgvLnNlYW1jYWxsLm8uZDog
Tm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQ0KPiAgIG1ha2VbNF06ICoqKiBbc2NyaXB0cy9NYWtl
ZmlsZS5idWlsZDozNjI6IGFyY2gveDg2L3ZpcnQvdm14L3RkeC9zZWFtY2FsbC5vXSBFcnJvciAy
DQo+IA0KPiBVc2UgdGhlIG9iai15IHN5bnRheCwgYXMgaXQgd29ya3MgY29ycmVjdGx5Lg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogTWFzYWhpcm8gWWFtYWRhIDxtYXNhaGlyb3lAa2VybmVsLm9yZz4N
Cj4gU2lnbmVkLW9mZi1ieTogSW5nbyBNb2xuYXIgPG1pbmdvQGtlcm5lbC5vcmc+DQo+IExpbms6
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNDAzMzAwNjA1NTQuMTg1MjQtMS1tYXNhaGly
b3lAa2VybmVsLm9yZw0KDQpUaGFua3MuICBTaG91bGQgdGhpcyBiZSBpbmNsdWRlZCBpbnRvIHN0
YWJsZSBrZXJuZWw/DQoNCkFzIHN0YXRlZCBpbiB0aGUgY2hhbmdlbG9nLCB0aGUgcHJvYmxlbSBz
dGFydHMgdG8gZXhpc3Qgc2luY2UgY29tbWl0DQoNCiAgYzMzNjIxYjRjNWFkICgieDg2L3ZpcnQv
dGR4OiBXaXJlIHVwIGJhc2ljIFNFQU1DQUxMIGZ1bmN0aW9ucyIpDQoNCj4gLS0tDQo+ICBhcmNo
L3g4Ni9LYnVpbGQgICAgICAgIHwgMiArLQ0KPiAgYXJjaC94ODYvTWFrZWZpbGUgICAgICB8IDIg
LS0NCj4gIGFyY2gveDg2L3ZpcnQvTWFrZWZpbGUgfCAyICstDQo+ICAzIGZpbGVzIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNo
L3g4Ni9LYnVpbGQgYi9hcmNoL3g4Ni9LYnVpbGQNCj4gaW5kZXggNmExZjM2ZC4uY2YwYWQ4OSAx
MDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvS2J1aWxkDQo+ICsrKyBiL2FyY2gveDg2L0tidWlsZA0K
PiBAQCAtMjgsNyArMjgsNyBAQCBvYmoteSArPSBuZXQvDQo+ICANCj4gIG9iai0kKENPTkZJR19L
RVhFQ19GSUxFKSArPSBwdXJnYXRvcnkvDQo+ICANCj4gLW9iai15ICs9IHZpcnQvc3ZtLw0KPiAr
b2JqLXkgKz0gdmlydC8NCj4gIA0KPiAgIyBmb3IgY2xlYW5pbmcNCj4gIHN1YmRpci0gKz0gYm9v
dCB0b29scw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvTWFrZWZpbGUgYi9hcmNoL3g4Ni9NYWtl
ZmlsZQ0KPiBpbmRleCA2NjJkOWQ0Li41YWI5M2ZjIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9N
YWtlZmlsZQ0KPiArKysgYi9hcmNoL3g4Ni9NYWtlZmlsZQ0KPiBAQCAtMjUxLDggKzI1MSw2IEBA
IGFyY2hoZWFkZXJzOg0KPiAgDQo+ICBsaWJzLXkgICs9IGFyY2gveDg2L2xpYi8NCj4gIA0KPiAt
Y29yZS15ICs9IGFyY2gveDg2L3ZpcnQvDQo+IC0NCj4gICMgZHJpdmVycy15IGFyZSBsaW5rZWQg
YWZ0ZXIgY29yZS15DQo+ICBkcml2ZXJzLSQoQ09ORklHX01BVEhfRU1VTEFUSU9OKSArPSBhcmNo
L3g4Ni9tYXRoLWVtdS8NCj4gIGRyaXZlcnMtJChDT05GSUdfUENJKSAgICAgICAgICAgICs9IGFy
Y2gveDg2L3BjaS8NCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L3ZpcnQvTWFrZWZpbGUgYi9hcmNo
L3g4Ni92aXJ0L01ha2VmaWxlDQo+IGluZGV4IDFlMzY1MDIuLmVhMzQzZmMgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gveDg2L3ZpcnQvTWFrZWZpbGUNCj4gKysrIGIvYXJjaC94ODYvdmlydC9NYWtlZmls
ZQ0KPiBAQCAtMSwyICsxLDIgQEANCj4gICMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0y
LjAtb25seQ0KPiAtb2JqLXkJKz0gdm14Lw0KPiArb2JqLXkJKz0gc3ZtLyB2bXgvDQo+IA0KDQoN
Cg==

