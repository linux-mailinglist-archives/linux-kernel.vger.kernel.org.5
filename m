Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBFE76DFD3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 07:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjHCFok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 01:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHCFoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 01:44:37 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485B518B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 22:44:36 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so8176601fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 22:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691041474; x=1691646274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N17mOoqnnUTZabcqpIbOcfnfxpGhrgb1sPK5QFRZMDw=;
        b=O7RIG76B+fMU7Pv2WrTp/NyxkGLYBl88Uqyv0JXpI5L9k6Rdoz8x3naWa3vFteWULH
         bIKWq42wPTu3DdfS43Z/mDFLSUWxWpUc6mD2Ad1bx3Sh8uFicMmb0P+XX4AebHouQonV
         cXUhNuSJvWcgD+GkMzYYhV5gwcbQFWnSPiK38qvLBa0ytuePHSiZpQ5UgurMuWH7mjx7
         ESAB89BuN2X+JRT0hx+u7Ax86nsrDzkRqnmmMfWIpaI40OFmFK2viHkTyYxuzX5l9QSU
         2+dToZ8dmVz9INDIY827qtN3nMpl2w3LfD3a0sGbrzd/vpTx0+PaXEaUl9uAlYccLd+0
         PdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691041474; x=1691646274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N17mOoqnnUTZabcqpIbOcfnfxpGhrgb1sPK5QFRZMDw=;
        b=WoZSAfOVxX0UBjR0mpxsmPPYsmlOwRV/hipdNW6+8V/jmzuvinf0XjJgfoJJQqPdMs
         ohnecUwyx9p8h/2TDDFkTdFM5zt2xQAR2tzLw8rCUgMPSGM35D8V2PVnG7eE4idjH0M/
         Vxmez7EI/PMiyTWUbnKOwzfsBsmn0aL0B4ZFTsxCOt/wlo0L4+UW+mAyTKTumA4OdVzg
         q7vZKF007DUwWVdQtlcgtTQA+gxMSANNVT8dkiThnhQIEuacdZC/Uz/tWY+TnbWbowON
         B9cxPqEWTdUwvaLRlJagrk0lieNPKSbB785z76sIfR5/kxjYiUxDKaRs+wkNfWCV17mc
         orrQ==
X-Gm-Message-State: ABy/qLauW6SL6eMF5GvpLe9cKUtzkxNyB1BBaXiGQrxZozYQSEljhTyw
        3r0+HxQ1oMQLlxPVhyjpsaVpqBuKU7FZuwqJ1WuieF4=
X-Google-Smtp-Source: APBJJlH2u7pjnmVdCU9QFg/PWcn5KJDYDp8yO5fxMbbiEBpV+wPepTJu+at5foeDke5Sr6UlLS11XRWhQJDPSdlcTFc=
X-Received: by 2002:a2e:80d7:0:b0:2b6:d63d:cc1e with SMTP id
 r23-20020a2e80d7000000b002b6d63dcc1emr6336175ljg.51.1691041474238; Wed, 02
 Aug 2023 22:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <ec3ce891-5a9f-c0b0-1a1e-1d66bb8e3623@cs.utexas.edu> <1126dfcc-50d1-e4ed-12a3-d48e6b6a1bbe@cs.utexas.edu>
In-Reply-To: <1126dfcc-50d1-e4ed-12a3-d48e6b6a1bbe@cs.utexas.edu>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Thu, 3 Aug 2023 01:44:22 -0400
Message-ID: <CAMzpN2gqnO_yRUxGcUXVoS5Vf7nEPdUEb6B5=Ud+8Lj7MuowSQ@mail.gmail.com>
Subject: Re: x86 64-bit Entrypoint
To:     Yahya Sohail <ysohail@cs.utexas.edu>
Cc:     linux-kernel@vger.kernel.org
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

On Wed, Aug 2, 2023 at 9:50=E2=80=AFPM Yahya Sohail <ysohail@cs.utexas.edu>=
 wrote:
>
> Hi,
>
> I've read the documentation for the x86 boot protocol at
> Documentation/arch/x86/boot.rst. It states the following:
> > In 64-bit boot protocol, the kernel is started by jumping to the
> > 64-bit kernel entry point, which is the start address of loaded
> > 64-bit kernel plus 0x200.
>
> When I build a kernel and check the bytes at 0x200, they have the
> following disassembly:
> 0x00000200      eb6a           jmp 0x26c
>
> The bytes at 0x26c disassemble as follows:
> 0x0000026c      8cd8           mov eax, ds
> 0x0000026e      8ec0           mov es, eax
> 0x00000270      fc             cld
> 0x00000271      8cd2           mov edx, ss
> 0x00000273      39c2           cmp edx, eax
> 0x00000275      89e2           mov edx, esp
> 0x00000277      7416           je 0x28f
> 0x00000279      ba204df606     mov edx, 0x6f64d20
> 0x0000027e      1102           adc dword [rdx], eax
> 0x00000280      8074048b16     xor byte [rsp + rax - 0x75], 0x16
> 0x00000285      2402           and al, 2
> 0x00000287      81c200047302   add edx, 0x2730400
> 0x0000028d      31d2           xor edx, edx
> 0x0000028f      83e2fc         and edx, 0xfffffffc
> 0x00000292      7503           jne 0x297
> 0x00000294      bafcff8ed0     mov edx, 0xd08efffc
> 0x00000299      660fb7e2       movzx sp, dx
> 0x0000029d      fb             sti
> 0x0000029e      1e             invalid
>
> Notice the invalid opcode at 0x29e. In 32-bit mode 0x1e would be PUSH
> DS, but it is invalid in 64-bit mode. It appears the 64-bit entrypoint
> is invalid. Are the docs out of date?
>
> Thanks,
> Yahya Sohail

The code you are looking at is from arch/x86/boot/header.S, which is
the 16-bit legacy BIOS entry.  The 64-bit entry point the boot docs
are referring to is in arch/x86/boot/compressed/head_64.S.  The 0x200
offset is relative to the start of the protected mode setup code,
which is appended to the setup header and legacy BIOS code to form the
bzImage.

Brian Gerst
