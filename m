Return-Path: <linux-kernel+bounces-20891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3C3828701
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 925221C2437C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DD338FA1;
	Tue,  9 Jan 2024 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QESw8Fi5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5A438F8A;
	Tue,  9 Jan 2024 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409D8x8k007881;
	Tue, 9 Jan 2024 13:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=7glfnnpCpN5mrx64ygsoXAEGUKHpeaPmhuGLsawq5uw=; b=QE
	Sw8Fi53wlD/vsiBNmC3EYjXp9o4cs3m0S17RnrVytrvBfERNdpCmWUfZvnCXgBX9
	Q1GN1Jhk2lhoztALIBoqUW7wHXgiXQ8J4VMeaAzB3ULiBuMFHUZOh88l96t2SnTu
	TmoXJDAWbxwcra5olfVh0B4poKut1jss3BD+eT5stgPzW5qm5hXwIEV4N5xogdog
	rty5c+4/y8x+1m0Fg+yIqpeEhrOKbhQ0FDyPCdbQ0sHIIFPI/2sWNeRhvwpEPXM7
	4IMGNeAyQ4ars+xgLMSD7eNyfHl8hFDGDeoKd472JuS5tZkvDBcSddFVNA4yQ409
	NnTLNB5y16JfM3wSSS+w==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh234gkuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 13:24:30 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409DOTKN013306
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 13:24:29 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 9 Jan
 2024 05:24:27 -0800
Message-ID: <3a17f36a-04bf-04f2-7a22-82b76977b325@quicinc.com>
Date: Tue, 9 Jan 2024 18:54:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v11 1/4] firmware: qcom: scm: provide a read-modify-write
 function
Content-Language: en-US
To: Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
References: <1704727654-13999-1-git-send-email-quic_mojha@quicinc.com>
 <1704727654-13999-2-git-send-email-quic_mojha@quicinc.com>
 <CACRpkdY7fbFyNNd6GAikxC3+wk0ca8Yn_8__zkp+Q-deJeJ_LQ@mail.gmail.com>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <CACRpkdY7fbFyNNd6GAikxC3+wk0ca8Yn_8__zkp+Q-deJeJ_LQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7NBQlC_FIUtPqOrbYbh0Dz26UGPIzPi6
X-Proofpoint-GUID: 7NBQlC_FIUtPqOrbYbh0Dz26UGPIzPi6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=608 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401090110



On 1/9/2024 6:44 PM, Linus Walleij wrote:
> On Mon, Jan 8, 2024 at 4:28 PM Mukesh Ojha <quic_mojha@quicinc.com> wrote:
> 
>> It was realized by Srinivas K. that there is a need of
>> read-modify-write scm exported function so that it can
>> be used by multiple clients.
>>
>> Let's introduce qcom_scm_io_rmw() which masks out the bits
>> and write the passed value to that bit-offset.
> (...)
>> +int qcom_scm_io_rmw(phys_addr_t addr, unsigned int mask, unsigned int val)
>> +{
>> +       unsigned int old, new;
>> +       int ret;
>> +
>> +       if (!__scm)
>> +               return -EINVAL;
>> +
>> +       spin_lock(&__scm->lock);
>> +       ret = qcom_scm_io_readl(addr, &old);
>> +       if (ret)
>> +               goto unlock;
>> +
>> +       new = (old & ~mask) | (val & mask);
>> +
>> +       ret = qcom_scm_io_writel(addr, new);
>> +unlock:
>> +       spin_unlock(&__scm->lock);
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(qcom_scm_io_rmw);
> 
> This looks a lot like you are starting to re-invent regmaps
> regmap_update_bits().
> 
> If you are starting to realize you need more and more of
> regmap, why not use regmap and its functions?

I think, this discussion has happened already ..

https://lore.kernel.org/lkml/CACRpkdb95V5GC81w8fiuLfx_V1DtWYpO33FOfMnArpJeC9SDQA@mail.gmail.com/

-Mukesh

> 
> Yours,
> Linus Walleij

