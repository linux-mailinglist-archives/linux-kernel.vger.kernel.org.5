Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8287BDA8C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346384AbjJIMAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjJIMAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:00:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9173C94;
        Mon,  9 Oct 2023 05:00:46 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399Bk93c029864;
        Mon, 9 Oct 2023 12:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=o9r1b72AGzQX2cPr3WsZ4YtvkbsTzQxrKOO5gARLsSg=;
 b=EqS9Eb8QuzhS2rsmdbzg/FEhk6CjLoBgeb2ZxodZgr80/jtVRB/v1t/oYe9xYXbHgg++
 m9vY5hE9lS44rxu4+RjHXogYHDr+P4tdv0vifgUMsiSzLEDYgF2W0xsuP5GLxqPD3ND0
 zatW1t7s2F3ZpspyyLlNa0Te6QBEYoDTKFmCxEJ+Z6uZf0Fe73IhI4ch+MA971Od89WM
 EbKXPSF2GdZ1eoMrMfGPYAKxTOJ4OnZEOB4fvOrZBY1vu187+2duPrD9iFORbXcibe3x
 NXP4hYGibfPgAfMj2huKwl1O09eBmYVzJa4ZXBRvLbIRswsY1c2axJda5LcxQA5hjmVR Jg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tkh592b8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 12:00:04 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 399C02Xr000308
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Oct 2023 12:00:02 GMT
Received: from [10.214.225.95] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 9 Oct
 2023 04:59:49 -0700
Message-ID: <a869ec2e-966b-f8ea-7f68-a77c214a45af@quicinc.com>
Date:   Mon, 9 Oct 2023 17:29:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [REBASE PATCH v5 10/17] pstore: Add pstore_region_defined()
 helper and export it
To:     Kees Cook <keescook@chromium.org>
CC:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <mathieu.poirier@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <linus.walleij@linaro.org>,
        <andy.shevchenko@gmail.com>, <vigneshr@ti.com>, <nm@ti.com>,
        <matthias.bgg@gmail.com>, <kgene@kernel.org>,
        <alim.akhtar@samsung.com>, <bmasney@redhat.com>,
        <quic_tsoni@quicinc.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <kernel@quicinc.com>
References: <1694429639-21484-1-git-send-email-quic_mojha@quicinc.com>
 <1694429639-21484-11-git-send-email-quic_mojha@quicinc.com>
 <202309131620.34EB0F6972@keescook>
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <202309131620.34EB0F6972@keescook>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DDbFoX8caW9i9Gk7bqvbx_eyrZSMb8tu
X-Proofpoint-GUID: DDbFoX8caW9i9Gk7bqvbx_eyrZSMb8tu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_11,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310090098
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review.

On 9/14/2023 4:54 AM, Kees Cook wrote:
> On Mon, Sep 11, 2023 at 04:23:52PM +0530, Mukesh Ojha wrote:
>> There are users like Qualcomm minidump which is interested in
>> knowing the pstore frontend addresses and sizes from the backend
>> (ram) to be able to register it with firmware to finally collect
>> them during crash for debugging.
>>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>>   fs/pstore/platform.c   | 15 +++++++++++++++
>>   fs/pstore/ram.c        | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/pstore.h |  6 ++++++
>>   3 files changed, 63 insertions(+)
>>
>> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
>> index e5bca9a004cc..fdac951059c1 100644
>> --- a/fs/pstore/platform.c
>> +++ b/fs/pstore/platform.c
>> @@ -139,6 +139,21 @@ enum pstore_type_id pstore_name_to_type(const char *name)
>>   }
>>   EXPORT_SYMBOL_GPL(pstore_name_to_type);
>>   
>> +int pstore_region_defined(struct pstore_record *record,
>> +			  void **virt, phys_addr_t *phys,
>> +			  size_t *size, unsigned int *max_dump_cnt)
>> +{
>> +	if (!psinfo)
>> +		return -EINVAL;
>> +
>> +	record->psi = psinfo;
> 
> Uh, this makes no sense to me. If this is a real pstore_record, you
> cannot just assign psi here.

Ok.

> 
>> +
>> +	return psinfo->region_info ?
>> +	       psinfo->region_info(record, virt, phys, size, max_dump_cnt) :
>> +	       -EINVAL;
> 
> Common code style for this kind of thing is usually like this:
> 
> 	if (!psinfo->region_info)
> 		return -EINVAL;
> 
> 	return psinfo->region_info(...)

Thanks.

-Mukesh
> 
>> +}
>> +EXPORT_SYMBOL_GPL(pstore_region_defined);
>> +
>>   static void pstore_timer_kick(void)
>>   {
>>   	if (pstore_update_ms < 0)
>> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
>> index ab551caa1d2a..62202f3ddf63 100644
>> --- a/fs/pstore/ram.c
>> +++ b/fs/pstore/ram.c
>> @@ -437,6 +437,47 @@ static int ramoops_pstore_erase(struct pstore_record *record)
>>   	return 0;
>>   }
>>   
>> +static int ramoops_region_info(struct pstore_record *record,
>> +			       void **virt, phys_addr_t *phys,
>> +			       size_t *size, unsigned int *max_dump_cnt)
> 
> But there's a larger problem here -- "virt", "phys" and likely
> "max_dump_cnt" are aspects _specific to the ram backend_. This can't be
> a generic pstore interface.
> 
> I'm not opposed to it being exposed only from ramoops, though.
> 
> But I think you'll want a pstore generic way to iterate over the
> records..
