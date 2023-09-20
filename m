Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AA47A8C04
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjITSsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjITSsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:48:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9848CAF;
        Wed, 20 Sep 2023 11:48:32 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KIEE3b018242;
        Wed, 20 Sep 2023 18:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eFL2cOXt4S31KE1b7/1gOPuylzH5IeQJULT409jF1Zo=;
 b=Pq0z2qE0VmfWf7mc8MH/DtdwlAgpjFAo8T8XNezX2bnJ8+/Tx2EQqkuNX5gIm4mOud+2
 C/36QPo7MeJQOWMvrgTXHC01nmZ6TxaZvOEPwvYgt+V1U4wlXbo3LXMhIQ4khIYYgZGL
 KQ94Cra1gN0fwoBjy8UMRpa5cl5koCgZQsr+coCuN4WWL3SbJawUxKCtxH4itZCRSXZc
 9Qy/YSco4VKTtAsfdAZoNIefxghbnfZi5hw4O+bRYxs9qTjml6KcdfN/vbA5/X3Hxkkp
 b6rhJcATf2/yf2tbh7ws2CSI5sEgdJ5HcVgp62tOIDrW/BFoc2jsReedv8L3v714nzEp 3w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t7qj926ta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 18:48:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38KImP9W014602
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 18:48:25 GMT
Received: from [10.48.245.144] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 20 Sep
 2023 11:48:24 -0700
Message-ID: <82c49ef3-a9d9-47d6-a1c3-704f8af83e6a@quicinc.com>
Date:   Wed, 20 Sep 2023 11:48:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 wireless-next 6/9] wifi: ath10k: Remove unnecessary
 (void*) conversions
Content-Language: en-US
To:     Wu Yunchuan <yunchuan@nfschina.com>, <kvalo@kernel.org>
CC:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20230919045056.523958-1-yunchuan@nfschina.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230919045056.523958-1-yunchuan@nfschina.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0nzYmSzwIcUy72H6jNzWaCks7OZXJ9Af
X-Proofpoint-ORIG-GUID: 0nzYmSzwIcUy72H6jNzWaCks7OZXJ9Af
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_08,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=790
 mlxscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200156
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/2023 9:50 PM, Wu Yunchuan wrote:
> No need cast (void*) to (struct htt_rx_ring_setup_ring32 *),
> (struct htt_rx_ring_setup_ring64 *). Change the prototype to
> remove the local variable.
> 
> Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
> Suggested-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Ideally your Signed-off-by: should be the last tag you add, but in this 
context I don't think it matters.

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


