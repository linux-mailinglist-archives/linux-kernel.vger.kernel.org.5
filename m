Return-Path: <linux-kernel+bounces-6584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5656A819AA4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD8A288604
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06CB1C6B1;
	Wed, 20 Dec 2023 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NLpG2VwD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996BB1D69A;
	Wed, 20 Dec 2023 08:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK6F3W2023046;
	Wed, 20 Dec 2023 08:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Y62vHsky7woaZ4yIiuprCQtDCr+efrl5WiKH4aMYlQ0=; b=NL
	pG2VwD29daXVHlJq65x2nteFn0AOOrQbh9W/bNf91SIE/6s/NM4QwIGj6dmzmAxV
	+07F9BJJFqvc5dTt/RWwYcvqKP0htznMiyFM2ZTIi9mIFh3RPC0IJHFK5Q978Ca/
	5P2LwyoO/M6ioiTK+4H1S93qbB/W94m83arIUFIIr9zZNvxOjRnBOl4lacaDr7zW
	roknz2dEiDV1z8e/j1pb9lWGIbR7GrgrrK9nAAW4Fd5JBJPNstC2jZHi2ZfLTV6W
	E3T1X7SaXHSQWPu7H11+jv8wy5g1MgYXbNvbsfRU5Mr1NXqJvhjcYXF31zZeq0ND
	ddGG8t50OJpUsGCxiwjA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3fa3hpbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:37:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BK8bisJ006908
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:37:44 GMT
Received: from [10.216.36.155] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 00:37:40 -0800
Message-ID: <d3dfefbe-0aee-4b4a-ac5c-32db29d691c9@quicinc.com>
Date: Wed, 20 Dec 2023 14:07:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 17/34] media: iris: implement vb2_ops queue setup
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stanimir.k.varbanov@gmail.com>,
        <quic_vgarodia@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <mchehab@kernel.org>,
        <bryan.odonoghue@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <quic_abhinavk@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <1702899149-21321-18-git-send-email-quic_dikshita@quicinc.com>
 <cb2a921c-5c8e-44c8-af1d-78d877977b62@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <cb2a921c-5c8e-44c8-af1d-78d877977b62@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: n_XTXsBR4L6G0SE1wabPyaMIIeCi4Cj5
X-Proofpoint-ORIG-GUID: n_XTXsBR4L6G0SE1wabPyaMIIeCi4Cj5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=787 impostorscore=0
 clxscore=1015 adultscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312200059



On 12/19/2023 5:26 PM, Konrad Dybcio wrote:
> On 18.12.2023 12:32, Dikshita Agarwal wrote:
>> Implement queue_setup vb2_ops.
>> Calculate the buffer count and buffer size as par video
>> hardware requirement and updates to client.
>> Also, allocate the video driver buffers for output and
>> capture plane.
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> ---
> [...]
> 
>> +static int input_min_count(struct iris_inst *inst)
>> +{
>> +	return MIN_BUFFERS;
>> +}
> Why is this a function?
> 
Some extra checks will be performed to calculate the input buffers for
encoder, hence it was made a function. May be I can directly use the macro
at this point and introduce the function later in the patch with encoder
patches.
>> +
>> +static int output_min_count(struct iris_inst *inst)
>> +{
>> +	int output_min_count;
>> +
>> +	switch (inst->codec) {
>> +	case H264:
>> +	case HEVC:
>> +		output_min_count = 4;
>> +		break;
>> +	case VP9:
>> +		output_min_count = 9;
>> +		break;
>> +	default:
>> +		output_min_count = 4;
>> +		break;
>> +	}
> 
> switch (inst->codec) {
> case VP9:
> 	return 9;
> case H264:
> case HEVC:
> default:
> 	return 4;
> }
> 
Right, this is better, will make the change.
>> +
>> +	return output_min_count;
>> +}
>> +
>> +int iris_get_buf_min_count(struct iris_inst *inst,
>> +			   enum iris_buffer_type buffer_type)
>> +{
>> +	switch (buffer_type) {
>> +	case BUF_INPUT:
>> +		return input_min_count(inst);
>> +	case BUF_OUTPUT:
>> +		return output_min_count(inst);
>> +	default:
>> +		return 0;
>> +	}
>> +}
>> +
>> +static u32 input_buffer_size(struct iris_inst *inst)
>> +{
>> +	u32 base_res_mbs = NUM_MBS_4k;
>> +	u32 frame_size, num_mbs;
>> +	struct v4l2_format *f;
>> +	u32 div_factor = 1;
>> +	u32 codec;
>> +
>> +	f = inst->fmt_src;
>> +	codec = f->fmt.pix_mp.pixelformat;
>> +
>> +	num_mbs = get_mbpf(inst);
>> +	if (num_mbs > NUM_MBS_4k) {
>> +		div_factor = 4;
>> +		base_res_mbs = inst->cap[MBPF].value;
>> +	} else {
>> +		base_res_mbs = NUM_MBS_4k;
>> +		if (codec == V4L2_PIX_FMT_VP9)
>> +			div_factor = 1;
>> +		else
>> +			div_factor = 2;
>> +	}
>> +
>> +	frame_size = base_res_mbs * MB_IN_PIXEL * 3 / 2 / div_factor;
> that's a bit magic..
> 
This is the formula to calculate video frame size, no magic here :)
>> +
>> +	 /* multiply by 10/8 (1.25) to get size for 10 bit case */
> misaligned
> 
Oh! wasn't caught by check-patch.
Thanks for pointing this, Will fix.
> 
> Konrad

