Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D762977C09F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjHNTT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjHNTTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:19:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F11E65;
        Mon, 14 Aug 2023 12:19:12 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EHgNW8013781;
        Mon, 14 Aug 2023 19:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dLL1fyf2iEwCBWvFDNBGHw/ySedV142t1xnuJ8ZjcIY=;
 b=I7AGM3hQjjCnRFZu6nQOTii5G60Wm7QoB5bGvZeV5atp+O4FYHp7p+w+G6aQi/OGR/nq
 ewZ0jzzI/xQ8mNG+liFctlYymfDEPDEYDCVPxPwp75K9GWcM2ZdHwjifdcWgYK7pJvqc
 g8Gtbt5LwES1paDncg7PpX/pXoAfj6h7SjUE3EEw4EeyjWUMoCCacQ/nEazFXCLfdAmH
 4tCi6lS9B+CUG2wmjhZuf1LiRRnT3LvGTnfoYNbaLKddqksZq4sISpKQVqOIEm3li04Q
 Syba57aP1wGb8zdcwgVLoBpaxdS/1urTThsYgnhDAlUE+M/NO7r9gUKNI4VP+CrUcmit FQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sffxt9j0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 19:19:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37EJJ1DY009028
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 19:19:02 GMT
Received: from [10.50.35.106] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 14 Aug
 2023 12:18:58 -0700
Message-ID: <ae50edf0-8c3a-97c5-32da-25118f36066f@quicinc.com>
Date:   Tue, 15 Aug 2023 00:48:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 16/33] iris: add helpers for media format
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <mchehab@kernel.org>,
        <hans.verkuil@cisco.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-17-git-send-email-quic_vgarodia@quicinc.com>
 <cd1fea83-3e0c-32c2-dc9f-61569366e212@linaro.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <cd1fea83-3e0c-32c2-dc9f-61569366e212@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _FY3DyvtfqOBmnqBCSZWznzPIlTNzRGg
X-Proofpoint-GUID: _FY3DyvtfqOBmnqBCSZWznzPIlTNzRGg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_16,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=633 spamscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140179
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/2023 11:25 PM, Konrad Dybcio wrote:
> On 28.07.2023 15:23, Vikash Garodia wrote:
>> From: Dikshita Agarwal <quic_dikshita@quicinc.com>
>>
>> Add helpers to calculate stride, scanline, buffer size
>> etc. for different media formats.
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>> ---
> [...]
> 
> 
>> +
>> +#ifndef MSM_MEDIA_ALIGN
>> +#define MSM_MEDIA_ALIGN(__sz, __align) (((__align) & ((__align) - 1)) ?\
>> +	((((__sz) + (__align) - 1) / (__align)) * (__align)) :\
>> +	(((__sz) + (__align) - 1) & (~((__align) - 1))))
> <linux/align.h>?
> 
sure, will replace with standard ALIGN macro
>> +#endif
>> +
>> +#ifndef MSM_MEDIA_ROUNDUP
>> +#define MSM_MEDIA_ROUNDUP(__sz, __r) (((__sz) + ((__r) - 1)) / (__r))
>> +#endif
>> +
>> +/*
>> + * Function arguments:
>> + * @v4l2_fmt
>> + * @width
>> + * Progressive: width
>> + * Interlaced: width
>> + */
> Kerneldoc would be cooler
> 
Sure, will take care of this in next version.
> [...]
> 
>> +static inline unsigned int video_rgb_stride_pix(unsigned int colorformat,
>> +						unsigned int width)
>> +{
>> +	unsigned int bpp = 4;
> Always?
Will check more on this if all supported RGB formats have bpp as 4.

Thanks,
Dikshita
> 
> 
> Konrad
