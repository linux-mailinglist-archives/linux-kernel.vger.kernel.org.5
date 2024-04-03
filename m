Return-Path: <linux-kernel+bounces-128892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F90C89618C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367661C238A1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E625C96;
	Wed,  3 Apr 2024 00:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="o1CokUMC"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF5A17C8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 00:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712104701; cv=fail; b=MJlz6O+76z4oQcxH5uxbkwMD4fhwweXLagUsCVIvrF4KhOS9QJQfyXMjm4omNQSw0vUWixGbdWbFHDtlTW39GApM0g4VySkR/Vdyw7VdLAr0u/uJOY9ilhO9x4LhDn2IddQC8p0rQaru9eoeZ2iCHJtI7L7eEXlA958CC/xH+P8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712104701; c=relaxed/simple;
	bh=DApWLmh6wzAa0jn6zwBM2hxUDYQHSzxuy3JdV04opWw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ExJoKR9Zz/TxFikTH25pE1uE08742eYnC1QI6mdemyihkYLCZHqPR/NU2XogBjSHBi61Deyim5+qUv2Iu61nCkBR8vjiRLoEXfa9TlxWzgRKguZeJomm2valONOgs7i1CGlNRFebVaXoFQLyKozc0T+aTdYyCtmRwoKhkQ5mRUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=o1CokUMC; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4330F3K5002391;
	Wed, 3 Apr 2024 00:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=DApWLmh6wzAa0jn6zwBM2hxUDYQHSzxuy3JdV04opWw=; b=
	o1CokUMCSwFOCYDVa0uID28xS/6hV8+W70ym8mHmodH+fsrJ57t3FLounKbEmsRr
	DJS9lKab8DqJ9WQ4E5Qs4BS8q0ilUPeDxa1nxH7bxnL/cr5mwxTTbTYSTX3CdCqK
	81u3RlnSqUsvr0QS7I9Y5RL7Kph4Gb1Z3h+Nbq95a3qFJZvkBZsCsz8ydX/QAmWw
	hMzrMJdj6wfBKaVR+aJolN2nU24eE1m3+NGaZKAoC+hFdOcb4jerbcNYNMVQYKr7
	gXqDk2hZZqvAu6Oo+zuZ8XgH74fvZbkczD1ZRr3/0ttsIDGaH1p19Q/pN+ihvYZ2
	T+4xbWst2veQqmhm7fq/Mw==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3x67xy3w3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 00:37:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M19M+sPDMjbSnt8AA6gBhGRabfVUZWwjqROJU5AMWWYzH1TIs/vTxntacA7utWUTYv2RXAXQ+6gxx/blcUQCOTSaR6G74FKRI1baoDToNAaG0zpbwdev7YzpoOKgKpRsE6fsZH98U7rmwRBJmZheJelFLpHOlZx+SZF0XI9ivjYPYaPSj0h6cLsT+h0cOYPTDklqnBp5SKgBSFSHxPOvo4t7NyDqiauJ4Vvmf42TW25o/bY6DwC8dbbqnXCqZXOhIGJWL0Nelyh1t/XflldHUMW4YbsvoGHY6WQQWrc+38MRexuF7QAinAOxpp8LnsxuSIpDx2Hkykgm3+/CglM7Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DApWLmh6wzAa0jn6zwBM2hxUDYQHSzxuy3JdV04opWw=;
 b=DtH+g/rRPKFM4Jt1yjQy/CZM4Dbcfyza6udbKXKkNvfNQ+5yzqV9fENNBu4VLirgRc1xKq6Z4GQJtGVqDpoemtcFNCVYkRiHGn37CuNFVO4RiRkzVBtV7PCBJmuPaYVo/6Xv9rw+exIK/zybiOP59XuPu1eO6+3LqAH4RbgerQOnh+lZL8np8PJuI+JoQfPfyesiFa05B2PG7NEQkPFIio15JTf/gQghRKlTCeLlY8iuCFtGM5oO5tRJuA55qQuO7Qu/F5A6JwJU7n+KM4L0sXhbf391415MzrP4s88vEbibzFvrZN/1QJOdVlwl7r6UuZ+t3nX/iINSuECmh1n9TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by SJ1PR11MB6084.namprd11.prod.outlook.com (2603:10b6:a03:489::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Wed, 3 Apr
 2024 00:37:26 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::8cb4:86ac:461a:d683]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::8cb4:86ac:461a:d683%4]) with mapi id 15.20.7452.019; Wed, 3 Apr 2024
 00:37:26 +0000
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
Thread-Index: AQHagxH5to6e/r7juEWuwAcLekH5VbFUvd4AgADzXhA=
Date: Wed, 3 Apr 2024 00:37:25 +0000
Message-ID: 
 <PH0PR11MB5192C3A3806D89D0CACC2CEEEC3D2@PH0PR11MB5192.namprd11.prod.outlook.com>
References: <20240331021926.2732572-1-xiongwei.song@windriver.com>
 <20240331021926.2732572-4-xiongwei.song@windriver.com>
 <69089796-9a3b-41a1-9b7c-18c773b96aa2@suse.cz>
In-Reply-To: <69089796-9a3b-41a1-9b7c-18c773b96aa2@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5192:EE_|SJ1PR11MB6084:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 +QfyOxkoi5qhZooZ3sSTg+0ewmamI9jMn7RlM6mpR1rjyxgFf8CjTUYd0kwl6/eeUD3c6ojOWBPa838cMWWc45+FLFsVtC6d2Gzh2zvDVD2J80zJ8sHZp3MejM/top6yfNFkyhBWAIUmz/ghJful3RYbhXbHnWN6cuHXvYW2DoCVX8341Z9VWwPG3egDDq4+s9DiR+JaRc+1CvOxE1yU9Eyl294//ZKH60jz2SD4rRDU5yCqnwdlx8pq9W1ntlpjWERDybX9n2RAxngmDt94C+51HWnilQSKZIdPQymyC1qYvRfhQxqL7A1iMyOD5L5YZ9f9LMK7jVwoTRllMbAvW6KyazWdfOpjJTx0v5t4fa/vWCatQV3CuFmPxw5KZvBZtyKblxpYfSA9vHcZm1fwXx3djpu3nsjfQo/LDo3hSgrc94SvYJC1enCw9k4hKwYXdwLSgqc46f0PNJOe+mCfpS6G04BKp/+VUvEGWX34fyNG51u7r8d16hIKmBmdrdA5yOD8f1TrXxwN7plFVODb5EitAvLeSPGwHoBFg569om/3fwhytPYbY7t/4XXafA/g29Wl2ikWQhMEpkdHd45idVsdhdzUkWzPzCXeRkpk+AYBYocBinSYynHkOcIbmEjQT1LGDkc89pwZJjxJR8gGXH/+i0DMflK7c2d+qwcests=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TjVOZ2dreXhvT1E0cUk4L0VqcHAyZU90Mk5KeWkwRzkyZE9jT0orMmU4cDFI?=
 =?utf-8?B?a0Qzb1V1R1RDYnpSK1NYUjZCcW1LUU12b0RrdlViSVd4c2dPOW9JUGtOVXRV?=
 =?utf-8?B?a2Z1Um5WTU41NzE5MkZnaDMwWncwL1lsSUdyeWtWekNDRzBzSkFrMmZuM01H?=
 =?utf-8?B?eG1UOEMyTlVuUEFPMlZpOTZ6dHptVVVmNEZuNElRQVROVnVCbDFxU0hmT3Zt?=
 =?utf-8?B?ZlQ1NzdpMWZmTDErOEZnUHdTNzA4YXliZ2I1TWNwMTkrMFR1dmRsVEs1b05q?=
 =?utf-8?B?Z2YwdzJHQjc4T3FjQlpGK2J6czBLTitkbjhnU2FZOGIzS3NrMWFHbCtCODgx?=
 =?utf-8?B?eDFqdUJwdjFyZUpqWlNIaExDQlA3MjV0YjM4bDdXQ3FpRW5MbTlYczdZRXN2?=
 =?utf-8?B?ODJtUlpXRUpDdnd4SCtQMkd6NXRTdi9GbUh0S01UMHl6bzBIdHdBd21tK01L?=
 =?utf-8?B?aURpRjNISlR0Z2FhN1JXR2ZEb0t4S1oyNi9QNnI5dnhBVHkrcmJlbkJxKzRi?=
 =?utf-8?B?aHBRekVTMUpXK09jRkV4MS9xc2t4bjFydnhVVGd2Tml1VXJiQWsrUUVxNTU4?=
 =?utf-8?B?c1lNYUYyM1Q4TUt1b3FDVkQwVGUvMGFZOWpiZ1piNTB4ZXRUTytET3h6VWFj?=
 =?utf-8?B?alg5cTMxOXJlUjF2NHBkV3VIUmdsYXFURVlyNVVicW1yeFlZQ3Zoc1FybUYv?=
 =?utf-8?B?U2xkcFZ1NW43OFFxWnk3azliZENmc2ZycGZ0VXBrQXd1TnlkaTQ1ODh0eUQw?=
 =?utf-8?B?dzhtbDFBL3g5Lyszb1gvNXViWkN1N1VGUW5SUWYwNHdMcDNCQ1dRK0NYTnZr?=
 =?utf-8?B?M1Bva3JiRmdLaGRURi9KSnB2cGtST3lhQkIvRkNMRWI5djdFTmw4Y3Mzb2xY?=
 =?utf-8?B?VjkyVVpQbHhkcmZZdVozVHVUL1FOb0ZwUmVKYko4VldnMzJHSlRvd2RDeTA2?=
 =?utf-8?B?OUV3VHhzZ2FqRWFGMmRDUTNSWXRyMTdidWppbU5jaUxQQmVzNU1zczgyM0sr?=
 =?utf-8?B?azVyUTAwRzlqdEpha1FZcWNVamRac2hoRld0K3gvUHloeTdJSklMQ0N2bFJX?=
 =?utf-8?B?bXpOUSt5RVVpQlA3YlJ0OE1SVU4rblRpU0I4NFl1b3ZFZjMrekwrbU1MY3Ir?=
 =?utf-8?B?RFJVNkQreGxmaUgzM3VJaWh6SzByZHFnVXYyYUN0bExJcjNRVVR6WTBBdERO?=
 =?utf-8?B?MUE2TXFzaVpWOEQ2VlJpbE02Q0lUSjR6SC8zeXVnMUlCRUgvdzRiRXBFWFpL?=
 =?utf-8?B?TkZ5OGNzRVNRdmhvTjhGbDVnT1NoUVJrMnlwcHJUN2ZxZU5hSDdmS3daczQ4?=
 =?utf-8?B?SjY3ck5kZ2t3all2U3RvbGV6dW1nQVU3QzhrNGNCNkx1ZjBQSEZ4OFEzbkdn?=
 =?utf-8?B?WC9nUXh1anc3ak1FMTgvVmpxcnVvTURkQ04wVHZwZ2lFVFZkd01HZEtTMDcx?=
 =?utf-8?B?K2Q3Y2FhSEFPUGllZFFuMXR4TjA2d2Rxby9QYjdZYlI2dmVXNlcvVUdXMGFS?=
 =?utf-8?B?U2ZhVXBjL1dncmtIUEtIenAwOFYzaVhtR1Z2UnhWakhralhRSjhEb0xmaS85?=
 =?utf-8?B?YmFhbHI5QmdXUHZKeW10SDNKS3kvcmRpS3RFUU5qV1pxaDVnMEh6aitOWlRU?=
 =?utf-8?B?TjdBSTRrQXgvM3AzVCtCcGxRK0hRYmRnU2RJQVBIVXJzL211ZUJtcCs2eTN1?=
 =?utf-8?B?V2RjUnU1MTZXNXpHNFk0YUFyQldkalM2L3ZKb0N6MGMzY1Z1bFdqUDMxWHA2?=
 =?utf-8?B?N1VkdW9ZaU41QkZ5UVF4R0FnZE5KdEt6eEtEalRpUnZEQ1pqU2FSaDA3MFVS?=
 =?utf-8?B?bnZTMERQdDVIYW1PV3pHRVBlNktoNzNoSExpNjF2alVnZk1IeGozdDZpd0pK?=
 =?utf-8?B?QTJ3N0szaWlqNG9oaEMyOXZtNHNwNy9RMndBYUcrWERaNnJBaXhvRk9oczBq?=
 =?utf-8?B?bGpvQ1lEUXZPellkak9oU0MreG5TRGl3VEJhcUpHMG1kc3NIbk1CTElCQ0g4?=
 =?utf-8?B?TWF3MVBJRFNTTDlsTFJpc2R1N2ZvTzZxQnRFU1RZOXZvczhjd3QyN2puVjhr?=
 =?utf-8?B?MlM2NnlDY1pGUkZtWUpHd1kyOUxrT3VGbzV2cXArcGczdnVEOWFIWjNLWWlr?=
 =?utf-8?B?cUxmeDhydUNQNk9JbkpzYVBtdmJJek1EdVlSeTI4dzZZRy9KK1N0OEVTdTVt?=
 =?utf-8?B?M3c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ba722ff2-5f7a-4210-157c-08dc53763c26
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 00:37:26.0054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4+67DiyPerwaTx9FYcEtftHCMPsHJsOGPgDuNlS9P0dJi++Y8zoOjazqbjH9M+XheJZpAi5ZxE5X/CWhY2HWxOLt21MUNu+JRyOBn3lqMmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6084
X-Proofpoint-GUID: Hdd0gHStn9t6miPouXknazLRWqv5RDCp
X-Proofpoint-ORIG-GUID: Hdd0gHStn9t6miPouXknazLRWqv5RDCp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_16,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030002

PiANCj4gT24gMy8zMS8yNCA0OjE5IEFNLCB4aW9uZ3dlaS5zb25nQHdpbmRyaXZlci5jb20gd3Jv
dGU6DQo+ID4gRnJvbTogWGlvbmd3ZWkgU29uZyA8eGlvbmd3ZWkuc29uZ0B3aW5kcml2ZXIuY29t
Pg0KPiA+DQo+ID4gVGhlIGJyZWFrIGNvbmRpdGlvbnMgY2FuIGJlIG1vcmUgcmVhZGFibGUgYW5k
IHNpbXBsZS4NCj4gPg0KPiA+IFdlIGNhbiBjaGVjayBpZiB3ZSBuZWVkIHRvIGZpbGwgY3B1IHBh
cnRpYWwgYWZ0ZXIgZ2V0dGluZyB0aGUgZmlyc3QNCj4gPiBwYXJ0aWFsIHNsYWIuIElmIGttZW1f
Y2FjaGVfaGFzX2NwdV9wYXJ0aWFsKCkgcmV0dXJucyB0cnVlLCB3ZSBmaWxsDQo+ID4gY3B1IHBh
cnRpYWwgZnJvbSBuZXh0IGl0ZXJhdGlvbiwgb3IgYnJlYWsgdXAgdGhlIGxvb3AuDQo+ID4NCj4g
PiBUaGVuIHdlIGNhbiByZW1vdmUgdGhlIHByZXByb2Nlc3NvciBjb25kaXRpb24gb2YNCj4gPiBD
T05GSUdfU0xVQl9DUFVfUEFSVElBTC4gVXNlIGR1bW15IHNsdWJfZ2V0X2NwdV9wYXJ0aWFsKCkg
dG8gbWFrZQ0KPiA+IGNvbXBpbGVyIHNpbGVudC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFhp
b25nd2VpIFNvbmcgPHhpb25nd2VpLnNvbmdAd2luZHJpdmVyLmNvbT4NCj4gPiAtLS0NCj4gPiAg
bW0vc2x1Yi5jIHwgMjIgKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMTIgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvbW0vc2x1Yi5jIGIvbW0vc2x1Yi5jDQo+ID4gaW5kZXggNTkwY2M5NTM4OTVkLi5lYzkxYzc0
MzVkNGUgMTAwNjQ0DQo+ID4gLS0tIGEvbW0vc2x1Yi5jDQo+ID4gKysrIGIvbW0vc2x1Yi5jDQo+
ID4gQEAgLTI2MTQsMTggKzI2MTQsMjAgQEAgc3RhdGljIHN0cnVjdCBzbGFiICpnZXRfcGFydGlh
bF9ub2RlKHN0cnVjdCBrbWVtX2NhY2hlICpzLA0KPiA+ICAgICAgICAgICAgICAgaWYgKCFwYXJ0
aWFsKSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgIHBhcnRpYWwgPSBzbGFiOw0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICBzdGF0KHMsIEFMTE9DX0ZST01fUEFSVElBTCk7DQo+ID4gLSAg
ICAgICAgICAgICB9IGVsc2Ugew0KPiA+IC0gICAgICAgICAgICAgICAgICAgICBwdXRfY3B1X3Bh
cnRpYWwocywgc2xhYiwgMCk7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIHN0YXQocywgQ1BV
X1BBUlRJQUxfTk9ERSk7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIHBhcnRpYWxfc2xhYnMr
KzsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIC8qIEZpbGwgY3B1IHBhcnRpYWwg
aWYgbmVlZGVkIGZyb20gbmV4dCBpdGVyYXRpb24sIG9yIGJyZWFrICovDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgIGlmIChrbWVtX2NhY2hlX2hhc19jcHVfcGFydGlhbChzKSkNCj4gDQo+IFRo
YXQga2luZGEgcHV0cyBiYWNrIHRoZSBjaGVjayByZW1vdmVkIGluIHBhdGNoIDEsIGFsdGhvdWdo
IG9ubHkgaW4gdGhlDQo+IGZpcnN0IGl0ZXJhdGlvbi4gU3RpbGwgbm90IGlkZWFsLg0KPiANCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgZWxzZQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFr
Ow0KPiA+ICAgICAgICAgICAgICAgfQ0KPiA+IC0jaWZkZWYgQ09ORklHX1NMVUJfQ1BVX1BBUlRJ
QUwNCj4gPiAtICAgICAgICAgICAgIGlmIChwYXJ0aWFsX3NsYWJzID4gcy0+Y3B1X3BhcnRpYWxf
c2xhYnMgLyAyKQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiAtI2Vsc2UN
Cj4gPiAtICAgICAgICAgICAgIGJyZWFrOw0KPiA+IC0jZW5kaWYNCj4gDQo+IEknZCBzdWdnZXN0
IGludGVhZCBvZiB0aGUgY2hhbmdlcyBkb25lIGluIHRoaXMgcGF0Y2gsIG9ubHkgY2hhbmdlIHRo
aXMgcGFydA0KPiBhYm92ZSB0bzoNCj4gDQo+ICAgICAgICAgaWYgKChzbHViX2dldF9jcHVfcGFy
dGlhbChzKSA9PSAwKSB8fA0KPiAgICAgICAgICAgICAocGFydGlhbF9zbGFicyA+IHNsdWJfZ2V0
X2NwdV9wYXJ0aWFsKHMpIC8gMikpDQo+ICAgICAgICAgICAgICAgICBicmVhazsNCj4gDQo+IFRo
YXQgZ2V0cyByaWQgb2YgdGhlICNpZmRlZiBhbmQgYWxzbyBmaXhlcyBhIHdlaXJkIGNvcm5lciBj
YXNlIHRoYXQgaWYgd2UNCj4gc2V0IGNwdV9wYXJ0aWFsX3NsYWJzIHRvIDAgZnJvbSBzeXNmcywg
d2Ugc3RpbGwgYWxsb2NhdGUgYXQgbGVhc3Qgb25lIGhlcmUuDQoNCk9oLCB5ZXMuIFdpbGwgdXBk
YXRlLg0KDQo+IA0KPiBJdCBjb3VsZCBiZSB0ZW1wdGluZyB0byB1c2UgPj0gaW5zdGVhZCBvZiA+
IHRvIGFjaGlldmUgdGhlIHNhbWUgZWZmZWN0IGJ1dA0KPiB0aGF0IHdvdWxkIGhhdmUgdW5pbnRl
bmRlZCBwZXJmb3JtYW5jZSBlZmZlY3RzIHRoYXQgd291bGQgYmVzdCBiZSBldmFsdWF0ZWQNCj4g
c2VwYXJhdGVseS4NCg0KSSBjYW4gcnVuIGEgdGVzdCB0byBtZWFzdXJlIEFtZWFuIGNoYW5nZXMu
IEJ1dCBpbiB0ZXJtcyBvZiB4ODYgYXNzZW1ibHksIHRoZXJlIA0Kc2hvdWxkIG5vdCBiZSBleHRy
YSAgaW5zdHJ1Y3Rpb25zIHdpdGggIj49Ii4NCg0KRGlkIGEgc2ltcGxlIHRlc3QsIGZvciAiPj0i
IGl0IHVzZXMgImpsZSIgaW5zdHJ1Y3Rpb24sIHdoaWxlICJqbCIgaW5zdHJ1Y3Rpb24gaXMgdXNl
ZCBmb3IgIj4iLg0KTm8gbW9yZSBpbnN0cnVjdGlvbnMgaW52b2x2ZWQuIFNvIHRoZXJlIHNob3Vs
ZCBub3QgYmUgcGVyZm9ybWFuY2UgZWZmZWN0cyBvbiB4ODYuDQoNClRoYW5rcywNClhpb25nd2Vp
DQoNCj4gDQo+ID4NCj4gPiArICAgICAgICAgICAgIHB1dF9jcHVfcGFydGlhbChzLCBzbGFiLCAw
KTsNCj4gPiArICAgICAgICAgICAgIHN0YXQocywgQ1BVX1BBUlRJQUxfTk9ERSk7DQo+ID4gKyAg
ICAgICAgICAgICBwYXJ0aWFsX3NsYWJzKys7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgaWYg
KHBhcnRpYWxfc2xhYnMgPiBzbHViX2dldF9jcHVfcGFydGlhbChzKSAvIDIpDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICAgICAgIH0NCj4gPiAgICAgICBzcGluX3VubG9j
a19pcnFyZXN0b3JlKCZuLT5saXN0X2xvY2ssIGZsYWdzKTsNCj4gPiAgICAgICByZXR1cm4gcGFy
dGlhbDsNCg0K

