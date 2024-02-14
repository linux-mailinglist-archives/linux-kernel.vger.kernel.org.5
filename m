Return-Path: <linux-kernel+bounces-64761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4372785428E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46AF51C22EAE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D78F10A13;
	Wed, 14 Feb 2024 05:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R1SuX3Sf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF9410A01;
	Wed, 14 Feb 2024 05:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707890234; cv=none; b=WQ7yNmoT/VM3Jr0+9eZGzK5YTr3V1IETr8zM4n1WLtZEoUTTKagnF2sTfpneeKj+ui5eGR0CP1o0kbJcY+zyz5B+yxYAMD1PrgdtUNiUEjQtD/wvnZpKh3qRsoTK6U6B03swlhH1PyV0F7HQQaUiKuYyN1NyawGr+ICk7+HR88c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707890234; c=relaxed/simple;
	bh=6SDXUXlfPjx8eiB5vMETjU0fSxFRT+10FuXj/UbTsx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uEx73yvmgdb3GqhvQBtHnYltpBIqU1MCsFp3jhquW1NfPhuFXBYSLshWyoWVdNqcDeFMAsdaDPbpEgV6IDPQZDch98TvA6A8MjxwgpKiupx7fV+J7SN0VsugwxViQBNNzOwzlxdwb7QYxHz6HtaHpyT8zcxxAonRRQcuf9ynaXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R1SuX3Sf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41E5OHdx010014;
	Wed, 14 Feb 2024 05:57:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=w8ISlZMV1zhNjIcMsRsxLGRvBcIZv75kpuqKibeytG0=; b=R1
	SuX3SfAoZoaedqYn0nsqf/4YpmM4dvvAc6HCQCaSF2FrHJk6zIVx7SaBvChxxMCL
	7+TV3+bO3T+0l0Krxfy2BDY6VWfS0m3vvqldZdrqNMVP58vwrmp30khtbkDl9yDr
	8OyBt/Suns4cYelDQx4q+lyhyKqDVZbK9O/WCckTIzoy5XB02dcwE2Gg5MXoLe6g
	gD417D6GKEUhkbuSV9LVgsmlSTEL05Z70GI5B8HvsSzCcAkZR65cHVTXbKZKli/N
	bXxrbpEShz5lpvmqgw5Pfp2v1t9OCL/hEm5WHdPnkAUXoXzqusBoKvPN3OsZCl9/
	liWE7AqIYFJNG7055B0A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w8nt4060p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 05:57:07 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41E5v6SY019237
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 05:57:06 GMT
Received: from [10.214.18.146] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 13 Feb
 2024 21:57:04 -0800
Message-ID: <38e6cf32-78fc-4a5a-a98c-18b126bdf50f@quicinc.com>
Date: Wed, 14 Feb 2024 11:27:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] soc: qcom: mdt_loader: Add Upperbounds check for
 program header access
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>
CC: <konrad.dybcio@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20240213080010.16924-1-quic_audityab@quicinc.com>
 <y6em73mzbh47fzpgfvfsrypw5ktgt6zaqfujscaxkjuqivlxcr@vcke7w4omq7b>
From: Auditya Bhattaram <quic_audityab@quicinc.com>
In-Reply-To: <y6em73mzbh47fzpgfvfsrypw5ktgt6zaqfujscaxkjuqivlxcr@vcke7w4omq7b>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MYPfwjGipRs2ALcjACeImYEJQAGuB-AA
X-Proofpoint-ORIG-GUID: MYPfwjGipRs2ALcjACeImYEJQAGuB-AA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_16,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402140044



On 2/14/2024 11:12 AM, Bjorn Andersson wrote:
> On Tue, Feb 13, 2024 at 01:30:10PM +0530, Auditya Bhattaram wrote:
>> hash_index is evaluated by looping phdrs till QCOM_MDT_TYPE_HASH
>> is found. Add an upperbound check to phdrs to access within elf size.
>>
> 
> How is this compatible with what is being observed on SM8450 and
> implemented in commit 8bd42e2341a7 ("soc: qcom: mdt_loader: Allow hash
> segment to be split out"?
> 
> Regards,
> Bjorn
> 

Calculating hash_index is introduced with this commit 8bd42e2341a7 
("soc: qcom: mdt_loader: Allow hash segment to be split out"

     for (i = 1; i < ehdr->e_phnum; i++) {
  	if ((phdrs[i].p_flags & QCOM_MDT_TYPE_MASK) ...

I'm trying to add an upper bound for this access "phdrs[i]"

>> Fixes: 64fb5eb87d58 ("soc: qcom: mdt_loader: Allow hash to reside in any segment")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Auditya Bhattaram <quic_audityab@quicinc.com>
>> Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>> Changes in v4:
>>   - Added additional prints incase of Invalid access.
>> Link to v3 https://lore.kernel.org/stable/1c91c653-cebe-4407-bdd6-cfc73b64c0fb@quicinc.com
>> Link to v2 https://lore.kernel.org/linux-arm-msm/9773d189-c896-d5c5-804c-e086c24987b4@quicinc.com/T/#t
>> Link to v1 https://lore.kernel.org/linux-arm-msm/5d7a3b97-d840-4863-91a0-32c1d8e7532f@linaro.org/T/#t
>> ---
>>   drivers/soc/qcom/mdt_loader.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
>> index 6f177e46fa0f..1a79a7bba468 100644
>> --- a/drivers/soc/qcom/mdt_loader.c
>> +++ b/drivers/soc/qcom/mdt_loader.c
>> @@ -145,6 +143,13 @@ void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len,
>>   	if (phdrs[0].p_type == PT_LOAD)
>>   		return ERR_PTR(-EINVAL);
>>
>> +	if (((size_t)(phdrs + ehdr->e_phnum)) > ((size_t)ehdr + fw->size)) {
>> +		dev_err(dev,
>> +			"Invalid phdrs access for fw: %s, e_phnum: %u, fw->size: %zu\n",
>> +			fw_name, ehdr->e_phnum, fw->size);
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>>   	for (i = 1; i < ehdr->e_phnum; i++) {
>>   		if ((phdrs[i].p_flags & QCOM_MDT_TYPE_MASK) == QCOM_MDT_TYPE_HASH) {
>>   			hash_segment = i;
>> --
>> 2.17.1
>>

