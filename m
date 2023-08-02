Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C26576CA73
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjHBKGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjHBKGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:06:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5818196
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 03:06:06 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3724XFMu020961;
        Wed, 2 Aug 2023 10:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=eIzxzpTJrE8SFJQOovUrBi2LJyMj33uUIwke+IPSnAg=;
 b=TZleOF3vSINUnc8FKqZ3U/9nbnAM7jqA/HhikrgK1bf1QxP8RY5PYnVMA/gMeOo6FIak
 ljIcigIdIN2O4HPt+Ro9TyXpGUmyj7SJ05pk9EupRV3GNtNu839lD8MXpf2E88EDDlpC
 jaL4aecKNfe11925W4Cu5yj8H3zD0f2JS8JjCB2MLvIfgOolnjmTYtpIcWsHpw9Dg6dt
 0nMBVlhU8Z7r6XxPBZ9lzXM08G0h0EskCnNrgcnJ8okjUNyfo2E3Pa23RXfkythxa3p0
 7nou6EwClH/jSm6DlhPKsotF8ijvFQ9NKEY8yGbs1UvmBQ+4Yp+kekf1GK9WYjp1X3Jp /w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6yq4awg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 10:05:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 372A5uqw007420
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 10:05:56 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 03:05:52 -0700
Date:   Wed, 2 Aug 2023 15:35:50 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        Kees Cook <keescook@chromium.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] scripts: Add add-maintainer.py
Message-ID: <63764b84-3ebd-4081-836f-4863af196228@quicinc.com>
References: <cover.1690951441.git.quic_gurus@quicinc.com>
 <0d000c48e939beaa97c744c0a8b652396a0b045d.1690951441.git.quic_gurus@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0d000c48e939beaa97c744c0a8b652396a0b045d.1690951441.git.quic_gurus@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2-rP3oWhi1-NNcfeP5BFEAOw1Yfa7s8E
X-Proofpoint-GUID: 2-rP3oWhi1-NNcfeP5BFEAOw1Yfa7s8E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_05,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=640
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020090
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 09:54:29PM -0700, Guru Das Srinagesh wrote:
> This script runs get_maintainer.py on a given patch file and adds its
> output to the patch file in place with the appropriate email headers
> "To: " or "Cc: " as the case may be. These new headers are added after
> the "From: " line in the patch.
> 
> Currently, maintainers are added as "To: ", mailing lists are added as
> "Cc: " and all others are addded as "Cc: " as well.
> 
> The script is quiet by default (only prints errors) and its verbosity
> can be adjusted via an optional parameter.
> 
> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> ---
>  scripts/add-maintainer.py | 82 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100755 scripts/add-maintainer.py
> 
> diff --git a/scripts/add-maintainer.py b/scripts/add-maintainer.py
> new file mode 100755
> index 000000000000..942d331cf8d4
> --- /dev/null
> +++ b/scripts/add-maintainer.py
> @@ -0,0 +1,82 @@
> +#! /usr/bin/env python3
> +
> +import argparse
> +import logging
> +import os
> +import sys
> +import subprocess
> +import re
> +
> +def add_maintainers_to_file(patch_file):
> +    # Run get_maintainer.pl on patch file
> +    logging.info("Patch: {}".format(os.path.basename(patch_file)))
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
> +    # Specify email headers appropriately
> +    to_maintainers  = ["To: " + m for m in maintainers]
> +    cc_lists        = ["Cc: " + l for l in lists]
> +    cc_others       = ["Cc: " + o for o in others]
> +    logging.debug("To Maintainers:\n{}".format('\n'.join(to_maintainers)))
> +    logging.debug("Cc Lists:\n{}".format('\n'.join(cc_lists)))
> +    logging.debug("Cc Others:\n{}".format('\n'.join(cc_others)))
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
> +    next_line_after_from = from_line[0] + 1
> +
> +    # Reverse lists to maintain same order as in get_maintainer.py output
> +    # as we will be insert()-ing the elements
> +    to_maintainers.reverse()
> +    cc_lists.reverse()
> +    cc_others.reverse()
> +
> +    for o in cc_others:
> +        lines.insert(next_line_after_from, o + "\n")
> +    for l in cc_lists:
> +        lines.insert(next_line_after_from, l + "\n")
> +    for m in to_maintainers:
> +        lines.insert(next_line_after_from, m + "\n")
> +
> +    with open(patch_file, "w") as pf:
> +        pf.writelines(lines)
> +
> +def main():
> +    parser = argparse.ArgumentParser(description='Add the respective maintainers and mailing lists to patch files')
> +    parser.add_argument('patches', nargs='*', help="One or more patch files")
> +    parser.add_argument('--verbosity', choices=['debug', 'info', 'error'], default='error', help="Verbosity level of script output")
> +    args = parser.parse_args()
> +
> +    logging.basicConfig(level=args.verbosity.upper(), format='%(levelname)s: %(message)s')
> +
> +    for patch in args.patches:
> +        add_maintainers_to_file(patch)
> +
> +    logging.info("Maintainers added to all patch files successfully")
> +
> +if __name__ == "__main__":
> +    main()
> -- 
> 2.40.0

Thanks Guru for submitting this script. In my limited testing, I don't
find any issues. It works as expected.

If I run this script on a series which spans across different lists,
there is a possiblity that we send partial series to certain lists. What
is the best way to deal with this? one way is to include union of all
lists in CC while sending the series with primary maintainer in TO. Can
the script print those values for easier workflow?

Thanks,
Pavan
