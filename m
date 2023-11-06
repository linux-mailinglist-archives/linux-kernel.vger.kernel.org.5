Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8610B7E29D3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbjKFQd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjKFQdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:33:53 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A93A4;
        Mon,  6 Nov 2023 08:33:50 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6G1jXO017862;
        Mon, 6 Nov 2023 16:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=STkmTe5rIC/2ejeHvl/1lIfOskilFGYF5p+NP1HVvk8=;
 b=Ye0cUa6tBdk1xd4P3WvwaghSDGIOHqIPxbwbEZlxtI7lpKcv/YuXRRl+MNJqUTJz6dQg
 neaha6GN8ZFxNa1JOprSbuiZayEYK+zMOtk+JHPaOSVnzKzfyOg2ANKrYqsMznMbb6zH
 mfuLrnJC8UKBbVfMXWinGAZzMLBNNre9ZdKjtQ4tB8fIJTFu0Hu/w3ychWTq4uXeKyUU
 06Quo6FN9M8B6WfjiVUNTyHIP1fQxUsGJdj20DqPbF5FpTRtvOi9HWMvjxAN14jiFWln
 DGaItIl29tWQH28JebcPtxW1JjNGbNBS3mu8ztHFVfsoo4+dBKhpJZ6Z1F8kpNpp8cb2 +Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u73a702hm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 16:33:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A6GXeG1009410
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Nov 2023 16:33:40 GMT
Received: from [10.110.1.228] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 6 Nov
 2023 08:33:40 -0800
Message-ID: <ec7d829b-28c3-400b-97f9-e6d2f5a4d4aa@quicinc.com>
Date:   Mon, 6 Nov 2023 08:33:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] wifi: rt2x00: improve watchdog support
Content-Language: en-US
To:     Shiji Yang <yangshiji66@outlook.com>,
        <linux-wireless@vger.kernel.org>
CC:     Stanislaw Gruszka <stf_xl@wp.pl>, Kalle Valo <kvalo@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <TYAP286MB0315D63EBE1DE458D6B9D42ABCA4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <TYAP286MB0315D63EBE1DE458D6B9D42ABCA4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jt2Tg85W3KmuZCTcQe6xPOj0NYkz9ARs
X-Proofpoint-GUID: jt2Tg85W3KmuZCTcQe6xPOj0NYkz9ARs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_12,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=392 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060133
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/2023 1:57 AM, Shiji Yang wrote:
> P.S. It seems that this cover letter won't be included in the patch
> series in https://lore.kernel.org/. It's an issue with the Outlook
> email or I missed something?

Outlook e-mail is apparently rewriting your e-mail headers:

Subject: [PATCH v2 0/3] wifi: rt2x00: improve watchdog support
Message-ID: 
<TYAP286MB0315D63EBE1DE458D6B9D42ABCA4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Microsoft-Original-Message-ID: 
<20231104085800.17576-1-yangshiji66@outlook.com>

Subject: [PATCH v2 1/3] wifi: rt2x00: introduce DMA busy check watchdog 
for rt2800
Message-ID: 
<TYAP286MB0315D7462CE08A119A99DE34BCA4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <20231104085800.17576-1-yangshiji66@outlook.com>
References: <20231104085800.17576-1-yangshiji66@outlook.com>

Subject: [PATCH v2 2/3] wifi: rt2x00: disable RTS threshold for rt2800 
by default
Message-ID: 
<TYAP286MB03155DDB953155B7A2DE849ABCA4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <20231104085800.17576-1-yangshiji66@outlook.com>
References: <20231104085800.17576-1-yangshiji66@outlook.com>

Your actual patches are being threaded since they all reference the same 
Message ID, but the cover letter no longer has that Message ID.

You might want to look at using b4 
(<https://b4.docs.kernel.org/en/latest/contributor/overview.html>) 
instead of git send-email.

 From the linked page:
The main benefit of b4 send is that you no longer have to really care if 
your mail server performs some kind of content mangling that causes 
patches to become corrupted, or if it doesn’t provide a way to send mail 
via SMTP.

