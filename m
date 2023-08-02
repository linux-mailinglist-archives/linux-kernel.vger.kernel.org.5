Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC34D76D1F9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbjHBPbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbjHBPaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:30:52 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720C730EB;
        Wed,  2 Aug 2023 08:29:35 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d0e009433c4so7353649276.2;
        Wed, 02 Aug 2023 08:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690990174; x=1691594974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjGT5MZT/KYoCShCvWCNxWhackCgYzrKJaoLfxrA8WM=;
        b=AavCHvHgpveeOS1jtZ+eY0zxkOUyhsiJ+vG3mGbV0jq54pSnMoPVZZRYZPvfh0T2U1
         vapRXvqAtoeps28Hgg30XpttrCdtI+BTDgs/wtpfpeME9etK8MTf+IRVE6dxz/RzecCy
         BFko1Cr5ACJ5KLTzFf88rczBiGlcs+lQHtSvqyKzcauZUmV5ahTx+HpfqXYEV9pWPDM1
         mbqedIY/GxdX/LdcE55u0MXO6vKeklLRBQTg3WvTgL+rXAkKt0R8fAiMaMLttZrY8Rf3
         sm/MLctwYHTjPCaGNILHihcUPcdRT5pc21gqvGogK1iFhRK4cYwc+weK+oXVEEnSLNEZ
         d3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690990174; x=1691594974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjGT5MZT/KYoCShCvWCNxWhackCgYzrKJaoLfxrA8WM=;
        b=Sy7J/X1KOMs4BaB9eBglptzbgn84D8W4kWoiGMYJcP315pO4rc/XiGhYlNhpxUVerz
         J8EjwAGnaBh1qmmustO1agOc535rZoC6H1WOnp7bZX3YjdE483GQSE5143179VT1kZye
         CozWon6+TsKJ7BQJV6aytVG9wNgUsKLwaX5hUV2mPLgdIKNsVdzN5JTpIiC2kF4kJwDX
         sWOAs05pwZJjrZsfj/mK8pzOEY1gzwwWJsibhOTuVMVizUPy9p3GW13vabPunny/stom
         8MkiR4FXMDMH5Y1YL+Ga/yDMNNnlCloPWya+0xmXoGZrHnhz0hQ2U7cZXc5yY7Fg6lJk
         cImA==
X-Gm-Message-State: ABy/qLa3BJL/hwuaM5glVLbahD2q4Nz3ZjnK1kllhHX/UAjP7pK3gAWd
        32h6eVNgmZa/jc71w2LOpPBH/ud4LXbWuZtUoJU4fDvYhIQ=
X-Google-Smtp-Source: APBJJlFuMzGv/XwV3IrY7F8nutri3KEFsZXE4bOMmdK7tUwp8EMiB+ykS3db03UhfC5+cuWcLSIJZXuXvni/5NiUuW4=
X-Received: by 2002:a25:844f:0:b0:d19:6a42:9271 with SMTP id
 r15-20020a25844f000000b00d196a429271mr15363400ybm.23.1690990174469; Wed, 02
 Aug 2023 08:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <PAXP190MB1631B7C90A99FCEBB1594AAE8B4DA@PAXP190MB1631.EURP190.PROD.OUTLOOK.COM>
 <CANiq72kf=VktsDS6ctLxVt70EGtkSwfx+Z2=qNMdyQf81pQ3dA@mail.gmail.com> <PAXP190MB16316300F2E89EC06A4E3AF78B21A@PAXP190MB1631.EURP190.PROD.OUTLOOK.COM>
In-Reply-To: <PAXP190MB16316300F2E89EC06A4E3AF78B21A@PAXP190MB1631.EURP190.PROD.OUTLOOK.COM>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 2 Aug 2023 17:29:23 +0200
Message-ID: <CANiq72kxOEt2Kb_rxY0+WD6uu=NXy+6PGMvGjTHfNFVXucgH7w@mail.gmail.com>
Subject: Re: [PATCH] lib/Kconfig.debug: fix grammar in RUST_BUILD_ASSERT_ALLOW
To:     =?UTF-8?Q?Timo_Grautst=C3=BCck?= <timo.gr@hotmail.de>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 12:05=E2=80=AFPM Timo Grautst=C3=BCck <timo.gr@hotm=
ail.de> wrote:
>
> Ahh ok, i also dont think you can call it a "bug". Is it not possible to
> simply remove the `Closes:` tag from the patch and not categorize the
> whole thing as a "bug"?

I think either way is fine. Since we have an issue in the tracker and
it is a fix, even if trivial, let's go with something like:

    Reported-by: Miguel Ojeda <ojeda@kernel.org>
    Closes: https://github.com/Rust-for-Linux/linux/issues/1006
    Fixes: <hash> ("<description>")
    Signed-off-by: <fixed real name> <timo.gr@hotmail.de>

For the formatting of the `Fixes:` tag, I recommend using the git
`--pretty=3D` config shown in
https://docs.kernel.org/process/submitting-patches.html.

Cheers,
Miguel
