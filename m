Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF9B7742BB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbjHHRtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234792AbjHHRsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:48:50 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACBAB0A36
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:21:41 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-56433b18551so3505822a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691511671; x=1692116471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDrh8BIjjcioiUiDgVZRZWHMdXQTz7RggcR/+kw0NLg=;
        b=r06dXFMKrcuqkF1hV+2eIac5Y67EsXXIHhuBS0VH+ueZxt1Q7ZzKc2IDV3F4V7yhVd
         8ASUHmqdgpXSCAssr58CG4JPGT46mmIz42fqqvHMelBDiyPDn2VFIYkML/sT7h68XYuY
         fK9A88C7qpxoGo97DC1iShiaz4x5EWEsdsLNvobxheWUz079G1/+1JYJ7OVVJlFjvpRJ
         dSVMLjAFGnoKFhSWU8Ro6sRJhnz7+vInlG4M1hgN3QYIhFuf5jMJtRRGiwUgI4wLcJ6n
         AzF5HYiIhSAyFXGYJZ5kgNutCbbb/8IX+9MaprwlnasJ+bp13Sq1omfgo609MRmlPUnJ
         mSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511671; x=1692116471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDrh8BIjjcioiUiDgVZRZWHMdXQTz7RggcR/+kw0NLg=;
        b=ArXtdGjRfdq9eUmmd4hXEZbcdPc6E+6PLoNVnIHCURgProHwd1JjwUYhgdoUvs9DE9
         IckpqIbhFUfbC81oFCEuqN++LSWhpfNql4g5Rz/7RS5+E44TpMYNX4OgUySjPnw7KZmQ
         WjLz3af9q8dZw4vrHOyQo/wPgN6auw1KgSECpq2ogp86aW734yuXNWaQCy5rUUV/fQP/
         wNkjXmLNRwqNvpAcRh/RaGUFuH/YAYSq4iF92sRhFnuHLKPKA+JADVECiGnrx147i6dp
         Ic84AIoZcsMbI6TGlwUhf55CHQjsO5fv7+oL/WLr7E2Bb1EqAqwsTF5H6adYWl9zi3SI
         fC9A==
X-Gm-Message-State: AOJu0YyN0dxabfaFqanEHi6yg1q9gZu/Oog/qS4ky2vCwRuOJi9iYS7a
        OpvBHTElRYpNJketHy7R5KjcbHMEp8DDaQjUJp/u2Ws0QhWi4i10Bjs=
X-Google-Smtp-Source: AGHT+IGgk2Gn5ioNH0AcFXHWCRiyva9Nx2L/8mMA/ydZKbkG7fAbv8oXVgFtjI3hbchGPrQFMMIeNjTdPD0hamE70pA=
X-Received: by 2002:a25:8f84:0:b0:d3a:e626:af3a with SMTP id
 u4-20020a258f84000000b00d3ae626af3amr9952727ybl.24.1691500372554; Tue, 08 Aug
 2023 06:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230808-virt-to-phys-mips-v1-1-af6fcd45ed31@linaro.org>
In-Reply-To: <20230808-virt-to-phys-mips-v1-1-af6fcd45ed31@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Aug 2023 15:12:40 +0200
Message-ID: <CACRpkdYisteBTk9DOeCZiCeH5hJW87O-m+zsWAU7uwg7ud=ZYw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Drop virt_to_phys define to self
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 11:29=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:

> The function virt_to_phys was defined to virt_to_phys and then
> implemented right below.
>
> I can't understand why, just drop it and let the actual function
> slot in.
>
> Fixes: dfad83cb7193 ("MIPS: Add support for CONFIG_DEBUG_VIRTUAL")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/mips/include/asm/io.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> index affd21e9c20b..18ed44843541 100644
> --- a/arch/mips/include/asm/io.h
> +++ b/arch/mips/include/asm/io.h
> @@ -111,7 +111,6 @@ extern phys_addr_t __virt_to_phys(volatile const void=
 *x);
>  #define __virt_to_phys(x)      __virt_to_phys_nodebug(x)
>  #endif
>
> -#define virt_to_phys virt_to_phys
>  static inline phys_addr_t virt_to_phys(const volatile void *x)
>  {
>         return __virt_to_phys(x);

Just have to CC Arnd on this because I never feel I understand this
properly.

Normally you would do this so as to override the default virt_to_phys()
from include/asm-generic/io.h, but we do not seem to be using it here?

Further right below we are implementing phys_to_virt() with no
corresponding define, so in any case this needs to go or that one
needs a define.

That said they seem like a good candidate to replace with the
generic variant because the content is the same sans some debug
hacks that I doubt are still needed.

Yours,
Linus Walleij
