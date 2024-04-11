Return-Path: <linux-kernel+bounces-140474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4018A1528
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99886289BD5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA556149C59;
	Thu, 11 Apr 2024 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="q2r76ijW"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1441426E;
	Thu, 11 Apr 2024 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712840328; cv=none; b=BxaTmH85+ElhDCGhC/VfcW+/Yr985L4wQV0z0C4vQSOfnWlac9SALMsO1rN3+n9lpCzbUiXhKTBetsJeleMQUGsnWtPDx/L1tbSUejFdLd2FIRvK0cFMcruqMC4hDiOJSWfiNE9cCJX1Ok2Ee3/KaCFB81luYlOTWraUuOErO2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712840328; c=relaxed/simple;
	bh=BfL3on5Vy64bGST9xExl/O1IdYPFsrOFPQCut2DMxUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dzFn0nW+gSxD8QzBfBll3u6QMPq4rLBgxKnL6ggaXcq3D2QA1qT80bgDyOVkI//+dVerA2GEl7o02t3VneYaav+ofDd4rTDSd7dEa3pwiYBLyOnhESNbNiJRtp3ap7logfJGhLn+/XV8B6bhbCNwPtswWNXqFhoZmVyw0bDPrQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=q2r76ijW; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43BCl6GX029833;
	Thu, 11 Apr 2024 14:58:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=SCP/OM/t7m+EjiP6PIvcvQc/MwCc6wLfedFPwnczz9U=; b=q2
	r76ijWKXtRiFqvL9fTrLv8DqwVeIzyFsQfcnygRPVNquSsWnMImP7RF0Ps/xdMq9
	c35oceeUjLaj5xx4xkWQUcGmuysFeg6tsNhsCZtbK1nGBm5lQ3LRBgJM47Obn6VG
	ZRE2xMSf3ShPfjFPpbW14/1yC3IQEzHbUC8eXBdvyAkserUy2CVOB2b9ExHzFXBT
	h8ChFm1JUi+JXk85GZnXrnrZfSEH42ekvWZk0TERvnFsyhPweKQRzoNr10Shk/KZ
	YvA/WjGZ2teNssP/8WQqfHWneUvmvtCzsTNMObyBsZ18+aPnBRIexZXQyodX25sX
	Ei9xy53M3hhBq7T1JhVw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xbfy13bq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 14:58:24 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E705D4002D;
	Thu, 11 Apr 2024 14:58:20 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0C59A214550;
	Thu, 11 Apr 2024 14:57:38 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 11 Apr
 2024 14:57:37 +0200
Message-ID: <278bccaa-edc0-4f3d-8e9e-6159d2b47394@foss.st.com>
Date: Thu, 11 Apr 2024 14:57:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: dt-bindings: media: add access-controllers to
 STM32MP25 video codecs
To: Rob Herring <robh@kernel.org>, Hugues Fruchet <hugues.fruchet@foss.st.com>
CC: Rob Herring <robh+dt@kernel.org>, <linux-media@vger.kernel.org>,
        Mauro
 Carvalho Chehab <mchehab@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20240410144222.714172-1-hugues.fruchet@foss.st.com>
 <171276671618.403884.13818480350194550959.robh@kernel.org>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <171276671618.403884.13818480350194550959.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_06,2024-04-09_01,2023-05-22_02

Hi Rob

On 4/10/24 18:31, Rob Herring wrote:
> 
> On Wed, 10 Apr 2024 16:42:22 +0200, Hugues Fruchet wrote:
>> access-controllers is an optional property that allows a peripheral to
>> refer to one or more domain access controller(s).
>>
>> Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
>> ---
>>   .../devicetree/bindings/media/st,stm32mp25-video-codec.yaml   | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/st,stm32mp25-video-codec.yaml: access-controllers: missing type definition
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240410144222.714172-1-hugues.fruchet@foss.st.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

This patch depends on STM32 firewall bus YAML which has been recently 
added in stm32-next branch. I tested it on top of stm32-next and there 
is no YAML issues (neiter dt-bindings checks nor dtbs_check). If you 
agree to ack it, I could merge it on stm32-next.

Thanks
Alex

