Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFA678232D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 07:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjHUFbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 01:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjHUFbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 01:31:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15977A3;
        Sun, 20 Aug 2023 22:31:18 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37L54abN025014;
        Mon, 21 Aug 2023 05:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=c8uUEEZWKdhdjMO4DdNXq1RHRVYBuI0mJCa8u5UnvD0=;
 b=nXIV8CmzyHyecUi3DLWXPyDfB23Dj/xN9tf/48gvlOfVv489UPpOvEAOOd/w1bl8RoCv
 A1vlYRy5lZGZ4YfuD4NxPpSjUhC6fwpYqKsFugWasbzXwAJnR4d90grvsrXl4qE7t5mn
 eAjszgKrg846IFsAdrGQMGtkqgCJha65HNAJkHdRl4PVcKIdMhyUCShvWBma+AtMGDU4
 8rFTxvTMcmhX0mjLH4WAlyNu9n/4P8NIjIsqLUQRqh0kcs7p3I5DL1rT6/bwy+wira9h
 eHySLtYaWeYLB/5TRmmjvqdWJpGzgHb8SDxIurrfvYZIHsf/w1vwFMrmmvIFEcYAYk0d tg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sjmpxk0d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 05:30:37 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37L5UavZ031646
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 05:30:36 GMT
Received: from [10.201.3.104] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 20 Aug
 2023 22:30:33 -0700
Message-ID: <1ee5a95c-2fe4-2163-5ff2-0c01d05c30cf@quicinc.com>
Date:   Mon, 21 Aug 2023 11:00:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/3] mtd: rawnand: qcom: Update read_loc size to 512
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <mani@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>
References: <20230818145101.23825-1-quic_mdalam@quicinc.com>
 <20230818145101.23825-2-quic_mdalam@quicinc.com>
 <20230818215908.0e60b00b@xps-13>
Content-Language: en-US
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20230818215908.0e60b00b@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nL12fBierDu-ThJenNzDjeTF1ZFvVonP
X-Proofpoint-ORIG-GUID: nL12fBierDu-ThJenNzDjeTF1ZFvVonP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-20_15,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 adultscore=0 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308210051
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/19/2023 1:29 AM, Miquel Raynal wrote:
> Hi Md,
> 
> quic_mdalam@quicinc.com wrote on Fri, 18 Aug 2023 20:20:59 +0530:
> 
>> For parameter page read upper layer is passing len
>> as 256 bytes and if we try to configure 256 bytes
>> size in read loaction register then subsequent bam
>> transaction is getting timed out for 4K nand devices.
>> So update this length as one step size if its
>> less than NANDC_STEP_SIZE.
>>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> 
> I'm fine with patches 2 and 3 and will take them. But this one does not
> seem legitimate. I don't like it. Are you sure the ECC engine was not
> enabled when it timed out? Default should be having the ECC disabled
> and it should just get enabled when you need it. There is no reason
> why, specifically on NAND devices, it would not be possible to read 256
> bytes.
> 

    Yes default ECC engine is disabled only. When length was 512 bytes for
    parameter page read it was causing BAM timeout error on SDX65, but it
    was working fine on IPQ807x.
    We will drop this patch for now. Let me check on SDX65 and try to fix
    all the error.

>> ---
>>   drivers/mtd/nand/raw/qcom_nandc.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
>> index d4ba0d04c970..413e214c8e87 100644
>> --- a/drivers/mtd/nand/raw/qcom_nandc.c
>> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
>> @@ -2885,6 +2885,9 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
>>   	op_id = q_op.data_instr_idx;
>>   	len = nand_subop_get_data_len(subop, op_id);
>>   
>> +	if (len < NANDC_STEP_SIZE)
>> +		len = NANDC_STEP_SIZE;
>> +
>>   	nandc_set_read_loc(chip, 0, 0, 0, len, 1);
>>   
>>   	if (!nandc->props->qpic_v2) {
> 
> 
> Thanks,
> Miquèl
