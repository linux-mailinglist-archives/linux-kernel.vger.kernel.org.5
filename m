Return-Path: <linux-kernel+bounces-18990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B0E82661F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 22:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2DF1C2099B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 21:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B7E11C88;
	Sun,  7 Jan 2024 21:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="XakzUVv2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE39411712;
	Sun,  7 Jan 2024 21:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 407KHnFh030488;
	Sun, 7 Jan 2024 20:18:12 GMT
Received: from deu01-be0-obe.outbound.protection.outlook.com (mail-be0deu01lp2169.outbound.protection.outlook.com [104.47.7.169])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3vew7xrhk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jan 2024 20:18:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnWqdVNKmHWkSLO9UfEZ6qj5sGRaxfw57Psxu4AptKtRukSrKHywQ6wZWItXT4tSsblSlwF5VSejoOu5Xc00EMMjoZ3pjWv1dOo/yLHocKU9TSMGtrtBae1lL3TzfF8CxcN8mbQtOJLXWP1VyKgmgEq53xWm6pcnibAbJqlxBu+XETqqhbxAMhn6C4h28Tj7Nk1VyFcte9gGKWlwQYezO/eMxvZxZafB9+Ynd2i+4gE4Ne5ftYs636X+5kMNEI6rXAJLA6JITJduqKQPtb6AN9oLXvv8p4ALcQwgOTWBel/s9+G2XkGWOLkXYSS8/4VJ0dyHnNEy3nkaRyrgWolfKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aw35/cTECd5gsj1QOvlDcM0qGL3Bs9pUuHRT5dLaFn0=;
 b=RcdGSl6tZSQEgziyXPxrZAulV56dcLRryiRresNmD6ul1Ssj83ieoEH7EnrrQWztkD7cX6+z+1u9V3QvprOz4mbZuOs3dJ5QwCw/jXvB3nZssuVPmCHP/xdmKsTBaznoduOOsZlE8vjKnY2t0eIYZr8qosv2JzbEk+yCSqMq46AaJHZZR3KIZEV54KwHIcZSuDdSlp7ouXMFxVGERJjo/FZJ0FaKsPIhgsKgm+zkn93x8OLS6J7DihhCvicnPIQi+aXRukLoIfK2b4qldo5YGQlGpSTE1ywfTQMmZcnIopqxFrjFSNepZEaEZ1lb4oigzQkh7ReAvEme0OuJSJZl0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aw35/cTECd5gsj1QOvlDcM0qGL3Bs9pUuHRT5dLaFn0=;
 b=XakzUVv2jv0k5yWI5bx5NBcNr7yu0ImzAeRoXG3wG6hskvb1w/UJal8K2vnZuT+RZ41rcV/9ThcYO4rC5c0g3iicU6ugVnbptFmLKimsV7yx7Dz81NmjraXdljD5B/lWOixi2uX/T8HYS6hu5nU1xZ/Fm3pURxKUMKKVvQTXJUunc4O3UlXLkJuB7bdpNP5vVIdOebrdXIb5arSrfRpirZR8J4gLMJt+mK5qTwYWFjRxqB/7vL72XK6X0Ltl2KANAVqTKMlbGLqiBX2XwYYcLMCxgGCSVv0FvT2XnpEbcbrKhJMEtV9v1HpJkBOPBFUXArP7qXJc1lxrl0J40i4rRA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BEZP281MB2615.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Sun, 7 Jan
 2024 20:18:05 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::437a:5255:4944:171c]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::437a:5255:4944:171c%7]) with mapi id 15.20.7159.020; Sun, 7 Jan 2024
 20:18:03 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Colin Ian King
	<colin.i.king@gmail.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko
	<andy.shevchenko@gmail.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] iio: invensense: remove redundant initialization of
 variable period
Thread-Topic: [PATCH][next] iio: invensense: remove redundant initialization
 of variable period
Thread-Index: AQHaQLWKDRdfkdysS0iDYgVFu6EwHLDOhdcAgABFdAg=
Date: Sun, 7 Jan 2024 20:18:03 +0000
Message-ID: 
 <FR3P281MB17572C4F651951596882B5DACE642@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240106153202.54861-1-colin.i.king@gmail.com>
 <20240107160736.14f3ae1d@jic23-huawei>
In-Reply-To: <20240107160736.14f3ae1d@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BEZP281MB2615:EE_
x-ms-office365-filtering-correlation-id: 4287edd6-6b99-4e1f-072b-08dc0fbdc061
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Z2mXAY9Ls2KizJG4i46Cmn5cctrNt5AC1xDKcJyQChGLmlirb6zL2nK9lv3gR4tkxugsBajK2s2uswwB7Lgt0pgmMfym02Z220MKDGY0ZOQ2LemQ8sYwlkjimnzOfI+XkMDzmcDVAopKetOJwzr+U3Bkr9GVutQCoq4d+yko6wLbROKTaSFX8W0mTB9yp65Ydt4j8iO5uy1HKOz9JYAGVGEG63IwRw0pgOmn60XEajU4ahxbtD6ZSq3V31JC3gBF4cfpC2dh4XBcKR8XyPDw1dR26iQ5m724ljTVXJE5SFBzBn9Ywgh2oqBCYnsZ65BQ6KG1Q8u32ef8OoJoW07FXFlhiPAggwxC1gICkppWMUgOc0zokTpOBR4mtAZRKHQ+QYTww9FsY3JirZgjAf7AvpEWCGtPuKvX+OE4TOsmOPk2nFsGM5ZlJ08OTHYUS/HvpLSe0ubJTShllDz4O1vMKkryWxXu/HsoH4R2qGOgfT+Rhsf/OSSJjIZKRTN75puruHa9chKXQDOlbVqeiyc2/GEeNtiNlM0fjF0pPxVg51qw8mAMdh+jmVRxoeCg7+9ls6Z4bUI+bJffLz3CNoyWYkhhYZVLasftALeE31dEdSlmJFV6sXgKkxZNJZ31KNwxZO5byiLpcuMC/dbTG7ElL/3JjFVNTtwG719PW9Hltky7gxFAjbGOVBgLw7HLyPZHNO9Abch0DVzjrPco3zm05A==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39850400004)(230173577357003)(230273577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38100700002)(33656002)(2906002)(316002)(8676002)(8936002)(54906003)(110136005)(5660300002)(55016003)(38070700009)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(91956017)(41300700001)(122000001)(86362001)(4326008)(52536014)(6506007)(53546011)(9686003)(478600001)(71200400001)(83380400001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dFV0R2JhazlpbDRyN2lMNmRWenROazVHZUxnTDRFQzkwUDEvQ3Z1MDh2Yldy?=
 =?utf-8?B?K2tPb25Ba2dHODZsN0xGQk1nclJVYmhtdW42eGJCdjZvNE5iQTUwMEhZYVR4?=
 =?utf-8?B?MUxOWGN3SnNtaTZUVXV6clNZcHZBWDZVcGo2VXFzaUpxV21NL1hLMkl0aEhI?=
 =?utf-8?B?MSt4THBUQ1MrQmtwcXhnK1BoNmRPSjdMMHRacFB6dHdiQ3hQdXg4cWdlWnpT?=
 =?utf-8?B?cUVSQlJNeVNXL2RHMjJzdVBJM21zaGx0Um9sTEVHL2tCWC9lSXVncE8wZUlh?=
 =?utf-8?B?SUVaalJIdmlrNXVPdFhsYlpaQWd3MkU3czF0VzNMdHpBNUdpM2JySTgxU29C?=
 =?utf-8?B?YkVTM3l6MFN2WEl2QThUVC9vN1FKOTRFenRmRnU1TUJRMUZkSEZwWGVob2FP?=
 =?utf-8?B?SE82VTFzeWwzdFk1Z3E5Ykg1R1NLUUczODI5TjljbXFaamdkSCs5STZmK2g0?=
 =?utf-8?B?enJhcy9xZVljbFBIMXY1R1RRbzhqWnB0emUySVd2UjRCYVBlaUErd3U2bU43?=
 =?utf-8?B?NjJLQ0k4UENJeUJGMTNQQjR0ZFpFY0RhS0o4ZW1TU053UDJRbU1aUzRndDFs?=
 =?utf-8?B?RTZOUEp0dXFBY1E1MWJJdHFFeXZRWkdwUGJwMWtVS1JWMTdxNEFtRXRJbERK?=
 =?utf-8?B?ZUlpMUR0bmtoSFBrR3FaaC9hNzZrK0dtbG5NL1FScEpKNGJ6bE15YmUvc2Zm?=
 =?utf-8?B?Q3dvWElpVCtyK1ZPRkF1ZlNNUW1lUGJxbXVSc0RKckxxME9IS0tWNEZzSW93?=
 =?utf-8?B?dGJ4bDJtMjFIaW4yOEsraEtYTHltNm8vSlZLZllMMnFMS1JoWnpPNHpId0c0?=
 =?utf-8?B?VGxVaXFRbzRPYVdROUlpMEdVM2ZvaUxRd3lMU1l5VXFaaHFUVCtXNHNHc2Ry?=
 =?utf-8?B?cThMZVRBZHFQN2NlMU5jMUgvWHhsaHNFcSsrOUIyVFNqL3BzUDNoYXRLZUdq?=
 =?utf-8?B?cTFHSW93emp3UkpaNlVRb0FLQVVWc1dpN084SUp6b2FmY29mY2FSUW1jSmRX?=
 =?utf-8?B?b04rZFFraU9jWlB5bVFUbm1lN3hxOFBMQ0JmbndMYk1aTExrS3oyVi80Vm9r?=
 =?utf-8?B?YVRGOXhtUjNSaU9pTzg1SUxrc1pVeEQ1bDFhME5RNUNnZVZTVFBMcC9Fc1kz?=
 =?utf-8?B?ZkRFcEYvQkh2MDdhUERvS1RtT1R3VVc5YjdLWFFnR05VUWg5WnJ0UXdvV0VQ?=
 =?utf-8?B?eHkxbWFwN205cm8reE8wSVZ1SnR1TFl6aUNmelpFRlU0MFVUdG1vMjlJcFRE?=
 =?utf-8?B?TmJhMWpiRFk4dVVTTUVNRmpUYmRsaDJzdGJyNElMZDE3TXZWaTB4M1EwcUh0?=
 =?utf-8?B?MzYwUVhCbTZkTUlCelJ1WG5tRlVjaVJOQWF4SjlRcEVjMXE3NXU4Y3hJVmxW?=
 =?utf-8?B?RWx1b3V6cGRBVWFFdXI2OCtrVk9MeWpTZ1pZdS9IM0JsR3NlcjhLMDVRU1Zu?=
 =?utf-8?B?aEFhVC9kVHdMVnZpN0J0eHdZaS9iQ3BZR0hLUFovQXRNWFVHdFcyY0hwMlgx?=
 =?utf-8?B?ODZjM20wTmxUS2pDWHpOSzdJNWE2bXBDalJYOTZoTVg2RUNpTDJpSmxpTUli?=
 =?utf-8?B?UEYyRmpIbHdrMU1yajhCUUpERnVNYk45eVN1MU0wRHdCaVc1MGlaR1hOd1Jv?=
 =?utf-8?B?Rld0UVNSR2pkMDFXYkM1QWczYjNTbGlVWkJJTzh5Y2RsNjd3WjVUTnpsTE9h?=
 =?utf-8?B?RDB3OStDTUJpMS9uSUlZVksvQndJR0tWdStlYk9iUVJLcDQrRHkwSUZJZmtT?=
 =?utf-8?B?Qk5qMEh1cTRST2dGRG55RU5lbU5DMlFBQUdQU1Q0N1FzMHVSUSt6cTIxbEJo?=
 =?utf-8?B?bXVId044a2VZT0NkRzl3U0dDdU9ONFM4V0JzT1lRalpvTkxYQlZhREQ0VHlI?=
 =?utf-8?B?akQ1RnZKYWhYMUkwcjVYdnVJV1pDZ0V3MU9sa1RISEJna2ZtbEJiREQ2bDhh?=
 =?utf-8?B?d0QyWnhEbVlaZ2lhTzVWMmpzSEJJQnRpZ01LYXJrRXlldUxLaHlCUTBVNGg1?=
 =?utf-8?B?K3JtU292YWpVUVFFQVc0RGJFZU9qQTljSUdIa242UUFydUJqNVdUbVUxQStV?=
 =?utf-8?B?akRZcUdQOUNDNlJ4S0J2Uk9nelQ3OUtKZjZJYjF5bVJvMnVtV1VGdXhoK05I?=
 =?utf-8?B?YS9EVGRiMDN2TnovRW9PK21ZTXRpVlV2dUp6L1dIRk85cEhZNDF6VmRmbVFT?=
 =?utf-8?B?NmVlOXdSSGlVY3Rmcng4ckJqUVc4QVcyaXFDNkRTeWVWQVdPRVpnR2V0QUQ1?=
 =?utf-8?B?SWI3NWhNYVc4dWd5MmxKMW1ERk1BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4287edd6-6b99-4e1f-072b-08dc0fbdc061
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2024 20:18:03.0347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9vGzF9s02h/NLE5ZbPmOgtzbqF7M3FxZwycE9+iTMKXQE9GuslZ/FDz7zui67wwPQ6uK5slypYVq/wUrDckqfM2mWv1t9GzXcW2wODhjogo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2615
X-Proofpoint-GUID: Tlz1r3ALB-mn0VEJa_PsQnjFigfqqYPZ
X-Proofpoint-ORIG-GUID: Tlz1r3ALB-mn0VEJa_PsQnjFigfqqYPZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_16,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401070081

SGVsbG8gQ29saW4gJiBKb25hdGhhbiwKCnRoaXMgaXMgT0sgZm9yIG1lLCB0aGFua3MgZm9yIHRo
ZSBwYXRjaC4KVGhlIGluaXRpYWxpemF0aW9uIGlzIGNlcnRhaW5seSBjb21pbmcgZnJvbSBmaXJz
dCBkZXZlbG9wbWVudCBhbmQgaXMgbm90IG5lZWRlZC4KCkFja2VkLWJ5OiBKZWFuLUJhcHRpc3Rl
IE1hbmV5cm9sIDxqZWFuLWJhcHRpc3RlLm1hbmV5cm9sQHRkay5jb20+CgpUaGFua3MsCkpCCgpG
cm9tOiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPgpTZW50OiBTdW5kYXksIEph
bnVhcnkgNywgMjAyNCAxNzowNwpUbzogQ29saW4gSWFuIEtpbmcgPGNvbGluLmkua2luZ0BnbWFp
bC5jb20+CkNjOiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT47IEplYW4tQmFw
dGlzdGUgTWFuZXlyb2wgPEplYW4tQmFwdGlzdGUuTWFuZXlyb2xAdGRrLmNvbT47IEFuZHkgU2hl
dmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT47IGxpbnV4LWlpb0B2Z2VyLmtlcm5l
bC5vcmcgPGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc+OyBrZXJuZWwtamFuaXRvcnNAdmdlci5r
ZXJuZWwub3JnIDxrZXJuZWwtamFuaXRvcnNAdmdlci5rZXJuZWwub3JnPjsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZyA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4KU3ViamVjdDog
UmU6IFtQQVRDSF1bbmV4dF0gaWlvOiBpbnZlbnNlbnNlOiByZW1vdmUgcmVkdW5kYW50IGluaXRp
YWxpemF0aW9uIG9mIHZhcmlhYmxlIHBlcmlvZCAKwqAKT24gU2F0LCA2IEphbiAyMDI0IDE1OuKA
ijMyOuKAijAyICswMDAwIENvbGluIElhbiBLaW5nIDxjb2xpbi7igIppLuKAimtpbmdA4oCKZ21h
aWwu4oCKY29tPiB3cm90ZTogPiBUaGUgdmFyaWFibGUgcGVyaW9kIGlzIGJlaW5nIGluaXRpYWxp
emVkIHdpdGggYSB2YWx1ZSB0aGF0IGlzIG5ldmVyID4gcmVhZCwgaXQgaXMgYmVpbmcgcmUtYXNz
aWduZWQgYSBuZXcgdmFsdWUgbGF0ZXIgb24gYmVmb3JlIGl0IGlzIHJlYWQuID4gClpqUWNtUVJZ
RnBmcHRCYW5uZXJTdGFydApUaGlzIE1lc3NhZ2UgSXMgRnJvbSBhbiBFeHRlcm5hbCBTZW5kZXIg
ClRoaXMgbWVzc2FnZSBjYW1lIGZyb20gb3V0c2lkZSB5b3VyIG9yZ2FuaXphdGlvbi4gCsKgClpq
UWNtUVJZRnBmcHRCYW5uZXJFbmQKT24gU2F0LCAgNiBKYW4gMjAyNCAxNTozMjowMiArMDAwMApD
b2xpbiBJYW4gS2luZyA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT4gd3JvdGU6Cgo+IFRoZSB2YXJp
YWJsZSBwZXJpb2QgaXMgYmVpbmcgaW5pdGlhbGl6ZWQgd2l0aCBhIHZhbHVlIHRoYXQgaXMgbmV2
ZXIKPiByZWFkLCBpdCBpcyBiZWluZyByZS1hc3NpZ25lZCBhIG5ldyB2YWx1ZSBsYXRlciBvbiBi
ZWZvcmUgaXQgaXMgcmVhZC4KPiBUaGUgaW5pdGlhbGl6YXRpb24gaXMgcmVkdW5kYW50IGFuZCBj
YW4gYmUgcmVtb3ZlZC4KPiAKPiBDbGVhbnMgdXAgY2xhbmcgc2NhbiBidWlsZCB3YXJuaW5nOgo+
IFZhbHVlIHN0b3JlZCB0byAncGVyaW9kJyBkdXJpbmcgaXRzIGluaXRpYWxpemF0aW9uIGlzIG5l
dmVyCj4gcmVhZCBbZGVhZGNvZGUuRGVhZFN0b3Jlc10KPiAKPiBTaWduZWQtb2ZmLWJ5OiBDb2xp
biBJYW4gS2luZyA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT4KSGkgQ29saW4sCgpJIGRlZmluaXRl
bHkgd2FudCBpbnB1dCBmcm9tIHNvbWVvbmUgd2hvIGNhbiB0ZXN0IHRoaXMuClRoZXJlIGlzIGRp
cmVjdCB1c2Ugb2YgdHMtPnBlcmlvZCBhcyB3ZWxsIGFzIHRoZSBsb2NhbAp2YXJpYWJsZSB0aGF0
IGlzIGluZGVlZCBvdmVyd3JpdHRlbiBhcyB5b3UndmUgbm90ZWQuCkZlZWxzIGxpa2UgbmFtaW5n
IG5lZWRzIHNvbWUgd29yayBhbmQgcGVyaGFwcyByZWR1Y2UgdGhlIHNjb3BlIG9mCnRoZSBwZXJp
b2QgbG9jYWwgdmFyaWFibGUgc28gaXQncyBvYnZpb3VzIGl0IHdhcyBvbmx5IGludGVuZGVkCmZv
ciBtb3JlIGxvY2FsIHVzZSB0aGFuIGl0IGN1cnJlbnRseSBsb29rcyBsaWtlLgoKVGhhbmtzLAoK
Sm9uYXRoYW4KCj4gLS0tCj4gIGRyaXZlcnMvaWlvL2NvbW1vbi9pbnZfc2Vuc29ycy9pbnZfc2Vu
c29yc190aW1lc3RhbXAuYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2NvbW1vbi9pbnZf
c2Vuc29ycy9pbnZfc2Vuc29yc190aW1lc3RhbXAuYyBiL2RyaXZlcnMvaWlvL2NvbW1vbi9pbnZf
c2Vuc29ycy9pbnZfc2Vuc29yc190aW1lc3RhbXAuYwo+IGluZGV4IDAzODIzZWU1N2Y1OS4uM2Iw
Zjk1OThhN2M3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvaWlvL2NvbW1vbi9pbnZfc2Vuc29ycy9p
bnZfc2Vuc29yc190aW1lc3RhbXAuYwo+ICsrKyBiL2RyaXZlcnMvaWlvL2NvbW1vbi9pbnZfc2Vu
c29ycy9pbnZfc2Vuc29yc190aW1lc3RhbXAuYwo+IEBAIC0xMjYsNyArMTI2LDcgQEAgdm9pZCBp
bnZfc2Vuc29yc190aW1lc3RhbXBfaW50ZXJydXB0KHN0cnVjdCBpbnZfc2Vuc29yc190aW1lc3Rh
bXAgKnRzLAo+ICAJc3RydWN0IGludl9zZW5zb3JzX3RpbWVzdGFtcF9pbnRlcnZhbCAqaXQ7Cj4g
IAlpbnQ2NF90IGRlbHRhLCBpbnRlcnZhbDsKPiAgCWNvbnN0IHVpbnQzMl90IGZpZm9fbXVsdCA9
IGZpZm9fcGVyaW9kIC8gdHMtPmNoaXAuY2xvY2tfcGVyaW9kOwo+IC0JdWludDMyX3QgcGVyaW9k
ID0gdHMtPnBlcmlvZDsKPiArCXVpbnQzMl90IHBlcmlvZDsKPiAgCWJvb2wgdmFsaWQgPSBmYWxz
ZTsKPiAgCj4gIAlpZiAoZmlmb19uYiA9PSAwKQoKCg==

