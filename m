Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EA47CD104
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 01:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344338AbjJQXsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 19:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjJQXsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 19:48:05 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A9193;
        Tue, 17 Oct 2023 16:48:03 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HNT8Eh018343;
        Tue, 17 Oct 2023 23:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DJoVEfqFMIqV1HS5dvMlwjU/EVOBb+1dppBYz/22x64=;
 b=IKE+gyGbd/y5V4x/BLos/pmADc6/9nAEs95JGJJd9hKQEnMl/FvYJv0tFK+w+IH6jjaW
 9ypoBxSebCAgULnSYdpAGJfehhahF/ttEzX+gnSI3dAUx0wrgHmKWaLgYX4h7f0DW71H
 1F1f8xgI7X1zx2HztX/v7pWbiamcKh7I81nlGYk0g5DaTbEggX/hzoft1WHBepUz1gf6
 YHQ+lryCk2+dARpysI6qnUiaxHsLsWDMxIL6om14pIHGA6MEIVOk12PyxGSP3FoSRcA9
 AMbs2dd0v0Y2V6FsKZVxIStIrMlA3a16+RKZS4W3nftegDL5acZMiVAKHqNT1eFly40v Cw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ts85fuwk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 23:47:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39HNlvbi004065
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 23:47:57 GMT
Received: from [10.111.183.229] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 17 Oct
 2023 16:47:57 -0700
Message-ID: <36928c4f-3353-42c7-a42f-2bc31e1eee89@quicinc.com>
Date:   Tue, 17 Oct 2023 16:47:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wl18xx: replace deprecated strncpy with strscpy
Content-Language: en-US
To:     Justin Stitt <justinstitt@google.com>,
        Kalle Valo <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>
References: <20231017-strncpy-drivers-net-wireless-ti-wl18xx-main-c-v1-1-ed5322ec8068@google.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231017-strncpy-drivers-net-wireless-ti-wl18xx-main-c-v1-1-ed5322ec8068@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ---xUCgFdwsCS9tW5717FXPkhoNc1glg
X-Proofpoint-GUID: ---xUCgFdwsCS9tW5717FXPkhoNc1glg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_07,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 mlxlogscore=378
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170201
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch (and a few others in your recent set) are missing the wifi: 
prefix. this prefix is a relatively new addition and would not show up 
in the history of some of these ancient drivers you are touching :)
