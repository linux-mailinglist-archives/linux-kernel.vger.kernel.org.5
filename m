Return-Path: <linux-kernel+bounces-143236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B12B28A3623
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB4E1F236E5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDBF14F9F4;
	Fri, 12 Apr 2024 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b="PPuy52hP"
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1B114F13E;
	Fri, 12 Apr 2024 19:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.242
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712948617; cv=fail; b=GonEPDNz+eykvu0x+R8+Q1fxgfKd2AGrpiD7ezQ1kiH/I9TiS4D1dQmmjZ1T8IAWLwvnfWzkn7HR5xad+rX6xIvLBJBLGW1qFXK2tv3QMztBb+afyxOimovQMcKl08iDuaNN4+pzBhasB9eHA2MhR/gXmNk9C9q0MsQ5tWcSu8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712948617; c=relaxed/simple;
	bh=w0GXoPoVXq20ZzFqnCrUpBss5WcElt3jJ33vs4jXlQ4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nzslB+QNBjJLdLBxyMP+i9cRDE7NEIaEOmqeOAzJT1zyrSMpMAOxvNZVvG4YB3LNtVsfCABUQPrGkuckUD5bc1gLugtHr7Z6xTnUUg/IAuDwW4NbMZCcBFfTLY2b4CUMA/bo7SY6d7bVH16BpF0v1mqBaLqcTcQTu31M3/FaeaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epam.com; spf=pass smtp.mailfrom=epam.com; dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b=PPuy52hP; arc=fail smtp.client-ip=148.163.133.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epam.com
Received: from pps.filterd (m0174678.ppops.net [127.0.0.1])
	by mx0a-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43CDu5Bk020474;
	Fri, 12 Apr 2024 19:03:29 GMT
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104])
	by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3xf1saj9wy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 19:03:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acg/u1ZXXLYOxbDDPIvA/R1HjDUAWTaaSdo6Gjsq697nSRlY9f3AB5feRc/1iLzpbtNqWKw9KF9Iv+fduwdopZLa3bJhdjT4KFG5yGgRFKKo9rtSKPgfyNUr2An/08ICNdkNkRsU6BTek4JclBTr6OMCR0aGI3n7VMwoVCPcqZvrYYmJzmPF4uMNR7F3v5nsNQG7rn6HL/CMPuf5earYEofTDbSPL38pd2fDj8unwdRQhnO0+Cdynpmwb9QkDWsjZQW5/YZ6uYEwHYPk+xYxKUYDCEQ58fhueFrBrAPKbN5BkO/1/v4YSTbZTIFO7/0eSVnLa7I3+sAgWd2g4pPxtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZgT/yvE/u5C2JKDXUNRvWqf5cFw7ZY2EWmbfUam6nE=;
 b=XqsM8BnqwjVisgEOQ4PSv3bwJI+8jeZ8o9MyT2Ug1pUSw3xV4p66Ohw3AsYSvpPVQ1KAxsJ75ouWuK9OCbkKwvd5WO2HckmE5gFUsI7uYFPkqwGNiaG12a1ndOgsnzhJHuY0eHoq9vTuil+aebh/TEKyJGDYi7qclI7wDelC45Gqu60gtNxfP3daMj6TJdi/Mmh1QIJ8LCgd/ttoLxf1PuH0cVhmRGvj6lyp8A8jG1/u2S3dEPMnoFnmHbj/dfmzMyT2WZinnW7M4xO3isEkvkWjVv5WIOlv3ePOGCxrx/tP7/Ba+y3zfPa0kDLYV+IoFCTWG5U6TJvY3l2Q9DQCTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZgT/yvE/u5C2JKDXUNRvWqf5cFw7ZY2EWmbfUam6nE=;
 b=PPuy52hPuq2Et0SFGEPIeidvf4DMsrgg1D+a3LCFocl4GUODgBq6x3oZe+KfO3mgaeiR1jNKI2kv9JYKThbtRzsaSVj3Uq3FFp96XLLK1qBQhCplJsYXp2zipsZoy44xtzcI+H5BOlLo+mAqoj7QjdA7C5zWNiJslz5VEDK9bY4nJ90VzRbFAsmvRhMxSkK3L+gD6aC1FsyDWDV/T8hmsG56y9abTorMxs3e83FUFpsJp+rfTBlsdWfSv4K1CKJlIAeLT90Tx21gBRg2mqpPS6JpJMTICaX8DvOijAL4bZdypjm03hlJgCNADODdYa01gM2HxdoLRGqm9Kbjv+usPw==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by PAXPR03MB7934.eurprd03.prod.outlook.com
 (2603:10a6:102:219::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Fri, 12 Apr
 2024 19:03:26 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::74c9:2488:1dd7:b976]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::74c9:2488:1dd7:b976%3]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 19:03:25 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
CC: Stephan Gerhold <stephan@gerhold.net>,
        Volodymyr Babchuk
	<Volodymyr_Babchuk@epam.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad
 Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] arm64: dts: qcom: sa8155p-adp: fix SDHC2 CD pin
 configuration
Thread-Topic: [PATCH v3 1/2] arm64: dts: qcom: sa8155p-adp: fix SDHC2 CD pin
 configuration
Thread-Index: AQHajQwYOQ9To8w33EaflpLdE0ZqmQ==
Date: Fri, 12 Apr 2024 19:03:25 +0000
Message-ID: <20240412190310.1647893-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.44.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|PAXPR03MB7934:EE_
x-ms-office365-filtering-correlation-id: c3e3711f-1c08-4dfa-24fb-08dc5b233b52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 tLpDiKot25bQ5fOA/mLZ5tEuv4yhQRk9KRmo/jIJLUji/FlQ5e3lxar5BEbScQqRqPHbOrO6DTsgRyTeHsqV2nysgUKaKo1WZ3YhFKv1iU0CPXAY1QiegwVyaPN/s9NV8XV9ELmZ11X1AzY7ACrW69tZyOg6VOTNfxwR7ciLHpSHi9EgzjF7ESJkEdrmHxsvq9hw0wRtgYGiXYJkjlw/GJtVQ5qdJ/QzgVFqbZtHcGMLhqkTyttb8q/1x9bhLWQRqc6Bj3uf3qMJnSHyB4vVrZ8x7pEtEH0ZrRJCEMKf58d4mfVBCpj90TtvrHuZB6e2xu2WFUsv6EOBeZC7wLOb9Xx4KXBi25NvvyzAhDxXGkOtViczi6fAxrapJ+BoOeontBwZsbSN8VMJf1WVFI86FNaBaxYhQoUK0XJ/eoqTwYIi14vxBGnwoVvlGubK1GSWeD216fwQh9OfiF54yx2ar76dTLy8HEDkIVgob8XBpfAY+Ka04hjb/wg5Wr7ooX8KHJVraxqb13Ciem62ADNFnUEGodRCkhi5tkQHlP9uL8BJOtI+Xq3rTzDynYoDLlgq+mOqB0WA7Hrs7eTkLEmbeXzlsCwiF4kVGraXguDFvvbAf1NjRInN+0Q4S/1kyeY+SOCC5scwrwM23YZzdECRnTHzQIwNab5KbKHEA6+e/TzeE+DsOeF+IuQSuLfm97Mn5hJhHKhaQ1qtCkZbsJSQjQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR03MB10456.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?bILD0DFmUYl+HOfn4uk9rotdxpdMzuiSUDAIt4gnPnu/ciAHlavTCSmmTa?=
 =?iso-8859-1?Q?Jx7zMNQIBEyeq4oRnONCVWTGDFXgPjC92sJ2eQSM74zpIH50Z5z/4IOsKU?=
 =?iso-8859-1?Q?yCoQTVFr6y2BOqgnundNDd08wgc5ZL0cdXEcKebReXyPvcxhdI1lfJECSD?=
 =?iso-8859-1?Q?jyuJNkFn/Oiox1JUVA5xysBuKEtfOTmKqRoD5Om1iEVbyLiMs6FlNRx8P8?=
 =?iso-8859-1?Q?0P4IaLnsgncV+QHEhIbfQdQ84ygd95Vy12/7ugIMM9lIcHBqohha3VCNLI?=
 =?iso-8859-1?Q?GLVPzLVisdsjbDhNmo748aLepCIokEF0fz0IDhB41zW9CskbgWZIc5WRPc?=
 =?iso-8859-1?Q?l1hmVUJWfTqGKlubicbrLP+sWY9WhIYdx7oRylcg6FHzbQVuLWuCnGhhuA?=
 =?iso-8859-1?Q?+eHAgluEL76NcCYnbTuGDJOIZl5ftuGrAVopBl7h01e+pCcNVGCXNFOo+I?=
 =?iso-8859-1?Q?8lq6688999W7Au9GS9x6hab4sCy4czvAyHarcyttx51YR82J9HNJPOskAy?=
 =?iso-8859-1?Q?/f94poqrpQRDibTBXdnvlVql/wvZ/2PeRronC4bRjU+Po7YxQNjfiNhceG?=
 =?iso-8859-1?Q?Wc9un+U2lnDx1s6rVZrhgiqkglrqKNx9QETp/+fAINvUk2B4Z5oVmxFsnU?=
 =?iso-8859-1?Q?W6gMZVjKKyArtoWr5G8+xpb5yql2HsW+c8mgqa9t+9JoE+Mwg9ixwPpGN3?=
 =?iso-8859-1?Q?D5eKa3TiVlzO2jtgzVIs+qihfOr2Slr0Qn9Ye9+2oe0MM7TsuaKnANhCeL?=
 =?iso-8859-1?Q?/tSkhzvJ578gPYaovbXc0AtsLyoqvlODsYdqW0G6vsCW/w9+2dm9n3kYw1?=
 =?iso-8859-1?Q?voiRuduwE8+UWJVcHcqnxYLpqMBOUq7yKWzZYBlx58IwH1+Hk6lomPYa53?=
 =?iso-8859-1?Q?ypkJJVZuxFTleU7X5j/Z5Y2c02ObiJYvtBOu3HXgEU1Eed3qnI5ON+1Y1X?=
 =?iso-8859-1?Q?1+Omfgoe/CWagBNH2fIQ8DfCQBMDXtrEkX/pL2XgmWGtRvnFdlYnFerSp2?=
 =?iso-8859-1?Q?qrs2Iiy0XeVGucW0WkCg7UJpkhlxshQBxmab49n6wZCvoK6Z04J3terfjg?=
 =?iso-8859-1?Q?cDwo+gSTYLYEm2kCSzcHXHiV4K9k2g9RvK5SPi+nKdJ+La377bsnushMMI?=
 =?iso-8859-1?Q?zO0alzGf6RVspJCU1Tx3+S6SiHlg1txjF6fdxSQ1ehuchNr/Qg5Sjcl56L?=
 =?iso-8859-1?Q?p2HybWpMw23ucWoeZ/g3YBrA5PCmKjIkzpcf3oGCJDxckZLl4ENO25FlVA?=
 =?iso-8859-1?Q?gmwDnynv+JoCPwwfZ46rmKD4xURJ8tNNhI0Z6/6JIQtReWA1s1GpWc3uOd?=
 =?iso-8859-1?Q?D5l0QBz2N67sBh3RXg6gd6lvcAhCRJBnoW+7iCk4FjLnIvBtQI0tpodfdh?=
 =?iso-8859-1?Q?l18roawGyVDHJj6e/gQwko2J6Uy2j04mpl4i1Ax8OWukb94lfznkU6eaed?=
 =?iso-8859-1?Q?5NRMevKsEFc9q6ZfrB3k6idJc5NXQYHiq7mtCfjgwhtI91xrp/2+U+1+ub?=
 =?iso-8859-1?Q?zjpOb38dkvG6UBbSGdVtvgF+5CjXCnnRVXGOTV3Mm1e4twRzO4VrttG0lD?=
 =?iso-8859-1?Q?1UEqBcenLpRkUrxiZEqFrAdB/T7RjMX49t6HHKjNq50FMFksJIbSu29KhD?=
 =?iso-8859-1?Q?XBNIFUbdGsMZx9TlP7IJtqsFwepxZHmrJrBndJsLxDh6wFpYi5AiwaxQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e3711f-1c08-4dfa-24fb-08dc5b233b52
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 19:03:25.6564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8H5QoYLZxSjkL2udwVudHeOcV0COy7xmNgX2bcvFBAQ6xC2PMO0VeJb87EbkpCQgpbQyD1SKSQe426FqCPaBIWSTBirRfQftkgdc0GrSF4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7934
X-Proofpoint-ORIG-GUID: HVhugvE8dnL-QWE9DmElssdcV1qdmlbV
X-Proofpoint-GUID: HVhugvE8dnL-QWE9DmElssdcV1qdmlbV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_15,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0 suspectscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404120138

There are two issues with SDHC2 configuration for SA8155P-ADP,
which prevent use of SDHC2 and causes issues with ethernet:

- Card Detect pin for SHDC2 on SA8155P-ADP is connected to gpio4 of
  PMM8155AU_1, not to SoC itself. SoC's gpio4 is used for DWMAC
  TX. If sdhc driver probes after dwmac driver, it reconfigures
  gpio4 and this breaks Ethernet MAC.

- pinctrl configuration mentions gpio96 as CD pin. It seems it was
  copied from some SM8150 example, because as mentioned above,
  correct CD pin is gpio4 on PMM8155AU_1.

This patch fixes both mentioned issues by providing correct pin handle
and pinctrl configuration.

Fixes: 0deb2624e2d0 ("arm64: dts: qcom: sa8155p-adp: Add support for uSD ca=
rd")
Cc: stable@vger.kernel.org
Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>

---

In v3:
 - Moved regulator changes to a separate patch
 - Renamed pinctrl node
 - Moved pinctrl node so it will appear in alphabetical order
In v2:
 - Added "Fixes:" tag
 - CCed stable ML
 - Fixed pinctrl configuration
 - Extended voltage range for L13C voltage regulator
---
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 30 ++++++++++--------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts=
/qcom/sa8155p-adp.dts
index 5e4287f8c8cd1..b2cf2c988336c 100644
--- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
@@ -367,6 +367,16 @@ queue0 {
 	};
 };
=20
+&pmm8155au_1_gpios {
+	pmm8155au_1_sdc2_cd: sdc2-cd-default-state {
+		pins =3D "gpio4";
+		function =3D "normal";
+		input-enable;
+		bias-pull-up;
+		power-source =3D <0>;
+	};
+};
+
 &qupv3_id_1 {
 	status =3D "okay";
 };
@@ -384,10 +394,10 @@ &remoteproc_cdsp {
 &sdhc_2 {
 	status =3D "okay";
=20
-	cd-gpios =3D <&tlmm 4 GPIO_ACTIVE_LOW>;
+	cd-gpios =3D <&pmm8155au_1_gpios 4 GPIO_ACTIVE_LOW>;
 	pinctrl-names =3D "default", "sleep";
-	pinctrl-0 =3D <&sdc2_on>;
-	pinctrl-1 =3D <&sdc2_off>;
+	pinctrl-0 =3D <&sdc2_on &pmm8155au_1_sdc2_cd>;
+	pinctrl-1 =3D <&sdc2_off &pmm8155au_1_sdc2_cd>;
 	vqmmc-supply =3D <&vreg_l13c_2p96>; /* IO line power */
 	vmmc-supply =3D <&vreg_l17a_2p96>;  /* Card power line */
 	bus-width =3D <4>;
@@ -505,13 +515,6 @@ data-pins {
 			bias-pull-up;		/* pull up */
 			drive-strength =3D <16>;	/* 16 MA */
 		};
-
-		sd-cd-pins {
-			pins =3D "gpio96";
-			function =3D "gpio";
-			bias-pull-up;		/* pull up */
-			drive-strength =3D <2>;	/* 2 MA */
-		};
 	};
=20
 	sdc2_off: sdc2-off-state {
@@ -532,13 +535,6 @@ data-pins {
 			bias-pull-up;		/* pull up */
 			drive-strength =3D <2>;	/* 2 MA */
 		};
-
-		sd-cd-pins {
-			pins =3D "gpio96";
-			function =3D "gpio";
-			bias-pull-up;		/* pull up */
-			drive-strength =3D <2>;	/* 2 MA */
-		};
 	};
=20
 	usb2phy_ac_en1_default: usb2phy-ac-en1-default-state {
--=20
2.44.0

