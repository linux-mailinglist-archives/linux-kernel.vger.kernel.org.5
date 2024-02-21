Return-Path: <linux-kernel+bounces-73964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1BF85CE1C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E178B23B3F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C0225619;
	Wed, 21 Feb 2024 02:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="nKSdqE6N"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB2E2BAF0
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 02:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708483154; cv=fail; b=nInAw2JfBj3FMOs9fj1VNk2xRMNJjnlLXcQyIlRTEki/3as5eQfIvsBNtisC6KykSjYLTpVZeHu2eJErNoW7lbnKshzzWs8BOVBgmqEqbELwx0ue87MjnBbg73Gj0Y8vYbju7Bgby/M5IB7pqgOaWLjP6O/YnFqJ+XpEKn7o74U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708483154; c=relaxed/simple;
	bh=0eR6U8TW8my7HwTmWwJC3CONe6WJvFBnFHL061pVyLc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cA06Cu4DP1EKMqNaa6ZzT+modK75dfDY81E7zJpUvf7/mTtB841mfpKgiwOszP111gV0DLInPvykoSEC/YwRpAEFuhHfCk8s6mBMgjn7/HA8ipyN7/EI2XrWZbxJS9x2/nRmCIhxVmYGupaHaqKvqE2BqnzuvYK/AenuYx67qro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=nKSdqE6N; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41L19VSW021647;
	Tue, 20 Feb 2024 18:18:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=0eR6U8TW8my7HwTmWwJC3CONe6WJvFBnFHL061pVyLc=; b=
	nKSdqE6N8KCX9tfsCZewlJJo6OKwKvgfYsF6GZrFuzr6aNZyoj2O+pf2VVMz/+pJ
	KJpWboBdwUdy4NBLptQbHKq+yzE9OI4UahpP+J45OtCxZxD5ASceDDaB0yC+Bzv7
	3CpQYfAhImryKSSoSJ3gBu0DjRVCwHG094rPe4pAbsZLHSiH2HZ4JBeKZRHKBOGN
	I/owS1SEiiBGcn1nCBPOAoCbcyWSTlO/iSra/OFOgRV6kpYBeNiyPzHhCjC/Ljr1
	sICfTrV/XReIaEdtf3uQWxVdHIO7TjDl+gHV5sqItM7IpXqd9KfC81uPvCeqbmT2
	NjnXS9hYYTD6NCLJjm9JpA==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3wd20cgand-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 18:18:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5c1ee3Z3xjscmLyv+EtahvFoNAEixkwcAOTz+GAs9nfj7ubC4lLCVWqFnFFozqeXUpdTjkDjApKxDQ/1ERBpryb14Yxvpmt/tlBPfAjPL7yf6pTy7tZqT0SQa3BwT30DOa9+AgOlChR3f/DI1xwjhLC8DhOTTwwUAzka+kWRXVbjEEB88MPCo2jlLPi8hRUQ2h3wRE1KMguRKSfbGZ1tqWyw/zUXBEhEfuyp0f1KfqkHhOLXiyckx41VePGZMVMuIrSCO8125VcX5oHOJgeVux3DXtxCFzJTArIb3POFmZlUlTu6dvoSNP2TnC9051hki6BL9ehZzCwIBIOBLJ2Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eR6U8TW8my7HwTmWwJC3CONe6WJvFBnFHL061pVyLc=;
 b=lyI8edmkE92hsSxuOr/76RBd1sa054tSAtxv8mbQd+CvFHzms2xQU8Pvegh4hhvIYTxJsPFdeEp+HVO8QoAJ2Uw9U/lXYZL2/zaPGns7kSYn8BG2hikvPzqpopjDXWpp0EUIZE93Zear2m5yMrK3WP5A5fvgXoVkYr1oWCbSTw1gEmHS94TUjG8Olrcqykr8u73E3DnSxiuqHbSenwYR6papCNwZmHD/4b4VZ9ZfIYpq1sF+C6KoaKRf2OWJ6pv/9D14h7fe0421nAt8pOA8PpD+oEr0BnXETyrihWNkH9EbpmWS+UTnIfkhvRnBOUTft4MZmE6pbP2IyDzObIb73g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by SJ2PR11MB8538.namprd11.prod.outlook.com (2603:10b6:a03:578::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 02:17:59 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::230c:58c0:c3f9:b5f3]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::230c:58c0:c3f9:b5f3%3]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 02:17:59 +0000
From: "Song, Xiongwei" <Xiongwei.Song@windriver.com>
To: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka
 Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo
 Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo
	<42.hyeyoo@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander
 Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino
	<vincenzo.frascino@arm.com>
CC: Zheng Yejian <zhengyejian1@huawei.com>,
        Chengming Zhou
	<chengming.zhou@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Steven Rostedt
	<rostedt@goodmis.org>
Subject: RE: [PATCH 1/3] mm, slab: deprecate SLAB_MEM_SPREAD flag
Thread-Topic: [PATCH 1/3] mm, slab: deprecate SLAB_MEM_SPREAD flag
Thread-Index: AQHaZB4V5G9cauwLMUeerVHZZ0FHGbEUAXtQ
Date: Wed, 21 Feb 2024 02:17:59 +0000
Message-ID: 
 <PH0PR11MB51927A728EA0776433CD66AAEC572@PH0PR11MB5192.namprd11.prod.outlook.com>
References: <20240220-slab-cleanup-flags-v1-0-e657e373944a@suse.cz>
 <20240220-slab-cleanup-flags-v1-1-e657e373944a@suse.cz>
In-Reply-To: <20240220-slab-cleanup-flags-v1-1-e657e373944a@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5192:EE_|SJ2PR11MB8538:EE_
x-ms-office365-filtering-correlation-id: 5acc7f52-6f8c-427f-f89f-08dc328352fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 plgx5vvSXRDXglsjts6lLcsFIBTwm3Mu9S0RZmTQrb0zJFWVTGNH7GKaKyEsyFfSl9X7hLlmE/5sn1cxmCtJDIz03NRnynVevaO4txyH0VzPvcntzRNoLt7rHO0xpbRg4tohQhoHUB2VosFjJGP/9aU0bwPssmKcc2gANYkGTuIlUlH79kRQ4fdmLm4XO7+U2+r2eh+cbBWS12Ox5BauXlfYGlv0HafSA5QGb0bVETKqlN0WqoQeNkDdD59mU7SkZ0e1CTuTwhbGqICX5fHTbS4EDD1TGltlHK8ZlyV377yVZHgz5V35g4ZjpFZtEHG6/kkBjWO/LxcYTCZyyUxOIx8/JUxdGk4Qko3YvFnRMLl3U00ME5ownIXP2Q+o9DEpm3mv01JEdsAyQszmROFrPnPUije6kUKDALDLpZSYHG0YcdtpX4Y1b4gGhvfnmcXRrrbj0uC/O+qwCCz3Rg+Y+Ty0ZexNj4Q+q14hL1ARKgftpDK8S/UMpB85SKFMUD13mTWwZ5TjSueJPKJHEqYcgLUnY9IzB98vCt93x1st5rA3NWj8q5TDPIQ6oxwsGlzCeveGQOAkZDJoxcFj+yD0RnqSBILG7lxafb+310GAKIGD/h/q6equZtebq6vFVfXr
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TlFzbUdSWXhIeS90WDBDdWsyaDk1aU0vb1FkU0VvblFyYzdnejEyQWg0d3lx?=
 =?utf-8?B?ZGR5VkM4TFNoeUZpeWIzUEpVY3d6YUlTRG4xU0t2bHZ3UU1wNUhIOENrSW1k?=
 =?utf-8?B?WFAvaUFXYTdnUlBNSFhQSjZab1BsUytFRTFlNTBqdmpKSmsrZnVJdXNpay8x?=
 =?utf-8?B?Mml4RzZXVG9lTlQ4anl4Q3VRZ2ZFUlg2UWtzS2N3OW5YWFI3SmFzbElZMExW?=
 =?utf-8?B?cTBGWitWNlpXVXBYU2FNWkYvRWhOUlJSTnlVcDgrc2d4QzFUNUNvek1OeUxn?=
 =?utf-8?B?MVdHTk5SRUpsaTU2b0VNUnhBVnlyMmtJYUthUTNibS9kYTBzaTkzWmtiS2FF?=
 =?utf-8?B?aU5CTEtkUGFoZVlZeXo3aGFTQXBuR0oxN0xLWm5VbWpBQ3FBeW5tc09JeXJR?=
 =?utf-8?B?cEtnUjduTnRhbVpNMThzQXNhb3h6cGpUUU15dHhsWSs3TXcwTEZUN3V3V3U0?=
 =?utf-8?B?bEs4UlhXR0Y0S0QzWnNQMTBKWEsyRGgrMXpuN3NLNDM3Q1F5cFdVZFhESWFn?=
 =?utf-8?B?Q0E4QjN3eGpDZmRBNWZmaCtlVmZwTlhGa3pweHRpQkwzbGxCSGxudkI2d2ZC?=
 =?utf-8?B?OEg2T2xza3J2TlNEb2Izcy90NFhXMWxHd2REa2F0d25taGhhVEFOYVAzbkxG?=
 =?utf-8?B?cVdkbkxQdzFzZGJrdUkyei96SHQxbFFnTGNTS2s3SjA4UWNWYlgxa2V1MnJQ?=
 =?utf-8?B?UGNNQ2lIb0xLSldXS3RsVnVXS3VyT2Njc3ovUHAxWVAvSWlnMHZCdnV2NW9p?=
 =?utf-8?B?cnFxMTZwT3BnaW5zeTdzNVBsM3J2WEVzUkZCZXRIeFhVN0l6UHpnSmJHOWE4?=
 =?utf-8?B?Y0xzRXJQSFFCY201R0IzMTFGaGZxRVBNN1FaZks5YWdRNDJTSTNvS1RNdFRs?=
 =?utf-8?B?NzMzRHEwYXozdkhuK2YySFlQRlVOdUE2N1Y2OTV0RXJjc0lvck9QNlRkKzMw?=
 =?utf-8?B?Z1VlVTkyMm14eGNKOTBmSTdWV2RPU0NvNmp0SkwwNVdtVFVrSHE3aFc4d2dj?=
 =?utf-8?B?UHo5OWhvaXFWWHRWWVp0OTRZN0pMTVBBTVFJOFZzSEpXZm9iT2FMVXNFTXdm?=
 =?utf-8?B?QVlvdTlsZ0NFRGhUak9hZ25KbnY2aVZKYlJhbk9NT3BPVWlZUzljbnpFelU4?=
 =?utf-8?B?dzhzUjZTVnM5bUpuUnZ1NHpmUk1ZNThHZ1N6aklhZzdYaDdiZXV4eVFyQnR4?=
 =?utf-8?B?dkZPNjhxem4rdVk2Y0dVRE9wZE1icm80aU8wRTJOUHIrT2xDM0VxbUdaWGFS?=
 =?utf-8?B?eHU4OGtMVWdLQTkvdkxNS2R0OEh3WUc5Y2lVTk8rL0NTQmthZGxnWnh6ZEZG?=
 =?utf-8?B?dTNLZDhxeU9scVlGcFRYdXBvWFZhUlhoMnR6SEJQYlo4QkY4Y2dnekIwbUVV?=
 =?utf-8?B?RWdZYlZnQ0VnSXFmbThlU01aWDFZQkdZalAzSVluTkJ2YXM1SENTelpXaTNq?=
 =?utf-8?B?ZTNXOUw2WUdTOHBwWWRmVmlZUG51T2J6a1ZOWVZFVzNrcTBJT0FpMCt1WkJ3?=
 =?utf-8?B?Z0dzUGIrQkxrcDVWOXhZS0JVMy8vT3A0dmpRUVRxOUZkZG9FYWFSMVFSd3Rj?=
 =?utf-8?B?UlpjWUZ1MW81d3J1eCtIMXdjTEdZdkV4WEUwYU1SYWJ3SEljK3hhRHoxVlJn?=
 =?utf-8?B?aE5JMG9Wb1ZUVEI1Z3ZkNWJWNGlUY01KNEtPb0paT1g5N1JvU0dlTjhBZUg3?=
 =?utf-8?B?ejBrb0dtOUVxZVp3bmVacVFvTXoxeVl4OStvNkg4Q01uL0IxYTVNNGNIenNx?=
 =?utf-8?B?clJreFUzdm9ENDdKb3BHZHdsbU4xOE5LZXlHbGhSNTM1aUZRWEMzS3ZvTGFa?=
 =?utf-8?B?U1IvbTh0RW9oMld1Q1U4eWdkc0IyOEU4TEZ2M2NPY1JJL0lPOEJFamgvTjQ5?=
 =?utf-8?B?WXVlMVEwMHAyczE4K1ZSSU9paHVIUnRCQVJYOXVnSmQzVDQ0alkxMXpCdEtC?=
 =?utf-8?B?clRrWjQwOHBzc1owTDN3KytxcW1RbldHQ1EwYndjQ2RkbWZtNXR3NXVTWitX?=
 =?utf-8?B?RVpvdHBwdEVmcUY5QkJzbXNOU3JtaUZzSVRwY2NOODVUVWlzUVlQOWt3ZTRk?=
 =?utf-8?B?THo4SEQvcmw4Z0ZMdEtPanoreDFoVW5Rc2FBMGRIeVFjVGs2OFBhbnh5c1ZK?=
 =?utf-8?B?REFsTTF6ZU1tN2FQV3dZZU81Z3ZsdkdqaEF4UEJueVJNWDh3TERWRVlkQ0VD?=
 =?utf-8?B?RVE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5acc7f52-6f8c-427f-f89f-08dc328352fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 02:17:59.3782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sdFv6yZ3JySV+IWVTPOiW/bgdegxxrURViwsZipP+De5T4mlNdsB2F8syCtapcVbOt2gCIkoTzlfpWd4P57PFOz9ely9DgofhixMnD4/IGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8538
X-Proofpoint-GUID: F19HJeW5U28aiZeK5kJv5fHBtyrqFGkG
X-Proofpoint-ORIG-GUID: F19HJeW5U28aiZeK5kJv5fHBtyrqFGkG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=589 malwarescore=0
 clxscore=1011 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210014

PiBUaGUgU0xBQl9NRU1fU1BSRUFEIGZsYWcgdXNlZCB0byBiZSBpbXBsZW1lbnRlZCBpbiBTTEFC
LCB3aGljaCB3YXMNCj4gcmVtb3ZlZC4gIFNMVUIgaW5zdGVhZCByZWxpZXMgb24gdGhlIHBhZ2Ug
YWxsb2NhdG9yJ3MgTlVNQSBwb2xpY2llcy4NCj4gQ2hhbmdlIHRoZSBmbGFnJ3MgdmFsdWUgdG8g
MCB0byBmcmVlIHVwIHRoZSB2YWx1ZSBpdCBoYWQsIGFuZCBtYXJrIGl0DQo+IGZvciBmdWxsIHJl
bW92YWwgb25jZSBhbGwgdXNlcnMgYXJlIGdvbmUuDQo+IA0KPiBSZXBvcnRlZC1ieTogU3RldmVu
IFJvc3RlZHQgPHJvc3RlZHRAZ29vZG1pcy5vcmc+DQo+IENsb3NlczogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsLzIwMjQwMTMxMTcyMDI3LjEwZjY0NDA1QGdhbmRhbGYubG9jYWwuaG9tZS8N
Cj4gU2lnbmVkLW9mZi1ieTogVmxhc3RpbWlsIEJhYmthIDx2YmFia2FAc3VzZS5jej4NCg0KUmFu
IGEgcm91Z2ggdGVzdCB3aXRoIGJ1aWxkIGFuZCBib290dXAsIGZlZWwgZnJlZSB0byBhZGQNCg0K
VGVzdGVkLWJ5OiBYaW9uZ3dlaSBTb25nIDx4aW9uZ3dlaS5zb25nQHdpbmRyaXZlci5jb20+DQpS
ZXZpZXdlZC1ieTogWGlvbmd3ZWkgU29uZyA8eGlvbmd3ZWkuc29uZ0B3aW5kcml2ZXIuY29tPg0K
DQo+IC0tLQ0KPiAgaW5jbHVkZS9saW51eC9zbGFiLmggfCA1ICsrKy0tDQo+ICBtbS9zbGFiLmgg
ICAgICAgICAgICB8IDEgLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zbGFiLmggYi9p
bmNsdWRlL2xpbnV4L3NsYWIuaA0KPiBpbmRleCBiNWY1ZWU4MzA4ZDAuLjYyNTJmNDQxMTVjMiAx
MDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9zbGFiLmgNCj4gKysrIGIvaW5jbHVkZS9saW51
eC9zbGFiLmgNCj4gQEAgLTk2LDggKzk2LDYgQEANCj4gICAqLw0KPiAgLyogRGVmZXIgZnJlZWlu
ZyBzbGFicyB0byBSQ1UgKi8NCj4gICNkZWZpbmUgU0xBQl9UWVBFU0FGRV9CWV9SQ1UgICAoKHNs
YWJfZmxhZ3NfdCBfX2ZvcmNlKTB4MDAwODAwMDBVKQ0KPiAtLyogU3ByZWFkIHNvbWUgbWVtb3J5
IG92ZXIgY3B1c2V0ICovDQo+IC0jZGVmaW5lIFNMQUJfTUVNX1NQUkVBRCAgICAgICAgICAgICAg
ICAoKHNsYWJfZmxhZ3NfdCBfX2ZvcmNlKTB4MDAxMDAwMDBVKQ0KPiAgLyogVHJhY2UgYWxsb2Nh
dGlvbnMgYW5kIGZyZWVzICovDQo+ICAjZGVmaW5lIFNMQUJfVFJBQ0UgICAgICAgICAgICAgKChz
bGFiX2ZsYWdzX3QgX19mb3JjZSkweDAwMjAwMDAwVSkNCj4gDQo+IEBAIC0xNjQsNiArMTYyLDkg
QEANCj4gICNlbmRpZg0KPiAgI2RlZmluZSBTTEFCX1RFTVBPUkFSWSAgICAgICAgIFNMQUJfUkVD
TEFJTV9BQ0NPVU5UICAgIC8qIE9iamVjdHMgYXJlIHNob3J0LWxpdmVkICovDQo+IA0KPiArLyog
T2Jzb2xldGUgdW51c2VkIGZsYWcsIHRvIGJlIHJlbW92ZWQgKi8NCj4gKyNkZWZpbmUgU0xBQl9N
RU1fU1BSRUFEICAgICAgICAgICAgICAgIDANCj4gKw0KPiAgLyoNCj4gICAqIFpFUk9fU0laRV9Q
VFIgd2lsbCBiZSByZXR1cm5lZCBmb3IgemVybyBzaXplZCBrbWFsbG9jIHJlcXVlc3RzLg0KPiAg
ICoNCj4gZGlmZiAtLWdpdCBhL21tL3NsYWIuaCBiL21tL3NsYWIuaA0KPiBpbmRleCA1NGRlZWIw
NDI4YzYuLmY0NTM0ZWVmYjM1ZCAxMDA2NDQNCj4gLS0tIGEvbW0vc2xhYi5oDQo+ICsrKyBiL21t
L3NsYWIuaA0KPiBAQCAtNDY5LDcgKzQ2OSw2IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBpc19rbWFs
bG9jX2NhY2hlKHN0cnVjdCBrbWVtX2NhY2hlICpzKQ0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBTTEFCX1NUT1JFX1VTRVIgfCBcDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFNMQUJfVFJBQ0UgfCBcDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNMQUJf
Q09OU0lTVEVOQ1lfQ0hFQ0tTIHwgXA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICBT
TEFCX01FTV9TUFJFQUQgfCBcDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNMQUJf
Tk9MRUFLVFJBQ0UgfCBcDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNMQUJfUkVD
TEFJTV9BQ0NPVU5UIHwgXA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTTEFCX1RF
TVBPUkFSWSB8IFwNCj4gDQo+IC0tDQo+IDIuNDMuMQ0KDQo=

