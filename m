Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5200879BE1B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346686AbjIKVXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244296AbjIKUAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:00:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A0A1B8;
        Mon, 11 Sep 2023 13:00:44 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BFfRmm026688;
        Mon, 11 Sep 2023 20:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=H5CM1cE9Y6HDbTdAD+oPNCwMtvDm0Oj8TKJeMdK5O9M=;
 b=avwUnqmXR+iLqjn4y1G3qvPqUthwBTWsHZur/8UClZ5dKwIEHy60o7tHkz3g3DqUbp5F
 4HNTElcjTpt42zExF5gB9Ikz/Oc0unrI+Q0Nv3lwDC3mXLzApIsPU0vFO2ZyL6/rNF/W
 81Z7aE2kwY2XXTnvHQg/x0GzVvFRlZ+qdSQ/xB/hvp4w3N/Vvm3QMvv0cJOT1ZMjhQSZ
 7sQIhDAdeQZT5PwV/GBPLYVbHz4Wl3T7ogQ5rJnhI1TIwrn7zIvbeNvLVjW32GuqGov+
 TT7yNPSzFY9nC62vGCZ+jQIlGKKYanpFTE9mzR2ZUA95edLN3bFUOm8Prk0b0Jy+c1TU Zg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t24ra8v7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 20:00:27 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38BK0RSl003781
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 20:00:27 GMT
Received: from [10.216.42.58] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 11 Sep
 2023 13:00:21 -0700
Message-ID: <f3d77752-f5f0-4896-b209-8e02f501a5b1@quicinc.com>
Date:   Tue, 12 Sep 2023 01:30:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: nand: qcom: Fix the node for nand unmap resource
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <mani@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_charnte@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_pkondeti@quicinc.com>
References: <20230911133026.29868-1-quic_bibekkum@quicinc.com>
 <20230911174039.63f6e835@xps-13>
From:   Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <20230911174039.63f6e835@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rtaDGYBllpCMOaBMGjQviBVwBhMT-MmM
X-Proofpoint-ORIG-GUID: rtaDGYBllpCMOaBMGjQviBVwBhMT-MmM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_16,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 suspectscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110184
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/2023 9:10 PM, Miquel Raynal wrote:
> Hi Bibek,
> 
> quic_bibekkum@quicinc.com wrote on Mon, 11 Sep 2023 19:00:26 +0530:
> 
> The title prefix should be s/nand/rawnand.
> 
> The title itself is unclear "fix the node" does not mean anything to me.
> 

sure Miquel, will rectify the prefix and give a meaningful title in the
next patch.

>> Fix addr argument to dma_unmap_resource() in the error path of probe.
> 
>        ^
> No abbreviation unless you are quoting the code directly.
> 
>                      of?                            probe error path
> 
>> The addr argument should be dma address instead of physical address.
>        ^                      ^                      ^
>        ditto                  the?                   the?
> 

Thanks for these pointers, will revise the commit message removing
abbreviations and making other changes as suggested.

Thanks,
Bibek

>>
>> Fixes: 7330fc505af4 ("mtd: rawnand: qcom: stop using phys_to_dma()")
>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>> ---
>> v2: Incorporated comments from Pavan/Mani.
>>
>> v1: https://lore.kernel.org/all/20230907092854.11408-1-quic_bibekkum@quicinc.com/
>>
>>   drivers/mtd/nand/raw/qcom_nandc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
>> index 64499c1b3603..b079605c84d3 100644
>> --- a/drivers/mtd/nand/raw/qcom_nandc.c
>> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
>> @@ -3444,7 +3444,7 @@ static int qcom_nandc_probe(struct platform_device *pdev)
>>   err_aon_clk:
>>   	clk_disable_unprepare(nandc->core_clk);
>>   err_core_clk:
>> -	dma_unmap_resource(dev, res->start, resource_size(res),
>> +	dma_unmap_resource(dev, nandc->base_dma, resource_size(res),
>>   			   DMA_BIDIRECTIONAL, 0);
>>   	return ret;
>>   }
>> --
>> 2.17.1
>>
> 
> 
> Thanks,
> Miquèl
