Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE827682B2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 01:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjG2XTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 19:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjG2XTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 19:19:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EAD2D4C;
        Sat, 29 Jul 2023 16:19:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A069E609D1;
        Sat, 29 Jul 2023 23:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBCCC433C9;
        Sat, 29 Jul 2023 23:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690672744;
        bh=+rMEdyCZNWm93y1bOksh/e0ThIqHthTq6uyet0NnSWo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bENE52AcIFFt6r1rH/YAt8vAiKcjnbjGmF9jhDnMOpW3H172O8cpSXLElzvHdzlPA
         JeSsVntqQLpbH1s4coAXmxUUajZp4yVLsAthvEOQdYYssTJvscrHx3GAA7NRCndwye
         55t8eutwge5ukuWAcgIFjr1Fm0lMmrBw7tAVDGqFGbj/JN7mXe3+HOQ6mVNJ1rzeGY
         poPClKu9rFVIugw8f5LKBE5BrMG1/HADi/gdzSlmfyXY5laMGejsqxvLzuRgUC3T5/
         F7OTa+LBt2xyLLXUk3v3zN+NiHPe2eUwb1/X9uA9eeCm9rh2HZtbV0GduVfNLWYUZt
         Ai5JNtaZIpQnA==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-99bf91956cdso145491166b.3;
        Sat, 29 Jul 2023 16:19:03 -0700 (PDT)
X-Gm-Message-State: ABy/qLY0V+NNIha4aLqlt1aSVzNZl5pO21MxzR0nalh1i6zhZ1tGYIYl
        8dZDsOAfmgiQpB+xn2iB7squRgHW6SfEfWlB90A=
X-Google-Smtp-Source: APBJJlHKIjB8b415XdpEKxfDcXxvXqq4F6Rl2bQGhjsd5fEwxOTtsoeC1IK7TtQbj1XWOtJL8QdxqvvtGr5YYPIEQNE=
X-Received: by 2002:a17:906:7a58:b0:99b:5ba6:f2cf with SMTP id
 i24-20020a1709067a5800b0099b5ba6f2cfmr2772537ejo.26.1690672742279; Sat, 29
 Jul 2023 16:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230726145740.1765323-1-arnd@kernel.org> <CAJF2gTTC0BTOyWH4Zod1oRQaUpS9dE-6=otfpGOPcCcffrHohQ@mail.gmail.com>
 <ef413a40-ddc4-4d23-bc56-23b7095ffc83@app.fastmail.com>
In-Reply-To: <ef413a40-ddc4-4d23-bc56-23b7095ffc83@app.fastmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 29 Jul 2023 19:18:50 -0400
X-Gmail-Original-Message-ID: <CAJF2gTR+sMYLgids6zKE=qAvoaibxU8m4eNNF9O8M+fj6Nsv6g@mail.gmail.com>
Message-ID: <CAJF2gTR+sMYLgids6zKE=qAvoaibxU8m4eNNF9O8M+fj6Nsv6g@mail.gmail.com>
Subject: Re: [PATCH] csky: fix old style declaration in module.c
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 3:06=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Sat, Jul 29, 2023, at 06:59, Guo Ren wrote:
> > Thx Arnd,
> >
> > Reviewed-by: Guo Ren <guoren@kernel.org>
> >
> > You could directly put it in your next tree. If you need me to do
> > that, please don't hesitate to let me know.
>
> I don't currently plan to send a pull request for the warning
> fixes, please just merge it through your own tree for 6.5 or
> 6.6.
>
> I'd like to enable a few warning options (-Wextra, -Wrestrict,
> -Wmissing-prototypes, ...) in the Kbuild for 6.6, but the Makefile
> changes will probably go through the Kbuild tree or linux-mm,
> and the fixes for existing warnings can just take their normal way.
Okay, I would put it in my tree.

>
>      Arnd



--=20
Best Regards
 Guo Ren
