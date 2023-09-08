Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629FB798DCD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344314AbjIHSYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344812AbjIHSXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:23:24 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D988F270E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 11:20:54 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58c8cbf0a0dso63230127b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 11:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694197192; x=1694801992; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/97EpKERbgiYzE8cLBdT8sawBWM8E2NpBoGs1AmAU6M=;
        b=qowPPs3w3UR/EL3t+fjKBk4WrnFkHDtPAWzaPKQ2zQNJt5RG4eA4SM40eRIY/sVoCg
         cadTW5ksgZ19HLR3ps7zH9P6yYQSOXRJWSJlsyS+QB+J0ofGlx51IpeOBU/LPFsXF43l
         xhrExaR5u2uPbeICbdOw4mhi4DFbPowcyTG39udJ5FQWFX7ZVduODjUOSncNmLUVJjC7
         SPWXPGM42zCyqJUCXgcCG7XimugKqnc/Q3/oO4gSQbFvt1cvIADq6V90aG/FZ2hpwdGA
         yc5nAfbkjU9WS2vYX8/orGPnO0rb5uILg7zDOqg0oGgtr6gSxqNTms0hqvn4bvoY4lIU
         LjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694197192; x=1694801992;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/97EpKERbgiYzE8cLBdT8sawBWM8E2NpBoGs1AmAU6M=;
        b=S6bERESKhgkdH1f0vyWeTo6xlmd43AqkKiReFqNMGt+eVRBcN+GtgGt2JtqZBkNbVX
         DL3GgqI9eZ+CdC/Cj1f2KL8djQ7Kotr+OKtzzyWWlO6q+F7aXgeDHFTaFnku3jOJX+5I
         fBuydo7ksXeiq7RDM/IyFf1hzCUFlgJPzSZpeDMWk9rB7XTCLSdiYDZ8a4/mGbiF3sWG
         zy70liVE7wyA55GjR2eHLfsJLYTD41TN/yqiK4q19Y2xCc2sriMrquXTvucUwEqeIHTQ
         OeJGgXEAKKM7TV9QaorjbXjeGSXRSoWy0IDxp/b64UVNBKieTKfYzSi7X54v+DDany5+
         xnrg==
X-Gm-Message-State: AOJu0YyaswD5GLWVvQsMVNQHF1rhqBImPdES5Bl8IoDnTSMDOdFU80Nn
        tItNdmBej709MEmHMe7JZBe5qSsuZ0k=
X-Google-Smtp-Source: AGHT+IE64zl/Q7BHyFa2RZyEnCoDczJcAdOGZGRNn5/bEdQq1fPm6CCa5snaBq5FWmeyVh/22edqi1WcVOs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:7603:0:b0:d7e:78db:d264 with SMTP id
 r3-20020a257603000000b00d7e78dbd264mr188480ybc.5.1694197192401; Fri, 08 Sep
 2023 11:19:52 -0700 (PDT)
Date:   Fri, 8 Sep 2023 11:19:50 -0700
In-Reply-To: <20230804120536.2339722-1-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
References: <20230804120536.2339722-1-linux@rasmusvillemoes.dk>
Message-ID: <ZPtlxmdIJXOe0sEy@google.com>
Subject: Re: [PATCH v2] scripts/setlocalversion: also consider annotated tags
 of the form vx.y.z-${file_localversion}
From:   Sean Christopherson <seanjc@google.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023, Rasmus Villemoes wrote:
> Commit 6ab7e1f95e96 ("setlocalversion: use only the correct release
> tag for git-describe") was absolutely correct to limit which annotated
> tags would be used to compute the -01234-gabcdef suffix. Otherwise, if
> some random annotated tag exists closer to HEAD than the vX.Y.Z one,
> the commit count would be too low.
> 
> However, since the version string always includes the
> ${file_localversion} part, now the problem is that the count can be
> too high. For example, building an 6.4.6-rt8 kernel with a few patches
> on top, I currently get
> 
> $ make -s kernelrelease
> 6.4.6-rt8-00128-gd78b7f406397
> 
> But those 128 commits include the 100 commits that are in
> v6.4.6..v6.4.6-rt8, so this is somewhat misleading.
> 
> Amend the logic so that, in addition to the linux-next consideration,
> the script also looks for a tag corresponding to the 6.4.6-rt8 part of
> what will become the `uname -r` string. With this patch (so 29 patches
> on top of v6.4.6-rt8), one instead gets
> 
> $ make -s kernelrelease
> 6.4.6-rt8-00029-gd533209291a2
> 
> While there, note that the line
> 
>   git describe --exact-match --match=$tag $tag 2>/dev/null
> 
> obviously asks if $tag is an annotated tag, but it does not actually
> tell if the commit pointed to has any relation to HEAD. So remove both
> uses of --exact-match, and instead just ask if the description
> generated is identical to the tag we provided. Since we then already
> have the result of
> 
>   git describe --match=$tag
> 
> we also end up reducing the number of times we invoke "git describe".

Dropping "--exact-match" is resulting in unnacceptable latencies for me.  I don't
understand what this is trying to do well enough to make a suggestion, but something
has to change.

E.g. on my build box, a single `git describe --match=v6.5` takes ~8.5 seconds,
whereas a complete from-scratch kernel build takes <30 seconds, and an incremental
build takes <2 seconds.  When build testing to-be-applied changes, I compile each
commit ~15 times (different x86 configs plus one for each other KVM architecture),
which makes the ~8.5 second delay beyond painful.

And for actual testing, I can do an incremental build and boot into a VM in under
20 seconds, a multi-second delay is extremely painful there as well.
