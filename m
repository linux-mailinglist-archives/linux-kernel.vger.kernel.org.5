Return-Path: <linux-kernel+bounces-135665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8D389C97C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F89CB2707A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71211422BA;
	Mon,  8 Apr 2024 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jp59jNVP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED9624B4A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712593243; cv=fail; b=I97uBVrp0OIuNKgFHDhtT0yN9qYUZ1h62CKxx5wilKHMlsvNsptjfiZQ2CYL/qVjwgOvLRgM59BHZjcIUd4UQi8nCJA/4ZP93vUOmIu6FO2bYZ78Se086qcJBVgCeES/PQ70Tbayv5/tuxBDL7rHpDRuvmirQJ6c5aIzsEd/SCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712593243; c=relaxed/simple;
	bh=VbpHmh7Xxow4KeHi2nalitRRs8oEzbxPJSSWisw9iD8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y2i57jmK0o9Bu0vTJ11f9Y6fEnX783cAL19m4nVibiSMojScA9icZb362X6qSmv4qHo/lTNZfbUHOLH8yVBkq4MNbSBIKRHFT60j00j8xBtXM8YrooR9AbyfADrOJKbIacEsG4bNY4i4UgIz2iYNJsR57ZYbenISpu5vxOm9QiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jp59jNVP; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712593242; x=1744129242;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VbpHmh7Xxow4KeHi2nalitRRs8oEzbxPJSSWisw9iD8=;
  b=Jp59jNVPzTHWvnDYvr85+BgbFWK/YrLSqttiOBlj2LmDhLwlFP1ckh0p
   WmGg/1LiyNLpXZTIFkZvxf6gcH+UO44WbrP6LFvjgHZ6k14soe3CiqGtm
   4mZ/5J50Pwnh46iqPoWakgKgUn5AnNKiEGMONUa75+xsNxY4KdTx9FRO8
   1WG89RzA/14195oTW/EoEbIZndejP2kmLMTtLdBIieeBoWuXKk8laC5jj
   +fvS76g3jVUSZreKMYq4dktDlMLRheja1P5MMVGvm5kDxNrG3IWy8U3VP
   IhfhX5I6SskCeDCNzQgHL68M1Lh7xDGi1nle18/gtGEmCdjnExshEcs0P
   g==;
X-CSE-ConnectionGUID: kSnsvt61Tj2QKBiHhQwNKA==
X-CSE-MsgGUID: YeNHjyC+SvKlh87l1LjH+Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7723622"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="7723622"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:20:41 -0700
X-CSE-ConnectionGUID: jAXWgrqeTICxUlDMT3hc2g==
X-CSE-MsgGUID: 5hpWXiX8R6O9X9373Qnvxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="51126194"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 09:20:40 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 09:20:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 09:20:39 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 09:20:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UT7GuxYkVFRQwW2a6/RhAZ5zPVK2626vTzs+SSm+sqLTLFBk++ebwGi2FaAT/vxcORPsUCwKuYzTZ5+L/VnMAvAGCPr/ZtFcsMsRvRUpB/W5MT9k7eTib2ao+59D86Gbu0LYl1XqYDwxWTq+kiEa9ctw4mEPPYmGP11U1iSYIeL95wRwWkZqa1eOcDOa/gJLk1wVdVqt6KiPlcBdh28WRxkW3ob3pUVbJG16AvtTtxPSYT9FHzgUkBEhPfgq2LqR380bEeVh22vIcKlV3aGtZRTdP6g+wRmGJ12payLkCZwS0VfwFgOq7lKL3SEY2TFJ0Ez5ekqc3NEdK7kpoaya8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbpHmh7Xxow4KeHi2nalitRRs8oEzbxPJSSWisw9iD8=;
 b=EQ3VrYtC8XuZO3RvDUTeYhydfUKGgLXYxvmjxENl3VeGfH+GZTrjWshGiCICQf3Nr3c9495nkZZGmD01fEfLNv/JKKbHyMnplWzUARfkY6Qdfvp4gDxcCD2615dZAWKXTriMAMNEYQmnL95D15Xchemt6G7rOUGHkF5oxYnqws+SoWcXJG8p5YnXdoRUiMwdfPeRHB6hmVv3B/C+CWio50OVnSx+f/dysGXXTkWn80Cx7x9FVq5oApvyzZwkfDxiI2rYaurtzYLGYA19wwXsxqgKjJaFql+SdqyizAb8dqiRQyE0EGS3QzyUvHN2Ge0cksuU6InBCGODMyBi6DY8Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH3PR11MB8313.namprd11.prod.outlook.com (2603:10b6:610:17c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Mon, 8 Apr
 2024 16:20:36 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 16:20:36 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to struct
 cpuinfo_x86
Thread-Topic: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to
 struct cpuinfo_x86
Thread-Index: AQHagS5KoaFl1e6FLU2YPMaZiCLmO7FNXROAgAABToCAAAEjsIAABDsAgAASPNCAASNagIAOGFGTgAHr5+A=
Date: Mon, 8 Apr 2024 16:20:36 +0000
Message-ID: <SJ1PR11MB60837E437DFA0595DF5B25D0FC002@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240328163746.243023-1-tony.luck@intel.com>
 <20240328163746.243023-2-tony.luck@intel.com>
 <20240328164811.GDZgWfSzAWZXO7dUky@fat_crate.local>
 <20240328165251.GEZgWgY1Clb9z4t3VX@fat_crate.local>
 <SJ1PR11MB6083AADC97E50462C1137D71FC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240328171204.GGZgWk5JNOzQzoaEql@fat_crate.local>
 <SJ1PR11MB6083D8BB65748452B204ED8AFC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240329114007.GAZgaolwSFtjHStiuL@fat_crate.local>
 <Zgr6kT8oULbnmEXx@agluck-desk3>
 <20240407105407.GAZhJ7T0fEhzow2MN2@fat_crate.local>
In-Reply-To: <20240407105407.GAZhJ7T0fEhzow2MN2@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH3PR11MB8313:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ySUmEaN5kKAWGN89VGD6I/NBr9wzIKc289LpQvCXD3zmL/eRMT5TeSRAjDow2JJty6RG9sqKpSfIJ8nVqyeOyEmrn2KIy9j7yniARzSZxBL8AjVLVSehTMa6lt0lOz+waKwXjmbDxPXr62H/Csi5kdKtdSvbGneT2Hm9TdMNAzKTHfkn7qTFAhTua/z20JhuUgPl/waLQ+R7zVlBz3tgo4HsVdhuvkghRI24KL6IHwB6wJvasF6yVg+yboA1RfmuIdxq9wwA+b/qWY2JZhTi6PiZNAblhzol664RlWpys5UYm39G5/m/PbG+91p8AWRzbS5ZFRcD6D8MDnGkMO5SGbMF2zkR5JZdgZourWUhXsSe4WdGqxC+4z9nZMxS4wXu1NMJTPW6hbj6wSf5tsVoHjHg9VRiYCz1I4lCkRV3acN7l57bIsbUMzDKYTNbpKS2iBpE36nfpB462CYUWmyrV8LWTlnQyg4J/bAUVSsxGqqwMQ1UC8XkdilvrSjMqzkwRcxoV00BF4x4cRtk2XJFkHYqEZVeikz6hoZUkNCTnzj/orf9tEWgmSb9EgVm9BwS/reg6DivBYx79gTTcQcWdfIMLgbck/XVLrTd6FdYi4dDTwYb7C3/q5Gcf1dzGYJQ6KbF+885Vyah9jXcXDKuR7Y1O1UhaYKznkaRd23MiMQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHh4VFFONjcrQlZZeVBCWnJxS2VXYnB4NDErSE53VUU0NTBEWVFrYnFCUjlV?=
 =?utf-8?B?YStDVkUybnpGT3lRVlI1SVk1b0FjZ2xoejFQb2ZQdWFXaTJqT0h4WnQ4UkxC?=
 =?utf-8?B?RTBYaEQrbURQTm9DWHBlUzROZGdFaWtubXBwM2gwM2VnMEVRNGhsYTVsWFpS?=
 =?utf-8?B?V1gwaGxxV3B5eXFtMHB4ZFl1emxFQ0ZXN1llRElyb2dMdWdOcStuMlZzcUhW?=
 =?utf-8?B?eFZmbmxXM25aSllrN1hSaUVwYnhVSmNXd3NjTGpsK0RVV1I5QmdZU3hHUGNw?=
 =?utf-8?B?ODB3MUJ3MzZ1SmVEL0FkUXlWMmdENUwyaGxaMWxPT1RmVlBmcU5KNEluNGhG?=
 =?utf-8?B?M3dWVnNTdTNVUWVGbGtLbGF2aERtd0tPL2EyQWpHVG8zR0pyMFVtWUU1dkpp?=
 =?utf-8?B?VE1yQ2JWbGplSmhRb3NjVmxKd2lROWZNNG83amU0eFI0NGFQWkx2clI5MzhV?=
 =?utf-8?B?VjFaZ28rZ2lLRkRVZmhsQnNpSk1zU1ZIVHNvNDJDRzRLOHMza3FwM3BmMzBq?=
 =?utf-8?B?RlgzSnNkejZxMkQ4RXhNblFQWmswampLeUlsbldkMG5rL0dXUmRaZHBNcXdY?=
 =?utf-8?B?cWVqcWQ3Mm52SUh6RSt3alF4Tll2cWZjSXZzSHJncVhrckJDdXNMNE5Gd1I4?=
 =?utf-8?B?Y1ozUDZtZTJLRENQYzZTQkxNaFFJVzUzbjJ6dDQ5SDBKRjJPYkhGa0pwSzN3?=
 =?utf-8?B?MHlvS2pIZG50SGdrcTdaV1hxa3BRTnhCOGh2MjJVM0NSNmxTRkRiNW05d1cr?=
 =?utf-8?B?Wkh4UnpJblk3MUNWZmFqWk1sS0VWSjZ0SXhXUWNML29lSUJiWGJIM2NKQ3BD?=
 =?utf-8?B?UnR6bTlLbmhCVFpqSG5qd0Z2ajJCeGlWQVhXY2xKR3VSUzJySlBGazYybGhU?=
 =?utf-8?B?b2lURkdvWFdpKzc1TWpKaUMrczI0dU9lTSswVzR4eTJPMm5lY25ndDlWZDRy?=
 =?utf-8?B?VTlaSUt5TUtjYlZ5bGhBNTIyN1pGZnlQV1lZdE8rcDBiQ252WmN1LzZVTU45?=
 =?utf-8?B?ME9iSFpzL3BrS3ByL2JDNlVtKzFRaWlDcUJuMHMydTk4RjA1azlheTdVd3Nt?=
 =?utf-8?B?T1VINmtRbzdsRUlnazRQNUh2dm1QUHBmUzd4cWtBQmhpdDZzS21URCtiVHhN?=
 =?utf-8?B?ekdmQTRNOGF3UzRFMlNyS0hQUDgvQTQrV3cvQ2UxbCt0d2ptK2dkZTFGTlZp?=
 =?utf-8?B?L2M4a1hiNGVvVFlDenpKM2xPdWJTSit2N2d0ZHExZFZTT0dhZzlpS3dUa3Z0?=
 =?utf-8?B?MzZER1Y2SlhGdGlabVFmYWtDL05oOThaazFVdFNrZGpCWVBMbDlENWxzb2E3?=
 =?utf-8?B?RklUSEM3cHFCdkFOTVg3K0greVFHcUNaUk1hUFFrU2RXWk1DMUdKM2lzNXhv?=
 =?utf-8?B?ZUxMQVZWUjMyam54eGEzSnc1eDFqTmV6R1lUTTVHaU9CRnl1N1QvaW5XYUVy?=
 =?utf-8?B?TUxsV3lwK3BhRWpGRXk1MG42dnVLNVpTZ1k3NXFxWTlVbFBEeG5tSmxBZzZE?=
 =?utf-8?B?L0FHeUM0dnBIQkRPV1RYWkRFMkFwUXd5UVNmMEhuakdtR1laNktqNktXcXpV?=
 =?utf-8?B?NDkvRlRoeFBDVjlmMDRlcDZIZ2o0c2hNUXdEcWRLaENhKzluTTF3T0pJUk9Y?=
 =?utf-8?B?NU5BbVcvK1NLV2hDb0F6TXNZMEVpQW9QZjIzZmZXWVdTdEpTUHhLYlY1S1k5?=
 =?utf-8?B?S0YvSmlZMStCNHBXWStCTDhXbkdDcXlYcDI4SFNaeGZnUkdhcDZDdkt0cC8z?=
 =?utf-8?B?bi9BR1lzNHpIUFpBTUQxV3BhdFliNUFLYTNyUG5zWlp6VnA0cmRNSG5BWTQx?=
 =?utf-8?B?ZWtiSEM3QytFRFFkKzVzcy91UUw2Z2QzL3h4eTdNMnR0TzdSTUN2NG9vd2Vw?=
 =?utf-8?B?cElVemFBb1VrK1BNWFRtM3BkWmN1WFloek5haTVYbFhQa3ZzWjlObFNXb3RK?=
 =?utf-8?B?THhpZzFwLzVwSi9Yb2h4WXlwdTdVakZzQXpNTUxNdUxRRitnLzRoLzRCemRN?=
 =?utf-8?B?ZHk4bFdhN0VHTWxwMHdSeWUxWXZscGJPSmlKSXFRb0xjU2d1QWU4WmM3ZENu?=
 =?utf-8?B?VkxoMFJMNFczV3pwVTVuVHp6TU4vZzQ1eFRyWVRVcDl4NGNjUzNwRWNXRXVl?=
 =?utf-8?Q?WN7TsCxoWttOSC9anCrGaYyeT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d26b00-37a9-4fb0-11b5-08dc57e7d2a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 16:20:36.2392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sHpqxCA4azEIZT9I+b16Gxl830DHU8YPGMm4+7sKa5lR97wTXLeqKhX0p+5yeSOtT1DPaKGUlvm247GbOXtk/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8313
X-OriginatorOrg: intel.com

Pj4gVGhhdCdzIG1vcmUgdmlzdWFsbHkgbW9yZSBjb21wYWN0LCBidXQgbWF5YmUgbm90IGFueSBt
b3JlIHJlYWRhYmxlLg0KPg0KPiBZYXAsIEkgc2VlIGl0IHRoZSBzYW1lIHdheS4NCj4NCj4gQnV0
IHlvdSB3b3VsZCBoYXZlIHRoZSAqb3B0aW9uKiB0byBkbyB0aGlzLg0KPg0KPiBUaGFua3MsIHll
YWgsIGluIGNhc2Ugd2UgZXZlciBnZXQgdG8gY3Jvc3MgdGhhdCBicmlkZ2UuLi4NCg0KQm9yaXMs
DQoNClNvIGFyZSBwYXJ0cyAxLTMgcmVhZHkgZm9yIFRJUD8gSWYgdGhleSBnZXQgYWRkZWQgSSBj
YW4gc3RhcnQgY29sbGVjdGluZw0KcmV2aWV3cyBmb3IgcGFydHMgNC03Mi4NCg0KNzMgYW5kIDc0
IGFyZSB0aGUgY2xlYW51cCB0byBkZWxldGUgYml0cyB0aGF0IGFyZSBubyBsb25nZXIgbmVlZGVk
Lg0KDQotVG9ueQ0KDQoNCg==

