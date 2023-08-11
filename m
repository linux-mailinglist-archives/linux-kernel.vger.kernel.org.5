Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E47779106
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbjHKNvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjHKNvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:51:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB33718F;
        Fri, 11 Aug 2023 06:51:40 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BDW5pR023281;
        Fri, 11 Aug 2023 13:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EdJ7xk6KBRC6ekdTqcGFDBr4UL/D1NvEBLqYNr6O/8g=;
 b=jujjhG0MVpvETWiv90rkrXnDzvALXGfBGtDjwcIGcHmBaaKYX8fc/2H4fIKmLFAn8CUB
 BlDrYAgWePOtNgPrCJ73gqCnO6A6yiNpuUQbmVXzl4BHB9DKwoNodxoDPZ2J1B4kaqE0
 8u8G5RIskZuDWDbH/1l2gmyxNDdJap3Xv62aR5gdDDm+uuDg0TqllSA6M5bR3k/0nr9R
 DwwZHafFnNSCmfF8CBdZeJATq9s9lFzoyHJWjD0W7rPf2U0UingMkDW1s2fDg+zJIZMP
 z0AknAcvRJyxW7VrqUMmKoMsa29QJv/5wpSCrDscExVFQXBDJ8Nwsty6EWhnMDNFfvCq ww== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sd8ywsssk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 13:51:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37BDpP9m029487
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 13:51:25 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 11 Aug
 2023 06:51:24 -0700
Message-ID: <1c51f302-e79e-5aa4-e9a8-73a244a240ce@quicinc.com>
Date:   Fri, 11 Aug 2023 07:51:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] bus: mhi: host: remove unused-but-set parameter
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
CC:     Arnd Bergmann <arnd@arndb.de>, Tom Rix <trix@redhat.com>,
        Vivek Pernamitta <quic_vpernami@quicinc.com>,
        Carl Vanderlip <quic_carlv@quicinc.com>,
        "Qiang Yu" <quic_qianyu@quicinc.com>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>
References: <20230811134547.3231160-1-arnd@kernel.org>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20230811134547.3231160-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4hbVszYQnY-wuP1oyx0JEB6dwTAGI-U9
X-Proofpoint-ORIG-GUID: 4hbVszYQnY-wuP1oyx0JEB6dwTAGI-U9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_05,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 phishscore=0 mlxlogscore=743 lowpriorityscore=0
 clxscore=1011 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110126
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/2023 7:45 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Clang warns about a parameter that is decremented but never evaluated heere:
> 
> bus/mhi/host/main.c:803:13: error: parameter 'event_quota' set but not used [-Werror,-Wunused-but-set-parameter]
>                               u32 event_quota)
> 
> Remove the access to the variable to avoid that warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

