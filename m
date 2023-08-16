Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFCC77E576
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344287AbjHPPns convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Aug 2023 11:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344411AbjHPPnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:43:43 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B2E272D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:43:23 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-56cc3453e31so4773722eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692200578; x=1692805378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jS0Ir3BurK0CGHkxbuP8affn5Kxq0PiiVgp+Xnqctvs=;
        b=NcXYMK5t0A2/09uizkIjmxb0IrCjXWq1RHTNzk6TRoViNfiv5Vcyjk//pY2x+6DZUx
         0pk9rk/GE6sAUaGWzmAcDRGTfzj37vYugT8GLwum4JByfZLUFatgxq723g/J8544MV34
         5+n3aENIsRscLmHKa0JGNZPpsWrjWGTR9nvP0bzglSHezLKQX+vHVovF5OfVlOb59Onh
         KBpNQ6R1LqKq8og1pI7taQvnuzcSTj2iVpcXysZXn1UUaGMMAGo3KPtTcDTXw+HvHc6W
         z/BpgpN25K/KfMCL55Cz6NzTw0h5BDK87XgUJfIvuUcpASoFah3UFr3IuYSyCqHvH4e6
         kSsw==
X-Gm-Message-State: AOJu0Yw4pVw4SCF1RuRa61ak7OxAfX/ePrw8P5CUyVWDojFRtKlXFVNK
        Jjx6ughAa70Ila9SF3HJPaV4lIyE6/PadQ==
X-Google-Smtp-Source: AGHT+IF6KeppAtrot8zJBsPAKpytFSPOwdwNRuEgIlCuxzPjrzlFV6ERDcH1L1IS6evEFDQI4p4c7g==
X-Received: by 2002:a05:6870:64a2:b0:1b0:73e0:97eb with SMTP id cz34-20020a05687064a200b001b073e097ebmr2604923oab.30.1692200578162;
        Wed, 16 Aug 2023 08:42:58 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id db4-20020a05690c0dc400b005844ae2bfa3sm4063489ywb.95.2023.08.16.08.42.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 08:42:57 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-d656d5e8265so5963202276.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:42:57 -0700 (PDT)
X-Received: by 2002:a25:b292:0:b0:d72:a54d:4b7 with SMTP id
 k18-20020a25b292000000b00d72a54d04b7mr561479ybj.1.1692200577772; Wed, 16 Aug
 2023 08:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230809211057.60514-1-arnd@kernel.org> <20230809211057.60514-2-arnd@kernel.org>
In-Reply-To: <20230809211057.60514-2-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Aug 2023 17:42:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUbVugY9rz1ZBLri154k7Sna59tHx_5O1V1wfXDwQzKSw@mail.gmail.com>
Message-ID: <CAMuHMdUbVugY9rz1ZBLri154k7Sna59tHx_5O1V1wfXDwQzKSw@mail.gmail.com>
Subject: Re: [PATCH 2/2] m68k: add memcmp() declarartion
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, Aug 9, 2023 at 11:11 PM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> There is a global definition of memcmp() that gets built on m68k but is never
> used and causes a warning because of the missing prototype:
>
> lib/string.c:671:15: error: no previous prototype for 'memcmp' [-Werror=missing-prototypes]
>
> Add the corresponding declaration to avoid the warning. As far as I understand
> the #define to redirect memcmp() to __builtin_memcmp() does not actually do anything
> here since this is what it does anyway.

I believe it does with -ffreestanding?
So if you don't mind, I'd like to apply this with that sentence removed.

x86 also still has that define in string_32.h.
Andi dropped it for amd64 in commit 6edfba1b33c70110
("[PATCH] x86_64: Don't define string functions to builtin")
in v2.6.17.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v6.6 branch, with the obvious typo fixed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
