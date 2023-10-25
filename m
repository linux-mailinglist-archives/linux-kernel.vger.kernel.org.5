Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3667D7151
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344380AbjJYP5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjJYP53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:57:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9637F12F;
        Wed, 25 Oct 2023 08:57:27 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PDQ4Eq028981;
        Wed, 25 Oct 2023 15:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=SQTscEEGyLS4/y/ePQ3HTxjVVgwjTkKWys2p8oXosRA=;
 b=j7jAI1D+POji1NlkXWpMoiTTYwyzomP/r8Jzpz+PJFn4tUWjLtDxQlcoyp8O//GlC0fw
 N+nghzSkj6nmr0K9Sj+O2sguyDmw1leDxBjspSAaf0SL09JTU/X4J0W2S0ci06SqkhFI
 DquCUF5AunkzQ/mIz4Oqyyww7j9x2HoYm6pAG7m3UTIvPhLkNVu6r62X6akyIIR8iDq9
 ZZ8RzSoQhiJ7CrFxl8XprC3J75FLtFmyUsTx2lxl5RTL/zZi2+A5YEnw8pb1xyjh7aZ9
 nXWObRK/NDmUzfikgT9rYZ2UQ+t9ZMxMij+ZQpcSSHG304Ofp83noFRdGWDKt2oYOVv+ gA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3txngvhxw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 15:57:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39PFvAQt014013
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 15:57:10 GMT
Received: from [10.48.243.236] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 25 Oct
 2023 08:57:09 -0700
Message-ID: <77205594-e8eb-4303-a2f6-d64ea80c2fd5@quicinc.com>
Date:   Wed, 25 Oct 2023 08:57:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: drop NULL pointer check in
 ath12k_update_per_peer_tx_stats()
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, Ma Ke <make_ruc2021@163.com>
CC:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231013074711.2202850-1-make_ruc2021@163.com>
 <169822778398.891844.2822098383458779586.kvalo@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <169822778398.891844.2822098383458779586.kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6wD8ysc4m1ahQADIL7-j5AFmz-DdXw9H
X-Proofpoint-ORIG-GUID: 6wD8ysc4m1ahQADIL7-j5AFmz-DdXw9H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_05,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 malwarescore=0 clxscore=1011 adultscore=0 spamscore=0
 bulkscore=0 mlxlogscore=936 impostorscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250138
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/2023 2:56 AM, Kalle Valo wrote:
> Ma Ke <make_ruc2021@163.com> wrote:
> 
>> Since 'user_stats' is a fixed-size array of 'struct htt_ppdu_user_stats'
>> in 'struct htt_ppdu_stats', any of its member can't be NULL and so
>> relevant check may be dropped.
>>
>> Signed-off-by: Ma Ke <make_ruc2021@163.com>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> 
> Jeff, what do you think?
> 
look correct,
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

