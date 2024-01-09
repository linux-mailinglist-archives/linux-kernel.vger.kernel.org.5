Return-Path: <linux-kernel+bounces-21274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B63F9828CE0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D10B11C24E82
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFD53D384;
	Tue,  9 Jan 2024 18:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P2NSDdPV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6773D0CA;
	Tue,  9 Jan 2024 18:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409HbdIJ019425;
	Tue, 9 Jan 2024 18:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=WCWpu2RIhrOq6HplpMQL7
	vEfslhi3o20Rz7+Rge3pHo=; b=P2NSDdPVg058BEoGfmLI8MdOdrIcASLB6QcW+
	3Dc8drwI0oDBt2rnWtAWr92oHNRG2pp1GM0Xgo8kfEFr5/BmS6LZ56ZVMfnJrIEE
	9cJ1GoKEz4K4v39n2Izx52H9QhMhvtX+dTP1PaJ/JRpazsIR1tmOCCLidL7m1wfd
	TnvdbZXJwtWoYaOikZum+AQw/erbV2LCeJke1RixBGoSFHG0QGqK9Zalu75Bbsbc
	BOy/Ozns+c8ki0e8Q5lMefhfqHrow8Qh0S+LdbWnZZbwnc1FeC4M24EPz+47oFCn
	e5qumkSyxuzYw742fXAkbPUPpYp2umimds8AzlJ1JTv5z6zMQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh9ta09yf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 18:43:26 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409IhPdF001740
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 18:43:25 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 10:43:24 -0800
Date: Tue, 9 Jan 2024 10:43:23 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>
CC: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-mtd@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tingweiz@quicinc.com>
Subject: Re: [PATCH] dt-bindings: mtd: Change the schema for nodename which
 includes "sram"
Message-ID: <20240109184323.GA24189@hu-bjorande-lv.qualcomm.com>
References: <1704367382-29979-1-git-send-email-quic_zhenhuah@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1704367382-29979-1-git-send-email-quic_zhenhuah@quicinc.com>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: D3jd0Yer2swtBYyNa5sjn2eqUEtYhwU9
X-Proofpoint-ORIG-GUID: D3jd0Yer2swtBYyNa5sjn2eqUEtYhwU9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1011
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090151

On Thu, Jan 04, 2024 at 07:23:02PM +0800, Zhenhua Huang wrote:
> Node name which includes "sram" not only represents MTD devices, but also
> lots of sram devices(eg, qcom,imem.yaml, rules in folder sram/*).
> 
> To avoid the conflicts, change the schema as:
>  - if node name includes "sram", must select "compatible" to match
> (I have listed all "comptible" string in mtd.yaml by searching
> drivers/mtd/* to find applicable drivers)
>  - if node name is nand/flash, use "nodename" to select.
> 

You're right, it doesn't seem appropriate for the mtd binding to be
selected for nodes intended to match e.g. the qcom,imem binding.

> Fixes: 7bdc671822e9 ("dt-bindings: mtd: physmap: Reuse the generic definitions")
> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> ---
> Hello,
> 
> Tested a few devicetree nodes, which confirms:
> "qcom,imem.yaml" which in sram/ not matches with mtd.yaml anymore.
> All nodes include string "sram" must have "compatible" which listed in
> mtd.yaml to be matched.
> 
> Current I just modify the rule for "sram" as it is definitely conflicting with
> rules in sram/*. I have not much backgrounds on nand/flash whether they may have
> similar conflicts.
> 
>  Documentation/devicetree/bindings/mtd/mtd.yaml | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/mtd.yaml b/Documentation/devicetree/bindings/mtd/mtd.yaml
> index f322290..1704437 100644
> --- a/Documentation/devicetree/bindings/mtd/mtd.yaml
> +++ b/Documentation/devicetree/bindings/mtd/mtd.yaml
> @@ -10,10 +10,28 @@ maintainers:
>    - Miquel Raynal <miquel.raynal@bootlin.com>
>    - Richard Weinberger <richard@nod.at>
>  
> -properties:
> -  $nodename:

The mtd binding is $ref'ed by other bindings, similar to how we do with
other bindings of common properties.

So, I think the problem with mtd is that this ($nodename) turns into a
"select" automatically, which causes this binding to match nodes by
name, rather than just those $ref'ing it.


We should be able to avoid the automatically created select from the
$nodename, and rely on $ref, by just adding:

select: false

Regards,
Bjorn

> -    pattern: "^(flash|.*sram|nand)(@.*)?$"
> +select:
> +  if:
> +    properties:
> +      $nodename:
> +        pattern: "^.*sram(@.*)?$"
> +  then:
> +    properties:
> +      compatible:
> +        enum:
> +          - arm,vexpress-psram
> +          - cypress,cy7c1019dv33-10zsxi
> +          - microchip,48l640
> +          - mtd-ram
> +  else:
> +    properties:
> +      $nodename:
> +        pattern: "^(flash|nand)(@.*)?$"
>  
> +  required:
> +    - $nodename
> +
> +properties:
>    label:
>      description:
>        User-defined MTD device name. Can be used to assign user friendly
> -- 
> 2.7.4
> 

