Return-Path: <linux-kernel+bounces-43944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47918841B59
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7341F24E55
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 05:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65384381AB;
	Tue, 30 Jan 2024 05:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EBPRNVJu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9812E37701;
	Tue, 30 Jan 2024 05:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706591890; cv=fail; b=jb4FaFswN3ln1zZQtDOZzA7Z7Bueai70uoIfJpNlcfuhh2oi9h50XqeF0YRBvwv22A9mlg7NiWI/pt+AilYGBA7aUCDhueYkBJdOIvPuc8/O1obuVJGMLP66KGpS00Fi9jgurWhq7waeJFPUarF0XwI5puOyCRrADyqdIGLVj3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706591890; c=relaxed/simple;
	bh=YjPnjaXPZ688GymKYEPBgzWIdqfOyfltZvju/ndIMdo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RizmXFpd39tR9kkHAc2ryMVEWAGMSLTy25mnRhJmsAbVRUqD39hV90QQ7ZQ6y14swQQ1V+vK5pZ8+H2ObTq3dstQTHbwcU7WSlEhmPro7Wtad3QU+AZwkh5h5FaGpJck8ZYx1hdl1I47aWzh6LddzkZsZnKhEnF8tA3DXDgFXxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qti.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EBPRNVJu; arc=fail smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qti.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U1Edp9024136;
	Tue, 30 Jan 2024 05:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	qcppdkim1; bh=NHhZ/pDVjItbkhtNxif3MiwDOyzZ9CAFdpH7Xkygvak=; b=EB
	PRNVJuqa8yy9aNp6lyvdeJousEf4obtPeVx/o6wZh4N67kCtwJLObxkbrNmaiNWK
	AHpWaH2VpYcLlXIu3zEvdPuNhOerPIrPaNLncnVXPLUdrUqxg7VLobl5rrdlBTMU
	+GQKdYnwNljr9Nq9cKCir0NqO1lfkTXQLRxn0juUSP+uiC79gXVmLDKfyjGN5VF9
	RAcn7+E4vf514EoYlEF4g0fZtOUO3z39jJt582myvB/azWD0WKCxie7wN+VEGZCP
	bLtqILcPH4AgC+gWlYlIQzmc6p90RxD5mB4biml2QBb8u84aaNJiUgvZHElW8OZt
	4iqrkxXrUaS1e6hdDncw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxexr9eyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 05:17:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2u2vywpUvuqePXp2/BUbzBpbFD0ijmEhqSgUhoUruTYV0RWnwcHYTv9cNLtSeVYsJhso3FNvo2Yu78v52w/QAXGVpuL3yAtMtR8DAHG3c6VocL3tTMs65HJ9iDntq0KPiqSrbfOj8Mhy3qU2XC3EWa7PG5HTc55ANL3Opz8pyzxHTW6gpMNS7OoicvBvGdnwM/GqrKPvuT4ge0efPsipp2mxshc72E/wE7sryw5wXsaIDQTd2t7Z0iI7rb2FwD7gg/sMPt5YG6+32crfwcjGCQWDYSX8Ndmv9z6csNqMnkjt9S6blvU8RK5Ne/Ed6MnRKRBkZUiqbo2y8qAv5shkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHhZ/pDVjItbkhtNxif3MiwDOyzZ9CAFdpH7Xkygvak=;
 b=Jqk43Wni3wMYOQyF7PIFvUKnPXj8HfJ73fRzpQj71DpAeDv9fjK2+17rrrGUwaPRDOv4EkY+Ym7PJ5d6Nb65zMd1A8vZXU0DDYT2K6RYCLgDvZrmthVbrCOKW6q4U5XF2NegQE1wJqQZkinmRreCCeKI6Id41xhqJHl7F79m86inuPNPnaAGKA5nCs3Xq1pCJBqfkxJvljq5kgHD/Z1EY6n3aYdsjynoThlI4+pL2QJ9ux34CqX3lqHfNdOm3CJwjeBx1ggeOHUUxjaJkVmTkI2C+Aggk/xI41agNkJYzgEQxewshjJX+aCuOURPxJMWNyQ6n18B5CfAEB8cSfpQFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SJ0PR02MB7758.namprd02.prod.outlook.com (2603:10b6:a03:320::24)
 by CH2PR02MB6759.namprd02.prod.outlook.com (2603:10b6:610:7c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 05:17:56 +0000
Received: from SJ0PR02MB7758.namprd02.prod.outlook.com
 ([fe80::75a9:e461:7c33:5315]) by SJ0PR02MB7758.namprd02.prod.outlook.com
 ([fe80::75a9:e461:7c33:5315%6]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 05:17:55 +0000
From: Viken Dadhaniya <vdadhani@qti.qualcomm.com>
To: "Viken Dadhaniya (QUIC)" <quic_vdadhani@quicinc.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org"
	<konrad.dybcio@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-arm-sm@vger.kernel.org"
	<linux-arm-sm@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "Mukesh Savaliya (QUIC)" <quic_msavaliy@quicinc.com>,
        "Visweswara Tanuku
 (QUIC)" <quic_vtanuku@quicinc.com>,
        "Chandana Kishori Chiluveru (QUIC)"
	<quic_cchiluve@quicinc.com>,
        "krzysztof.kozlowski@linaro.org"
	<krzysztof.kozlowski@linaro.org>,
        "Viken Dadhaniya (QUIC)"
	<quic_vdadhani@quicinc.com>
Subject: RE: [V2 RESEND] arm64: dts: qcom: sc7280: add slimbus DT node
Thread-Topic: [V2 RESEND] arm64: dts: qcom: sc7280: add slimbus DT node
Thread-Index: AQHaLQqYfTJ0YmByPUqTFabIz9LsyLDyHGwA
Date: Tue, 30 Jan 2024 05:17:55 +0000
Message-ID: 
 <SJ0PR02MB77584EC82BA714E5F1011E6CEB7D2@SJ0PR02MB7758.namprd02.prod.outlook.com>
References: <20231212145026.20828-1-quic_vdadhani@quicinc.com>
In-Reply-To: <20231212145026.20828-1-quic_vdadhani@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR02MB7758:EE_|CH2PR02MB6759:EE_
x-ms-office365-filtering-correlation-id: 51534f56-a931-40c5-aea1-08dc2152d110
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 YRxPMXi123n/ek9JNZH888wnxKW9iggIErBniu3SJteUVM6ftr4hhPfmxsGbIxhNLCpotGVfwI/l/9Z77LOGhbofwmQOHYWAXEM/VQjeK8YyJTN2OaIhznpK4TLXo87ohh1HvyLQxFfDz6+1xVd53E4JJvS1r7HBv4LPP/m6INeZY1kcvvR7EXNrYSCsPPhpqspjeMyfAVPO+SKCr1ez8D4uPZWdoPTaQdX/b1IOMvjK72+WaD+noPeR3zw7efE3JcgSa4ciLPECsWqaPz4ElrLa+krab4IPUqub0oVfR6OVuG+RP0zAYFso8BV6eLo3GYPXlEGMbvJw5Aqsnf408p28z1shUcj9rZXS2fi8PzQJTD0tUnh7yARPrU35KwAJmaL4dNnOoeN53MoDUt4+JWKU4CxF0P7kxBIBlH7MBH5jJWp5x1MqCZZNCP2H3GtK3tBhrfZLKDmH6vbwJ0TVUVRxhe2fc2ONeNNHOMyLw3xrOJf9s3C66f5/Ozo2SEZ69/yyx+HCCCnmZBwWwYFGBPBI3R6y9sOrJBQN/o/pPa86/4A+Kbhrh/bolNqLKKh8V4nE59i3i1MWQQKC7G3hi8ahKIw5ndVCvaynp4MfsS26jMv+/lxiDmNmTf2JY/XD
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB7758.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(366004)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(316002)(54906003)(122000001)(8936002)(33656002)(41300700001)(86362001)(83380400001)(38100700002)(478600001)(4326008)(66446008)(52536014)(76116006)(26005)(110136005)(66556008)(64756008)(66476007)(9686003)(2906002)(71200400001)(66946007)(53546011)(6506007)(7696005)(5660300002)(8676002)(107886003)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?RUo1cKfh9AFHecvOO4psFKXutqAdwVzJ3mqQGGHu88zmFq7uajtkIsHRoH6I?=
 =?us-ascii?Q?rd+2oO0Z7X7slou7T8GtjDihkBuyqSMw1bw3X/SVX/TPJ1mo5xLv5+aq8OO9?=
 =?us-ascii?Q?xrQPeAdT8TPoknyVQAH/9EMidsuU4kKPYfsatdhvOYN89oNjtKmg+gB4zN/m?=
 =?us-ascii?Q?i9ccSlWELUaZ0BQjITs5mrvowPL+DUmkEdEpOfxy3SItBS+1v4t/2vkmJ7Fl?=
 =?us-ascii?Q?q+yMm/twm/FBsQAefLNJfPDn4+t9lrTwbKwncIP1uV7CS6yL5Qc5ce7LzqBz?=
 =?us-ascii?Q?PvIQD2Pa/8auquxkrOEzc/Dkyl6S3/tc2ua2qfxlZUyMJR9i501IOa0d1c8l?=
 =?us-ascii?Q?fvIgAAuJC6bQdZCtqBwRtXIY6Q86I2ADiGIXvkuT9ok7snMZJ8hsvRvE5+Oc?=
 =?us-ascii?Q?+VlkzedUxRpVJ9VMfQk7zQMGbngN5mpWMne4HvBTEJNuDt/7HysiQgEaiGa3?=
 =?us-ascii?Q?J33wqlQGtkSWcyJGCL13vXp54wa3LyiALLxCPeNRb6vCmUes1oNP29wFWckA?=
 =?us-ascii?Q?NP/RpS9t33wD+rjzkRCHnqrznpMpXJOIxG+ePnLqHCRAy1kS9O3P5KAC6S6/?=
 =?us-ascii?Q?SGpmN8ldtiyCX2cWbnvUWPoIXnFP/axIVBmzwxuNie7o4crYeAX2gcKZ/rhl?=
 =?us-ascii?Q?dWq6xa41vQ+AW+UGkc3R5obXMHDAdrKs+/8sia48BlAKS6G6puT/DaOTROyg?=
 =?us-ascii?Q?GQP6KISJ749otXgzJj96f06rdJNZNkiDKzObk6LzTyltylV3IibfiXn5Y/t8?=
 =?us-ascii?Q?YsRvNQJpQ1W1vjirmOyiXfZKcIBwNd2i/NKjhCx0NsaIgeIzzRd606vuLLxM?=
 =?us-ascii?Q?PtP80iUcvBnj8TzbAQeXR1YbFqH6vWYZDDrUOp43izgQjZPJA9UIVL4boCWA?=
 =?us-ascii?Q?uHFeBS/LPwwMIaEhFnbyfI6un0RsHrYyxRv2IYeilBUbCIyDj474CXZfZVmr?=
 =?us-ascii?Q?U2mfGzJKbdmdDGfyU7C/zVZnJ5gxmkn3w06sPneYHO5zUS8GOetjk+qlQmvm?=
 =?us-ascii?Q?2nWwrNjQd+575Y/+uCpxxyna9Rtgh57nfcoGaV7QO1ELubMj4T0fBcEv73Md?=
 =?us-ascii?Q?SrsCA5gjTCS5o5CneDb+zE1zDWxuUA/WmFmACEZEampkdo/+YLVqcDW9q+rB?=
 =?us-ascii?Q?U69ZxJ2/msGyHqlafpDABZA/c2fDQwAPIBJW3cbtxrB27usJtTSR42cYgQ3a?=
 =?us-ascii?Q?VUdvLEmZgfNAg6SQkGmidf92nFiRM05qRCrJQP7fXqh8ZBe/U655BiQVg4rv?=
 =?us-ascii?Q?y89TYNMFlzkg8K3JPL/Wk+scUlOUdbQZ6cMdCaOIsyyfDmTd19znQqrXLAQy?=
 =?us-ascii?Q?WVJV4+yjD1I4gw7qEtmWpoKeyzuLqVNPfneDOIV1irxdAiVP+BRvsVB0R7DS?=
 =?us-ascii?Q?zwqmy2RSMT+uRyZODmkk3dTAVE9R8Vz9wKfAj9r9egavsZGNwjrQWkpWRN7D?=
 =?us-ascii?Q?Cu6j/HRzZ/VsZW47RIvmc0OhW+FBWn84M6Yff+qkuK2XNssgCcym40g6Lonr?=
 =?us-ascii?Q?YeKe8oMjKxNlvnX0DjdsPYqt7+/4NAy5+WBcNHUJ16+AfbLZ1qv2IhfAxQqE?=
 =?us-ascii?Q?s4Xy0r2r4NEJvmi8HNr4t14fw2v09qxi6wIzQspf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	FTdtrQjKtYgZXmaGwSFmGhWjOfLRZKeE74h1T6NLKJ1mInZvEPsvdBa40sljtfVnHRaTo23+r2aGEwTxE/Zc31lovbz0kdNIPxkxjXDOUXhnGxoQ30vcnMagxKDamwRd3tX9dT+p89aARl0rHyS2SK1zFraNhVcjAEXIW4aXwqLM3egiOUeJNnJX6v5ZrpJihYr5SDaf3pph61hFKWHrpTLHbbWOdugGhp+QAMBuvhxrOqarK/xtibE7ucFlz3V+cdEmHSQm59RJrQpVJjApIdHWQh+R3a0Chcv7WSapwY3S3MbW4od9u4JWj6yIejOgdP1ZSR4SDaADnmPvt7KbNlx6U8BxteJHNJoZFYTAq0Fqa9fjYbS8mDFeRbcM6WduOmlqr2bNjO+sg732w4jfp/xq0RRrDVBkfq2N7DH37JGkEFFjasTEm0PFNtv/UudBbfxyuAKvxJrbOA/xyIFJDkuJYtKwxEM6S8H0AKKJHzPXgKXSwzXf5tUFn8+CEnhma4QYTMWR+0qjsBTTvg4yuLWPVEeShoE3yGa+f3V6nfVRtqEeu3sEzDOtwD+P+PMh4s7SPxkNBJDEIVkTcH7vnSGxfc9jbjpI6AdOzuTW0lpyykiun4F1p+IALccORNOs
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB7758.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51534f56-a931-40c5-aea1-08dc2152d110
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 05:17:55.8056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lc5ivB4id6HY9Jflao5f6agl9SIkiMlDNCDf1we0psDhLOF2iNC6RLNtKQwsA2mJmNYDO1nGbbZY7vEun2fbZ6Ic44MH/NNh4hS4a/LTV28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6759
X-Proofpoint-GUID: MJZ4ihVdLkYzmRndtbl-5M9HmFRqrb5d
X-Proofpoint-ORIG-GUID: MJZ4ihVdLkYzmRndtbl-5M9HmFRqrb5d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_02,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 clxscore=1011 mlxlogscore=774 bulkscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300035

Gentle reminder for review.

Thanks
Viken

> -----Original Message-----
> From: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> Sent: Tuesday, December 12, 2023 8:20 PM
> To: andersson@kernel.org; konrad.dybcio@linaro.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org; linux-arm-
> sm@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.=
org
> Cc: Vijaya Krishna Nivarthi (Temp) (QUIC) <quic_vnivarth@quicinc.com>; Mu=
kesh
> Savaliya (QUIC) <quic_msavaliy@quicinc.com>; Visweswara Tanuku (QUIC)
> <quic_vtanuku@quicinc.com>; Chandana Kishori Chiluveru (QUIC)
> <quic_cchiluve@quicinc.com>; krzysztof.kozlowski@linaro.org; Viken Dadhan=
iya
> (QUIC) <quic_vdadhani@quicinc.com>
> Subject: [V2 RESEND] arm64: dts: qcom: sc7280: add slimbus DT node
>=20
> Populate the DTSI node for slimbus instance to be used by BT FM client.
>=20
> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> ---
> v1 -> v2:
> - change 0x0 -> 0 to reg property.
> - reorder the DT property.
> - change node tag slim_msm to slim.
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 04bf85b0399a..9fec8743e19a 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2528,6 +2528,31 @@
>  			status =3D "disabled";
>  		};
>=20
> +		slimbam: dma-controller@3a84000 {
> +			compatible =3D "qcom,bam-v1.7.0";
> +			reg =3D <0 0x03a84000 0 0x20000>;
> +			interrupts =3D <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells =3D <1>;
> +			qcom,controlled-remotely;
> +			num-channels  =3D <31>;
> +			qcom,ee =3D <1>;
> +			qcom,num-ees =3D <2>;
> +			iommus =3D <&apps_smmu 0x1826 0x0>;
> +			status =3D "disabled";
> +		};
> +
> +		slim: slim-ngd@3ac0000 {
> +			compatible =3D "qcom,slim-ngd-v1.5.0";
> +			reg =3D <0 0x03ac0000 0 0x2c000>;
> +			interrupts =3D <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
> +			dmas =3D <&slimbam 3>, <&slimbam 4>;
> +			dma-names =3D "rx", "tx";
> +			iommus =3D <&apps_smmu 0x1826 0x0>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			status =3D "disabled";
> +		};
> +
>  		lpass_hm: clock-controller@3c00000 {
>  			compatible =3D "qcom,sc7280-lpasshm";
>  			reg =3D <0 0x03c00000 0 0x28>;
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation


