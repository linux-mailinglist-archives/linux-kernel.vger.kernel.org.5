Return-Path: <linux-kernel+bounces-157013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F228B0B8C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 810B2B21609
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC91B15D5D9;
	Wed, 24 Apr 2024 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="G4vS641B"
Received: from mx08-0063e101.pphosted.com (mx08-0063e101.pphosted.com [185.183.31.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B84415B986;
	Wed, 24 Apr 2024 13:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.155
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966808; cv=fail; b=gqTe1dfqd0leHc+6wKljrowo1nZip10Vv5FJzKB7QSgnyHWpWc/XHH6gaUwOPLAGhXqF2z6M+E3ccZ0ZZEzcKuo8fCCu9vOweYahcbHXO9SclbfGupYanWA63Z17uzzS4n93rk+pxOAXmp3Vk3ZVTDA0JFSqyDYsC/R4yPxhIZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966808; c=relaxed/simple;
	bh=B/zADlbqzAH+NIvoh/ZRP3Ehfkp5fuyWqXJlXTmRJqw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FNT1Vi70zDxVvCbyIK9COBe6IoocfGzBdI3y8oH3Yx+LTGAcUjr60A2ZcmRFzRPOeZ5vUrRQNypxHQyOeD9Url0sKXMj0En3es28ZdijiE5jcdcrKFPWAcMU/OSspS+KZRX057fsS8K0it75woPDXEFdsxdjQCm4Cc885OUNVKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=G4vS641B; arc=fail smtp.client-ip=185.183.31.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247494.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43ODU27M015721;
	Wed, 24 Apr 2024 14:31:33 +0100
Received: from pnzpr01cu001.outbound.protection.outlook.com (mail-centralindiaazlp17011004.outbound.protection.outlook.com [40.93.132.4])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 3xnxsfrqy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 14:31:33 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCSNRJYA39r5uRwRKcpIC5xU+75mVMxoXXROpV4S2QV0qZ9wbWXLnBIU8ck7v2PURPYNr89leQCFXA5/Ww3mckGYWcyixf4hAFCNcpTCDw9i0/L6Nw12d1mEN4ok+M15SFXQeU1VMyQ5NfXtTU0g8tRAMOnTZ9/cx+MbwuHqcBMk2/LowB1L8Ja2NvqYSDewZ6hvnfxFl4M+lF4PW9bjJH7F7KlCbrbgOTGG4oEXh2nrT5otoy2yB0IxxZar+4WStgTkbMSaZD6G9PIl3PyR+izLoD9gbdOOqF+0WAxgNVmIkGODkienU8csqFpLzgwsPi8X/rZcf0F3A6OHwa8NOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lvL1TUn5Yvj9GLuw4qtYmS97NZ51w3SpKX6nyCrdOg=;
 b=CJgfkxFNN4jGa7ZTCbngG6GMpQPA0Ozv23IbIlL19lCR29AOdv754okfIFyxmXUAUst13RklhH7+5RPobUTtgMhGWJaXfYEi4D1WBidrHKlTrvBP8vObWUFwX/wc6ytRmPX+pfhBtNYMDRN7eGJS+wS79PeoDS2YoM1QUCWP2m294+EQNOvEaqiKGm/BSxoM5plZ8kfE7d6WfZfyVEL8Pw+fRsGDjEyIHnO2Ks+qwTHF1a6eOr8bUXHvkdvHuC/prVHL/wje4gB7xWJ0ahp9EAsV0JUETZ5HM4MNsI204WnMSfwVFbWjWcHs3fSL+NsKfcQ9stpYewa5Ta+exTp5KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lvL1TUn5Yvj9GLuw4qtYmS97NZ51w3SpKX6nyCrdOg=;
 b=G4vS641BPoUA9zSGMN1Oc833CxuEPj3KA+38i7zXy9v3OYI5I21qZyaqplYLw4vpEWjftX9nXKRjuUouFC9kafdwIY3RguX0RdYER/bZo3CPE4lqJ7eWcOpAWxp7/lLyHbUxg6z1YW9wtPmFon2aRlziF7JtviHHkDn3bf23MlQ=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by MA0PR01MB6106.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:7a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 13:31:29 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%3]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 13:31:29 +0000
From: Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>
To: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner
	<heiko.stuebner@cherry.de>,
        Sebastian Reichel <sre@kernel.org>,
        Chris Morgan
	<macromorgan@hotmail.com>,
        =?iso-8859-2?Q?Rafa=B3_Mi=B3ecki?=
	<rafal@milecki.pl>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Andre
 Przywara <andre.przywara@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v2 1/7] dt-bindings: Add Blaize vendor prefix
Thread-Topic: [PATCH v2 1/7] dt-bindings: Add Blaize vendor prefix
Thread-Index: AQHalku2J3Py82Z/+Uy6xvmYmAxwkA==
Date: Wed, 24 Apr 2024 13:31:28 +0000
Message-ID: <20240424133124.19101-1-nikolaos.pasaloukos@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB10184:EE_|MA0PR01MB6106:EE_
x-ms-office365-filtering-correlation-id: c857f620-fa3e-4552-2da6-08dc6462d906
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-8859-2?Q?QEscHlWykWngXtAnPOE3QZJJLY6CxVmSMrWZo1uqtk5iWSxrpQNPgX7nTp?=
 =?iso-8859-2?Q?DePQY9p9uMGFbE3f1OE9FoE/C7rdgP0i0JDUMrnuaPgklZc2lPPg1QNXu2?=
 =?iso-8859-2?Q?KGAfQBARN1wU3zbDw2ditUFRH4nSQkb8QXzfNHTyIRGycAVLX0bj4IWQmE?=
 =?iso-8859-2?Q?M7Mgb8tgcfj7T2OhsoZg9Gy6y2eUwN2edlwmNeuwc1tnS0Nn3ntl2t3nCp?=
 =?iso-8859-2?Q?6ZD1mxwagYbld7tPY7HORvXAdOp5pgDnAMeCX2rFq+s6qNTrm6X5dPiO0V?=
 =?iso-8859-2?Q?l7i93AAbutTb1MVe4VfCSW2UKbZOAZfg7KFAU+cTqfLvZ1xSNd24SqhIj/?=
 =?iso-8859-2?Q?qgES7ZZV0ieJ2su+ny1bJPCDV/e/si2f4cIQezhRteoUOxIHzPkL/+hBdC?=
 =?iso-8859-2?Q?DWh6oTROu4YrtTwpNxudgUfufPYgo+E2a8sNYMz7nf1lOzNF2lCem6i5tp?=
 =?iso-8859-2?Q?prQJiPuEI/zOhXeIGeucRO56zAjO386YtmQhuNz7dOSSic4DOoMO0/KBNe?=
 =?iso-8859-2?Q?6eucBoo90fUXjQcWqyQJvcZ4IVqJmIR30S6bXkRoAWQPpHsk+bVRrakXDo?=
 =?iso-8859-2?Q?ri/BGXhfnKWb2LJohmVe24BCPwtEiHhKx/XahKAF98WFOOelnzbpW3epRc?=
 =?iso-8859-2?Q?YhJoCyIqTUaMPM1IgXUbnFJuxvKxhfsmwPAOwcZrA6X327CDvSjWn8FfqK?=
 =?iso-8859-2?Q?GgboiuZVLdpcK4k+/nL0kylxaBG7zfJfCw4rMpsm8VplQ5RmJJXYInOURp?=
 =?iso-8859-2?Q?FHbOD3EY+YL56L32mEr79mjziQe9ykkyN8Z4BpwyJMhaAasWLwmKGRhUba?=
 =?iso-8859-2?Q?+fqjgjSBDjbgR9SZ6pmfgGU9HFaqsVZZ7MW+rHmuULWjWj+cijGQZhP5hr?=
 =?iso-8859-2?Q?C1bVHD5KkDliKnSqVcHMV+kcc3hua9nc+sKxZTDNyhIcq6r5hKWUYVzkLK?=
 =?iso-8859-2?Q?tu1jMRbIjiCJQghIgmAMG3TuHux62gsfST49n/QTXwrYKW/x0nWJYbe9pe?=
 =?iso-8859-2?Q?xJ4aUWZ0JiTNWPK8Bgx5qzf15hqO0ZDp8/hIzu0lYF4qdWw0TAvA63BoqD?=
 =?iso-8859-2?Q?vLISmpVOpTFfvGj/pDyRnyiPIfC0BWDNpNyKQsw0By3FFnShFcG6CiJMxK?=
 =?iso-8859-2?Q?d9NnhE1SrXhy5Q+TlkUX4cSIjs+GdQEw9AinD38P777RVkGs645t7YGYb+?=
 =?iso-8859-2?Q?BHaqnV64VhYEx2NqDMOKCkr5KaM/AOVxiZ3JKeoiay6WJLH/vB4yji87vY?=
 =?iso-8859-2?Q?vitYTEX9669C/FgX0aKGdgZ+GSU8kAb9qubma/Le5Udoi4IXmy+jDSQ0Fn?=
 =?iso-8859-2?Q?kSE3vnzUEP2knz7ZwH4aF26HEg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-2?Q?XUIGJs8y05FTv6BHSDc6IXCd1Btqur5kLiOBRiCh8skNduRCC1zmov8nwu?=
 =?iso-8859-2?Q?vkB79n53Mg6jtvQSV8Le9IGdvD20O1wpfecyPBrCfasjJXgivOdimcjyzY?=
 =?iso-8859-2?Q?tYiN5aKCsPvTTL+RTiy6/csqGL88C5vAAzUhleA4QJ3UIg2KjdaJ41DTSV?=
 =?iso-8859-2?Q?8tcyoOa+ArenRhPGy+mYY8zOV2Qh3bMgUjk5lknx+AsgrmPswMEgDLPqw4?=
 =?iso-8859-2?Q?D8AiEq9357AM4lIIUCYVzpAK7i0PnL+yddvLbG5a8OFBqxC6SffxO0HyTA?=
 =?iso-8859-2?Q?O5OWrfaDMoeVuvVgL//3pM/5aMLxxlrtmlHucTsWONTeApqs1X1/MwgTmK?=
 =?iso-8859-2?Q?E77+rYvuXR4/UByfbHLrtLW9F7QJlxRyMawiiVy5+nnQycK3XVCJ+BtECI?=
 =?iso-8859-2?Q?HGSNXGsjMJ128XYbPq0RONNG5aB2a0O3hsvpxDqqaNbLN4ofzIf+2s0f0S?=
 =?iso-8859-2?Q?37JsKlXdASy0qM5qSAQqltdn4shdK8bkldfV2VIhRiy6xcZIa+MWjR+zDF?=
 =?iso-8859-2?Q?5bVOz5Emz7qd1p8dHu2/xFesO3hXu7Hawxu8SHEzFch5/s95hKM0D20m2h?=
 =?iso-8859-2?Q?CmgxnkzL0hH7GlZpm8w55IZK0PCW+G4Xw3MmR9oOevT5W01u6EK2JsxaK6?=
 =?iso-8859-2?Q?I8A9N9krtoHg7AlktuRsYbk41RlGfh5x6Oj3UnjwWKbp/Eb97cLfYuSw1L?=
 =?iso-8859-2?Q?3gKY47OtpTX8Zdp++/Gy219cQ1eYMLesBz0QOshoG4YaCny+uBaJVULAx2?=
 =?iso-8859-2?Q?kf6Utkh+LFsaMrCMwZGw3/BUcM5x/Fa8hiCUR/SXaSJ768P+PZEH7lQWYK?=
 =?iso-8859-2?Q?YNEr1uc8gsE7ZnWxFDzzfGEKybTOGmkHc2H/dLPOse9ORfl7SVjlASW/Nu?=
 =?iso-8859-2?Q?MrNLqJKMUHAxQfPKySfbQLNh53vakD8ztqAk1MdcBLw89ujDRAWujDnYY1?=
 =?iso-8859-2?Q?d6UaxG4fN+f54Ehq/xh6FnoXpQizXcbpnd6PWPFyzGJ0qvJ/Ofblet4/lQ?=
 =?iso-8859-2?Q?XJ3eLxFMigoXxPq9OwNc21ThwCA4drshS5KCqx2tV9imWrFbNyDr+Kzw6d?=
 =?iso-8859-2?Q?EmOKZDKmDuOFj1/vWJOgeGK5ebvD9/lzjZwlQq8ihiayCFrYj2lbW9K1k0?=
 =?iso-8859-2?Q?6NIGRwoS5D9mGTicFSRSP0fX4Srzjl9qI7HnTuhrJ1swinu7hMMVgzim9z?=
 =?iso-8859-2?Q?ul3mII+Co0glmT32nLv3gWef9PULh+jy9u+LazkfrYUWI4YfhRqXc6ZwTe?=
 =?iso-8859-2?Q?7uazkINYgIqZS3cbNcmLkYyuLkZkl8ktmQPcDdTvtOWKB2X68fmTAQusvI?=
 =?iso-8859-2?Q?zsM4kr7+Mor9OdK91MrA26owRw6vcCU+hOb4bWcjo88y0pCgBW8mRpagqU?=
 =?iso-8859-2?Q?3N2Joe7pQQ2ZpxA4jY1jwjOQzqZvrsQN8i5F9BS6KH91sgT7RyQzKPHI8E?=
 =?iso-8859-2?Q?SmYJKlQdtkidsYfpHyHP/KDji1iKIGc1F1AuP08oUXL8VdMvC67Zu+LCUV?=
 =?iso-8859-2?Q?B3Oogowk8Piairpo8OKQlPPD6lFdBDf9kTn4mQDGyKdnjdnwXwNGLeb4Rs?=
 =?iso-8859-2?Q?eMtsExVOskYW10AoMybSz4nFM0k2rIx4/YTJkcoRpyB7Apq6Ius9fEw4An?=
 =?iso-8859-2?Q?ApqXnFhRgHUIrWvHpfaRKBtxc8lLgy1dDzULINjc4QmLlQGacI6Gp+2w?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c857f620-fa3e-4552-2da6-08dc6462d906
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 13:31:29.0042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zzUZKlc4Qg368H2Vw7xWyJXUkjdwonSXrlBrM68P3H8d+ktiPp2Jajc8VMlPt2CjQoT9wCYCOWbsO3GjPpRYcCCyTTa9J6Uz0KBF5RHGcBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6106
X-Proofpoint-GUID: 3l7PGBpxh3eTQ0MIPytref6xmeynxe6A
X-Proofpoint-ORIG-GUID: 3l7PGBpxh3eTQ0MIPytref6xmeynxe6A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_11,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 bulkscore=0 mlxlogscore=847 malwarescore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2404010002 definitions=main-2404240046

Blaize, Inc. (www.blaize.com) is a SoC manufacturer with integrated
programmable Graph-Streaming-Processors for AI and ML.

Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docum=
entation/devicetree/bindings/vendor-prefixes.yaml
index b97d298b3eb6..746ff14028d1 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -214,6 +214,8 @@ patternProperties:
     description: Shenzhen BigTree Tech Co., LTD
   "^bitmain,.*":
     description: Bitmain Technologies
+  "^blaize,.*":
+    description: Blaize, Inc.
   "^blutek,.*":
     description: BluTek Power
   "^boe,.*":
--=20
2.34.1


