Return-Path: <linux-kernel+bounces-135891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4A689CCBA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBEF11F22FC9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7E8146596;
	Mon,  8 Apr 2024 19:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QD+qDGXy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D9A14600C;
	Mon,  8 Apr 2024 19:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712606264; cv=fail; b=iJk0hlcKwQFWKcefUmEmZwYgDlDSjKcxP19C2iSZJt+huCTkugVxAYAD2W+RQHxu5FrToC+bFV5AezvfRHbPOFdlUHiW6gfspAnDuoisVBuBoZuuN/y+HbxyfaRrr3TxmE3Chfjx3te2COjJbXkenFBUDXhsBlo2ErNVkAtl1Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712606264; c=relaxed/simple;
	bh=kvU1ScUvjo74n1lA3FRqbxg220YQ9Vlwdvw+U8Id8k0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=upotzvDG/kYrehrxIKx26uoEzK0xdWmIyDG46AL0Rp8rkEUCSUgSNSHGK2F3Xwbtv4KQLuofzt5pem6FXEyoC+Vo5d9Zm+RfMVCG+wWtQ4aE76wS26ieyJsX3T1Tc7eJWBqvdKIAzIQjit6tSyn24a7KvyHoJGxxeE3xrYRDZKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QD+qDGXy; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712606263; x=1744142263;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kvU1ScUvjo74n1lA3FRqbxg220YQ9Vlwdvw+U8Id8k0=;
  b=QD+qDGXyvs0jcTKrG+e/g7yS5fW/cODCdWUTzAcqZdo4tC4j0icc9jBq
   n4vsitGtIQ2S2vzuf6bIBjAzKYHFTClDQ0jKctpRh1Uz/swVJct/v/byh
   audTYzH52AxAPK8F+c+g95dBzcV5qVd/8aV1msPxz4cJfaYEpDEZY1F3z
   0YoHmryr8HPrKnejNS/28xmb4JslBhF4IkFqhaZbpCnzd46GzwpE1af+Q
   gcgk7B13e3YtfqtA7VgKISnn4ITGdgbRNej1vPHn3TEZf9v1qfyujAz0A
   f0lHmugm+hB2WKsEl8D3fN/qiLJ6yCUMqsnEnYJ/OGL/t+IOPflXGgPlI
   A==;
X-CSE-ConnectionGUID: GFbl6oXLRwiIcjS2yGNYOQ==
X-CSE-MsgGUID: VZ/jUhKkRuGioR1ycEbwWg==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8005142"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="8005142"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 12:57:42 -0700
X-CSE-ConnectionGUID: SRPafl/7TSipmDRQHcxh0Q==
X-CSE-MsgGUID: fYNyqlEbSpa1+e68Fbaehw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="20082041"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 12:57:41 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 12:57:41 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 12:57:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 12:57:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 12:57:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlZAzNgc/QdaYIaOk0N02SDTF3i7JYvXgxs7r8gElwfgL/lT4z1xGutHBGMnFzQwzc9crUIMf8jPOP+TR/9BH0n/Z5/EcNTiHMYbQiTwbUlNRBG0dqixk5bqJYaX7U8TI9hE7h0rjWu9ndDN8g64muYUx+4uUfsdbkcg+rikeLwcRva2qKHK4hX6DPOFitH8XxmHP+agfWJBbOsiU0TNEiq1OOeugO2r0ufx0ilHYYigDBHukqRk82yUuPRoViAdektVoiVZEPT/2JZqnYBBrXEckex3Nff/5iF0m7w67N6Dc2EI7/H95ZNwXNH/O1GFQF2VHYdZtJLSqerT+vLDkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvU1ScUvjo74n1lA3FRqbxg220YQ9Vlwdvw+U8Id8k0=;
 b=ko/9XGW9Oi+4nvr2fQBkbJvPerQBEgWZdaagHzvP7X+dguf6GsUQMmdMSPtmQUPCkwbIG5jKHpIy7WHwgqqHYYmDya4jvcQTw1N1d86uHF7WmRWreHYYSTaQbF94xOiJ/BMrIvtJLrkABHpA+XRHWJGq2c+2gC/LMvKh0TSvTtFjBM/pPhCwYvDjvCcS6DKkSdGRGGOXmQZw1mqEAxkUhObkx/OoeWcxYjfv6y6Si+zJwGpKu1Az81BsPPqd8Rm8LGmH5DDEm63DDJ6Wea+/2YMUPQuvWa46FazEWW1cC6w8xh+EQMGUEddDPrZ+5hOheiM4UnTnSMMQevVgcOv/4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS7PR11MB7692.namprd11.prod.outlook.com (2603:10b6:8:ef::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.41; Mon, 8 Apr
 2024 19:57:38 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 19:57:38 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Naik, Avadhut" <avadnaik@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "Avadhut.Naik@amd.com"
	<Avadhut.Naik@amd.com>, "John.Allen@amd.com" <John.Allen@amd.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [PATCH v2 16/16] EDAC/mce_amd: Add support for FRU Text in MCA
Thread-Topic: [PATCH v2 16/16] EDAC/mce_amd: Add support for FRU Text in MCA
Thread-Index: AQHahqLS7zyVgK2sqUK2yq9QKfANxrFZ2C2wgAT11gCAAAIl0A==
Date: Mon, 8 Apr 2024 19:57:38 +0000
Message-ID: <SJ1PR11MB60838B718317B171D2935C16FC002@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-17-yazen.ghannam@amd.com>
 <SJ1PR11MB6083683CAEA79F935BFA1B31FC032@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0c903e3b-093e-461a-aa70-c2d58fc6d82d@amd.com>
In-Reply-To: <0c903e3b-093e-461a-aa70-c2d58fc6d82d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS7PR11MB7692:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ux5GFQdORtismHzRbeeFrwh0djZU+jHWmACcwZVRpCjupjo/ak8YJ0QXKbsHMqeCmNPJoDtqo46ZIjET2FvhXLGvkns/TjkE3Jhm/0QoPW6jASdad76AfoGbmCMWIZmzvhsYhIBwLosCmGS5HhYHmGENKEG2GlqYYpOEW3xIKgzbjhwhliSQP1GTt2D6S5cL2VSFld+rrqU4CJsqeo7F7xlVyB9CyD4/ZCyTYN0OJO3QUBYE76aXSm+pNBXPOSzwxMbZ42x5z8uUNVi/ILrkdPh/4qBVd+shCdR4LPfsGKc8tQvwcnD3zK0vxtdY6/IT16aqJeS9LLe1LYy3lfhJlUyjSzn+gDgQa0a/YZFTzc0CLYtvYyj27vVq04O+o4vCj76SGcYglynSL66TfkUmRVhER4XnQspdWwXNSTA5QJ5cmvKxU6yHlId3iEXVKoxOnCMoyMV9n7DNGgH26GLW01uk0bPtZ+bXl7QBTZY61KooxD3Ddr16ve3LDClkDEiZe/I7L51K4FHJ1ogN5hm5Vhk9tn7pgTokay43OEEBpZ4qq7J7i1lQ7BnvUKNHTocpzlQfmsMO7W5kccyJjLgYbwDgn4b7Jvrk2W1GuUVfatOb+0iSL+6Alkn0O6iEOyk16KJEQbFh/LpDIsbk8qWOnZ6tTWj562DY9n/NLXKSmsE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0V3Y2tMYzBPK2ozQ1h4OEVLTDZaRzdxTER0WXEwdlpoTGppd2NaZ25oZ1Bq?=
 =?utf-8?B?aFN2cStWVW5aTThFZ0Q4OXU3OTlCYlh0ak9YdE50cnM4Z3pHM21xZURKTHlJ?=
 =?utf-8?B?bDIzL1ZjclJYUDJCOTNIaWx1WTdBZHRUSlZoTEY3Q3cralRZbzdNenA1ZSsz?=
 =?utf-8?B?RWRUV0JWWDNEMjg1TzdnSksyUDQ3Z1JEQkplZlo2cGVTQnZDNzZpUVNhYjd3?=
 =?utf-8?B?OXcvcURvZHd2Vyt5Mm5hbG9obU4yZk5XMWtkOFkrT0lPMGhmQmhQWEpRZ3dR?=
 =?utf-8?B?TURmQk9taCt0aWMrVWs3T083Rlg0NzE3Z2RZWkowT0h2Y3ZVWmJsTks4blY1?=
 =?utf-8?B?VmQ5czE4cUJLUHVscWFXaE9WdkErWW5MczVmanB0RkdaSlAzRU9qeWZEbWdF?=
 =?utf-8?B?YWs2akZpVUxxMHIrRWNWQlVadDBaVWZXRWx1K0hndWNrNE9Vd1U3N1Vvczdk?=
 =?utf-8?B?LzZzbTNEb0V1YU9TMkkyUnU3N3d0RHNkQ3EyVmNWZDQxMlRza3h1VzhsdEZQ?=
 =?utf-8?B?cFVUUFg3RjZKV1lHVEVyTkl6eDVwTUxwYTlWZWgyL2RGdjRUd1dhbGFqYSs5?=
 =?utf-8?B?NGtZdGZ4L1l2cjJzUGdWQXozQUpCUnNUYXFxMldvWHI0a3ljUFdjeXpMNVdE?=
 =?utf-8?B?NjI2TU8vdWkyVEQ1b2JHM3oxMXRWR0NHOU1tOE9DWXRvUWRvS2FnQ2xIS2tq?=
 =?utf-8?B?ZW9sR2dUdUdvaUREQWhla212QVJkR3dmL0tkVHJxOCtWeVdSZU16YUtTSE1I?=
 =?utf-8?B?dnBQSzZ3YjJkK1ErcFF3SXlMeGdwUVZQSGJSMTNvTHhyM2xjcjdlaU9DcnZj?=
 =?utf-8?B?VTJONjYxdlpmNUlFTTRsZisybnJpTVBubzRWUnpMQ3EyNnRSWlhMRU9SS2Vh?=
 =?utf-8?B?dEoyUXowb1V0bm12SzRjcFA3d2NGSS9EeU4vNzJUdlQzM3NTeGJnWFZsWVdM?=
 =?utf-8?B?KzBIVFRqNHZqVE1SclVjUXRja1VFZ21UV1hHdWsybU1USGhQaGUwYlRxc2pP?=
 =?utf-8?B?TlBBT04zRmZiV2xmejFPU296YlBrdlNuRXNUd2Z1bHkyTDRkdHpuakNjSVlr?=
 =?utf-8?B?ODVuWm9Tb3cvdmZobkI2REYvV1U4REwrd0Z5TTY4cjNhQ0lsRDlrQmFFNmxM?=
 =?utf-8?B?YVFmYkdZYzdWeW45S0F5bWlFSUtzb1FKY0s3VkVKYS8xVzdqRG1WOVRyNWRG?=
 =?utf-8?B?aGpoS1pMdXNEeDRKVkhtcFFHUG9TSmprbGorRXBvWUUzYWpwbzM5bTNpandq?=
 =?utf-8?B?ZnNXUmJYaDhQeUV4ZFp1RGdsY0dLOUkxZGV4YnU3T0JKeW00dFpXTHYrY1hj?=
 =?utf-8?B?RU1wQ3ZIdGpaVDB1cGU4bWFNRzVXMndPdjJwejBxdVArYzhJYVV0bTNIM0pt?=
 =?utf-8?B?TmhwbmtzT29zV2hZMmFacW1aVmFCQXpzTjc4MDZnMTljaFF3U0l3Q09FVGUz?=
 =?utf-8?B?U21kWkVOQjJMUTk4V1Y3eDBzV1J6WGJob1g2aHhVR3VCMzFjbnRON3h0ajNQ?=
 =?utf-8?B?M0Q5bUplNmdtbzNLRmF3WEtKWC9mb1cxaVVRK2w2YTlGTmh1N2ZVSGJxT3JL?=
 =?utf-8?B?QW5lekN3RzdqYWRDYlZrQWZCZVp4VTI2aFNNdGZLR2RpVnJwNldiSXRzTzZz?=
 =?utf-8?B?QXJqclZvYUQrRVB5QjFqd09CMUhJRGUrRTF6ampFTHJnTDNQR2VWRXFrWjZM?=
 =?utf-8?B?MEdTVmI3MFVNdkMxOGRXeXVydHRGRE5YaE4xcTRlUWNrMWxraERiWXBhL2Jt?=
 =?utf-8?B?QkJRMHZQN2xjRkRtL3kydVg0TS9zK1RRbTAzUlpmNnp2UkNTRXdKbURaVHNV?=
 =?utf-8?B?bXBwSENUYkFjSjZPVlhPaFhYMWh1OXd1WExia3lqR2N0dnVWbUtyOE5hRWNx?=
 =?utf-8?B?REZiaXc1UnZNKzdsRkI3eHV3TXV2SXp3MTh0VjdnWk1YRlFiTjdldS9KanNm?=
 =?utf-8?B?WVpHRXVDb3AxL3NBby9rdUtNampFT2RJWVF1QS9QcC9Lc3ZSb2RqTXgyUnp0?=
 =?utf-8?B?NWhRZlNaWmkzV1J6QTZIRTFIOVYrQlZ3WVEyT2hkemM3UUIyTUU3ME9DTWhm?=
 =?utf-8?B?YjJsRjhjaDRZbDNCNFNUQjN3MmR5WE56SFdaZ2NYS1M4N0k0dG5hYmVkZlN4?=
 =?utf-8?Q?8SYy0D0evaqi7IIv0ck3HrlQx?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d682c215-b20f-4b46-a144-08dc58062495
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 19:57:38.6293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /WzyGQO6zpSTilCW8jVBBVvIu7GPZpc5ZphvqhycxtovSOIbSm1nyzmzCjaz9p0HSm4LiORfrYafge94NiKAXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7692
X-OriginatorOrg: intel.com

PiBBbGwgb2YgdGhlIGFib3ZlIHJlZ2lzdGVycyBpbmNsdWRpbmcgdGhlIG5ld2x5IGFkZGVkIGNv
bmZpZyBNU1Igd2lsbCBvbmx5DQo+IGJlIGxvZ2dlZCBpZiB0aGUgc21jYSBmbGFnIGlzIHNldCBp
biBtY2VfZmxhZ3MuDQo+IERvZXNuJ3QgdGhhdCBhbHJlYWR5IHNlcnZlIGFzIGEgdmVuZG9yIGNo
ZWNrIG9mIHNvcnRzPw0KPiBTb21ldGhpbmcgdGhhdCBJIGFtIG1pc3NpbmcgaGVyZT8NCg0KDQpB
dmFkaHV0LA0KDQpZZXMuIFRoYXQncyBhIHN1ZmZpY2llbnQgdmVuZG9yIGNoZWNrLiBJIHdhcyBs
b29raW5nIGF0IHRoZSBiaXRzIGluIHRoZSBwYXRjaCwNCm5vdCBhdCB0aGUgYnJvYWRlciBjb250
ZXh0LiBTb3JyeSBmb3IgdGhlIG5vaXNlLg0KDQotVG9ueQ0K

