Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0372478B59E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjH1Qvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjH1QvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:51:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4661611D;
        Mon, 28 Aug 2023 09:51:22 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SDu4ce002687;
        Mon, 28 Aug 2023 16:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=qcppdkim1;
 bh=E/zxHmDC4jra0NMakqWCnkItMllF7m7krjnAu1g88Qk=;
 b=ghc2czfMxhuRXtTR+9VP5Kp9j77h5+Jmjb/v0VD+J8OjT3GbvrKmx2nMoPxznwwMbDg8
 MM9gjP7sgG21wCaVug6rfAp9HBs2qzNQcihryJ6MqKmZxJMn/hR6XI4SNIG+3+kqguoc
 inDHu4iN4zUBzE0Re82ZieLc8jhKqel0JCRJJ/+fSfi6/DA24Gz1CqOfHSALtr2QUI4r
 SKhwwEiJhgP3WBYVvnZAv1twvYiNWbbX75GIjrnPU/lthZHu7eAWcYzLX7bKDA91mKpF
 vD3a+hvdfQTSidlhO6t16dsHa7aCPl8ClJaVhCHEsUcb5N5jZuMv0K251Y8KK6IAU1d+ cg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sq73n4dgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 16:50:42 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37SGofbQ014202
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 16:50:41 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 28 Aug 2023 09:50:39 -0700
Date:   Mon, 28 Aug 2023 09:50:38 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Vlastimil Babka <vbabka@suse.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jani Nikula <jani.nikula@intel.com>,
        "Guru Das Srinagesh" <quic_gurus@quicinc.com>,
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
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] scripts: Add add-maintainer.py
Message-ID: <20230828165038.GB818859@hu-bjorande-lv.qualcomm.com>
References: <cover.1693037031.git.quic_gurus@quicinc.com>
 <141b9fcab2208ace3001df4fc10e3dfd42b9f5d9.1693037031.git.quic_gurus@quicinc.com>
 <87jztf37ny.fsf@intel.com>
 <20230828133554.GA818859@hu-bjorande-lv.qualcomm.com>
 <CAMuHMdU+3oj+-3=f5WFVTRsKQjqCpU8SnVqKSZGk8XRxhsDcVQ@mail.gmail.com>
 <9aec0740-2482-d3ad-caf2-5e6278a050b3@suse.cz>
 <89c73602-43f1-30a4-ad58-637aadacd653@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89c73602-43f1-30a4-ad58-637aadacd653@linaro.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _fsIvEDya7IumSFW2M3hfpnyM2ztud7x
X-Proofpoint-ORIG-GUID: _fsIvEDya7IumSFW2M3hfpnyM2ztud7x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_14,2023-08-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=922 lowpriorityscore=0 clxscore=1011 phishscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 05:23:58PM +0200, Krzysztof Kozlowski wrote:
> On 28/08/2023 17:14, Vlastimil Babka wrote:
> > On 8/28/23 15:48, Geert Uytterhoeven wrote:
> >> Hi Bjorn,
> >>
> >> On Mon, Aug 28, 2023 at 3:37 PM Bjorn Andersson
> >> <quic_bjorande@quicinc.com> wrote:
> >>> On Mon, Aug 28, 2023 at 11:14:41AM +0300, Jani Nikula wrote:
> >>>> On Sat, 26 Aug 2023, Guru Das Srinagesh <quic_gurus@quicinc.com> wrote:
> >>>>> This script runs get_maintainer.py on a given patch file (or multiple
> >>>>> patch files) and adds its output to the patch file in place with the
> >>>>> appropriate email headers "To: " or "Cc: " as the case may be. These new
> >>>>> headers are added after the "From: " line in the patch.
> >>>>
> >>>> FWIW, I personally prefer tooling to operate on git branches and commits
> >>>> than patches. For me, the patches are just an intermediate step in
> >>>> getting the commits from my git branch to the mailing list. That's not
> >>>> where I add the Cc's, but rather in the commits in my local branch,
> >>>> where they're preserved. YMMV.
> >>>>
> >>>
> >>> May I ask how you add/carry the recipients in a commit?
> >>
> >> I guess below a "---" line in the commit description?
> > 
> > Does that do anything special in commit log? I'd expect (and I do it that
> > way) it's rather just adding a
> 
> It does. It goes away.

Afaict, it's verbatim copied into the .patch, which would mean that it
goes away when the patch is applied on the other side.

But it's still going to be in the email (followed by another ---), so
unless there's another step later in the process that cleans this up I
it looks ugly, and not very useful - unless I'm missing something.

> > 
> > Cc: Name <email>
> > 
> > in the tag area where s-o-b, reviewed-by etc are added.
> 
> Why storing autogenerated scripts/get_maintainer.pl CC-entries in commit
> msg? The non-maintainer-output but the automated output? There is no
> single need to store automated output of get_maintainers.pl in the git
> log. It can be easily re-created at any given time, thus its presence in
> the git history is redundant and obfuscates the log.
> 

Fully agree to this. In particular if the patch is going to be sent as
part of a series the recipients list won't be accurate for any patch.

The case I was looking for was the case where I want to make sure to
include a specific person, beyond the get_maintainers output. So pretty
much the usual Cc: tag in the commit message, but I don't necessarily
want to write this fact into the git history.

Regards,
Bjorn
