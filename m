Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9397C5470
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346915AbjJKMz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjJKMz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:55:27 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D309D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:55:25 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-4547428694dso2673837137.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697028925; x=1697633725; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TJHkKAgZfrxS1O8Tslb2tMsF0PPp/zqOL3rMiik7kWc=;
        b=Lz2M2d/r4s97ZOBTxD6wi/FYiH09kYAdVnpLQnfaZGz/9u2CHVruRBFSmhYfoPponp
         jsj+8dUOpXBoEg9L0CgBGvgg46GmXB34BcWp8CJSqQbgGCdsAsYxvhUBNsyi5Ly/FJoe
         nMQH2sg6UtMW42RC3oR9A0PDLP4YQr7BWtgWZRnJ8ExqPd/Z06vvpcRJOwRi9ycRxOKs
         Pbxl7N7BaKuqXYHE9OpsBtpIyj8HvHRzocy9t6adwMg8Rbpo7QZTja5UFcKstam0tqtL
         IMkebO5QLmaMPJ+2q9YkLX98jCXD9BJo82k63Gm1AfpT9sgzOufCjwSM/U5fLqpZdhBZ
         nc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697028925; x=1697633725;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TJHkKAgZfrxS1O8Tslb2tMsF0PPp/zqOL3rMiik7kWc=;
        b=grf8WXofLr+D9qbqrZvE+pjLt8ki/N1f53M8FRoKPqpLzbiAYVX6SHorWAijo3D0K/
         MQwR5D5Vo2pLWyS0zxPziAn5FsliBf13BGeJtq3GTdlG6ruECENcqGLt9o/yYtRutug3
         U2fLSXCR5yhN/u9gZW4oHYfEiTRXlzICo0cYGsWKf0Nsr7cWmwxr0DijTMWyCioRCzGc
         KzouBUwjoOxewrAnGL9SDkB1NcOZodmPfuHIZdMtewoCscHm1SWst8ShSCF6C9DYxbSI
         01b+QC/YfPGInrO7lIrG48BliAsA85pH6C7T0Sf9Khs4K57ZA3ZjP0J6ThxN/WF8v2Po
         ZzWA==
X-Gm-Message-State: AOJu0Yz/YN7pBD8C9BlAyE1iNBtSWhVdTDQys/1YJq59Lz/L6vTAQb6Q
        Yh4MQr7PEVx7Y186SssyYA6g3XS0LqiQH2X/zdqOaA==
X-Google-Smtp-Source: AGHT+IE/GS3ZefqbCTRAxvzj5P2FzW1ao64b6+xoVl1jPWppctYlhVhjbQJTPsbdrbj5cpefjtgO744OBsx/DINQjDg=
X-Received: by 2002:a67:f489:0:b0:44e:d415:76a3 with SMTP id
 o9-20020a67f489000000b0044ed41576a3mr20147184vsn.11.1697028923184; Wed, 11
 Oct 2023 05:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231010231616.3122392-1-jarkko@kernel.org> <CAFA6WYMdrCfqMVExYBbhCK7vUSQffyUfSWpQO0=HeQc6Edz9OA@mail.gmail.com>
 <186a4b62517ead88df8c3c0e9e9585e88f9a6fd8.camel@kernel.org>
 <0aeb4d88952aff53c5c1a40b547a9819ebd1947e.camel@kernel.org>
 <CAFA6WYObvJvQv=-JJ5gnmFqJKbT=4JnT+ErC=iB1KfnYfVn7Ag@mail.gmail.com> <79fe0b97e2f5d1f02d08c9f633b7c0da13dc9127.camel@kernel.org>
In-Reply-To: <79fe0b97e2f5d1f02d08c9f633b7c0da13dc9127.camel@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 11 Oct 2023 18:25:11 +0530
Message-ID: <CAFA6WYMrg3VBYvdV8Or==YK_qATk22bL+_ryDC-oO4jVf7DCWg@mail.gmail.com>
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

On Wed, 11 Oct 2023 at 18:07, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Wed, 2023-10-11 at 17:47 +0530, Sumit Garg wrote:
> > On Wed, 11 Oct 2023 at 16:04, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > >
> > > On Wed, 2023-10-11 at 13:12 +0300, Jarkko Sakkinen wrote:
> > > > On Wed, 2023-10-11 at 11:27 +0530, Sumit Garg wrote:
> > > > > On Wed, 11 Oct 2023 at 04:46, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > > > >
> > > > > > Do bind neither static calls nor trusted_key_exit() before a successful
> > > > > > init, in order to maintain a consistent state. In addition, depart the
> > > > > > init_trusted() in the case of a real error (i.e. getting back something
> > > > > > else than -ENODEV).
> > > > > >
> > > > > > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > > > > Closes: https://lore.kernel.org/linux-integrity/CAHk-=whOPoLaWM8S8GgoOPT7a2+nMH5h3TLKtn=R_3w4R1_Uvg@mail.gmail.com/
> > > > > > Cc: stable@vger.kernel.org # v5.13+
> > > > > > Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> > > > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > > > ---
> > > > > >  security/keys/trusted-keys/trusted_core.c | 20 ++++++++++----------
> > > > > >  1 file changed, 10 insertions(+), 10 deletions(-)
> > > > > >
> > > > > > diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
> > > > > > index 85fb5c22529a..fee1ab2c734d 100644
> > > > > > --- a/security/keys/trusted-keys/trusted_core.c
> > > > > > +++ b/security/keys/trusted-keys/trusted_core.c
> > > > > > @@ -358,17 +358,17 @@ static int __init init_trusted(void)
> > > > > >                 if (!get_random)
> > > > > >                         get_random = kernel_get_random;
> > > > > >
> > > > > > -               static_call_update(trusted_key_seal,
> > > > > > -                                  trusted_key_sources[i].ops->seal);
> > > > > > -               static_call_update(trusted_key_unseal,
> > > > > > -                                  trusted_key_sources[i].ops->unseal);
> > > > > > -               static_call_update(trusted_key_get_random,
> > > > > > -                                  get_random);
> > > > > > -               trusted_key_exit = trusted_key_sources[i].ops->exit;
> > > > > > -               migratable = trusted_key_sources[i].ops->migratable;
> > > > > > -
> > > > > >                 ret = trusted_key_sources[i].ops->init();
> > > > > > -               if (!ret)
> > > > > > +               if (!ret) {
> > > > > > +                       static_call_update(trusted_key_seal, trusted_key_sources[i].ops->seal);
> > > > > > +                       static_call_update(trusted_key_unseal, trusted_key_sources[i].ops->unseal);
> > > > > > +                       static_call_update(trusted_key_get_random, get_random);
> > > > > > +
> > > > > > +                       trusted_key_exit = trusted_key_sources[i].ops->exit;
> > > > > > +                       migratable = trusted_key_sources[i].ops->migratable;
> > > > > > +               }
> > > > > > +
> > > > > > +               if (!ret || ret != -ENODEV)
> > > > >
> > > > > As mentioned in the other thread, we should allow other trust sources
> > > > > to be initialized if the primary one fails.
> > > >
> > > > I sent the patch before I received that response but here's what you
> > > > wrote:
> > > >
> > > > "We should give other trust sources a chance to register for trusted
> > > > keys if the primary one fails."
> > > >
> > > > 1. This condition is lacking an inline comment.
> > > > 2. Neither this response or the one that you pointed out has any
> > > >    explanation why for any system failure the process should
> > > >    continue.
> > > >
> > > > You should really know the situations (e.g. list of posix error
> > > > code) when the process can continue and "allow list" those. This
> > > > way way too abstract. It cannot be let all possible system failures
> > > > pass.
> > >
> > > And it would nice if it printed out something for legit cases. Like
> > > "no device found" etc. And for rest it must really withdraw the whole
> > > process.
> >
> > IMO, it would be quite tricky to come up with an allow list. Can we
> > keep "EACCES", "EPERM", "ENOTSUPP" etc in that allow list? I think
> > these are all debatable.
>
> Yes, that does sounds reasonable.
>
> About the debate. Well, it is better eagerly block and tree falls down
> somewhere we can consider extending the list through a fix.
>
> This all wide open is worse than a few glitches somewhere, which are
> trivial to fix.
>

Fair enough, I would suggest we document it appropriately such that it
is clear to the users or somebody looking at the code.

-Sumit

> BR, Jarkko
