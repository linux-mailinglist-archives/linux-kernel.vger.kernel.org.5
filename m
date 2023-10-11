Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7556A7C5372
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbjJKMRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjJKMR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:17:27 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77679DC
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:17:23 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a7d9d357faso11778027b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697026642; x=1697631442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sIwwSVPQgNdZrWxFWOKz+2uIJcJJpTj8JRe+NnP9VHY=;
        b=LZfqlEFB66enpkByNrCJLWD1XzkygJVu38cM3b8tPbCRW2660S2BK8kOSBmngCuzYN
         L31g56pVSheWxnDUgN2pCGV8i6RlK/lAWDaAvK6QmxRPAIqRVsAe6ASNCT3+wcNDtxbc
         YH3wl8lkWzjSdV2K8wGRX7mstshrkktmuSwRyuIxumCc390tC3BzmvrKq3mbrErmRDun
         QS1ydHoYwHiWHISP4nr75RuwxggEuOF1ablY5RWQyM1lKhJfDvmVnQi20C2wQvMDVyeU
         vKDNc8Ej1Lk2cLx1E4q4dwJY1hBpzqCRznL+FZFQ3uoFZggIYsFbm+uK5b/RTiXDjYwc
         ysDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026642; x=1697631442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sIwwSVPQgNdZrWxFWOKz+2uIJcJJpTj8JRe+NnP9VHY=;
        b=kwd9rkyB+ltCV0iyh5u1pEVKolYWF661Z4kORs0j2oXLChUmv3nnjtZbXvQWmT4ZBd
         6joZmArmgpVbEdew9NHok0ik9cpA5NQX7M0coWep/qJu6AKK3gL+S8oxIKQu7tPrbxte
         QtNgf3wQhCjX8ziFiSxe19m393JJdpG1zHdqDSbJNhulbo9K7FYn8LDvHQVfYLbe2bSp
         NSkcjbm38Fqrxscssvo6TQ6OGMPlu+0tFYudkuH2pteK3EiZuAlcL8rP+iDPRkt0CUBB
         /zhA7ZPl7/c/oegKjtXn6dsF1d2+e64NACLVa7qDxsjLfcoXhqY/y6YFFQWxUfNmq5QR
         6frA==
X-Gm-Message-State: AOJu0YxSNbhX7BbZ3aCI4xSOwTlmc6ljwjRYSv3VH9mhwu3MOPiGCmJH
        HIm55KR9SQYOBKd5zS6eOjkhIDkCA5Jzbn6ZbABq2w==
X-Google-Smtp-Source: AGHT+IHdsGpUl2F/ABzPt0MiHqRLMOqD782Zj3S2K92UY3MNeAlMxM0Dfsb02ulGGkYsBm28PZa268wbqGdNjOa9tuA=
X-Received: by 2002:a05:690c:dd2:b0:5a4:f7d3:394e with SMTP id
 db18-20020a05690c0dd200b005a4f7d3394emr28388983ywb.14.1697026642640; Wed, 11
 Oct 2023 05:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231010231616.3122392-1-jarkko@kernel.org> <CAFA6WYMdrCfqMVExYBbhCK7vUSQffyUfSWpQO0=HeQc6Edz9OA@mail.gmail.com>
 <186a4b62517ead88df8c3c0e9e9585e88f9a6fd8.camel@kernel.org> <0aeb4d88952aff53c5c1a40b547a9819ebd1947e.camel@kernel.org>
In-Reply-To: <0aeb4d88952aff53c5c1a40b547a9819ebd1947e.camel@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 11 Oct 2023 17:47:11 +0530
Message-ID: <CAFA6WYObvJvQv=-JJ5gnmFqJKbT=4JnT+ErC=iB1KfnYfVn7Ag@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: Rollback init_trusted() consistently
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     keyrings@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable@vger.kernel.org, James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:KEYS-TRUSTED" <linux-integrity@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 at 16:04, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Wed, 2023-10-11 at 13:12 +0300, Jarkko Sakkinen wrote:
> > On Wed, 2023-10-11 at 11:27 +0530, Sumit Garg wrote:
> > > On Wed, 11 Oct 2023 at 04:46, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > >
> > > > Do bind neither static calls nor trusted_key_exit() before a successful
> > > > init, in order to maintain a consistent state. In addition, depart the
> > > > init_trusted() in the case of a real error (i.e. getting back something
> > > > else than -ENODEV).
> > > >
> > > > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > > Closes: https://lore.kernel.org/linux-integrity/CAHk-=whOPoLaWM8S8GgoOPT7a2+nMH5h3TLKtn=R_3w4R1_Uvg@mail.gmail.com/
> > > > Cc: stable@vger.kernel.org # v5.13+
> > > > Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > ---
> > > >  security/keys/trusted-keys/trusted_core.c | 20 ++++++++++----------
> > > >  1 file changed, 10 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
> > > > index 85fb5c22529a..fee1ab2c734d 100644
> > > > --- a/security/keys/trusted-keys/trusted_core.c
> > > > +++ b/security/keys/trusted-keys/trusted_core.c
> > > > @@ -358,17 +358,17 @@ static int __init init_trusted(void)
> > > >                 if (!get_random)
> > > >                         get_random = kernel_get_random;
> > > >
> > > > -               static_call_update(trusted_key_seal,
> > > > -                                  trusted_key_sources[i].ops->seal);
> > > > -               static_call_update(trusted_key_unseal,
> > > > -                                  trusted_key_sources[i].ops->unseal);
> > > > -               static_call_update(trusted_key_get_random,
> > > > -                                  get_random);
> > > > -               trusted_key_exit = trusted_key_sources[i].ops->exit;
> > > > -               migratable = trusted_key_sources[i].ops->migratable;
> > > > -
> > > >                 ret = trusted_key_sources[i].ops->init();
> > > > -               if (!ret)
> > > > +               if (!ret) {
> > > > +                       static_call_update(trusted_key_seal, trusted_key_sources[i].ops->seal);
> > > > +                       static_call_update(trusted_key_unseal, trusted_key_sources[i].ops->unseal);
> > > > +                       static_call_update(trusted_key_get_random, get_random);
> > > > +
> > > > +                       trusted_key_exit = trusted_key_sources[i].ops->exit;
> > > > +                       migratable = trusted_key_sources[i].ops->migratable;
> > > > +               }
> > > > +
> > > > +               if (!ret || ret != -ENODEV)
> > >
> > > As mentioned in the other thread, we should allow other trust sources
> > > to be initialized if the primary one fails.
> >
> > I sent the patch before I received that response but here's what you
> > wrote:
> >
> > "We should give other trust sources a chance to register for trusted
> > keys if the primary one fails."
> >
> > 1. This condition is lacking an inline comment.
> > 2. Neither this response or the one that you pointed out has any
> >    explanation why for any system failure the process should
> >    continue.
> >
> > You should really know the situations (e.g. list of posix error
> > code) when the process can continue and "allow list" those. This
> > way way too abstract. It cannot be let all possible system failures
> > pass.
>
> And it would nice if it printed out something for legit cases. Like
> "no device found" etc. And for rest it must really withdraw the whole
> process.

IMO, it would be quite tricky to come up with an allow list. Can we
keep "EACCES", "EPERM", "ENOTSUPP" etc in that allow list? I think
these are all debatable.

The original intention to iterate through the trust source list was to
allow a single Linux kernel binary to support platforms with varying
trust sources (one or choose one from multiple) available. IMO, any
restriction on the basis of error codes here since we can't predict
them correctly may forfeit this intended use-case.

-Sumit

>
> BR, Jarkko
