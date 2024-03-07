Return-Path: <linux-kernel+bounces-95580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54476874FBB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09167281FE1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A9612C54C;
	Thu,  7 Mar 2024 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b="rqU/cjUA"
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C328312BF12;
	Thu,  7 Mar 2024 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.137.242
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709817232; cv=fail; b=KLHc+CLv99bSDPRGsVvWCuCUnUeNZbD5BZ3cOAMVsr57Y2c7bdNX1E1Ruvow1wgsc4BHyCoFaqqjUS6tfFeUhCoef40iMKglNXH+Ug2lfEsFHdfFzOVXNT8/nc7XoKbT2RjJbaxL7QjrBc/qgImESkKMkzAdjq7tN7n7mBdFkzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709817232; c=relaxed/simple;
	bh=nUKU92xbc789bgeZYx3o8OO8kJINP7D8VSwITwI2m3c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tIODESGbPQTglWvMBtMma0gLkYYzAfBp9c4IiLNXbcAhO5vDwdDyBX0vsNNqK07W4c8OKBvzJ4RyrxPaDzZVyrBqAy54VI5lbBtG/Xm9qamwWD65uxlTVA61Ke0vA76w9lDR8Cut8Rjs06jBwZJJTzjNL0jsIkuWg+uuhJh6aGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epam.com; spf=pass smtp.mailfrom=epam.com; dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b=rqU/cjUA; arc=fail smtp.client-ip=148.163.137.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epam.com
Received: from pps.filterd (m0174682.ppops.net [127.0.0.1])
	by mx0b-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 427AE6d9029822;
	Thu, 7 Mar 2024 13:13:46 GMT
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169])
	by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3wqbnagudn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 13:13:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REa4ya79voNF0+SArJnMTka6TQpOTTO2Pe1TEmeGkBQL4JNjVtq0wnFy0UX1/8DKy9kTdE8NrkDwuX5RbHyDG0D+CbToaQbF3optl4gDeTmHirMllrhLJ5izcEeffN65MgF+I2nPa49MiLlXfwajfgug6VXN5mNrzO2JUbHRCzVJr1m/khZNZgGn4NckwOHapgxGEqJmVjms7PXJANGodiAG5RQmIFEuOXjHy4m0JSBmGuaq2c2hIg0FuyUdSgBPbG6Lhy10GTCZ1CkT/rVWqy9/jfWksgdu2mGb0uKxNTXKecB2QaDQQQu+bD9RH1kvYVAMUQ1ocQ9dlGlfzSnwbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MllKiFgFm0caqpqHfJzwWIxzGMrFrLVMsgCvhzEn1FE=;
 b=Um/uHORph0PEOhjI7xFnyJIBpzFu3Krc1cwvT7PiYUFsGeKs/+YqbzExWD6sPvnlGmWuQQWOPyX/zzj7vcGt9Ctdia1m0Hp17lHNelT++DqYuDEdmz+CbNk99l6icTb/ud/crig6Y08WHZXBQk5rJbP1xsSKgRqdpUYirc5fQnWgtGHLP+USIHFQSli1fB/TxEz2dC9AI0Sd/UUF469ZadoeDruG9LCqDRRo6nOhFOn6N25Xs4o2Yfr63P/5upVtAOYv5D/TG20KCfmb08DHo9CKD5LBcxVDlv3jlp6oRqnvxyWcvHZUzohAQ8yYRTSNRcLlJxCz9P9ZTGcYJVfi+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MllKiFgFm0caqpqHfJzwWIxzGMrFrLVMsgCvhzEn1FE=;
 b=rqU/cjUAnsysGERw3RGbkR61r0Q5W7BzsnvKHOBKGFAkW3Oq7/DW/4wTrqEYE3MWsv4kl2EMIqbIcs84IGSKFh4ze0kpMOFihpzZcS5NFKNGGB8naNQJBwvgIJFWWy4HFtAV5I4caODrisqiJNNO41sQ4qJ515ENe3YIAVBWKbPUcRhhzWrUTfuAR4KQblEgjEJXu7v99XBVX2mtl4c2Vk9mRIDZr+DrLc59dpj4OXiD0qkABkJIXaAhgimn5/qyxjmdRETJf0xe509DDwSKWXCoHkciuSYk0E6aO6p8LAwTolijQE2GX3gGO+q2+ii4qWWQGvaBTTST1ngW6soYug==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by DB9PR03MB9709.eurprd03.prod.outlook.com
 (2603:10a6:10:459::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Thu, 7 Mar
 2024 13:13:43 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8%4]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 13:13:43 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: Sumit Garg <sumit.garg@linaro.org>
CC: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
Subject: Re: [PATCH] arm64: dts: qcom: sm8150: add reset name for ethernet
 node
Thread-Topic: [PATCH] arm64: dts: qcom: sm8150: add reset name for ethernet
 node
Thread-Index: AQHacAItveF3myb2TEeE2+qqsjF4PLEr3OyAgAAGdQCAAFwwgA==
Date: Thu, 7 Mar 2024 13:13:43 +0000
Message-ID: <87le6u18xl.fsf@epam.com>
References: <20240306200910.2732835-1-volodymyr_babchuk@epam.com>
 <CAA8EJppNopEF0DmgjCAJyxe8HRebD26Q8heKKLKbPstdfBOv6A@mail.gmail.com>
 <CAFA6WYMvtNbAMb5bAuH=as01wxACbjs5XcyPrvcSH4YpGGHhpA@mail.gmail.com>
In-Reply-To: 
 <CAFA6WYMvtNbAMb5bAuH=as01wxACbjs5XcyPrvcSH4YpGGHhpA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: mu4e 1.10.7; emacs 29.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|DB9PR03MB9709:EE_
x-ms-office365-filtering-correlation-id: e13cb3e0-faaa-494c-1c21-08dc3ea869ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 a9NjTQeVSvVGZ6tkI/HLh8mkGEWIbUuTS17eWZPTwksoKL6QLnW50/Psbljn3gtv5Lk1p+fYpNInY2aujISJ2wO/1RL0u9jsaZPyMkP9QXtlqNtFTDjGxPziVmKBWhjk4dmG8aaIWCMrENRC+h/3UUe8x0tcg34XmGSYH5miweyhwwhO0Z5Gf2lNDFe10VkPVL9CPrQi0cmI7B4YsdBLrgeuUpUrxkc6bdcD4rLyQBmUycRo/MNmmWgEJMDS6HnA2susNU5PdzPp0LEyR9z3Hp2uUahM7HTvsevm3z45ArBRGiktodb0wthd/cotM57s2OQJsqESDMCZcQGkyi1JVkFahCAQ2UvG6p3Z4x/p9bnj1mZvYvffJAfozsd2M2d4Jmv5U1pXWbk6P1sH2SCJ/3+en2jv3zs8pwKF/KmGdPhWIqRqWCUhSjetj+59Sw7fgFcCbWtGlKKlNJje8Kdqx5ap6hKvI7FqasYaDiw0aP+nhppZKXJpPw5XnXPxLKWNciVd2MSA+7JysME/hz/wvHyfk8XbKr/5p4kHJQ6NEgEWwXwANRUmRyFvbBlECXgS6df0dYNL/yJEZI5/jrtXvm7wnBHZRKVK2VPIvoxRYETvYB6ZZmSFV67E7F2wHC7pULkTwZqvAfjkPsOmSGZ30QCY9oa8FCrZhIdCrWP1RkSqG6yPThmV3ijh/O3h+hSQPcWYVYiVIz+reaQmH88Vy34bNlepn+zmz9MsX6jZe4s=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR03MB10456.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?wwgNS/+Epnop6yIbsFqbP1GgnSBWbqBR8Pn/R+2Pb6xBShLJZxyQSdQi9X?=
 =?iso-8859-1?Q?2DRVQhwR9LcHFiIR7vQylyOmXPipyUd5AdrIEOCPhbgoTU73K2zloTou6F?=
 =?iso-8859-1?Q?kNbHnvnHTsaaJ/QNU1v9SHZVAqVUQSy/uHnF3maIKqmbJ9kzc0R522d0Uu?=
 =?iso-8859-1?Q?mDd2FUc8ZU9bBmKRS4/vNksktvySx8Jblf7U7p5Px+VZqqwkfMixFCa6vR?=
 =?iso-8859-1?Q?k1+eQTQNETJG9pTf2vYXwnoMNVEZZHqkwR+1LmrEAdjdyEF2hdpvLYNlvp?=
 =?iso-8859-1?Q?eh9HFZZrlfTj2aPnMFoa0BseEkbpTfeOJPBS08wWhsXd3O34yj98pl6nlx?=
 =?iso-8859-1?Q?jZtLZ2hSlvngp920SN28iZAI+KREnbSpCOzbyefS8gioLEIkAJ4f5i4g5R?=
 =?iso-8859-1?Q?sPwgKVplcBmIkI6bSqQ1S0AtsRlce70I7cN94MZUnmtxusrcpXwCmWQ4mO?=
 =?iso-8859-1?Q?WKhJ0izysP1kuiIk/MnLcXiQxdW6p1mJqqAWo+FHY9PU9wn8ld2Xjm7fRC?=
 =?iso-8859-1?Q?yFFTlx/XycKfNwkc/AdGFnMeCfTFVeb0CmO9S/Y/W/c8sLDGb/nt5aXqMp?=
 =?iso-8859-1?Q?1U0KdsKr2KM9BGJcA7VyFPEthm87RufYEWqhJBaw7SnHq2nuWFh6H+d7AO?=
 =?iso-8859-1?Q?LukD+Z9hCNRCxUdaAwsNdLpnboTdxZgjljrI6V8elTl/+w2RlyBA0371+1?=
 =?iso-8859-1?Q?rUrQsM8+hqB7hzsk4oVVAGQ+h7zANW/hxbD9iOem4kI898RbAdHUDJ57Ja?=
 =?iso-8859-1?Q?eBd40elMCFhJBlnTD4BriFPqqu+TD2K8+wSPw1+qzr6g0l5RGgLiEry+P0?=
 =?iso-8859-1?Q?LZBT0A6rJwv0Lyz5xL6QfrIxQ7WPpZB9l5BiOUhEhDS5z19jXjcczDOO01?=
 =?iso-8859-1?Q?AFF2EW+3HPTSDydpZaIQq8/umkBS/+ShevVGNypx1+1awRA3DuFcaLH+MF?=
 =?iso-8859-1?Q?PQu2+5fZ3UchkJrJgX18fJupVXQqTJ34pMTPAqtXhwBxhJ6Yz8lloRv+Iq?=
 =?iso-8859-1?Q?gq+FXyDVoLDf2+3Uzj0HcmOmMJSJEDcsK0YYu51PzqFTbTIaC4oeaKWRXt?=
 =?iso-8859-1?Q?IuEhzXKxSqKaowIVSQZnySio9UGgoUh48+/KbNqE4sXoNrYv3ML5I13Stg?=
 =?iso-8859-1?Q?+qATYbwv8vXwLEGrV5VKZ/e8Q7yOBWsP3GGemLJi5UegLklmAC10tVtVOb?=
 =?iso-8859-1?Q?3KLlRHyfhcn1cDzNAkivUde6EIzyYp+YXVmUBP57AXq0+tgsfwHN121m1q?=
 =?iso-8859-1?Q?NzJBZtOoAkp+UlrOD0lvhbMXSKRz1quNKmBt545jEqByU7t/cNYUm0MCvc?=
 =?iso-8859-1?Q?QJvF7AbyPOECLNhxujW+ZkCSLptRiKOZV1Vl0tWiMpP5a6MbNQqQ5BkJo1?=
 =?iso-8859-1?Q?iE6ijhYQ9NnK0YrkKTsqWgsiYKuHCb/cwZjg+ZmPody6S3SOBwqmg/s+t4?=
 =?iso-8859-1?Q?ZAkHx5QCzDI5/GUEDB3Pdhj4ReuTvm54hXMl0s0rPGLAuQ9XUzrmVP7XZG?=
 =?iso-8859-1?Q?HdC9huwrDiJaWeWqpcFq/BYjiWFTtRECdpGhgQdCLFfJwyccbNC911eBzh?=
 =?iso-8859-1?Q?N1B8xPQfr3wHyLitmn+FjHuWRIgMCKAoMkgBgW4TJ0d8DyBIGLVSGTRpFx?=
 =?iso-8859-1?Q?sR6FfauMmGmZsRvI/DASihC2ftbBgGMzPLmqmV+EH0U2bgYIO8QRHk6A?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e13cb3e0-faaa-494c-1c21-08dc3ea869ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 13:13:43.2278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zlhedFNLifbHFvNojqbbMSYjnTlQ3fTj+NVKxCAFq8E+SLMazujyV2duWLMSd3qrrkcM2X+JHJ0H6Pa9GRV+gdH6lzRnuBBtcBKU9//PCOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB9709
X-Proofpoint-ORIG-GUID: 2rY_7ZNFnJj3ctYjR7yb2wIIvEHkdvHW
X-Proofpoint-GUID: 2rY_7ZNFnJj3ctYjR7yb2wIIvEHkdvHW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403070087


Hello Linux Maintainers, Sumit

First, I am terribly sorry about this half-assed patch. Generally I am
doing all the required checks. But this change seemed so
trivial... Anyways, lesson taken, this will not happen anymore.

Sumit Garg <sumit.garg@linaro.org> writes:

> On Thu, 7 Mar 2024 at 12:40, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
>>
>> On Thu, 7 Mar 2024 at 00:22, Volodymyr Babchuk
>> <Volodymyr_Babchuk@epam.com> wrote:
>> >
>> > Add reset-names property to the ethernet@20000 node. This patch does
>> > not change behavior on Linux, but it is needed for U-Boot, as it tries
>> > to find the reset by name, not by index.
>> >
>> > Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
>> > ---
>> >  arch/arm64/boot/dts/qcom/sm8150.dtsi | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dt=
s/qcom/sm8150.dtsi
>> > index 761a6757dc26f..c2e65d6a2ac62 100644
>> > --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
>> > +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
>> > @@ -951,6 +951,7 @@ ethernet: ethernet@20000 {
>> >
>> >                         power-domains =3D <&gcc EMAC_GDSC>;
>> >                         resets =3D <&gcc GCC_EMAC_BCR>;
>> > +                       resets-names =3D "emac";
>>
>> According to the snps,dwmac.yaml schema the "emac" is invalid here.
>> Only "stmmaceth" and / or "ahb" are permitted here.
>
> Okay, it looks like earlier the Linux kernel on Qcom SoCs always
> assumed that the EMAC reset signal is deserted by prior boot stages.
> So I suppose we can reuse "stmmaceth" here instead of "emac" with a
> corresponding change to U-Boot driver as well.

Maybe it would be better to access reset in U-Boot by index, in the
same way as linux kernel does? I am not sure that "stmmaceth" will be
correct from the semantic point of view.

As I understand, "stmmac" name is used due to historical reasons in
Linux, as this driver was introduced for STM SoC initially. But the same
IP block is being used in many different SoCs made by different vendors
and there is nothing STM-specific left in it anymore. Especially taking
into account that this IP-block was designed not by STM but by
Synopsys/DesignWare.

--=20
WBR, Volodymyr=

