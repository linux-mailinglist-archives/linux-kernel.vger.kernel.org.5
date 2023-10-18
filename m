Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16237CDDEC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344783AbjJRNxh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 18 Oct 2023 09:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344782AbjJRNxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:53:35 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6E095;
        Wed, 18 Oct 2023 06:53:34 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-d9a398f411fso7765504276.3;
        Wed, 18 Oct 2023 06:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697637213; x=1698242013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDpjjdShjqITiNCQrSVmXLGjWP750vEbHAu62sP/538=;
        b=SwqArA01wiEYxfXGaB31wHqQw9jmrznCnIGCP06VWEyJQ7jO1DznAUzvOJAvWHEu8O
         3jJV5itCY7sEpMdNa+q8wOZ+Oc2sc3A/h16Z6Kw9pqP3zWvct5po1nVUNP0J0EkkxvOe
         O7Jx5YD70GiEA+qK39uEr1FEotpTUG7JywO+r0ctEE5IYnCjSu5ovbOogH0KC9oyCUdV
         7YynolYu9NfI21eb9zflodX8H9USnwUSBFZFku6eOB2aTASfpwGB6c+RthIUrvj3Fgnt
         96ywnwUm6MpY7swL4o/Diz6Q3RV9eKshMKAN+AjWIdv+9fU/f/fItXWG/Fqj7UM2kknJ
         i7Ug==
X-Gm-Message-State: AOJu0YxjLLkNq/qYLr79VOdP7D6+7v34ZyXs4C8Q6r9ZIRtn+5bnN4c2
        hzJoa+jQb58WzHhtqRqetqyMvHbb30W6bA==
X-Google-Smtp-Source: AGHT+IFZlOBIdbgBC3CLFzpg+EfQImir1AyZSm5XQ5WT+uVzl74PTWmsUDM+kx2PahPoPbhcwkUaCw==
X-Received: by 2002:a25:8145:0:b0:d9a:5475:6aac with SMTP id j5-20020a258145000000b00d9a54756aacmr5280076ybm.48.1697637213269;
        Wed, 18 Oct 2023 06:53:33 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id x16-20020a25ce10000000b00d9a36ded1besm1318895ybe.6.2023.10.18.06.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 06:53:32 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5a7c7262d5eso86180347b3.1;
        Wed, 18 Oct 2023 06:53:32 -0700 (PDT)
X-Received: by 2002:a05:690c:10c:b0:5a7:afc9:3579 with SMTP id
 bd12-20020a05690c010c00b005a7afc93579mr6112881ywb.18.1697637212500; Wed, 18
 Oct 2023 06:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230709123329.33674-1-denghuilong@cdjrlc.com> <7554aadc5afb915ee1065cea56053cb6@208suo.com>
In-Reply-To: <7554aadc5afb915ee1065cea56053cb6@208suo.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 Oct 2023 15:53:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWLxc7Tu2FNMRiO_LMjM2VSdtmHAiMeWv-+NgxA9+fqeQ@mail.gmail.com>
Message-ID: <CAMuHMdWLxc7Tu2FNMRiO_LMjM2VSdtmHAiMeWv-+NgxA9+fqeQ@mail.gmail.com>
Subject: Re: [PATCH] sh: heartbeat: prefer 'unsigned int' to bare use of 'unsigned'
To:     xuanzhenggang001@208suo.com
Cc:     ysato@users.sourceforge.jp, dalias@libc.org,
        glaubitz@physik.fu-berlin.de, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sun, Jul 9, 2023 at 2:39 PM <xuanzhenggang001@208suo.com> wrote:
> Fix the following warnings reported by checkpatch:
>
> arch/sh/drivers/heartbeat.c:33: WARNING: Prefer 'unsigned int' to bare
> use of 'unsigned'
> arch/sh/drivers/heartbeat.c:62: WARNING: Prefer 'unsigned int' to bare
> use of 'unsigned'
>
> Signed-off-by: Zhenggang Xuan <xuanzhenggang001@208suo.com>
> ---
>   arch/sh/drivers/heartbeat.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/sh/drivers/heartbeat.c b/arch/sh/drivers/heartbeat.c
> index 24391b444b28..07f04ed0d517 100644
> --- a/arch/sh/drivers/heartbeat.c
> +++ b/arch/sh/drivers/heartbeat.c
> @@ -30,7 +30,7 @@
>   static unsigned char default_bit_pos[] = { 0, 1, 2, 3, 4, 5, 6, 7 };
>
>   static inline void heartbeat_toggle_bit(struct heartbeat_data *hd,
> -                    unsigned bit, unsigned int inverted)
> +                    unsigned int bit, unsigned int inverted)
>   {
>       unsigned int new;
>
> @@ -59,7 +59,7 @@ static inline void heartbeat_toggle_bit(struct
> heartbeat_data *hd,

patch: **** malformed patch at line 19: heartbeat_data *hd,

Please fix your email setup.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
