Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451A776D39A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 18:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjHBQ0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 12:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjHBQ0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 12:26:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BB91FFA;
        Wed,  2 Aug 2023 09:26:06 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372E7f1i028328;
        Wed, 2 Aug 2023 15:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=l27L1z+fYh8L3ZhSSl3etbSXBI7anqfGlqjXvz1VcQM=;
 b=cUrJgIK4QWL8orqSU9cB9WcD9MoUcdP7a+IgT2POv4gUjWMRWLRWbXRzlOZF0Bjl9MRM
 MbbshXB43bGPH3uRIKQqoCxPWRp6twV8GkC4+6ShWffxyjjReBDxSfsTWrjc9M0mgaHO
 aallzm6bWIeHUxQs/He2Vq74229RhIvFdmOvoxQGtp95T5l34EP2aj7EjUCGiwq3qOjF
 NTTaIxpZtwkpO8tFM9CUz/yhcDjqP/OKv0nGiw26HoJq4tVz1U1hbmxy+ccVtatczamM
 0PD1oNNlUrQr7YLrAFLiGoAUJoeiP4UQMwr83DYQWlRqyzvvE453e8KJZ5w3kPpDsRq8 /w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s75dgasd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 15:16:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 372FG32r000824
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 15:16:03 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 2 Aug
 2023 08:16:02 -0700
Message-ID: <a36af0d6-f6bf-39f8-825d-c743dbd6e84e@quicinc.com>
Date:   Wed, 2 Aug 2023 09:16:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH][V2][next] accel/qaic: remove redundant pointer pexec
Content-Language: en-US
To:     Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Carl Vanderlip <quic_carlv@quicinc.com>,
        "Oded Gabbay" <ogabbay@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230726140626.264952-1-colin.i.king@gmail.com>
 <dc7fdd8a-b3c4-b931-61be-b9bc467c6a85@quicinc.com>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <dc7fdd8a-b3c4-b931-61be-b9bc467c6a85@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 71YLkLg0-fdy5LzX6hH5l4uUHqpY7jSM
X-Proofpoint-ORIG-GUID: 71YLkLg0-fdy5LzX6hH5l4uUHqpY7jSM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_11,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 mlxlogscore=752 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020135
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/2023 8:05 AM, Pranjal Ramajor Asha Kanojiya wrote:
> 
> 
> On 7/26/2023 7:36 PM, Colin Ian King wrote:
>> Pointer pexec is being assigned a value however it is never read. The
>> assignment is redundant and can be removed. Replace sizeof(*pexec)
>> with sizeof the type and remove the declaration of pointer pexec.
>>
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> 
> Reviewed-by: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
> 

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

Applied to drm-misc-next

Thanks!

-Jeff
