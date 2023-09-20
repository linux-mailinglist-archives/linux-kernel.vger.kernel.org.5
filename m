Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6827A8B75
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjITSRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjITSRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:17:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69529CA;
        Wed, 20 Sep 2023 11:17:17 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KIF1ob000901;
        Wed, 20 Sep 2023 18:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tiJNMK96sISeNic9l/ccZjrYr/lRLHKhPAPSf/CuSJ8=;
 b=bNa0Xoeg6PhkRuWRSVDLhJHw+zbt5CTrxkJEpn9OLIIheTjcdvIkFJCNjJtJ01AEi8Am
 96AikriGN2ok+PgCQs9V7TZ4SI+Q0F9oZK79AP4l286Cl//crRvF51X7y1jf81ZsBYmJ
 LEAtn15kJerIpbAFNi7tiOzlzf3acXussLIJ5kMuAkQ/QRsTql0FW6njHhCBLrykSfNF
 NGyZpqRglhYL2VeAyGe1WxlYTSgbh17UsNci97jgCxg42vekPfjp1tG3PGwM/suSnqG/
 V5/oaej3D35+6d3QC3JNn7mSaU1Mxy0GfbahuLPtUDm9x+nLFizfpNnFWyfx4ppEXkgs qw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t78upm1eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 18:16:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38KIGtdY028858
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 18:16:55 GMT
Received: from [10.48.245.144] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 20 Sep
 2023 11:16:55 -0700
Message-ID: <b7f9728d-b17f-4869-a862-c86ada8a0c25@quicinc.com>
Date:   Wed, 20 Sep 2023 11:16:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 wireless-next 3/9] wifi: wcn36xx: remove unnecessary
 (void*) conversions
Content-Language: en-US
To:     Wu Yunchuan <yunchuan@nfschina.com>, <loic.poulain@linaro.org>,
        <kvalo@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>
CC:     <wcn36xx@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>
References: <20230919044925.523403-1-yunchuan@nfschina.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230919044925.523403-1-yunchuan@nfschina.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vy7f_bbCQtXatua65eoffe48_FcEQy_O
X-Proofpoint-ORIG-GUID: vy7f_bbCQtXatua65eoffe48_FcEQy_O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_08,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=845 suspectscore=0
 spamscore=0 clxscore=1011 adultscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200151
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/2023 9:49 PM, Wu Yunchuan wrote:
> No need cast (void *) to other types such as (struct wcn36xx *),
> (struct wcn36xx_hal_update_scan_params_resp *), etc.
> 
> Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

