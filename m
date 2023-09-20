Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FA47A8B13
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjITSET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjITSEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:04:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7204CC9;
        Wed, 20 Sep 2023 11:04:09 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KHO7Ne012647;
        Wed, 20 Sep 2023 18:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=d6hdCc5sOQVcCqTmOAQhuBvnC4Z4vZNf3OAh6V5VMSI=;
 b=UWVx+jGwK9ujPuqWA+ucsy1A/c9xD8tilGN+2yhfRHOKTSmpiKjP2hsyZh/YviDAOf7I
 TcZT+gjtCn/n3wvV5tt6LGLRpSmy2anGkDLBI2q73Ne8QocSj21Wp+MWyZkgHorNtvLL
 pE77d51ap87orvlPfu3br92J3Fgql/Iltqm2AgBFDbXMJXxRnDotibub5gdbo+nViMw1
 QtpP0Tg4CypPMkCXkFlgxflGtbQiacdBrUgRHkaUdD5HeaTPxv4jBJ9zaGwBFJWV25Qm
 sSAs4kkwxuxfy+N1q2SpXSuF/09lVV0lSXGPmPXmWvg8GPolt9ZgOpwyrSQcnWeGRhv8 eQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t7vbksfhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 18:03:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38KI3me4013620
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 18:03:48 GMT
Received: from [10.48.245.144] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 20 Sep
 2023 11:03:48 -0700
Message-ID: <5a67f11d-0cd2-42bd-bbda-58b0cd196add@quicinc.com>
Date:   Wed, 20 Sep 2023 11:03:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 wireless-next 7/9] wifi: ath12k: Remove unnecessary
 (void*) conversions
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, Wu Yunchuan <yunchuan@nfschina.com>
CC:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20230919045142.524226-1-yunchuan@nfschina.com>
 <169522155403.1418260.5064455550425202498.kvalo@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <169522155403.1418260.5064455550425202498.kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vOISO6D7w7dmLs3Rq77WTSW7vmlYR9TO
X-Proofpoint-ORIG-GUID: vOISO6D7w7dmLs3Rq77WTSW7vmlYR9TO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_08,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 mlxlogscore=754
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309200149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/2023 7:52 AM, Kalle Valo wrote:
> Wu Yunchuan <yunchuan@nfschina.com> wrote:
> 
>> No need cast (void*) to (struct hal_rx_ppdu_end_user_stats *),
>> (struct ath12k_rx_desc_info *) or (struct hal_tx_msdu_ext_desc *).
>> Change the prototype to remove the local variable.
>>
>> Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
>> Suggested-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

For the Pending change:
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

