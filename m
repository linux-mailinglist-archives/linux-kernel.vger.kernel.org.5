Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047A07BE392
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344571AbjJIOw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjJIOwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:52:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581E98F;
        Mon,  9 Oct 2023 07:52:54 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399EiUlm023925;
        Mon, 9 Oct 2023 14:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LIqyYJmCPEdR/Fz/OX70bybdvmSWzeNzRHaRA8qiwbg=;
 b=f+IFkoSTZPhOFGQZqc+vEbtsMcXa9E66d9FZV6Z5Th7aZAk+96RTWWL1gTFQN2q+Cjy5
 OyPtD6hx6Grs7Y2pzRhkR/9EzypUy0a7HecMSv612VZ7qfnq4zphej1y5/5JI0cuiiYv
 z0VjGvvBegaletdPbzos/sFyAwemYySHlGn6DER0awwV+FPCkYc+IloEb6xBDQMKN0rQ
 F3ZnqpmD73E8i77SSqzt9uBTiKnOwdcKQME4d0EkPw1iyiTwGTmf+GEwfiS7MNO9H/SR
 ENWnjG65KbXlYpURf9lydXhCQFNYLKnlq2UkiEMUz3d1bWohycqqcbp+DbUIope5TcTw oQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tkh87amr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 14:52:42 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 399EqfaA020876
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Oct 2023 14:52:41 GMT
Received: from [10.110.87.129] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 9 Oct
 2023 07:52:41 -0700
Message-ID: <b1c9ad08-5aad-ccbd-247c-a5b2aaa42b5b@quicinc.com>
Date:   Mon, 9 Oct 2023 07:52:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: Add new compatible for smc/hvc
 transport for SCMI
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20231006164206.40710-1-quic_nkela@quicinc.com>
 <20231006164206.40710-2-quic_nkela@quicinc.com>
 <20231009144154.vfx5caqxtyezulxx@bogus>
Content-Language: en-US
From:   Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <20231009144154.vfx5caqxtyezulxx@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -ArKwvWj-pbQty5DVA0MNW19o3Sj_S-Y
X-Proofpoint-GUID: -ArKwvWj-pbQty5DVA0MNW19o3Sj_S-Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_12,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 impostorscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=877
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310090123
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/9/2023 7:41 AM, Sudeep Holla wrote:
> On Fri, Oct 06, 2023 at 09:42:05AM -0700, Nikunj Kela wrote:
>> Introduce compatible "qcom,scmi-smc" for SCMI smc/hvc transport channel for
>> Qualcomm virtual platforms.
>>
>> This compatible mandates populating an additional parameter 'capability-id'
>> from the last 8 bytes of the shmem channel.
>>
> While I am happy with the simplification here, I am also bit nervous how
> long before Qualcomm abandons this. I hope this is adopted as is in all
> internal and downstream code without any modifications and this is not
> just a push for upstreaming some change to minimise delta with internal/
> downstream code.
>
> --
> Regards,
> Sudeep

Qualcomm is using patch on all the virtual auto platforms using 
shmem/doorbell as scmi channel. This is already being used without any 
modifications in our downstream code. No delta for this patch series. 
Thanks!

