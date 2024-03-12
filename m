Return-Path: <linux-kernel+bounces-99904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EAD878EFD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E6981C20D98
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1503C6995C;
	Tue, 12 Mar 2024 07:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MTbYQNFe"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED756C2FD;
	Tue, 12 Mar 2024 07:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710227165; cv=none; b=CgyFAF2SGs/NooUolIk5XVN0VxBeoFxKZ6cIZvZUZCedPUVqpXLa35Oi2t3ZPsZbtMCcb74/1hGMW2GiI5ojctf35di21GoPuEmAuXXjysnSFwd1EMDPAMVBJl9V1RDJm0LaiPhORnrf9EjCe+LdTlRl1LeDGyL6wi/PadJtWc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710227165; c=relaxed/simple;
	bh=JocwIlLZjm9gCYFghV8+dAjoZOh1i8sXxt+NJb3kdU4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=f317CTnrmFq0ClQl+c2a56aZDtJCR5AqbWFYv2V7Tpgx/kEbZDRZkdukTktZ+j1ts4bZOL3IhpzrMcfdU0v1NJs17DbXyU2WIDuOhlgPdoluC/jtXNYupldPRoFmSJvvpgKE3bH31Xn7tpcFQX5XaNMVS6lSH54ZfRy89DV6Uj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MTbYQNFe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42C6Hj1p024963;
	Tue, 12 Mar 2024 07:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=wH+mvWcyy2v9McJVwf0Nnv0Qi7tO2fnY7lw9wytsMe8=; b=MT
	bYQNFeeRbZp+eh+OiG1mTRIpRJ6Kryc0pXGcHaKOcJH2gzFwraAjC8cz6repyNs4
	YF1zx2a9ee0nGep5lIMPHulz8G0qVZ8eTvUug9N6pSICr0JyldHpksp0mg9MhTPK
	5XxDuNyTndyKYHPoowhyUAMvAizgyjvR6TrLeigeuNWnwVgnTJqGJF5n8GJ2wFip
	Jsrvn4AnLPOD76VpvEC+WU4HWPVffDnakz0ufOINbXK2F7VFY09Jf3nfoYoDAROl
	wAn1kXncYY80oAmya0+UhcLkPaOAJuL9DFxou2nO7jKJEQC014PUOKx3r4a3x39s
	tz7S8OVrnpMY1xp3qIFQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wtfwn08g5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 07:05:56 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42C75tc4011990
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 07:05:55 GMT
Received: from [10.214.18.146] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 12 Mar
 2024 00:05:53 -0700
Message-ID: <2521790d-2676-43af-bdac-76043fd63dd6@quicinc.com>
Date: Tue, 12 Mar 2024 12:35:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] soc: qcom: mdt_loader: Add Upperbounds check for
 program header access
From: Auditya Bhattaram <quic_audityab@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>
CC: <konrad.dybcio@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20240213080010.16924-1-quic_audityab@quicinc.com>
 <y6em73mzbh47fzpgfvfsrypw5ktgt6zaqfujscaxkjuqivlxcr@vcke7w4omq7b>
 <38e6cf32-78fc-4a5a-a98c-18b126bdf50f@quicinc.com>
Content-Language: en-US
In-Reply-To: <38e6cf32-78fc-4a5a-a98c-18b126bdf50f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nZv5UbID9omxc2EP9MeKPXrrWihXnuOz
X-Proofpoint-GUID: nZv5UbID9omxc2EP9MeKPXrrWihXnuOz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_06,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403120053



On 2/14/2024 11:27 AM, Auditya Bhattaram wrote:
> 
> 
> On 2/14/2024 11:12 AM, Bjorn Andersson wrote:
>> On Tue, Feb 13, 2024 at 01:30:10PM +0530, Auditya Bhattaram wrote:
>>> hash_index is evaluated by looping phdrs till QCOM_MDT_TYPE_HASH
>>> is found. Add an upperbound check to phdrs to access within elf size.
>>>
>>
>> How is this compatible with what is being observed on SM8450 and
>> implemented in commit 8bd42e2341a7 ("soc: qcom: mdt_loader: Allow hash
>> segment to be split out"?
>>
>> Regards,
>> Bjorn
>>
> 
> Calculating hash_index is introduced with this commit 8bd42e2341a7 
> ("soc: qcom: mdt_loader: Allow hash segment to be split out"
> 
>      for (i = 1; i < ehdr->e_phnum; i++) {
>       if ((phdrs[i].p_flags & QCOM_MDT_TYPE_MASK) ...
> 
> I'm trying to add an upper bound for this access "phdrs[i]"
> 

Any further questions on this Bjorn.

>>> Fixes: 64fb5eb87d58 ("soc: qcom: mdt_loader: Allow hash to reside in 
>>> any segment")
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Auditya Bhattaram <quic_audityab@quicinc.com>
>>> Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>> ---
>>> Changes in v4:
>>>   - Added additional prints incase of Invalid access.
>>> Link to v3 
>>> https://lore.kernel.org/stable/1c91c653-cebe-4407-bdd6-cfc73b64c0fb@quicinc.com
>>> Link to v2 
>>> https://lore.kernel.org/linux-arm-msm/9773d189-c896-d5c5-804c-e086c24987b4@quicinc.com/T/#t
>>> Link to v1 
>>> https://lore.kernel.org/linux-arm-msm/5d7a3b97-d840-4863-91a0-32c1d8e7532f@linaro.org/T/#t
>>> ---
>>>   drivers/soc/qcom/mdt_loader.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/soc/qcom/mdt_loader.c 
>>> b/drivers/soc/qcom/mdt_loader.c
>>> index 6f177e46fa0f..1a79a7bba468 100644
>>> --- a/drivers/soc/qcom/mdt_loader.c
>>> +++ b/drivers/soc/qcom/mdt_loader.c
>>> @@ -145,6 +143,13 @@ void *qcom_mdt_read_metadata(const struct 
>>> firmware *fw, size_t *data_len,
>>>       if (phdrs[0].p_type == PT_LOAD)
>>>           return ERR_PTR(-EINVAL);
>>>
>>> +    if (((size_t)(phdrs + ehdr->e_phnum)) > ((size_t)ehdr + 
>>> fw->size)) {
>>> +        dev_err(dev,
>>> +            "Invalid phdrs access for fw: %s, e_phnum: %u, fw->size: 
>>> %zu\n",
>>> +            fw_name, ehdr->e_phnum, fw->size);
>>> +        return ERR_PTR(-EINVAL);
>>> +    }
>>> +
>>>       for (i = 1; i < ehdr->e_phnum; i++) {
>>>           if ((phdrs[i].p_flags & QCOM_MDT_TYPE_MASK) == 
>>> QCOM_MDT_TYPE_HASH) {
>>>               hash_segment = i;
>>> -- 
>>> 2.17.1
>>>

