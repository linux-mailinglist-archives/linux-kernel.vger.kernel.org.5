Return-Path: <linux-kernel+bounces-122021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1314B88F0E1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367F91C2BC59
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6854E153587;
	Wed, 27 Mar 2024 21:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b="TOtCBBlr"
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03E04CB38;
	Wed, 27 Mar 2024 21:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.242
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711574753; cv=fail; b=qzcD7k5fadK2FtmGDonPTwgZNpugzx02QW6sqLEwrtB35H40Lud6MBCCuL60rAgLaONmIzrldGUYSLLgAVpTjK35Kvjx+b9eY+Revm4JRyq+6FXLpYXXHNFjoyDoAFwlXgMYE38LV4C6T1Y3GdpkNsWMTOdPR/Q9HC2ZDiPPGVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711574753; c=relaxed/simple;
	bh=0XvGh4CIDYX1cvJz1FJ06ime7tKXc9dTeCCxFvOFAsY=;
	h=From:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qx31flMzpM2YqsjQZDCGjlXFn3DyrhGNw6P5L87PGYgMmNh6Mb5v5/gersA4EhLcZoiISzjMleYCtx9Z28hXsfmVBZtRuBzcd4HUQtSpHU9tXgcyNdsUfh03VHD4pS2zHKOPFY5h3Q5v2YeqAkFfxmnrXeFQvJYA38wOquZW8DU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epam.com; spf=pass smtp.mailfrom=epam.com; dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b=TOtCBBlr; arc=fail smtp.client-ip=148.163.133.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epam.com
Received: from pps.filterd (m0174677.ppops.net [127.0.0.1])
	by mx0a-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42RJkB3n021877;
	Wed, 27 Mar 2024 20:09:39 GMT
Received: from eur04-he1-obe.outbound.protection.outlook.com (mail-he1eur04lp2051.outbound.protection.outlook.com [104.47.13.51])
	by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3x4gurt059-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 20:09:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwBECxNedck1mIJVnKB4YrSzTwoaqHVuICaaBKt20ApxyN8zZ7xCCkr3tC5JYo7kJu2rMsc/t7w3kHwi3rszwDqgOvmTghLP5E+MBGIG0V+X0W9XxDnbWQdFFspqAmdapZCnOwjggerDtzbIkPwC60xI1QAJlh3VIz+4enLWyfaygrgvz4iteRiPoCURIPi2OhWIP4uIM9SJy3QByObBhijSzObL2FValCuu73g6oGA6EkzeCG79iVutL+83hDUVd2J7JEH9xr97+xcMuvdgpwYfOl7O2er5C2KKXbEySAmcnjWI67KbPy/HqSvuel+9XFcJZQ53ON8KaVb8O9+uyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqJ+DEJeF9LwZt1m1i77SrFVz2k3naYfPGBzuYCgFHg=;
 b=kJnvEuPFnzV0ugSQ57cxUme4c6CvnhR1+HVqTqQoidJJPoFcXXIF7tfK695O95x7UovQtB/+pzW5d32OjRbcmVIkPpWnvYuqt0V4oEJEK/l7Kp/x6nPEC1FMaf0jmBNhB+2Xc85xQ85ZjZ/wsr6HnUT4+LgZq7iqTIcZPhPw9LHX8plj8U96v9oG+daBHbkWA2B4d5lZ1BJYhWMZZ6fyTIzLhDxqvRT/Y+2VnRiVcmHM0E/cLlx/UOKI0nGFPyaRtxUHoP790HYUg08fjDfjEy4LeffyZ5w5vLy2r0erFBRoVob6JV8oM5Gsp2WWVDGlN5gxH3pZctvXcLZofGSTdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqJ+DEJeF9LwZt1m1i77SrFVz2k3naYfPGBzuYCgFHg=;
 b=TOtCBBlrPkLoOZDdhfNBPuLTrOVSWMGCLYy7H5oi0XwzvDKoI+7TcyH/BsQzVPQoFddbm35UREdHLqhMvo2lcDb2XcSTDT0PzwdshgGScPf7mR/qbSwLaGNrdLuOvbb/wbh/hUokoJu8sMCmlYXfzlAY552zFTmJpiZbRWZ/WBjSz1rI8VjYMAj4H0VyLYLRg95PIfFIo0s/sA84yji5g7/G2/SQZYHfl9EeU/dLiVkNf3cDte4C9ekNoUw2Tm0m0du+kMOpH4DfUzv0/Ju+GIZpVhJymFNIpsAzPhXcGRAKNHW7C3ARxI0f3+OfNMTnFx49KIwOovr64g9jNdeNdA==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by DU0PR03MB9079.eurprd03.prod.outlook.com
 (2603:10a6:10:466::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Wed, 27 Mar
 2024 20:09:34 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::74c9:2488:1dd7:b976]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::74c9:2488:1dd7:b976%3]) with mapi id 15.20.7409.028; Wed, 27 Mar 2024
 20:09:34 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
CC: Caleb Connolly <caleb.connolly@linaro.org>,
        Volodymyr Babchuk
	<Volodymyr_Babchuk@epam.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad
 Dybcio <konrad.dybcio@linaro.org>,
        "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] soc: qcom: cmd-db: map shared memory as WT, not WB
Thread-Topic: [PATCH] soc: qcom: cmd-db: map shared memory as WT, not WB
Thread-Index: AQHagIKviCrPH112HEOpsjr5BCtYWA==
Date: Wed, 27 Mar 2024 20:09:34 +0000
Message-ID: <20240327200917.2576034-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.43.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|DU0PR03MB9079:EE_
x-ms-office365-filtering-correlation-id: 5beb3eab-a157-43a2-8054-08dc4e99d245
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 7gzB/v8dtrRH2ff5rFGjSpwKyhkcEwppklXHFSTRsTBWTCdYZ+MXM81FWj9zorvFKmThoJuQ4CLEsiA7CDmI7oEAEK+4n87B6rl6nFdGe2/iP1feMYe0+tdBZ+cunC1lDSgsWzP+o1Y8+xwpVqA4cIKys6GDlnR+6wuoWYB3dvf2X8EF6Ph5z4QAPnFlVAQv1hWQy4QlCNJsOB2Tk5v+PC3ZBs6mvjXRj3UCpDbYzvDCkgvdvWGI9OF2Pa5v/rzJAW/ILlRqNIn0KBxkvTvHqiUF6dmPaYuMTomyWa+70u/dpcBa8PjPp5JsP0OH08zFW5t8mx5IAhIiKX0Vg9++UMVM7CZwU0jz/FZvke4vkBZr9HrPeI68cc23oFEVg//Df4nXlcBqmM6efBX+dyIE3nMX72sMfrLkXrTXQd2pyCS471GJ41J5ANV957Ii2OrYe2YLEe30AHF611LRvCr5zhWZ7l8cA2xQ0LxKGefthp6IBgnTcX7xg7VbNGYLqTLo/5LeXzIX4dUGCDzxmYTFJ5NjgfDW9AtdKzKZfsz78b7trxEqnYXaq05XiaRJDqu3IJpv5Obh1F9MptDZ1zcwLwm/udNaqFkr2nmezgetZQMAqJwB0ebFz1LDky4WrtWxTU7APHTBcAQSCvrzwsfo0cWrdcPiYNQkIXzmzK5ymPtMtnKnhRGBh93JTP77wP0Dc+HECFF1lyKhC2hhgtoxOK8ssiHcvdoRUUi6BVGogLE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR03MB10456.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?yXQubbxLZivy9Mc3XDBF6MTJ1XXTC1ubqkeaOamul4kctLSHHoQj2AG8Vl?=
 =?iso-8859-1?Q?1XzhdAGptYLJdZc9mpZk6DUCjR1D7FXlP+5YQR+cwl/1i/5bV7log1vn4Y?=
 =?iso-8859-1?Q?6+2SZ45wKK1F7YpArX03lEEW6AVfVoEZ/QUdS3GKOPilCX46L4c/oCPPmA?=
 =?iso-8859-1?Q?gX/Tyb5meYNMMZPT/p8eyoW7N04vD4nm2vpATPqCuaGstBQBI85fTXL3IQ?=
 =?iso-8859-1?Q?A03u4k+dPndvIAccbL98aT7DKfY6zCL0TCDxkqa446I/7pWzLbLkQqwXE3?=
 =?iso-8859-1?Q?CwTEldrdXDLML55MCj/hv6RUwnzCIV9F0nK8iUaOoPY2AhJ1MIq/e6o3FM?=
 =?iso-8859-1?Q?ImjWHDRxC0rpiUNILWzmjwidg2ESxLloNKQYLki81PsYuv5IHMYuMA4BCR?=
 =?iso-8859-1?Q?bgsysiG3XUGw3xub4k4Dn17pYTkB7+9PUx5sxVAmAVhpfbeFB8HCo1xLOa?=
 =?iso-8859-1?Q?dzU/1wRVUuXrdR3S31l5JM/19sbo75drO87bpv2NDIFaZMYfljZCfLKw0z?=
 =?iso-8859-1?Q?6MQ9tTWzaDZnYajxEW+WU4UbKsukA3t/toqfsvx4+HTZMsX1eUPvl7A5z4?=
 =?iso-8859-1?Q?P17zpSutzwT3HY7wpuUCx0UEsEDTICzeny/W14QXJVbjktTU3IF7ln3rKV?=
 =?iso-8859-1?Q?1+IFm0OAFQYsMObKcC4V/j2W0GgcvHIoR0Ls6dZNDnqRnHKU2Wnuh9lo6V?=
 =?iso-8859-1?Q?L5FWOrsXKq77MtZkTd5frw/uNxHsk4lzk2M1zj1FFNRs/FUYeAmAq1Sa3s?=
 =?iso-8859-1?Q?HzPiQbYGW60RzdTLgJti7XqXXOBKV75TU3q7pSAd/R4BG+DkWMdtJudg/B?=
 =?iso-8859-1?Q?+lSAiPCF3ohg9xrbPYh4UhSjHaMjXVZ9/9nM9g3CqGQkVA38XbJQIonWYM?=
 =?iso-8859-1?Q?NtvF+E5QijcHBs576lssyRqSiHkgb4rBPAeZM1TOms6/1TLjnQbrkb5df9?=
 =?iso-8859-1?Q?s155dZxZw3PdSSswyKT4DvJ1qcoenMpwsyJkCopGNJ+dSXKFafkbgsQ3X6?=
 =?iso-8859-1?Q?lCKwsX379DorEuldBK286R6R7IRj2UZXRUFALFVoeqz8KwJPKmXBMPxP6P?=
 =?iso-8859-1?Q?eZPafTHD4d5XXc6E1NB0vErJmiiCEgRELZD77RjcfAYny126DDNVKEBw2w?=
 =?iso-8859-1?Q?1C8luytEv5TGWjnSiCeVDHITg0na53Luo80xkzB/SqRcjmg+ysmtKsGLyp?=
 =?iso-8859-1?Q?F4rRZ3H85TT5dnVYM+HeGQiZkcljWBXouylGEPgaT3/pB7QxrLX6zif9jE?=
 =?iso-8859-1?Q?s07VMmGl2Q20u/icls97RJSYQMJHF/JVfY82+AcBsuOX4U5GbFRR46ahJJ?=
 =?iso-8859-1?Q?U1vxlA2Q7HHA7Oyp3aPDavMVqXrznleolDL/IPciRAEidgjsZ/2LvfqHzC?=
 =?iso-8859-1?Q?YDwPg4QGKJdwpUJlC+3SFzTMqOCUZLhQbcCb70q8O8f9gg0o9g+bmvn5bu?=
 =?iso-8859-1?Q?g3xCzob31U2vDmjGJgFFYRyKxEeoIr+obmw/obGr68Pyf+58izRKmLbIsi?=
 =?iso-8859-1?Q?1yM3t03ly64JHE/KR8FeOzaabU21sohPA4YouFNkK17n6bqZ674d8GTeVl?=
 =?iso-8859-1?Q?vA8IHibfVXrIfT/6IuER5a0/Jf311U3Rmz7keCjQkOHti5vMdq+GLm8FuY?=
 =?iso-8859-1?Q?2Gjd6t+hn0O9B+ZuVnilc9ymHhHvirEC1KkfdGAlYK+NH7mr2wLKFdAw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5beb3eab-a157-43a2-8054-08dc4e99d245
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 20:09:34.4056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RXi1iDFmrHb+FOclbG3j6Dgc5Qa1l+Zsm3YJGAv2oNEDHOJlcYUpd/0xbutwLZMN6Ykck+Z9akiroI3Xn2qbI9wYfgAOZRlHuSfjQSyibCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9079
X-Proofpoint-GUID: hrQiV7ga_2B1QjQttbWtUkoSeUBYr2Nv
X-Proofpoint-ORIG-GUID: hrQiV7ga_2B1QjQttbWtUkoSeUBYr2Nv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_16,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 mlxlogscore=911 impostorscore=0 adultscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403270142

It appears that hardware does not like cacheable accesses to this
region. Trying to access this shared memory region as Normal Memory
leads to secure interrupt which causes an endless loop somewhere in
Trust Zone.

The only reason it is working right now is because Qualcomm Hypervisor
maps the same region as Non-Cacheable memory in Stage 2 translation
tables. The issue manifests if we want to use another hypervisor (like
Xen or KVM), which does not know anything about those specific
mappings. This patch fixes the issue by mapping the shared memory as
Write-Through. This removes dependency on correct mappings in Stage 2
tables.

I tested this on SA8155P with Xen.

Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---
 drivers/soc/qcom/cmd-db.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index a5fd68411bed5..dd5ababdb476c 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -324,7 +324,7 @@ static int cmd_db_dev_probe(struct platform_device *pde=
v)
 		return -EINVAL;
 	}
=20
-	cmd_db_header =3D memremap(rmem->base, rmem->size, MEMREMAP_WB);
+	cmd_db_header =3D memremap(rmem->base, rmem->size, MEMREMAP_WT);
 	if (!cmd_db_header) {
 		ret =3D -ENOMEM;
 		cmd_db_header =3D NULL;
--=20
2.43.0

