Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4F679D734
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbjILRH7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Sep 2023 13:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236950AbjILRHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:07:54 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FCA1702
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:07:50 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-68faf930054so2666601b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694538470; x=1695143270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9tCnWlA9XrE1nFim4ctCI9ELCfqKkedS78A2cZgsAs=;
        b=nf8MYhd+lI6WrLkVM5GxEETVXjivN8q8uy+/JcVygY1JmA6J9eQgMDImn2zjzBuMcn
         wZ5FvAiJK1iB1KtYr4Wgd/Dc3OTcXFGv8f7U6XAytyRRCKSl7JIso0ikH16ApRgsp9Lk
         DxsI72boAWP8fOuavvEDMEZ4wCyyG6x8R2tkVjxBC+y328gE09d3CCd6s6gpT1xLBN1d
         tRTG990MCTm8ukcbTECmEcCNB08vJ8ZOMTeUDNfYP1OoFwj+sPzSR847fkyCgUdGsxE5
         tLHwjh4sxsWMjfwd13V+0E9ZoDATwUBlVI4JJAfSY5BRqwCqEmf4iu6840MJPI9Z5Wk7
         1sCQ==
X-Gm-Message-State: AOJu0YzQV8d+IMKz+v7HVv6efgPOEuOjDZrvoDkls2qpIP17DZyux0kd
        BobGjHzXNVqUE0lnKPPo3xcr49Li1gFmcS6/nbpvNA==
X-Google-Smtp-Source: AGHT+IEX304k/En1unElz+dinA3pOm9BIfW/BeJRpXk+dmhwOWv24esWXOeFgonERRywb9hmuicVqc7Me333ZHXCx3Q=
X-Received: by 2002:a05:6a20:54a1:b0:155:2c91:f8e5 with SMTP id
 i33-20020a056a2054a100b001552c91f8e5mr25646pzk.14.1694538470311; Tue, 12 Sep
 2023 10:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230911223238.3495955-1-jforbes@fedoraproject.org> <CVGU920P4LEH.4WNZCAJI4URK@suppilovahvero>
In-Reply-To: <CVGU920P4LEH.4WNZCAJI4URK@suppilovahvero>
From:   Justin Forbes <jforbes@fedoraproject.org>
Date:   Tue, 12 Sep 2023 12:07:38 -0500
Message-ID: <CAFxkdAoSswhixvD6u0VLD=D9aaX-JFAdDewTF_WJmMwSbZDxeg@mail.gmail.com>
Subject: Re: [PATCH] tpm: Fix typo in tpmrm class definition
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 4:41 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Tue Sep 12, 2023 at 1:32 AM EEST, Justin M. Forbes wrote:
> > Commit d2e8071bed0be ("tpm: make all 'class' structures const")
> > unfortunately had a typo for the name on tpmrm.
> >
> > Fixes: d2e8071bed0b ("tpm: make all 'class' structures const")
> > Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
> > ---
> >  drivers/char/tpm/tpm-chip.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > index 23f6f2eda84c..42b1062e33cd 100644
> > --- a/drivers/char/tpm/tpm-chip.c
> > +++ b/drivers/char/tpm/tpm-chip.c
> > @@ -33,7 +33,7 @@ const struct class tpm_class = {
> >       .shutdown_pre = tpm_class_shutdown,
> >  };
> >  const struct class tpmrm_class = {
> > -     .name = "tmprm",
> > +     .name = "tpmrm",
> >  };
> >  dev_t tpm_devt;
> >
> > --
> > 2.41.0
>
> Unfortunately your patch does not apply:

Fixed with the V2 I just sent out. Seems I had suppress-blank-empty =
true in a config file somewhere. Apologies for wasting your time.

Justin

> $ git-tip
> 0bb80ecc33a8 (HEAD -> next, tag: v6.6-rc1, upstream/master, origin/next) Linux 6.6-rc1
>
> $ b4 am 20230911223238.3495955-1-jforbes@fedoraproject.org
> Analyzing 1 messages in the thread
> Checking attestation on all messages, may take a moment...
> ---
>   ✓ [PATCH] tpm: Fix typo in tpmrm class definition
>   ---
>   ✓ Signed: DKIM/linuxtx.org (From: jforbes@fedoraproject.org)
> ---
> Total patches: 1
> ---
>  Link: https://lore.kernel.org/r/20230911223238.3495955-1-jforbes@fedoraproject.org
>  Base: applies clean to current tree
>        git checkout -b 20230911_jforbes_fedoraproject_org HEAD
>        git am ./20230911_jforbes_tpm_fix_typo_in_tpmrm_class_definition.mbx
>
> $ git am -3 20230911_jforbes_tpm_fix_typo_in_tpmrm_class_definition.mbx
> Applying: tpm: Fix typo in tpmrm class definition
> error: corrupt patch at line 18
> error: could not build fake ancestor
> Patch failed at 0001 tpm: Fix typo in tpmrm class definition
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> BR, Jarkko
