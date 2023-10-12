Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31237C6715
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347250AbjJLHmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347262AbjJLHlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:41:40 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096E1D58
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:41:16 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-452b0430cc5so303341137.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697096475; x=1697701275; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HuTzVVpWdQXfIbCNcLDHhiGj4g2lhIgP95vVCMWnKu8=;
        b=FjmhU7F58fXYqrpfekItfgbA6ig+1Po/mOShaCO2Bj7DIGV+zEBaohsxFI7BNins50
         tgAoQBwq2fTy7QHeWtdlveyQpqSrbbSXspe0k1WN6s80VHRC4VFSIJuz8vkTAe2IvlT8
         qyIno3wNoMRN8JOeFG4ZpSZL9T68KSuI5ykkvn3bTOdQcYK5JFSJAB+zeXGvYr1qwML/
         B6t8fy+Jb8xu4rf412CCSPGWDQDSRDGMnEjHzqx+5lnSn5sW22NMQ3IE+HXG02p4dzhU
         /yM1YwsrUsehl3XlSkZdgZBb7Vq7KbVM84a/QqoVe/Zb/V4tRpRioC4KwVPP16ey3yOl
         AD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697096475; x=1697701275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HuTzVVpWdQXfIbCNcLDHhiGj4g2lhIgP95vVCMWnKu8=;
        b=CL2d2B7cVe5cld1jdabvctmp8AWJHm1+wlnNEkw4u3tR0ubogVsrg7kVUeOMb25vot
         O8p5uFVs2cxzySiw5xqPQY12Lpzt3eL9DITR28Thw7LuRQpK5Q6qxtUMOKBesyUbprif
         uT74rXiJesjf5w/c9grW+byxU8MPhsFWik4gvxIRWC/G75sTdNhEIR11xrzYp4nvDIXP
         lXGz1l8Cx+ELpCc35ktLJDCZq5oEfnA8iNFLy3Dk4kSm/Qecj7L7DXOrazgjpcq+IFHc
         R+gEoIrVsdvNLeFNHcYpEcN0X1XutSd2d2xEYqWaBt+O+c8YoxEKrXJk/jTwSxBB7yIO
         48cQ==
X-Gm-Message-State: AOJu0Yw1rP1tx/KOTZ2MEGQvLiVmlabDy/7exFwOMP6IRO3Y0kP/57rw
        SR3GsyNA5ESbdcIc2Tr8/qrgiu+wQvIWFLhLZWLfMA==
X-Google-Smtp-Source: AGHT+IFIoyyfZlTvB8S/gl1Hw8oygtouPPoDfVj32Vyph4N5NM7wLZ+d5sx0lnWhPESWJqsWmh24Zi0Fkzqqw/HJY6k=
X-Received: by 2002:a67:fc43:0:b0:450:f9eb:f412 with SMTP id
 p3-20020a67fc43000000b00450f9ebf412mr23274386vsq.5.1697096474893; Thu, 12 Oct
 2023 00:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231010231616.3122392-1-jarkko@kernel.org> <CAFA6WYMdrCfqMVExYBbhCK7vUSQffyUfSWpQO0=HeQc6Edz9OA@mail.gmail.com>
 <186a4b62517ead88df8c3c0e9e9585e88f9a6fd8.camel@kernel.org>
 <0aeb4d88952aff53c5c1a40b547a9819ebd1947e.camel@kernel.org>
 <CAFA6WYObvJvQv=-JJ5gnmFqJKbT=4JnT+ErC=iB1KfnYfVn7Ag@mail.gmail.com>
 <79fe0b97e2f5d1f02d08c9f633b7c0da13dc9127.camel@kernel.org>
 <CAFA6WYMrg3VBYvdV8Or==YK_qATk22bL+_ryDC-oO4jVf7DCWg@mail.gmail.com>
 <b70d6be5980185a4fb4205e71c56111183e1f160.camel@kernel.org>
 <CAFA6WYN0vXWZveAkzOfV_6Kki77SxgX7C=Xqe9brZMX1Dj2iLg@mail.gmail.com>
 <bdf8dbb2e1aeeb6396d7a03b8c00d0db729c602d.camel@kernel.org> <6b1c0255de20752b55b902df0882c018cf75032d.camel@kernel.org>
In-Reply-To: <6b1c0255de20752b55b902df0882c018cf75032d.camel@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 12 Oct 2023 13:11:03 +0530
Message-ID: <CAFA6WYM9_RmjTkvZ2xgr+GrhwWfJVYG8Zn+A++gOuNOsDZk0EA@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 at 19:35, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Wed, 2023-10-11 at 16:55 +0300, Jarkko Sakkinen wrote:
> > On Wed, 2023-10-11 at 19:12 +0530, Sumit Garg wrote:
> > > On Wed, 11 Oct 2023 at 18:36, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > >
> > > > On Wed, 2023-10-11 at 18:25 +0530, Sumit Garg wrote:
> > > > > On Wed, 11 Oct 2023 at 18:07, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > > > >
> > > > > > On Wed, 2023-10-11 at 17:47 +0530, Sumit Garg wrote:
> > > > > > > On Wed, 11 Oct 2023 at 16:04, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Wed, 2023-10-11 at 13:12 +0300, Jarkko Sakkinen wrote:
> > > > > > > > > On Wed, 2023-10-11 at 11:27 +0530, Sumit Garg wrote:
> > > > > > > > > > On Wed, 11 Oct 2023 at 04:46, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Do bind neither static calls nor trusted_key_exit() before a successful
> > > > > > > > > > > init, in order to maintain a consistent state. In addition, depart the
> > > > > > > > > > > init_trusted() in the case of a real error (i.e. getting back something
> > > > > > > > > > > else than -ENODEV).
> > > > > > > > > > >
> > > > > > > > > > > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > > > > > > > > > Closes: https://lore.kernel.org/linux-integrity/CAHk-=whOPoLaWM8S8GgoOPT7a2+nMH5h3TLKtn=R_3w4R1_Uvg@mail.gmail.com/
> > > > > > > > > > > Cc: stable@vger.kernel.org # v5.13+
> > > > > > > > > > > Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> > > > > > > > > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > > > > > > > > ---
> > > > > > > > > > >  security/keys/trusted-keys/trusted_core.c | 20 ++++++++++----------
> > > > > > > > > > >  1 file changed, 10 insertions(+), 10 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
> > > > > > > > > > > index 85fb5c22529a..fee1ab2c734d 100644
> > > > > > > > > > > --- a/security/keys/trusted-keys/trusted_core.c
> > > > > > > > > > > +++ b/security/keys/trusted-keys/trusted_core.c
> > > > > > > > > > > @@ -358,17 +358,17 @@ static int __init init_trusted(void)
> > > > > > > > > > >                 if (!get_random)
> > > > > > > > > > >                         get_random = kernel_get_random;
> > > > > > > > > > >
> > > > > > > > > > > -               static_call_update(trusted_key_seal,
> > > > > > > > > > > -                                  trusted_key_sources[i].ops->seal);
> > > > > > > > > > > -               static_call_update(trusted_key_unseal,
> > > > > > > > > > > -                                  trusted_key_sources[i].ops->unseal);
> > > > > > > > > > > -               static_call_update(trusted_key_get_random,
> > > > > > > > > > > -                                  get_random);
> > > > > > > > > > > -               trusted_key_exit = trusted_key_sources[i].ops->exit;
> > > > > > > > > > > -               migratable = trusted_key_sources[i].ops->migratable;
> > > > > > > > > > > -
> > > > > > > > > > >                 ret = trusted_key_sources[i].ops->init();
> > > > > > > > > > > -               if (!ret)
> > > > > > > > > > > +               if (!ret) {
> > > > > > > > > > > +                       static_call_update(trusted_key_seal, trusted_key_sources[i].ops->seal);
> > > > > > > > > > > +                       static_call_update(trusted_key_unseal, trusted_key_sources[i].ops->unseal);
> > > > > > > > > > > +                       static_call_update(trusted_key_get_random, get_random);
> > > > > > > > > > > +
> > > > > > > > > > > +                       trusted_key_exit = trusted_key_sources[i].ops->exit;
> > > > > > > > > > > +                       migratable = trusted_key_sources[i].ops->migratable;
> > > > > > > > > > > +               }
> > > > > > > > > > > +
> > > > > > > > > > > +               if (!ret || ret != -ENODEV)
> > > > > > > > > >
> > > > > > > > > > As mentioned in the other thread, we should allow other trust sources
> > > > > > > > > > to be initialized if the primary one fails.
> > > > > > > > >
> > > > > > > > > I sent the patch before I received that response but here's what you
> > > > > > > > > wrote:
> > > > > > > > >
> > > > > > > > > "We should give other trust sources a chance to register for trusted
> > > > > > > > > keys if the primary one fails."
> > > > > > > > >
> > > > > > > > > 1. This condition is lacking an inline comment.
> > > > > > > > > 2. Neither this response or the one that you pointed out has any
> > > > > > > > >    explanation why for any system failure the process should
> > > > > > > > >    continue.
> > > > > > > > >
> > > > > > > > > You should really know the situations (e.g. list of posix error
> > > > > > > > > code) when the process can continue and "allow list" those. This
> > > > > > > > > way way too abstract. It cannot be let all possible system failures
> > > > > > > > > pass.
> > > > > > > >
> > > > > > > > And it would nice if it printed out something for legit cases. Like
> > > > > > > > "no device found" etc. And for rest it must really withdraw the whole
> > > > > > > > process.
> > > > > > >
> > > > > > > IMO, it would be quite tricky to come up with an allow list. Can we
> > > > > > > keep "EACCES", "EPERM", "ENOTSUPP" etc in that allow list? I think
> > > > > > > these are all debatable.
> > > > > >
> > > > > > Yes, that does sounds reasonable.
> > > > > >
> > > > > > About the debate. Well, it is better eagerly block and tree falls down
> > > > > > somewhere we can consider extending the list through a fix.
> > > > > >
> > > > > > This all wide open is worse than a few glitches somewhere, which are
> > > > > > trivial to fix.
> > > > > >
> > > > >
> > > > > Fair enough, I would suggest we document it appropriately such that it
> > > > > is clear to the users or somebody looking at the code.
> > > >
> > > > I went throught the backends on how they implement init:
> > > >
> > > > 1. Returns -ENODEV when it does not exist.
> > > > 2. Calls driver_register(). Something is wrong enough if that
> > > >    fails to rollback the whole procedure.
> > > > 3. TPM: -ENODEV
> > > >
> > > > Therefore, I would keep in the existing patch since there is no weird
> > > > uapi visible legacy behavior to support in the first place. And for
> > > > that reason there is no good reason to have all those four POSIX rc's
> > > > in the list.
> > >
> > > Okay I can live with this patch as long as it doesn't break the
> > > intended use-case.
> >
> > Well this sort of policy has been already existing for some time:
> >
> >         /*
> >          * encrypted_keys.ko depends on successful load of this module even if
> >          * trusted key implementation is not found.
> >          */
> >         if (ret == -ENODEV)
> >                 return 0;
> >
> > If we would need a list of error codes, then this is also incorrect
> > implementation because the error codes that you listed should be
> > also success cases.
>

As I mentioned before we can go ahead with this policy for trust
sources and see how it pans out.

> The dead obvious constraint here is that whatever error codes are
> processed they need to be exact same anyway right?
>
> If things fall apart you should really not continue. This is IMHO
> categorizes as a critical bug,

Here we are discussing trust sources as multiple independent devices.
If a particular device probe/init fails then it shouldn't be a blocker
to probe/init another device.

> not just debatable aspect on how
> subsystems are engineered. I.e.I do not consider this as any sort
> of API discussion per se.

Agree, I see it as a policy decision for the trusted keys subsystem.

-Sumit

>
> BR, Jarkko
