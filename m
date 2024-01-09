Return-Path: <linux-kernel+bounces-21252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E79828C86
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051D51C24460
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C28A3C099;
	Tue,  9 Jan 2024 18:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b="cD3iV846"
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AFA3C087
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 18:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epam.com
Received: from pps.filterd (m0174678.ppops.net [127.0.0.1])
	by mx0a-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409GakVP026343;
	Tue, 9 Jan 2024 17:04:04 GMT
Received: from eur02-db5-obe.outbound.protection.outlook.com (mail-db5eur02lp2104.outbound.protection.outlook.com [104.47.11.104])
	by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3vh6q511bj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 17:04:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l91UECNZmKIutwTLzPJ8mwoJbZYlnO0lQPHXGFBXbgYIdV/tGPAip0fs5z2SRCR4z6OqXPKe4UbHY3zU8DcEsXYDhND3cImc4FFQ7f2dlylcaxeLdxXnq7qcd5cpmIgO2DawGMdO1tSi/lofmpZVz8z4BPaDz+ktCkU2dXHRXasjK21VryaeWmYzBn4TUq0FPrXCv211zJtQ6RoWfWccmdOyuHuOsp1IKk/4xtVorJV1Ew7S+mYCvt4l/taEg9lyTBYtTvfSZnMB4IBJqNVpL1AFCi5zJGmfH7FDjYKC8EdAI5GZrtwlRDVmHze/iobM/vqiIaTboK7wsZCOadxF/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0J9GIwLAp4ZxcVEDHKtuCfL8rnH+L7o5D2FBXcFZrk=;
 b=T8t5Yboza2PkmrvetwQTIGVIBHZZk/zPK/WIb4rPVcE54rByrF0ciua6dwEjEejf7+sR0g0fQhpLAd31dWVK36NmX/N6Upac6VIVfeBT84LxAWam0Ao7vjkEcx8QC1Gkj8vfYiXnGPpoBgcqOo4N4fPlUuzWJI8eX5EvWfyo1Dd+Hn3xSjWcjvTwbQ1CNGRmDSjzO+cs0Q6yAb/UvEzPEIJTRYzy8ITGWCwhwUUMHMh8iyZoXmGR63bcV4NeevyUAmQuBlBtEYN2MHez7twfp8cG/PFzoP+NCvyHTMztuBXhttIc9PaCcXxJIZDH4il+K8qzbenfiKT911h7fugs3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0J9GIwLAp4ZxcVEDHKtuCfL8rnH+L7o5D2FBXcFZrk=;
 b=cD3iV846jSlhjOV+tfEL7zql4SPaKRo2s8Vn01d5nZYuPW49wxLP/qMA2FS1p/Q5l0j3jp+03lAiUf9bmQfQsCf9OWtbWbT/EZV0dmgvFoiYzMmX+P+bn3f7rQMT6VitdVnnTeefL5MPMavnzp/8ocSAPwl7rXcumVWXjOZK3FwOJVM65mvEUpTLaDAh1x4nbwQJXIYIpthdoJbuqOatqQNfWL+GROi7T486wk0ZcEZdhM1t2SML6gezUZ1dinBw7zPT5eevXm/G9vnrNR0fQohQ76CuR4zfdrbJJO9iNPmMcLP5tdl/ZNx69IDHLwNpgJ8YcWEXnTvZ2yPTQOtUgg==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by AS8PR03MB8859.eurprd03.prod.outlook.com (2603:10a6:20b:56f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Tue, 9 Jan
 2024 17:03:56 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::82af:59a5:4446:9167]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::82af:59a5:4446:9167%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 17:03:56 +0000
From: Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To: Daniel Vetter <daniel@ffwll.ch>
CC: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?=
	<christian.koenig@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano
 Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH v2] xen/gntdev: Fix the abuse of underlying struct page in
 DMA-buf import
Thread-Topic: [PATCH v2] xen/gntdev: Fix the abuse of underlying struct page
 in DMA-buf import
Thread-Index: AQHaQVU6yMzlzksitEGXkGgH1iK2frDP0zwAgAHluwA=
Date: Tue, 9 Jan 2024 17:03:56 +0000
Message-ID: <4386d559-8543-4afb-8162-94bdcc198266@epam.com>
References: <20240107103426.2038075-1-olekstysh@gmail.com>
 <CAKMK7uE07Uz-3yxH3+TNUEroKCobZ5xG+_HBPNWLOO0-cKAS+g@mail.gmail.com>
In-Reply-To: 
 <CAKMK7uE07Uz-3yxH3+TNUEroKCobZ5xG+_HBPNWLOO0-cKAS+g@mail.gmail.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR03MB6108:EE_|AS8PR03MB8859:EE_
x-ms-office365-filtering-correlation-id: bd148c32-e027-4b83-afee-08dc1134f716
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 nSqE3D1eTZvWf0bh9B16nXghOwvO8uLavoizs7MOcDN7Wu5eUoFWXHmXtCDBlggCh9QfN/35n84lT4TFH2fhqENrGu50gQdmUUX8uDMTtT86TO76R6wQUene7WzvLYCg7lSoUgQJU/RkxoJ9KQO5cs07lFQBZRKrFXsm7lc5dqWKSTKQNsEliktOJfdLOYyjlfwDPcZ3GFFeHSGnmYhS607EnjiLTOv8+OWJx7MhUa8140+vz37gvB4NYyxK77pU+Cwg6nt/AV0GB4llfQbHs1JQ7bnkrYWUlJbcyxfHxM+xIvjGecqR+pq80bNLISZW8OOAMd78zNr66hpKhXjf5HPx0PRBc6bgTwiRjTgNceu2Noj9vofLj0V/nBVues2NN8ml79mosVaU3iLxclxP0rVJl6PWXB8abIWjNw6xB55xdvG6JUOXaAZLqGIqLPlWT8Iy95hAvwvzEs3gWhEeYmYsJozYd9drrM8+DLIrChyQPIgvya7xKek5zoCYE/jBn0w3I5ORA1jknwambYqL8iqL6J6g8idZy1Wc/JngNgRFzogLDe56ZemS6X5XBSJvPYxXq36BnOV3Sut3IxMaIArJJA/giNDdCyvNXUIjoXZWckU2n+km1heg9OUwGths2t/xO/pB8puDixrqvIFtMk/f5EnZRePwHQIzjwY4NLHa1QmyQFy5TaDpHahiqz0z
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR03MB6108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(186009)(451199024)(1800799012)(31686004)(38100700002)(6486002)(122000001)(2906002)(41300700001)(5660300002)(66476007)(6916009)(8676002)(8936002)(76116006)(64756008)(66556008)(316002)(66446008)(66946007)(91956017)(83380400001)(38070700009)(4326008)(54906003)(71200400001)(6512007)(86362001)(6506007)(36756003)(31696002)(2616005)(478600001)(53546011)(26005)(66574015)(966005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?akxNTlNWSTdJNllxNUtMVTQ2aWx1VjRNODh6VC9UN2tYUXhmaXNvN3JYK0lw?=
 =?utf-8?B?VlRJNGNLbkIzYjlkSnY4Ukw3V2lINW5Yc1ROUFBxcFY5U2FqREV1em1CbTdL?=
 =?utf-8?B?UUZxY0VQWlMzdGVIYlh0RGNTV0w2Yis3MHdXeUhJYWxBdHJRVjFVcmxwNE5m?=
 =?utf-8?B?YU5mdjAza05yOTZJQWJ4dUkzanVRMEpNaVR3WWM2WjFVbk9FeVVwRkRDZC9x?=
 =?utf-8?B?MnpCTkRxcmJjcnVJaVlUTURXYkxxU1AyRWNGMUdRZUExQURTZVBkOTR2ZUlM?=
 =?utf-8?B?b0lGYTA3RzlLaGFvUWoydXgzMXZYekpLT0RqdVN0cmZ3eStzcjJkbE4zUXAv?=
 =?utf-8?B?MkJad2tnVzVaR2JvQ0h1Rkljb1lkc3R3SUdVbHpNeGxFTk0ydEdlaWtCc1Bo?=
 =?utf-8?B?c3V5akd4bUF4blZQeG9hNmVxMWpacm44Wld5WUFlMG5FSjhLSEFuRDdiSmEr?=
 =?utf-8?B?RjF3Q1hraU5nVzBodnBPeVlkZ1I0MjFtdGF4dmRmUmdMdmxDa2pSZmJHc1d4?=
 =?utf-8?B?N2hTTjU4MFRGc2Y3NnREUkVEWWZqelVXN0hsUWgzZzUxbXRhdzhxK2ZZM21m?=
 =?utf-8?B?aStQOWFSNnM5S2J0Q0JsbUtDNXVSYWlDdnVOVmsvNzFPc1ZxcmJhd29BTHg2?=
 =?utf-8?B?NnYzTmdlRHRtK0FVdkNGUWRHQ0VjU2dDVUM5UE50Q1ZYN29XOGNLVE82bkxx?=
 =?utf-8?B?dFRxNkdlYk8wcDVuVE43QVg3Tk5SMDBFSiswbFBUNTBKRDFNZVZybFlDU1ZC?=
 =?utf-8?B?SVpqc2tqMGtiRjg2WVlpSWhqbWRFZ2svNW1nV3RscTBXRFkrRThLaWZNWTdZ?=
 =?utf-8?B?Q25lTDVLejhaWG94TjRkaFExOEQrZEM1REhGUURSdzhtMGxKZmpqTzV1OTRP?=
 =?utf-8?B?NWNhZXB2MnpLMmM1RmNkbmQwOTU1ekxVWGllRTJmL2xYSGU5Wjg4ZDlRQzBJ?=
 =?utf-8?B?emtnMUNjcHFuQ29xQzR0Q3F4NEhqUGZNZVlGOUJ4QjVsTnhIN1p5M3BHbnF6?=
 =?utf-8?B?dCtxR2RJOHFGWUxBMXZnd2RMdUVzSXdPdWJiTWMxd1dQMTBVckZUbjV0Tndw?=
 =?utf-8?B?WXlIU0lWeEdPZ1BqVHhReHdzNlpZUGNuR3E3NVBQVDRNd0h2QlhjUCtTRUVk?=
 =?utf-8?B?VmNlQ2ZBdFFoMThJQlAvR3hiSWVKUTJEZ2NYelUwQTF0UG45M3BESzB4T0NB?=
 =?utf-8?B?RVJWbWpSR3I3SEw0azBHQTdkSGF5MU5EZzVUZFpMSVAvR0VPNzNScmswb1VY?=
 =?utf-8?B?T1o5VlE3cUV3RHJBR2grSkx5TUlzc2ZPWThhMXBuVS9LU25RT1ZTelg5WXlt?=
 =?utf-8?B?ODhSL29Xd1Fvbkh6YS8xUUk5WER6S1lGQXFQY2J5VTFLWXFRaWJmeVVEZjVn?=
 =?utf-8?B?a0tybDY2WjArUzlQZ0ZyM3F3TTdsenZFd1ZURGN5K1ZzczZxbzhHcDl2S05s?=
 =?utf-8?B?Y0QzWVJERlFwS2wxeGxTdnR5Wlc4bEgrYnZtVDhIWXUzTmJTMDZYMnFHa2R2?=
 =?utf-8?B?U3FMVXJlUjR5Y3I4MkxnazB5OUxoeUQ5OG9YaGozTG1wbTNSdFV2ZmttZEZr?=
 =?utf-8?B?UWlyeHNtWEsxT1ZjZ3VjNFV0eDJqcVpJcW51NncxajJJbFl6Q09MWnFXOEc4?=
 =?utf-8?B?UDJTMEVlUlpGTkVjSEJjQThuOGRhS3F4eUpxdzE1cGg5V0REQWJFUTZWdDhL?=
 =?utf-8?B?cFNQUUlkY2kwc0pnakpwcCttbE1TQmh2S2JOaEZBOVN3dk5XSFNWYnNPYXc4?=
 =?utf-8?B?bFErQ1ZBeElkOStURnJFcmxiKzVVZnZqZHN3RC9PZDFjOUgvb1NWU0NGVmhk?=
 =?utf-8?B?R1pRZG51djlrTU1LcnE3WjlCcitqVWh3em5od05SSW81RW9pcTVyYmNXQjlp?=
 =?utf-8?B?QXVudjNVeFUxdUNHUk9oSHBjd25VL1o4d1IveFQraUdZbk85cnZRamp1dGNP?=
 =?utf-8?B?eFpsMjkweERMUTlZclFXdVBRYXJ4YVIwM1JIV25pL2VHTTVlaEowNVlXZUhZ?=
 =?utf-8?B?ZmZVN3F3YUhEVDJNZFB3enlwdzhkRko0VHpqRDNxYm1kOStvbXRMVXh3N1hO?=
 =?utf-8?B?U3paMS9tdUtwSzFDaDFBTTN2bi9pb3FqQStLWEI1RkM0UUZjQjdWUVo5QVJG?=
 =?utf-8?B?dCtySHhWYzVIUWMrUk1lVzNkcDlwUnRXcmZXM3J0d3BJQkRuOHh0RS81N1cx?=
 =?utf-8?Q?g+/vDgLAzltdQfIf4SutL0w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AAE19337E15484E84B0098404BEE7F5@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd148c32-e027-4b83-afee-08dc1134f716
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 17:03:56.0870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d0/7Rwg7MV78xEma8Oi3I3TIBlJ0JVoz7UkTbdd5gUEUpkCYnU6nll/gYmfDbtsEI7kIcMQSE117pSbPXczR+y9HP8mCehfJQSVzyqIdq/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8859
X-Proofpoint-ORIG-GUID: -h9GZdLAXGaRbYl1FO6Hdoi2Cplg2bgj
X-Proofpoint-GUID: -h9GZdLAXGaRbYl1FO6Hdoi2Cplg2bgj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 adultscore=0 phishscore=0 mlxscore=0 clxscore=1011
 mlxlogscore=999 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090138

DQoNCk9uIDA4LjAxLjI0IDE0OjA1LCBEYW5pZWwgVmV0dGVyIHdyb3RlOg0KDQpIZWxsbyBEYW5p
ZWwNCg0KDQo+IE9uIFN1biwgNyBKYW4gMjAyNCBhdCAxMTozNSwgT2xla3NhbmRyIFR5c2hjaGVu
a28gPG9sZWtzdHlzaEBnbWFpbC5jb20+IHdyb3RlOg0KPj4NCj4+IEZyb206IE9sZWtzYW5kciBU
eXNoY2hlbmtvIDxvbGVrc2FuZHJfdHlzaGNoZW5rb0BlcGFtLmNvbT4NCj4+DQo+PiBETyBOT1Qg
YWNjZXNzIHRoZSB1bmRlcmx5aW5nIHN0cnVjdCBwYWdlIG9mIGFuIHNnIHRhYmxlIGV4cG9ydGVk
DQo+PiBieSBETUEtYnVmIGluIGRtYWJ1Zl9pbXBfdG9fcmVmcygpLCB0aGlzIGlzIG5vdCBhbGxv
d2VkLg0KPj4gUGxlYXNlIHNlZSBkcml2ZXJzL2RtYS1idWYvZG1hLWJ1Zi5jOm1hbmdsZV9zZ190
YWJsZSgpIGZvciBkZXRhaWxzLg0KPj4NCj4+IEZvcnR1bmF0ZWx5LCBoZXJlIChmb3Igc3BlY2lh
bCBYZW4gZGV2aWNlKSB3ZSBjYW4gYXZvaWQgdXNpbmcNCj4+IHBhZ2VzIGFuZCBjYWxjdWxhdGUg
Z2ZucyBkaXJlY3RseSBmcm9tIGRtYSBhZGRyZXNzZXMgcHJvdmlkZWQgYnkNCj4+IHRoZSBzZyB0
YWJsZS4NCj4+DQo+PiBTdWdnZXN0ZWQtYnk6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5j
aD4NCj4+IFNpZ25lZC1vZmYtYnk6IE9sZWtzYW5kciBUeXNoY2hlbmtvIDxvbGVrc2FuZHJfdHlz
aGNoZW5rb0BlcGFtLmNvbT4NCj4+IEFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+DQo+PiBSZXZpZXdlZC1ieTogU3RlZmFubyBTdGFiZWxsaW5pIDxz
c3RhYmVsbGluaUBrZXJuZWwub3JnPg0KPj4gLS0tDQo+PiBQbGVhc2Ugbm90ZSwgSSBkaWRuJ3Qg
bWFuYWdlIHRvIHRlc3QgdGhlIHBhdGNoIGFnYWluc3QgdGhlIGxhdGVzdCBtYXN0ZXIgYnJhbmNo
DQo+PiBvbiByZWFsIEhXIChwYXRjaCB3YXMgb25seSBidWlsZCB0ZXN0ZWQgdGhlcmUpLiBQYXRj
aCB3YXMgdGVzdGVkIG9uIEFybTY0DQo+PiBndWVzdHMgdXNpbmcgTGludXggdjUuMTAuNDEgZnJv
bSB2ZW5kb3IncyBCU1AsIHRoaXMgaXMgdGhlIGVudmlyb25tZW50IHdoZXJlDQo+PiBydW5uaW5n
IHRoaXMgdXNlLWNhc2UgaXMgcG9zc2libGUgYW5kIHRvIHdoaWNoIEkgaGF2ZSBhbiBhY2Nlc3Mg
KFhlbiBQViBkaXNwbGF5DQo+PiB3aXRoIHplcm8tY29weSBhbmQgYmFja2VuZCBkb21haW4gYXMg
YSBidWZmZXIgcHJvdmlkZXIgLSBiZS1hbGxvYz0xLCBzbyBkbWEtYnVmDQo+PiBpbXBvcnQgcGFy
dCB3YXMgaW52b2x2ZWQpLiBBIGxpdHRsZSBiaXQgb2xkLCBidXQgdGhlIGRtYS1idWYgaW1wb3J0
IGNvZGUNCj4+IGluIGdudGRldi1kbWFidWYuYyBoYXNuJ3QgYmVlbiBjaGFuZ2VkIG11Y2ggc2lu
Y2UgdGhhdCB0aW1lLCBhbGwgY29udGV4dA0KPj4gcmVtYWlucyBhbGxtb3N0IHRoZSBzYW1lIGFj
Y29yZGluZyB0byBteSBjb2RlIGluc3BlY3Rpb24uDQo+Pg0KPj4gICAgdjI6DQo+PiAgICAgLSBh
ZGQgUi1iIGFuZCBBLWINCj4+ICAgICAtIGZpeCBidWlsZCB3YXJuaW5nIG5vdGljZWQgYnkga2Vy
bmVsIHRlc3Qgcm9ib3QgYnkgaW5pdGlhbGl6aW5nDQo+PiAgICAgICAicmV0IiBpbiBjYXNlIG9m
IGVycm9yDQo+PiAgICAgICBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvb2Uta2J1aWxkLWFsbC8yMDI0MDEwNjIxMjIuaXQ2enZMRzAtbGtwQGludGVs
LmNvbS9fXzshIUdGXzI5ZGJjUUlVQlBBITM4LW13VDlIQ3RPZVpDM200SS1tOW4waHJhZ1lNSGZt
V2NIS2dEeEVwR3M5bWczNU0wYnBQV1dPUks4YWljaHhIdE8zNkdaX0puQ1dUTGRKWGRaWUJtQ3Yk
IFtsb3JlWy5da2VybmVsWy5db3JnXQ0KPj4gLS0tDQo+PiAtLS0NCj4+ICAgZHJpdmVycy94ZW4v
Z250ZGV2LWRtYWJ1Zi5jIHwgNDQgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMjUgZGVsZXRpb25zKC0p
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL2dudGRldi1kbWFidWYuYyBiL2RyaXZl
cnMveGVuL2dudGRldi1kbWFidWYuYw0KPj4gaW5kZXggNDQ0MGU2MjZiNzk3Li4yNzJjMGFiMDFl
ZjUgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3hlbi9nbnRkZXYtZG1hYnVmLmMNCj4+ICsrKyBi
L2RyaXZlcnMveGVuL2dudGRldi1kbWFidWYuYw0KPj4gQEAgLTExLDYgKzExLDcgQEANCj4+ICAg
I2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KPj4gICAjaW5jbHVkZSA8bGludXgvZXJybm8uaD4N
Cj4+ICAgI2luY2x1ZGUgPGxpbnV4L2RtYS1idWYuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgvZG1h
LWRpcmVjdC5oPg0KPj4gICAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KPj4gICAjaW5jbHVkZSA8
bGludXgvdHlwZXMuaD4NCj4+ICAgI2luY2x1ZGUgPGxpbnV4L3VhY2Nlc3MuaD4NCj4+IEBAIC01
MCw3ICs1MSw3IEBAIHN0cnVjdCBnbnRkZXZfZG1hYnVmIHsNCj4+DQo+PiAgICAgICAgICAvKiBO
dW1iZXIgb2YgcGFnZXMgdGhpcyBidWZmZXIgaGFzLiAqLw0KPj4gICAgICAgICAgaW50IG5yX3Bh
Z2VzOw0KPj4gLSAgICAgICAvKiBQYWdlcyBvZiB0aGlzIGJ1ZmZlci4gKi8NCj4+ICsgICAgICAg
LyogUGFnZXMgb2YgdGhpcyBidWZmZXIgKG9ubHkgZm9yIGRtYS1idWYgZXhwb3J0KS4gKi8NCj4+
ICAgICAgICAgIHN0cnVjdCBwYWdlICoqcGFnZXM7DQo+PiAgIH07DQo+Pg0KPj4gQEAgLTQ4NCw3
ICs0ODUsNyBAQCBzdGF0aWMgaW50IGRtYWJ1Zl9leHBfZnJvbV9yZWZzKHN0cnVjdCBnbnRkZXZf
cHJpdiAqcHJpdiwgaW50IGZsYWdzLA0KPj4gICAvKiBETUEgYnVmZmVyIGltcG9ydCBzdXBwb3J0
LiAqLw0KPj4NCj4+ICAgc3RhdGljIGludA0KPj4gLWRtYWJ1Zl9pbXBfZ3JhbnRfZm9yZWlnbl9h
Y2Nlc3Moc3RydWN0IHBhZ2UgKipwYWdlcywgdTMyICpyZWZzLA0KPj4gK2RtYWJ1Zl9pbXBfZ3Jh
bnRfZm9yZWlnbl9hY2Nlc3ModW5zaWduZWQgbG9uZyAqZ2ZucywgdTMyICpyZWZzLA0KPj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IGNvdW50LCBpbnQgZG9taWQpDQo+PiAg
IHsNCj4+ICAgICAgICAgIGdyYW50X3JlZl90IHByaXZfZ3JlZl9oZWFkOw0KPj4gQEAgLTUwNyw3
ICs1MDgsNyBAQCBkbWFidWZfaW1wX2dyYW50X2ZvcmVpZ25fYWNjZXNzKHN0cnVjdCBwYWdlICoq
cGFnZXMsIHUzMiAqcmVmcywNCj4+ICAgICAgICAgICAgICAgICAgfQ0KPj4NCj4+ICAgICAgICAg
ICAgICAgICAgZ250dGFiX2dyYW50X2ZvcmVpZ25fYWNjZXNzX3JlZihjdXJfcmVmLCBkb21pZCwN
Cj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHhlbl9w
YWdlX3RvX2dmbihwYWdlc1tpXSksIDApOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZ2Zuc1tpXSwgMCk7DQo+PiAgICAgICAgICAgICAgICAgIHJl
ZnNbaV0gPSBjdXJfcmVmOw0KPj4gICAgICAgICAgfQ0KPj4NCj4+IEBAIC01MjksNyArNTMwLDYg
QEAgc3RhdGljIHZvaWQgZG1hYnVmX2ltcF9lbmRfZm9yZWlnbl9hY2Nlc3ModTMyICpyZWZzLCBp
bnQgY291bnQpDQo+Pg0KPj4gICBzdGF0aWMgdm9pZCBkbWFidWZfaW1wX2ZyZWVfc3RvcmFnZShz
dHJ1Y3QgZ250ZGV2X2RtYWJ1ZiAqZ250ZGV2X2RtYWJ1ZikNCj4+ICAgew0KPj4gLSAgICAgICBr
ZnJlZShnbnRkZXZfZG1hYnVmLT5wYWdlcyk7DQo+PiAgICAgICAgICBrZnJlZShnbnRkZXZfZG1h
YnVmLT51LmltcC5yZWZzKTsNCj4+ICAgICAgICAgIGtmcmVlKGdudGRldl9kbWFidWYpOw0KPj4g
ICB9DQo+PiBAQCAtNTQ5LDEyICs1NDksNiBAQCBzdGF0aWMgc3RydWN0IGdudGRldl9kbWFidWYg
KmRtYWJ1Zl9pbXBfYWxsb2Nfc3RvcmFnZShpbnQgY291bnQpDQo+PiAgICAgICAgICBpZiAoIWdu
dGRldl9kbWFidWYtPnUuaW1wLnJlZnMpDQo+PiAgICAgICAgICAgICAgICAgIGdvdG8gZmFpbDsN
Cj4+DQo+PiAtICAgICAgIGdudGRldl9kbWFidWYtPnBhZ2VzID0ga2NhbGxvYyhjb3VudCwNCj4+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihnbnRkZXZfZG1h
YnVmLT5wYWdlc1swXSksDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBHRlBfS0VSTkVMKTsNCj4+IC0gICAgICAgaWYgKCFnbnRkZXZfZG1hYnVmLT5wYWdlcykNCj4+
IC0gICAgICAgICAgICAgICBnb3RvIGZhaWw7DQo+PiAtDQo+PiAgICAgICAgICBnbnRkZXZfZG1h
YnVmLT5ucl9wYWdlcyA9IGNvdW50Ow0KPj4NCj4+ICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBj
b3VudDsgaSsrKQ0KPj4gQEAgLTU3Niw3ICs1NzAsOCBAQCBkbWFidWZfaW1wX3RvX3JlZnMoc3Ry
dWN0IGdudGRldl9kbWFidWZfcHJpdiAqcHJpdiwgc3RydWN0IGRldmljZSAqZGV2LA0KPj4gICAg
ICAgICAgc3RydWN0IGRtYV9idWYgKmRtYV9idWY7DQo+PiAgICAgICAgICBzdHJ1Y3QgZG1hX2J1
Zl9hdHRhY2htZW50ICphdHRhY2g7DQo+PiAgICAgICAgICBzdHJ1Y3Qgc2dfdGFibGUgKnNndDsN
Cj4+IC0gICAgICAgc3RydWN0IHNnX3BhZ2VfaXRlciBzZ19pdGVyOw0KPj4gKyAgICAgICBzdHJ1
Y3Qgc2dfZG1hX3BhZ2VfaXRlciBzZ19pdGVyOw0KPj4gKyAgICAgICB1bnNpZ25lZCBsb25nICpn
Zm5zOw0KPj4gICAgICAgICAgaW50IGk7DQo+Pg0KPj4gICAgICAgICAgZG1hX2J1ZiA9IGRtYV9i
dWZfZ2V0KGZkKTsNCj4+IEBAIC02MjQsMjYgKzYxOSwyNSBAQCBkbWFidWZfaW1wX3RvX3JlZnMo
c3RydWN0IGdudGRldl9kbWFidWZfcHJpdiAqcHJpdiwgc3RydWN0IGRldmljZSAqZGV2LA0KPj4N
Cj4+ICAgICAgICAgIGdudGRldl9kbWFidWYtPnUuaW1wLnNndCA9IHNndDsNCj4+DQo+PiAtICAg
ICAgIC8qIE5vdyBjb252ZXJ0IHNndCB0byBhcnJheSBvZiBwYWdlcyBhbmQgY2hlY2sgZm9yIHBh
Z2UgdmFsaWRpdHkuICovDQo+PiArICAgICAgIGdmbnMgPSBrY2FsbG9jKGNvdW50LCBzaXplb2Yo
KmdmbnMpLCBHRlBfS0VSTkVMKTsNCj4+ICsgICAgICAgaWYgKCFnZm5zKSB7DQo+PiArICAgICAg
ICAgICAgICAgcmV0ID0gRVJSX1BUUigtRU5PTUVNKTsNCj4+ICsgICAgICAgICAgICAgICBnb3Rv
IGZhaWxfdW5tYXA7DQo+PiArICAgICAgIH0NCj4+ICsNCj4+ICsgICAgICAgLyogTm93IGNvbnZl
cnQgc2d0IHRvIGFycmF5IG9mIGdmbnMgd2l0aG91dCBhY2Nlc3NpbmcgdW5kZXJseWluZyBwYWdl
cy4gKi8NCj4+ICAgICAgICAgIGkgPSAwOw0KPj4gLSAgICAgICBmb3JfZWFjaF9zZ3RhYmxlX3Bh
Z2Uoc2d0LCAmc2dfaXRlciwgMCkgew0KPj4gLSAgICAgICAgICAgICAgIHN0cnVjdCBwYWdlICpw
YWdlID0gc2dfcGFnZV9pdGVyX3BhZ2UoJnNnX2l0ZXIpOw0KPj4gLSAgICAgICAgICAgICAgIC8q
DQo+PiAtICAgICAgICAgICAgICAgICogQ2hlY2sgaWYgcGFnZSBpcyB2YWxpZDogdGhpcyBjYW4g
aGFwcGVuIGlmIHdlIGFyZSBnaXZlbg0KPj4gLSAgICAgICAgICAgICAgICAqIGEgcGFnZSBmcm9t
IFZSQU0gb3Igb3RoZXIgcmVzb3VyY2VzIHdoaWNoIGFyZSBub3QgYmFja2VkDQo+PiAtICAgICAg
ICAgICAgICAgICogYnkgYSBzdHJ1Y3QgcGFnZS4NCj4+IC0gICAgICAgICAgICAgICAgKi8NCj4+
IC0gICAgICAgICAgICAgICBpZiAoIXBmbl92YWxpZChwYWdlX3RvX3BmbihwYWdlKSkpIHsNCj4+
IC0gICAgICAgICAgICAgICAgICAgICAgIHJldCA9IEVSUl9QVFIoLUVJTlZBTCk7DQo+PiAtICAg
ICAgICAgICAgICAgICAgICAgICBnb3RvIGZhaWxfdW5tYXA7DQo+PiAtICAgICAgICAgICAgICAg
fQ0KPj4gKyAgICAgICBmb3JfZWFjaF9zZ3RhYmxlX2RtYV9wYWdlKHNndCwgJnNnX2l0ZXIsIDAp
IHsNCj4gDQo+IE1heWJlIGFkZCBhIGNvbW1lbnQgaGVyZSB0byBleHBsYWluIHdoeSB0aGlzIGlz
IGRvbmUgYW5kIHdoeSBpdCdzIG9rPw0KDQoNCk1ha2VzIHNlbnNlLCB3aWxsIGRvIGZvciB2My4N
Cg0KDQo+IEVpdGhlciB3YXk6DQo+IA0KPiBBY2tlZC1ieTogRGFuaWVsIFZldHRlciA8ZGFuaWVs
QGZmd2xsLmNoPg0KDQoNClRoYW5rcyENCg0KDQpbc25pcF0=

