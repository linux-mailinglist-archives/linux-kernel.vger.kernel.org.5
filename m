Return-Path: <linux-kernel+bounces-156973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F10F8B0B0B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CDCA286348
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FB615ECC5;
	Wed, 24 Apr 2024 13:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="mlPuefDp"
Received: from mx07-0063e101.pphosted.com (mx07-0063e101.pphosted.com [205.220.184.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E155515D5A9;
	Wed, 24 Apr 2024 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965579; cv=fail; b=DDbo2oPW2IsierMvf7baLeU46l5qCCHU1QAOP6sHBa/cKbAnYzi95jwG4ruKHv1ZF/ul3PGXAMFgZKjv+qfgkZu3P5uC/egbZefRQqud6KSiWGmmQwI2qkGsXEYIykVrTNXcPPO5InN/EtWHHZP5NJnJHjwLY3nWk6yAJBBc1lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965579; c=relaxed/simple;
	bh=JUJUGgAuzri622iDqhnCvtH2Dk0vw0LL7ZQu7WXGgts=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DHrBgfMM4erHRx2nH63k51X59P7USOfrTxqp0/Jy+cmn+Ab2KmVk4wDZq6paDpQ4xzkl0fLruf/KQPFWHoZswAZmQV7M5GGAnL8uhHkdQGreN3DzuMRO5oqcKzJWWW7XP2ZUXXDF4iKX7Lo9HwiUfgtpFbzNdqGNIBxJJrGsBY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=mlPuefDp; arc=fail smtp.client-ip=205.220.184.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247495.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43ODVbsn027710;
	Wed, 24 Apr 2024 14:32:39 +0100
Received: from pnzpr01cu001.outbound.protection.outlook.com (mail-centralindiaazlp17011004.outbound.protection.outlook.com [40.93.132.4])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 3xny4n8uyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 14:32:38 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zl7bpw7L1jr77W9QCyZFWoliZlUwDit8DSDdGXIHP7M/4dUD3AOFiGeR8kw4Zp+JC6s26+lXKBwwYaUS/FKSoXhGx8m/JVkSLi0/A+kaPfAcexcvJWrOevVkCENGOolC2gceX58GzY76v88QH5/WIwSvMgCym2iISab0hGhslw+ZgBiPDyr+fhqDsgJsmfxLiG5L6Qwnb6AiZeeaAjWB8k+OPxupzhtvkZkm7BLnm16vTHpMrbmbbUuAc5cRML6j5+bF2nqbiUwa/4UPSFaNVCJtig/fimLmSevszYtwxY0hjP8TRc7QiNvh/maH495TT9nbrsgs1wDLISf/bT3Kvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUJUGgAuzri622iDqhnCvtH2Dk0vw0LL7ZQu7WXGgts=;
 b=gObEAbElpkBsBCA3uIpEFPJ9bByyqovMCBErjY3mnyWCdRZMNLqcqdXQ1GhPakC+rw7B+scNxOG7kx4KzF5FSbK+eFPcC5TqCJZihjJUjMhZ4/k9tzUmXVpZm+qwVIBdYmX04dPbiQxmrJmaErMj66E+ph4dD5/25gGe9qzjaERLOKc0/QCIy3BpNlWSn1tJ6TwIh1Dxnl5xSpzGiOjLrKXXD2mAgd+OJAzxPriJLAEu/I6BEYSiLr2uzA6EaN/piUMKIEJa9dsWamQowWFr3yKg7G6r7m8eU4BDiVD0LonKk47mEpb/AJ/x/bj8LxquIzgQzeBc0RVwILI8ylQU3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUJUGgAuzri622iDqhnCvtH2Dk0vw0LL7ZQu7WXGgts=;
 b=mlPuefDp78b6dOeeBwRkCP85FVWst8t1nWj7mmy0B51+c5mZT5sUa0sP0+eSUVOL6X+6/LyfpFeaz/vF+8aC96HDAsxE0SLjA2usR8y5BW80A2dTRvZqTrqf8HK5Z6n4bW3Q6Ru6eY5QTX6cj5IuhwIWfTdYXCLDzuGXOHpP3oM=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by MA0PR01MB6106.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:7a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 13:32:33 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%3]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 13:32:33 +0000
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
        Philipp Zabel <p.zabel@pengutronix.de>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v2 3/7] dt-bindings: reset: Add binding constants for BLZP1600
Thread-Topic: [PATCH v2 3/7] dt-bindings: reset: Add binding constants for
 BLZP1600
Thread-Index: AQHalkvc6upXIDvPFki5v34BmmIU8Q==
Date: Wed, 24 Apr 2024 13:32:33 +0000
Message-ID: <20240424133230.19179-1-nikolaos.pasaloukos@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB10184:EE_|MA0PR01MB6106:EE_
x-ms-office365-filtering-correlation-id: 9b5868c6-9a7c-4336-caef-08dc6462ff43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?xgyGWHNy5jaNYitRMriTFQ0gVNcBTpGOBbVpqmFnwgIhRCD9HWGtQIdtiL?=
 =?iso-8859-1?Q?rwU7ifh6O7tgspL33FVTlQoULw/nyOOJa15giI9j2FeWs7sZyjKOF6zL/n?=
 =?iso-8859-1?Q?uPIDC1HdnHNrUdDdZOjh6DPxwMAxGo4SSIZ1Pb68JVO466XUPfNV0Yao/n?=
 =?iso-8859-1?Q?fKkD1wIDPcnA29dBxKnG6TYCP72jIG3iUP43fEZkQwWUUm55hOJcAiQmQy?=
 =?iso-8859-1?Q?MjA3eD6wMuAfaGoyiGvGq4UAmkp9TqpcjH8V5pKOo6jD5qJwp4MYLz/CMH?=
 =?iso-8859-1?Q?K0Uz+WmnvvHAXxZfEQzN9f+uzsBITcsabVzqPV5rEZWDw2cg13ciDeCkk3?=
 =?iso-8859-1?Q?U1gJDhNdb2rB5+hUxwnyPk+Urjlo1e7nTbRahZsbSrV5+yyDmW/R5SzLbb?=
 =?iso-8859-1?Q?IMZWQBO2KKQWcEB7QXSDm2/BpsR2wjmm30S4XyNSqqEImZiU/PuRIxe4qD?=
 =?iso-8859-1?Q?rEp98NhXt0HUM7rDAGzwo5803O3eKVEnF6IaOh+zPAylMZYS9kTUJZXBL5?=
 =?iso-8859-1?Q?3Xux/Grr3E6qNa1UGg3UgJT4MlO5wTsH2LJdQPEbvR5YTsHNLxXh86BON3?=
 =?iso-8859-1?Q?T/Nb4VXL4Up+VqXzlTKPGszlLjGOd7LJLGHbl7SNqkR5uUyAl+T/od9B0M?=
 =?iso-8859-1?Q?kqIWb++KCNXcaqnjZ1p8W7hynlquwRz8K5INIoEooneUVFM276XgU37qhI?=
 =?iso-8859-1?Q?CbcSJtf2XkSqzADX/W9Om0/TVMzfJAolKm7FPFHpWuxpA+NOrbAF7WiYJe?=
 =?iso-8859-1?Q?0JCmeOaKMGzW214U+4tkA0daR+N0Xf9k+pRN3+SD9q0i/NAN5dtOOVAfXP?=
 =?iso-8859-1?Q?T1mt1E7asfvhMwBX70+jGPyBahXcG5Hv+OeIDF7PUXO5mT72LI1hcSezCm?=
 =?iso-8859-1?Q?PT6yE3XtlKDVfB48GDuQ6U4GuzQDn8mwj8HynKbVzVzVW0HnHpsC/nM0uk?=
 =?iso-8859-1?Q?x6kbcEYVnwXMlE8ulyXdFxccJdDKEPeUh6+1LFa+jBqgRIajh/mIVqgAa3?=
 =?iso-8859-1?Q?q3zCbdfKZP4zVTlKOp9LL7oAOPOzXt65PA/7f3mrSblN8EfDFGdHkQbEW9?=
 =?iso-8859-1?Q?4TFdHDl+ACKs/jaWh9lmRbxuvRFbZn11gtwA5ceuE2FHXxrqU+YGV1sMx6?=
 =?iso-8859-1?Q?9Ik0SKIk46gmrG/X2Jlkgz5sy+ww6cDMU8K32GJWwY4g2KGd5gGuDp/Du+?=
 =?iso-8859-1?Q?8vvdVcs6IbHmaUn3q43+MrX5bUDgad8efV6PYIv6Ze4CVjQtKYdTNV1Uoh?=
 =?iso-8859-1?Q?OZIIqT4xOBjbe+DKsmTnb2AMOK5uQwbwiWWPPbVWAT8/ZWamutrl3t1dMT?=
 =?iso-8859-1?Q?VF6WX+j/Wpio8XGzWatShQL9HdtXaTyGq+43Kpn3DNDQmbpGrPS5sUQmG9?=
 =?iso-8859-1?Q?M8iMNxHFZ0skjdURO9kNkMVwmo6TbEdA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?fU724KmU+y3aI1MVYTrt2PoDEFjSpiFaJnVNnaWKhvPa/iC5M48e57xBsR?=
 =?iso-8859-1?Q?R8OVD5ZnuGeC7Vd3Dj8EwKuxNLgVrTW2QbxyMMMC1SIt5fXVWXxq0sv9XZ?=
 =?iso-8859-1?Q?PaWl9CY2mbirWXtUtHcNjDUNPI1WGupsGrtnICNoYzWVO8rDnNdowMBzRb?=
 =?iso-8859-1?Q?oghxUyns3MP34d3Yq6xA7nVzT/zFuAtvsjObUNhzlDbO2qRmkfdR1B9lSK?=
 =?iso-8859-1?Q?I4/YwdSTUlkadpsrpWfbMQ6D51nO96ywfsdEhxEiYbb+F0q6K+WwklAXZQ?=
 =?iso-8859-1?Q?BJClZb26GWsXD71g/0MyhK1zJHvPbLsrkw5VvFlHhE8kFCP9SVbGOXSEkj?=
 =?iso-8859-1?Q?XwdB15GcJRER2sHJ07lZvbyEvpPLX84XawfzXOk7YShMaMC0sGz8mJ1Xxn?=
 =?iso-8859-1?Q?SCHuk6hpWXXtMx4YoWVrI0zEcsHcMN9rTXe90Y7FTJd78dfaMohzAsBjF+?=
 =?iso-8859-1?Q?9PiznDgyBjzZ6KcvbRL6FZ2jRXXwjS05PsPSN1Tk4AiFg7sfthx+ewddDm?=
 =?iso-8859-1?Q?wnEyaVnu3GpCEgzQdul6cXyMQ3jkNC/W3t6O/lZMgjB4u9qlSekpo9FeIq?=
 =?iso-8859-1?Q?XRArGOQ6L94nhkm9dFLD1cIaLRJ8BN5ExRZeJvNpwhjLunM51CK2B3kJr0?=
 =?iso-8859-1?Q?DijxuuNG8ef9uE+XKsixqxpyaKCJJuue8P2phFCR3DFgFbX4vu24Ahnmi7?=
 =?iso-8859-1?Q?lNrBLaPDW+yifpiMYpqmRZORP+n5un5DsdsDq2b2RFK5NM57IB2cUcAUad?=
 =?iso-8859-1?Q?aQpfQhp8xkM06Asdd3rtmN92pU8alro91jDCtCYyjASmdwLDbOoKAGdOtI?=
 =?iso-8859-1?Q?dgScdvCBA21g7iODATMW8BYYlZdUTBNGkJFjd+G5qlOYa712xbxkQ7Rq99?=
 =?iso-8859-1?Q?dms5e63bA8Rj8qTw4cITtS1tlAfLyw3qaw/Z8eVEGrM2WS+J9F9YgTGnbD?=
 =?iso-8859-1?Q?n4d8hCo+LAEgNVmegFVkQrPrhuwoI5Mz8HEeAcDXF/Zq/h5Dsggt5Rrzc3?=
 =?iso-8859-1?Q?Y9nuJRnyycFfmyD/EHDinwRHKUgl5YPMBkX2W+RCo90QaMkc9hgVCjhnV6?=
 =?iso-8859-1?Q?CjpWWFoM3QS/ZnUd2tAaCeQkdgJxqmubesm8DMcVhkLpyOqAKpasYQCcPw?=
 =?iso-8859-1?Q?uVFK9DjsXaxHx4OyaH8LQGF9W5tA4VRP75nSCu3PwCU60y+bLlLNV2QU0S?=
 =?iso-8859-1?Q?Me4lqKaB0HL8zbNINrBCvVtiP+sSy3NCxLF43UFlgKouPF/DCHfYcxhTup?=
 =?iso-8859-1?Q?KpqqXucVU/lxuZNrn5Ps7I4P3VKj89xZ4jQktr/g252wKzYsjECvw1zJS6?=
 =?iso-8859-1?Q?Z92OEojSk4SGR6AizFtTcDPZ239e0lXTSnKsZE+b1u+y1mdC+lHvryqmC1?=
 =?iso-8859-1?Q?nFNF5q7oEsl9qyP/AYTMpuksnpGc8dk9jMfCHMMBCdkdTCGw92vCGqoEii?=
 =?iso-8859-1?Q?U6RX7mNKS26zvVkAAgbOTlyWWy6xJe5GOcDoJux/eLx0r0I+GhC3E2Gfy3?=
 =?iso-8859-1?Q?cxA4YBXobPCCq/jrPUGjKFJ2NzD6LjzOBtiTrcPqUF3oIX+m6yIAavHVVR?=
 =?iso-8859-1?Q?nyu3/N7XNh5mfCMITUXtkhZ2pzwT/g+Y6voTykyElvWW/P6SLIHAHJ5cls?=
 =?iso-8859-1?Q?0xfMBQhilI1MTKWpH3CSsZcSj/0nCNjnHZ+YWvqFICCECniBbE8TpzWw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5868c6-9a7c-4336-caef-08dc6462ff43
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 13:32:33.1946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e5rj1M2TicxdVJZgnHw2MkgDJ9QYbJFoIGzTF71KyptqCW/VEeSsRqUL60aAIl71/ZU3V3OABDKm2wAipX+z02iMBCKEpSuSvUVjs1Fv964=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6106
X-Proofpoint-GUID: WcPHtqr1QyydUtEVJoPemlEnWxiaTpNh
X-Proofpoint-ORIG-GUID: WcPHtqr1QyydUtEVJoPemlEnWxiaTpNh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_11,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=715 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.21.0-2404010002
 definitions=main-2404240046

Add SCMI reset numbers according to the Blaize BLZP1600 SoC
hardware specifications.

Reviewed-by: James Cowgill <james.cowgill@blaize.com>
Reviewed-by: Matt Redfearn <matt.redfearn@blaize.com>
Reviewed-by: Neil Jones <neil.jones@blaize.com>
Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
---
 .../dt-bindings/reset/blaize,blzp1600-reset.h | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 include/dt-bindings/reset/blaize,blzp1600-reset.h

diff --git a/include/dt-bindings/reset/blaize,blzp1600-reset.h b/include/dt=
-bindings/reset/blaize,blzp1600-reset.h
new file mode 100644
index 000000000000..c500c2b0690c
--- /dev/null
+++ b/include/dt-bindings/reset/blaize,blzp1600-reset.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (C) 2023, Blaize, Inc.
+ */
+
+#ifndef DT_BINDING_RESET_BLZP1600_H
+#define DT_BINDING_RESET_BLZP1600_H
+
+/* ARM SCMI resets */
+
+/* BLZP1600 reset numbers as defined in the hardware architecture */
+
+#define BLZP1600_A53_C0_HARD_RST 0
+#define BLZP1600_A53_C0_SOFT_RST 1
+#define BLZP1600_A53_C1_HARD_RST 2
+#define BLZP1600_A53_C1_SOFT_RST 3
+#define BLZP1600_A53_L2_CACHE_RST 4
+#define BLZP1600_A53_DBG_RST 5
+#define BLZP1600_GIC_RST 6
+#define BLZP1600_CRYPTO_RST 7
+/* reset 8 invalid */
+#define BLZP1600_GSP_RST 9
+#define BLZP1600_DRAM_A_SYS_RST 10
+#define BLZP1600_DRAM_A_DDRC_RST 11
+#define BLZP1600_DRAM_A_PRST 12
+#define BLZP1600_DRAM_A_ARST 13
+#define BLZP1600_DRAM_A_PHY_RST 14
+#define BLZP1600_DRAM_A_PWRON_RST 15
+#define BLZP1600_DRAM_A_PHY_PRST 16
+#define BLZP1600_DRAM_B_SYS_RST 17
+#define BLZP1600_DRAM_B_DDRC_RST 18
+#define BLZP1600_DRAM_B_PRST 19
+#define BLZP1600_DRAM_B_ARST 20
+#define BLZP1600_DRAM_B_PHY_RST 21
+#define BLZP1600_DRAM_B_PWRON_RST 22
+#define BLZP1600_DRAM_B_PHY_PRST 23
+#define BLZP1600_USB_RST 24
+#define BLZP1600_USB_PHY_RST 25
+#define BLZP1600_CAN0_RST 26
+#define BLZP1600_CAN1_RST 27
+#define BLZP1600_CAN2_RST 28
+#define BLZP1600_ETH_MAC_RST 29
+#define BLZP1600_SDIO0_RST 30
+#define BLZP1600_SDIO1_RST 31
+#define BLZP1600_SDIO2_RST 32
+/* reset 33 invalid */
+#define BLZP1600_SD_CARD_RST 34
+#define BLZP1600_CSI0_CTRL_RST 35
+#define BLZP1600_CSI0_VDMA_RST 36
+#define BLZP1600_CSI1_CTRL_RST 37
+#define BLZP1600_CSI1_VDMA_RST 38
+#define BLZP1600_CSI2_CTRL_RST 39
+#define BLZP1600_CSI2_VDMA_RST 40
+#define BLZP1600_CSI3_CTRL_RST 41
+#define BLZP1600_CSI3_VDMA_RST 42
+#define BLZP1600_CSID_CTRL_RST 43
+#define BLZP1600_CSID_VDMA_RST 44
+#define BLZP1600_DSI_CTRL_RST 45
+#define BLZP1600_DSI_VDMA_RST 46
+/* resets 47-48 invalid */
+#define BLZP1600_DMA_RST 49
+#define BLZP1600_QSPI_PRST 50
+#define BLZP1600_QSPI_RST 51
+#define BLZP1600_I2S_TX_RST 52
+#define BLZP1600_I2S_RX_RST 53
+#define BLZP1600_I2C0_RST 54
+#define BLZP1600_I2C1_RST 55
+#define BLZP1600_I2C2_RST 56
+#define BLZP1600_I2C3_RST 57
+#define BLZP1600_I2C4_RST 58
+#define BLZP1600_UART0_RST 59
+#define BLZP1600_UART1_RST 60
+#define BLZP1600_SPIS_PRST 61
+#define BLZP1600_SPIS_RST 62
+#define BLZP1600_TIMER_RST 63
+#define BLZP1600_TSENSOR_RST 64
+#define BLZP1600_VIDEO_E_RST 65
+#define BLZP1600_VIDEO_E_REORDER_RST 66
+/* reset 67 invalid */
+#define BLZP1600_VIDEO_D_RST 68
+#define BLZP1600_VIDEO_D_REORDER_RST 69
+#define BLZP1600_VIDEO_D_L2_RST 70
+
+#endif
--=20
2.34.1


