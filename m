Return-Path: <linux-kernel+bounces-156982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E38B8B0B2E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 060432866AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A3716C87C;
	Wed, 24 Apr 2024 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="i9APOnvB"
Received: from mx07-0063e101.pphosted.com (mx07-0063e101.pphosted.com [205.220.184.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0C315E817
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965651; cv=fail; b=By4AUpjDhvsLs52E4uFNn3WLHZKPHomnQBHk4oTAEbsWGvY1sXl53M6/nLd84geRLh0NjcbYpbwqKUF7XM6cmeH4IjawVuZxjY8xidQ1vwZ6Ig8vodKn4f77OtEd89iGfX40u0vJb1V72pEGiyP8xBsbYk3fjIOdiR4x76RvOQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965651; c=relaxed/simple;
	bh=ktvra+5PlBCeAeh+Iu9UaHOPk/2ATeCHqcg+pXz4d8g=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BjsA6ErqJ8XL9CnU4pmW3CWrZkyI8y5If9YkUdWLjoCs72ZllCpKwPT/JbGiNUYOfFWuIXXNso3mBF8VILkWxGeARFFo4tGdsK2ESRlY0iHZxUrRF57pcK+3Y+I6Nfa77mg5H1KM6vmTNTVI98gHh7jDbwE2HxALIm9tJ0a7inU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=i9APOnvB; arc=fail smtp.client-ip=205.220.184.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247495.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43ODK2ZA012433;
	Wed, 24 Apr 2024 14:33:41 +0100
Received: from pnzpr01cu001.outbound.protection.outlook.com (mail-centralindiaazlp17011004.outbound.protection.outlook.com [40.93.132.4])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 3xny4n8uyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 14:33:41 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5pfw6vkExI+weXo58ZsFxma3dlVs15Y7KAPj6qvclfShn+Yz5TIV2xqAAmn2s5CG4zmTX/VzREE0OlhEQyh2L70dkZRW7r1fiyIIzbcJNR+c3QkzGPyuApT8hssLV/N1e+9cIV4CL7jl4n2YGwIs6+wRYWkEZC6VtALPProhBoIKWtGAH1ilEfbBqlL7tt+Sxz2N0frEwAHfLfU+oV4UchQwK7CIKZq2xhSJswLFWkYIo91yLuxmSV0fE4FYhhL9Bed8Bkq6j7i3cJJIEnTE39jOxCmEG+JwdUvi4vKYmEorBRHX9X6YRxUBDmtVhsKpNf+SV8lzrCl4LcTGcuaBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktvra+5PlBCeAeh+Iu9UaHOPk/2ATeCHqcg+pXz4d8g=;
 b=FAgu9Jv+Xxcco46BWjSdvrifiCXU0DmEbbOxWLAE6xWvtdTgaeJj9r3LheCZjGrzJnaEmscDIEGosb9tldun1fdp/svgNG9kY1TvHr3ySaGpbKve3p4ETOogUAZ8gcqLVuUM9ZRxhcgGfoszYTpzIin42HBptT6SPDW/ccdi8Ai4JTskl0oF1HpMUg4Yk0HBBrHEkLVcpf2GbXfXWSYLte+yPY9G45J6aV2QHxqcj5NcQuO9WDA7l6feVkFReidxjhVeBBhwea8c8Xp+W2UHNf04M6kUgBhgbWHndI8DlchkUoKne6Ab+2HHCjpzpJ+STKy27i6hRP+uMEA0ZMLsJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktvra+5PlBCeAeh+Iu9UaHOPk/2ATeCHqcg+pXz4d8g=;
 b=i9APOnvBk0mfnXs+GgzRaCfExYkaC7VfYqCUEATC5hE16my3RhabRiYYSzdV7ICWhvRap3Wvd//FsrGa1n3tHh/DCmgY88ARP/9jONMb0d+sV5VfNu+8AS7byMbDxf6pDW+xS5Z+UJo5CKT3CcmF48ix7oRQ5Q3h9Z4Uh8yk60E=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by MA0PR01MB6106.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:7a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 13:33:37 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%3]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 13:33:37 +0000
From: Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>
To: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>,
        James Cowgill
	<james.cowgill@blaize.com>,
        Matt Redfearn <matthew.redfearn@blaize.com>,
        Neil
 Jones <neil.jones@blaize.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Geert
 Uytterhoeven <geert+renesas@glider.be>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Marek Szyprowski
	<m.szyprowski@samsung.com>,
        =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E_Prado?=
	<nfraprado@collabora.com>,
        Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v2 7/7] arm64: defconfig: Enable ARCH_BLAIZE_BLZP1600
Thread-Topic: [PATCH v2 7/7] arm64: defconfig: Enable ARCH_BLAIZE_BLZP1600
Thread-Index: AQHalkwC6c81qvA6LUiPsoJVGep8aA==
Date: Wed, 24 Apr 2024 13:33:36 +0000
Message-ID: <20240424133334.19314-1-nikolaos.pasaloukos@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB10184:EE_|MA0PR01MB6106:EE_
x-ms-office365-filtering-correlation-id: b242dd4e-9686-44f1-0eed-08dc64632546
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?oYD6w+kzmBgwMrLfT7IHRCyT6QHrtiYx3q4d791MuHzjNGter4GqizxVrz?=
 =?iso-8859-1?Q?8kBHkokxNNuxHKRMGI0MTu0cY/jaMFlbZ9TKRVR4Og4h8p0miTWO1VuNYy?=
 =?iso-8859-1?Q?x7SVhbbcy75UEP3nPvrJP1kX2eV0xJZQJd0+Mq6jQUbsOjwHuyLPFp95tc?=
 =?iso-8859-1?Q?yDGKYR9nrarr/vR+RjOyEUE4ua0RiEp1NaqpJgywUOH/6jO+cb3YHcOKYp?=
 =?iso-8859-1?Q?Pkxr1voPT0T6EdiEF53motCtg0D7ZjbDWJllgf/8+KOTre9hVNsd7fuWbZ?=
 =?iso-8859-1?Q?RXshTToYri3e4e6dVy4bfL0GDaGXkuX814nisthGHTgV0lHi0tSKzZPh9F?=
 =?iso-8859-1?Q?k/Nak+xDc/Rw46+cssajnlfwzLoOWR7B399PHm6F3qrGv0AEcMIaXlmyI3?=
 =?iso-8859-1?Q?eQUBz0v6cyp0Rp0fZoPVw5aeAJ/QxluG3Uu7zzPsYPoYULyaJVt7CTxmO7?=
 =?iso-8859-1?Q?HyHqjiIJDVI6ob74i1Gh767aN27dDFAeclmOZGa19pX3u8ZGQsLJqKb3LN?=
 =?iso-8859-1?Q?xdRbjVA0s8lTPnizL4aQNhfJcoKu3Z5DSW/qQlGh7jZHgvM2y7/R4LGteh?=
 =?iso-8859-1?Q?wAcUximNE2PJAxRncxJkxP5lk4Rcks643FgKvpGEEpwrAGkozrV9A+xPda?=
 =?iso-8859-1?Q?3Ob629c89fDvzhvHpJtky25iolwVHG2YSr7AW6jro97ZVzLSB8u3gaqQaO?=
 =?iso-8859-1?Q?ErTH45CH2GBwWHJxTxhmcqKeQyO9V/EuRLoalJua0zVqFypTw1Lbc2kWSh?=
 =?iso-8859-1?Q?SpQXY6PQQ2S2LR3bHpYxnM4Q9tDcjibs1CNfho+YxjoXJtwqPdDaAgXMLQ?=
 =?iso-8859-1?Q?pY/OoX6Co54CxUGmCRr5s5Orj1Tt/AWEKkdsakbMgT9w9oq3Zn/1vz59WT?=
 =?iso-8859-1?Q?1oxFLbn2YWqSp/pEDPK3KyQhPw2jlYIiA8Itk1fTN/e+z5iPLh/+FvWqBP?=
 =?iso-8859-1?Q?ag6ypoBoLFU2mSghVF3WEVQInUrnTIhJho+eEUlnY6WeNCqmI01RJoj3nq?=
 =?iso-8859-1?Q?K87SmOgiSfwiZtPXkaKSGnEWnaMEGnMMZuqmrAJTJboKx2tBnqBa6a8Kks?=
 =?iso-8859-1?Q?/hXv2Wtit4ccWyM/1SeQIjom0uV4b9WhEWbMs5re3b2qyeQoKUEq+7M2kc?=
 =?iso-8859-1?Q?KDaO58luxpt7HJSMB79koSHdUpnEz1lv0ysvdq6v+RITgy6rFEo+5VA8C8?=
 =?iso-8859-1?Q?LuS3sJxKp1rQFoR29bF9MkOj03+iIxAh/FxWHikSiX1kMgAj3Tkf597mri?=
 =?iso-8859-1?Q?SarWG+0HoGWEyuIK0zl5tAg7NAd9Y9N89cpC3jUUpqrjI6xgJzk59k9NO3?=
 =?iso-8859-1?Q?TocukT3Y55lvsuKnqlD8G6FlJEA3HAmpL8vgjUhya6pgkoKmw6HFmL5zbV?=
 =?iso-8859-1?Q?5XzvoJKucbBgkPI7O82C5/FT5FQeBSIQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?YX/oIzL2Qc2nzrWJXTSYIYKTZQ4yvU9OoihwOTeyRCRVv0PiBUDUf9nX5+?=
 =?iso-8859-1?Q?aGDWVZEW+wzAMwdPKWiTTMpd8HTgwxjHAKX639nxqPUo7MkL8w6/OkYzps?=
 =?iso-8859-1?Q?js1morDEpYSM1DtXqbDPx4tTcYFQenNojzRIiuHNa/P6rGhh8C9nXxcqYm?=
 =?iso-8859-1?Q?yp6lcdtrOzAyVWMsp9X43aqf7fraB3VmxxTJ4/rz1iNumYv+/Dw9RjWrB7?=
 =?iso-8859-1?Q?baGc1dKptvl0V5dgMQjZf2kKxzbet3kYwVFaufgCdrsa3aaB1IazHIDVgm?=
 =?iso-8859-1?Q?af+8s9ikbm15TQ5qZqxaIvZRtSNKALEDyHOhBc1TBKHfcwv7o7WmFFYU9V?=
 =?iso-8859-1?Q?sViwgkw/gxyi02hccsS3F1xg5+Gyv6aBNWKZSvCQ1TyFQotvSEviYYqxQC?=
 =?iso-8859-1?Q?w1CNoDCfxF/TistzYiYGW26U37b64xTj3r636L7AKmzJ1/BGOIenYB882z?=
 =?iso-8859-1?Q?nUvSwOyJmJNAXx6Tma5Ni3IW1A36ysPLoj4bu+lDyhcajyYBRnCvr0IurJ?=
 =?iso-8859-1?Q?ueligk0DOGT4/kqh2taj17SUoTWWiUbwbhvuxyiYFf7+EVJWxPEhbVZy+m?=
 =?iso-8859-1?Q?03K839bOF7soX3Q2fdHMmEeEsjSRhdq6YV/d8vvE64vvDXa23DDnETisEp?=
 =?iso-8859-1?Q?O/bK2C9rcZABlcTizT6EBuUKY/vxoj29lzUYtxtYQJpTYo3gVJHTmcoJB1?=
 =?iso-8859-1?Q?jYk8RfdM5Ikkf+cpwCa6iog1Gk2WPu4B50khc9U1wMkdzplk3nHTN7Pa3O?=
 =?iso-8859-1?Q?0nKfE67XGyx15N1HRu1ZyLOZmCB+e+zAP6kGrR1PJZh7AmEmKbLshZnSni?=
 =?iso-8859-1?Q?HClwY7j9FHKnnoKtJ0onM21HTZzmpWIikFsurL3QUSdmC5l3W+REjno5yc?=
 =?iso-8859-1?Q?spuRSqqKpsge8AkTJgU1IvjdOMrUDd6VVEERUHe65bUqESwtgYGXwp7Svc?=
 =?iso-8859-1?Q?DB0fQaQSCSMqPzBABwBBoC5KgX9jSXgLkArZXC1iojugMNP7JQ16VlXM/H?=
 =?iso-8859-1?Q?XA4VjSYNklz/h9jBor0zlCNNGhYgsuZeNTYe+F/NKeuU8kdUTkr1rYTkJs?=
 =?iso-8859-1?Q?1zuzlPUc7Q5LAU3nVTJiYAWMcelj9IScd9IIkH/lECD88XkEF/1iT3wmJD?=
 =?iso-8859-1?Q?0c+7J4haYla+xVCTM2mgw7eWIw6QIglAWgFejVGAyGAou4a9cdyRcKR6Pw?=
 =?iso-8859-1?Q?E01aorCZa3Wxdl2ZWIiaCnkAGmZk8z4GDGfp5nIXLvAdLVgW3yIz5E2Xwh?=
 =?iso-8859-1?Q?QcFndbBWg3Vpwi3jnhTsNOTR7lvqEnayWOpzMOQ5cBkuQmzkcTdngd6L1h?=
 =?iso-8859-1?Q?9eRBisAn/8kYD/zkyKbBH2jelUCsHv2ReF8I+A4wji1jpNvZ9NyJ2nftft?=
 =?iso-8859-1?Q?/MablV4elM6DOgUx7MeL9ySxMvieWIVdhniYroeKH/dORR2ov8lc3mViPJ?=
 =?iso-8859-1?Q?JttzGemTj89bPpqHvRR2J6iulRVtvbdYN35W/uiaR9hgf8GAACJ9a6p5iw?=
 =?iso-8859-1?Q?2BGCCgGXqiXKoumJl3gQRu06e+XkjlD9m5FaItd/Tz64tqFpY37+g59GPh?=
 =?iso-8859-1?Q?Dt8JatG7zcTVwFbEKGtlGxnghias39ASxuX2Oc8B8uJjwfLmatDTTNls1o?=
 =?iso-8859-1?Q?Uux4swRIv0gkR88MFbWGNEpAj47+Q0BIdELSAL3lUrwVQ3K5DtYRP/ow?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b242dd4e-9686-44f1-0eed-08dc64632546
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 13:33:36.9439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2s6LZuR4aokEwlgPPxjd7TBkYxRYSnVycRYUF12kirh9MB6kKlAsRCB3swv3voRWGX6gEtQjkmCn4Qzqn6AXKGGXLM4L0yQ17fc/muYAvQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6106
X-Proofpoint-GUID: vbrp4grc3W5kgZRgWcJcwoWANsUkOCil
X-Proofpoint-ORIG-GUID: vbrp4grc3W5kgZRgWcJcwoWANsUkOCil
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_11,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=774 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.21.0-2404010002
 definitions=main-2404240046

Enable ARCH_BLAIZE_BLZP1600 to get proper build coverage.

Reviewed-by: James Cowgill <james.cowgill@blaize.com>
Reviewed-by: Matt Redfearn <matt.redfearn@blaize.com>
Reviewed-by: Neil Jones <neil.jones@blaize.com>
Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2c30d617e180..7d368a8911bf 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -43,6 +43,7 @@ CONFIG_ARCH_BCM_IPROC=3Dy
 CONFIG_ARCH_BCMBCA=3Dy
 CONFIG_ARCH_BRCMSTB=3Dy
 CONFIG_ARCH_BERLIN=3Dy
+CONFIG_ARCH_BLAIZE_BLZP1600=3Dy
 CONFIG_ARCH_EXYNOS=3Dy
 CONFIG_ARCH_SPARX5=3Dy
 CONFIG_ARCH_K3=3Dy
--=20
2.34.1


