Return-Path: <linux-kernel+bounces-129651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26143896DE0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03B22838CC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF83D1419A1;
	Wed,  3 Apr 2024 11:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="iXxFgsc1"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E85E1386C9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 11:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712142976; cv=fail; b=K/VAfy11c/XqSP4VmRJvsdwKuKGxelvnuWmkelNP+Z+B1ee/Hv2pBGJ7D5vzBk5P/OzeXBGCVggyHrbfeb4gwhJVHeLYlHkt3H/MEeCq0tD//kIt2EfGtICw/90KfbvqajEeXAlWht1E1yP0FlxX9V4MNqfC7YH8Gr3UdiREVEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712142976; c=relaxed/simple;
	bh=QGJneJYye6Sn7O7ntkSRCMeIcS6WFcwV6jshkOdKTx4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b2kiTQ/O42rtB/n1s4fBlNulH49imkgPn7P4L/Be/GTDcT4Voknqx9Goa0S22FJvZPY6QT+7qVhRTjrQ5d1Lvkuaz5wJyP2RpYktuSllBlr6chR8MsupAGXXHRtT4A4fbzsNGa/pdK6Orr+cOpuE5Ps39XSj8ej6mROtbl7SDgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=iXxFgsc1; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4337JrHV009071;
	Wed, 3 Apr 2024 04:15:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=QGJneJYye6Sn7O7ntkSRCMeIcS6WFcwV6jshkOdKTx4=; b=
	iXxFgsc1XfD+gDELR1lXjTzCtX7GZiPwPWbpz/yoi8Qm8xw3lLYRttxy9UxEEPeX
	+BbplvmfH9+JGoYcE5xQsYGlhQrqKSJlWdAw/MAmfmgr5ooGAfrC3+GkCEoDADXl
	5lrik4/HjWgmsSQaiNP48tfezbtMsZtwzCmZ/u4/UYazEskkhqSytNRdomHmQT5F
	OZYPcz8Usg1f62bu2a/we5kEZN5BUXZfbFNAqD2FGhdzPWqCm9+qFZ62P1zB8F/j
	9Nr3EZiSXMSxn0nFt55l1QAGooWt2ffWIn1ECddErLsPoZA+EbsvLndFqrKWx1kk
	U8nSiaxbDasqWhT65temmQ==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3x6e10m5tv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 04:15:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qtlc6ERLS9kLKaT+apM92ZU3hyeQuYdLHoc0zpEtFuKv8muxyqCfW79OphCXlacquznIGyB60B3dRhUe6NXcJ+1Hfwgn/gkIYG0SUtthNZ7mrBnAyBrKl3C7qlHhJ0sfYGkLMjMfNxcL8dNYBO5oi71FLYDgBzVaHwZKw0zShyrbpDuqWxA/j8LsPPc9UQxyuLOZb8AVlRv1tXCeEPJcHbNRXDJkBcZpeRm/Y0u9viACij3EAyqMUBvsqyvQnJ5voqeETG4eusYG7T/hukHcOnQHN3rvZUfGSdubB+HEAT0kkkGhYb6zSqWVIAhojEz5G3biHVn4N3EL3jl+GuDx+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGJneJYye6Sn7O7ntkSRCMeIcS6WFcwV6jshkOdKTx4=;
 b=Cu6FTrtE/PMuUZAF2xwNKmgo9kx9m04PNCNxTOL9u8d1Rl4ImIeRY+nF5T9qSIeh2x1JRzPVMZOi3J+8kOeDQ3rvXHOpleR/dtwR+VZv+NUAfWQse0+rsy9YYykZ2rkBd6hwVm4V7qsjMHftbNQTi57pe1l3vo2cbmTJmW4965O12RO7oy2JcqigV4+qpYcMVSxs5XC5b2plUqXsxUlMMky98UvXMEDygqtxwqTOkpFWEW03s2SrHeARxfohz8CThg2oAqiXZaTBcwBU91s4K28mgJnUmqXMTid4Eo0DMLzx2L5TpEKeewjJdkwgoLFv/h/7bNLTJKMLIaxcKdesKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by PH0PR11MB7615.namprd11.prod.outlook.com (2603:10b6:510:26e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.24; Wed, 3 Apr
 2024 11:15:44 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::8cb4:86ac:461a:d683]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::8cb4:86ac:461a:d683%4]) with mapi id 15.20.7452.019; Wed, 3 Apr 2024
 11:15:44 +0000
From: "Song, Xiongwei" <Xiongwei.Song@windriver.com>
To: Vlastimil Babka <vbabka@suse.cz>,
        "rientjes@google.com"
	<rientjes@google.com>,
        "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org"
	<penberg@kernel.org>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "42.hyeyoo@gmail.com"
	<42.hyeyoo@gmail.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "chengming.zhou@linux.dev"
	<chengming.zhou@linux.dev>
Subject: RE: [PATCH 3/4] mm/slub: simplify get_partial_node()
Thread-Topic: [PATCH 3/4] mm/slub: simplify get_partial_node()
Thread-Index: AQHagxH5to6e/r7juEWuwAcLekH5VbFUvd4AgADzXhCAAHjagIAAQB1g
Date: Wed, 3 Apr 2024 11:15:44 +0000
Message-ID: 
 <PH0PR11MB5192F328F5BC9252AE0EB70AEC3D2@PH0PR11MB5192.namprd11.prod.outlook.com>
References: <20240331021926.2732572-1-xiongwei.song@windriver.com>
 <20240331021926.2732572-4-xiongwei.song@windriver.com>
 <69089796-9a3b-41a1-9b7c-18c773b96aa2@suse.cz>
 <PH0PR11MB5192C3A3806D89D0CACC2CEEEC3D2@PH0PR11MB5192.namprd11.prod.outlook.com>
 <2cab01ce-7c5f-46d6-b8a4-c2a24c3f9a32@suse.cz>
In-Reply-To: <2cab01ce-7c5f-46d6-b8a4-c2a24c3f9a32@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5192:EE_|PH0PR11MB7615:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 lyzsUlScnLbsxUQBAvh89y8/GSbSbJd9Dv4Mqrzx7NBVwbDSC3xUNn4Rq+Jwa+qpZXCVG+jv2wkoKSG4aqkeTngrRuXNsPTvWLqWxC1NIYLR8aV8X0eD+0PCcvLOeHrobMptjdPAe85u3galbTjeshJpIb5+Vpj8Y3NU0VgOSpaAsyIHkY0WqqIA/evhXUjX9jLKI5hIx6V1vW65i05T81O1eyYmg4HzHq6ZuZRYRfANXN/AD0uBr7Z0/p75SoiwK+FZNXQr0ldCRx3MtP+Kaa4dFvTb5HIHmMeO5THJV71DmvpwKk2p8C3h4AfKe2d+uzB7lBJThc6MF0rX36DRmj82g6LVx8idiX1RpqfO0VHF5P9IvtSNmcF8T6k811BS8k7oU3EmNv730x2YI+SURY6/DN/CBMt2trccGzEdxbYjG/dBz9Dt4tlRDKePMK3mLh5jssVY2v0AX0HtYfhiGNUktOqW8/0mtbAqV7gA7Y7ywLwvzzjehd1SfRSiJCuLVvNqPEltrw4mcQtNACjUW/5kNvWdRC+xzMBesllbzmRJG8DR2N6jrJ/LFUaWLaj1EXlUMpE62DWawCF+GvoRTwRmwzFJIOPjiwiKP4ZSuDIw0pP1Aug3HC2QhgmG7/6UuOsdIwuxhxpWGDgJPG6GcTz5BHwuIDhUp3PQah/EleE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?T296UjFkeHVoM2ZFK0twYWpWVEplaithcVdmQUVGdjAvNXkvdmV1MkZVKzNP?=
 =?utf-8?B?Q1VNcVJEdWZXQlRqVmlETWU2TFR1UjNTeXJ3ekZlandJWk01RVE4dTFTNDAy?=
 =?utf-8?B?b2hHUFdkOFVBc0NXNit6a01pU2hHWXpZR1gyMUpENzZheVV2TGxJa0o4M25K?=
 =?utf-8?B?ODQzcndpMEMwczhSMzhEdmZvQkFCRmZGOGFqaHBsTFlLcmF4S2RsRForbXJ5?=
 =?utf-8?B?czYvKzYrY3psTVpsdWx3OFRMYXB2OUo3c24xYkp3R0ZacEZjaFFHRDNSRTZh?=
 =?utf-8?B?S0ZRNHZoNU1wZndqL0xaejV6aFhMQUhmRnd5S2x1YkpJNUhKdTlRenRCWU01?=
 =?utf-8?B?WFpOb1doaktsTTdmZ1ZrT0o3SkNkeFVnSDh2VEQxSkEvQzVHaG01U0JGUTBt?=
 =?utf-8?B?S1YrM2YyZmdBN2dzOEJZcUE1TFVPZ1J5M3crTVVHWDFXczE1aHpaTE9DTG52?=
 =?utf-8?B?T3BVdDg2TU1RbFJMbWM4VDRiMllLdVl4NUtod3kreUhKcnQwb0hZNlhYL04r?=
 =?utf-8?B?emdwbDc2b3R1R3l5NkUvUmIwNWJ2SmZRam5TSElKNjlyL1dWRHNJaFNxc0dX?=
 =?utf-8?B?UW42bDBQeXpWYy9aMnB0ZXUzSVdTeW9venVocWxqNDZKQm5ta3loT0dSbHMx?=
 =?utf-8?B?SllLcjgwNW0ybTVraHdESDRLSENGb2FEM0l4cTZzd3I4T0FOaEpvbjRqY1dq?=
 =?utf-8?B?YkROR0YrM1FpVCtDWVhkTk11cE5WcmY5ZTUrbHJZeG9CK3NsODFuNFluR3Vj?=
 =?utf-8?B?b1ppV2NvUStsVGsrN2JaQ3BxQk5qaGJrTitSU1pnYVZUQnZFdVlvWm9IU1pG?=
 =?utf-8?B?bm0xL2F4TzBGR2VPUmZBeGpSRFRRRHhxZHN2USt3eFB6NzNVNS9TZkcwVkQx?=
 =?utf-8?B?R043ZEQ5ZktVQzc3dkIxMFVXZFFUajZnYWh3Y1M4Q2JReVltenc3c00rdkNj?=
 =?utf-8?B?a1FJUnFuUXBzS0wrTkg4Wi9MUkRSajBoKzl5b0tlU3RsWC9QOUNtTTlobW1E?=
 =?utf-8?B?ejNUK2x4NjY1S0F5R0V1R0RyeDd6cmJKeERxK1dZVDZoSm41VmtLaFRFQ24w?=
 =?utf-8?B?UUxya0pmSVEvL3hNdGQyTVFMVldOZjZpOE42RDVPYmROc1MrditEM2FhdFZV?=
 =?utf-8?B?c0RnbzVKRGNLdmx5VFpGaFdwQWFIRVNwTDB5N29oeWF6K3pKRDh2cUhVUlky?=
 =?utf-8?B?WlU1bHk5dGF6WjdydktMUHh3M1lxMGh1QkZxRUJwZC9LbkJPVHpYbVc1VndH?=
 =?utf-8?B?SDFkRkd5UVRzU0R0OHlwM2JuYklIbnBSa1pwUGJaUDNFcm15K0VYVk1DOUJR?=
 =?utf-8?B?UnBtZUF1NUQvbi9hUzlVeHJaZ3V3enNZYmNYTDBRclhpSDMzLzdYcTRWQmt6?=
 =?utf-8?B?cGJJQ0Z6NW1lYjRHMWYwZHp3WnRtWWdaRGR3aGx2RTZLS3ZzdGRLVkVURDZG?=
 =?utf-8?B?VjdoeXQyTnBka2ljVGtFVTFiZC9KRXVXdjZMZURIVnJsdGFSNDNPdzBURm1D?=
 =?utf-8?B?ZGVQRm9rYU14NStNU3JSS2s3TkVyOW5yUS9kZmtUSlgyK3prNkhGUnh3REt2?=
 =?utf-8?B?VmZDRWhGN0t0a3AydTRZUmcrYnhkZ3pmeitLcHNxeXNrR0U3U2kxMWZZRGVx?=
 =?utf-8?B?OHp6VmpsZ2M4RERYTWRJNHJaSEJZOTRCK0J6ZjhCR2RyNVZZanBRRzhhNG81?=
 =?utf-8?B?QXhqcEhMTmVVTHdETlN0UHhtRVhTSVgzN0ltOTJ0T0E5YkpOaE1ZdGNCanYr?=
 =?utf-8?B?QjB0aE1nZ0krM2N6WHdqQUtRNXh0cXRKTXRaTmxleEVwaFNPNXlYdkRjTnZV?=
 =?utf-8?B?cDc4UUN5bGFOQVN1UXJNbnM1cGJ5TW4ydkVycGhhWlVrNE4vbXZVQmJJdWFL?=
 =?utf-8?B?SjhYRUtaVmE4SDMwWktKczFpbEJXcDJXSk1sWjNaN3dHTDhKeXViRGRMY1Q4?=
 =?utf-8?B?L0VmeG1IREFyVHlVUW03cjJOMk8wVVdDTzFSSXNqS0htUzd2ZEcyZUJZdWdm?=
 =?utf-8?B?WVduMUNLbGFYelg0aFoxNmY3ZGlBS3d0TG4xNnJhVk93ZmY3UnlZQUZaRW90?=
 =?utf-8?B?c2xPbm5YMFhKQlFjN0xLVzNNUHFOS3BIL1FCczAzS1JpRW9wUi9nZnlKTEdT?=
 =?utf-8?B?TE4wVTR3OEJYSUdtYnlseGNZYlROaUVhVG03b255a3Rjczc4UHBVckE3N015?=
 =?utf-8?B?dHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5192.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 110e9638-268d-4ba3-9cee-08dc53cf67d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 11:15:44.4617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3yo7mGsadApvhuDwLskBfHxvkgpIOGZAncIS5qNOg7A+zVQWPzySyJD36/t37+pDc6DrmUtfU1dH2bK4ZLRlgDUIrEQ5ymgyfNr3aN1Q1Eg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7615
X-Proofpoint-ORIG-GUID: eUuur51tw2E8WGbAdXIPomCCovrVum_D
X-Proofpoint-GUID: eUuur51tw2E8WGbAdXIPomCCovrVum_D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_10,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 mlxlogscore=811 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030078

PiANCj4gT24gNC8zLzI0IDI6MzcgQU0sIFNvbmcsIFhpb25nd2VpIHdyb3RlOg0KPiA+Pg0KPiA+
Pg0KPiA+PiBJdCBjb3VsZCBiZSB0ZW1wdGluZyB0byB1c2UgPj0gaW5zdGVhZCBvZiA+IHRvIGFj
aGlldmUgdGhlIHNhbWUgZWZmZWN0IGJ1dA0KPiA+PiB0aGF0IHdvdWxkIGhhdmUgdW5pbnRlbmRl
ZCBwZXJmb3JtYW5jZSBlZmZlY3RzIHRoYXQgd291bGQgYmVzdCBiZSBldmFsdWF0ZWQNCj4gPj4g
c2VwYXJhdGVseS4NCj4gPg0KPiA+IEkgY2FuIHJ1biBhIHRlc3QgdG8gbWVhc3VyZSBBbWVhbiBj
aGFuZ2VzLiBCdXQgaW4gdGVybXMgb2YgeDg2IGFzc2VtYmx5LCB0aGVyZQ0KPiA+IHNob3VsZCBu
b3QgYmUgZXh0cmEgIGluc3RydWN0aW9ucyB3aXRoICI+PSIuDQo+ID4NCj4gPiBEaWQgYSBzaW1w
bGUgdGVzdCwgZm9yICI+PSIgaXQgdXNlcyAiamxlIiBpbnN0cnVjdGlvbiwgd2hpbGUgImpsIiBp
bnN0cnVjdGlvbiBpcyB1c2VkIGZvciAiPiIuDQo+ID4gTm8gbW9yZSBpbnN0cnVjdGlvbnMgaW52
b2x2ZWQuIFNvIHRoZXJlIHNob3VsZCBub3QgYmUgcGVyZm9ybWFuY2UgZWZmZWN0cyBvbiB4ODYu
DQo+IA0KPiBSaWdodCwgSSBkaWRuJ3QgbWVhbiB0aGUgY29kZSBvZiB0aGUgdGVzdCwgYnV0IGhv
dyB0aGUgZGlmZmVyZW5jZSBvZiB0aGUNCj4gY29tcGFyaXNvbiBhZmZlY3RzIGhvdyBtYW55IGNw
dSBwYXJ0aWFsIHNsYWJzIHdvdWxkIGJlIHB1dCBvbiB0aGUgY3B1DQo+IHBhcnRpYWwgbGlzdCBo
ZXJlLg0KDQpHb3QgaXQuIFdpbGwgZG8gbWVhc3VyZW1lbnQgZm9yIGl0Lg0KDQpUaGFua3MsDQpY
aW9uZ3dlaQ0K

