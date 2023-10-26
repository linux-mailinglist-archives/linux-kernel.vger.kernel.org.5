Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899D57D83D5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345100AbjJZNsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjJZNsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:48:24 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0F8BD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:48:22 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d9caf5cc948so686954276.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698328101; x=1698932901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1S/Bb/tPpH94M8WXhMx2lGTSS2CQLvVdb8TajQ5C6MI=;
        b=DSJhD4MSKTR/G/8XCL+a3ONUPgnwMLz+/q9C4g+A52CivCDNXLHose+ro5t0/GpHeF
         m8kjq/Imh1km2mx3bGWq1vLe2kCc2EYvcgNpYjrFvkqmmaS9PAwfFDUxJr2FCA648b6O
         yi3WGaiM9Fa77SXeaFVKOtKgMJfLYtbw6EhqwFBRRszd5g1ZzTuLuu909J+Q4fKA0OFQ
         o4hjt1OSt6/pecVsySPLWFAKLJo0zcVYJ0/GivjFh1LpuMlWM4/2lqa627zWcsIKSIcg
         zAnfB26VJXy7JUHqPYM1C2GE1gQtpNKXUQGiHkNVVfRrAYSmRkdnSXuDaLQ3UnF3DsQI
         5jIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698328101; x=1698932901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1S/Bb/tPpH94M8WXhMx2lGTSS2CQLvVdb8TajQ5C6MI=;
        b=asu2lvwcVAY2xK0yrxar1HCpwjesTx72DU3wD0d8cgrytCyvJd0EgUjSx8bd/s+G2l
         PDDAGCvbuQj+52v6Qn7ys1WX0Es+pnbbIsxrAalnjGNxNZUEN/K6IcVuJsvY2T83kE8L
         3EcjatIyzXYXd//2PoZrgmJuDu0eTDoOV/posPA2+V7kJTjCqBjDuF0UAFwm/2K+3xf6
         vYuId8O5WYPPsOxMLUCKObUonnKhR9yPHRk5sUJtybdqhYJvWWQlaz0J3oRpY6iO4Nlg
         rGMcR4t1WmvvxYOVXiwRkIzukgYoc9/EVmadKRj7WtOAuALhkjUvCxK0lACgHEr2dvol
         k7aw==
X-Gm-Message-State: AOJu0YyxmQOelrcCS/D+hDU1PTbnJSa37FpVpYgnukifZmZixu8KPPLZ
        N43sVdOAN0L/h64mhW4M+/VoTeugor937JcZqUSuvg==
X-Google-Smtp-Source: AGHT+IHOlQXdKvdG6dDhTf58GtbNr/n/7+CCGsIIeBqRMx8FFpsP7RTgjGl6yZz1+3P57Q39kPZ6cYfB9llghQvkuzc=
X-Received: by 2002:a25:4c1:0:b0:d9c:aa17:2ae3 with SMTP id
 184-20020a2504c1000000b00d9caa172ae3mr17257498ybe.64.1698328101477; Thu, 26
 Oct 2023 06:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com> <20231026-mbly-uart-v1-6-9258eea297d3@bootlin.com>
In-Reply-To: <20231026-mbly-uart-v1-6-9258eea297d3@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Oct 2023 15:48:10 +0200
Message-ID: <CACRpkdYkgg91HXuZ6LVymwHvLTRGzb5ubU-7k3wUm3DDRwkmww@mail.gmail.com>
Subject: Re: [PATCH 6/6] tty: serial: amba-pl011: Parse bits option as 5, 6, 7
 or 8 in _get_options
To:     =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 12:41=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@boot=
lin.com> wrote:

> pl011_console_get_options() gets called to retrieve currently configured
> options from the registers. Previously, LCRH_TX.WLEN was being parsed
> as either 7 or 8 (fallback). Hardware supports values from 5 to 8
> inclusive, which pl011_set_termios() exploits for example.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

With Ilpo's comment fixed:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
