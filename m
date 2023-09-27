Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C2D7B0EFF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 00:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjI0Wpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 18:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjI0Wpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 18:45:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D00AF;
        Wed, 27 Sep 2023 15:45:44 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RMhLEc021202;
        Wed, 27 Sep 2023 22:44:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=2WzMCyujUUN8vsItkqe30uu8LNBKln4ud1vWe5HQBXc=;
 b=gp/ksm5e9YgMqVJk1uaNNgbzZXcDL9Y5PUlM8QRbA/WQGoOju4jq+yo6DBVFV/arFrxr
 3Lsii92FbWJhJiVUmyzbCbKMgKESQ1iw3zecNq+yFsqdSoynyWjQqR/5LVHFF2uk6r9B
 6OlyhnZ1WNYXmPOHIp2+W2d7FEw2Yy00vavA/7K2mTyYLJuQnzIMKW76PyAz60YHY8Uk
 cYH7LJP3EgAgYFADMUcwJ+SAfU2zn9EXDZi/OXxd5sDTINUz8mZbCXbxNrmetlf13KdP
 30+NKDfSkehHZsm+71weqSzFdgJlcWQGP66V+I7zQ7KdternlvvZbsAEF56KyfDJIUF3 bA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tc43mu1gr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 22:44:34 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38RMiXT1007881
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 22:44:33 GMT
Received: from quicinc.com (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 27 Sep
 2023 15:44:30 -0700
Date:   Wed, 27 Sep 2023 15:44:28 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        "Konstantin Ryabitsev" <konstantin@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <workflows@vger.kernel.org>, <tools@linux.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] scripts: Add add-maintainer.py
Message-ID: <ZRSwTBkhlg5kj7jf@quicinc.com>
Mail-Followup-To: Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@quicinc.com,
        workflows@vger.kernel.org, tools@linux.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <cover.1693037031.git.quic_gurus@quicinc.com>
 <141b9fcab2208ace3001df4fc10e3dfd42b9f5d9.1693037031.git.quic_gurus@quicinc.com>
 <2efba6b3-2399-9deb-d0ce-78f7b5e12f30@linaro.org>
 <0f0bc437-e052-459d-bbda-bebeff1537ae@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0f0bc437-e052-459d-bbda-bebeff1537ae@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: T6hX6RCIoYGyX4HlYCDsPLRHDWQvfoYp
X-Proofpoint-GUID: T6hX6RCIoYGyX4HlYCDsPLRHDWQvfoYp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_15,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 bulkscore=0 phishscore=0 mlxlogscore=819 malwarescore=0
 adultscore=0 spamscore=0 clxscore=1011 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270195
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 27 2023 10:21, Pavan Kondeti wrote:
> On Mon, Aug 28, 2023 at 10:21:32AM +0200, Krzysztof Kozlowski wrote:
> > On 26/08/2023 10:07, Guru Das Srinagesh wrote:
> > > This script runs get_maintainer.py on a given patch file (or multiple
> > > patch files) and adds its output to the patch file in place with the
> > > appropriate email headers "To: " or "Cc: " as the case may be. These new
> > > headers are added after the "From: " line in the patch.
> > > 
> > > Currently, for a single patch, maintainers and reviewers are added as
> > > "To: ", mailing lists and all other roles are added as "Cc: ".
> > > 
> > > For a series of patches, however, a set-union scheme is employed in
> > > order to solve the all-too-common problem of ending up sending only
> > > subsets of a patch series to some lists, which results in important
> > > pieces of context such as the cover letter (or other patches in the
> > > series) being dropped from those lists. This scheme is as follows:
> > > 
> > > - Create set-union of all maintainers and reviewers from all patches and
> > >   use this to do the following per patch:
> > >   - add only that specific patch's maintainers and reviewers as "To: "
> > >   - add the other maintainers and reviewers from the other patches as "Cc: "
> > > 
> > > - Create set-union of all mailing lists corresponding to all patches and
> > >   add this to all patches as "Cc: "
> > > 
> > > - Create set-union of all other roles corresponding to all patches and
> > >   add this to all patches as "Cc: "
> > > 
> > > Please note that patch files that don't have any "Maintainer"s or
> > > "Reviewers" explicitly listed in their `get_maintainer.pl` output will
> > 
> > So before you will ignoring the reviewers, right? One more reason to not
> > get it right...
> > 
> > > not have any "To: " entries added to them; developers are expected to
> > > manually make edits to the added entries in such cases to convert some
> > > "Cc: " entries to "To: " as desired.
> > > 
> > > The script is quiet by default (only prints errors) and its verbosity
> > > can be adjusted via an optional parameter.
> > > 
> > > Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> > > ---
> > >  MAINTAINERS               |   5 ++
> > >  scripts/add-maintainer.py | 164 ++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 169 insertions(+)
> > >  create mode 100755 scripts/add-maintainer.py
> > > 
> > 
> > I do not see the benefits of this script. For me - it's unnecessarily
> > more complicated instead of my simple bash function which makes
> > everything one command less than here.
> > One more thing to maintain.
> 
> Thanks for your bash script. I slightly modified it to keep maintainers
> in To and rest in Cc. 
> 
> git send-email --dry-run --to="$(scripts/get_maintainer.pl --no-multiline --separator=, --no-r --no-l --no-git --no-roles --no-rolestats --no-git-fallback *.patch)" --cc="$(scripts/get_maintainer.pl --no-multiline --separator=, --no-m --no-git --no-roles --no-rolestats --no-git-fallback *.patch)" *.patch

FYI, b4 has "b4.send-auto-to-cmd" and "b4.send-auto-cc-cmd" [1] as well to
override its default behaviour. You can just set the above two b4 config
options as you like and it will do the right thing.

Guru Das.
