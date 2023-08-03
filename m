Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386DE76E3EA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbjHCJEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbjHCJEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:04:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B52E46;
        Thu,  3 Aug 2023 02:04:44 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37377ECN007909;
        Thu, 3 Aug 2023 09:04:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=VrQ4mfqjql4ZB4HPg+PnuPiU8+5Jf6FFhsvjXmsUTc0=;
 b=i5ur2xSaD4IpdInPZ6BDQvOCbJx+4ysK2X0GIgViT1gcOIF+lJx2MXFdkwzV+KEdaNfZ
 QB/Yfo9Y/0+cyB10s0n8sqpf1WYap/ledWaDwe89EaDESBXmZR6fGgRpKe3xKqIV2Sm0
 AAcXrKauhtqHArfjNOxPphMmYWBqiE3hMx/vxfV6cfRWrIKz4j5TcPVG4Wr6F/4qNDdq
 lcOIQ4G6W/KBLsZu4Qrjb+ZzPLGLPbJItAkugXMmRFl4ut0S0j98i4vRCUfqvz6ROdqn
 PKMx3BQDPiVopeNPwvw8KgXfZwdh8+F3KHKRKHewllZ+myF0En6x2rMghErQMPHRRRJU Ig== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s87jhg7d3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 09:04:20 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37394JYm012583
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Aug 2023 09:04:19 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 3 Aug 2023 02:04:14 -0700
Date:   Thu, 3 Aug 2023 14:34:11 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        Kees Cook <keescook@chromium.org>,
        "Bjorn Andersson" <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, Will Deacon <will@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <quic_pkondeti@quicinc.com>, <u.kleine-koenig@pengutronix.de>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] scripts: Add add-maintainer.py
Message-ID: <44afa9e4-9aaa-4a80-b2a9-57d0bf14b6e0@quicinc.com>
References: <cover.1691049436.git.quic_gurus@quicinc.com>
 <829b08342568735095bbd3f8c44f435f44688018.1691049436.git.quic_gurus@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <829b08342568735095bbd3f8c44f435f44688018.1691049436.git.quic_gurus@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: X-7ur7DVOVUjh8_MPdBa-YLNBnuwCpqZ
X-Proofpoint-ORIG-GUID: X-7ur7DVOVUjh8_MPdBa-YLNBnuwCpqZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_07,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308030080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 01:23:16AM -0700, Guru Das Srinagesh wrote:
> This script runs get_maintainer.py on a given patch file and adds its
> output to the patch file in place with the appropriate email headers
> "To: " or "Cc: " as the case may be. These new headers are added after
> the "From: " line in the patch.
> 
> Currently, for a single patch, maintainers are added as "To: ", mailing
> lists and all other roles are addded as "Cc: ".
> 
> For a series of patches, however, a set-union scheme is employed in
> order to solve the all-too-common problem of sending subsets of a patch
> series to some lists, which results in important pieces of context such
> as the cover letter being dropped. This scheme is as follows:
> - Create set-union of all mailing lists corresponding to all patches and
>   add this to all patches as "Cc: "
> - Create set-union of all other roles corresponding to all patches and
>   add this to all patches as "Cc: "
> - Create set-union of all maintainers from all patches and use this to
>   do the following per patch:
>   - add only that specific patch's maintainers as "To: ", and
>   - the other maintainers from the other patches as "Cc: "
> 

Thanks. I have tested this logic by running this script on two patches
from different subsystems. It does what it says.

> Please note that patch files that don't have any "Maintainer"s
> explicitly listed in their `get_maintainer.pl` output will not have any
> "To: " entries added to them; developers are expected to manually make
> edits to the added entries in such cases to convert some "Cc: " entries
> to "To: " as desired.
> 
> The script is quiet by default (only prints errors) and its verbosity
> can be adjusted via an optional parameter.
> 
> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> ---
>  scripts/add-maintainer.py | 113 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 113 insertions(+)
>  create mode 100755 scripts/add-maintainer.py
> 

Do you need to update MAINTAINERS file?

> diff --git a/scripts/add-maintainer.py b/scripts/add-maintainer.py
> new file mode 100755
> index 000000000000..b1682c2945f9
> --- /dev/null
> +++ b/scripts/add-maintainer.py
> @@ -0,0 +1,113 @@
> +#! /usr/bin/env python3
> +
> +import argparse
> +import logging
> +import os
> +import sys
> +import subprocess
> +import re
> +
> +def gather_maintainers_of_file(patch_file):
> +    all_entities_of_patch = dict()
> +
> +    # Run get_maintainer.pl on patch file
> +    logging.info("GET: Patch: {}".format(os.path.basename(patch_file)))
> +    cmd = ['scripts/get_maintainer.pl']
> +    cmd.extend([patch_file])
> +    p = subprocess.run(cmd, stdout=subprocess.PIPE, check=True)
> +    logging.debug("\n{}".format(p.stdout.decode()))
> +
> +    entries = p.stdout.decode().splitlines()
> +
> +    maintainers = []
> +    lists = []
> +    others = []
> +
> +    for entry in entries:
> +        entity = entry.split('(')[0].strip()
> +        if "maintainer" in entry:
> +            maintainers.append(entity)
> +        elif "list" in entry:
> +            lists.append(entity)
> +        else:
> +            others.append(entity)
> +
> +    all_entities_of_patch["maintainers"] = set(maintainers)
> +    all_entities_of_patch["lists"] = set(lists)
> +    all_entities_of_patch["others"] = set(others)
> +
> +    return all_entities_of_patch
> +
> +def add_maintainers_to_file(patch_file, entities_per_file, all_entities_union):
> +    logging.info("ADD: Patch: {}".format(os.path.basename(patch_file)))
> +
> +    # For each patch:
> +    # - Add all lists from all patches in series as Cc:
> +    # - Add all others from all patches in series as Cc:
> +    # - Add only maintainers of that patch as To:
> +    # - Add maintainers of other patches in series as Cc:
> +
> +    lists = list(all_entities_union["all_lists"])
> +    others = list(all_entities_union["all_others"])
> +    file_maintainers = all_entities_union["all_maintainers"].intersection(entities_per_file[os.path.basename(patch_file)].get("maintainers"))
> +    other_maintainers = all_entities_union["all_maintainers"].difference(entities_per_file[os.path.basename(patch_file)].get("maintainers"))
> +
> +    # Specify email headers appropriately
> +    cc_lists        = ["Cc: " + l for l in lists]
> +    cc_others       = ["Cc: " + o for o in others]
> +    to_maintainers  = ["To: " + m for m in file_maintainers]
> +    cc_maintainers  = ["Cc: " + om for om in other_maintainers]
> +    logging.debug("Cc Lists:\n{}".format('\n'.join(cc_lists)))
> +    logging.debug("Cc Others:\n{}".format('\n'.join(cc_others)))
> +    logging.debug("Cc Maintainers:\n{}".format('\n'.join(cc_maintainers) or None))
> +    logging.debug("To Maintainers:\n{}\n".format('\n'.join(to_maintainers) or None))
> +
> +    # Edit patch file in place to add maintainers
> +    with open(patch_file, "r") as pf:
> +        lines = pf.readlines()
> +
> +    from_line = [i for i, line in enumerate(lines) if re.search("From: ", line)]
> +    if len(from_line) > 1:
> +        logging.error("Only one From: line is allowed in a patch file")
> +        sys.exit(1)
> +

Few minor issues from my limited testing:

- It is very unlikely, but for whatever reason if "From:" is present in
the patch (commit description), this script bails out. Pls try running
this script on the current patch. May be you should also look for a
proper email address on this line.

- When this script is run on a file (get_maintainer.pl allows this), it
  throws a runtime warning. may be good to bail out much earlier.

- When this script runs on a non-existent file, it does not bail out
  early.

Thanks,
Pavan
