Return-Path: <linux-kernel+bounces-94992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 383EB8747E1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B51E51F22D5E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 06:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF33D1BF20;
	Thu,  7 Mar 2024 06:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TUXLIJi6"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427E61BC56;
	Thu,  7 Mar 2024 06:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709791608; cv=fail; b=hkxCn9U4YRe3d2hOat8BeaxS4h1T+Kku4o3dwg/kr5k8U1qQb1wVqIVFIEYYnDtbmX+AJpjxmhCfukqItUgduetP3FEcrIhghq3NwDwLqRHxooZheNJ6V4Oa9PkR2sXfxlEHc9uRj4jc9wJZ1MA+A6KkEYRxcaN3Nsf8ZTsKtVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709791608; c=relaxed/simple;
	bh=iFEwQNaZBo+/vW670/E2RESbS5d9liyM2LEoA9kkKro=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c/FSTb25hofZqohkCw+65790RQfNXaoQr77VDlT1u9qiG6dL9A68vMpB7oiYeBvvLOEHqeahIhyveiQOKYr73J2w0qeJ1y/Db6nzFvwQomzb3Gu0ocmhcrsU84q1E5Cq+D4FrQWjaSOx3f9wsC5gYZ1KiEaEmlbabfyKx25ZQZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TUXLIJi6; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dz1FSVc35PLNUtHIi76cUIV5YfOEzrb/PKjXOZDHAdnsu8a0KN8GWCejyWKgqnL0c7lEEXYdW7+swWbMiDQGZVp9R5Ftfz2r2YxBg/c5eHOCYQO9KXENOJdKuBvJaLzVJmTlmaZs/E2Q7zF4zTdwyWuF5tmTFgeVb7Ew8sQmMEEHh0kaB4wLcnJ34krChOieldP9+i2q9t/G/SwmX3dW0ohCQsuSuhPR9oH73BxPKxHFY+JI1aM2ouLs4Fy8ZJAZSpwDGRwquyTvVW8anIbqyGTozoCJiY8C9380ad3QC/RF7kvjSvuUcwp1Iop9lHLPrrr10aHDKOiusFmYKjcs7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFEwQNaZBo+/vW670/E2RESbS5d9liyM2LEoA9kkKro=;
 b=SWDJINKR/G9z5L/f45yEX+/49aA1FNqj3JgOxNPNkFQ51B1Up9mQUW6xnB12o6HqzqBZBAM/InPfg6PdUvbh9Vih2LYG+FxnZWA2B8gQwfMSWcCI576oIM311I4wJrrzIx7UHApUhY+k2WwEP3QyCwamGsjz9+kbavj/d1Uvdv/sF6bRv0hU/Mb2MMaErfstBt8pPbbdCeCImf5QjXGBl4UGlOM47JVQQWiF5l6HCtrZ3k64frINmMJwwPkhtz/t8UC6Ib+Y0dfXY0u3+EmZM4mWWM9uqQSwz9PfkL9ybMqWRGePY67pIyvwHs04L1uCuIBf1g36PZNvOWZuL/scmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFEwQNaZBo+/vW670/E2RESbS5d9liyM2LEoA9kkKro=;
 b=TUXLIJi6AgDG/Qj0veMWlPS6P8lsGGIaPQWB2nKktC9JqzKfVpvhv2xrWMq2HCemghWlzAYap/LVEr5BbxFC3+k6fTdgzb5QR9rqhJ54ePOgqBgNpd6CNSHnsEe90U2uBnSwwFXSB8+u+xv7RgLrTpKJcvgBlDAw+pvxeM+vKmc=
Received: from PH7PR12MB7284.namprd12.prod.outlook.com (2603:10b6:510:20b::18)
 by PH0PR12MB5630.namprd12.prod.outlook.com (2603:10b6:510:146::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 06:06:45 +0000
Received: from PH7PR12MB7284.namprd12.prod.outlook.com
 ([fe80::60e8:2b67:3927:b3bf]) by PH7PR12MB7284.namprd12.prod.outlook.com
 ([fe80::60e8:2b67:3927:b3bf%6]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 06:06:45 +0000
From: "Trivedi Manojbhai, Naman" <Naman.TrivediManojbhai@amd.com>
To: Stephen Boyd <sboyd@kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"robh@kernel.org" <robh@kernel.org>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers: clk: zynqmp: remove clock name dependency
Thread-Topic: [PATCH] drivers: clk: zynqmp: remove clock name dependency
Thread-Index: AQHaPhVjvmRGRPQ6SUKSkOvyusaGNLDI1osAgGNW7YA=
Date: Thu, 7 Mar 2024 06:06:45 +0000
Message-ID:
 <PH7PR12MB7284F36E51750D47102410448A202@PH7PR12MB7284.namprd12.prod.outlook.com>
References: <20240103072017.1646007-1-naman.trivedimanojbhai@amd.com>
 <55fd522918aa41f386e01432248933da.sboyd@kernel.org>
In-Reply-To: <55fd522918aa41f386e01432248933da.sboyd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7284:EE_|PH0PR12MB5630:EE_
x-ms-office365-filtering-correlation-id: d5a2437a-1756-46b1-2eef-08dc3e6cc45b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 BJB+Y5ClU5hJNWQJ+uRgRNjCbRCp9vGxxUK8m9vA2p38LYjfiHINdU7EEuXSZNr86RDmd+0coKD1ddeHgKXMlyYLX035YFYZLtEfQ4iDZNC/h54a9FhC+kg1Jfh9I4czA/c8vyzYJbE0OpuFPkgY6p/QdoUkF9XsX9BdZm3urrTdmUyNpqkP/Aitvd0DYEeyH8+Gn1n9j2hwyLoEvPbJJiRZa61AvsDZXLZb/zTvI39uEdWgP0O2YkSBhGvvwd6xMzBLToOnETegNDBX8DsucPI9xIPn3IM0oBXAPI4T7qgl0bHiM5nvJxAudDf9U3OLuiDlleUY0K+gEDT4jaxsm//pO4DM7QQ4as/ZRVhZJSqE5uoHSE+2CB1xCx0iYtJrNJ8vzJA5Zi3ldY5BxXpOSSOAOnWUS3i0rYLDl6IhM6Y+zOT0Zh+FFH2CjV0VzqCtyJQdCTTz8WFQCMP8yWdR6YHqTF6RA93bTv0NWgnmHzBnkswiwLnz/GCR5NTvh9peIP9VcFA+6gyIQBiQ8OZ3yw5VvmgDqT+8A4PswRgeZmUA/pTWffQD2JoC5mLX07QJeQnGqcFHpFr4FtXzN63IDQYBVB8VRpxqi8fpfWqc8F5SQZ1CS6xROl6AWwmmJQ7R9gsvpK1JR/Q7uuPKLZnHZrZKVa7VnFb5d9Z3xVol6VyPRv26dJAQ8xyJ6VUH/j+Ud2Jlpd4UkOxIWaOia8UeDL2t46ZQ3bjFpfQx5lFWDr8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7284.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T3UwOGFiQ29BOVdjTnl4RGZmVzFmbS9GL1BBa1F0VUo4ZitBOUVTNG5ENE9C?=
 =?utf-8?B?ajBtZVNQbjc0YzROOFMvTU5uS3NKdFFBY1h0bjF1L2U2VDdOQTJxY2gxdjFw?=
 =?utf-8?B?aC9SMTU0Ti9XUFY3dzgxQ1dzdm1jZnZtUmVISy9uNDZ4dEpzaVdaM2Z4bEkr?=
 =?utf-8?B?Z09yMUlFY29JZldWc2YwTXVxNnZIWDdCd1ZZZDRBSElwVzhsSFo0TDZYLzBp?=
 =?utf-8?B?TVY5Q2lPOTJibHhCUVV1TnVIRVAveUd3SDJBVDk5ZSswOVhkR1lLUERLaXBj?=
 =?utf-8?B?aXpmK2M5c0h4QzdZc0k1V0hJaGROVHhIbnloNzdlam1XRVhvcElVNkJXQ1pB?=
 =?utf-8?B?bnRXd2VmZU8yMHRsRWIrNTg4bWhIMzl0WTVKWXZ2L2duNEZUMzd4NVgwdXMx?=
 =?utf-8?B?TUpGOFBIWnIwNEtCK3pod2lmMlgrZ29xOC9MU2xBQzNFd01PWW9PZFcyalJj?=
 =?utf-8?B?YXJ4ZlhMUDdkZ1NENVI5ekVQdUUxbW9aOVZzNmhMc2J5ZWlVWWM3ZTNYcWUz?=
 =?utf-8?B?aDZPK1NnMVNacm5nUXBDam80aUhHU0lHU1ZKYWxwdjBKZzQvQ1kxRU1CRUxs?=
 =?utf-8?B?aElVWm1YQTNicVo2ZTI3aXhBSW5qQ29ORzFxY3ZKZW9aa0NTemFXbU55ZTh5?=
 =?utf-8?B?Um1Uc3loZ2FaOTFuYStQQnp1Q3VrZmo3RjFUMjBjTVRFTGFYUVF3QTltcGhw?=
 =?utf-8?B?RnVoN0tBaHV6TEtzL3h3cnJqell2K1IyN3BtSGNxaW9PUVV0TFVxM0hQcDhy?=
 =?utf-8?B?YzZKM0oxMWwxSmFHNHJ1VXVldGxJZDVpS0tJOFl3ZEpyUnIzNzhSNVR1Rjlk?=
 =?utf-8?B?ejF1cnpqZVQ4UVo5N1ZtMXJuK0lYK08vKzNmWEJVTFhBajhKWkJUSGFNN3F5?=
 =?utf-8?B?YWdabmloaTdBV3pYZHJ6aDlmWXlNZmVTc2k0YmRTLzRKNUpqMnJpcG5CNGN2?=
 =?utf-8?B?UDRDdW1hV1Q5YmxiKzJvd0F4Y1lFZVNIV1NzNEo2OWhDbXFkRm1vdVhQbm5v?=
 =?utf-8?B?dGUxVWJ5UzBpQWUxZlVidHhGcS9Hd1Y4aHd2SUtwWEJHb25rcHhwQVJva0NJ?=
 =?utf-8?B?MjJqZU54NFhLUUd4RWZGWnNMRlFBTG1MOUJ2YWlyZlkzWlluV05uTzh2OG5P?=
 =?utf-8?B?MXA1QjZMMEF4YkFhekJ1YXpUVmRqYjB4YUZrSlhMbWJoc3BJbFZVVi8rbEp1?=
 =?utf-8?B?ZUpMN29UQnc0MGlRQ2tFMjdyZElJMVpQUXhIbm5tSXN2MGFQc3V5RThzWWpG?=
 =?utf-8?B?N2xOWmZaK1JHQ284RE5sREtyRm11QmJHQW02UVFaNzZncXAvNUY3U1A5dHNN?=
 =?utf-8?B?NXpVclhmQU9jL2xzRFA3SmFkTjN3WUZkMVVqV0VWQWU1enV2M0g0VkdQaU05?=
 =?utf-8?B?T0lwZ0lRWCtsRmRCV1YrbitYNWRDby83ZHRIWXRaeVgyOGdpRWNFNkJUMDZS?=
 =?utf-8?B?L1R4STJjbnM4UVV5NWVpekdDZUE5WW5iNWU0Q2hpN2tidFltbjFsVEtwRGQx?=
 =?utf-8?B?RHdxbzBoZHNzMEtXRVhVUGRNMVNWS1N6eGtMVFZHUk1MZ2gzVXd3Q1drSUxj?=
 =?utf-8?B?RWZkc29mQXo4MkthMjFLY0J0Z3dmbjA0VC9zYnBRVDJhRElrb2ZJRHo2dzhJ?=
 =?utf-8?B?anhxTm0vczJvNmI3VE1KcmNUb21OaFdMMkFaK3d3d2dIVHJUbHk3cGRNeTJD?=
 =?utf-8?B?SkU0QTlMWnFYM2FEbUNWUGpNVEp0T3d6R0drdDA2Vlc1RFNTU3phbVVLRHF0?=
 =?utf-8?B?dnNOSnc1R0ZLL3oweXpHa2wxSzhFMzBFWWVjclowZlVwcEVJWkNmN2ovZ3E4?=
 =?utf-8?B?cWNDWEZ1QXZmYlRaWFFDRkUzVVFWQkJOZWtNQ2pvSVp3SS9VWGRuY0tyc1h2?=
 =?utf-8?B?ZGRXU0VlY0FmWDJsenBGSEFZR2Vzb1B4ZUVMem1IQWpIQ2RTNGt6azY1M3Zi?=
 =?utf-8?B?RlRobVlhOUk5MGlLbjNiZDFvUzYwdk05UlMyZHlxb3Rxdnd5TFpIdmdJWmxU?=
 =?utf-8?B?WWlQZjgxR0Z2bTBEWG5zTGc0bWtyRWpBdW9walhJOStmb1A1eHZPU05ZQWhP?=
 =?utf-8?B?bENma2ZPSFcrT3Rpa1dMNW12WW90Q3JkejZUZkFxUzRxQ2NJVHNvb2VHQTAz?=
 =?utf-8?Q?b3aE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a2437a-1756-46b1-2eef-08dc3e6cc45b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 06:06:45.1192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iaAe6UWacXdov22ZgRNIPVf3a5DrQ43p9a+jvnBOU8Uyl3uZU1ngHGVScNf6NI6+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5630

SGkgU3RlcGhlbiwNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogU3RlcGhl
biBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPg0KPlNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDQsIDIw
MjQgNjozMCBBTQ0KPlRvOiBUcml2ZWRpIE1hbm9qYmhhaSwgTmFtYW4gPE5hbWFuLlRyaXZlZGlN
YW5vamJoYWlAYW1kLmNvbT47DQo+YWJlbC52ZXNhQGxpbmFyby5vcmc7IGFuZ2Vsb2dpb2FjY2hp
bm8uZGVscmVnbm9AY29sbGFib3JhLmNvbTsNCj5rcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5v
cmc7IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsNCj5tdHVycXVldHRlQGJh
eWxpYnJlLmNvbTsgcm9iaEBrZXJuZWwub3JnDQo+Q2M6IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+a2VybmVs
QHZnZXIua2VybmVsLm9yZzsgVHJpdmVkaSBNYW5vamJoYWksIE5hbWFuDQo+PE5hbWFuLlRyaXZl
ZGlNYW5vamJoYWlAYW1kLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIXSBkcml2ZXJzOiBjbGs6
IHp5bnFtcDogcmVtb3ZlIGNsb2NrIG5hbWUgZGVwZW5kZW5jeQ0KPg0KPkNhdXRpb246IFRoaXMg
bWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNh
dXRpb24NCj53aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNw
b25kaW5nLg0KPg0KPg0KPlF1b3RpbmcgTmFtYW4gVHJpdmVkaSBNYW5vamJoYWkgKDIwMjQtMDEt
MDIgMjM6MjA6MTcpDQo+PiBDdXJyZW50bHksIGZyb20genlucW1wX2dldF9wYXJlbnRfbGlzdCgp
IGZ1bmN0aW9uIHRoZSBjbG9jayBkcml2ZXINCj4+IHJlZmVyZW5jZXMgdGhlIGNsb2NrIGJ5IG5h
bWUgaW5zdGVhZCBvZiBpdHMgcmVmZXJlbmNlIGZyb20gZGV2aWNlIHRyZWUuDQo+PiBUaGlzIGNh
dXNlcyBwcm9ibGVtIHdoZW4gdGhlIGNsb2NrIG5hbWUgaW4gdGhlIGRldmljZSB0cmVlIGlzIGNo
YW5nZWQuDQo+Pg0KPj4gUmVtb3ZlIGhhcmQgZGVwZW5kZW5jeSBvZiBjbG9jayBuYW1lIGFuZCB1
cGRhdGUgdGhlIGxvZ2ljIHRvIHVzZSBjbG9jaw0KPj4gcmVmZXJlbmNlIGZyb20gZGV2aWNlIHRy
ZWUgaW5zdGVhZCBvZiBjbG9jayBuYW1lLg0KPg0KPlBsZWFzZSB1c2Ugc3RydWN0IGNsa19wYXJl
bnRfZGF0YSBpbnN0ZWFkLg0KVGhhbmtzIGZvciByZXZpZXcuIEFzIHBlciBteSB1bmRlcnN0YW5k
aW5nLCB5b3Ugc3VnZ2VzdCB0byByZXBsYWNlIHRoZSBwcm9wb3NlZA0KbG9naWMsIGFuZCB1c2Ug
InN0cnVjdCBjbGtfcGFyZW50X2RhdGEiIHRvIGdldCB0aGUgY2xvY2sgbmFtZSBmcm9tIGRldmlj
ZSB0cmVlLg0KDQpJIGhhdmUgZ29uZSB0aHJvdWdoIG90aGVyIGRyaXZlcnMgd2hpY2ggdXNlIHRo
ZSAic3RydWN0IGNsa19wYXJlbnRfZGF0YSIgc3RydWN0dXJlLCB0aGV5IGhhdmUgaGFyZCBjb2Rl
ZCBjbG9jayBuYW1lcyBpbiB0aGUgZHJpdmVyLiBJbiB6eW5xbXAsIHRoZSBkcml2ZXIgcmVjZWl2
ZXMgY2xvY2sgbmFtZSBmcm9tIGZpcm13YXJlLg0KDQpBbHNvLCB0aGUgInp5bnFtcF9nZXRfcGFy
ZW50X2xpc3QiIGZ1bmN0aW9uIGlzIGNhbGxlZCBiZWZvcmUgY2xvY2tzIGFyZQ0KcmVnaXN0ZXJl
ZC4gU28gYXQgdGhpcyBwb2ludCwgd2UgZG9uJ3QgaGF2ZSB0aGUgaHcgc3RydWN0dXJlIHdoaWNo
IGhhcw0KY2xrX3BhcmVudF9kYXRhLg0KDQpTbywgSSBkaWQgbm90IGdldCBob3cgdG8gdXNlIHRo
ZSBzdHJ1Y3QgY2xrX3BhcmVudF9kYXRhIGluIHRoaXMgY2FzZS4gQ2FuIHlvdSBwbGVhc2UgcHJv
dmlkZSBhbiBleGFtcGxlIHdoaWNoIEkgY2FuIGxvb2sgYXQgYXMgYSByZWZlcmVuY2U/DQoNClRo
YW5rcywNCk5hbWFuDQo=

