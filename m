Return-Path: <linux-kernel+bounces-109182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 294328815D5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BADE61F243AD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F295231;
	Wed, 20 Mar 2024 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EeA4rQl3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76A6522F;
	Wed, 20 Mar 2024 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710952905; cv=none; b=tCBfyR7UMA2x3Y2AqfP551oxrj0HkRHlzdgz16lC9mjOy/dJFl/Zw5T6otiKNLJjdB0SdMF1f8fHbjmlI8L16M4mmv6ndwV9UsOByjTS/Z3D2OvZPxmwBN0JBcz1BkKLQbGpSVnsqH8R2dkrzosSqi2FzH9mhIQ8wvyh87y7/Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710952905; c=relaxed/simple;
	bh=h9EePanYJCjU+5awKtHjb+P8VEkK1Dd+2tmFtrEfLXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SvHcxxHcCk5H50wBYv1u0vLfTAHa3Ld3SpqOK2LHFpk00KJYPLmdqwBjdy0wAi6y4o1XICtLX6K8jMfNUTwe8k6uS3HpLaoohYlV797+P323TomQqbObCOh2XcfRGc4skUiD7k+5dT2YXq3cn1mgfRbx5yEQ1n6UVBdiNSVPYnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EeA4rQl3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KEjfKT018922;
	Wed, 20 Mar 2024 16:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ZRPw8Xlah0NCXTfcYmJ5cZjvfxE3sPSCdds+KCoFvME=; b=Ee
	A4rQl3Y+IFM7lk3I2ORDmw4cT7OqFLMd6U/9irknMHMHLACf9v6XE765jOcvMmBV
	6juQp+g+k3x1mjUKeQCDrh4Ro0cFzQpV5qImLM1p3vRlzR5cccislk/+oNK3BsAT
	88NHdVrYzNxYZm6IBGOjJlyScFeSMdyZ1ZQMFfZUDR5EiIwqXtoMrEIif5JdiPMr
	+XQqQMp+OMzBz/+5F3RYC5ZFGPBdbbuaYWVOss5FsfXfDLb4e4uTceTV8Q3ToiTw
	Tc39lJrwbLY2oajvF2+qJhQAXb0DkL7B26DZyQiHe6UFhxJI+33ovbAqrfdEBAmo
	nyIyuxNLJzedWfaDoVwg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyvrms1h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 16:41:23 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KGfNRI031218
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 16:41:23 GMT
Received: from [10.251.44.126] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Mar
 2024 09:41:20 -0700
Message-ID: <2f2a8047-d885-4c65-9b07-23b79f1ca2a8@quicinc.com>
Date: Wed, 20 Mar 2024 18:41:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] media: qcom: camss: Add subdev notify support
Content-Language: en-US
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Depeng Shao
	<quic_depengs@quicinc.com>, <rfoss@kernel.org>,
        <todor.too@gmail.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mchehab@kernel.org>,
        <quic_yon@quicinc.com>
CC: <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20240320141136.26827-1-quic_depengs@quicinc.com>
 <20240320141136.26827-3-quic_depengs@quicinc.com>
 <21d2139f-8547-466a-9be1-fbeae1194869@linaro.org>
From: "Gjorgji Rosikopulos (Consultant)" <quic_grosikop@quicinc.com>
In-Reply-To: <21d2139f-8547-466a-9be1-fbeae1194869@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: g2LAgO8VsWYBj4AO1qFpgmVMj3jwzEis
X-Proofpoint-GUID: g2LAgO8VsWYBj4AO1qFpgmVMj3jwzEis
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403140001
 definitions=main-2403200133

Hi Bryan,

On 3/20/2024 6:08 PM, Bryan O'Donoghue wrote:
> On 20/03/2024 14:11, Depeng Shao wrote:
>> From: Yongsheng Li <quic_yon@quicinc.com>
>>
>> The buf done irq and register update register are moved
>> to CSID in SM8550, so but the write master configuration
>> in VFE, in case adapt existing code logic. So add buf
>> done and register related subdev event, and use the notify
>> interface in the v4l2_device structure to communicate
>> between CSID and VFE driver.
> 
> 
> Shouldn't it be possible to just have a function to write internally ?
> 
> You know the indexes of the CSID -> VFE connection.
> 
> The subdev notify is I think not the right fit for this purpose within
> our driver.
> 

<snip>

> 
> I'm really not sure I see a good reason for this.
> 
> Why can't we just define calls between vfe and csid similar to
> 
> drivers/media/platform/qcom/camss/camss-csid.c:        ret = vfe_get(vfe);


Maybe we need to rethink and redesign this part of the driver.

In the initial version when this driver was introduced the CSID was
independent device from hw perspective,
and represented as separate sub-device.

With the newer architectures CSID was part of IFE hw (handled by the VFE
sub-device in this driver)
and vfe_get was introduced, but i believe it was not an issue because
the CISD still was kind of independent.

In the patch series:
"https://lore.kernel.org/lkml/20240319173935.481-4-quic_grosikop@quicinc.com/T/"

We try to decouple CSID from VFE and remove direct dependency
introducing parent_dev_ops,
where depending of the topology and parent device (VFE in this case or
other parent in future chipsets which contain CSID)
can reuse the code.

I am not sure if introducing parent_dev_ops is right way to go but we
can discuss further and see how to extend the driver
in proper way.

Just to add i am not saying that adding direct calls to VFE is not
proper but just close the door for other sub-device contain CSID to use
the code. :-)


Regards,
~Gjorgji

> 
> ---
> bod
> 

