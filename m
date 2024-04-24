Return-Path: <linux-kernel+bounces-156971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D178D8B0B06
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CAE91F2345A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA02A15E213;
	Wed, 24 Apr 2024 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="h4CUo2Dz"
Received: from mx08-0063e101.pphosted.com (mx08-0063e101.pphosted.com [185.183.31.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E24115CD4A;
	Wed, 24 Apr 2024 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.155
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965541; cv=fail; b=qjBsaMH8D3DAc73XNIldCSO7TZvXbIO1BCxlfudH9fDEpU7Ep/DPF6HbKEDSmgvQ8CmCqI0jUZpISdTfl4ANgOcMZKH7+vraEVEWBfQDYoD1pb+176wucHSGunjknojelc/NNpGkEnOLKjuhHxWkZIZvJwtKQ1n1lDvY6Po5C3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965541; c=relaxed/simple;
	bh=otmeC8jNafY2a53LwD5fZGOGAbu254cR10zN1XIA1Wk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hA965xOWBoe44Q8O2h4V+EZZlqQgcPDKwg3lN2DP9f57anpSVozfysqc2YF+peS+b+rcKDu2+ubjiZ9Mmunyl/4C0gnTSB36gAnMjDCc0FEwzZsQv1Ej0gFG1XvsUEUDVfuLIsF9XM0hnMVmrPpA7q/+ayh65+gHd1eQ+c9g8uQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=h4CUo2Dz; arc=fail smtp.client-ip=185.183.31.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247494.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43ODU27N015721;
	Wed, 24 Apr 2024 14:32:08 +0100
Received: from pnzpr01cu001.outbound.protection.outlook.com (mail-centralindiaazlp17011007.outbound.protection.outlook.com [40.93.132.7])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 3xnxsfrqya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 14:32:08 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sv1uCRqTOqQNZqNJnaApn3CaeiGjdzg7u3uEMr/QtzHoh4+VSNvjPQaKvUSVK3kfNLIEydo0uZmYVuuVTF1QksgzWyC4QzbAc80yL7MwQs+v+DPRvDJG0oCqNOCd2Qzx2JcB1Cs3RmPND2+/FQBkEghKjj7EKF3z4UuLPWGhaq15ws5s+hF7YcvKUW6nk/MqW5ylmadbMvF5ti44PK4u5TtzvfsAa20kIgynxGdQSAkQOpFLgbDVjdI8MWRbsq8xFbah7Mc+lt0TImuh7xl/Svs9Q2J5y6pLhnRFKIoJc931fIfjfDrHVZolQW1Zmwtt/c/qNUCDfq8mpEOgqCS6Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E//GxHF8CuON8Ap8NdTk+Gsl36aGz+QEVeS+5zOVUQM=;
 b=NMHryms/sIF+oxnKQKVXPHCd0v1S8egD49VzycGQBEJOCdX6g6oo1DRvyN8PJBjjq7r/+/W6zvV3fYZL5OSlFOJ1aF+ufM8GoEnVvEDU1af7ZBgKiLCrwZWISse5zj1Ee5BVb8xlHtipU3/FnPUcXEuxDkM7uEBmL7cBdWLGxEQgTu1F3KKr23OmplfAgufjbl8YYUjuX/QDCaicq8LpvFP3YVrDOLYX5iCmZyvSBkkKR4jh4tJLjSMWUeAXFTpC8jX1AYLsDPQkHQDPDPm8Y04N1d1zWMOW2SCxuAcERDjvKlLHutYGXJCwJPaSX7gWuci7w3rf1twwJ9ImqqW5dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E//GxHF8CuON8Ap8NdTk+Gsl36aGz+QEVeS+5zOVUQM=;
 b=h4CUo2DzC9d8sFHvf3TGUKiArhuGk0M15gfN31POL8EJlzkU2qnktGgdvC6UfRiBp3gsXAini5Iq58xIRIGV2qWDmU2VOd5MX2U70sTCtQ9wIyx1A1kIxyBD+m75BSfsvPYA4iSguUDTeMguvYyjplH4YC5FXJ+OqB+T8koWxbo=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by MA0PR01MB6106.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:7a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 13:32:04 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%3]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 13:32:04 +0000
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
 Jones <neil.jones@blaize.com>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: [PATCH v2 2/7] dt-bindings: arm: blaize: Add Blaize BLZP1600 SoC
Thread-Topic: [PATCH v2 2/7] dt-bindings: arm: blaize: Add Blaize BLZP1600 SoC
Thread-Index: AQHalkvLgszYcI3Dx0OoIZTyfjzAhA==
Date: Wed, 24 Apr 2024 13:32:03 +0000
Message-ID: <20240424133201.19140-1-nikolaos.pasaloukos@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB10184:EE_|MA0PR01MB6106:EE_
x-ms-office365-filtering-correlation-id: a00ea771-04fd-4172-f956-08dc6462eddd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?lK1Z+HlTnqGYXE9p4WZPzpdwouvcm2ciQudiplaizcbjEYv7zM7yh1Aumg?=
 =?iso-8859-1?Q?qnoFt9H4Y04W/UqmAj6iiJyAjF/ZiEmuokf/7ihPkEahQ196vxsq8BldrP?=
 =?iso-8859-1?Q?vxfOhf1X2UVLNKCsEKk7qyw/TPYCN3fwgy5tKiDld1W48ypMEjDEz30eS9?=
 =?iso-8859-1?Q?zlPZgsk2Y3EzLummn+orRR/MhRxN5LeTDe6nTvcUGQWTM6GEwopkaYeGdq?=
 =?iso-8859-1?Q?IOarH0B5+nY3ofwZHY8hIaV/UT0bamvYGnTurcaJs23abu0IyN/wfrDgQU?=
 =?iso-8859-1?Q?4t/YELc8T2FEVpBsefaA+0YvjYRVHSdJI9V8GcCDUVYZbjvyH5xv5Rrcax?=
 =?iso-8859-1?Q?yKk4PQysdjXP4iOh7w9990sQ1GZRzKzzoafKdKxgrmC9PHUFiePQ7P+7kc?=
 =?iso-8859-1?Q?ro8OhvKlppe16RocBeSJTf2xdZSA6yHo+lBDmXhJjp1lk9KwL4nQTNiTfC?=
 =?iso-8859-1?Q?W+tpnqUpB9nGhXE76cCevzHy/xP982rCHRPXXcEvx7BE3jwt4YmXFj89sE?=
 =?iso-8859-1?Q?5ZWZYHF1xbf7hb+xhkPh6Uv5dTIImcnrsaajQm7y8vZulziqSAQIuKw9en?=
 =?iso-8859-1?Q?FygCgYspWxYnUeWh95YG6FuhperRYJr8w3hu8wCp40fRky1dBq4Mc9GtTb?=
 =?iso-8859-1?Q?QBfSiqQPOaN6qdEg2SlCMZVVzR2B5wmNLDF+iDTXoQSqPyG/YVeQQQwYaz?=
 =?iso-8859-1?Q?TH1A9vMPwgs/jTJz+1vbffjWSApmW6BR4Cs/p1kQXH+hrP6gvmACCBrVg7?=
 =?iso-8859-1?Q?Ed6SerP3bN41mEBUIj/8AJ2aFCz/Z14BImyaDfNl9xdczx7mByykJqL2n1?=
 =?iso-8859-1?Q?UBoPEZzB3bmgWPxZcC1Yq/Ggp7p6Z3WnpxuabxTPuuo69/T6QPBfT/wqjR?=
 =?iso-8859-1?Q?aku2FmlHNJChKz4s8jgugnDzTJg+081TZ9EY2oHpuRC7okZwP1vaNMZwKW?=
 =?iso-8859-1?Q?DcpejAr061ag/HhE1xINHuRk5fxF43Axt4rqZmD2NBX0SkmwC8U833BhUL?=
 =?iso-8859-1?Q?znalnxfsVB+zvH7HxV9uYnY8gHWiVOPjjwPgdOFq3DH1r4sPk4S7dThDGT?=
 =?iso-8859-1?Q?uRQRSDDWDl31gFe5UGknRxTLf3bXRvjYjt/V9wBO1LO8U1Fz7gULDvBZQ/?=
 =?iso-8859-1?Q?yhBdtEuYh4nLm0gjgxuOKV8rheKuqYVmP7vet0d0nyBIjw7gTans3hC3st?=
 =?iso-8859-1?Q?wOOfTob3TNONXowac0duzs20BietTMhs8uqwnyZ6m3BQ/TGpFqQ4/LQOj+?=
 =?iso-8859-1?Q?CMlYDxsKzlRY5oGtC9bBpSHRir0puOfrupZJ6xE+6WyATu0xFhFFTfhO5S?=
 =?iso-8859-1?Q?Obu9Gm0VUEU/fTT9lEM7pzrbnw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?mq7+kbJ9qmjD3kIeYfaRBjvCwUouXUHOJnED/yX7f7ij1pjJJiQi+/nDq2?=
 =?iso-8859-1?Q?W5yPWLDYkEa23+4CXylJoZlW968oDqPIKFjaZvrZtYtTQpkEiiEwq0q5mS?=
 =?iso-8859-1?Q?sgybwif9lCA1Gq9jl89LVm3zs63o7UxEAqiOu71C2gsP8S+XZLEKaVXZWE?=
 =?iso-8859-1?Q?1fpRXvrCQuAnMy/Mwn6kCfuIeALvFsnC8Jg7sXQIrD2x3pdJGR2axCBXYu?=
 =?iso-8859-1?Q?dcFjWtFAX9RTmQGHBeJRx8MN7DWtGu8wQocDje76amm0aoQBxe4ywOhIaE?=
 =?iso-8859-1?Q?VR4sVy16+tdYNz+6H7nF4FLPLOdGgxozi5+8YceJLrvve++AESkdYJRcre?=
 =?iso-8859-1?Q?Pwq9/ITNrqyqBtHuQR3mytVdjowtLUsdWb678j5mefBGwhtRVcVBKkrQL4?=
 =?iso-8859-1?Q?Zmjhmsz4hl3q9EIV3hSCqXjBlf5qkQoZVNu70nZI6kR54lB199DSCCUhGP?=
 =?iso-8859-1?Q?3gPekzm+/dYqFFJUxXEnmbu2Smnvvlwfdsa1iYBcSOXZXGw9NBEmjYNPXa?=
 =?iso-8859-1?Q?At6kcD/nxpdLl5F1lU0tp+ZRuLOSDkO0x3nNkDcK0dRgqJqyybWGdDstEu?=
 =?iso-8859-1?Q?7MdM7J8wjjQxyCLIiDHAGWk2fk3Ol0Js0goRduXsSFr6i8mPduqLe1rbQF?=
 =?iso-8859-1?Q?i/MaB7F11HOe838y2L1MCA0CJAEtZGgAAohIiXwnUoW/bGnxvJuK4ARU9m?=
 =?iso-8859-1?Q?5sb/Tj9Z8dzk8NZpU9OJT5Wmr4mhjsPYsdIotITDAh7RsZeqkwWc73cp26?=
 =?iso-8859-1?Q?EFenQ52MbcJOZ3EHK/zop/RqLcBKGn1KUMrFtAtyj2mFronL63cbydgJjK?=
 =?iso-8859-1?Q?LVxnV2+tNX45TZtq0gCgdotfX4bjeP9raAxystkk+/ebPELkd62FgO30pK?=
 =?iso-8859-1?Q?dMTAgL0lpgN04v45pGIT71ny0pQzkMn3S1DVSv4+MNzMVToi2TsiDuleJ2?=
 =?iso-8859-1?Q?Jq8PIzb8OE16MsyE0G4/UKuGa2lmWwlHy80TCwlwiUNgNsHZvMc1ew+pr8?=
 =?iso-8859-1?Q?nwJKps8HcuGXgycyWvontDnVo/CEEs/UpbpLAe4m33JXzPbV21FaFV7CPp?=
 =?iso-8859-1?Q?o/qZ6OZrfs6WAycj+hgQG24v5tDzY+ovqXFlAxbnha4h1QAjKlsbqBIwGt?=
 =?iso-8859-1?Q?eti5VgZlhKUYjPPMv66us4HT7No5aHpOm1EAJxo/QnuhV+bBb5LjxJFnIM?=
 =?iso-8859-1?Q?CjNKGzSm4LnGCNOOobn+ue8qA1cI4pBVktwwNMQJVGAVWsd2vQDkC7x89e?=
 =?iso-8859-1?Q?q9Y6K5nu8ASjpMACnt9/x0tf6MWULLU5z7T/qLCsMgQIzgD6g8PKPqK6c5?=
 =?iso-8859-1?Q?KB8uh4mNAM0ARUUK+9IYaE5ToQ3nXm1O2Q1XSYY5uJQi0lkDQrwPv21klB?=
 =?iso-8859-1?Q?bChUrrJkyjBVex7BEnk3F7pSL5L8nfh25NtziBySsCNMABzm7PUhsC8UPw?=
 =?iso-8859-1?Q?7gKLaxy+eV0dQcJhCvKvQ1cfabMxkfQuzMrAVTkPBa1+0oFaG2w12SAHHj?=
 =?iso-8859-1?Q?Ev2aIv9yajIfRhLMGm7W1yWa3HR4Cv2ZeKPyYXvm6qzYvmIVar0bOKO+bp?=
 =?iso-8859-1?Q?bX9TahoT+KNmxzfjelYnojesE9jp74TGxXUnWLKS7cswDxwl39ZiE3SG8i?=
 =?iso-8859-1?Q?btKOzelOTxshwqQwbRI4FaFYJKLsKakjo5cRGW4H6KBjOvN9XNUhNAMA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a00ea771-04fd-4172-f956-08dc6462eddd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 13:32:03.9809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IROsG5MH+LJEgsb25+zVQ/hpnEw+N62QzgZRkEuKcCLMZyk5mGWOS8vzRNqGswQ3U2ONfpNEaYHbFO/1E1VatvyhbM2ktravufxVgjred8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6106
X-Proofpoint-GUID: TM2K2xNz-V8vu0MAYZoa-BiR-BfBwiWl
X-Proofpoint-ORIG-GUID: TM2K2xNz-V8vu0MAYZoa-BiR-BfBwiWl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_11,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 bulkscore=0 mlxlogscore=795 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2404010002 definitions=main-2404240046

Add device tree bindings for the Blaize BLZP1600 CB2
development board (carrier board), which uses the
BLZP1600 SoM.

Reviewed-by: James Cowgill <james.cowgill@blaize.com>
Reviewed-by: Matt Redfearn <matt.redfearn@blaize.com>
Reviewed-by: Neil Jones <neil.jones@blaize.com>
Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
---
 .../devicetree/bindings/arm/blaize.yaml       | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/blaize.yaml

diff --git a/Documentation/devicetree/bindings/arm/blaize.yaml b/Documentat=
ion/devicetree/bindings/arm/blaize.yaml
new file mode 100644
index 000000000000..8034aeb7a2b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/blaize.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/blaize.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Blaize Platforms
+
+maintainers:
+  - James Cowgill <james.cowgill@blaize.com>
+  - Matt Redfearn <matt.redfearn@blaize.com>
+  - Neil Jones <neil.jones@blaize.com>
+  - Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
+
+description: |
+  Blaize Platforms using SoCs designed by Blaize Inc.
+
+  The products currently based on the BLZP1600 SoC:
+
+  - BLZP1600-SoM: SoM module
+  - BLZP1600-CB2: Development board CB2 based on BLZP1600-SoM
+
+  The compatible property should follow the format:
+
+  compatible =3D "blaize,blzp1600-cb2", "blaize,blzp1600";
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: Blaize BLZP1600 based boards
+        items:
+          - enum:
+              - blaize,blzp1600-cb2
+          - const: blaize,blzp1600
+
+additionalProperties: true
+
+...
--=20
2.34.1


