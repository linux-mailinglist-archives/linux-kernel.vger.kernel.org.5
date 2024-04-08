Return-Path: <linux-kernel+bounces-135888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1809089CCAA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EE5FB26ED4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB35B1465AB;
	Mon,  8 Apr 2024 19:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="tE9zmm+u"
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C58146007;
	Mon,  8 Apr 2024 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712605799; cv=fail; b=iQFQ0AE/1VaRKQfCe0BsVzdnOEz9+ZOysYbv48RIRKwaJgItk833jfvVcbDfsG9RISt3xWWxhG7/eOGZOBCedSbObURj2Z10GJvwpFza4Nu+HFifMj/a8ks6okMuUulILIZF+8qgSApY3UFNNgQSNiTKcYQPnQBIvO7CDPQUu3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712605799; c=relaxed/simple;
	bh=y0r9UOxg6uGMHjf/xHT+2BOYd+BoCODUVubesVY7QPM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QAlpe5iOpfuM2cK3RQpKlA15ZcKIes57x5/szB1PW5d2Qr9R0NbHlvGS/qAB+tTOHcbPv761m0ZLBNa/HHNBi0n8CNC9zy+T7c+wDmAciFt6Y7Nu5yDBP8FgbHjPshgrPfDr2UyajyEyXv/jpD3776E8g3iV5tNvMIu9PPuzSgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=tE9zmm+u; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 438JNvrK002304;
	Mon, 8 Apr 2024 19:49:38 GMT
Received: from deu01-be0-obe.outbound.protection.outlook.com (mail-be0deu01lp2168.outbound.protection.outlook.com [104.47.7.168])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3xavryhgxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 19:49:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyxovdsUr00fRfSiZud+5nsUtsWk3ctOIxyB9PFYTkdohniqMumQQnYVSL3AVnkflAsCiFIG2jwuSzzzeZW64xeqEpOLemyqWeSRaJTiqOrKWHywcoUek5mcZ/CjnlvH/c22DY4H1Iv3ab32yT03VCjoaqJcv0ULyCGgdZ3BxD1H8xRjWtWaDG5PdsoJ2UkQ12WLMyzqkvXSID0cc3sBAjHu9c5BHp9KDSK1s4nji+N5Lpq2BIOvmj16cFr4j0taX3vFTQy1cwGzrG4NOeR+xDQbzEJHxo8LsniUbobQaECy+22i5xqLK9x2U0iTaY9P+fR5KEzPm/LKYQ3c83houg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMj48TlTOWN8cOqjDJAZPzW6/UaDwb2y/jO/gQVIKHw=;
 b=UhDiZgMI5eL0Gg06mcJc89auyMLnlBUe7DpWk4UOSzSDAoYE/gRtt+e5aczKCK5D5mOETx2yLFLarPloqN9AbmxLybwMuSvxlukzlF7Pp9PCk8MmzaG+BEsSZvQ+HVv9/TO5J8Uvwz/ZC6bZAHKAhv8quuz01mrc8cShBXpGSXbv6qudlibX9HAGNrCwyF6oHNl7oV4IhAEBqY7TZ2ONH+cnfvDK2yi+sdIzikzo26O/1siRSQuqSzYHFdyVVuG0Qc6NjegcpVUEMkqCikfm5v3gsMExqv2X/x6fV5MWS0u3++E1kWM0zkWflUsMoFoSb6lseajE8BBgwJMkjj+npA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMj48TlTOWN8cOqjDJAZPzW6/UaDwb2y/jO/gQVIKHw=;
 b=tE9zmm+uybNZWhR9ld4SQr74Gll9xapVf+4H/d/H+VOHSqiitMdjYyqxLa5jKMkQ6S6WUYi8Eq9cVzx6m4SwbYiRti/tPMpinVUZU4q0FQIOKAeZET/hg8ajmh4BRjk8WBatN3wYx/wR5EV5D5TcEEPaDRBsjEXmSGLjZKgurYrA8SElcmzthpPj2swLWsvNQd73pGNYxm44/XGcBT+Ow3R8qALnqHHh2Hy1r/z3wKPdxdKP7c3jg0pr1TwyklcHMaW8PI/kn3ZqKLkiF1+BnKOYaby0KrMlqBxOwm2EuZpIsSTLoeY54gIDjOBYZvxpjtgGgXxJ1kUy9WJ0Mp9LzA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR6P281MB3724.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:c3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 19:49:32 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ed6d:53c2:7987:ea18]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ed6d:53c2:7987:ea18%4]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 19:49:31 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Luca Weiss <luca@z3ntu.xyz>,
        "~postmarketos/upstreaming@lists.sr.ht"
	<~postmarketos/upstreaming@lists.sr.ht>,
        "phone-devel@vger.kernel.org"
	<phone-devel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: imu: mpu6050: Improve i2c-gate disallow
 list
Thread-Topic: [PATCH] dt-bindings: iio: imu: mpu6050: Improve i2c-gate
 disallow list
Thread-Index: AQHaidKwc1spTU+Cy0SOvLRms3HCILFexeuR
Date: Mon, 8 Apr 2024 19:49:31 +0000
Message-ID: 
 <FR3P281MB17571BB638E31DC630C3F78CCE002@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240408-mpu6050-i2c-gate-v1-1-621f051ce7de@z3ntu.xyz>
In-Reply-To: <20240408-mpu6050-i2c-gate-v1-1-621f051ce7de@z3ntu.xyz>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR6P281MB3724:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8shUAhs4uTFnvTSc1T4FYnxnDJQP33TzlUDVNcc/2V/dmamFaHX1DqJgHQcr5usLJg3HnXHasexbbr6lGueBBxPtvPAk6cmjUAtNVvKPhQI2Miie+bRbrLTEQ2YR14ipUy1RFDgoR/QNAmR4QXlCUOByHv2pDRn+PUmWLLOiBxpbpGjSewss7qyL5X0ZxD6YS5zl8dtkgaKK2359mVkAKbc12Dn1o8iFgfB+j2vnOgIGr3pjA0aQjszOTjF/M5yOWEARnzivyn6m+RUlGUMmkNQ7nnPCekbryD4hhh7iIvzW/KGk6Al1mPSGZGNHmJN+R//15VNyReuwQRnlSM17t7d5j0GpYX0K9Jy8Qso1+DHXIdP56GKf2OVqZmEhAWsEqit4Hs4z4yWniRA8w0hEzadWG3rRdCrre6mcPRgMDV7rbjYxn7+Ay62LSzeGFjqsYW7BKtoXFN0qUzDGB0wpKJn/rbVkul/UTdXzC1WiL1hdxHEs3W1xscbbyS7m8578dzt+emxYZ6IP5Ko1d3Czk5j19yEfjOI4KxEmA3OYAursP37alKxHz5TirTdwkDxSjjMnSrAx87SOKEGF1FtckMMqJhefPcov0fZYCfvKi50=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?Q8VG1Eo93AoK4J4iGwMHk3TpJFR2Coetj0bb1LCe/JhMEy9ZjnpyL3Ex4J?=
 =?iso-8859-1?Q?OZmAUFijyqkeds91MQan2guWrWa40qXSZk515ExRH07OFypSFBZSPhR3V0?=
 =?iso-8859-1?Q?93a/2SxCIfnId9fODbokjEEeHbBK5cm/uLaixxUuNa4OKk7bTxQhGHhRkr?=
 =?iso-8859-1?Q?u/5hwUBo7dj2ZxqcXKhAQAuerjOEWNw95mMYjAQGH5A/Rqgp+cg4ENNaqu?=
 =?iso-8859-1?Q?nB05CENkf2Oh3CndpHfRRB169X1Bbvqg+TxI2eqejtqgcntfdM95LsLus2?=
 =?iso-8859-1?Q?cirTNPH4/BO1W+j4lNv1RwuDUjc5+5e0KYbH2hzMw+wDUhsluFU5orqY8t?=
 =?iso-8859-1?Q?csLExi5rZgjc4XjHZ0cXju2IacETvFaTcRP29+afqRx9HKP2qjV/zhfk67?=
 =?iso-8859-1?Q?Z/Zbxd4+/1BsUciF9qzIF7j9EuzKEKvNi4nxmZUb0sbiqvwCypaX7WhzIg?=
 =?iso-8859-1?Q?4g1C/swjHJrDhPJLMqf0gqwORCtdJ005AFiDrTro8FN0yMSWiiuROgRG7/?=
 =?iso-8859-1?Q?Dp1bKdDIH430GcNoGY7vSYH/OEmzcLlPmk576F47YZnaYgz/phHQpDUTfb?=
 =?iso-8859-1?Q?3/D+0UaiJ/FZv92AM4u9pQa3LFTyPtwf+fI0T6mdNM0Dqi2XJCyZTvZRuW?=
 =?iso-8859-1?Q?gr51CwsuCp4vxTYrisuWfFqpytpiJCXTZ2Dgy9ljNYDrktK9mnXrXyvJ6b?=
 =?iso-8859-1?Q?ol2XOwCMfChOxJGX5Bnozbb7PyHd1sO0gafmjEYug4/a+lEfqDi2xe3gVD?=
 =?iso-8859-1?Q?gag1gYM23TUek2l0CB3Ak4uTieZq/TQbFYOSVBzb4heoSva10Tp8Suq/ju?=
 =?iso-8859-1?Q?Rxrk+ehRQJGzHKtuha3lLLbn1rS/U9wtBYpc4Du8BqRvWNc42FcdIAFcAM?=
 =?iso-8859-1?Q?WsZgEFXeKsT+zPfeSf6aSUX0sgPlsaRYR5QSNDrP131S3ulaCmfzjFar1X?=
 =?iso-8859-1?Q?GIjaMPuKme/nitCSGl2qfZMS2/CsP5Yz5uzn/1XeCR7nz4FnLBrI/Vf/Tl?=
 =?iso-8859-1?Q?Up06kV3qdX2BalVy1seXL7XqN4OlGaPRRiZU8dPMLBtuYg16zMJnXoGpb+?=
 =?iso-8859-1?Q?4RmrKWJOyXvEbWI47xZdPTDx84vCqNkmRe/bWyErE68Xz8QbS8NInTWlGI?=
 =?iso-8859-1?Q?9jHPtSHqP3Dkq0d9e73OcZIyVmuh8FdAAh7rLDop1I24j53Z44i1OlBS/P?=
 =?iso-8859-1?Q?Pzj7InsWWbnjD+AisU6IPR9ZmHPIIhnOjVv3v0iMaTZ+WXiRYUpHtOvWIn?=
 =?iso-8859-1?Q?oVAy82abOfJMddahpiyzjhYZc0qYtSKZ3nB8uNxPGfPqTPL2bANyTv1HP3?=
 =?iso-8859-1?Q?fKHxp9J/JnUbJydvuf6boShbBlpLad5hevz+5Y7VOnMbif85XgqAK0ciX6?=
 =?iso-8859-1?Q?6Ch+x/3ElPQuHtqSR0M4mRGR9fF1R08fu2lUaXP+T5SsbpiOG0k9unUHbP?=
 =?iso-8859-1?Q?+UEnJiEGBjZ00FhFGnpjIir3Eef4m2ooBxl8ME9H/GWTpcFoMjwK2vxhzE?=
 =?iso-8859-1?Q?DFBniPiq02Uhk7Rkd8znsOuI8OJrqRC9gGuamGKlAnRLfMB1dPIMTEsvBA?=
 =?iso-8859-1?Q?RdAFsceTbCjYj0Ux72jhpcdf2I7JRglwlGRKV7Pt/a0Lr5CTfx5YxQerLE?=
 =?iso-8859-1?Q?OlMZB5Rgg8gsQEohrE4sF3/dh6Nwwl7MiObzZt9Ejp5VN6Sai+yUQVzwRw?=
 =?iso-8859-1?Q?SFdb6EPHTS2lxeFmONAHBGaB0GxyXV7+Ndyp5zxnoQtf0iKwIYfeT/bjTX?=
 =?iso-8859-1?Q?J6lA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c8c2d0-04bc-4a69-5caf-08dc58050260
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 19:49:31.7439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0NG+U03mHawk3DLMLRRt/YiQJJjJdkUpw9YS7R4bkaPuS5Cy/cRI5NEGwyJ+UdKRQD6dZpPPgcPfQK582ucHupfUuEv+OtUsWGVQs5aR/aA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB3724
X-Proofpoint-GUID: mmUdzb40YsE5V-LVT2AXjG1wuqZW_jCD
X-Proofpoint-ORIG-GUID: mmUdzb40YsE5V-LVT2AXjG1wuqZW_jCD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_17,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1011 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404080153

Hello Luca,=0A=
=0A=
good catch, thanks for the patch!=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
=0A=
=0A=
From:=A0Luca Weiss <luca@z3ntu.xyz>=0A=
Sent:=A0Monday, April 8, 2024 18:34=0A=
To:=A0~postmarketos/upstreaming@lists.sr.ht <~postmarketos/upstreaming@list=
s.sr.ht>; phone-devel@vger.kernel.org <phone-devel@vger.kernel.org>; Jonath=
an Cameron <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>; Rob He=
rring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Do=
oley <conor+dt@kernel.org>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@=
tdk.com>=0A=
Cc:=A0linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; devicetree@vge=
r.kernel.org <devicetree@vger.kernel.org>; linux-kernel@vger.kernel.org <li=
nux-kernel@vger.kernel.org>; Luca Weiss <luca@z3ntu.xyz>=0A=
Subject:=A0[PATCH] dt-bindings: iio: imu: mpu6050: Improve i2c-gate disallo=
w list=0A=
=A0=0A=
This Message Is From an Untrusted Sender=0A=
You have not previously corresponded with this sender.=0A=
=A0=0A=
Before all supported sensors except for MPU{9150,9250,9255} were not=0A=
allowed to use i2c-gate in the bindings which excluded quite a few=0A=
supported sensors where this functionality is supported.=0A=
=0A=
Switch the list of sensors to ones where the Linux driver explicitly=0A=
disallows support for the auxiliary bus ("inv_mpu_i2c_aux_bus"). Since=0A=
the driver is also based on "default: return true" this should scale=0A=
better into the future.=0A=
=0A=
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>=0A=
---=0A=
This fixes dt validation error on qcom-msm8974-lge-nexus5-hammerhead=0A=
which uses mpu6515=0A=
=0A=
arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dtb: mpu6515@68: =
i2c-gate: False schema does not allow {'#address-cells': [[1]], '#size-cell=
s': [[0]], 'ak8963@f': {'compatible': ['asahi-kasei,ak8963'], 'reg': [[15]]=
, 'gpios': [[40, 67, 0]], 'vid-supply': [[50]], 'vdd-supply': [[49]]}, 'bmp=
280@76': {'compatible': ['bosch,bmp280'], 'reg': [[118]], 'vdda-supply': [[=
50]], 'vddd-supply': [[49]]}}=0A=
        from schema $id: https://urldefense.com/v3/__http://devicetree.org/=
schemas/iio/imu/invensense,mpu6050.yaml*__;Iw!!FtrhtPsWDhZ6tw!Athn1pwCL_LPp=
Z97exHEFSkirApIqFF2ISY01IuyHtFBxpbPkcPWh_FmzB_TiCzb8uv1HO0AHY4IeIlv1-o$[dev=
icetree[.]org]=0A=
---=0A=
 .../devicetree/bindings/iio/imu/invensense,mpu6050.yaml | 17 +++++++++----=
----=0A=
 1 file changed, 9 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.y=
aml b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml=0A=
index 297b8a1a7ffb..587ff2bced2d 100644=0A=
--- a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml=0A=
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml=0A=
@@ -62,14 +62,15 @@ properties:=0A=
 allOf:=0A=
   - $ref: /schemas/spi/spi-peripheral-props.yaml#=0A=
   - if:=0A=
-      not:=0A=
-        properties:=0A=
-          compatible:=0A=
-            contains:=0A=
-              enum:=0A=
-                - invensense,mpu9150=0A=
-                - invensense,mpu9250=0A=
-                - invensense,mpu9255=0A=
+      properties:=0A=
+        compatible:=0A=
+          contains:=0A=
+            enum:=0A=
+              - invensense,iam20680=0A=
+              - invensense,icm20602=0A=
+              - invensense,icm20608=0A=
+              - invensense,icm20609=0A=
+              - invensense,icm20689=0A=
     then:=0A=
       properties:=0A=
         i2c-gate: false=0A=
=0A=
---=0A=
base-commit: 8568bb2ccc278f344e6ac44af6ed010a90aa88dc=0A=
change-id: 20240408-mpu6050-i2c-gate-4ea473e492f4=0A=
=0A=
Best regards,=0A=
-- =0A=
Luca Weiss <luca@z3ntu.xyz>=0A=
=0A=

