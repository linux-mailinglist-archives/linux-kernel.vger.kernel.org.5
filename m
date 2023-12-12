Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5A780E83E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346081AbjLLJxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjLLJxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:53:38 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F21C9B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:53:45 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6d9f4eed60eso3015717a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702374824; x=1702979624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4FYnDfB20cXN+psZI3a8Iagv7wP611UUkj3XdrM8zwc=;
        b=jy6GG82Kfy7+kpAMojflYCw74l7KS074o108mFcNQaovAuEhXAwJreJJchufoCMDcY
         M1mFTwo5ayLhYR5ThQ5OrlK0mJL1wnnlaaqKF9AsOiWrHMQiHfW/b7jhyIUXhv4cJkm+
         ga6Lf1LO8DWdGIp3O3XxWHsKroOJM5LP9L/jJmODe5RmkWs6fyUbVAzNtTB2YNhYYoF8
         1XjdBWvr+gyuHVNTdQyk/V1S35TxTPoMJQiBOt8mORsF56cm/NMjdziTKtKDfOldJOsA
         wy8KOzL52oK9gqD3JF0T707RSaVIsvEQn6ipC+5UHc7KsdM3qYgZvxJGsmsYzb5qm0eW
         Q3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702374824; x=1702979624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FYnDfB20cXN+psZI3a8Iagv7wP611UUkj3XdrM8zwc=;
        b=Z6lzgg3mK/FBO/elQ2r2r/gmpTtyc7owiS5yMRcZtYmdKRdz13RMbiG0SS4hNJnB5x
         f0aeKw7aBVWg4Y95z7/kyA+TT9Slv7REbQLt+Al/q0k6i6DUx7EK0brBTgPAOTdzOO2K
         HolYegZ6E4AMYc5JwiscKiAgqaQOVdPnnL3ERXmosXilpoz3OYnLYlapApVoxSKlNzgx
         NZo55h5PXf9z0nW2S8hd9pTjkQII1+4EyDA5QMFsfCRZHOmYkcAhzgy0p1QAjNqoFnCn
         kNlIB0HrwcGVe4hLS6NeJJYU2XX+ct6MYwsiT8Fdbc0mmu59kYYk5+JF8DkrbZUmfGuX
         NSOA==
X-Gm-Message-State: AOJu0YyA6D0OsXDySE8vTe3AMZ5jwqSCxPlW+RkW7hmVMbqzg9Eo4Wly
        exEccKgMGR5tvlUVdi6yWHQWM/qxGefJYX4JbOQimboMZmc=
X-Google-Smtp-Source: AGHT+IFTApqJAGqbB4h0GszqmK3xeuVDNAWBcAkjrvuDodO0ZqZceVo9RZ+Zd7Uiy+NsQjon5lH58NWRVuJZXUOnvvU=
X-Received: by 2002:a05:6359:4c25:b0:170:c921:fed9 with SMTP id
 kj37-20020a0563594c2500b00170c921fed9mr6323036rwc.60.1702374824473; Tue, 12
 Dec 2023 01:53:44 -0800 (PST)
MIME-Version: 1.0
References: <20230410100255.16755-1-borneo.antonio@gmail.com>
In-Reply-To: <20230410100255.16755-1-borneo.antonio@gmail.com>
From:   Antonio Borneo <borneo.antonio@gmail.com>
Date:   Tue, 12 Dec 2023 10:53:31 +0100
Message-ID: <CAAj6DX0SpA0jFtKT0Pu02BuXsF5_=UG0N4H8iyB9Rf-gqK50dA@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: exclude gerrit's Change-Id line from commit description
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org, borneo.antonio@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023, 12:03 Antonio Borneo <borneo.antonio@gmail.com> wrote:
> Checkpatch rejects patches that have empty commit description and
> logs them with:
>         WARNING:COMMIT_MESSAGE: Missing commit description - Add an appropriate one
> But if the patch has a gerrit's Change-Id line placed before the
> line Signed-off-by, then checkpatch considers the Change-Id line
> as a valid commit description text.
>
> Use the Change-Id tag as a marker of the end of the commit message,
> thus not counting its line as part of the commit description.
>
> This patch is not relevant for the Linux kernel development process
> as gerrit is not involved and the Change-Id tag is rejected. But
> other projects, like OpenOCD, base the development on gerrit and
> reuse kernel's checkpatch with flag '--ignore GERRIT_CHANGE_ID'.
>
> Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
> ---
>  scripts/checkpatch.pl | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index bd44d12965c9..5b2212d5907b 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3224,6 +3224,7 @@ sub process {
>
>  # Check for Gerrit Change-Ids not in any patch context
>                 if ($realfile eq '' && !$has_patch_separator && $line =~ /^\s*change-id:/i) {
> +                       $in_commit_log = 0;
>                         if (ERROR("GERRIT_CHANGE_ID",
>                                   "Remove Gerrit Change-Id's before submitting upstream\n" . $herecurr) &&
>                             $fix) {
>
> base-commit: 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d
> --
> 2.40.0
>

Gentle ping about this patch

Best Regards
Antonio
