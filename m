Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318547F7556
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjKXNgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjKXNgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:36:49 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDBDD4E;
        Fri, 24 Nov 2023 05:36:56 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so274596066b.1;
        Fri, 24 Nov 2023 05:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700833014; x=1701437814; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLmOSbrE/2kU+ec8KehbdILGLwTk1RjiZ7PfntVZKVg=;
        b=H/MNj97MjDGEA1MgnCDp19yM0I3dylVoY4KFDr2weMkdgp48P9JPSGEPS35cytroUW
         gt+kAEYIsdZdqnMi5ugeuwpwvtRKPswOv+/Sd+BgJz8l0/d1XlJN+bUGDgy4hAijd1si
         35b2WDWZcah4QUP++IEsaUT0+M3V6b0nIV/gpY806nIkN+L2uFAamqrNPPoRQv3pMJ72
         0GkOGxAQVQUmHL8Uyp0lhNOky04SOm3bKYVoYn0AL5DlmHNkMKUeDw6lvK6aLS8Kf4pg
         P7yd7I+HeRlREgeUxebbRd+NWfCSM0ws7LUe+rbUWVsFgDsP5B39vlyEYUZE0V6PNmbJ
         7ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700833014; x=1701437814;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLmOSbrE/2kU+ec8KehbdILGLwTk1RjiZ7PfntVZKVg=;
        b=Gyo/napN2oHVcY5tQassTWjPyySvKtQgzk6kIZkHKrfyb7syJ4GPwE/J/CJfxHfn/M
         XwAPHj5U3qyg2/JiYhtMqy1Wyiawzg8rxbeXoz9QsyKljFcDf1Fsq3VJ+ozzxHqMCx3c
         l3YbdxhU0P8mbDyvLxCVVpmfkE2liup8+KzrAlkIGWTlAGY8si4XBDqOMXfCL8q8g7QY
         vN0iibgQejUfHWAhWNL5Yq65+OOyvIx0ouuBHmE7aGUZ5rGAx0UbPWKayUXmy/J7OrCd
         nMbbrWqRz0GsSXsFpNhWzU29dW1Sl3eJtkHqGGSexYj4XPYXzvmedI38K5u18owroeIz
         wMqA==
X-Gm-Message-State: AOJu0YxxAIwIvDU6bbZWSpQfd//2k5qwjlJ6oJf8ClbYv+hfduNA/ZkV
        DILMxDHfPaEU+ZUwCPVmoJc=
X-Google-Smtp-Source: AGHT+IFqZ50WMt2oUp76dypCcRHmS7//0BjeidS5jzxRO70QfgZZCnN5MAFNHkmo8jgNyiAQWLfVCQ==
X-Received: by 2002:a17:906:12:b0:9ff:7164:c1fa with SMTP id 18-20020a170906001200b009ff7164c1famr2422356eja.13.1700833013605;
        Fri, 24 Nov 2023 05:36:53 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id z2-20020a170906434200b009ad7fc17b2asm2049547ejm.224.2023.11.24.05.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 05:36:53 -0800 (PST)
Date:   Fri, 24 Nov 2023 14:36:51 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sean Young <sean@mess.org>
Cc:     linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] pwm: make it possible to apply pwm changes in
 atomic context
Message-ID: <ZWCm8_S7epYQwZiG@orome.fritz.box>
References: <cover.1700323916.git.sean@mess.org>
 <ab49d3c11dd3fa432459cc8e11a77127f1a803dd.1700323916.git.sean@mess.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hgjpG1/obTMMognX"
Content-Disposition: inline
In-Reply-To: <ab49d3c11dd3fa432459cc8e11a77127f1a803dd.1700323916.git.sean@mess.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hgjpG1/obTMMognX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 18, 2023 at 04:16:18PM +0000, Sean Young wrote:
[...]
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index c4b066f7c5097..495aba06c64c3 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -286,6 +286,7 @@ struct pwm_ops {
>   * @npwm: number of PWMs controlled by this chip
>   * @of_xlate: request a PWM device given a device tree PWM specifier
>   * @of_pwm_n_cells: number of cells expected in the device tree PWM specifier
> + * @atomic: can the driver execute pwm_apply_cansleep in atomic context

I'm a little reluctant to suggest that we rename this to might_sleep as
well because it would require that we audit each and every driver to set
this properly, since by default all devices have so far been defaulting
to "might_sleep". But then again, I think that's something that we're
going to need to do at some point anyway.

In the interim, I think we could keep it like this and address this as a
follow-up.

Thierry

--hgjpG1/obTMMognX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmVgpvMACgkQ3SOs138+
s6HAAw//ct4gKrWjBExDza1kxoB9kMmSwy8Ix26Sb4TjW89uZEp7FQCAgvsILRk2
XVKu9xl2vdM/WBprSkvv/UQdBz+g18xJVFKbJdz4WYwrYjdRic5vdlpUsrkbjYUr
WbccEEMdQN+s4c6QpRCFxAEJbwTvI5KY/HG5cRhfp6EtwfXgBnjtjwRcYc+4/jEm
AaJ/fEdpKd9biRwFIkFyrZsZef3MJI4KVE5Nfkz+lkMCZuSCehkKO/Mw4gNsbgWR
ehd9Gcz+nBZDPYgn87UTrOJfM13DBIRpLT087OK/MObKvzYGH9z0q5UcoFoCMdPD
v70M5i+jFEDTkjYoIibeftoL88uq0boga3YwU8UP8KhlnJSW4gUubDfP31W8SGcB
ZUEwW6Z0hxmDMOdH9FvikAdWYhopwu+Y8kcZUkDVFO6FiNZihP3pm/Pdc0RSf/Vc
WaA9mFhHOngaOde/dLx5E8OYc37WHqXehS3TsfExjkuiUEJv9hBIkx4AT47mSEKi
AQstSySIApc0vaXsT0DZ6BCNah6MBGmAchtX1t9jtf2k4bW0iv2fh3z6maOS3U3S
Yk/XhoT9Zrsaxd+30PaaoU5HFNEFzT0n86QyLecTnGX5jdd1ecLn4V/QslJFon7A
BrpbbhA0oiKZ05xlpvjL3I24i6lFx59EI76uFrxDh/kMkdESiiM=
=NVyq
-----END PGP SIGNATURE-----

--hgjpG1/obTMMognX--
