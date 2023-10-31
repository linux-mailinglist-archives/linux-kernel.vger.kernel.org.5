Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83747DC36D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbjJaALU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 20:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235702AbjJaALQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 20:11:16 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CC6CC
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 17:11:11 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c594196344so74696961fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 17:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698711069; x=1699315869; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kv2EXT4ffTjJGbqlDnc3GAWzM7rrWWafWmD8tR8LJX4=;
        b=cjHPFLlpziVLY91TU3StKPiCs/SYswbUO6hfksVHC21JjFXNt87pcd9ZK2GYo3lVIs
         Qv/DuzMct2vcQEX/X70Aa0CzD+iPpV19LBRD4Q8ildEDRXxsgMm0i2rmmwGXP+TbJqjE
         vkTGHwW2bFrypZkKc+tpogjHwT/q5KLsbtKE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698711069; x=1699315869;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kv2EXT4ffTjJGbqlDnc3GAWzM7rrWWafWmD8tR8LJX4=;
        b=jExLap1dFuVIi1QMFGlWbfnSlzVqBiHy2Ti3vUNCzh4XY78xxZlmLgYxu2OyE5jSu4
         gMFF3iI6zQng40FnOpQwVxq/252Tbh4kRu+bfVlgk4hLSQIJIusGsSnpejXtRtndsHzK
         0l2n5mUkFfggT8V4O/l9QSvA+YRwY3//iRJBrSesPWe4uorKGSwkgROoh+F9vRU2jAwA
         Fki2RJiBduP8L01oGiJGaqdWdCZHUahrFfbcfP2SYMp8xwsynt8I1/Rm0roTyivHICqI
         /0GJBNyVLBhztYETN3tIXS8sVqAUzwzIKIcVPCzbjpqv0t0FqAQpKllHzVS659digUMa
         NHvw==
X-Gm-Message-State: AOJu0Yzrpv0Ihwyj4Yh3KWJNyR23yD3ADEcOxf85iCuF80oaCpBia/LH
        V0+m9EIrmKCY2Pe0x9QS+TiqujLRZrn9q72EMjNPAA==
X-Google-Smtp-Source: AGHT+IGKypDKuShHfj+Ldzk56gU/m4gNlaUsxDNlw9r+sLfTq2rRxdeQuGKrcEHBS5yyOyLIsW4qAw==
X-Received: by 2002:a05:6512:2527:b0:507:a001:792e with SMTP id be39-20020a056512252700b00507a001792emr11689546lfb.46.1698711069351;
        Mon, 30 Oct 2023 17:11:09 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id w8-20020a05651234c800b0050797a14c01sm10410lfr.204.2023.10.30.17.11.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 17:11:08 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-507d1cc0538so7020625e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 17:11:08 -0700 (PDT)
X-Received: by 2002:ac2:5225:0:b0:507:b87f:c61b with SMTP id
 i5-20020ac25225000000b00507b87fc61bmr7056948lfl.66.1698711067777; Mon, 30 Oct
 2023 17:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <ZT0IY1INe8Jls7EC@gmail.com>
In-Reply-To: <ZT0IY1INe8Jls7EC@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Oct 2023 14:10:51 -1000
X-Gmail-Original-Message-ID: <CAHk-=whiZvO3r+RbX71qxPgFYm0TGWMkPkNXNHcwPrhxLq633Q@mail.gmail.com>
Message-ID: <CAHk-=whiZvO3r+RbX71qxPgFYm0TGWMkPkNXNHcwPrhxLq633Q@mail.gmail.com>
Subject: Re: [GIT PULL] x86/boot changes for v6.7
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>
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

On Sat, 28 Oct 2023 at 03:11, Ingo Molnar <mingo@kernel.org> wrote:
>
> MERGE NOTE:
>
>  - Pulling this tree will generate a conflict in
>    drivers/firmware/efi/libstub/x86-stub.c, due to a fix we wanted upstream
>    without related cleanups, which is resolved by picking this resolution:
>
>         boot_params_ptr = boot_params;

Hmm. I think I should also remove the now legacy line of

   extern struct boot_params *boot_params_pointer asm("boot_params");

from drivers/firmware/efi/libstub/x86-stub.h, no?

               Linus
