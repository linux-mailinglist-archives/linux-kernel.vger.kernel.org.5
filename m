Return-Path: <linux-kernel+bounces-140388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2888A13B1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF59B1C21311
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A61E14C5A1;
	Thu, 11 Apr 2024 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b="sdt/XpaE"
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BF81474BE;
	Thu, 11 Apr 2024 11:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.137.242
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836569; cv=fail; b=ltCCOpO/8g0w5l0B6CccssgWFeldiZtDGMhw8drHEDaxvALWqi1kVgtYLpjeIY3Ftib8CLX0OvEraC2q+3DWSBP6tw2PUqtBFV+ENJD1fQ5PyOnkY1Ck2Ydmee0EzGy+Wxcmq3rGQfHekDUszZl3D2zxkm9zXR2qWmZvzXoyr6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836569; c=relaxed/simple;
	bh=Lm1ZTVmELwli1x6mn9RKDOLvxf6mjw9v19ijukmcPmY=;
	h=From:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FF5gMg94Ih9c96Oh4HVWMeuMAKp9MLbqoediSbm+xwCsapkqr55TEi+SBqORxjJhRVFMwoZNhhAY2c3uGkRYYNtSPbBTuMBjtQC+GKQZHmR6Vg//4dMenIungZbgEPJeL+neZm0KZMugteN8kMTH1cJMQ+d10frlmTn9uXBpP9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epam.com; spf=pass smtp.mailfrom=epam.com; dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b=sdt/XpaE; arc=fail smtp.client-ip=148.163.137.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epam.com
Received: from pps.filterd (m0174681.ppops.net [127.0.0.1])
	by mx0b-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43B8O1qi005506;
	Thu, 11 Apr 2024 11:56:01 GMT
Received: from eur05-db8-obe.outbound.protection.outlook.com (mail-db8eur05lp2105.outbound.protection.outlook.com [104.47.17.105])
	by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3xecajrpfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 11:56:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kn7fyQAA8VtURtVfhCbmwVoaFyTzC4qF81AyYXUE/ko9igpABUneEFMPrRQET2t8NVUlj+z8kOkCqzZM0p7jc/xi+AOj6NuPYu3Ry60Q4/CSjmikcpBFDtAR/5D9tddssc3d7g2XafduUvwi0Fpl4ToZt3PRmkqJELu4vz5IZx7w9629Ia6AcGOU++K9vPB7uknY591cbIjCxA8vrz+LV68Xv9MuWCelXYItqQsY2uVkt5GaljxPZ2hU7g9H76oYNkys1oXwgSQxpMZ9f8JLJ2jltfzQeWPeGFF3bSB5glH9+Jc50ZTNT1uu2TkRljQrY1bTo7I40+eRRVWSIxxGfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+EiJlmnfVds9yRlfHVEd8OXe9/CAk3wCUSw6UOQhpE=;
 b=ApzWnUAsR9Kwz03UzI9uhGeO+Y/+xs7fpVsCohKtA8T5dNBcfMhzahdi0iDemeoLGwqaJxwkfyaXOcTRkooJYHOTEZdmvWi2FXNtFuBrK62/eusfx5+FhAODaCVECa14p0FLj/quk2Rm8Z8RBJeVcdjwTrygAxDwBj+TpGK7+01iWtqRpe87tJsef6gdcNv5wsMoGa/AZ0ihLb3GRcxq4kfbaS3hzBxTnYs2fiQnigOVxoJqkY9WKlYi69Cr4PYgrf3zqW/enVsPwtyqgAPB83UST1xGlSerWp3gq1BlDqM4iKooOtB5GmwA71BBdmDzsDijXvViHtF09k0nq16+bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+EiJlmnfVds9yRlfHVEd8OXe9/CAk3wCUSw6UOQhpE=;
 b=sdt/XpaEttMY/nUad05Sidu1dyDWiw9GVvR6gdsvhjV+YPxMq7dRLJ2/h5o0RncKdHnp/5YqI4WA7IOTYL4LAbs+TcnIOVXfbUgPWnGUyJskvcB4Ke1Vob5HxHsw51x2UouU5zOvW09QtXqcdhoX+IU+c6BpG0Q6Y331sTiPtcxeSMzs3133sCNGLMWwEfdCdPBaSL1cY3Gmoo5fj97IoY+aqLNDSM+SmpBK5e72jVF4ArcC/Z6fj7WB1SV5jnb1ityJI5jmMsqlVnQJVxXc+7bYABw09AiP8YkWB8mAQY0zqeVQttt9us7ZvF5VsAtgVSw1HeYmBq78p9atNfOy0A==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by PA4PR03MB8296.eurprd03.prod.outlook.com
 (2603:10a6:102:261::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 11:55:55 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::74c9:2488:1dd7:b976]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::74c9:2488:1dd7:b976%3]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 11:55:55 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
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
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] arm64: dts: qcom: sa8155p-adp: fix SDHC2 configuration
Thread-Topic: [PATCH v2] arm64: dts: qcom: sa8155p-adp: fix SDHC2
 configuration
Thread-Index: AQHajAc1RfBxI3QF4U667KfqA0a9CA==
Date: Thu, 11 Apr 2024 11:55:55 +0000
Message-ID: <20240411115506.1170360-1-volodymyr_babchuk@epam.com>
References: <20240410134022.732767-1-volodymyr_babchuk@epam.com>
In-Reply-To: <20240410134022.732767-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.44.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|PA4PR03MB8296:EE_
x-ms-office365-filtering-correlation-id: 489efa10-772c-4316-20de-08dc5a1e584d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ZyvnOiyiZ45kd6TUeQRg66u2oEJdTQFt5u5cN4HZPYaS018S4wQXAwEAQUC46MY8mhx9E4Ivs2fU838YCzyYRjn2Vx13JmlMiXB7n6GkaNMJVT7z2Ef+67enXA7cpqEAR3kZAX4oeGCxsXmzZ9hQvAj2iPVXhxeQ3iGZd7PCedpz1YYxTdihlzwTLyRVEQa2IZx16sR2FNEM6YBIZ7+zOig0enQ+PHvN21ejlTfb3dnmZhqWwKcv87f9WqLkyETuYiJGvmluDcH5KFL9irHibcUQdlFyZrELxBqjFRLkchZOG2OnOAJYFO/weGt3xp4AUvlZgISy1Vl5DU1dsRknBBgwNLsY2wtfVHdA3gFJzN89/C+uzH7KYjwz8kR9TNCbfmBMNPEb3rvK8ZgMewbfUTOQ7k9gwWWMgpzi5csirzzfOOzmERqnc+iS7u2/SS5YIiPRH0lJWedQ3kM2MRYZnZe35L5vnr6Es2Xnkql9ihNLouMa1X2FbAkMpnuNSeRLoWxgdRJFVVptRMFYA4QXRTk90Y6Q2lUqbBrYrWm1U2IMy8FKUBBrRPDPpcHltPGPaeyQwGu2gx9/Hsdeplja5xBxo5BalV1r4iKUeNCEsT3rINrFhuz3+Q0SHGhpJtzz4AEcM5gcAcGJMPb/bnpp8JvPTOwN/vSzm7vVww4LbzcmndkSiS1LarZdzZY03guOMcxTFzCUk1r9Q9S0oFxV+A==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR03MB10456.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?ErKWuYOfVwO5Aq6sZEBosu2sN8zLjSScP+RIVEgdBEZKpICG4S3u/0mpkf?=
 =?iso-8859-1?Q?gWbbhVdZiroRaqE0oVjTGuCmobrSu9IPc82lCSwyuRzoK0oESFVqqSZGPe?=
 =?iso-8859-1?Q?A/zULYAZg/e02PudfVPJ8WyOYpiL7gADSKv7yXp7AfaXiwVFkP/ibJP1Dc?=
 =?iso-8859-1?Q?a+ZdjleMtobfQLT0pD78PBxXAHrKKF+wSexucXDQ8ZIHPV/tPtZXhYU0fi?=
 =?iso-8859-1?Q?OLb+M7GcrVUT9e+AaghxE7h2jlQVAE9jG4gpRLCeT2VT+iDbkXOvhD36Y4?=
 =?iso-8859-1?Q?tfa7+4ZHPRBbf9dqy8dzM2hacnLph14FJcGAIfNVoTFMfQ/+QbvW7D6BoP?=
 =?iso-8859-1?Q?0YBOvxaIfmEgizg/zB9ZJcquEPuJP0axMT0He5/4BV1QDrBhXMiddHnjeV?=
 =?iso-8859-1?Q?O2W3Hprn3I0e+3qUD5HpjQCO3vvlzFf5J7so3S4HX0UDjZp97qHu52SPzV?=
 =?iso-8859-1?Q?N5KT5C1JA9ouGwpIHvOgvlKAY4Q0tyZRARtC7RrdLG40jQHbJi4+Xo079r?=
 =?iso-8859-1?Q?W22kumLafjkJbsIsxwjI+e2/Am6cR/nyT7oBkwEC34GmK7EImSkA8uBj1H?=
 =?iso-8859-1?Q?uonc/yGttwHOSWSmU9+xjgFEOnAkIiCUPACX33jaiVS7tDvYp4OwkRVgNf?=
 =?iso-8859-1?Q?ZROHvbDTafYBdB0UWp8Hi4xwj8S5BbXxPXLk8KdYvPARDGrJ6ayqivWjKB?=
 =?iso-8859-1?Q?gBDWYwyZpFHVxsFm/LBXEEiqudvEiph6JTffOFDi1BfCdTI8ERGmAIUOR5?=
 =?iso-8859-1?Q?giypUDpfK+l0CWjoEuUUsVamMwkmq+c7rhv5dQlfP7TT3PF3EFwjXdVkFT?=
 =?iso-8859-1?Q?fWqMfHTlU4vHNOvTMw4Eec7/DSVk7jXo4eAfR+nw7kxM4f4J6V9zCcmY6a?=
 =?iso-8859-1?Q?rCGQw7SRKVI03eE7lWaephUGAa3XwmutT64lcldBgQhqagB2OtT6AsW+j7?=
 =?iso-8859-1?Q?xWBGQf4ey2GPJRIVZ0W2+N4ph2RM4LaIzQWS8NKaMyGplTVkzjNhvFv36J?=
 =?iso-8859-1?Q?xNURS8Yvm2t1ZllU8X3iVZfm28fe39tSPscik8HPRCl3e7gjLTkfeDlTpr?=
 =?iso-8859-1?Q?LUu0ey4gXKuiyUdUIdMp8fPrcl4BFfrYmGyNed/qQFblqAzv7hJ9RROasi?=
 =?iso-8859-1?Q?pgirddKfw9DN1tw7Z3rAb2O5D+ri+Fdg3Pb8yqxuu/zsJkh6gUVz8GiEMl?=
 =?iso-8859-1?Q?U3TtjaycO8wgUHzZ5LSf2YBMUWyTgJ4682+Pe5VohSotl4TwDCK3Pp8KWk?=
 =?iso-8859-1?Q?lT7M99+J3wd8hNdcukQ2rodrKpGvG3O9swPOGOUL6h/Sh9LjyWlceTjfVT?=
 =?iso-8859-1?Q?hwiKcXZ2w3P31pxzMT+knSmeKy6R3PFmKkc4rS7aoc+GNL0syTPPeasFWu?=
 =?iso-8859-1?Q?nQsmNxZT95US3R50axz7y2Mfw0y8JPeeAEcSYWGYSSO1UbKY/98LtiTdJy?=
 =?iso-8859-1?Q?zxwBVQSyVV/E0OzZHVk3Utl2Gjx8SPHwxqEr2NbeWoWYPRWv1E46ONnabA?=
 =?iso-8859-1?Q?CIN72Gkwo9c1N75sHi4PgBJHB7lwpZ0IexJ18aaYvryAvQeSTN50pA0UZM?=
 =?iso-8859-1?Q?dqc0O9GeOvyjkTiLTP85+iwEGMQwROPlMNfxCuBGk2AVTywAqiEKIEi9Xo?=
 =?iso-8859-1?Q?tNIibL5KUKaM+AxQk69sAsWOGrQrsd7oeWgpo4gUvWXSdB7SMlV/yLRg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 489efa10-772c-4316-20de-08dc5a1e584d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 11:55:55.6674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PFNnjKxnkxE+Dbb/2b9NiOBrWK9ZS+QlSpVw13aVrGUFV4kQ4RYgQd1Hnb6uZc5EFG6p15PjhGO9OZlKxvF8QzUa5+fHXXXD6bpcUbwSNno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB8296
X-Proofpoint-ORIG-GUID: bKSzHqNAWnK5eh5rh0fOb5cnUZr_bRLP
X-Proofpoint-GUID: bKSzHqNAWnK5eh5rh0fOb5cnUZr_bRLP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_05,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1011 phishscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404110086

There are multiple issues with SDHC2 configuration for SA8155P-ADP,
which prevent use of SDHC2 and causes issues with ethernet:

- Card Detect pin for SHDC2 on SA8155P-ADP is connected to gpio4 of
  PMM8155AU_1, not to SoC itself. SoC's gpio4 is used for DWMAC
  TX. If sdhc driver probes after dwmac driver, it reconfigures
  gpio4 and this breaks Ethernet MAC.

- pinctrl configuration mentions gpio96 as CD pin. It seems it was
  copied from some SM8150 example, because as mentioned above,
  correct CD pin is gpio4 on PMM8155AU_1.

- L13C voltage regulator limits minimal voltage to 2.504V, which
  prevents use 1.8V to power SD card, which in turns does not allow
  card to work in UHS mode.

This patch fixes all the mentioned issues.

Fixes: 0deb2624e2d0 ("arm64: dts: qcom: sa8155p-adp: Add support for uSD ca=
rd")
Cc: stable@vger.kernel.org
Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>

---

In v2:
 - Added "Fixes:" tag
 - CCed stable ML
 - Fixed pinctrl configuration
 - Extended voltage range for L13C voltage regulator
---
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 32 +++++++++++-------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts=
/qcom/sa8155p-adp.dts
index 5e4287f8c8cd1..b9d56bda96759 100644
--- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
@@ -283,7 +283,7 @@ vreg_l12c_1p808: ldo12 {
=20
 		vreg_l13c_2p96: ldo13 {
 			regulator-name =3D "vreg_l13c_2p96";
-			regulator-min-microvolt =3D <2504000>;
+			regulator-min-microvolt =3D <1800000>;
 			regulator-max-microvolt =3D <2960000>;
 			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
 		};
@@ -384,10 +384,10 @@ &remoteproc_cdsp {
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
@@ -505,13 +505,6 @@ data-pins {
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
@@ -532,13 +525,6 @@ data-pins {
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
@@ -604,3 +590,13 @@ phy-reset-pins {
 		};
 	};
 };
+
+&pmm8155au_1_gpios {
+	pmm8155au_1_sdc2_cd: pmm8155au_1-sdc2-cd {
+			pins =3D "gpio4";
+			function =3D "normal";
+			input-enable;
+			bias-pull-up;
+			power-source =3D <0>;
+	};
+};
--=20
2.44.0

