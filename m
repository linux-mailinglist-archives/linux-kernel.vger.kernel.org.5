Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CE278A752
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 10:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjH1IPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 04:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjH1IOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:14:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D1D126;
        Mon, 28 Aug 2023 01:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693210489; x=1724746489;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=QLFf9ulvG0seTevyAaf2b7IoLOlWlrsa/M3s7UysrKw=;
  b=g3s9mckMWLK/ulFO5M1mjgOWc3qRx9o4JVn9ZL9ZwtvX9GQwUhkHJkvI
   RfBx26QRbGps+IMjTX0V3Ho6fokbt+7E1JlXMVh+hPHymh421RzG8ajoh
   xVdF/sQbyqY+CaKLvZxqdhzlEQcC0ODnGlL6BZygmmXTai+1yJdw8Fa33
   WyI+8IYB8TOoxdDU3uiGwmhHB4ilyvnJ6DtWwBMSpU5Z941PIA7RWQQku
   iDbNo6OFBVO25nbToC4C+1grPzwBnTlqdYJ8pS96GJGASdJ6vuNSC7SQC
   4Rl9ugLmhNYqZihL+3TJ0KP57FlvYULRLJ/CNv+i+oCyfz4EVimYrMbVj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="373936837"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="373936837"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 01:14:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="984786383"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="984786383"
Received: from golubevv-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.57.84])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 01:14:43 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quic_pkondeti@quicinc.com
Cc:     linux-kernel@vger.kernel.org, kernel@quicinc.com,
        workflows@vger.kernel.org, tools@linux.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: Re: [PATCH v3 1/1] scripts: Add add-maintainer.py
In-Reply-To: <141b9fcab2208ace3001df4fc10e3dfd42b9f5d9.1693037031.git.quic_gurus@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1693037031.git.quic_gurus@quicinc.com>
 <141b9fcab2208ace3001df4fc10e3dfd42b9f5d9.1693037031.git.quic_gurus@quicinc.com>
Date:   Mon, 28 Aug 2023 11:14:41 +0300
Message-ID: <87jztf37ny.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Aug 2023, Guru Das Srinagesh <quic_gurus@quicinc.com> wrote:
> This script runs get_maintainer.py on a given patch file (or multiple
> patch files) and adds its output to the patch file in place with the
> appropriate email headers "To: " or "Cc: " as the case may be. These new
> headers are added after the "From: " line in the patch.

FWIW, I personally prefer tooling to operate on git branches and commits
than patches. For me, the patches are just an intermediate step in
getting the commits from my git branch to the mailing list. That's not
where I add the Cc's, but rather in the commits in my local branch,
where they're preserved. YMMV.

BR,
Jani.


>
> Currently, for a single patch, maintainers and reviewers are added as
> "To: ", mailing lists and all other roles are added as "Cc: ".
>
> For a series of patches, however, a set-union scheme is employed in
> order to solve the all-too-common problem of ending up sending only
> subsets of a patch series to some lists, which results in important
> pieces of context such as the cover letter (or other patches in the
> series) being dropped from those lists. This scheme is as follows:
>
> - Create set-union of all maintainers and reviewers from all patches and
>   use this to do the following per patch:
>   - add only that specific patch's maintainers and reviewers as "To: "
>   - add the other maintainers and reviewers from the other patches as "Cc: "
>
> - Create set-union of all mailing lists corresponding to all patches and
>   add this to all patches as "Cc: "
>
> - Create set-union of all other roles corresponding to all patches and
>   add this to all patches as "Cc: "
>
> Please note that patch files that don't have any "Maintainer"s or
> "Reviewers" explicitly listed in their `get_maintainer.pl` output will
> not have any "To: " entries added to them; developers are expected to
> manually make edits to the added entries in such cases to convert some
> "Cc: " entries to "To: " as desired.
>
> The script is quiet by default (only prints errors) and its verbosity
> can be adjusted via an optional parameter.
>
> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> ---
>  MAINTAINERS               |   5 ++
>  scripts/add-maintainer.py | 164 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 169 insertions(+)
>  create mode 100755 scripts/add-maintainer.py
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0903d87b17cb..b670e9733f03 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8721,6 +8721,11 @@ M:	Joe Perches <joe@perches.com>
>  S:	Maintained
>  F:	scripts/get_maintainer.pl
>  
> +ADD MAINTAINER SCRIPT
> +M:	Guru Das Srinagesh <quic_gurus@quicinc.com>
> +S:	Maintained
> +F:	scripts/add-maintainer.py
> +
>  GFS2 FILE SYSTEM
>  M:	Bob Peterson <rpeterso@redhat.com>
>  M:	Andreas Gruenbacher <agruenba@redhat.com>
> diff --git a/scripts/add-maintainer.py b/scripts/add-maintainer.py
> new file mode 100755
> index 000000000000..5a5cc9482b06
> --- /dev/null
> +++ b/scripts/add-maintainer.py
> @@ -0,0 +1,164 @@
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
> +
> +    try:
> +        p = subprocess.run(cmd, stdout=subprocess.PIPE, check=True)
> +    except:
> +        sys.exit(1)
> +
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
> +        if any(role in entry for role in ["maintainer", "reviewer"]):
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
> +def find_pattern_in_lines(pattern, lines):
> +    index = 0
> +    for line in lines:
> +        if re.search(pattern, line):
> +            break;
> +        index = index + 1
> +
> +    if index == len(lines):
> +        logging.error("Couldn't find pattern {} in patch".format(pattern))
> +        sys.exit(1)
> +
> +    return index
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
> +    # Get the index of the first "From: <email address>" line in patch
> +    from_line = find_pattern_in_lines("^(From: )(.*)<(.*)@(.*)>", lines)
> +
> +    # Insert our To: and Cc: headers after it.
> +    next_line_after_from = from_line + 1
> +
> +    for l in cc_lists:
> +        lines.insert(next_line_after_from, l + "\n")
> +    for o in cc_others:
> +        lines.insert(next_line_after_from, o + "\n")
> +    for om in cc_maintainers:
> +        lines.insert(next_line_after_from, om + "\n")
> +    for m in to_maintainers:
> +        lines.insert(next_line_after_from, m + "\n")
> +
> +    with open(patch_file, "w") as pf:
> +        pf.writelines(lines)
> +
> +def add_maintainers(patch_files):
> +    entities_per_file = dict()
> +
> +    for patch in patch_files:
> +        entities_per_file[os.path.basename(patch)] = gather_maintainers_of_file(patch)
> +
> +    all_entities_union = {"all_maintainers": set(), "all_lists": set(), "all_others": set()}
> +    for patch in patch_files:
> +        all_entities_union["all_maintainers"] = all_entities_union["all_maintainers"].union(entities_per_file[os.path.basename(patch)].get("maintainers"))
> +        all_entities_union["all_lists"] = all_entities_union["all_lists"].union(entities_per_file[os.path.basename(patch)].get("lists"))
> +        all_entities_union["all_others"] = all_entities_union["all_others"].union(entities_per_file[os.path.basename(patch)].get("others"))
> +
> +    for patch in patch_files:
> +        add_maintainers_to_file(patch, entities_per_file, all_entities_union)
> +
> +    logging.info("Maintainers added to all patch files successfully")
> +
> +def remove_to_cc_from_header(patch_files):
> +    for patch in patch_files:
> +        logging.info("UNDO: Patch: {}".format(os.path.basename(patch)))
> +        with open(patch, "r") as pf:
> +            lines = pf.readlines()
> +
> +        # Get the index of the first "From: <email address>" line in patch
> +        from_line = find_pattern_in_lines("^(From: )(.*)<(.*)@(.*)>", lines)
> +
> +        # Get the index of the first "Date: " line in patch
> +        date_line = find_pattern_in_lines("^(Date: )", lines)
> +
> +        # Delete everything in between From: and Date:
> +        # These are the lines that this script adds - any To: or Cc: anywhere
> +        # else in the patch will not be removed.
> +        del lines[(from_line + 1):date_line]
> +
> +        with open(patch, "w") as pf:
> +            pf.writelines(lines)
> +
> +    logging.info("Maintainers removed from all patch files successfully")
> +
> +def main():
> +    parser = argparse.ArgumentParser(description='Add the respective maintainers and mailing lists to patch files')
> +    parser.add_argument('patches', nargs='+', help="One or more patch files")
> +    parser.add_argument('-v', '--verbosity', choices=['debug', 'info', 'error'], default='error', help="Verbosity level of script output")
> +    parser.add_argument('-u', '--undo', action='store_true', help="Remove maintainers added by this script from patch(es)")
> +    args = parser.parse_args()
> +
> +    logging.basicConfig(level=args.verbosity.upper(), format='%(levelname)s: %(message)s')
> +
> +    for patch in args.patches:
> +        if not os.path.isfile(patch):
> +            logging.error("File does not exist: {}".format(patch))
> +            sys.exit(1)
> +
> +    if args.undo:
> +        remove_to_cc_from_header(args.patches)
> +    else:
> +        add_maintainers(args.patches)
> +
> +if __name__ == "__main__":
> +    main()

-- 
Jani Nikula, Intel Open Source Graphics Center
