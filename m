Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110DC7DDC3B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 06:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376762AbjKAFUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 01:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346907AbjKAFUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 01:20:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4B2ED;
        Tue, 31 Oct 2023 22:20:42 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A159JAX025607;
        Wed, 1 Nov 2023 05:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2idRMuZ7DuUJqYjTV5TGovRghgnCLifZDyaN59zOrAg=;
 b=ojSYkxJyKSJLdP1DBBGn806ieE82CmmkAg0WeEoan9iblKXnHj3ktZokPI9K9Y+B/IOs
 PxsCrFurhRInI9tX0QCx9QS2X/KKmNH2zP2JjJMuKulPv4d3EixCssW94QPfFmjONoGe
 f+53Xi+2pPNF1dBBbriSis433TWbJIzpvY4v/AEWT0lpG80ng545wy/KsIUpjw51miC8
 /pZxNkxz654WVtCW/iFCfv47c+y92ffQRihKph3iCiF8PjltU0tjsotJnosi0HQ7iI3p
 xkfJ2661V09SPV6Gi7D1U82gtAvFxNY2wL7x6YDGuWewuYQNe24DTTA9BVjDMs46gXaR 1g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2egsw74j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 05:20:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A15KS83001000
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Nov 2023 05:20:28 GMT
Received: from [10.217.219.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 31 Oct
 2023 22:20:25 -0700
Message-ID: <2aa185f7-815e-ee65-9d22-79ca2fe1b059@quicinc.com>
Date:   Wed, 1 Nov 2023 10:50:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] bus: mhi: host: Add alignment check for event ring
 read pointer
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_parass@quicinc.com>, <stable@vger.kernel.org>
References: <20231031-alignment_check-v2-1-1441db7c5efd@quicinc.com>
 <20231101051748.GD2897@thinkpad>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20231101051748.GD2897@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mPyeGpPNFeU6lyUknZD7pR4P0Ja52hFw
X-Proofpoint-GUID: mPyeGpPNFeU6lyUknZD7pR4P0Ja52hFw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_02,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311010045
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/1/2023 10:47 AM, Manivannan Sadhasivam wrote:
> On Tue, Oct 31, 2023 at 03:21:05PM +0530, Krishna chaitanya chundru wrote:
>> Though we do check the event ring read pointer by "is_valid_ring_ptr"
>> to make sure it is in the buffer range, but there is another risk the
>> pointer may be not aligned.  Since we are expecting event ring elements
>> are 128 bits(struct mhi_ring_element) aligned, an unaligned read pointer
>> could lead to multiple issues like DoS or ring buffer memory corruption.
>>
>> So add a alignment check for event ring read pointer.
>>
>> Fixes: ec32332df764 ("bus: mhi: core: Sanity check values from remote device before use")
>> cc: stable@vger.kernel.org
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
> Bjorn gave his R-b tag for v1 and you didn't include it. If you dropped it on
> purpose, then you should mention it in the "Changes" along with a justification.
>
> - Mani

As there is change in the logic I didn't include the tag. I will mention 
this on the next patch.

- Krishna Chaitanya.

>> ---
>> Changes in v2:
>> - Change the modulus operation to bit-wise & operation as suggested by Jeff.
>> - Link to v1: https://lore.kernel.org/r/20231023-alignment_check-v1-1-2ca5716d5c15@quicinc.com
>> ---
>>   drivers/bus/mhi/host/main.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
>> index 499590437e9b..e765c16a99d1 100644
>> --- a/drivers/bus/mhi/host/main.c
>> +++ b/drivers/bus/mhi/host/main.c
>> @@ -268,7 +268,8 @@ static void mhi_del_ring_element(struct mhi_controller *mhi_cntrl,
>>   
>>   static bool is_valid_ring_ptr(struct mhi_ring *ring, dma_addr_t addr)
>>   {
>> -	return addr >= ring->iommu_base && addr < ring->iommu_base + ring->len;
>> +	return addr >= ring->iommu_base && addr < ring->iommu_base + ring->len &&
>> +			!(addr & (sizeof(struct mhi_ring_element) - 1));
>>   }
>>   
>>   int mhi_destroy_device(struct device *dev, void *data)
>>
>> ---
>> base-commit: 71e68e182e382e951d6248bccc3c960dcec5a718
>> change-id: 20231013-alignment_check-c013f509d24a
>>
>> Best regards,
>> -- 
>> Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>
