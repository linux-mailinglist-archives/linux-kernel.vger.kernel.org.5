Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9127CF046
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjJSGoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjJSGog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:44:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3EFB0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 23:44:34 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39J4gl6D022537;
        Thu, 19 Oct 2023 06:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=V8Y7x8UraueFxVKVMqR8JbqzcQQnarTUUx02ADqzL/Q=;
 b=e30Oy6DLdIe/Aqezq0ROiFuOE5DMx3XTllCw/5wAif72a4qv3ZGXqYZmb6N1WVOD7zhu
 lYFEdWOuoDRSXcbj0kyEGLzbBgyNO91gjMFLu9VxpTt742m3012N/ZgxqypL9tvBjr3Q
 VSZWu7/C1KxDQEAGEsrefoPuOPhnaHHpNv7a/pOAt0pvOcemOYz9GaF84pezI0SB1q8g
 Y4jE/p5cpVM5LXHvQZr6JgWoaLE/GgxX22/UZ7fI3NlKWUxPDukJnwW7Xpe21608RJt9
 YD5lNNl4SVQ+QDPllaTGIAXkQA/UiW0ssuMruTgHptbLuBAODGqJppOPb447x0EBQCy7 5w== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tt5v839qb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 06:44:12 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39J6iBo0008330
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 06:44:11 GMT
Received: from [10.214.66.187] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 18 Oct
 2023 23:44:06 -0700
Message-ID: <d752e44a-d420-3bb4-e8fc-c8eee7304675@quicinc.com>
Date:   Thu, 19 Oct 2023 12:13:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 1/4] add generic builtin command line
To:     "Daniel Walker (danielwa)" <danielwa@cisco.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>,
        "dwalker@fifo99.com" <dwalker@fifo99.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "maksym.kokhan@globallogic.com" <maksym.kokhan@globallogic.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "tomas.mudrunka@gmail.com" <tomas.mudrunka@gmail.com>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        <quic_guptap@quicinc.com>, <quic_ylal@quicinc.com>,
        <quic_vjitta@quicinc.com>
References: <20230417162415.GF1391488@zorba>
 <4c420081-fe57-d036-ded7-2899c13738ee@quicinc.com> <ZS6YIjZznHMojNLO@goliath>
Content-Language: en-US
From:   Pratyush Brahma <quic_pbrahma@quicinc.com>
In-Reply-To: <ZS6YIjZznHMojNLO@goliath>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: R5ekLEn_H0aCNKQIuq6bDIlWF02rb0tN
X-Proofpoint-ORIG-GUID: R5ekLEn_H0aCNKQIuq6bDIlWF02rb0tN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_05,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=798 lowpriorityscore=0 phishscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190057
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17-10-2023 19:51, Daniel Walker (danielwa) wrote:
> On Tue, Oct 17, 2023 at 04:10:42PM +0530, Pratyush Brahma wrote:
>> For such a usecase, the CONFIG_CMDLINE_PREPEND seems to be quite useful as
>> it would help to stitch bootloader
>> and the desired build variant's configs together. Can you please help to
>> merge this patch?
> Yes, your at least the second person that's asked for it, and it's been on my
> list for some time to release again. I'll try to release it as soon as possible.
>
> Daniel

Thanks Daniel.

Please have this config support for arm64 as well. Previously arm64 used 
to support CONFIG_CMDLINE_EXTEND
which was useful for our usecase. However it was dropped from commit 
cae118b6acc309539b33339e846cbb19187c164c
referring to your patch series as an alternative. Hence the need.

Pratyush
