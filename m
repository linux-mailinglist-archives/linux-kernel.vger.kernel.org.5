Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67146757F77
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbjGRO3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbjGRO3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:29:39 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C1B198D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:29:36 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-bc379e4c1cbso6111126276.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689690576; x=1690295376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bryOwiknWUwevUDRi31Hq1FKRURS8yHR/1muX0AXWyg=;
        b=gdgjSmK5j29S70GlL+c8ZQouFA8dEbeqlcpRKOx8mL1lIJBRamXv+LKgwiDywV8quf
         iIy/LrUwLgTBsRUnfUOEDAZJLBlrrOPW0BUift1PCkKQdaEEzhs7Y5naPs+oNIDYDSuq
         kyC1Y54Tb5Hf6Lu9dHGYTUApB5/bKHOcAu269nImuhrAUgRD4xBa+f34CPpdZFC3RkLO
         gPU/quayPb+vxcxwhQv0YzGUjIUmFhvOSfnowOs1qJpqH3l9AnDeZecjG0kA20v63vQJ
         RG+vopVgTAdOYjB/cNxhkJcWEMJWxjizVOTOKuLlqTAPqcy1+VyCoQoIwd8/tb+bn88L
         RvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689690576; x=1690295376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bryOwiknWUwevUDRi31Hq1FKRURS8yHR/1muX0AXWyg=;
        b=XP/JymN3NvF7DpuDq8cUrj0cpN5p0vWy4m3Q8BbzUyffPcWF+5HJUSwZHwTbxBcCYv
         4qr5UNuTGPHnvU3ChJqwpKMayqW/8KYGh0SKvqI4BNRrLrIXwgyRoNA5jTaqnWrFuaHr
         LP07dk016RKdHQiBp8GCrdMYe2hXFyzokq2n5+Ls4S6F76qY/4NobutSlvXu/a7F50bp
         0ZvAEjMpZXhjRDoG/tlMQYmq8jq4dcVpVLiXICk9bZg4O/nxH2nkaD69KiiE/OjAARc5
         fGk5q2V69oyxa1sH+in8w0RgFNfn3/I66i+n5f46924bMB0NggV2j/Fbd3KJB5cJlrNH
         nJBA==
X-Gm-Message-State: ABy/qLYqV6YiWGXXYLR2zF8ENkG539r4aqHaqC6kysysFNxyiLrXt1+Z
        cQxZtRvcBFSheaknKmtUVJ3cxuoANBtXGJ4Ky9hH5A==
X-Google-Smtp-Source: APBJJlHjApAsPpZDTVZJiTmpFY3wlhCJ5+3CoO0/LyGtCKZ7eR1ZMW5//Lib0UubQbiQxgUN/vmR1pU9nAGU+sPEQkQ=
X-Received: by 2002:a25:ad1e:0:b0:c11:d5a9:d260 with SMTP id
 y30-20020a25ad1e000000b00c11d5a9d260mr17616ybi.49.1689690575780; Tue, 18 Jul
 2023 07:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230717223049.327865981@linutronix.de>
In-Reply-To: <20230717223049.327865981@linutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Jul 2023 16:29:23 +0200
Message-ID: <CACRpkda2T2gxfjmHYqMNk-De7phRzeMFvenH84XJMK7BXbdv0Q@mail.gmail.com>
Subject: Re: [patch 00/58] x86/apic: Decrapification and static calls
To:     Thomas Gleixner <tglx@linutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 1:14=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:

> This builds and boots on 32bit and 64bit, but obviously needs a larger te=
st
> base especially on those old 32bit systems which are just museum pieces.

These things are indeed museum pieces if you think servers, desktops
and laptops. They will at max be glorified terminals.

What we noticed on ARM32 is that it used for:
1. Running 32-bit kernels as guests in virtual machines (I don't know if
  x86 has this problem, sorry I'm ignorant there)
2. Embedded systems with very long support cycles

For x86 there is PC104, I think William Breathitt Gray knows more about
those, scope and usage etc. The typical usecase is industrial embedded
(I've seen quite a few e.g biochemical lab equipment set-ups) which are
running on a "it works don't fix it"-basis but they are network connected
so they may need new kernels for security reasons, or to fix bugs.
https://en.wikipedia.org/wiki/PC/104

These things have lifecycles that easily outspans any server, desktop or
laptop. 30+ years easily. They are just sitting there, making whatever
blood cleaning agent or medical.

I think the automation people have mostly switched over to using
ARM things such as RaspberryXYZ for new plants, but there is some
poor guy with the job of keeping all the PC104 plants running on recent
kernels for the next 20 years or so.

Yours,
Linus Walleij
