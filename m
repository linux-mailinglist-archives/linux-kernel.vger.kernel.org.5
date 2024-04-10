Return-Path: <linux-kernel+bounces-138811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 842C289FAA7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109641F30F15
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786E2179667;
	Wed, 10 Apr 2024 14:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b="Ppz5Jw5r"
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07E6179644;
	Wed, 10 Apr 2024 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.137.242
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712760546; cv=fail; b=SX9Os26JQbpfqA9q3kgDpZWpXNcemobXHXBlejH2sjreL5Bh7MEv1gcbznYicRPgONbvjWB77wDJjhzmUD4wnFzTAw+MHSkFYuQt/xd7+UuFvL9eVhyod3Qki5ojl0yJQqlRWKD6NjDqX0pZgLuGtqxmKXPWciPOo1RI6g9tGOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712760546; c=relaxed/simple;
	bh=kgw6ePhQ3gzGUJqVhFfkF7xlHLTqshV6uStCImBTV7Y=;
	h=From:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=n1g+t79X0DOoy0v97qDdmpezC+V8zt3aM0Q4w0l+6cxVrvn6yG0/UpYIJ/DHpTkD6AseLNpr1Vxb7SYRnwGE1foRQpkjRlR10r6slhlQ6pviJw8sCLcI4VMISgw6lZo04v2OqYgaAIYAqt3+ApQWczt+sXoPH6MCcXbMUEkZU6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epam.com; spf=pass smtp.mailfrom=epam.com; dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b=Ppz5Jw5r; arc=fail smtp.client-ip=148.163.137.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epam.com
Received: from pps.filterd (m0174681.ppops.net [127.0.0.1])
	by mx0b-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43ACemw4007954;
	Wed, 10 Apr 2024 13:41:38 GMT
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104])
	by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3xdu02g7ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 13:41:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQDfsljGcVSDhFXVZ9DEF/1TwiPGXhMFycPa5kxwE+j/L8p7x2RAktBdOG2Jf6BkdocfuUQw4wxg0Lk7Xr1RejTIXT54woEDtAXfzDwZv5AUzW9urMh2IBuukAusWYt9h666O5wwy2HFatAWeG03Dg2b5fj98evWZUxeWl85oCNRw1V7JWFtl8imwn9UH/13QQyUyGqr2dWkyr5aqr72hwbhhSLuPoR3IhQa2nOKm05hqkT7rUAOfsOoYYga4n1e/fdFkmxJPU1sY9acCViFZXlQEcsAAUncFXp1KwGXhOQ96HK5idO8G23UMoP76TtXV2w2UssdkjmR5b+wkUq5zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLG4d493oSU/IXqZx5H2+fP+w27hxO2MQYEKsC6L02s=;
 b=QkPy4c9eXmlXwza7tctvsvmr6b//S5Va1GJg8a4mVVvVWSFxEQwzq8ZYvX7m7T2dLP0JsncuNFiHCOOaPlzgkVaW0B7QSkdH8Lsk1pIr09tbru3MBEIUxnF5i8m1tyYgXRJDo3O1I1ksa6DiUtUrAy307fA1GcUgHyz0ZxjVlUykDcUeRuXWGI5R8OJ++17s1F4lISW+fNU420Yv3iWkl21/uxB3fPZkg8k0AONsuHEJKWwgOE3dfQGCfrkRth0Z8xpm21Ohe7T6rngRj0M8NyFbmxR7yaRtZXV0WCLeN53aXVU1a/wnVOLoMNzmUNJu+Oqes7HQDurCDHVKYMP+nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLG4d493oSU/IXqZx5H2+fP+w27hxO2MQYEKsC6L02s=;
 b=Ppz5Jw5rurwQlHVND0OL/eYZpPwB/2geA5lnrleeF4O20l3TtdK9eaUdG8iJR5J+Lg4IN2jER+QvbPFinoDDLC0BKE0cl9WXLsebpsAxHAfXtL2wtGSnjtgCaU9b+hNAKn6oIrOSY0TyURbSsHrPqiEEuKlScJdbyxSwGbhkg5yxUxDhDYyJ6/W+PLTmJVjHr1Cqq/gePbBlmbfyQsVJ5q3bsr83AymHaW4PnSLzNnjRZR0NmFNifger0rzuZ10u1IAGvVP8S2Evj/uboKKdjHtsCykgNNBgWqW1c5hHfB2Prf/S5vZSxgcz8Uffcy5hmqIXxODM521Ld9b7aSaI/w==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by DB9PR03MB8869.eurprd03.prod.outlook.com
 (2603:10a6:10:3df::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 13:41:31 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::74c9:2488:1dd7:b976]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::74c9:2488:1dd7:b976%3]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 13:41:31 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
CC: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: qcom: sa8155p-adp: use correct gpio for SDHC2 CD
Thread-Topic: [PATCH] arm64: dts: qcom: sa8155p-adp: use correct gpio for
 SDHC2 CD
Thread-Index: AQHai0zLM9/mnLFG7UOC+X9g3MAg9g==
Date: Wed, 10 Apr 2024 13:41:30 +0000
Message-ID: <20240410134022.732767-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.44.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|DB9PR03MB8869:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 atpaXVRNnvAYXxSqjuZgih32puH2uvFrydhRoGuDnq+VcTZeH7BHuoQRIfLxc9k1lai+Fk08iYjr2XTk1c/iRxarasDKrXxRjFAKUeOKX0z20odx5xVll54b73pV39wlvYjKunD89Ap9VNTyZRTXwyvYqpB0eKmuEUgkhL7eDtFkoxLHI+r0vJ2kakRGacw7q0/6D+s4g7T9x16fVku+GOAgNG2VwWPzK5/+1L6IODIiA/Z+gCRHWKH0hzHMUTqQFgV1udn8VlqsKrdX70ynP04qeue/kemhQMtTvYiwazqgljauk5mRBZ6KQHdHSs2B+ZP+XUez/tvE4bf37ompu2ePiC0VGqCT02ah2WuVjv9stHOkozKAFUGV5KE/F7le8CYTVvYA3iGo8BEQ+9oPsPuImqGjMYJ41H3vxYTlWw7yDikzpWBw1F7KEW7moCeO0omzk6fr6d9kSS4PU4+8Bt6xSMapu2YdULWmJdC3CcvfX7+gRr+vWgG0M8Hr/qdvxyTw00/GXJyPoLwgjB+Zor4c/XsU4VNFb7o6Aj1vWetfF6rSfAxd3Cf58L/s7YozwahpwfHj6k7FqoV82p+2AAGDaEhJTPV7aGmD2wsW94FNnnuemFcWIjIHsn6hM2To0xYey2QbcdjQZ9p/hdELyOGSNG59iPX7xt2YBxsdffw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR03MB10456.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?2tuBdvVisjoL8vFNJ8k1l47PV1001kSvPsftIDX3FRlQ1vluklWA1u9Vv6?=
 =?iso-8859-1?Q?QUi3nCy6IoR23e2ESJ9jyu+pQeXs/L9wOS0P3tAR53jAqqtbTJts2iGdTG?=
 =?iso-8859-1?Q?XS6WE8w4s+/OBA/nbi3PGO9l50HpF08AwfJP47CxYYwrVM6ZZOA+1ld2On?=
 =?iso-8859-1?Q?FAeIHRINK6femd2EHwnUrawqOieenDPyI5592LTO15kOwbyfngFM+pj91+?=
 =?iso-8859-1?Q?KfTVsOnK95AWNBAUbb1P4UpJE4NxOL08wVMJaSjJfRSjaUYNEYpG0XKXm4?=
 =?iso-8859-1?Q?mPt/sTYag3nUgMLxCLrVMIkPLzAkloP2es2erOY+cLPO+qHMlHQ8qEPV82?=
 =?iso-8859-1?Q?p6Qlid6lC0x/bVvWV1E4rh+p00Xy6RAlB3zu+nv+4KGP/TEL4q5XtTA70L?=
 =?iso-8859-1?Q?0eYZKY6+W9c4QdhiXLc5bMS2IhXJUt4eg8GGiOVYDk0/3wtsF8zs0CncFR?=
 =?iso-8859-1?Q?XXhkknc6gZWS7wPnBm5r2hs7hDHb8LnagLqmWZc2IfC9nvt/2dycM9s67P?=
 =?iso-8859-1?Q?jGLelEMcLCrlyYXZLK3feGVNlULs4TP9lgzqQA4w3q7/vbKK93UH36x8x6?=
 =?iso-8859-1?Q?fqm6G0o5QKiCAJ76f2ZSR7MBjeHrIKnjdeOq5HyOebrWcAS0/ptPF1RKoS?=
 =?iso-8859-1?Q?yFFOhOu9kK2N5mBJj8SVV3WmjJV8bLOK2OzabKifUyvEsjeLPoP4PXmJqS?=
 =?iso-8859-1?Q?y8JvVyHGfKVs5zA2n0lbgCANDyabFZUHY+IKbtIXWmXG/Ab4dIVd9LiwH6?=
 =?iso-8859-1?Q?Bw8/fV/4AmOsYIur990SVJFDl0919LAGTQcPYaGJ+FZP0Y+awmEeHG70oh?=
 =?iso-8859-1?Q?i4b6p8nmS0kEU4rP7u/+PD0YuQNrvP79RX94dYydXhCroyffkDxFSZneT5?=
 =?iso-8859-1?Q?S/E19YWFL/3gZYPIlPseUfroaIkhW5kG2TNLWe+8ioy5LdQxS4PjQy2Vwm?=
 =?iso-8859-1?Q?7St0H5gk53XbhPpNLkAknwSkVyVcpdOv7SaeL544KxfgeEfJF/3n8P1VT1?=
 =?iso-8859-1?Q?wliIpJR+bkFMJnh14ccKMPtdVTBbDW4P76b7W0DsRoVnjDeqf0KDKUGwUW?=
 =?iso-8859-1?Q?3x+yAVv43MMBKnHEp6wQGMgWxDozDwX//FC4tWJZy1siSzAP60HDyovS/D?=
 =?iso-8859-1?Q?4fXZ307fNiQppAQvJnihI0H7omYIhVE6K+GOhfD7LefLK/rcl42pprLX9C?=
 =?iso-8859-1?Q?Zjb5S70ujYu/riVKMa0lKAg4B2hRnIDzfoRErKzElAi8XH9dCEm09791Dc?=
 =?iso-8859-1?Q?cwLQ2+bIp4o0C2Gte28M0luAxwZvTuam4+rht2pTJRqdRdP6Qxo8YT6dEC?=
 =?iso-8859-1?Q?2mc2SrEm1nsX+zYtmVRBHv3Y5aM8a4GsD+mesrfjqIl3S18zvuWMHQnFCR?=
 =?iso-8859-1?Q?nmXeUkAH/9C743nD3S2VoTOR3HztdAy7/ZL9CynVKhs51VS1juk1/Ljdl4?=
 =?iso-8859-1?Q?rjkq4pRYjISO0gcxaGMUv20tc2YkFJi+a6ooldgtVU5G3KBRmNg2RQwuR1?=
 =?iso-8859-1?Q?le2fgcGxbxoTXlltDodc2hCP5PSHjsaLNrQgXB1UZEHnZhLRuQw5Usckg2?=
 =?iso-8859-1?Q?RAkhJSt6cjJYsFr7MGp1yFWWzKka8VJglXmZy4vL1Yhpm9KF8Bxejxj81a?=
 =?iso-8859-1?Q?8lbn3X85a+miw3dgKpTlj3iNZB5725lQmefBeKDFKab5wbsePk4IPsNg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0354ec-e8b2-4b41-a04c-08dc5963ee14
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 13:41:31.0179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mxvS+1b0mRjmnrd5EPJhK7S2ni4aZFodKa8Csy8SSMoFPtDsXpYVC3gh3M3MPUdmTBRHuGDMQah1nzs1QkkOw5/9431vGk5h+xnP3rj3g/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB8869
X-Proofpoint-ORIG-GUID: 6UsFBgpTr7FtAciju2fOUOzBbWLvI-XD
X-Proofpoint-GUID: 6UsFBgpTr7FtAciju2fOUOzBbWLvI-XD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=699 suspectscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404100099

Card Detect pin for SHDC2 on SA8155P-ADP is connected to GPIO4 of
PMM8155AU_1, not to internal TLMM. This change fixes two issues at
once: not working ethernet (because GPIO4 is used for MAC TX) and SD
detection.

Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts=
/qcom/sa8155p-adp.dts
index 5e4287f8c8cd1..6b08ce246b78c 100644
--- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
@@ -384,7 +384,7 @@ &remoteproc_cdsp {
 &sdhc_2 {
 	status =3D "okay";
=20
-	cd-gpios =3D <&tlmm 4 GPIO_ACTIVE_LOW>;
+	cd-gpios =3D <&pmm8155au_1_gpios 4 GPIO_ACTIVE_LOW>;
 	pinctrl-names =3D "default", "sleep";
 	pinctrl-0 =3D <&sdc2_on>;
 	pinctrl-1 =3D <&sdc2_off>;
--=20
2.44.0

