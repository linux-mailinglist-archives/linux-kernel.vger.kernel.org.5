Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACB977E730
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345047AbjHPRDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345050AbjHPRC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:02:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAE9103;
        Wed, 16 Aug 2023 10:02:55 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GCtD6G014036;
        Wed, 16 Aug 2023 17:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=mQL/ubOpOCVvSH/YDZTWN5K9XhRt1hFWYAP3tg6tKgU=;
 b=jPAUN9O1LHn70sEhJs3otJlkwvdz76eHp1IWXDQmSbBNjpHnZQJGXeIAQN+UBye5lO1E
 8BHwHQ9lYIQlkv6AjO5yXLMGgWQOPPQDX2jh9Lzgc6zCEFbRtWRs9DgRpay0NYkyMEki
 fs0kE3nDei26EXvmgh3GRmoj8qQ3wvFz1w8knTySimkHcvQBuIqb5OGdoPnKJ+u61LkF
 odpQUkAFirFc9AQ3aRyjE2BLfDpgOVxBJEex1EX59r4wrJjL2beL9ThuKnWIpzS5tXEI
 /PMq18xEFEO9Vz54JbvVwCfAec35NbBmG7cMI3JTQtQY/x/wXvsrI/7A9YTHaHjljItb /g== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sgf5uaarx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 17:02:40 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37GH2cJX016162
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 17:02:38 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 16 Aug
 2023 10:02:37 -0700
Date:   Wed, 16 Aug 2023 10:02:33 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Robert Marko <robimarko@gmail.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mojha@quicinc.com>,
        <computersforpeace@gmail.com>
Subject: Re: [PATCH v3 2/4] firmware: qcom_scm: disable SDI if required
Message-ID: <20230816170232.GA26279@quicinc.com>
References: <20230816164641.3371878-1-robimarko@gmail.com>
 <20230816164641.3371878-2-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230816164641.3371878-2-robimarko@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RRV8N2iztFnBwow1eBB_xDypdGCKMq6c
X-Proofpoint-GUID: RRV8N2iztFnBwow1eBB_xDypdGCKMq6c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_17,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 mlxlogscore=516 clxscore=1011 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 16 2023 18:45, Robert Marko wrote:
> IPQ5018 has SDI (Secure Debug Image) enabled by TZ by default, and that
> means that WDT being asserted or just trying to reboot will hang the board
> in the debug mode and only pulling the power and repowering will help.
> Some IPQ4019 boards like Google WiFI have it enabled as well.
> 
> Luckily, SDI can be disabled via an SCM call.
> 
> So, lets use the boolean DT property to identify boards that have SDI
> enabled by default and use the SCM call to disable SDI during SCM probe.
> It is important to disable it as soon as possible as we might have a WDT
> assertion at any time which would then leave the board in debug mode,
> thus disabling it during SCM removal is not enough.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Reviewed-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
