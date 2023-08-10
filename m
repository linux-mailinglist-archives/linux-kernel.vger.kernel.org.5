Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517237780CA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbjHJSxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjHJSxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:53:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A5926A6;
        Thu, 10 Aug 2023 11:53:01 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37AGqvxm022718;
        Thu, 10 Aug 2023 18:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=JCVfaQ2n9FBS/o8UR3Cr06klXshrKlNlQcuf1AxP3lA=;
 b=ot7qKQdb90dWyvmU+/LShv0LBzaYGWoNJlt5YrMmcvzY4BwYYH8pWyZv7UBRpLflxjrb
 BVWuTo0TK9FH4EqIstBVZdYr9alU3YTi7Ks3o1G152LQtMEBNZdhxu2wsZEhVBif/F83
 Hdq+hI9OtPIrxMAK5P0v9IcUJz5g33HmSpPtoazkEQ92yr03t3Q5nAuhOWC1BcXrdLpv
 9r7pEjFnQT46IGOTCWEM8sVuw3oIMOSIfQq58zgGvQ8jAJx1s6087OWq7sq9BHPKumPq
 H0I9eJMCjbvMgRCB09bS8lHPs+KlXZdT4zxmYGoLVTlzz+bARGg/f0FLbK9FFIzboxCJ fg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3scnsfa8wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 18:52:40 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37AIqdKZ005105
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 18:52:39 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 10 Aug
 2023 11:52:38 -0700
Date:   Thu, 10 Aug 2023 11:52:37 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        "Kees Cook" <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <u.kleine-koenig@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] scripts: Add add-maintainer.py
Message-ID: <20230810185237.GB31860@quicinc.com>
References: <cover.1691049436.git.quic_gurus@quicinc.com>
 <829b08342568735095bbd3f8c44f435f44688018.1691049436.git.quic_gurus@quicinc.com>
 <44afa9e4-9aaa-4a80-b2a9-57d0bf14b6e0@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <44afa9e4-9aaa-4a80-b2a9-57d0bf14b6e0@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zmU9HAlcBOvDVRWkJlT_qQ1CQZ772V37
X-Proofpoint-ORIG-GUID: zmU9HAlcBOvDVRWkJlT_qQ1CQZ772V37
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_14,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100163
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 03 2023 14:34, Pavan Kondeti wrote:
> On Thu, Aug 03, 2023 at 01:23:16AM -0700, Guru Das Srinagesh wrote:
> > This script runs get_maintainer.py on a given patch file and adds its
> > output to the patch file in place with the appropriate email headers
> > "To: " or "Cc: " as the case may be. These new headers are added after
> > the "From: " line in the patch.
> > 
> > Currently, for a single patch, maintainers are added as "To: ", mailing
> > lists and all other roles are addded as "Cc: ".
> > 
> > For a series of patches, however, a set-union scheme is employed in
> > order to solve the all-too-common problem of sending subsets of a patch
> > series to some lists, which results in important pieces of context such
> > as the cover letter being dropped. This scheme is as follows:
> > - Create set-union of all mailing lists corresponding to all patches and
> >   add this to all patches as "Cc: "
> > - Create set-union of all other roles corresponding to all patches and
> >   add this to all patches as "Cc: "
> > - Create set-union of all maintainers from all patches and use this to
> >   do the following per patch:
> >   - add only that specific patch's maintainers as "To: ", and
> >   - the other maintainers from the other patches as "Cc: "
> > 
> 
> Thanks. I have tested this logic by running this script on two patches
> from different subsystems. It does what it says.

Thanks for testing this v2!

> 
> > Please note that patch files that don't have any "Maintainer"s
> > explicitly listed in their `get_maintainer.pl` output will not have any
> > "To: " entries added to them; developers are expected to manually make
> > edits to the added entries in such cases to convert some "Cc: " entries
> > to "To: " as desired.
> > 
> > The script is quiet by default (only prints errors) and its verbosity
> > can be adjusted via an optional parameter.
> > 
> > Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> > ---
> >  scripts/add-maintainer.py | 113 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 113 insertions(+)
> >  create mode 100755 scripts/add-maintainer.py
> > 
> 
> Do you need to update MAINTAINERS file?

Noted.

> 

[...]

> 
> Few minor issues from my limited testing:
> 
> - It is very unlikely, but for whatever reason if "From:" is present in
> the patch (commit description), this script bails out. Pls try running
> this script on the current patch. May be you should also look for a
> proper email address on this line.
> 
> - When this script is run on a file (get_maintainer.pl allows this), it
>   throws a runtime warning. may be good to bail out much earlier.
> 
> - When this script runs on a non-existent file, it does not bail out
>   early.

Will fix these.

Thank you.

Guru Das.
