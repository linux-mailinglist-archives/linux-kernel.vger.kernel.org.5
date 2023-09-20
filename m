Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7AE7A8B83
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjITSR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjITSR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:17:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB897DE;
        Wed, 20 Sep 2023 11:17:50 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KIExqm008835;
        Wed, 20 Sep 2023 18:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NinWY8XgmAiihUjTdTLbDoT9e3k4KCbrdABqf7MAI+o=;
 b=cnRndOUwR9nQIPvGSlp3+ZDvPkSv0HGg4D/guLRA2vHd2gqOLVBSiUPVRnAv/A/R18TO
 fpfbqaDfCKs2jKjiUAh3chmz9MemtXuR5rfu5bcDJv6fFMXOpo8MY8+vy9sO55zPxUnT
 WdjkfjQO26vZ7S2M892cuGGM07I8k9X028CjxRi4CcecJQzDI17cMIXcp1/x+mCqyO/w
 /0ctI0ooJ4U1lK9KN0rhT/VnYd7TyntZWzG1D83Y4wxplRONEvOvhtMUKlzkU37hFNQg
 t8qQR1LGj9XTjwHr5Ctztd9ynHe9cCfuRBYGQERk6FG/zFgY7MW0o0fTJPoj8Kiq1c46 qg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t7qujhxpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 18:17:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38KIHgTU029679
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 18:17:42 GMT
Received: from [10.48.245.144] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 20 Sep
 2023 11:17:42 -0700
Message-ID: <0a93f63b-9062-4200-9126-7fada88c5aa6@quicinc.com>
Date:   Wed, 20 Sep 2023 11:17:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 wireless-next 5/9] ath6kl: remove unnecessary (void*)
 conversions
Content-Language: en-US
To:     Wu Yunchuan <yunchuan@nfschina.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20230919045008.523730-1-yunchuan@nfschina.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230919045008.523730-1-yunchuan@nfschina.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eY1uONcBrREykX7IkqR_P9yFyUgQgZ8P
X-Proofpoint-ORIG-GUID: eY1uONcBrREykX7IkqR_P9yFyUgQgZ8P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_08,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=771
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200151
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/2023 9:50 PM, Wu Yunchuan wrote:
> No need cast (void *) to (struct ath6kl *) or
> (struct ath6kl_cookie *).
> 
> Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>

Subject should have wifi: prefix added. Kalle can do that when he merges.

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

