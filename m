Return-Path: <linux-kernel+bounces-161348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B17968B4B04
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 11:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91B61C20D2E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BC854FAA;
	Sun, 28 Apr 2024 09:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vp6JySey"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF30AD52;
	Sun, 28 Apr 2024 09:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714296959; cv=fail; b=JY5V2TMF/yc25LBpHBF9bT681ZPLip3qRQe2FgjhNaeRQixQ4JVdd5Sy8rQhmlq6bAWYgz7wHRP7MdtLvQpZwx7zCu1t1WZ/LJh8da70m344/mVFQ6XaZ+XQQ/EgWcCik3H8u0YH+JujN8SlN4XnjarsmHxx13lqs01z882nQaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714296959; c=relaxed/simple;
	bh=UJyOiaTV8zEBLg9AEgB8zex0XXpIntA6vrxoKQOnRxs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fFR4fyxKFx+Is/xM4QXfD/+TaDBMLhwasgj+9adVYLcXoDthVoCo/3iilXdY2Y01BT5OBinQG3egtbFi3Q+RcO6M1Cgy/QibSpD9tmIIyYU5LWa95h56W48aOxxmz+wTBOgrXOl1pX8UpVK+96JuJSUUVEXYnJ6uKJ9cJKvGfZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vp6JySey; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714296958; x=1745832958;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UJyOiaTV8zEBLg9AEgB8zex0XXpIntA6vrxoKQOnRxs=;
  b=Vp6JySeyK1bvQ7c7ozHymRRL+ieNWzNCG62sP8zqqa2hHOYIpllhl2ia
   kmkzKjjJG6mnOZN2kPCj15Q13tPci9sWGVei4eXIUCotGkm7ay7wSpaoY
   TnqT4RWVGojnwIabQTJcOBB8f8gqwhcuOMNg7ORDgYB6eZ8Xgo3oADBtC
   2eExcyj4xYpFJlVXRqFAASSZTfaB1jpIQn3R+ly/ETsLoefeUl3cGrI8M
   djXwHDrd0M2niuXfscB7RN/syWx5asjmXtI9n956D93Fu8JY8cXKRbNYw
   BFDt1WrbyfSBRFUHUlFLQ01DEf8XgMv7tv8bnMrHhsrcfOXcNk9KZG5Sm
   w==;
X-CSE-ConnectionGUID: GnnCyJLNTA6yyjfuFxSCvw==
X-CSE-MsgGUID: q1rtDShWT7ai0AIxXR7UFw==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="21128093"
X-IronPort-AV: E=Sophos;i="6.07,237,1708416000"; 
   d="scan'208";a="21128093"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 02:35:57 -0700
X-CSE-ConnectionGUID: U6/KM/ThT16iCiAHcMRwOw==
X-CSE-MsgGUID: NXgyo56NRRKmuYNRlC8/Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,237,1708416000"; 
   d="scan'208";a="63305235"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Apr 2024 02:35:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Apr 2024 02:35:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Apr 2024 02:35:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 28 Apr 2024 02:35:56 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 28 Apr 2024 02:35:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dte0ii5v/Z8YsDei76LB/NdEHVcxHcchnY8cxrRfR98nDT647ovfmTD7/+HVlWMJRoVIYnB3yEvj8HHpRXlTfq3P9I6Xj3boLeTsAvLi0hyrfkHeLT4QUaBY2Lamw604MaCKnwgnEKgi3+I78e0TXQga11iYcza0GG5i1VI+5wfniDltiSMtv93NEQ23ph/9RK493bXjJtw1VGmQEFHJY5mrQGqMIDdGwWt8WCBtQY36gkN/PSp77RT54dXbA3pNRJNXndOSEkAfAJ8hHnkmI2ytaIy+nLMIGAgsn/rRDA+h7tfS8NOS5bzGeJy5IMzI1phsN003HdWTiKaPVs9YhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJyOiaTV8zEBLg9AEgB8zex0XXpIntA6vrxoKQOnRxs=;
 b=KHuIEDYlJ7i8UfvQ2NZLKluVThhV3Chk/+hOSfHkfv0LgtEHBE/8LiTpVg5hVV7IPo7gZwoJginZ5432s8i3XlI2TJ2WL8IhjyCObg3T23RKTl59xTxN1hoYNA+R5tLG/RJDHOkcdYvcIOc9yksZUEwNIjwitlMdvbfOocLhJpMULF1BiOjyLgcR2y+uQ26IPtd7zxn2SL1mt2e9t9TX1GUgphpLpZerIb5sisJ4DYOWdhr3cwAPTKN871S282jiHQL8o1ANm8lgyWe5ZS9Abk19So37NPTxVfZM/mpCyllzgcHzxrAfmMIj9bm0iIHmiP7HsCq2inxvesd25NtQbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by SJ1PR11MB6251.namprd11.prod.outlook.com (2603:10b6:a03:458::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 09:35:49 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::7e63:c3b2:84c1:e6c2]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::7e63:c3b2:84c1:e6c2%5]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 09:35:49 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "rafael@kernel.org" <rafael@kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Wysocki, Rafael J"
	<rafael.j.wysocki@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Pandruvada, Srinivas"
	<srinivas.pandruvada@intel.com>
Subject: Re: [PATCH V3 1/2] powercap: intel_rapl: Introduce APIs for PMU
 support
Thread-Topic: [PATCH V3 1/2] powercap: intel_rapl: Introduce APIs for PMU
 support
Thread-Index: AQHalNEuN5GdVlqKVEarpHZiNLGhUrF63EQAgAKY/4A=
Date: Sun, 28 Apr 2024 09:35:49 +0000
Message-ID: <299a61dffc891af6f5896ba77e500803322fdb04.camel@intel.com>
References: <20240422162040.1502626-1-rui.zhang@intel.com>
	 <20240422162040.1502626-2-rui.zhang@intel.com>
	 <CAJZ5v0iaf8Own=NuHZuYfVpKPBM-ZYHf-SYEgwsjREg-XfuNbA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iaf8Own=NuHZuYfVpKPBM-ZYHf-SYEgwsjREg-XfuNbA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|SJ1PR11MB6251:EE_
x-ms-office365-filtering-correlation-id: 52827d3b-0a40-4eca-1451-08dc67669697
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?SDkvSURaaEJabHhUbFFNb0ZVOGdRMFRkNWtodzhSMExhTEt1UTV5VGxyZWVP?=
 =?utf-8?B?NkFGdTVvaFhZMWp2bjFQM2VOTWIvZWZnU3JiS2hLRG9PU1lKdWg5Vnk4cUhJ?=
 =?utf-8?B?NWM3Q1d4TU93bUdCTGtKZlczemJ6aXp6OGhnSHpjY0RwVld1Q0tESERtTnRE?=
 =?utf-8?B?OERvSHM4bjhPVHVhbWk0ZXhGY3VldG5LUUQxTFpTZWdQRWdFcGdpQjNjencv?=
 =?utf-8?B?alEvcExXaEN0MncxWXMxVEY2UHNtY1ltaE1MajR1dUdFZ0E4VUh1TWJWNDIv?=
 =?utf-8?B?NVVzRkI5SWR4RHlwcnlhTTFXczhDZS9mZVkzVHErQnBDMUxVVGtBNmR0MHRX?=
 =?utf-8?B?Z0JhZk1veTBuNHVxNEd0QlRud1dtMkMwYi9HSHlVK2MxT3RWckdxSlhBdDc4?=
 =?utf-8?B?L2RGRk03WlVEOGE0Y05xdHM4cC9wT1hGMFJSVVJCYlJHR2Vub041VDkvRWcv?=
 =?utf-8?B?MUxvbFY1SkxWWW1xRTBadnQ1bWpGUTlTY0owTmtKeFp6TnJSVUd2TWxjS05R?=
 =?utf-8?B?aWUzc3NKNTFpNXQrZzQ0amV0dzJaKzcwVzBoQVlLR05yYjA2WkNmZmM1T0hT?=
 =?utf-8?B?ZnE4L1VoelMvcFFWc1pOOE00RUZrTnprUVE3QWQ4TGZxdjhsREhzL3hqL2FC?=
 =?utf-8?B?V2cwRm1vWVBFN0tDMEVmWitpK3QxK3BrU3N0NElCWmdTbFY5Y3FXVUlITGpj?=
 =?utf-8?B?NU5LcW1sVXlKTHBSSGxxTUhiL3ptUW1YT0FwdXkrNG12RG5UekI2ZG56Uko1?=
 =?utf-8?B?aVRKSVFpVVNxSHpVbCtYbWhGdktObnNQcVBNbEZORWVMdXFtNHF1c3R2ZVM4?=
 =?utf-8?B?bG9OWWdPbkduRTJSVldteEMyWHpFellRTXNIMkxwTEVNYk9SOHZoTzFRcFp6?=
 =?utf-8?B?MEtRdmkwNjVjQXd4R092aHVjdCtoY2k2Zi9qL3EyUzIyOUM2K1BTQlZ2RWlP?=
 =?utf-8?B?MnRvRG4wekMvMzNSRkxTYjRXdDlSUXJSSmlqSnVTYlBoMkxXblQrUE5vdUdG?=
 =?utf-8?B?ZDJrcW9YR2gxNkxvYyttdFMzTGdMbzU1WVl4MDYzbDB0VmJCNFpRYldpZFIy?=
 =?utf-8?B?WnFjRzM1N0JPL1RvTjNncW9sc3lrcGVhQWlteTFCMktmeU01d0NHWmdHZzJL?=
 =?utf-8?B?dHR2cHB2RTZVZlhnZ3FpYTkwcWxIMkNxOThsMFhIWi9zNnpMZHRlU3k1MVZT?=
 =?utf-8?B?L2drZlRURzBJWnlSRmtvZmNqNWRMekJ5VFBuNWRFRUs3OXF2T2JRVnE4aFhh?=
 =?utf-8?B?Z1JTQWVtaDlndHFMK2o3SGRIWHQrSFR4clpuSDhSUVJVSUJGU0FCemY5cUc3?=
 =?utf-8?B?S0dOOUtiVTdvUmVvbk9YbmNlbE1MWmNhUTl4MEtrb2srVE1UeVBmWGZHTmQ2?=
 =?utf-8?B?M0JtZzE5WVdoR3hCRXdwa2NHMVIySG1ad2g5ZFlkRE1VWGZtK3k3LzU4eDlj?=
 =?utf-8?B?RTBsd0o3NnJIeUs0Vno1WVRETk5mbHJ2dGcvSUU2dlJsWlAzQW41dGZ5RUpU?=
 =?utf-8?B?d3hjT2RRRVdBeXNvVVZwWUd6THFveERoVFI3K1VqUEhkd0pJbXFXZU4wOWF4?=
 =?utf-8?B?ZGo1eWVGYkpiWnJKVysxcUgrK08xK3NFdk00c2NQc1B6ejQ2dHZneFNzaU9j?=
 =?utf-8?B?cGZsaDRzTWhhdWhEOWtORkRMWElRbzkrSHcvd1ExeHlCRHJQTlZqMk5QWndM?=
 =?utf-8?B?SjA4Sm5VYzZTUFpPZFJMUWtlR2hQRGNZTXhhQis3Tmd4c2VTb1ZSb2ZteGts?=
 =?utf-8?B?alhmN0RYZHdNLy9teEVGYTdNZEN2bytLVUFGR3Q0L2tlT0hJdHBJMjcxN0dK?=
 =?utf-8?B?VmhVcUpNK24rYmxDbGxiZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N21mMVgxR3Mzekd3NkZJRlVubFQ2Q0Y5UGMxMU9qM0VmeUVjajBRdkwzenZW?=
 =?utf-8?B?aUxycXlwWFdDOUtkZHJYT2JmSncyaG95OEdJK2dwZFRydHhmVnhvdEdYZjdG?=
 =?utf-8?B?eW56QkQzYmZTeHFDQ1NyV3JrWi9od1pudUtmaHkyM1V4d1VYazgrTVNYanNU?=
 =?utf-8?B?TFIvaDN6Y1dDbVlvb1Y1TmFjdWpqeGdDdDRhTVY1ZVJMOFQ4NjM0TGovNENu?=
 =?utf-8?B?ZXY3RDh4WTNTY1puKzd6VmxLOHUzOTJYZUJScytIcFVFdGRLbFdXUzhDRncx?=
 =?utf-8?B?MXg4bUtzNVhoSkdxeDU0cnlsOUNnRU1rZ0lmUFVEMHFyN2dNTU92cUVJbVZa?=
 =?utf-8?B?cXZxWkpac0ZuSVRXQXVwZ0NWRjFEbDBiMmpTTGE2MFVZd0dXUFVvU1hkZkNo?=
 =?utf-8?B?RG42bHgwd3F2dXBmOGh0MDdiVDFVRkxwclA0OFNJNnAycHBRUXZHVTR4TVlX?=
 =?utf-8?B?WmxndjVuTDJsc21UTjdnbUkxOHUwOWJibHcveXBaQldPd21WeGhRUHFEZ0Fv?=
 =?utf-8?B?UHp1MVQ0K2NHVnl3YXhsdzZlYS9POXpTWXFTZy9uMitPcmtqM0lraFZBOVlq?=
 =?utf-8?B?ZGNsMXRHYkdHMVJjZXZiWTRocjFnUW9TdWdTN0U5Mkk4ekVTbSt3Z2ZXVk9x?=
 =?utf-8?B?dkNuZGZEKy9RZnhxdG1URjYvQnEzTC8yTy9OTTd6cEJFaEhJekZ0ZE5DSjBn?=
 =?utf-8?B?cFV3SWZvOUduOHdocFdJRTVLS1pwQ2l2U2NQWGVNNWVjZzE5SjdiWDhYVDhP?=
 =?utf-8?B?RVJvKzB2b09pcnkzelVpSThrVU9TdUw2a2xBalJHdHFkbnVpSDdzK2VPWjlo?=
 =?utf-8?B?dGsrNWVlM3ZCRFZ6ODQ2VUZ0b2VYeDJxU0tVbUdEQjhUQ2tnQ0kvYWE1UVBz?=
 =?utf-8?B?WnZBMVJwKzh1eWFGZm8wcVRLdUlGNTYxckp5MWdrSmhZY1lLOGhoZkhUREV2?=
 =?utf-8?B?OERMYSsvUkJzYzU2bEZzUFFiTHFSVzlreHRRZDgwYlNVeWdxaGVpZXpIZytB?=
 =?utf-8?B?anpSVDBaSTBVVjJpQjhBTE9uU29wQzJMYjh6N3FBekwrbS84aUpPZVdXMW5r?=
 =?utf-8?B?WWpOc2RFQ0Y2cWNiNWFkK21WYlpyWjlwNVZCcCtkeUhEN0xTd1lUTVZKSWhu?=
 =?utf-8?B?Mm5vWWI0cTRqcTNLWUQyY2FZck9QeHhPbWFKS0JYN0lLaStxZHRaZkwxZklz?=
 =?utf-8?B?MDdNSUZ3L2FnTVNrN29sellEemE1RUJYQUd0YlF0RjlDWnVRUjlTSnN1K3ht?=
 =?utf-8?B?dHVHSmpNalAxdFAvUFBYNFRBQ2dzZko4UVNSeWZGaG01M1k0cFpxMnFNaFFa?=
 =?utf-8?B?MDlTdUtKN0hIUE1KQm1MUXdlTk9aS0lQY21oMFlUd2EzMGhuOXZJZXJVLzdX?=
 =?utf-8?B?L0FOU01JNjJBZEQvMzZ2cjNWSkcrd1diNmVLMW5IajRCamlENERwZGlVZWc4?=
 =?utf-8?B?aXZra2NJZlVFSzFJcDJXMUZOSm1TTkZZaE02TGFKWUVMbVE2cUJQbHgvQ0ND?=
 =?utf-8?B?eUJvN2dIcW44S0I3azZKdTFPcFI1RS9yVFRoMEk0RkZzSFVWc242dnpQTXNL?=
 =?utf-8?B?NVJJZjNZSnpPbnp5Z3VIbmN0R1VwaUxjSVpmdURRVkNkSW1tRGtBbm1LNUc3?=
 =?utf-8?B?RlNUK0tDYkI5b3U4UU94Q0pidCtnVkVhSUFGQUtuRDNQVUlyZmpQWkxzMEdZ?=
 =?utf-8?B?bUVDYWQ0ZTJ0emZLSGwwQ1daNGRHaXZKaGkyMGxYc2FvK3JRbTMwTnp2QWlN?=
 =?utf-8?B?bWovU285MTV0RHZORExQajExcFYzUVFvb1dYejI4RDRYaTRyZUhpN21hbkpa?=
 =?utf-8?B?NStEVE5KcWVKRElGN2Z4VjV6amhEVGE1TXlEUnVwM2Nhcndsa0t1VTdNbXBw?=
 =?utf-8?B?Q0l0MjdHdWRaTWhmbHFvNHd5MU1zQTVLMlliYjJkbDlTN05VVHhJOTRyY0ph?=
 =?utf-8?B?RmxKNW44eTloeEhESkNQNDZIM1hic3IrL0h0RURyN0haUWlmeWkvbDJxWHM5?=
 =?utf-8?B?TGsySWVBN1R3NXJQN2ZaaE9oeVVKbTlFOWVrM0prQlZpd3owS1htUloxZWl1?=
 =?utf-8?B?bWx6dndBdExJZXVvVlc2SXM1MENWaHVTVlA4Ync3VnJhVUFyY2pmTUFpa2lr?=
 =?utf-8?Q?aVO9LfFOE1FJwDwNtS6xhIzSU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CD02006A488EF4B9F161517E457B41D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52827d3b-0a40-4eca-1451-08dc67669697
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2024 09:35:49.0382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iYKYlZtNGvTPtmc7e+r9dFA4ZgLfoa2CY04CDLOswW1icrl8JoWb0K3nKMLwR06dOC7G0hXOs5cScpLVmbjzRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6251
X-OriginatorOrg: intel.com

PiA+ICtzdGF0aWMgdTY0IHJhcGxfZXZlbnRfdXBkYXRlKHN0cnVjdCBwZXJmX2V2ZW50ICpldmVu
dCkNCj4gPiArew0KPiA+ICvCoMKgwqDCoMKgwqAgc3RydWN0IGh3X3BlcmZfZXZlbnQgKmh3YyA9
ICZldmVudC0+aHc7DQo+ID4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3QgcmFwbF9wYWNrYWdlX3BtdV9k
YXRhICpkYXRhID0NCj4gPiBldmVudF90b19wbXVfZGF0YShldmVudCk7DQo+ID4gK8KgwqDCoMKg
wqDCoCB1NjQgcHJldl9yYXdfY291bnQsIG5ld19yYXdfY291bnQ7DQo+ID4gK8KgwqDCoMKgwqDC
oCBzNjQgZGVsdGEsIHNkZWx0YTsNCj4gPiArwqDCoMKgwqDCoMKgIHM2NCB0bXA7DQo+ID4gKw0K
PiA+ICvCoMKgwqDCoMKgwqAgZG8gew0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHByZXZfcmF3X2NvdW50ID0gbG9jYWw2NF9yZWFkKCZod2MtPnByZXZfY291bnQpOw0KPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5ld19yYXdfY291bnQgPSBldmVudF9yZWFkX2Nv
dW50ZXIoZXZlbnQpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRtcCA9IGxv
Y2FsNjRfY21weGNoZygmaHdjLT5wcmV2X2NvdW50LA0KPiA+IHByZXZfcmF3X2NvdW50LCBuZXdf
cmF3X2NvdW50KTsNCj4gPiArwqDCoMKgwqDCoMKgIH0gd2hpbGUgKHRtcCAhPSBwcmV2X3Jhd19j
b3VudCk7DQo+IA0KPiBJIHRoaW5rIHRoYXQgaXQgaXMgb25seSBzYWZlIHRvIGNhbGwgdGhpcyBm
dW5jdGlvbiBmb3IgZHJhaW5pbmcgYW4NCj4gZXZlbnQgZ29pbmcgYXdheSwgYmVjYXVzZSBvdGhl
cndpc2UgdGhlIGFib3ZlIG1heSB0dXJuIGludG8gYW4NCj4gZW5kbGVzcw0KPiBsb29wLCBhbmQg
dGhlIGZ1bmN0aW9uIGlzIGNhbGxlZCB1bmRlciBhIHNwaW5sb2NrLg0KDQpJTU8sIHRoZSBsb2dp
YyBhYm92ZSBpcyBuZWVkZWQgYnkgdGhlIGhhcmR3YXJlIGV2ZW50cyB0aGF0IGNhbiBnZW5lcmF0
ZQ0KaW50ZXJydXB0cyBhbmQgdXBkYXRlIGh3Yy0+cHJldl9jb3VudCBpbiB0aGUgaW50ZXJydXB0
IGhhbmRsZXIuDQoNCkZvciB0aGUgb3RoZXIgUE1VcywgSSBzdXNwZWN0IHRoaXMgbG9vcCBhY3R1
YWxseSBtYWtlcyBhbnkgZGlmZmVyZW5jZS4NCkhvd2V2ZXIsIGN1cnJlbnRseSwgdGhpcyBpcyB0
aGUgY29tbW9uIGxvZ2ljIGZvbGxvd2VkIGJ5IGFsbCBQTVUNCmRyaXZlcnMuDQoNCj4gDQo+IEkg
d291bGQgYWRkIGEgY29tbWVudCAoYWJvdmUgdGhlIGxvb3ApIGV4cGxhaW5pbmcgdGhhdCB0aGlz
IGlzIGFib3V0DQo+IGRyYWluaW5nLCBzbyB0aGUgY291bnRlciBpcyBleHBlY3RlZCB0byBzdG9w
IGluY3JlbWVudGluZyBzaG9ydGx5Lg0KPiANCj4gVGhlIHJlc3Qgb2YgdGhlIHBhdGNoIExHVE0u
DQo+IA0KDQpUaGFua3MsDQpydWkNCg==

