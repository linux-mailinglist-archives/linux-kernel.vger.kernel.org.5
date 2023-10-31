Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9046D7DD4CC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346728AbjJaRlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjJaRlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:41:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23E191;
        Tue, 31 Oct 2023 10:41:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D83FC433C8;
        Tue, 31 Oct 2023 17:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698774081;
        bh=ssuQm0R2sElCSkmTjKzhKnpfhPhADluOjpo7m1Q17rM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NPRbgPlPW0bjnbahwvLJpJ0yNfo7rlVHw6LO/isS40GTTWwZjwSHurQJBJIh6jsjP
         yIdZKmpC5Q/9aKfwyEec7sanXqaDbFPMHTUagPaPytKk1E8IHg3oAFmap21xor51ni
         m74NaAehiurGiZoTrIK7VRjMcF6r6s+as2eJaxxYu5+S/bbzyZuu2NIZTSrHlNjg9i
         /+n+4ALW8qaBQaVdqTbwEc2VV7X/JkC74NUZzy35aTQq441gFmAlEJemt+NVq7U7sr
         C8zTAcxOuzESt/CyJq9QWowEe61XdGD1BTrxa5AyMBNWXiDwHOAmoOZgiz3sMStFnY
         ctCOdZxBcgtGg==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1efb9571b13so1862474fac.2;
        Tue, 31 Oct 2023 10:41:21 -0700 (PDT)
X-Gm-Message-State: AOJu0YzYAzv/o2xklIyYnKFp/caOzquodeo3W4B0Pfb/FjoozjaZbp5x
        W7Z2EvKaiubg9FxFRa7zOhen5utVagj/gD4N61c=
X-Google-Smtp-Source: AGHT+IFmS+N0ctuBvsdT7gLgmS2l3kzeA60TxuS9HsF+EJh0w9eI8AAhHcW2asgNfz1Pj7SdOJrQSDQ18dcRxgKv8vM=
X-Received: by 2002:a05:6870:658a:b0:1e9:960f:894b with SMTP id
 fp10-20020a056870658a00b001e9960f894bmr18249736oab.46.1698774080675; Tue, 31
 Oct 2023 10:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231020161217.255765-1-ak@linux.intel.com> <CAK7LNAR4Z3O+qZwhc6w7MGEbJsd6B8QZtz1p4_F7OO3jK+aigA@mail.gmail.com>
 <ZTWvBN71k3QSxZqB@tassilo>
In-Reply-To: <ZTWvBN71k3QSxZqB@tassilo>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 1 Nov 2023 02:40:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNASstN=r7ZjEu5p8Au0Au8RqCNgDL8_fCzK1JknTaW=bFw@mail.gmail.com>
Message-ID: <CAK7LNASstN=r7ZjEu5p8Au0Au8RqCNgDL8_fCzK1JknTaW=bFw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Add inline-account tool
To:     Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 8:23=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> > How to use this tool?
> >
> > I did not get any output?
>
> Hmm, perhaps you need CONFIG_DEBUG_INFO=3Dy ?


Please print a hint suggesting CONFIG_DEBUG_INFO
if "objdump --source" does not output the
source-mixed disassembly.


>
> > I do not think this patch is mature enough
> > regarding the coding style.
> >
> > Please polish the code.
>
> Don't follow. It's standard python code style, and the
> other python scripts in scripts/ use the same.


I hoped somebody would have provided some code reviews,
but it looks like it did not get people's interest.


See other scripts and check how the code is structured in functions.

I do not want to see a patch like
94a03e1d22e8dc75ddec159b2efadd4c6354503a

So, the script should be written in good quality
from day 1.


Also, PEP-8 is worth reading to learn good coding style
if you have not checked.




--
Best Regards
Masahiro Yamada
