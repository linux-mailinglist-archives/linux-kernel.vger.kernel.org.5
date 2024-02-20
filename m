Return-Path: <linux-kernel+bounces-72792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AAB85B8B4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 374AD284E02
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA3D612E7;
	Tue, 20 Feb 2024 10:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nv9a/AUQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD8B41A80;
	Tue, 20 Feb 2024 10:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423905; cv=none; b=mMDMYfgj0gRvtxloqcAe2fgHqbncKH+YDBeF3PeZzultoCKoABRlVqsaL60rBBIo8A4JiuhgAS2qRvg3XMlA5wYrHf2vLiEie0/RsctfiUuqNdj1wJe2agFH5FewF2bnQrs/odjOj/cWiykDMcllINAK3QLS4p67f1UTd4Df+x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423905; c=relaxed/simple;
	bh=4fR3RvvX25uhwy7hcoCiq63kjKy7ETnyYtzhSQgIwQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZEdsG9OoxgVcMmumy3df6cnLoScDkyZRyAC7URhSHpMtBN7Tp+Aa3AGZpR3hr7Pi8TS0UXnG7I3xW8Jxl/lNgxpKRR/RPJxvWY4HZ0E1eyneoiFcLvzbwFXUgRWK4b2xbf5d/3XsebBHEotB2bye3rWdDonwCS8+ySGa/kiUxd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nv9a/AUQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41K4Nw9V004019;
	Tue, 20 Feb 2024 10:11:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=/kGHPCXOUhT1b+kLQoJcMoS7pcHpOsfun4Cr9Uh9Xmc=; b=nv
	9a/AUQMvRnn255bi9Vv8Kft8pJ0XEWtaut5o5HED/dgsOoy6s1pmTwLTA1OMK0HM
	mnboG9RjEdyi31S8i61SCiZhVzIhIUYyW2G0jmjKbP0Io/2oUBM702zPdMYk/z0x
	Vyr2xxv5UFsSsTZXUWIPNnOaYDDlRdADChIswDhJrl7A8xRjELjBeL7U0XvdTVma
	iH4WLq67VktgXYXnP9UbLpbuPyERnJm7jxqK2akbjjZRrMOJ1IZ0jvL4rUdYRLFf
	CzUWcDJ1a5lhM25B7v38uE3r4wfJzvED3JUXy6WyJnUuZAuKA2a8Hrr6Fzi84Bis
	s8v67IWIoepGE8zgmJ9A==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wcn15rmu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 10:11:32 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41KABWho015374
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 10:11:32 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 02:11:29 -0800
Message-ID: <b56c871e-619b-f8bb-f149-fb9b22f8a79d@quicinc.com>
Date: Tue, 20 Feb 2024 15:41:26 +0530
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
To: Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij
	<linus.walleij@linaro.org>
CC: Mark Brown <broonie@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
References: <1704727654-13999-1-git-send-email-quic_mojha@quicinc.com>
 <1704727654-13999-2-git-send-email-quic_mojha@quicinc.com>
 <CACRpkdY7fbFyNNd6GAikxC3+wk0ca8Yn_8__zkp+Q-deJeJ_LQ@mail.gmail.com>
 <3a17f36a-04bf-04f2-7a22-82b76977b325@quicinc.com>
 <CACRpkdbnj3W3k=snTx3iadHWU+RNv9GY4B3O4K0hu8TY+DrK=Q@mail.gmail.com>
 <6lmxlfopjzxbvn5oe6uha2ppdjderuymgq3h3gz2suyb5i2vs6@mpadw4b37s5t>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <6lmxlfopjzxbvn5oe6uha2ppdjderuymgq3h3gz2suyb5i2vs6@mpadw4b37s5t>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: D3SoTYIZC-4s_saOcdRgFyLJ_gHyZYy9
X-Proofpoint-GUID: D3SoTYIZC-4s_saOcdRgFyLJ_gHyZYy9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402200071



On 2/17/2024 12:01 AM, Bjorn Andersson wrote:
> On Tue, Jan 09, 2024 at 02:34:10PM +0100, Linus Walleij wrote:
>> On Tue, Jan 9, 2024 at 2:24 PM Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>>> On 1/9/2024 6:44 PM, Linus Walleij wrote:
>>>> On Mon, Jan 8, 2024 at 4:28 PM Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>>>>
>>>>> It was realized by Srinivas K. that there is a need of
>>>>> read-modify-write scm exported function so that it can
>>>>> be used by multiple clients.
>>>>>
>>>>> Let's introduce qcom_scm_io_rmw() which masks out the bits
>>>>> and write the passed value to that bit-offset.
>>>> (...)
>>>>> +int qcom_scm_io_rmw(phys_addr_t addr, unsigned int mask, unsigned int val)
>>>>> +{
>>>>> +       unsigned int old, new;
>>>>> +       int ret;
>>>>> +
>>>>> +       if (!__scm)
>>>>> +               return -EINVAL;
>>>>> +
>>>>> +       spin_lock(&__scm->lock);
>>>>> +       ret = qcom_scm_io_readl(addr, &old);
>>>>> +       if (ret)
>>>>> +               goto unlock;
>>>>> +
>>>>> +       new = (old & ~mask) | (val & mask);
>>>>> +
>>>>> +       ret = qcom_scm_io_writel(addr, new);
>>>>> +unlock:
>>>>> +       spin_unlock(&__scm->lock);
>>>>> +       return ret;
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(qcom_scm_io_rmw);
>>>>
>>>> This looks a lot like you are starting to re-invent regmaps
>>>> regmap_update_bits().
>>>>
>>>> If you are starting to realize you need more and more of
>>>> regmap, why not use regmap and its functions?
>>>
>>> I think, this discussion has happened already ..
>>>
>>> https://lore.kernel.org/lkml/CACRpkdb95V5GC81w8fiuLfx_V1DtWYpO33FOfMnArpJeC9SDQA@mail.gmail.com/
>>
>> That discussion ended with:
>>
>> [Bjorn]
>>> We'd still need qcom_scm_io_readl() and qcom_scm_io_writel() exported to
>>> implement the new custom regmap implementation - and the struct
>>> regmap_config needed in just pinctrl-msm alone would be larger than the
>>> one function it replaces.
>>
>> When you add more and more accessors the premise starts to
>> change, and it becomes more and more of a reimplementation.
>>
>> It may be time to actually fix this.
>>
> 
> Thought I had replied to this already, did we discuss this previously as
> well?
> 
> My concern with expressing this as a regmap is that from the provider's
> point of view, the regmap would span the entire 32-bit address space.
> I'm guessing that there's something on the other side limiting what
> subregions are actually accessible for each platform/firmware
> configuration, but I'm not convinced that regmap a good abstraction...

To add more to it, in current series, we are just accessing single 
register for read/write and using regmap for this looks overkill to
me.

-Mukesh
> 
> Regards,
> Bjorn
> 
>> Yours,
>> Linus Walleij

