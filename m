Return-Path: <linux-kernel+bounces-143237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AD68A3624
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A932856EB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EE514F9F8;
	Fri, 12 Apr 2024 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b="tz/83Gxj"
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8F314EC44;
	Fri, 12 Apr 2024 19:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.242
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712948618; cv=fail; b=l/XUPZCMI09nkD16aj0PkqWkQ+Upg6eJU/JK/+cd7GeoWBeQ3qmUDqg8sU70wBnHO7TQWsOtrnNfKz3+liI5Ckv1Vh36L4XQchp5wmCAExMkG62np0GHi0RotdZhY8wbysxn4w79P00YuQDqyP6Jippk6n7xkiXTLb3qzKH6W7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712948618; c=relaxed/simple;
	bh=JYTHCTzNufeMvQsOs/8F5YTxYU5KUKE2bnMbfBt4h+o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bhd+WpAULL65+DL9d68rvdu2KVXLI+a89lQJemsJvK6Z8tl/82xE2HQUQzYnPFfAdV88f0yVO4t09fwCKf1alLoG11nsr+tYYXF/j4myJ+R/pHdq42U2Kg6w8eVaZCv2NnJIbMQr5NjNZYPGdsXH6uztfG2Thbac2WbapgZu0KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epam.com; spf=pass smtp.mailfrom=epam.com; dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b=tz/83Gxj; arc=fail smtp.client-ip=148.163.133.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epam.com
Received: from pps.filterd (m0174678.ppops.net [127.0.0.1])
	by mx0a-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43CDu5Bl020474;
	Fri, 12 Apr 2024 19:03:30 GMT
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104])
	by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3xf1saj9wy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 19:03:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKH83Fv8hrgfiDzoB59j4CbB4anEZm4b2G3VWH7OSXviQG1lqMrkxfw/ZCoD2LoLqhj15rt8+5mW4Lv2vIzbUHsrdNW7pNXCev/YPJQKktcg6sDqJdemNxA/48A8ZTfeg3JUsVfqqSJo1732Ye+zrKLBVExnrhXD4S20FIlWnWnSTMWXL4Q4JjaE/176Jzpnvn5tU+2pQ5BTJrJtUDzXGvkfG9AoVqBIqK2bEOx/+2wrDge5i2IMTEF/16P/r/0zn0FIYpdTI4eRqiLTeMzfrPsHWUzQv7rJsxPPilRw1Ak9lCN60BQW/GrVgmHHmw6uASenItqUHnggip4BvJTOzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFkv1ZenAqJLci4soMiTzgMNyEIk8WBJE0rW85YTOKo=;
 b=S/VRaxBCB2YY2IXXr5VbbZgxn3ttrTrjzKmuJfDyhU7WJsk7wjy1dXI6kllvEGGP2ziPO3/PgfAW42wYjEG3qkLf89eZwT4twu2RXm3AMoOGCqG29l6intE/5tEzG+ip4T0svQsGZDITv+V1e8yQp0+7lRFTHJ2OwyvVwRnYmhrzxcXYs6uHy+dw0wXnaejoA3RIw6memq6ncf1Vm/pI1ZsiqavDeOIy+VAmmzJiMRi/NH3UhqQsl0BBY0crMnlOLwrpT4o4rT3KC8VAmE76iTJl7m3SYWp2ZIrDPDQjk9Lpy0R52f1qe3NPfzGEyL3UjqchmPmgRFb59jomv+TyCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFkv1ZenAqJLci4soMiTzgMNyEIk8WBJE0rW85YTOKo=;
 b=tz/83GxjMybxk8rcVUgU7K4PT9qG0EDlnCBMNNeqkkS/sxVYOZFEs9wIuqJ0af0UZnyddnXi+DsNcyaAhVz6KCz+zkliuonBTwmQk8n2onYQu5mxdi0XLleMBfNJ8JTOC/nZtrodxmxMj5zuGyEpUmGFdUj6Of6uZfERtpCfQdkKnjwH1rvwBLCCRbsz+kjP9Pi1wmHcpZOUtfIG6CV8W5JQufTbmZHBcENmmQ7GGiEmziVJZg4JmLOsB5fRuD7+IPk+frCdrTCn9DvyyuFo9qItoLJZ58BRO2Gr/3Xfse+YlG7IPz/SHXxOlKaldum8ioZ3CuBY/uh+nxvB4HQlSQ==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by PAXPR03MB7934.eurprd03.prod.outlook.com
 (2603:10a6:102:219::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Fri, 12 Apr
 2024 19:03:26 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::74c9:2488:1dd7:b976]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::74c9:2488:1dd7:b976%3]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 19:03:26 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
CC: Stephan Gerhold <stephan@gerhold.net>,
        Volodymyr Babchuk
	<Volodymyr_Babchuk@epam.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad
 Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] arm64: dts: qcom: sa8155p-adp: lower min volt for L13C
 regulator
Thread-Topic: [PATCH v3 2/2] arm64: dts: qcom: sa8155p-adp: lower min volt for
 L13C regulator
Thread-Index: AQHajQwZoNf3a+cEJ06mugQP75YLSA==
Date: Fri, 12 Apr 2024 19:03:26 +0000
Message-ID: <20240412190310.1647893-2-volodymyr_babchuk@epam.com>
References: <20240412190310.1647893-1-volodymyr_babchuk@epam.com>
In-Reply-To: <20240412190310.1647893-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.44.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|PAXPR03MB7934:EE_
x-ms-office365-filtering-correlation-id: a9400d8b-7f82-4ef9-3c3e-08dc5b233bad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 0Qv0J9rq5Aj82D9qLwudaj+uFjMzip1pgSVQ1STDBvjQMZ/zLEEvBQpJKb7XZSao3qrIuO6yd7Q2koEab0SeVCTrKsg1RtC9wrVqWAe2ygwdH2b6cqsM7y5EAFozeKIqkvmPS3kFq2MHhEfFDY5+pdeIo9QtjIRdWcGlr4Pv9DsqpxE2EmiISq6vIVxqDkNvs9lGoSyr9VyCsExrEq4gU8b7ck3nz7TiynnIAmvtDiE5qzkJ9lOl7Yl4fy3QYbvx1amio060PDIOs+uujCSFXOZS0ajeELszNWIr4H+Utwd5CGtxDVXdb5X7rcF9iglCXmiLXflraWuYnNYQgrEAkzj7JC9//WCsiSvyon5K9Iim7oGmKfuSF3ATqxA9br84vEGnB0kPXZPRACWftPR1XOdf/luJEtP1XTsMKtkQKNEsWJ64S9sOw64Ag9xV3aEo08oZjET/CBx1THJ6e3XYNcebr2uC38y2PhdRQbVd8/23uB6fyZllXI2kaddM71dsMIinwdX+sSCSpKTL5bQveJhHMjL5CSE3Q2dmh1uOdBas/U2soGQ3q7Lj1FikKVIiAZWhzlWzIgve7o9/NkzD/Sjc5B5cLHiirEqHu/Mew+XiSzjhWBYf71FnoBdFZkfBx0no+Rp1+1cFauqKhdDZBi8tPjDXwosQWw/Rg1RLTyn5gPUK2GMNg2Dg2yMM502mXX0EDAm5RNYmbvONINYYn9aQxKHaUsQRMbMlF4RQTRk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR03MB10456.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?0+XdLabSa2MOWOwmwwzpr+ww89BM+lzpgfdW8ImxHtCByZNIcTC1xXdpEF?=
 =?iso-8859-1?Q?7DEphVi8KpxpZaXMLrg42CgScyUj3jRGmJwwJs7opGEU0hVodfHyaLSCh0?=
 =?iso-8859-1?Q?KQnEoe7v+/T6zU8wJZvyfFW64z4Edis/ciUlf/JM8g3ImhRB2IkvHqJN+z?=
 =?iso-8859-1?Q?AOfH/3KjOLyZAPALb8qSV8UCeBgLracE++q+KM/H9PX415G6T/Jkc4U58s?=
 =?iso-8859-1?Q?zLtApXX3ByRFp941YDD4LWvt/0C1JRO2t0Yh9kfETbI5PH5SwH6vk4tttD?=
 =?iso-8859-1?Q?bbwUHR7dwDlz5XxEsVt7vYvmByRx2yYxmKJ9OyPvu/dZjC/OB+RRLb3a+7?=
 =?iso-8859-1?Q?tSrBiwGydPVDD0lcEGgd9ZngJi3DD7xcC8ICQbbWSmrFgyhdQr/iIs7SF9?=
 =?iso-8859-1?Q?fvgURUBpEW2ipkh3TjMBd1h56W/Lu3qinYiWKD6ud9WUuOAx4uFiHzU1Eq?=
 =?iso-8859-1?Q?h2gsPgL8GNbRSo3doOEHrDLoEtY89xe07v8Hz+ImfsOuYwyXbUXZTwwtp8?=
 =?iso-8859-1?Q?CsMMuLkySNqDOwU3en0N8uRVOfgrEgJhHAN0a4JcypCvAiP/rMsaKvVOaj?=
 =?iso-8859-1?Q?BuOtuHHW5R6EAUPRgtU+3cunReYrc8hXtyKKM2ra8ANVqW0iMGzGLZFrMr?=
 =?iso-8859-1?Q?MBg2iGmb75mV/3x9n7Lwhaj1+x9QbHKNA02N5V+dCKRYm1U9NUxdjy0oOW?=
 =?iso-8859-1?Q?I76jMTjuy4EMNfj0k7wiI3yzUWOKwr7tWA0pFAYwAk6lDMea455u23cu6Y?=
 =?iso-8859-1?Q?TjL4pF+/5aVLV35cEEdGLRPyuySTGqh0S4tsAVabmeNktbiYEEhEgcw3Ru?=
 =?iso-8859-1?Q?t56MgTFxPfZeIj3vFSAp5UtfHkcExPO4zWYdnWlCsk98dKTetZ4mEWmbxr?=
 =?iso-8859-1?Q?l6BtyyuVYQs9tNMjjPRMOizdyUWlhdCehD13oxVM7a+TFLbQXw05IDKCVN?=
 =?iso-8859-1?Q?CdSb7Lnceqgkhuci65lE/BLzfaM+BtbK5/ZBfDGIbB1Xp/I+dU3doDbXPs?=
 =?iso-8859-1?Q?RF+JdLocUjW1iXicc8sH7EE4tfbBZ5LQsLtJTK4VUMd+WQuj+yrCezQQdz?=
 =?iso-8859-1?Q?h9yYZy+ZFWLJh2V/MG6qyjbhT4x3KRKlc7jtdwXzNA1uSNH+He1ZcFFVb/?=
 =?iso-8859-1?Q?5UvNQkUQ3N33UAvTdPiiRcr37wtj8bgCpJxQmJzdhKx4RoRUP4sozLErSe?=
 =?iso-8859-1?Q?p/6wpuQ+PTxEqB92Wwjyzxm3YHNv1uY5R74i2h1JV39D+QcJtF0y4FuKaR?=
 =?iso-8859-1?Q?UJrbk5yO0YNb2ps8yiTziIAf8SLOHlHz0niL4lzMFJGdd15kGcn5XFsaPa?=
 =?iso-8859-1?Q?KN7cPoGnqN9sCanpgdXVZxChudhXoW3mf57/Dr8nd0Esj+8g7jvvRBvT8C?=
 =?iso-8859-1?Q?iH90xZklHMW/URcl+CogQm3HBlrzGKjFQ6B83/sHTxxELvP1g4YEAKXL1S?=
 =?iso-8859-1?Q?bN+VW8VsVkajoI0iORzP5cGWsBTGaJ5XBsikZ1TvZbTPp1Ni+SV4AoHJGz?=
 =?iso-8859-1?Q?xbH8xRoSd0haqzL35CFkjFiKCU8IZBkcGynwZlfDyHfCdaM1HJtiEIkG9X?=
 =?iso-8859-1?Q?8rkSK61/49Y4WoOjK64Mkwg8x0CTL8MfwXEgRytL/rxT/nZMvI+yqxF/WS?=
 =?iso-8859-1?Q?vV1QxQgV8PgXC2eHdOUL4B7e73DhgJ7A1dL9w6lpvtNQ2eUOSVwQFRAg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a9400d8b-7f82-4ef9-3c3e-08dc5b233bad
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 19:03:26.1014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fQoanK8jeZJ4CcxF/cR+CbtqTBNZjQXZZzB2GLO12PqLg26HEqp1etqHkaZbWSKVU3+ha86tZvxOc6epQz/z4hrf2hZEbcuQgvIwxR65bdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7934
X-Proofpoint-ORIG-GUID: dGoJA2tYSQ12aoLLR8FnD4TvVJHL5jXv
X-Proofpoint-GUID: dGoJA2tYSQ12aoLLR8FnD4TvVJHL5jXv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_15,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=615 adultscore=0 suspectscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404120138

Voltage regulator L13C is used by SD card IO interface. In order to
support UHS modes, IO interface voltage needs to be set to 1.8V. This
patch extends minimum voltage range of L13C regulator to allow this.

Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts=
/qcom/sa8155p-adp.dts
index b2cf2c988336c..9e9c7f81096bb 100644
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
--=20
2.44.0

