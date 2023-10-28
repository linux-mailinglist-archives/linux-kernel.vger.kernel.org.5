Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5907DA7D5
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 17:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjJ1PfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 11:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJ1PfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 11:35:02 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41418D3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 08:35:00 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d9caf5cc948so2364462276.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 08:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698507299; x=1699112099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8nz7Y347FoMR7VcvdwalitvLrVo2XnIXuxuFyGWSWA=;
        b=Z2UKQk0Y9z2cMwJJdzZ1TDugoMe287IWUTyC16I49d+UY6VOr/YX/tB7zpQXGRS/1G
         /uFL3gx3KvcMT8iWfbycktH+jyvKKITi8q9aObDMuzbRCiXL2KFr7POU3eC+lB9dhKtB
         U8tiYI7dYJTD1onDsSZLINhyhBgmUo1q7ANuXUQH6EzxAuKYdhBbB4mRWBcsCI7XN4E6
         iIN/eHm8nadJB4DjHfdDNCL+mLb3xQ4A/WjhO9l6bvjFINQQqJP4MpdP5tWMYb6BGGMI
         b725TlFim/R4xx8nj5/UzRxZoK9XhhYNn+rABmYaucGCvVySanitMiS6aohK70Re/iyU
         UvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698507299; x=1699112099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8nz7Y347FoMR7VcvdwalitvLrVo2XnIXuxuFyGWSWA=;
        b=BBAFaMxtmRLzhoXttSDbz23IRUaYQIufWXD7zlbMvQQsV/wkk1fn7hUW6PihJV47hb
         UxCJukA6AdjD6AHztrFkwet18ZHI87sXFOyCDkR1+Y2FXWNiQrek16OFAyqlRDgQ0NP2
         sPFpVGSFe6LEcLIdDapgRahQQOnntu6PQFn9XTm0iQalhKrR3mR8zXBeEadSknU6POUd
         RPvccl5pMVYosXIH0FLAgTDwHgp31HenWTychwPHRy2qNzx/sOd2ZTr4s1rLQ95u7fUF
         /HVNRPtrUyFJH7ieKwpEiElaDejrJEGqmxbpLRbqCT8xEOgQMDTtRghj/kElu/Qk2x/L
         tEMA==
X-Gm-Message-State: AOJu0YwGd/kUGUOSMuXqkKS7lQj3KZ172ndMLkgDeAuBoCCPawIH4H3V
        veIcIJTeI1Y4hi6/4tCow21N/SUrvgeblHmkZfbE
X-Google-Smtp-Source: AGHT+IEhxraiZOz31Kh6g9w1ZKQEdOuTpbHM8zmyCV+huYIiGODPmBP0B+MGMGs4ux5B9P9q18WHQUubaNepET00LNw=
X-Received: by 2002:a05:6902:1209:b0:da0:52e4:b5aa with SMTP id
 s9-20020a056902120900b00da052e4b5aamr7298142ybu.8.1698507299391; Sat, 28 Oct
 2023 08:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231027163400.5764d549@canb.auug.org.au> <20231027.Soon0Gee4xul@digikod.net>
In-Reply-To: <20231027.Soon0Gee4xul@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 28 Oct 2023 11:34:48 -0400
Message-ID: <CAHC9VhTHVhgdBpSkMocmgWZgQzMcxMwC8Tp=Qr13Xvxaof82Pw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the landlock tree
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 8:56=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> Thanks Stephen, your patch is good! I tested it with the merge of my
> branch and LSM/dev-staging.
>
> The new Landlock changes (tested in -next for a few weeks) add a new
> call to security_add_hooks() which gets a new signature with commit
> 9b09f11320db ("LSM: Identify modules by more than name") from
> the LSM/dev-staging branch [1].
>
> I plan to send a PR with my branch in the next merge window (for
> v6.7-rc1).
>
> We should squash Stephen's patch in commit 9b09f11320db ("LSM:
> Identify modules by more than name") but it would not be possible
> without my branch. I see two solutions:
> * keep Stephen's patch in -next only, or
> * rebase LSM/dev-staging on my branch now, and rebase it later on
>   v6.7-rc1 once my branch is merged (which is the workflow described in
>   [1]).
>
> Paul, what do you think?

Thanks Stephen, Micka=C3=ABl.

Once the Landlock tree is pulled into Linus' tree during the next
merge window I'll update the LSM syscall patches currently living in
lsm/dev-staging and this conflict should go away.  FWIW, there are
other conflicts with the LSM syscall patchset, most notably in the
syscall registrations, that should also resolve themselves when I
rebase on top of v6.7-rc1.

--=20
paul-moore.com
