Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DFF7764C4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjHIQNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjHIQNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:13:35 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FDB10D4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 09:13:31 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1bba7717d3bso5347730fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 09:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691597611; x=1692202411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OgDFpldPgAGUwsz5nVjA6iwGleVqPZrR7mQ0AP3vWmo=;
        b=cXhIiBiLM018GsufSGIcEDDIMzQlZEz4vliqbqvQAhaaysoska0pkc0i2y370nF5tK
         sBntGdSuNZnBeLpMro/4md7WC9y34cCudI63VcmF3Q6wH5OvlVs/catHEJJYgQ7qzA7t
         +p2nRlrQnNajbEb9zB1jmSNgp7Pc3I6xdpXIHZzs3bQvSPQ4OuP8dZNHBJygzyOlbfZ5
         AF2HtrbOlKG2GnT8yBU0Y2rvbkLQevQkgJcEErQqyQF7qeQU0Dfg5AYpep0AiyLjv+2f
         IGcXo4bk8s2fdSQONTO3v60f1VeVf1I0WzpWG124ST5+q49NRnD0uXC3yAf21QpdGdZx
         zD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691597611; x=1692202411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgDFpldPgAGUwsz5nVjA6iwGleVqPZrR7mQ0AP3vWmo=;
        b=JnUp/Ex6dZEJYGyBKlOVUfBkHHEO3gQq2+GLALIFgYZpuUNR+jjsvAKChpV4PDrCK1
         QiSP+W7lA655lg9yk5f1yuimnPhiGR+wPP4/bM5z6RNH3mcdOfzUyNun2zbo4Ip5Vu1A
         uAYem9rfO/trhGcBWm2HwLrm5Ybt1FDYg+qTnKHqzoc0tSvlz/Xh8wP89toux2RB5VFY
         rRWIr4fWqRvoXjkNR8fBHwyf+PKg63QD0loOXqSF2oK5xm5/bF7/kIkwkqQtrM/zDLKO
         N+fmpz9k36/K/ODoQ+7cYXS6M99piNGtyuW830UiANJ4Ug6gTKb06ngqSMYrLaSh+WPE
         vIFg==
X-Gm-Message-State: AOJu0Yx849E+b7eoqRRgOQg11mr7FXrWzLtT/D8h3hdt/hSj9pmDE4rM
        Zorz3ZAnBGvx+dMJkpMnSidBy+NQAB8=
X-Google-Smtp-Source: AGHT+IGQOc7LJ63guOVnss4GJMRJFRHmnbH9p4lD+sJ+Md5W38pnvkNcCvDvPni2ZgeMSYNRrvd1tA==
X-Received: by 2002:a05:6870:c082:b0:1bf:74cc:c815 with SMTP id c2-20020a056870c08200b001bf74ccc815mr3636754oad.19.1691597610814;
        Wed, 09 Aug 2023 09:13:30 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:86d6:7871:f7e9:8a15:865a])
        by smtp.gmail.com with ESMTPSA id o2-20020a056870a50200b001bf817a62fesm7329356oal.31.2023.08.09.09.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 09:13:30 -0700 (PDT)
Date:   Wed, 9 Aug 2023 13:13:25 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v3] staging: vme_user: fix alignment of open parenthesis
 and deleted trailing spaces
Message-ID: <ZNO7JRmwnMmaHtzf@alolivei-thinkpadt480s.gru.csb>
References: <ZNJKTLZ62SZMM6D8@alolivei-thinkpadt480s.gru.csb>
 <2023080902-cattle-disparate-6b82@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023080902-cattle-disparate-6b82@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 02:24:25PM +0200, Greg KH wrote:
> On Tue, Aug 08, 2023 at 10:59:40AM -0300, Alexon Oliveira wrote:
> > Fixed all CHECK: Alignment should match open parenthesis
> > and deleted the trailing whitespaces as reported by
> > checkpatch to adhere to the Linux kernel coding-style
> > guidelines.
> > 
> > Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
> > ---
> > 
> > Changes in v3:
> > - Rebased against staging.git and staging-next branch, noted by Greg KH
> 
> I don't think you did this as it still fails to apply for me :(
> 
> Can you go through the exact steps and try again?
> 

I'm pretty positive I did as you instructed me, but I think the problem
seems to be another thing:

$ git fetch origin

remote: Enumerating objects: 46, done.
remote: Counting objects: 100% (46/46), done.
remote: Compressing objects: 100% (46/46), done.
remote: Total 46 (delta 35), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (46/46), 33.97 KiB | 135.00 KiB/s, done.
From git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
   1422b526fba9..c3bdcb94967d  staging-testing -> origin/staging-testing

$ git rebase -i origin/staging-testing

warning: skipped previously applied commit 7d5ce25fb4c3
hint: use --reapply-cherry-picks to include skipped commits
hint: Disable this message with "git config advice.skippedCherryPicks false"
^[[AERROR: trailing whitespace
#158: FILE: drivers/staging/vme_user/vme.c:566:
+^I^I   unsigned long long vme_base, unsigned long long size, $

ERROR: trailing whitespace
#180: FILE: drivers/staging/vme_user/vme.c:617:
+^I^I   unsigned long long *vme_base, unsigned long long *size, $

ERROR: trailing whitespace
#244: FILE: drivers/staging/vme_user/vme.c:1048:
+^I^I^I^I^I   u32 aspace, u32 cycle, $

ERROR: trailing whitespace
#311: FILE: drivers/staging/vme_user/vme.c:1844:
+^I^I^I^I     struct vme_bridge *bridge, $

total: 4 errors, 0 warnings, 0 checks, 277 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

"[PATCH] staging: vme_user: fix alignment of open parenthesis and" has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.
total: 0 errors, 0 warnings, 0 checks, 32 lines checked

"[PATCH] staging: vme_user: fix alignment of open parenthesis and" has no obvious style problems and is ready for submission.
Successfully rebased and updated refs/heads/first-patch.

$ git rebase -i origin/staging-testing
Stopped at d13431f7a7ba...  staging: vme_user: fix alignment of open parenthesis and deleted trailing spaces
You can amend the commit now, with

  git commit --amend

Once you are satisfied with your changes, run

  git rebase --continue

$ git commit --amend -s -v
ERROR: trailing whitespace
#158: FILE: drivers/staging/vme_user/vme.c:566:
+^I^I   unsigned long long vme_base, unsigned long long size, $

ERROR: trailing whitespace
#180: FILE: drivers/staging/vme_user/vme.c:617:
+^I^I   unsigned long long *vme_base, unsigned long long *size, $

ERROR: trailing whitespace
#244: FILE: drivers/staging/vme_user/vme.c:1048:
+^I^I^I^I^I   u32 aspace, u32 cycle, $

ERROR: trailing whitespace
#311: FILE: drivers/staging/vme_user/vme.c:1844:
+^I^I^I^I     struct vme_bridge *bridge, $

total: 4 errors, 0 warnings, 0 checks, 277 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

"[PATCH] staging: vme_user: fix alignment of open parenthesis and" has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.
[detached HEAD 527a5480c032] staging: vme_user: fix alignment of open parenthesis and deleted trailing spaces
 Date: Fri Aug 4 18:01:54 2023 -0300
 1 file changed, 43 insertions(+), 42 deletions(-)

$ git rebase --continue
total: 0 errors, 0 warnings, 0 checks, 32 lines checked

"[PATCH] staging: vme_user: fix alignment of open parenthesis and" has no obvious style problems and is ready for submission.
Successfully rebased and updated refs/heads/first-patch.

$ git rebase -i origin/staging-testing
Successfully rebased and updated refs/heads/first-patch.

$ git rebase -i origin/staging-next
Successfully rebased and updated refs/heads/first-patch.

> thanks,
> 
> greg k-h

Thank you.

Alexon Oliveira
