Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6B17A1393
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 04:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjIOCHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 22:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjIOCHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 22:07:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BA51BF8;
        Thu, 14 Sep 2023 19:07:37 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38F1vjQB031639;
        Fri, 15 Sep 2023 02:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DFfM3gwuXEv/bD4DPO1UqZiRQA0ptdzLpBiMIY5+g28=;
 b=HJ+Dcw3kxGd/kBzjt1pQxuP3reD8ksTOy+XaBRVZ2/RFRW4RDxtrBrPLp54Qzth2NSEo
 qnLVnnn8RfTybYKJSLG7OdiBWH9CM8aJ3yZtKDud3pR03HuJgPiKVjexO3NdpenGwJQV
 8szMNp827AaCj1bsjKPwvjHSHN8bQVKCGBvZuWuSHn5xlzjBytHH9lH1OyH4SAOzjDQ6
 7/8QYA2eOGz7wB8FI+pEPhwnjGwmIFCN3yXiSl8wctF1CuP+0eYuTq0tSan53yBrh7VS
 EikDFrRurnXCXyZVMnqz0nq2SjPJqOd08oIdyq4B9vPtrCfzWch7jd2HSwKyMpnd58Ex FQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4e2b00uj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 02:07:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38F27OOR015603
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 02:07:24 GMT
Received: from [10.253.10.13] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 14 Sep
 2023 19:07:21 -0700
Message-ID: <289ec1a4-1930-4bed-b6ff-f1a591dc4295@quicinc.com>
Date:   Fri, 15 Sep 2023 10:07:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/6] phy: qualcomm: phy-qcom-qmp-ufs: Add High Speed Gear
 5 support for SM8550
Content-Language: en-US
To:     Nitin Rawat <quic_nitirawa@quicinc.com>, <mani@kernel.org>,
        <quic_nguyenb@quicinc.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
 <1694411968-14413-4-git-send-email-quic_cang@quicinc.com>
 <bce78c63-139a-852a-f8bb-50510f9c4e7d@quicinc.com>
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <bce78c63-139a-852a-f8bb-50510f9c4e7d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KvPY1xCdSu9q2FxTzy_2c-X3ysk1Efh3
X-Proofpoint-ORIG-GUID: KvPY1xCdSu9q2FxTzy_2c-X3ysk1Efh3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_02,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150017
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nitin,

On 9/14/2023 8:26 PM, Nitin Rawat wrote:
>
>
> On 9/11/2023 11:29 AM, Can Guo wrote:
>> Split High Speed Gear 4 PHY settings from common tables, and add PHY
>> settings to support High Speed Gear 5.
>>
>
> Hi Can,
>
> Can you please add more details explaining the change. We can mention 
> that are we spliting serdes setting for g3 and g4.
Sure.
>
> Also how about having 2 patches, one for splitting serdes 
> configuration b/w gear3 and gear4 and other patch about new g5 setting.
No, we should have them in one patch, because after splitting, just 
writing the common settings won't work for G5 mode.
>
> -Nitin
>

Thanks,

Can Guo

