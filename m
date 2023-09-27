Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54807AF9DC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 07:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjI0FQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 01:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjI0FP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:15:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986FA30E5;
        Tue, 26 Sep 2023 21:52:24 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38R4ptXj014457;
        Wed, 27 Sep 2023 04:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=Z64BspELQYklUyMuw2Voosf6kBu/hbiH9y7iQJ+gUIA=;
 b=dFBdyA6p++hhhsE6mqzTnITePHOg37C/ZW6aFLWIqyBzLEIR8NIiRp8rhjm3tOelv2L3
 q8JC0Rr9dsdb3JNjMC/lSUairmLI/0aGJUNtngrYK2iLjxayN292KsXMAuK7PsXEySq3
 bTc0IUyo2TFOLn3ir7YPY+OqU0OhatQf3l2O3Iyufy6j0bZs3OoD6C3FVJETsg0FEbbb
 hhat/F6BQsE0lSOMFlNxNE0rJLoX87OUkLylUnUp9HXWFvDv/83rBBjoQO5kWej1Tzff
 /Z+4/mKNSytoy0p5kHnpz7K+iyWkCblQ5DC7Je4gbFDEHpR80jMV8DoMJHHq+HwMNtFb 3Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tc6hrrnvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 04:51:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38R4pr8O015273
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 04:51:53 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 26 Sep 2023 21:51:44 -0700
Date:   Wed, 27 Sep 2023 10:21:42 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
Message-ID: <0f0bc437-e052-459d-bbda-bebeff1537ae@quicinc.com>
References: <cover.1693037031.git.quic_gurus@quicinc.com>
 <141b9fcab2208ace3001df4fc10e3dfd42b9f5d9.1693037031.git.quic_gurus@quicinc.com>
 <2efba6b3-2399-9deb-d0ce-78f7b5e12f30@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2efba6b3-2399-9deb-d0ce-78f7b5e12f30@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: z7aGvcNuRbOwYkrcvFk2aB5_lnJWKxi_
X-Proofpoint-ORIG-GUID: z7aGvcNuRbOwYkrcvFk2aB5_lnJWKxi_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_01,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 mlxlogscore=579 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270039
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 10:21:32AM +0200, Krzysztof Kozlowski wrote:
> On 26/08/2023 10:07, Guru Das Srinagesh wrote:
> > This script runs get_maintainer.py on a given patch file (or multiple
> > patch files) and adds its output to the patch file in place with the
> > appropriate email headers "To: " or "Cc: " as the case may be. These new
> > headers are added after the "From: " line in the patch.
> > 
> > Currently, for a single patch, maintainers and reviewers are added as
> > "To: ", mailing lists and all other roles are added as "Cc: ".
> > 
> > For a series of patches, however, a set-union scheme is employed in
> > order to solve the all-too-common problem of ending up sending only
> > subsets of a patch series to some lists, which results in important
> > pieces of context such as the cover letter (or other patches in the
> > series) being dropped from those lists. This scheme is as follows:
> > 
> > - Create set-union of all maintainers and reviewers from all patches and
> >   use this to do the following per patch:
> >   - add only that specific patch's maintainers and reviewers as "To: "
> >   - add the other maintainers and reviewers from the other patches as "Cc: "
> > 
> > - Create set-union of all mailing lists corresponding to all patches and
> >   add this to all patches as "Cc: "
> > 
> > - Create set-union of all other roles corresponding to all patches and
> >   add this to all patches as "Cc: "
> > 
> > Please note that patch files that don't have any "Maintainer"s or
> > "Reviewers" explicitly listed in their `get_maintainer.pl` output will
> 
> So before you will ignoring the reviewers, right? One more reason to not
> get it right...
> 
> > not have any "To: " entries added to them; developers are expected to
> > manually make edits to the added entries in such cases to convert some
> > "Cc: " entries to "To: " as desired.
> > 
> > The script is quiet by default (only prints errors) and its verbosity
> > can be adjusted via an optional parameter.
> > 
> > Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> > ---
> >  MAINTAINERS               |   5 ++
> >  scripts/add-maintainer.py | 164 ++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 169 insertions(+)
> >  create mode 100755 scripts/add-maintainer.py
> > 
> 
> I do not see the benefits of this script. For me - it's unnecessarily
> more complicated instead of my simple bash function which makes
> everything one command less than here.
> One more thing to maintain.

Thanks for your bash script. I slightly modified it to keep maintainers
in To and rest in Cc. 

git send-email --dry-run --to="$(scripts/get_maintainer.pl --no-multiline --separator=, --no-r --no-l --no-git --no-roles --no-rolestats --no-git-fallback *.patch)" --cc="$(scripts/get_maintainer.pl --no-multiline --separator=, --no-m --no-git --no-roles --no-rolestats --no-git-fallback *.patch)" *.patch

> 
> I don't see the benefits of this for newcomers, either. They should use
> b4. b4 can do much, much more, so anyone creating his workflow should
> start from b4, not from this script.

The ROI from b4 is huge. Totally agree that one should definitely consider b4 for
kernel patch submissions. I really liked b4 appending a unique "change-id"
across patch-versions. This is the single most feature I miss out from gerrit where
all revisions of a patch are glued with a common change-id. If everyone uses, a common
change-id for all versions of series, it is super easy to dig into archives.

Thanks,
Pavan

Thanks,
Pavan
