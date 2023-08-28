Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AC078B6D4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjH1R5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbjH1R4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:56:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF71C185;
        Mon, 28 Aug 2023 10:56:52 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SGJ4Hx000814;
        Mon, 28 Aug 2023 17:56:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=1x5rlXTyf3rFYzB2POOoRa7o3PGeg4tEVqJTmUMWTPU=;
 b=cEAxZRb918yS38Jw1ls7ftTUFznu3xcfKYr2/WYmMGSxshKGzUs89XlvYz16iq0TumRf
 rVdapYNQcP/xA4D2l5EgtqKjfEPHmxICXcGD/AbyNJX+Rn8dHbupOivUSJbCrfiwAo9T
 U99Lhsf6wniiAMAD/iHrv7FmZ0gLKRJYA4KHIFVHHIhJVgIxlYEiuu/fmpiEHFBADVA1
 AmqXSTYUb73AAFiVYI6ZI+wTJCveYjfBzeqo6q4OFDQNyDY640sk39UPSsAngOrSr3+j
 Hs/u7awfpxT+IFQ1ONSBQqZOEAeToukCCJOf2mALHQTZlgbYv5o9RyFemqawcSsXgNNG Qg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sq9sdm2jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 17:56:34 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37SHuXtU017889
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 17:56:33 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 28 Aug
 2023 10:56:31 -0700
Date:   Mon, 28 Aug 2023 10:56:29 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
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
Message-ID: <20230828175629.GC23466@quicinc.com>
Mail-Followup-To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2efba6b3-2399-9deb-d0ce-78f7b5e12f30@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ninS63_k0bFr28tw0dwIdU5DGWC9_-x_
X-Proofpoint-ORIG-GUID: ninS63_k0bFr28tw0dwIdU5DGWC9_-x_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_15,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 clxscore=1015 mlxlogscore=651 mlxscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280158
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 28 2023 10:21, Krzysztof Kozlowski wrote:
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

In v2, Reviewers were added as "Cc:" whereas here in v3 they are added as
"To:". Not sure where you're getting "ignoring the reviewers" from.

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

Your function adds mailing lists also in "To:" which is not ideal, in my view.
You've mentioned before that To or Cc doesn't matter [1] which I disagree
with: it doesn't matter, why does Cc exist as a concept at all?

[1] https://lore.kernel.org/lkml/af1eca37-9fd2-1e83-ab27-ebb51480904b@linaro.org/

Thank you.

Guru Das.
