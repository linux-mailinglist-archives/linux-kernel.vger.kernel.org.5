Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C161E7D6C41
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbjJYMqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbjJYMqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:46:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3687990;
        Wed, 25 Oct 2023 05:46:50 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PCHP8x021586;
        Wed, 25 Oct 2023 12:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wjjSc92I5htECHlaVs3tEF9HxPxzvbqzSuF+P/5AcNk=;
 b=UrgpKYmI+IiU4Z8zwBRdY6aAzfQpz8F+p9lh927cRnwT42NTVHfvlB7KBa7v1OY7eXcV
 OJhvjPz+0bsEzq2W4XNy2vqpQopsXfZErrgqime/PDvYulCvze2UzlnPPwzLy+R39wZM
 GGrTnuQEc057+B/zqWU9F51x+Yz58gCEmioHIEt6ST++AAqAL9TYXQsJnafjcIB8j/Ul
 Q7dipmHUQvsMP1Xv9nPSbkasxicAQ0wgEdxy4tbFiHY9anAa7iB7qRHeYTqNzgiANwMb
 2Fj0uIHWb3dvlZEqa/vq4XhBhU2jh2/PrkLNpiIdBCmELU9yFqhSk0XBafyep+9lctY5 1Q== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3txk9k9vk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 12:46:41 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39PCkftv001619
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 12:46:41 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 25 Oct
 2023 05:46:38 -0700
Message-ID: <be86eca9-1bdb-eae9-6d00-8349de2c6166@quicinc.com>
Date:   Wed, 25 Oct 2023 18:16:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/3 v7] Misc SCM changes
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <p.zabel@pengutronix.de>,
        <linus.walleij@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1696440338-12561-1-git-send-email-quic_mojha@quicinc.com>
 <CAA8EJprTCWevfRNdVDV5xpgNu-Fh21HGM_eS2pOUuZJesgCD6Q@mail.gmail.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <CAA8EJprTCWevfRNdVDV5xpgNu-Fh21HGM_eS2pOUuZJesgCD6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NYW7NGkWaH3C1u7jzM7rcJTHBIF5rPHi
X-Proofpoint-ORIG-GUID: NYW7NGkWaH3C1u7jzM7rcJTHBIF5rPHi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 mlxlogscore=763 phishscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250110
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/2023 1:37 AM, Dmitry Baryshkov wrote:
> On Wed, 4 Oct 2023 at 20:26, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>>
>> I have given version to this series as v7 as it has already
>> gone through v6 and later got added to minidump patch series
>> However, these 3 patches can go independently and has no
>> relation with minidump hence, separated it from minidump series.
> 
> Please describe the merge strategy, since these patches cross the
> subsystem boundary. Linusw has acked patch2, which might mean that he
> is fine for it to be merged via the arm-soc? tree. However as nothing
> was mentioned in the cover letter, Bjorn has marked patch2 as not
> applicable (as it is outside of the usual subsystem area).

Thanks for your time in reviewing this series.

Sent another version here after addressing the comments.

https://lore.kernel.org/lkml/1698235506-16993-1-git-send-email-quic_mojha@quicinc.com/

-Mukesh



> 
