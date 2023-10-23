Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BDE7D3070
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 12:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjJWK6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 06:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjJWK6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 06:58:01 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F3CD79
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 03:57:57 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d9cb74cf53fso2784996276.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 03:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1698058676; x=1698663476; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NBVZHUuJrpDevxnw+p7Zz/Es9ubblbv4Z4MH6e534qM=;
        b=JYitacZBUi2Z9Gmk/Al0XfXiAvYYRLpKK34oSkgZhPk0no9M/xOOkLeVe1cFRs32zl
         /Yb9LDYUfv7AKd5t5QyMuEgxjvZ5wiejZyQwvjexoIu7Ojpkp6kzobm3tvF4lLSL7oxo
         ZmGP+B4hSMPJoh/yG+PBPLhw/8DCv2mbSqDi6g/szAp/TYYgEw50kAyQRVkeyn4jEsFs
         mE319mluPIcn5d961I9x+AWgdUkAyAA6rRr5buA5GGmnuZZGXt9NS+RwCpZj2j7nkW7I
         KyHt9qD5Ant1xV+41/HRofRMUvjIcmmDXQ62/Lh7qX2DPGkW6mL0R4FRYUjm6HKFrpjR
         Qybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698058676; x=1698663476;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NBVZHUuJrpDevxnw+p7Zz/Es9ubblbv4Z4MH6e534qM=;
        b=TatW/0ZYF7KkwDcm2a+u+ySpvUWApijHl5G6R/HpbcgT+1+JwkXOt60jLMrgXoOk4e
         rSJy1ZkAYwkl5aha0AsE3vx8C6siJ4wwSNRFU25v7YX1Fe556OY6drPT+KB4wUHC8SN9
         hiI8KroPim6otSq6Ogb+1Hjzz+mRUFRX1HhQHuFFiuxLnRF1KM1nnRym0zWybeWWvpKe
         ImtB/pEB393Gg2CS9HA5SB+2ld9rMNqCMRvg4C6yMtir3a5wOYe07hlrHoqbZW2qcocG
         734sD/I1YupRNr/9CRIxA2jF0r/+zlBR90Ac8o9vuC1Qe0x0qnFx16QQk6IOsKBk5CDX
         uIrw==
X-Gm-Message-State: AOJu0YyqnWut/bx4hPRWxV6UdszVa86TvjbUa29miMaD72PeRjNUuzZ9
        tATBj+JajPY+/CVi9K3c9aB8huztHdom/ZHHmCnYOG17m+kut6+l52Y=
X-Google-Smtp-Source: AGHT+IEA0mIfBUX90i7eWbXQ+g95+jr7ewXHBzIyIfnVUxr8Oxgpbeb2bylTylNReZIDaunfL5i6i7kz5iyvDY391QE=
X-Received: by 2002:a25:8290:0:b0:d9b:fd8a:871c with SMTP id
 r16-20020a258290000000b00d9bfd8a871cmr8096578ybk.16.1698058676397; Mon, 23
 Oct 2023 03:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231023085929.1445594-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20231023085929.1445594-1-dario.binacchi@amarulasolutions.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Mon, 23 Oct 2023 11:57:40 +0100
Message-ID: <CAPY8ntC8UJCQB8KOvrA7-gJaDqbRPcmzu3Vg3bpT+yuMQkAH2g@mail.gmail.com>
Subject: Re: [PATCH] drm/vc4: fix typo
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, Emma Anholt <emma@anholt.net>,
        Maxime Ripard <mripard@kernel.org>,
        Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dario

Thanks for the patch.

On Mon, 23 Oct 2023 at 09:59, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> Replace 'pack' with 'back'.
>
> Fixes: c8b75bca92cb ("drm/vc4: Add KMS support for Raspberry Pi.")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>
>  drivers/gpu/drm/vc4/vc4_regs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_regs.h b/drivers/gpu/drm/vc4/vc4_regs.h
> index f3763bd600f6..8ac9515554f8 100644
> --- a/drivers/gpu/drm/vc4/vc4_regs.h
> +++ b/drivers/gpu/drm/vc4/vc4_regs.h
> @@ -588,7 +588,7 @@ enum {
>  # define VC4_HDMI_HORZA_HAP_MASK               VC4_MASK(12, 0)
>  # define VC4_HDMI_HORZA_HAP_SHIFT              0
>
> -/* Horizontal pack porch (htotal - hsync_end). */
> +/* Horizontal back porch (htotal - hsync_end). */
>  # define VC4_HDMI_HORZB_HBP_MASK               VC4_MASK(29, 20)
>  # define VC4_HDMI_HORZB_HBP_SHIFT              20
>  /* Horizontal sync pulse (hsync_end - hsync_start). */
> --
> 2.42.0
>
