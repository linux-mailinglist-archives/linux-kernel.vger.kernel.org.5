Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214F478B218
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjH1Nhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbjH1Nhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:37:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B43CFB;
        Mon, 28 Aug 2023 06:37:05 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SDX8qX028394;
        Mon, 28 Aug 2023 13:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=GViM3/tL3UvdQVk3UIxa1wz7l24gOeny5OvFavC9lV8=;
 b=jH5/HuldpUTeT70uNeD4VFg6+UEa61e2DXokpukY5AyaPXwboYOox8a1ahkaofSMtq4O
 1WFxYB8t+ieNJYc4SWI8P41YN27nK7KMqdxsdOkBbLMNQhi/S2bqYDXKmHB+3WHjPOES
 Hvzie8sgjRAyg2oX5NV++8GLo0U/gmspeRtN68wmkGAA6CIz7eaRNJLSOORvivhG+wOg
 qTCposvXtf0g9j6/dR24q7kqEp5kAs0/c88cpbHgbnCeovRHr3GpXEvf1fCDgrhpi6ka
 pG1zrfar4pVm8rDBMt3iGdEcwvomI2YoLrjpgQUVIKxS4JEShpbUvwBaoV0eFHvdooZr Jw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sruhnr41h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 13:35:58 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37SDZv6U017410
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 13:35:57 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 28 Aug 2023 06:35:55 -0700
Date:   Mon, 28 Aug 2023 06:35:54 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Jani Nikula <jani.nikula@intel.com>
CC:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <quic_pkondeti@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, <workflows@vger.kernel.org>,
        <tools@linux.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] scripts: Add add-maintainer.py
Message-ID: <20230828133554.GA818859@hu-bjorande-lv.qualcomm.com>
References: <cover.1693037031.git.quic_gurus@quicinc.com>
 <141b9fcab2208ace3001df4fc10e3dfd42b9f5d9.1693037031.git.quic_gurus@quicinc.com>
 <87jztf37ny.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87jztf37ny.fsf@intel.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 239poMfsD4Fp-ipujqWFyvgT-Qa-f9Ny
X-Proofpoint-ORIG-GUID: 239poMfsD4Fp-ipujqWFyvgT-Qa-f9Ny
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_09,2023-08-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxlogscore=734 suspectscore=0 clxscore=1011 phishscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280118
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 11:14:41AM +0300, Jani Nikula wrote:
> On Sat, 26 Aug 2023, Guru Das Srinagesh <quic_gurus@quicinc.com> wrote:
> > This script runs get_maintainer.py on a given patch file (or multiple
> > patch files) and adds its output to the patch file in place with the
> > appropriate email headers "To: " or "Cc: " as the case may be. These new
> > headers are added after the "From: " line in the patch.
> 
> FWIW, I personally prefer tooling to operate on git branches and commits
> than patches. For me, the patches are just an intermediate step in
> getting the commits from my git branch to the mailing list. That's not
> where I add the Cc's, but rather in the commits in my local branch,
> where they're preserved. YMMV.
> 

May I ask how you add/carry the recipients in a commit?

Regards,
Bjorn
