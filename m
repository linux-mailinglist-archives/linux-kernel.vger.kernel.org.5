Return-Path: <linux-kernel+bounces-156980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2B88B0B24
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 236C7B29125
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334AB15EFC5;
	Wed, 24 Apr 2024 13:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="Z4iCiYCk"
Received: from mx08-0063e101.pphosted.com (mx08-0063e101.pphosted.com [185.183.31.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34AB15B98B;
	Wed, 24 Apr 2024 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.155
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965626; cv=fail; b=VspfC3x8hAvJlAngXwlOh8ewy1DP1X2i9JRKMAst0LT5iDtAyFCVI0H9ouNQP9a6X2L5tqzZ9XL7ZS7IZb7ShuRwFt7PkNSFH3HjcX0dRWZvvKHFToK/+2KkKImbrCCMHXtrKNTub9VqKQXOAtTiqdcg7B3Csawl27ZHolqqgVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965626; c=relaxed/simple;
	bh=KT1p2AaPaW/Z058z1VsmtpYWvOFsPK3UaJbyagKzjJ8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lu1FXt5wnlB+nhqpddxs6w0KKwp7qBg+RXijibH25j3C/xhk5PsuLtTTtlu750xRSeV1xD5JlLmRrZ/iEvtKspvO4Rqcixhs3lbOtx0LNa1Ds1oDP7F2WzpeaIq0HLl2McjBwKwMaEdncb4dKKYnvY6rHxivVSpRUiWgKz1TtTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=Z4iCiYCk; arc=fail smtp.client-ip=185.183.31.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247494.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43ODU27P015721;
	Wed, 24 Apr 2024 14:33:27 +0100
Received: from pnzpr01cu001.outbound.protection.outlook.com (mail-centralindiaazlp17011004.outbound.protection.outlook.com [40.93.132.4])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 3xnxsfrqyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 14:33:27 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrtRhjGMEXvAWmQS/x/PTGklgvPEhUyPeEUveAwPCSD6JlbArchYRuge3hsJJk6V2mjJLUmjjXCGVClQVDl4dHIxQuFiMjepRuppZiUMpLk2XovrmEyvRaHPXCEV+5GR43GGZBhzovS5wrbBYQb7C8SOWbL3Y+mv9IFkNKzt9fqzurT5lbauVbmIORA9UhhzuOElwZL1QuHQaN1JBd0e3bkjVmQMiR7elvXNWILqFM8wD+s49OmUF7gZsLO0NAEeMtiwgwyVxlC2IR+chNcEHbRvasBDSMbO0qr9S2RIbvpnpfoe/gnaUu/HVIdZX5VFzyPcA0ouRWPPOXr2wVjsFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdfW/UAR8YM7QgKfgoXrdSUaYVY8YSZrdpB//rsqdm8=;
 b=PrPwkf4B937lbqHDISv1/5IAa+KqbL0Wc/jp90xJEf+IhMqPOW6zG1aTqJ6ov9cqSAA6+YQIacBerSSRxaAR6tpb0AqcgX8EqTN8hTRTc8HtJ/JlCr8cY2aJCdRWz//1QK7/J7NHuMqVqL9gG3pd5l1im8P3lCCvW7ZVMW51PdeWuLdBitic1HbpNmn7WvJnPEXrjRBJrrhBytW3w223Z42wFF4LitTM3cH9Ug2N1r0DvtfuIubBgSmJ0p/WYk2MIA+9jkK+2OILZKeu1J0EZi7RO7GGVTYvnHRfHKILFyjEoR+LjDR4hkelb3QrjezepVsDJhIPhXGp16a6D1zEBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdfW/UAR8YM7QgKfgoXrdSUaYVY8YSZrdpB//rsqdm8=;
 b=Z4iCiYCkrSPlwob7cKx4DrV1NDWlRfGzDZ6/is6nhFAuhWz3ZH0AJYu7vjmjYwibplTvfGoCVC1KVJ7r4ak/Xgune9WsgRUhULgMSWP+Gd9QUgsAbMhquujqn/Nmmn8DrkVG9UCiqVqXVowdUL5Z2gQNwXap3GdTREyLy7P+rl4=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by MA0PR01MB6106.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:7a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 13:33:23 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%3]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 13:33:23 +0000
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
 Jones <neil.jones@blaize.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson
	<olof@lixom.net>, "soc@kernel.org" <soc@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: [PATCH v2 6/7] arm64: Add initial support for Blaize BLZP1600 CB2
Thread-Topic: [PATCH v2 6/7] arm64: Add initial support for Blaize BLZP1600
 CB2
Thread-Index: AQHalkv6j7L/VUx8ekGpZfmYzieIYw==
Date: Wed, 24 Apr 2024 13:33:23 +0000
Message-ID: <20240424133320.19273-1-nikolaos.pasaloukos@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB10184:EE_|MA0PR01MB6106:EE_
x-ms-office365-filtering-correlation-id: 8bf49b84-c3cf-4213-e7cb-08dc64631d26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?7gNwhSi0knNN5+/v7e4zdEE2WwEbHPF5lXkahe4JkLp5HQvkQ63CprFRvS?=
 =?iso-8859-1?Q?PmHOjFEfkrpCS7cuaKVZrsJMGFFj7JdSSTdmRFNIOUNSUOW7dedDJDFfPb?=
 =?iso-8859-1?Q?feQNYQmfQokqwv8o6v6yUBDPipdscSELtQ7oG9dRFNU+T2A3icDx2ZA3Wp?=
 =?iso-8859-1?Q?KLvBI1E+7wfOZP4JZtyF+OLWIFfPVsMYOM2Vy6yUWSc7potNAUKS6azGtq?=
 =?iso-8859-1?Q?9yt7HC9Vj4MaA6qeydj2L6LYd26d0UN+C+dHfMpCREYxUedenCRKu9l8g5?=
 =?iso-8859-1?Q?UtanSmprNxl5XqKED1oqmEkJRasVvfmkHQ0VN5WMtSsWsCUCI6oF90KOCd?=
 =?iso-8859-1?Q?Tr7eOIN9hBodn8/FfbS8Yh5aP6g+py0V4xbu7evMht/UZY+h+Q+jc4bWXj?=
 =?iso-8859-1?Q?JsPZOzgpskBqTG9lC/APoTK2aJFX4zh+Jtlq7ALIjFof4pqSpgU9ZW8hfn?=
 =?iso-8859-1?Q?rp9Y7jdjSENGP0Jrpb/VuPdTSmQQpcRJ9ufff0kWyQWz5kxRe7PvQpL2Ay?=
 =?iso-8859-1?Q?BD/hBefbiFLT54Xv1EPUVrItdk3mwGB0YzzACOChdXQNR1aOWuReMfWtts?=
 =?iso-8859-1?Q?ruTNjontfURq4ED9lOnUVuiRl11urZO7WNGOdk3hPdvhVFgM5HscF/oHqG?=
 =?iso-8859-1?Q?lZC6B5vqUsvULvsxDQ/ie13JSiyWsIQ6YGQdV5U1p7RMBKzIvfqRzatJlK?=
 =?iso-8859-1?Q?OqQtT9SoXHZgbYS0PSxt+tH/UdGrW1yHMQYlt9JhE/qlanlG7o8vzC6y22?=
 =?iso-8859-1?Q?5G3JkHXArR6U9jePXVD2AjGcXi/eWmJP2t1toOt4MVs6zs3MGnBkatKo8/?=
 =?iso-8859-1?Q?xHznluvZR8TvRLdVty/bVB6A+/BbhgFkFsSFxxmM4z7neXNb7j0pmr8In5?=
 =?iso-8859-1?Q?9LeGIj0DBp9WgA2Jk99ogIy+oDf57VFwzs2EvHOFNmq/YZhNRwqluxDpNw?=
 =?iso-8859-1?Q?g832aCRGkxDImwHYdXAFzygt9WvbDkuP6SVQEeN397zHLmunvjW51MZdtj?=
 =?iso-8859-1?Q?iu30xcVYIGTx1pLWRGxUJHsHtaYJgu/IgnDJTd2KIGmoE4nxR3+w4eiVd9?=
 =?iso-8859-1?Q?k1P3Cp7kVhPTLwq4oXRDr9tC+Xw4NqhmSnxnwL8riYOd8sXLhK5bFO0vMt?=
 =?iso-8859-1?Q?Ua9y1SEhBTxVZxbMu+QT9tzhbaYhP591ZyjIb7f5PSQODmkimzMcuWYvTq?=
 =?iso-8859-1?Q?BDwCwQ6p9qlJhC7XBfbn9Zgls64+FqUABwh7a161Ha/6LG+weBAVITWWIy?=
 =?iso-8859-1?Q?a5rFGr6zyA9EpMmqNEYZ+zT+URstUqkdlG80jL9IG6MxAh1br+OK/ug5Iy?=
 =?iso-8859-1?Q?gpHY8byzMQqIzX2+IPaVOWcYcY+exMCqBkxJlRPEQEaSQz5SzK+stIrBeN?=
 =?iso-8859-1?Q?rgLgH35CTVKMi0foGN/rg6rllqzFhZqA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?ABKQc3wbWt85b8nNw0a11zqt8J3ymBNMMAc3+03uraKSWCZyPTQiE+iIkp?=
 =?iso-8859-1?Q?ho8iAdrsBowRb+UOWiKQvGJ2mdug8T/t+xqHWStQz3W4KQXo9MMQZFL3yw?=
 =?iso-8859-1?Q?Rc7Sw/p9OWjbma/p0WoxpGzEEj247N2sPhGDK2bTECwLTi+/yNMhmy9QqS?=
 =?iso-8859-1?Q?JM+4Volfwv1DHp12wpdYnDj8CWRjLn65C2Sg1rcSOaS6KvKoG1wfWHig+7?=
 =?iso-8859-1?Q?6w2aNdlSU0AXDdCA2+FN0j6FTr3dS25K69lp1gyaGTWH9gBNmm8KWRx9Uh?=
 =?iso-8859-1?Q?hbwwAbKHQq1KcFygDAL6U1rA6FUrROTT3S3CRZYr5pHNggsYFNMSuhQMAO?=
 =?iso-8859-1?Q?lBvJ4vOg+4GUbsb5+Tq4IwVeiRJyu9d2c1PiIDTIh85v1HV5zjVU0T1rL/?=
 =?iso-8859-1?Q?z2otjFFgpn8FDJcsfa2LSCkocrLuSsKJJcLszauXQDcDWXe726IZZuKlbL?=
 =?iso-8859-1?Q?Mm5TXX0QAVMfCZhEbcULwndzwb3JCNgnHS8YZqWpz9eFoGbk9t4Nwoc7X9?=
 =?iso-8859-1?Q?Uxfa+rjHXWV0zLa7xv+N6omUAbmBmArUCQZ8p/gmuVzxnraHcRob1yNewg?=
 =?iso-8859-1?Q?Ikvr4dwCiX9Ic0DWgCV/xubGK1ufPisRRlC8j1bblutHUrovmTlwA5/RiU?=
 =?iso-8859-1?Q?+Iw83lEZXGnp81b+7gHb6NgyGpmG3lMY7GBvkJeN9T0Fw/fZXGy2R08k4B?=
 =?iso-8859-1?Q?/v/vNdorx/SQa6mlettabE78WRaqZTDobYaHs/oKb6QpMVa2Tpafz9VuOI?=
 =?iso-8859-1?Q?N+UmmgYTJTObMEwh/jdhQxbfzwgpI4GFK5F9btQlWx9Pj56BHVE1Z1+Q6f?=
 =?iso-8859-1?Q?iiDmbAsQOmG77v6v0sF2NAFeRnG2jFoXe9Fu0amep9ofhNm7OHm7BkmKDC?=
 =?iso-8859-1?Q?Iw3kmqub72uTMsesS3R4KwClaJ64ODM/mU3uhaN1DyJ1tS21TpvkdkQEfm?=
 =?iso-8859-1?Q?pSlwZIpA2WgSccfGFPBB0zxAiy0oPiH5uLx1uryicdgmCSyvlQY9ZRk7+d?=
 =?iso-8859-1?Q?FrsbvFjNQo6xWWWi4vQcUedIb5RSiwykz99tbDGTi6O6sVgpqhruTQGLxT?=
 =?iso-8859-1?Q?pweNYrgjEJ1rm8Zo3cVH7CyRrlxh9aiDKex73xY19XK6LXNvMu4U2QUjbk?=
 =?iso-8859-1?Q?IDxWhw1iBir3ZPB12Ximdfvu/VDZe+KLo1XPVWbUVrDGO97jjgmntlPSTC?=
 =?iso-8859-1?Q?6f9NP29wJGZhDQxzCSp2Sko2DvgKt3oESrWin7ubBrk//NPm9MhIWUYg0s?=
 =?iso-8859-1?Q?8t/FJfUIiwEl6zfnTUFyGmoKSTmHjXW+TUYJ+b4n1fqXTb6c0iLcQMM9Qy?=
 =?iso-8859-1?Q?mUcQw4CPCE5jPyVv8uuycvbw7rvUzwUIIbYF64Jugqa7irtzC+z91JEWIB?=
 =?iso-8859-1?Q?Rn9pnX6NYJUKD77ltc2DAUFo/JV+QkW6r9iY/wX0hilHW3o3MuOxLMfvSV?=
 =?iso-8859-1?Q?KoIn8yI7plabyqembEMiqv4IfHg1k5GzhBUPZ68sdvkjJ4rcvgWGF6j2Ki?=
 =?iso-8859-1?Q?XN5VgvRX17rL3g6ZGIePQRJrpvPTVvKgvSaItadpnVTdyqkVBM+1NHEsM7?=
 =?iso-8859-1?Q?JP6UIAHe3U3YGcTiDVQ21YIyT3PmU3+6KtqOW4GTM17NNi1qJNhmoB9KfF?=
 =?iso-8859-1?Q?uZeORsl+rG/YiyxcAxVLwLB/Hwqx36nplCd2dqmq8JS2I/b4SQhPP9/w?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf49b84-c3cf-4213-e7cb-08dc64631d26
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 13:33:23.3001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8iUjjjBCe6pPcmxfCm2JWwpJooJMmOENCFXymXMBZDY2iv95ZqzYl+P4O2s3fQ8crCiXG1GqZpu0Lla5L5fkxDvN2hFeo1C/cOSNXE5YU+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6106
X-Proofpoint-GUID: EpyYxUPhq1wzrF_3df5iLk2tBRFtkCqR
X-Proofpoint-ORIG-GUID: EpyYxUPhq1wzrF_3df5iLk2tBRFtkCqR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_11,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2404010002 definitions=main-2404240046

Adds support for the Blaize CB2 development board based on
BLZP1600 SoC. This consists of a Carrier-Board-2 and a SoM.

The blaize-blzp1600.dtsi is the common part for the SoC,
blaize-blzp1600-som.dtsi is the common part for the SoM and
blaize-blzp1600-cb2.dts is the board specific file.

'make dtbs_check' complains about ['ti,ina3221'] and ['national,lm96163']
which are already upstreamed drivers with no yaml documentation.

Co-developed-by: James Cowgill <james.cowgill@blaize.com>
Signed-off-by: James Cowgill <james.cowgill@blaize.com>
Co-developed-by: Matt Redfearn <matt.redfearn@blaize.com>
Signed-off-by: Matt Redfearn <matt.redfearn@blaize.com>
Co-developed-by: Neil Jones <neil.jones@blaize.com>
Signed-off-by: Neil Jones <neil.jones@blaize.com>
Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
---
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/blaize/Makefile           |   2 +
 .../boot/dts/blaize/blaize-blzp1600-cb2.dts   |  84 +++++++
 .../boot/dts/blaize/blaize-blzp1600-som.dtsi  |  23 ++
 .../boot/dts/blaize/blaize-blzp1600.dtsi      | 211 ++++++++++++++++++
 5 files changed, 321 insertions(+)
 create mode 100644 arch/arm64/boot/dts/blaize/Makefile
 create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600-cb2.dts
 create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi
 create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 30dd6347a929..601b6381ea0c 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -9,6 +9,7 @@ subdir-y +=3D apm
 subdir-y +=3D apple
 subdir-y +=3D arm
 subdir-y +=3D bitmain
+subdir-y +=3D blaize
 subdir-y +=3D broadcom
 subdir-y +=3D cavium
 subdir-y +=3D exynos
diff --git a/arch/arm64/boot/dts/blaize/Makefile b/arch/arm64/boot/dts/blai=
ze/Makefile
new file mode 100644
index 000000000000..595e7a350300
--- /dev/null
+++ b/arch/arm64/boot/dts/blaize/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_BLAIZE_BLZP1600) +=3D blaize-blzp1600-cb2.dtb
diff --git a/arch/arm64/boot/dts/blaize/blaize-blzp1600-cb2.dts b/arch/arm6=
4/boot/dts/blaize/blaize-blzp1600-cb2.dts
new file mode 100644
index 000000000000..0bdec7e81380
--- /dev/null
+++ b/arch/arm64/boot/dts/blaize/blaize-blzp1600-cb2.dts
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Blaize, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "blaize-blzp1600-som.dtsi"
+#include <dt-bindings/net/ti-dp83867.h>
+
+/ {
+	model =3D "Blaize BLZP1600 SoM1600P CB2 Development Board";
+
+	compatible =3D "blaize,blzp1600-cb2", "blaize,blzp1600";
+
+	aliases {
+		serial0 =3D &uart0;
+	};
+
+	chosen {
+		stdout-path =3D "serial0:115200";
+	};
+};
+
+&i2c0 {
+	clock-frequency =3D <100000>;
+	status =3D "okay";
+};
+
+&i2c1 {
+	clock-frequency =3D <100000>;
+	status =3D "okay";
+};
+
+&i2c3 {
+	clock-frequency =3D <100000>;
+	status =3D "okay";
+
+	gpio_expander: gpio@74 {
+		compatible =3D "ti,tca9539";
+		reg =3D <0x74>;
+		gpio-controller;
+		#gpio-cells =3D <2>;
+		gpio-line-names =3D "RSP_PIN_7",	/* GPIO_0 */
+				  "RSP_PIN_11",	/* GPIO_1 */
+				  "RSP_PIN_13",	/* GPIO_2 */
+				  "RSP_PIN_15",	/* GPIO_3 */
+				  "RSP_PIN_27",	/* GPIO_4 */
+				  "RSP_PIN_29",	/* GPIO_5 */
+				  "RSP_PIN_31",	/* GPIO_6 */
+				  "RSP_PIN_33",	/* GPIO_7 */
+				  "RSP_PIN_37",	/* GPIO_8 */
+				  "RSP_PIN_16",	/* GPIO_9 */
+				  "RSP_PIN_18",	/* GPIO_10 */
+				  "RSP_PIN_22",	/* GPIO_11 */
+				  "RSP_PIN_28",	/* GPIO_12 */
+				  "RSP_PIN_32",	/* GPIO_13 */
+				  "RSP_PIN_36",	/* GPIO_14 */
+				  "TP31";	/* GPIO_15 */
+	};
+
+	gpio_expander_m2: gpio@75 {
+		compatible =3D "ti,tca9539";
+		reg =3D <0x75>;
+		gpio-controller;
+		#gpio-cells =3D <2>;
+		gpio-line-names =3D "M2_W_DIS1_N",	/* GPIO_0 */
+				  "M2_W_DIS2_N",	/* GPIO_1 */
+				  "M2_UART_WAKE_N",	/* GPIO_2 */
+				  "M2_COEX3",		/* GPIO_3 */
+				  "M2_COEX_RXD",	/* GPIO_4 */
+				  "M2_COEX_TXD",	/* GPIO_5 */
+				  "M2_VENDOR_PIN40",	/* GPIO_6 */
+				  "M2_VENDOR_PIN42",	/* GPIO_7 */
+				  "M2_VENDOR_PIN38",	/* GPIO_8 */
+				  "M2_SDIO_RST_N",	/* GPIO_9 */
+				  "M2_SDIO_WAKE_N",	/* GPIO_10 */
+				  "M2_PETN1",		/* GPIO_11 */
+				  "M2_PERP1",		/* GPIO_12 */
+				  "M2_PERN1",		/* GPIO_13 */
+				  "UIM_SWP",		/* GPIO_14 */
+				  "UART1_TO_RSP";	/* GPIO_15 */
+	};
+};
diff --git a/arch/arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi b/arch/arm=
64/boot/dts/blaize/blaize-blzp1600-som.dtsi
new file mode 100644
index 000000000000..efac0d6b3d60
--- /dev/null
+++ b/arch/arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Blaize, Inc. All rights reserved.
+ */
+
+#include "blaize-blzp1600.dtsi"
+
+/ {
+	memory@1000 {
+		device_type =3D "memory";
+		reg =3D <0x0 0x00001000 0xfffff000>;
+	};
+};
+
+/* i2c4 bus is available only on the SoM, not on the board */
+&i2c4 {
+	clock-frequency =3D <100000>;
+	status =3D "okay";
+};
+
+&uart0 {
+	status =3D "okay";
+};
diff --git a/arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi b/arch/arm64/b=
oot/dts/blaize/blaize-blzp1600.dtsi
new file mode 100644
index 000000000000..ad1e502559d8
--- /dev/null
+++ b/arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Blaize, Inc. All rights reserved.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/blaize,blzp1600-reset.h>
+#include <dt-bindings/clock/blaize,blzp1600-clk.h>
+
+/ {
+	interrupt-parent =3D <&gic>;
+	#address-cells =3D <2>;
+	#size-cells =3D <1>;
+
+	cpus {
+		#address-cells =3D <2>;
+		#size-cells =3D <0>;
+
+		cpu0: cpu@0 {
+			compatible =3D "arm,cortex-a53";
+			device_type =3D "cpu";
+			enable-method =3D "psci";
+			reg =3D <0x0 0x0>;
+			next-level-cache =3D <&l2>;
+		};
+
+		cpu1: cpu@1 {
+			compatible =3D "arm,cortex-a53";
+			device_type =3D "cpu";
+			enable-method =3D "psci";
+			reg =3D <0x0 0x1>;
+			next-level-cache =3D <&l2>;
+		};
+
+		l2: l2-cache0 {
+			compatible =3D "cache";
+			cache-level =3D <2>;
+			cache-unified;
+		};
+	};
+
+	timer {
+		compatible =3D "arm,armv8-timer";
+		interrupts =3D /* Physical Secure PPI */
+			     <GIC_PPI 13 (GIC_CPU_MASK_RAW(0x3) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     /* Physical Non-Secure PPI */
+			     <GIC_PPI 14 (GIC_CPU_MASK_RAW(0x3) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     /* Hypervisor PPI */
+			     <GIC_PPI 10 (GIC_CPU_MASK_RAW(0x3) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     /* Virtual PPI */
+			     <GIC_PPI 11 (GIC_CPU_MASK_RAW(0x3) |
+					  IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	psci {
+		compatible =3D "arm,psci-1.0", "arm,psci-0.2";
+		method =3D "smc";
+	};
+
+	pmu {
+		compatible =3D "arm,cortex-a53-pmu";
+		interrupts =3D <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity =3D <&cpu0>, <&cpu1>;
+	};
+
+	sram@0 {
+		/*
+		 * On BLZP1600 there is no general purpose (non-secure) SRAM.
+		 * A small DDR memory space has been reserved for general use.
+		 */
+		compatible =3D "mmio-sram";
+		reg =3D <0x0 0x00000000 0x00001000>;
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		ranges =3D <0 0x0 0x00000000 0x1000>;
+
+		/* SCMI reserved buffer space on DDR space */
+		scmi0_shm: scmi-sram@800 {
+			compatible =3D "arm,scmi-shmem";
+			reg =3D <0x800 0x80>;
+		};
+	};
+
+	firmware {
+		scmi {
+			compatible =3D "arm,scmi-smc";
+			arm,smc-id =3D <0x82002000>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+
+			shmem =3D <&scmi0_shm>;
+
+			scmi_clk: protocol@14 {
+				reg =3D <0x14>;
+				#clock-cells =3D <1>;
+			};
+
+			scmi_rst: protocol@16 {
+				reg =3D <0x16>;
+				#reset-cells =3D <1>;
+			};
+		};
+	};
+
+	soc {
+		compatible =3D "simple-bus";
+		#address-cells =3D <2>;
+		#size-cells =3D <1>;
+		ranges;
+
+		gic: interrupt-controller@200410000 {
+			compatible =3D "arm,gic-400";
+			#interrupt-cells =3D <3>;
+			#address-cells =3D <0>;
+			interrupt-controller;
+			reg =3D <0x2 0x00410000 0x20000>,
+			      <0x2 0x00420000 0x20000>,
+			      <0x2 0x00440000 0x20000>,
+			      <0x2 0x00460000 0x20000>;
+			interrupts =3D <GIC_PPI 9 (GIC_CPU_MASK_RAW(0x3) |
+						 IRQ_TYPE_LEVEL_LOW)>;
+		};
+
+		uart0: serial@2004d0000 {
+			compatible =3D "ns16550a";
+			reg =3D <0x2 0x004d0000 0x1000>;
+			clocks =3D <&scmi_clk BLZP1600_UART0_CLK>;
+			resets =3D <&scmi_rst BLZP1600_UART0_RST>;
+			reg-shift =3D <2>;
+			interrupts =3D <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			status =3D "disabled";
+		};
+
+		uart1: serial@2004e0000 {
+			compatible =3D "ns16550a";
+			reg =3D <0x2 0x004e0000 0x1000>;
+			clocks =3D <&scmi_clk BLZP1600_UART1_CLK>;
+			resets =3D <&scmi_rst BLZP1600_UART1_RST>;
+			reg-shift =3D <2>;
+			interrupts =3D <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			status =3D "disabled";
+		};
+
+		i2c0: i2c@2004f0000 {
+			compatible =3D "snps,designware-i2c";
+			reg =3D <0x2 0x004f0000 0x1000>;
+			interrupts =3D <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&scmi_clk BLZP1600_I2C0_CLK>;
+			resets =3D <&scmi_rst BLZP1600_I2C0_RST>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c1: i2c@200500000 {
+			compatible =3D "snps,designware-i2c";
+			reg =3D <0x2 0x00500000 0x1000>;
+			interrupts =3D <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&scmi_clk BLZP1600_I2C1_CLK>;
+			resets =3D <&scmi_rst BLZP1600_I2C1_RST>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c2: i2c@200510000 {
+			compatible =3D "snps,designware-i2c";
+			reg =3D <0x2 0x00510000 0x1000>;
+			interrupts =3D <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&scmi_clk BLZP1600_I2C2_CLK>;
+			resets =3D <&scmi_rst BLZP1600_I2C2_RST>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c3: i2c@200520000 {
+			compatible =3D "snps,designware-i2c";
+			reg =3D <0x2 0x00520000 0x1000>;
+			interrupts =3D <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&scmi_clk BLZP1600_I2C3_CLK>;
+			resets =3D <&scmi_rst BLZP1600_I2C3_RST>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c4: i2c@200530000 {
+			compatible =3D "snps,designware-i2c";
+			reg =3D <0x2 0x00530000 0x1000>;
+			interrupts =3D <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&scmi_clk BLZP1600_I2C4_CLK>;
+			resets =3D <&scmi_rst BLZP1600_I2C4_RST>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		arm_cc712: crypto@200550000 {
+			compatible =3D "arm,cryptocell-712-ree";
+			reg =3D <0x2 0x00550000 0x1000>;
+			interrupts =3D <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&scmi_clk 7>;
+		};
+	};
+};
--=20
2.34.1


