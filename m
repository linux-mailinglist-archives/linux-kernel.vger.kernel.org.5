Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B2D76C7CC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjHBIB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbjHBIBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:01:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5D3B4;
        Wed,  2 Aug 2023 01:01:42 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37211fkI008077;
        Wed, 2 Aug 2023 08:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NqWLVpp+y1y0zXW6k+mxHCmC9rdsQy22hgANj0VoGkQ=;
 b=eNZ6KWmzjSuNq1MtdNJXi5VcWoI2G0mv/WzoUy+Q2vO7iyQDk7Duw/g4slwQaLJHpsTz
 /SUrqDQHVkfqmAS+hRh6kF78RM+69Y+DhBFb7ygy3+5ohDSDxlppXZahWmdgBho564bq
 H1fCUfCy1BXzTK7Dbp9bcJVjifwwMf2ZGyQHziqYlC6QmsMGb5TYAaVS8S5Lre1SwSL6
 I1oLfevEeJR/QfDstGMlorb2ly0+FfU8oH5pahsQyjtsi20rA6/h2UOjMJ+oiACE+A94
 gz2bta8BZ/kqIcEeYJQwvfzwJMbCFsE3mmXnanoxy4CXcVK95/nyzf8Ax2bdVVoGxO2n 1A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s75b31qpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 08:01:36 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37281ZtD026320
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 08:01:35 GMT
Received: from [10.239.104.229] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 2 Aug
 2023 01:01:32 -0700
Message-ID: <39e7dec4-8c84-2406-3490-251ff942282c@quicinc.com>
Date:   Wed, 2 Aug 2023 16:01:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 0/2] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth SoC QCA2066
Content-Language: en-US
To:     <johan@kernel.org>
CC:     <marcel@holtmann.org>, <luiz.dentz@gmail.com>,
        <johan.hedberg@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-bluetooth@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_bgodavar@quicinc.com>, <quic_hemantg@quicinc.com>
References: <20230727083555.1023992-1-quic_tjiang@quicinc.com>
From:   Tim Jiang <quic_tjiang@quicinc.com>
In-Reply-To: <20230727083555.1023992-1-quic_tjiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -Iq4voRhO5Cm_Q6Bj98KzKBCe9oaft-1
X-Proofpoint-ORIG-GUID: -Iq4voRhO5Cm_Q6Bj98KzKBCe9oaft-1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_03,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 mlxlogscore=837 bulkscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020070
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan:

   sorry to disturb you , any other comments for this version ? could 
you help merge this patch, thank you very much.


On 7/27/23 16:35, Tim Jiang wrote:
> This series adds support for qualcomm bluetooth soc qca2066
>
> Changes in v14
>   - remove stray newline
>
> Changes in v13
>   - change the subject name for patch 1/2, and move the qca066 type code to patch 2/2.
>   - correct log style and sort qca2066 btsoc type for patch 2/2
>
> Changes in v12
>   - fix compile error issue for patch 1/2
>
> Changes in v11
>   - reverse two patches order
>
> Changes in v10
>   - break out btsoc type print into seperate patch
>
> Changes in v2-v9
>   - solve review comments for code style and commit message context
>
>
> Tim Jiang (2):
>    Bluetooth: hci_qca: adjust qca btsoc type print expression
>    Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA2066
>
>   drivers/bluetooth/btqca.c   | 76 ++++++++++++++++++++++++++++++++++++-
>   drivers/bluetooth/btqca.h   |  4 +-
>   drivers/bluetooth/hci_qca.c | 41 ++++++++++++++++++--
>   3 files changed, 114 insertions(+), 7 deletions(-)
>
