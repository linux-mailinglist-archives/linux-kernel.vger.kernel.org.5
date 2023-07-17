Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C07C756EE9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 23:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjGQVXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 17:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjGQVXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 17:23:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07698E7;
        Mon, 17 Jul 2023 14:23:16 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HKi7gZ005639;
        Mon, 17 Jul 2023 21:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=cytvABo84vy7mFR/hVdvACmKWzXDqxPDfu+u5PnjsJo=;
 b=FHxJcVEgoY7dV1lsYEY0EjdxUUqKcZF+3cpWoPMYUgnLIENvJh32oWx/FFqIVdHGxL5g
 2SOS7HuKU+sXy5RG9dl2wZ6gNwJyO4UB98EweFM/2Dk/ThIT/5uKu7ec4mZTrFTpbzky
 WK4MvZtuaIbcmZyyr2O3yGs/A/uGMpIHcQDawszI6OtohwdtxQhhEEjJeyt5POzWgknc
 LzP5rwuR5CZK90xlDIn4lrTlS7LnngULIZ0Qv2923DLfrBXznyN//N72vgAnFSjEzAL4
 OJ9rUb2l+bstblTrTpfmNkjXFXP4whDQWU5+t8mDbxDeSDoUObIpDrxpARMm/ai/1QLI vA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3run0avkey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 21:23:11 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36HLNADK003222
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 21:23:10 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 17 Jul 2023 14:23:10 -0700
Date:   Mon, 17 Jul 2023 14:23:09 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>
Subject: Re: [RESEND] clk: qcom: rcg: Update rcg configuration before
 enabling it
Message-ID: <20230717212309.GA4176673@hu-bjorande-lv.qualcomm.com>
References: <20230712014812.3337992-1-quic_skakitap@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230712014812.3337992-1-quic_skakitap@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vptW1ctTBT4fQwY_XCWZZB6spRdZSs8r
X-Proofpoint-ORIG-GUID: vptW1ctTBT4fQwY_XCWZZB6spRdZSs8r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=852 bulkscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 07:18:12AM +0530, Satya Priya Kakitapalli wrote:
> From: Taniya Das <quic_tdas@quicinc.com>
> 
> If rcg is in disabled state when clk_rcg2_shared_set_rate is called, the
> new configuration is written to the configuration register but it won't be
> effective in h/w yet because update bit won't be set if rcg is in disabled
> state.

Does this take commit '703db1f5da1e ("clk: qcom: rcg2: Cache CFG
register updates for parked RCGs")', which was merged in v5.19, into
consideration?

> Since the new configuration is not yet updated in h/w, dirty bit of
> configuration register will be set in such case. Clear the dirty bit and
> update the rcg to proper new configuration by setting the update bit before
> enabling the rcg.
> 

For a shared rcg2, which was updated while disabled, updates will be
carried in the "parked_cfg" variable and the RCG_CFG will be stale so
invoking update_config() should lead to exactly the problem you describe
fixing here.

Perhaps I'm missing something here, can you please confirm that this has
been validated on a recent upstream kernel?

> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
> Resending this patch as there is no review for 2 months.
> 

Thanks for bumping the discussion.

Regards,
Bjorn
