Return-Path: <linux-kernel+bounces-94644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAA187429E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83F98B21748
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3C41BDCE;
	Wed,  6 Mar 2024 22:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b="EqpTCoIt"
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F0718EAB;
	Wed,  6 Mar 2024 22:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.137.242
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709763713; cv=fail; b=t6/Dc3GPdJJX+xD1Ag87cEDEG2+EXHXQ1P+G19Olw8TRZutNLfY4H2rATIzD6kHPHlf6k9qiZBtzeaj/6f8wufcpV32+USnBNpW//oozDAnKgrgb4uFwRSC74knPFPvlRQP07bz/gjDz5idKI+2MiyJ7LEIKvOZSueBAsPF27qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709763713; c=relaxed/simple;
	bh=ikDbV0OdMoxaOZkplE/+ZpRYlecrZofcRD3ZLNOdn3w=;
	h=From:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dneziFzYnN+Z04uhcbEkB7+ELSPMisGZ5039LKd7UIo1E+Zw7zzYJQdLzUGSZiedZtdpavpY8sTSmZIkwgMI50pto9mtKAiUu/C+dnkNK5/OuTilBh7URrrPcF+L1wqcnm89PK04QxJXKdzXH9i+cuNl7xmt1jzIpiMDixMfNJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epam.com; spf=pass smtp.mailfrom=epam.com; dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b=EqpTCoIt; arc=fail smtp.client-ip=148.163.137.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epam.com
Received: from pps.filterd (m0174680.ppops.net [127.0.0.1])
	by mx0b-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 426JmPdK013085;
	Wed, 6 Mar 2024 20:09:25 GMT
Received: from eur04-vi1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2050.outbound.protection.outlook.com [104.47.14.50])
	by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3wpg1wk94d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 20:09:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J97Q8qAx6RW27fCWnO8BS5jIMzWYmdyO3zlHB+/grKXqqSMkfGFxUtGrHpVxmN5JURk7P0kMjum47AKnVxwnIZ88b8MAE4lSnx2yo+mBiFF4sbWCEaQ6Hj1w7N0Sw3S9S3M29GS5nLRM4m72xWlt/lbjtgILtxaXfSwTOM8TekbnHle5sjbKnSHfIPN7DAcCl3MS0aEGxy6UqlO+SM5rfkMLsR2ACTUNWyPSexhJ5Tw9o8N1p8FBDJaCoQFcrpUaoS2D52Pb828Nko31K5MuCG+0EB36IYQhT+neSycR4hFqkz00l55DHKd4DtLscecMumFP5kuAGSZt/pTAcFD7Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9q2UimSOsgGg2OzdsJUGNxFsddrAQ63FCu8kWjIBEhw=;
 b=EnvHuM4sWkRIG/nKcyu2wyUevDJ4rhP47hjSvu9pWGjcJa6biV7s8ZFLhlA31furfNO+aMIh398lmHE+J3sDpwuq/D3QWrcB684DoAYd/38u8sxIEvNxQYKyB1g/zuMiKVdrH+wTOwvoUspQOd1SVjnKxEqMcFFGa21avBeuuqUHRK5KvCqT+ficuxDMUebDnrRg1oiMLrynWPB3mnSVnH4GFm3wxjuQBwmGnKIo481ZwXLXVrd5mkDU7nfg3Huka+vFmXvhRME3C5lSDBIvcUay/AkgAPGtziaNJfJ8loSPo9UZ5Hd2L3t3VzQh1XndfdUQBPCPb/OOvaa9EhzMew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9q2UimSOsgGg2OzdsJUGNxFsddrAQ63FCu8kWjIBEhw=;
 b=EqpTCoItQkQnIYccxqzOQqsz17kld0zr+66SzYjojwB1g8VqD0sUgxyzbY8lIQw9psPvfOx77IYt3CgWFUr2Rv/Aa375yG7R1y41YGK9FUvo4Ul13P99z7cFrDw4WtRoD7wB39pswiVYc9diSeDTgpC4YMbhhpdF+UZZNtfWwCiwS1i2wMtzh0zMHBXxwcnhEQsQiNKQ+qrjPYMLFtbEuwL48s4xn1nqi+RGFowmR/m4sWoSDnCvLCdUNc2jXyn8amWiNikF6NfWJc6yMcmDShZoqFRpo8d7o6cdjBPlb8jF6Ttk1P5ApQlvSLsube9zi2RfgdfHPsRAFbvFmH2AXQ==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by PAWPR03MB9763.eurprd03.prod.outlook.com
 (2603:10a6:102:2f2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 20:09:22 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8%4]) with mapi id 15.20.7362.024; Wed, 6 Mar 2024
 20:09:21 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
CC: Sumit Garg <sumit.garg@linaro.org>,
        Volodymyr Babchuk
	<Volodymyr_Babchuk@epam.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad
 Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: qcom: sm8150: add reset name for ethernet node
Thread-Topic: [PATCH] arm64: dts: qcom: sm8150: add reset name for ethernet
 node
Thread-Index: AQHacAItveF3myb2TEeE2+qqsjF4PA==
Date: Wed, 6 Mar 2024 20:09:21 +0000
Message-ID: <20240306200910.2732835-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.43.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|PAWPR03MB9763:EE_
x-ms-office365-filtering-correlation-id: f33e0bf8-ec41-4424-4d01-08dc3e19501d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 q34SOTIXYsOBIO5YSGhvYccQct2ksSWQeSNLs9oLoDQGDSiWKz8oraK0wTJup2HoTNte8KDUfnDuKCdmQZSNa3y8ZjpsQWjZPfiTglz8p3SGEHbUFUVZFi/tl8RiImEDaq/g7JSACCzHl+TASO1yPBg7JHzUDflTfIzD1azoItouly4y61JSdTd4j4GqZCe4knJWnIE9cp5ae7GwMBnbLhcoibW/RswoHX4Lu1PGWyMXQTdzB4LmodmuF8uH1gmh4L6akFXCn9Hh/69cmg7sIh4HPhI4b3Ma5A3DtUQ65Bq4YIo4oEnr+NgvQEwwXm0075sXFgqullKA2RsRXU+iOqWZKCm1Fm2hgV1cE84RAoX9HfCjupQjgP4XEEbHWsynWD32xsMZjpK1AGoWiIkmVJQHcy0N1hNBkpclbPHoV5devNP1XXAes6ms7ld3Eb+To4LEZ8tjN2tRBL12fhpGKRcmTctujmozjDxprNVTG4H/r98ikEJTysY4U/xZHOMG8wUnY7tWaip3eO/g+G0Ey8JFtvoxvfVzzwFbIFWNcbYw4eAdPdQNF/r9Eh+Okm4ZPlRR6SiGbc4HqMz8sTXcwMLqpPnjwxUIfJ6n7mgZUKP/JGrjhulfcxVNOl6mawAPpD/Q0UEi4un6aqydUohKmQ/z0yxQ6cQyKCy+aSVym2Oetpy1Upkc249M6OQh9b+eOSEyQgpLdaxvS/5ryKXBoP48H5UBPP30Tk0fT7NuoNo=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR03MB10456.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?sb3yPmw49Mv/CrOS8366t7KRihGzKv3XoHRvSlbMltggH5XvkG24Rh5Tn1?=
 =?iso-8859-1?Q?dR8q2aCAnwbHF+H02W5UM2VxVTxE1aPnfgGCbuC3qjs4VF4yeFmY03bJ8b?=
 =?iso-8859-1?Q?blyKzg11tnY1JA3JvrCGVNIstaowEhUIQR5ljReWBSLC7Dk05v90VG3gD5?=
 =?iso-8859-1?Q?bVzW29JJQEJMeXhXvgRlB8JU9jw/B5M72nASN5BbMIws2sDUE83AOFm/5O?=
 =?iso-8859-1?Q?qt5TFfKycuzLQVQy3zw8fhtRyJgMLogHm7PkTCtb3cAuDOF125afmjnsp8?=
 =?iso-8859-1?Q?eu/nhFwAfvvDlN818UNymNzlA9rogxpMa202nMpYdsWR/Jw/AiAbxwvvkz?=
 =?iso-8859-1?Q?jl166zn1CM8f2A+MqCakmyIjcVhM8mzSJUInEmyYKn5N8PFH/B9vDARjiA?=
 =?iso-8859-1?Q?D7G574+6jk3AnOEXsY7lI8/0ard3/e2PTL45aA944vpmM8C2LDIaXSyKk1?=
 =?iso-8859-1?Q?QTvrKN31ISLixU+wA+51EkquGw7TvFnF5gCEMmsfwY/7w0oPGvG8MGtLhW?=
 =?iso-8859-1?Q?2BM5j1MzSMXYEbDgPExCLWFGlzMCihK4/EwJU6o3c4Go2n2ZPOfqS4DEos?=
 =?iso-8859-1?Q?1+UGuxNF56jBIAnNZB2M4TdAjBAjnkxLtR9Kr8erU7hCfY4y2fmH/nnvpT?=
 =?iso-8859-1?Q?Ese1UggAdm8i0MyMlQDQ6zhD8cj8Yh4EQNGzNu4lLFmlT1wQ32sQUJ6Mrz?=
 =?iso-8859-1?Q?mKSFOiUGFyRunEBiy06UjDHbCanwsjk9A1S8v2bBb2eDQKZ29Vc/g/xOVg?=
 =?iso-8859-1?Q?LSBlZMS73d+Q0XDRGu77f/uSzzBVc4peGin3H4vcl9wwr3zT4gf1bm1dIU?=
 =?iso-8859-1?Q?SGJ3cXIjpeasEQ+CU+SbGo+hk9XlFRItuVVfnzysjekkUjdDrseSzQIOLB?=
 =?iso-8859-1?Q?Ae2YfbMmmajrrz34eRkCWitKmekL0CjgO9nMQJAXLLDi1xswNuL3tziAj8?=
 =?iso-8859-1?Q?20Y832b664Bk4MOtw4vot0Wa/y6OHHNbqNQzI0NMv8zkmGGC3VJ69Etk3B?=
 =?iso-8859-1?Q?McOjfZmKDG90rClzIIrTxDWlttkgdpoAg7WloP5XHkgQ/Hylqco2Y9TVes?=
 =?iso-8859-1?Q?wdKZCLZFgV2W5tXXvlQNCuCmnoDJ9Q0ooLOq+JPeFVR3caeJO+Tv/F9oKe?=
 =?iso-8859-1?Q?7sLgXBbbuCVVIZwI5m5AdBnYXLWGl5nn010g8eNmE+IRiAnojjz2s2nUkc?=
 =?iso-8859-1?Q?qR8XHnn4cgMX9GGF5NGNKyT88cIqXIXnaK2heE78sEc5jkuGq3kWQ9oDoy?=
 =?iso-8859-1?Q?s2PfV36rdS8lr3Kw4dg2pSXfvt7cD5A/kBqxr8IrVLXMjDBXWQ9saLe7zm?=
 =?iso-8859-1?Q?UozNMBvEV3MQ1eIokMcDKrOT8zzmcpe0mh1bcBM23Gsd7LzPlDiI0iu81M?=
 =?iso-8859-1?Q?bYEAOQbl1u0PA87je0wsFIKPR7XrIRpOtHETeBf+hq0gBW3YKoMtjWT/RV?=
 =?iso-8859-1?Q?+2T4z3BxNF6CCyGxSzWe8rlP4o8GpvxiapXc4DTlh7Cx2ucNeM59XrwQpo?=
 =?iso-8859-1?Q?56/ArEkwXwdP9YPD3dXn/a+ajQSVZX+EtgZSJQ+2SX01Pv+4ZdTDuUokLG?=
 =?iso-8859-1?Q?+i0LxbK18uIGceeWfN2nILqJR2YgUunTpmFIXD8H0KZFrRXIfp5PHefFl4?=
 =?iso-8859-1?Q?hR+J/yqL6ZdwS/YPJ4/elwnoJLEd1WRUoDcZf73BpIW9EVYphvY4h/pw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10456.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f33e0bf8-ec41-4424-4d01-08dc3e19501d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 20:09:21.8554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6KfB5I49DPIF6qytnfvzdbM+cQElC3UANp1cSDLBVdwyrxkWKtFBaEomAKRl1cZvb7x/2TH8NR+pRnxsxVCt86PnfhiNoh/0AuH758W0apU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9763
X-Proofpoint-ORIG-GUID: 9MFX-_cifhWMuO8sJPBnqK_nTnisUBec
X-Proofpoint-GUID: 9MFX-_cifhWMuO8sJPBnqK_nTnisUBec
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 impostorscore=0 clxscore=1011 malwarescore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2403060162

Add reset-names property to the ethernet@20000 node. This patch does
not change behavior on Linux, but it is needed for U-Boot, as it tries
to find the reset by name, not by index.

Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qco=
m/sm8150.dtsi
index 761a6757dc26f..c2e65d6a2ac62 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -951,6 +951,7 @@ ethernet: ethernet@20000 {
=20
 			power-domains =3D <&gcc EMAC_GDSC>;
 			resets =3D <&gcc GCC_EMAC_BCR>;
+			resets-names =3D "emac";
=20
 			iommus =3D <&apps_smmu 0x3c0 0x0>;
=20
--=20
2.43.0

