Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0376A7B835E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243125AbjJDPQk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Oct 2023 11:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbjJDPQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:16:34 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6D893
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:16:31 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5a22eaafd72so27408267b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 08:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696432590; x=1697037390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7G20iG4+lwdklDLeClOvf8KvH9MnEYm7S2jmZ9HxqQ=;
        b=Sl7bCAN6yss+XhcjxgTsbmrfG/52P2TlwX9D9gWxNELGvJ55DphduGSLKZU50PcJqa
         s7VdN+cqIuE1NUI5eLDnjOMyZyseHuucJEueDNT6yOQpmlUabM6jw2CbeBfB6dNVg3z4
         oPFLztM+N8PQPtza9PZ30XWL4aGl8XiZoKtFT7Zc06lfBRQ5shDIkJPDY3HoGW8QhBUu
         IHzaJ0Qx+jdJYd2YZ2wWxzjTysa9m3inTJCJBoR9qC0+BPVgnfI85FSJ2fSSmAfbxAfA
         ZmaAfllJZ/953uYbuBj06j5kxzkpMt4FL+sG2+0TH+p/1i1f1s4808CH9ZCKwoSMV7M6
         4n7A==
X-Gm-Message-State: AOJu0YzPPPipiEJrM1fZisoUS/v9eUZEgpY+aJ7u8lzqnoFAu/PxOGRh
        QkWCKOUk3nGuLDwjffXV2+mBeTCbk5rNqQ==
X-Google-Smtp-Source: AGHT+IEHTU9z5CN3wrZaIha3wx0MJ1oDSvn5hekAd1d2bMGwILWkyALxuZ0ivWMIertxQKN+0nIIfw==
X-Received: by 2002:a0d:ca4a:0:b0:58d:70b4:233a with SMTP id m71-20020a0dca4a000000b0058d70b4233amr2841610ywd.37.1696432589132;
        Wed, 04 Oct 2023 08:16:29 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id j13-20020a81920d000000b0059f61be458esm1198271ywg.82.2023.10.04.08.16.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 08:16:29 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5a22eaafd72so27407947b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 08:16:28 -0700 (PDT)
X-Received: by 2002:a81:4ed1:0:b0:58f:c452:74da with SMTP id
 c200-20020a814ed1000000b0058fc45274damr2777522ywb.42.1696432588431; Wed, 04
 Oct 2023 08:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <5971770.lOV4Wx5bFT@eto.sf-tec.de>
In-Reply-To: <5971770.lOV4Wx5bFT@eto.sf-tec.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Oct 2023 17:16:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUP_GqT49hMWxz=oSOc8S5PcpYPuvAAOdae4rd1zWV6Ow@mail.gmail.com>
Message-ID: <CAMuHMdUP_GqT49hMWxz=oSOc8S5PcpYPuvAAOdae4rd1zWV6Ow@mail.gmail.com>
Subject: Re: [PATCH] m68k: add missing types to asm/irq.h
To:     Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc:     Simon Horman <horms@kernel.org>, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rolf,

Thanks for your patch!

On Sun, Sep 17, 2023 at 11:18 AM Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> As reported in f8b648bf6628 ("net: sunhme: move asm includes to below linux
> includes") when including this <asm/*> header before the needed <linux/*>
> headers the compilation will fail because of missing types.

    arch/m68k/include/asm/irq.h:66:20: warning: ‘struct pt_regs’
declared inside parameter list will not be visible outside of this
definition or declaration
       66 |             struct pt_regs *));
          |                    ^~~~~~~
    arch/m68k/include/asm/irq.h:78:11: error: expected ‘;’ before ‘void’
       78 | asmlinkage void do_IRQ(int irq, struct pt_regs *regs);
          |           ^~~~~
          |           ;
    arch/m68k/include/asm/irq.h:78:40: warning: ‘struct pt_regs’
declared inside parameter list will not be visible outside of this
definition or declaration
       78 | asmlinkage void do_IRQ(int irq, struct pt_regs *regs);
          |                                        ^~~~~~~
    arch/m68k/include/asm/irq.h:79:8: error: unknown type name ‘atomic_t’
       79 | extern atomic_t irq_err_count;
          |        ^~~~~~~~

> Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

> --- a/arch/m68k/include/asm/irq.h
> +++ b/arch/m68k/include/asm/irq.h
> @@ -2,6 +2,8 @@
>  #ifndef _M68K_IRQ_H_
>  #define _M68K_IRQ_H_
>
> +#include <linux/types.h>

When just including this file, that still leads to:

    arch/m68k/include/asm/irq.h:82:11: error: expected ‘;’ before ‘void’
       82 | asmlinkage void do_IRQ(int irq, struct pt_regs *regs);
          |           ^~~~~
          |           ;

Instead, you want:

    #include <linux/atomic.h>
    #include <linux/linkage.h>

> +
>  /*
>   * This should be the same as the max(NUM_X_SOURCES) for all the
>   * different m68k hosts compiled into the kernel.
> @@ -59,6 +61,7 @@
>  struct irq_data;
>  struct irq_chip;
>  struct irq_desc;
> +struct pt_regs;

OK

>  extern unsigned int m68k_irq_startup(struct irq_data *data);
>  extern unsigned int m68k_irq_startup_irq(unsigned int irq);
>  extern void m68k_irq_shutdown(struct irq_data *data);

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v6.7 branch, with the above fixed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
