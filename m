Return-Path: <linux-kernel+bounces-30994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D035083273B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D331F239E7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4702F3C47A;
	Fri, 19 Jan 2024 10:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fSJYvA/a"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306E5944F;
	Fri, 19 Jan 2024 10:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705658752; cv=none; b=JR1S+gjTu9ZwLa0o6xzICA1+8+TQCt6zVRumlfXGLo9xLSAYPFAK93u4yruCJOoC3ye7ZjMvc8Ju4833lFz8vWoUM5Xjr/MPVj3tthZMsaD4+GP3quWile8ybxUnvoBfdgLC+MG0B33QSEN93X+uCqQHYfpiy59wRMhkhIuzb2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705658752; c=relaxed/simple;
	bh=u8p9mCUVfkz0WU9cO8UB76nso42+7Zw/S0jK9+Wpv3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=idyIJ9M+sTV48+mI7nFQMcR4tlA+96vYLY7s5NsIqphBqtYdloL+NjhrSP1dXkGGuMp6xIOS/IMiapk4nzgjg3zqR0MDb0HIk04K0LqO0LSrCFhM4R+nOv3q/TNySfYqs5cyE8IBx1uC0olYXeb/FKmIX4Yu3/umiRK7iaIWgD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fSJYvA/a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40J9tOFD003598;
	Fri, 19 Jan 2024 10:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=KRVA1UuE/kzOpSKsLsQz6w/DMtoThu8NzoYWjfs0PFw=; b=fS
	JYvA/aIT7ZSkxMz9tWYq2Ij+OAgi1KL8QTmWb5Y3M46oim2GW1cfTI1q/3vpahOP
	smnDNWZU2+jlg4oYnV7QdhWT/59V776dy2TqrTQyXrkU6OumlhNX2TC2Z2DmKKrK
	R1quiNbfFgtJI7Br36Enrcm7XHf87Kcu3LXycCmNx2po9j6/IItikyaD3/vTzUbY
	OfNgvATiJGgdohuajPWz4e5YDScqw2ZRLAr65k6U0s2A3LxjF3DfRClqN+QKatTc
	d+/UwP3DAfW1W89rPy3ezno0b472npV3QTCcXz5LCQuN24XahNYMZDfcVIa+CFQZ
	64Z8IlTnOQwIw184vlZg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vq6uba2jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 10:05:29 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40JA5Rs5003868
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 10:05:28 GMT
Received: from [10.214.66.253] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 19 Jan
 2024 02:05:21 -0800
Message-ID: <c091e857-9bdd-4114-947f-afa7b1206de8@quicinc.com>
Date: Fri, 19 Jan 2024 15:35:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/5] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <joro@8bytes.org>,
        <dmitry.baryshkov@linaro.org>, <jsnitsel@redhat.com>,
        <quic_bjorande@quicinc.com>, <mani@kernel.org>,
        <quic_eberman@quicinc.com>, <robdclark@chromium.org>,
        <u.kleine-koenig@pengutronix.de>, <robh@kernel.org>,
        <vladimir.oltean@nxp.com>, <quic_pkondeti@quicinc.com>,
        <quic_molvera@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20240116150411.23876-1-quic_bibekkum@quicinc.com>
 <20240116150411.23876-4-quic_bibekkum@quicinc.com>
 <f25b7a0d-28b7-428f-a88f-2ceecc208f85@linaro.org>
Content-Language: en-US
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <f25b7a0d-28b7-428f-a88f-2ceecc208f85@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5_WUllb4VAkzDADCg50QtQu2C5YizFyf
X-Proofpoint-GUID: 5_WUllb4VAkzDADCg50QtQu2C5YizFyf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 clxscore=1015 adultscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401190044



On 1/18/2024 11:25 PM, Konrad Dybcio wrote:
> 
> 
> On 1/16/24 16:04, Bibek Kumar Patro wrote:
>> Currently in Qualcomm  SoCs the default prefetch is set to 1 which allows
>> the TLB to fetch just the next page table. MMU-500 features ACTLR
>> register which is implementation defined and is used for Qualcomm SoCs
>> to have a custom prefetch setting enabling TLB to prefetch the next set
>> of page tables accordingly allowing for faster translations.
>>
>> ACTLR value is unique for each SMR (Stream matching register) and stored
>> in a pre-populated table. This value is set to the register during
>> context bank initialisation.
>>
>> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Since it's your idea with Dmitry's review suggestions, I don't think
> this tag makes sense.
> 
> It's normally used for situations like:
> 
> Colleague X: "Hey Bibek, I noticed x broke on y, can you fix it?"
> "Sure!" <proceeds to make a commit with suggested-by Colleague X>
> 

Got it, thanks for the inputs. Will remove this tag as it won't make 
sense in this case as explained by you.

> Just a nit below:
> 
>> +struct actlr_config {
>> +    u16 sid;
>> +    u16 mask;
>> +    u32 actlr;
>> +};
> 
> This, can go here, in the header:
> 

Sure, Noted. Will add this to the header.
Initially made it local, since it is only being used
in the tables.

Thanks,
Bibek

>> +struct actlr_config;
>> +
>> +struct actlr_variant {
>> +    const resource_size_t io_start;
>> +    const struct actlr_config * const actlrcfg;
>> +    const size_t num_actlrcfg;
>> +};
>> +
> 
> Otherwise, this looks good!
> 
> Konrad

