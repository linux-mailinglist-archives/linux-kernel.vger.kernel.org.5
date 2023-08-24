Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65076787AA6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 23:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243765AbjHXVpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 17:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243773AbjHXVpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 17:45:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA46C1BD8;
        Thu, 24 Aug 2023 14:45:14 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OJjYCk006834;
        Thu, 24 Aug 2023 21:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=hLNou2AczAuWG24pQywWWj5WvhaNuDU9OQNzD+LJbpw=;
 b=po8mb6TO9AX742RdxYL7Ness31u2EoSVNKpvX5ChdIf60oXqQ+GJc1SKykGsqRUhZ0WE
 vaZ7wvVDoFCjoMbpdgEPw+brML0lPy3Tt+gtLmbUvkfQh5GYYNJ1xbW0AvwjByPfVHU9
 NUo61cEOX/+43Arv+k/j7nnTlRiiw0uN6BPoeTdgAmyqrTCJNpjdFKq+o/R9wNQbUCFf
 0UCgKJJVIzTUBDonp1fn449cW0dteuRPPMiJKTXjL5hfxTTMnex/y/lu55vq9UbS2ZxU
 IxrK7jDidPT30Kmjy+Eky9BaZmXKccCL2lmdluTiCFnmYfGF5shCKDKag/Iy9p64+KHz NA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3snxtatq69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 21:44:39 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37OLicvx021468
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 21:44:38 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 24 Aug
 2023 14:44:37 -0700
Date:   Thu, 24 Aug 2023 14:44:36 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Nicolas Schier <nicolas@fjasle.eu>
CC:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Bjorn Andersson" <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, Will Deacon <will@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <quic_pkondeti@quicinc.com>, <u.kleine-koenig@pengutronix.de>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] scripts: Add add-maintainer.py
Message-ID: <20230824214436.GA22659@quicinc.com>
Mail-Followup-To: Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quic_pkondeti@quicinc.com, u.kleine-koenig@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <cover.1691049436.git.quic_gurus@quicinc.com>
 <829b08342568735095bbd3f8c44f435f44688018.1691049436.git.quic_gurus@quicinc.com>
 <ZOYicEP8D7kNGFin@fjasle.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZOYicEP8D7kNGFin@fjasle.eu>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lIvpSpabnkxwYlhRvi3kVquGm4HrVBhJ
X-Proofpoint-GUID: lIvpSpabnkxwYlhRvi3kVquGm4HrVBhJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_18,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308240189
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

Thank you so much for reviewing this script!

On Aug 23 2023 17:14, Nicolas Schier wrote:
> Hi Guru,
> 
> thanks for your patch!  I really to appreciate the discussion about how to
> lower the burden for first-time contributors; might you consider cc-ing
> workflows@vger.kernel.org when sending v3?

Certainly, will do. The archives for this list are very interesting to read!

[...]

> Some additional thoughts to the feedback from Pavan:
> 
> On Thu, Aug 03, 2023 at 01:23:16AM -0700 Guru Das Srinagesh wrote:
> > This script runs get_maintainer.py on a given patch file and adds its
> > output to the patch file in place with the appropriate email headers
> > "To: " or "Cc: " as the case may be. These new headers are added after
> > the "From: " line in the patch.
> > 
> > Currently, for a single patch, maintainers are added as "To: ", mailing
> > lists and all other roles are addded as "Cc: ".
> 
> typo: addded -> added

Done.

> > The script is quiet by default (only prints errors) and its verbosity
> > can be adjusted via an optional parameter.
> 
> IMO, it would be nice to see which addresses are effectively added, e.g.
> comparable to the output of git send-email.  Perhaps somehing like:
> 
>   $ scripts/add-maintainer.py *.patch
>   0001-fixup-scripts-Add-add-maintainer.py.patch: Adding 'To: Guru Das Srinagesh <quic_gurus@quicinc.com>' (maintainer)
>   0001-fixup-scripts-Add-add-maintainer.py.patch: Adding 'Cc: linux-kernel@vger.kernel.org' (list)
> 
> Perhaps verbosity should then be configurable.

Yes, this is already implemented - you just need to pass "--verbosity debug" to
the script. Example based on commit 8648aeb5d7b7 ("power: supply: add Qualcomm
PMI8998 SMB2 Charger driver") converted to a patch:

    $ ./scripts/add-maintainer.py --verbosity debug $u/upstream/patches/test2/0001-power-supply-add-Qualcomm-PMI8998-SMB2-Charger-drive.patch
    INFO: GET: Patch: 0001-power-supply-add-Qualcomm-PMI8998-SMB2-Charger-drive.patch
    DEBUG:
    Sebastian Reichel <sre@kernel.org> (maintainer:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS)
    Andy Gross <agross@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
    Bjorn Andersson <andersson@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
    Konrad Dybcio <konrad.dybcio@linaro.org> (maintainer:ARM/QUALCOMM SUPPORT)
    Nathan Chancellor <nathan@kernel.org> (supporter:CLANG/LLVM BUILD SUPPORT)
    Nick Desaulniers <ndesaulniers@google.com> (supporter:CLANG/LLVM BUILD SUPPORT)
    Tom Rix <trix@redhat.com> (reviewer:CLANG/LLVM BUILD SUPPORT)
    linux-kernel@vger.kernel.org (open list)
    linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS)
    linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
    llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT)
    
    INFO: ADD: Patch: 0001-power-supply-add-Qualcomm-PMI8998-SMB2-Charger-drive.patch
    DEBUG: Cc Lists:
    Cc: linux-arm-msm@vger.kernel.org
    Cc: llvm@lists.linux.dev
    Cc: linux-pm@vger.kernel.org
    Cc: linux-kernel@vger.kernel.org
    DEBUG: Cc Others:
    Cc: Tom Rix <trix@redhat.com>
    Cc: Nick Desaulniers <ndesaulniers@google.com>
    Cc: Nathan Chancellor <nathan@kernel.org>
    DEBUG: Cc Maintainers:
    None
    DEBUG: To Maintainers:
    To: Sebastian Reichel <sre@kernel.org>
    To: Andy Gross <agross@kernel.org>
    To: Bjorn Andersson <andersson@kernel.org>
    To: Konrad Dybcio <konrad.dybcio@linaro.org>
    
    INFO: Maintainers added to all patch files successfully

The first "GET:" output prints the output of `get_maintainer.pl` verbatim, and
the "ADD:" output shows what exactly is getting added to that patch. Hope this
is what you were expecting. Please let me know if you'd prefer any other
modifications to this debug output.

[...]

> > +def add_maintainers_to_file(patch_file, entities_per_file, all_entities_union):
> > +    logging.info("ADD: Patch: {}".format(os.path.basename(patch_file)))
> > +    # Edit patch file in place to add maintainers
> > +    with open(patch_file, "r") as pf:
> > +        lines = pf.readlines()
> > +
> > +    from_line = [i for i, line in enumerate(lines) if re.search("From: ", line)]
> 
> (extending Pavan comment on "From:" handling:)
> 
> Please use something like line.startswith("From:"), otherwise this catches any
> "From: " in the whole file (that's the reason why add-maintainer.py fails on
> this very patch).  Actually, you only want to search through the patch (mail)
> header block, not through the whole commit msg and the patch body.

I see the issue. I will use a simple regex to search for the first occurrence
of a valid "From: <email address>" and stop there.

[...]

> > +def main():
> > +    parser = argparse.ArgumentParser(description='Add the respective maintainers and mailing lists to patch files')
> > +    parser.add_argument('patches', nargs='*', help="One or more patch files")
> 
> nargs='+' is one or more
> nargs='*' is zero, one or more

Thank you - fixed.

> While testing, I thought that adding addresses without filtering-out duplicates
> was odd; but as git-send-email does the unique filtering, it doesn't matter.

Since I'm using `set()` in this script, the uniqueness is guaranteed here as
well - there won't be any duplicates.

> For my own workflow, I would rather prefer a git-send-email wrapper, similiar
> to the shell alias Krzysztof shared (but I like 'b4' even more).  Do you have
> some thoughts about a "smoother" workflow integration?  The best one I could
> come up with is
> 
>     ln -sr scripts/add-maintainer.py .git/hooks/sendemail-validate
>     git config --add --local sendemail.validate true

This looks really useful! I haven't explored git hooks enough to comment on
this though, sorry.

Guru Das.
