Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019FC78D037
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 01:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240021AbjH2XSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 19:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240035AbjH2XRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 19:17:50 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D02B9C;
        Tue, 29 Aug 2023 16:17:44 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TMiv5g026041;
        Tue, 29 Aug 2023 23:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=4ATyD/tEgZ/efDPx/mmt2wlb1CN5pBAvQLDrRXLw3ok=;
 b=XMhcQly4dK6o3auQzr5fit1xLKIjjSF9UyzNGSzuo6DvWoxWZV3jjWNwiqL9d+ec5ufD
 +UAMD3URsK9EnNZ3ugBTmO4I+EaOBjHFjJRfb5Gh1N5tj1QyJzSTBj1H7QJYdgjLWxGe
 EF66/3AMsPfRDCz8K1+SNOjuHd/ymi8j59ZP6aTj2r5zhdt6geJwxoCJdmvYhQNwhCjw
 8G2/Z5trIJstAWDULDAeJomu+8SO54fO6B1hfncyDcvMCGf5Gf8yOHSIgSH88ehe9l7h
 mPdQDLaGyM3UbBlbNGJPBZf5qpIAUUdAkWhtiSXXUUPESrVrzpxRL5HDZfw/RG30pwcT bA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ssmcv8q8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 23:16:44 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37TNGh6H021191
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 23:16:43 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 29 Aug
 2023 16:16:40 -0700
Date:   Tue, 29 Aug 2023 16:16:39 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        "Konstantin Ryabitsev" <konstantin@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <quic_pkondeti@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, <workflows@vger.kernel.org>,
        <tools@linux.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        "Guru Das Srinagesh" <quic_gurus@quicinc.com>
Subject: Re: [PATCH v3 1/1] scripts: Add add-maintainer.py
Message-ID: <20230829231638.GA27843@quicinc.com>
Mail-Followup-To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quic_pkondeti@quicinc.com, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, workflows@vger.kernel.org,
        tools@linux.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <cover.1693037031.git.quic_gurus@quicinc.com>
 <141b9fcab2208ace3001df4fc10e3dfd42b9f5d9.1693037031.git.quic_gurus@quicinc.com>
 <2efba6b3-2399-9deb-d0ce-78f7b5e12f30@linaro.org>
 <20230828175629.GC23466@quicinc.com>
 <78aa33f9-ead8-b128-2a7a-40530a1a3ed0@linaro.org>
 <ZOz4XtX3DFRQpvQY@finisterre.sirena.org.uk>
 <670a87e9-2f0c-ec9e-ebb4-9041c8972ace@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <670a87e9-2f0c-ec9e-ebb4-9041c8972ace@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BTfg8Gx4HnM4ASTi3r21PGrkzeCDsTD-
X-Proofpoint-GUID: BTfg8Gx4HnM4ASTi3r21PGrkzeCDsTD-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=631 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290202
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 28 2023 21:45, Krzysztof Kozlowski wrote:
> On 28/08/2023 21:41, Mark Brown wrote:
> > On Mon, Aug 28, 2023 at 07:59:54PM +0200, Krzysztof Kozlowski wrote:
> >> On 28/08/2023 19:56, Guru Das Srinagesh wrote:
> > 
> >>> Your function adds mailing lists also in "To:" which is not ideal, in my view.
> >>> You've mentioned before that To or Cc doesn't matter [1] which I disagree
> >>> with: it doesn't matter, why does Cc exist as a concept at all?
> > 
> >> To/Cc does not matter when sending new patch, because maintainers know
> >> they are maintainers of which parts. I know what I handle.
> > 
> > That might be true for you (and also is for me) but I know there are
> > people who pay attention to if they're in the To: for various reasons, I
> > gather it's mostly about triaging their emails and is especially likely
> > in cases where trees have overlaps in the code they cover.
> 
> True, there can be cases where people pay attention to addresses of
> emails. Just like there are cases where people pay attention to "To/Cc"
> difference.
> 
> In my short experience with a few patches sent, no one complained to me
> that I put him/her/they in "To" field of a patch instead of "Cc" (with
> remark to not spamming to much, so imagine I send a patch for regulator
> and DTS). Big, multi-subsystem patchsets are different case and this
> script does not solve it either.

Not sure what you mean by "does not solve it" - what is the problem being
referred to here?

In case of multi-subsystem patches in a series, the commit message of this
patch explains exactly the actions taken.

> Anyway, if it is not ideal for Guru, I wonder how his LKML maintainer
> filters work that it is not ideal? What is exactly not ideal in
> maintainer workflow?

I am not a maintainer - only an individual contributor - and as such, even
though I may get patches on files I've contributed to, I deeply appreciate the
distinction between being Cc-ed in a patch vs To-ed in one. The distinction
being that if I'm in "To:" I ascribe higher priority to it and lesser if I'm in
"Cc:".

If this script is accepted and gains adoption, maintainers like yourself will
only be To-ed in patches that touch files that you're a direct "Maintainer" or
"Reviewer" of. For all other patches in the series you'll be in "Cc:". I
imagine that this can be very useful regardless of the specifics of your
workflow.

Also, lists should just be in "Cc:" - that's just my personal preference, but
one that I'm sure others also share.

Guru Das.
