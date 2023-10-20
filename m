Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2568D7D0E20
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376995AbjJTLHy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 Oct 2023 07:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376745AbjJTLHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:07:53 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C84114;
        Fri, 20 Oct 2023 04:07:50 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5a7eef0b931so7507947b3.0;
        Fri, 20 Oct 2023 04:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697800070; x=1698404870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0tXFYyVXNiSpns+Mi0YzAxeIB5UtoY4Qzk6NSDbAd4=;
        b=kzNu9acOSzq0sJfdrkPgJlcLBJfz2F4+MftYhBeF0AojnncWE2sxBbvu+lUmqjoFWL
         VtGU1MMwQnf3PYJAGVIQAHJPx31WaF/649M4htfGCpREUKtn6i093cNPyNoUcrQDAoLF
         fqbhnHXGGwXKGW7vXMG4KEvAc4D3CYy/uIgaZhLvXx6x+X1mwG3n3Rdiw6ZeCanAdJKQ
         E4BTnLG8WBbfUvwrJpzVa30WJYNLi20JSHRaN+ANbDJNoh/G975mBWcX93QlSMb3aH9C
         qHRUGOFeG8qpNMGDhHWGE0VKQVtGkA8bQUNSOtq4K9pWOQtfwb38RS1h5uW55Wqj3X3b
         trZA==
X-Gm-Message-State: AOJu0YzqQQEUGoyNHFP34/2vA6hSDHtbVi1jSNh7do4KdusoioIsTvVJ
        HAasJRDubS57fJ/It/ltL85xdIYbs4Rukw==
X-Google-Smtp-Source: AGHT+IGIZEg1HuLGLlr2eGSX9BYh/8ZCnhY8T8FXaP/IEPn0CJakK4NQT8xAMUW+w61S5kNg18ca9g==
X-Received: by 2002:a05:690c:ed0:b0:599:da80:e1e4 with SMTP id cs16-20020a05690c0ed000b00599da80e1e4mr1965841ywb.30.1697800069822;
        Fri, 20 Oct 2023 04:07:49 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id z63-20020a0dd742000000b0059be6a5fcffsm599715ywd.44.2023.10.20.04.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 04:07:48 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5a7eef0b931so7507537b3.0;
        Fri, 20 Oct 2023 04:07:47 -0700 (PDT)
X-Received: by 2002:a81:4e09:0:b0:5a7:c50e:8df with SMTP id
 c9-20020a814e09000000b005a7c50e08dfmr1699674ywb.18.1697800067486; Fri, 20 Oct
 2023 04:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231020093156.538856-1-chentao@kylinos.cn>
In-Reply-To: <20231020093156.538856-1-chentao@kylinos.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 20 Oct 2023 13:07:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUo8tEBQa6soZm=MUWLy2AnkL6Vszt7vzbs-peb20=myQ@mail.gmail.com>
Message-ID: <CAMuHMdUo8tEBQa6soZm=MUWLy2AnkL6Vszt7vzbs-peb20=myQ@mail.gmail.com>
Subject: Re: [PATCH] treewide: Spelling fix in comment
To:     Kunwu Chan <chentao@kylinos.cn>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, mokuno@sm.sony.co.jp,
        linville@tuxdriver.com, dcbw@redhat.com, jeff@garzik.org,
        netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kunwu.chan@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kunwu,

Thanks for your patch!

This is not a treewide change. Hence the oneline-summary should be
something prefixed by "[net-next] ps3_gelic"

On Fri, Oct 20, 2023 at 11:32 AM Kunwu Chan <chentao@kylinos.cn> wrote:
> reques -> request
>
> Fixes: 09dde54c6a69 ("PS3: gelic: Add wireless support for PS3")

No need for a Fixes tag for a spelling fix in a comment.

> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
> +++ b/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
> @@ -1217,7 +1217,7 @@ static int gelic_wl_set_encodeext(struct net_device *netdev,
>                 key_index = wl->current_key;
>
>         if (!enc->length && (ext->ext_flags & IW_ENCODE_EXT_SET_TX_KEY)) {
> -               /* reques to change default key index */
> +               /* request to change default key index */
>                 pr_debug("%s: request to change default key to %d\n",
>                          __func__, key_index);
>                 wl->current_key = key_index;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
