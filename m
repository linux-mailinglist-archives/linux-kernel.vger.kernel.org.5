Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081AD7DC1F0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjJ3VcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjJ3VcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:32:01 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4E6F1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:31:56 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9c773ac9b15so743831066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698701514; x=1699306314; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m4CDD7gOBgZXjdEejFuqXex8Na0HsuHTt1rp6KKwgU8=;
        b=cFB4AMdfWXdBpvydQuLAOpk/VqmaHUK80IWOZi0itPlsiWNzAXUbC9JHNtmUvMwvl6
         LyMn+7bVtYTxbpduoVtCVHdrCn24GH1ZOrd4UKnPOy55qyFqF3zJkG3SxZFDLFWFAMu6
         tMcWa0E1SMT9ELiz1wzdHAtJhQlFrfos/rNAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698701514; x=1699306314;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4CDD7gOBgZXjdEejFuqXex8Na0HsuHTt1rp6KKwgU8=;
        b=dUsz/EKXa/5NFvpyKDpw72tKClZJHWcqm6nOil5pRf8WswbgrbgrASTE+IPfwMkkQ4
         KBoRd0tMxf2t/YpsWesvu1aSoDRxolP2cFm/n/W6DeQResga0hTG8RPx6x//J+wCA/6r
         LkXbrxgudM75xikYgVXKcHiZnqCqlzw0BnGKklVM7VrQ2roRsLPd5fsiDegGdTIm30Lh
         5u3tsl6sS+Jn+wwJ0QQJZ2e9pTKGH/ZApUoVQmKCrkysYrPNGFf5XxtSz8XCSejT7Afx
         fTzVJe3u2wE07M3BqDQg0iFPaUuXwfwwAmsBvF0qgKQwW/RvGQUtoSqWl92yrc5MayZC
         ktaQ==
X-Gm-Message-State: AOJu0YwIHhGBR0tP1QwrcvSgM0I3uR/ZUW62Tuk1gWuEREerlbVgO/6U
        4qak1dGLWPJaRxQfSIkU1q3O/zCQIGOMUSJ8TYlg+g==
X-Google-Smtp-Source: AGHT+IFhjP/mR9HRcpIkSuaZdan+rUcg31q6kP4J4z8rGVJUNgnkLOnSqLyCmOK/FfSA5tiiFnEZSw==
X-Received: by 2002:a17:906:7310:b0:9be:e153:3b82 with SMTP id di16-20020a170906731000b009bee1533b82mr8576531ejc.17.1698701514399;
        Mon, 30 Oct 2023 14:31:54 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id gs23-20020a170906f19700b00992f2befcbcsm6573839ejb.180.2023.10.30.14.31.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 14:31:53 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-9c773ac9b15so743828066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:31:53 -0700 (PDT)
X-Received: by 2002:a17:907:7ba1:b0:9b7:37de:601a with SMTP id
 ne33-20020a1709077ba100b009b737de601amr9630560ejc.49.1698701513400; Mon, 30
 Oct 2023 14:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <34E014FF-351E-4977-B694-060A5DADD35A@oracle.com>
In-Reply-To: <34E014FF-351E-4977-B694-060A5DADD35A@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Oct 2023 11:31:36 -1000
X-Gmail-Original-Message-ID: <CAHk-=wifhiJ-QbcwrH0RzPaKeZv93GKDQuBUth18ay=sLu5CVA@mail.gmail.com>
Message-ID: <CAHk-=wifhiJ-QbcwrH0RzPaKeZv93GKDQuBUth18ay=sLu5CVA@mail.gmail.com>
Subject: Re: [GIT PULL] nfsd changes for v6.7 (early)
To:     Chuck Lever III <chuck.lever@oracle.com>, NeilBrown <neilb@suse.de>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 at 04:24, Chuck Lever III <chuck.lever@oracle.com> wrote:
>
> This release completes the SunRPC thread scheduler work that was
> begun in v6.6. The scheduler can now find an svc thread to wake in
> constant time and without a list walk. Thanks again to Neil Brown
> for this overhaul.

Btw, the "help" text for the new Kconfig option that this introduces
is just ridiculously bad.

I react to these things, because I keep telling people that our
Kconfig is one of the nastier parts to people just building and
testing their own kernels. Yes, you can start with whatever distro
default config, and build your own, and install it, but when people
then introduce new options and ask insane and unhelpful questions,
that scares off any sane person.

So Kconfig questions really need to make sense, and they need to have
help messages that are useful..

Honestly, that LWQ_TEST option probably fails both cases.  The
"testing" is a toy, and the Kconfig option is horrific. I literally
think that we would be better off removing that code. Any bug found by
that testv would be so fundamental as to not be worth testing for.

                 Linus
