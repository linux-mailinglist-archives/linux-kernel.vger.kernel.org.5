Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41907CC0D3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343511AbjJQKlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjJQKl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:41:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82513A2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 03:41:27 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39H8GRuK014171;
        Tue, 17 Oct 2023 10:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : to : cc : references : subject : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zBhBLqqpj0n+5jzHyUrlt0lv7F+dDsbPhpjc08ioUEQ=;
 b=TDwQC0HikJ/UYtBkHD7h61cTXujZv3SrZ2WUb9ePKx+DvDe87gLqT+FD7MnliGdvN29L
 j14jiq6axOjLHO1GP6uQa6DGkzRkbe/Lpt/WQCUXl9HLh88EuPvkgMv2Dt0dZTLW4Dq1
 I98etMMnLTHGlR2f0FKoisvScNqjsm2EuPKCWBSMnc2PrrSSS+mjs4VJazOScTVArgPt
 m0FhiKbUR6hPXP/IVTeGYQpjXn7cQP1ufkal/suuta02ffDjRfKwlAdFcezMHPh9h8Qs
 2xK7v1ujUY3mYoub8nXof5TN6l4ZwiLybDjmeDJ/ONiWV0wmYWfynFk2H8tweN79kZwj Vg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ts85fta6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 10:41:08 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39HAewZd022148
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 10:40:58 GMT
Received: from [10.214.66.187] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 17 Oct
 2023 03:40:54 -0700
Message-ID: <4c420081-fe57-d036-ded7-2899c13738ee@quicinc.com>
Date:   Tue, 17 Oct 2023 16:10:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
To:     <danielwa@cisco.com>
CC:     <akpm@linux-foundation.org>, <christophe.leroy@c-s.fr>,
        <dwalker@fifo99.com>, <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <maksym.kokhan@globallogic.com>,
        <mpe@ellerman.id.au>, <robh+dt@kernel.org>,
        <tomas.mudrunka@gmail.com>, <xe-linux-external@cisco.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        <"quic_guptap@quicinc.com quic_ylal"@quicinc.com>,
        <quic_vjitta@quicinc.com>
References: <20230417162415.GF1391488@zorba>
Subject: Re: [PATCH 1/4] add generic builtin command line
Content-Language: en-US
From:   Pratyush Brahma <quic_pbrahma@quicinc.com>
In-Reply-To: <20230417162415.GF1391488@zorba>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MRvxMaYkqsM1Y31hTxHRI_3fVzxS599_
X-Proofpoint-GUID: MRvxMaYkqsM1Y31hTxHRI_3fVzxS599_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 mlxlogscore=535
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170089
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel

We have a usecase which requires this patch necessarily. For android 
usecases, we have two different build variants
differentiated by defconfigs - production and debug. However, we only 
have a single dts for both these variants.


We want to enable certain features like page owner and slub debug which 
require cmdline params in addition to
their respective configs to be enabled. Enabling page_owner and 
slub_debug options in dts file enables it for both
production and debug variants. These features have significant memory 
overhead which are undesirable for
our production environment. However, these are necessary for debug 
environment to enable internal testing and debug.
Currently, android uses out-of-tree configs like CONFIG_CMDLINE_EXTEND 
to do so in gki_defconfig [1].
One option is to use CMDLINE_FORCE option which would enable these 
cmdline params but this disables the bootloader to add
any additional cmdline params which may be necessary.


For such a usecase, the CONFIG_CMDLINE_PREPEND seems to be quite useful 
as it would help to stitch bootloader
and the desired build variant's configs together. Can you please help to 
merge this patch?


[1] 
https://android.googlesource.com/kernel/common/+/refs/heads/android14-6.1-lts/arch/arm64/configs/gki_defconfig#62

