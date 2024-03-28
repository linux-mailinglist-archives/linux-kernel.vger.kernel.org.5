Return-Path: <linux-kernel+bounces-123768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B06E890D81
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401C229FC7D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731FC13CF86;
	Thu, 28 Mar 2024 22:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b="Rtgr9Kh/"
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5303BBD7;
	Thu, 28 Mar 2024 22:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.242
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711664365; cv=fail; b=ON1NdiudEGLm+sJiHVrAOLbp67tXsGiErDdUGjcG2WpK8/LX8xFyBynQG/XW6kXj/IlhI5klsB23HCb+AhMrDM1189oSYLfw+neFScLQsKchGu7gr1wExxp5CgKy7Y8sIsxkngmcGG3nBIcMWTbOXv4xsb3qT+C0GZOtwEN5yMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711664365; c=relaxed/simple;
	bh=HyEeeWBFJvlEqRSAK88wylZeF3xOd2NUbZnqN0iXvCc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=czS3NFFUdMDFrplJzh+Iyh1oBwNp79WiF6AcEMUbWdSbnua7IQuvZxXEVDc/tBq96Cw0HhsnG7CcDZWOaWlpri83wXui+/Q90ID6SQvjlIL1ErOBvUUyKUahSZAY90d0xiWvvEhvl92IS6+S2psog/aAGrPggQAStwRK06dV0XM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epam.com; spf=pass smtp.mailfrom=epam.com; dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b=Rtgr9Kh/; arc=fail smtp.client-ip=148.163.133.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epam.com
Received: from pps.filterd (m0174677.ppops.net [127.0.0.1])
	by mx0a-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SJ63Ij020523;
	Thu, 28 Mar 2024 22:19:08 GMT
Received: from eur05-db8-obe.outbound.protection.outlook.com (mail-db8eur05lp2105.outbound.protection.outlook.com [104.47.17.105])
	by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3x5acssbdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 22:19:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFGxc3fwAf4RlyErB18BlZxCAav358SeAkfnSy2ARRlYCqq6QIveXb6Px8SzsEqAfRTCdO0F+Z1vNGLvqSYpvZhO7he5DRFAU92UeXmecKA1RVAi3RAYZpzqopkvS3A4VLwZgi7Dcgbz+EJoGeTlcUVRLyIMIwmGklADiyfx1GXZVO9H1kyMiX7RfON288S8ixTBPORpNeJNi6MiGtJYR8JpE1QvLF0uNs+oP9/YlmoF903uHjv7HU0WnRB0cfOIyvIZVTw2+5DqiQFh5QgKFIJC6K6vLaoDwNiGbrL/mQqdJLQshJJ9DfL9LYbqS6OlXojZ2XqLI5DBIVOXpWFPFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHa6FwnrBcHtgyOFdXJ367r6RK6lCGGR+a3/+VBdLQA=;
 b=eM/sjTKhOgknv7jE91Tv9a6cII2m31ItVbVVjIoaWl3XccYlRuOdsPwExfzGkJ/PPzQpqQRBetDO0Xaf9i33+dRoYKG+LBR99F32xjCn6Goh1D+29YWisL3gdxBr5s01LKbnj9vsMvFasfUQpOPWpPTw1JUQDnVetW80Jg/xkRg1lWYIC6pI1S6ox0nO7HVL1BcUCgZd85xyfKPP9hSoapjDdojMRn12g0WMCH99M9aXM7oghQ6JaVO/uBNpqDDOvYbP8SVhcRsvpcqGyRd8+pfmW4g4uxB/lVl2Q6zC38rZCGmCsDQoTOE5NqGcA86PZOhLjgFHzdTkfXQI9598vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHa6FwnrBcHtgyOFdXJ367r6RK6lCGGR+a3/+VBdLQA=;
 b=Rtgr9Kh//oAG2ZjTb7m56zZLZIhXZldr472Uw1OqUNlr52h0pUogjPm840dSf6DXPCf7jA+mPinx/Hpvd7DmPXQgQTOjJSnYOsVndls4QBTDFTehq5EwNl8n7mqLOJE+VnEXla2vNS6NreOb2UxKBuidQ65zCUywekfEFRuFCtBigmqCH6UsXxvHEG1t/o8fEeD3wGZdY4kIHBkkHZJle5ykJkr/zJOkNPxxQ1//bu5r4eqgJ87/YaVk0llygOxelT9VjBex5PeCMQAJ80p7p1NaIEMoCbxi7dCHN+6ljW0a1HGb50cy295bZpYYAZDkvysTgX8V3dx1mhGbXUcQ8Q==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by PA6PR03MB10324.eurprd03.prod.outlook.com
 (2603:10a6:102:3d6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 22:19:05 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::74c9:2488:1dd7:b976]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::74c9:2488:1dd7:b976%3]) with mapi id 15.20.7409.028; Thu, 28 Mar 2024
 22:19:04 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>
CC: Caleb Connolly <caleb.connolly@linaro.org>,
        "andersson@kernel.org >> Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: qcom: cmd-db: map shared memory as WT, not WB
Thread-Topic: [PATCH] soc: qcom: cmd-db: map shared memory as WT, not WB
Thread-Index: AQHagIKviCrPH112HEOpsjr5BCtYWLFNDjIAgACrjAA=
Date: Thu, 28 Mar 2024 22:19:04 +0000
Message-ID: <87sf0axanc.fsf@epam.com>
References: <20240327200917.2576034-1-volodymyr_babchuk@epam.com>
 <19bb6ff0-04ff-4e88-8c8a-499c054bdea4@quicinc.com>
In-Reply-To: <19bb6ff0-04ff-4e88-8c8a-499c054bdea4@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: mu4e 1.10.7; emacs 29.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|PA6PR03MB10324:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 mQxb+A0CsO1tDWMfpLR5JG0Mxl6mN7biOqjIQHWdKEis78XjGYOXFuFu/Cv7qhP0nP1bOZQ3+jLpnQ+2rANwfzDG/rVG0+bKudbIp8BrvHYQWrA0SX2MiKAc5n0PUCAi8R9JCZCBtl7yotc12mj8yGkG/w/RnFtI14EK+xi0okDFyROtJNWUXWDtTPr27bBfTpf8zuFNbFGt4rzasSnezOdnoyumNqsj8PZO22t+3Rz4CgZeNA8/7xDSJ3cpnv9bcOuG78BPY0cs2G8O1Ar3grgufy5e/Aag6gjaBGjlIngEnqajuyiPQLVzawWWGL/Z6Tm4molb3AaG9dua+zpOMCX2r7Gj7QTM9amtqTlenZFRImO8Es+tCOlpm2Zgh6VqyMCruYsOi9NzT4Ej0xWDScdrjxhle0LMjGWU/iYQ/8okABJlSbCBlKA5vzchwYgX75w6lzrtZrAN8KJJrorVBrupuzZBaTLOmHKI0bwBlVesAkhGwtn3KE3lddsrs07qp1HHJG3F9v3m68IQzS9UF7ewCdsbWzVVG4AfGNgLHfCbOUAP5/6WX+FFB9wuuJMVAnr+dyZ/CfmZLfp7J6h7lFpqcNUv2ICKJKN6Zg9vktDR6IfpBlFMGM3GJqQfGAqILXMrbyFRllqu2GUYpLKbuPUfXK+eh9cD/N8SZspRWIY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR03MB10456.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?grGXhM/5dwhvik554sRYi6Jqu3MU7QIaxhTZvw0Z4LRh8EYr9e0thgNjFn?=
 =?iso-8859-1?Q?g6QyWnDhhQ6h3KvdMoSdIN77mP3TnRDV855POUDXFRBRU5dUFt2jXiotzh?=
 =?iso-8859-1?Q?M9WPxzDsckM4OF5HsrfeU3+FtTiiqE2of3ZGxyrtsLssZsEFyJNtbh3Fqy?=
 =?iso-8859-1?Q?CrB+LhkaJMSqjrSAb7TqbLyQTOujqwc04FgNa74ej0Lfxmyel8NZ8/mTpX?=
 =?iso-8859-1?Q?N6pzFr7Qp7uZjBYYb3910MDXjmBv/Yvs9X4h/TZXDfXLIJshHrvoHUH3S3?=
 =?iso-8859-1?Q?5muiAILD48AShc6W3YZ/8x4qUfU1XE1VaKua1tRUHIZ1nhTqKE+NJSBldQ?=
 =?iso-8859-1?Q?Bsm1jO/OxVx5dvig7Wuuc+onZCR44lq7VQ7hGt4U+hNKNdBxy/t2w2c/Oy?=
 =?iso-8859-1?Q?Gi3FrjTQBB2Ym0pMOGBtZAwuswae/iMMHQ7aNkmxHTspAcUjXsu/L7kqnC?=
 =?iso-8859-1?Q?cWRG8V9+d3C3me7d+szjVg6hDj1T2BYR04pbwegDHkX/ac2xqXvKgNBBgR?=
 =?iso-8859-1?Q?he7m1cNWXD4Xg8/EM7Sa/0hRxFsjiXFODSQaL3JQWP+0xBOiT86StI3QOl?=
 =?iso-8859-1?Q?6lA5gIBY5uOFT7vuqC6Jf57ZgeQTJEIjw3W8uNLYYtUgDyfCxCWZgWEcye?=
 =?iso-8859-1?Q?U64KoFDIog6SzuG5xiTLjpJsGYwcsL96XNJ7h1ryeoq+P8vuOkj/U7uZr5?=
 =?iso-8859-1?Q?GjsDoI4oVjl9rGrZzxX4eMZ3uGriUJ2tr8Ptxp8Aj3InXmiaY1EMXGnZ+g?=
 =?iso-8859-1?Q?A0GQaSFNMbCqARRA0bIq/lPjEqY+VCAj6itnJvdPoSMv2fsM49WKDHEmQB?=
 =?iso-8859-1?Q?bgdC7ARQ0vuZKLP0+bx3VE0SE65UumACYBtm0aNResj89EdF4/0beW/w8A?=
 =?iso-8859-1?Q?UfiqEyWWSjWpfGGuFQb6/7OkspWK7bGwPJXGYjyHtmo5nQ0PSvd3zh193g?=
 =?iso-8859-1?Q?uLmxVHV9Hyw1LREGpCh5e82otcJo76VmfPj6Hv/4ddDG2OwhKHGmUSZ3Cy?=
 =?iso-8859-1?Q?jXxpMRpPlIBaMyFJTHiqvv1+Q7uPGfkdD4Om5jswUnb5B8TRF71rmRdVUr?=
 =?iso-8859-1?Q?XGQi4GYScspzfAyB7zZqTeg06a9mWywXwKjbiCQkCTgCuGTpmwG3ob5yh3?=
 =?iso-8859-1?Q?JPrn5UZbyKLqQgpGC+9nEM60UKpkTxXPIEXV1lbr6hGYe5cJjO/Sj53cIT?=
 =?iso-8859-1?Q?sy3JXPQn9AmEq3klXcMu+fntFEVE+0v2BA0TfrFvqnd06W3QSQ4v09+HOB?=
 =?iso-8859-1?Q?KW63uv7JbpKhz7xjhGSjcpkz6sGGaHskjVgwzmAI5tNT7QitF8djMeg9RK?=
 =?iso-8859-1?Q?ph4n6vUFMGn1IxUwik3RhGDGt1UWmlfEqwzlGfBP/ycFhYCdw2z0jbREWI?=
 =?iso-8859-1?Q?20vdYqfqmFPbWLK2PAzIJ8TmVjkAlrxLZ08CrZzEuclJKxQBstqEUhFRij?=
 =?iso-8859-1?Q?e0lsIRATDwG07JRTlxixJq3ID2ZR+1sgq/uezzUYZQw4KmfIev8v2b2lyh?=
 =?iso-8859-1?Q?w1EPYEfdq/wNyTX6J9zFX/25auG9tHkofMBuipa7CJmu+/Xafm1vV39hgH?=
 =?iso-8859-1?Q?uiArAifkaHdoXUYqD6yAR90YXfxLBiGePgoyRZqBpJa/7GUya4BNKj8xDb?=
 =?iso-8859-1?Q?1Td/0O1hRqV4TmW9BfoKFH7cMKfwaFDWzdVWT2fuI9WS7PYIux/O7hFw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a17adbd-25a4-4bdf-0953-08dc4f751411
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 22:19:04.5561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kmgUyyBr0uzXN7btOUsG2+sQZij5+GuS4WgC8IAR/Xm68GGG4fW3Iskx3CpHAq16DCH5ZQeowH4eLAdi80VqevSr6wuodigmu30/yxAI6xM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR03MB10324
X-Proofpoint-ORIG-GUID: cvknSzd17QgfbkyhKb_hR-t6rfkx83t4
X-Proofpoint-GUID: cvknSzd17QgfbkyhKb_hR-t6rfkx83t4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_17,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1011 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403280160


Hi Maulik

"Maulik Shah (mkshah)" <quic_mkshah@quicinc.com> writes:

> On 3/28/2024 1:39 AM, Volodymyr Babchuk wrote:
>> It appears that hardware does not like cacheable accesses to this
>> region. Trying to access this shared memory region as Normal Memory
>> leads to secure interrupt which causes an endless loop somewhere in
>> Trust Zone.
>
> Linux does not write into cmd-db region. This region is write
> protected by XPU. Making this region uncached magically solves the XPU
> write fault
> issue.
>
> Can you please include above details?

Sure, I'll add this to the next version.

>> The only reason it is working right now is because Qualcomm
>> Hypervisor
>> maps the same region as Non-Cacheable memory in Stage 2 translation
>> tables. The issue manifests if we want to use another hypervisor (like
>> Xen or KVM), which does not know anything about those specific
>> mappings. This patch fixes the issue by mapping the shared memory as
>> Write-Through. This removes dependency on correct mappings in Stage 2
>> tables.
>
> Using MEMREMAP_WC also resolves for qcm6490, see below comment.
>
>> I tested this on SA8155P with Xen.
>> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
>> ---
>>   drivers/soc/qcom/cmd-db.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
>> index a5fd68411bed5..dd5ababdb476c 100644
>> --- a/drivers/soc/qcom/cmd-db.c
>> +++ b/drivers/soc/qcom/cmd-db.c
>> @@ -324,7 +324,7 @@ static int cmd_db_dev_probe(struct platform_device *=
pdev)
>>   		return -EINVAL;
>>   	}
>>   -	cmd_db_header =3D memremap(rmem->base, rmem->size, MEMREMAP_WB);
>> +	cmd_db_header =3D memremap(rmem->base, rmem->size, MEMREMAP_WT);
>
> In downstream, we have below which resolved similar issue on qcm6490.
>
> cmd_db_header =3D memremap(rmem->base, rmem->size, MEMREMAP_WC);
>
> Downstream SA8155P also have MEMREMAP_WC. Can you please give it a try
> on your device?

Yes, MEMREMAP_WC works as well. This opens the question: which type is
more correct? I have no deep understanding in QCOM internals so it is
hard to me to answer this question.

--=20
WBR, Volodymyr=

