Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FDB7F7528
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345088AbjKXNc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjKXNcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:32:17 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6032B1721;
        Fri, 24 Nov 2023 05:31:23 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a00f67f120aso263956766b.2;
        Fri, 24 Nov 2023 05:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700832682; x=1701437482; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqoNh8/DGOCDjWGBAsyHy8zDaolvBGz6WR/aPalN8vA=;
        b=jc7pzhndHV74TrW5Y6euP8yk3htKIp8W3o1J4svRrdUUZjIdDRWgvExoS9S0QJD/zU
         rBFEIT2MxFeZ/RzClYiIL0/02BNJdUr2xcGIsYQ77LaRf35g73whiGnOOChNAdVWSOrI
         3hoq8vKd69rpowWA013qKYH7Bo61cWyy4QgiMXLsdISIwruZm2QyMOky9gdvpigFT2kh
         1fDO4jvhAIcvXHr6BSmtl7uTFXktnDXDFMVWUS4DaHBnHSBtYtswpMLFp79/pPk1yWRG
         hmZEhc/S29RsphTAt0pf2F0NPDGxYOfd/0JNu3TNk7MPkdFYp/43uE6PvHkLxFHbM6ee
         ZfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700832682; x=1701437482;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqoNh8/DGOCDjWGBAsyHy8zDaolvBGz6WR/aPalN8vA=;
        b=C0nGbEllQd0ZR9UGYNYIabEcZU4JD8C4NYjDZNpA7s+0dg2NqPP62OPWLMLz/5M+78
         tmpXg8oVR1r1kZlVcj8bEdUHzE3TPASfVNWVYIHvrhKOQoQYzN0wuRoyMRLPPE/+6Ovy
         ZADRjidfCaGRO9R8L+NVGSt9DfoHfPWXnLMvxpTMKbojBG56AvwWtji0wwC1jWKR/131
         /BKk4Zi6MGdDyIz9IRP9E/sQDEELpVn1H/Ist3FnTBsPOM0reHjQ0Xr+OaRIPGOobYge
         XINBminf+wxL25fA4hoDhLRwrTKsXxPIaP0D1X5uq7tFW57KBgHdj36ParxPaVNgGetL
         ah2g==
X-Gm-Message-State: AOJu0Yxm62nmPBvJXSHKOOIkD7oKbpAsw8xRU5Yr17p55DoW6b0eC3DF
        kyWzyWAWzcpI3hUuINPbNBs=
X-Google-Smtp-Source: AGHT+IF2CMWqW6QgTEUE8dPizHd4yGlrN9Vk/VgdOvaxxbdjXw50mDYgNNx7FjDnvVExXduvtyJWvw==
X-Received: by 2002:a17:906:5da:b0:a03:a857:c6e0 with SMTP id t26-20020a17090605da00b00a03a857c6e0mr1663923ejt.77.1700832681495;
        Fri, 24 Nov 2023 05:31:21 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id c24-20020a170906529800b009fe2f96ee9bsm2064075ejm.8.2023.11.24.05.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 05:31:21 -0800 (PST)
Date:   Fri, 24 Nov 2023 14:31:18 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sean Young <sean@mess.org>
Cc:     linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Jani Nikula <jani.nikula@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 1/4] pwm: rename pwm_apply_state() to
 pwm_apply_cansleep()
Message-ID: <ZWClpnMRg_vjuI_R@orome.fritz.box>
References: <cover.1700323916.git.sean@mess.org>
 <2b973840d800ffb71c2683c37bc996e0cf90a140.1700323916.git.sean@mess.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mURPCj0PduVIws0V"
Content-Disposition: inline
In-Reply-To: <2b973840d800ffb71c2683c37bc996e0cf90a140.1700323916.git.sean@mess.org>
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


--mURPCj0PduVIws0V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 18, 2023 at 04:16:17PM +0000, Sean Young wrote:
> In order to introduce a pwm api which can be used from atomic context,
> we will need two functions for applying pwm changes:
>=20
> 	int pwm_apply_cansleep(struct pwm *, struct pwm_state *);
> 	int pwm_apply_atomic(struct pwm *, struct pwm_state *);
>=20
> This commit just deals with renaming pwm_apply_state(), a following
> commit will introduce the pwm_apply_atomic() function.

Sorry, I still don't agree with that _cansleep suffix. I think it's the
wrong terminology. Just because something can sleep doesn't mean that it
ever will. "Might sleep" is much more accurate because it says exactly
what might happen and indicates what we're guarding against.

Thierry

--mURPCj0PduVIws0V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmVgpaQACgkQ3SOs138+
s6HS8A/7BjtLlUH5CMfFlBTprZQsDfOXKtQTFT7vSIrS5EOAuemIkCNWaesc5juC
gFpHk93q2Y8+pTg499tii+Ztr7m6Z00sAA8fpGEFwUn03iU9qrrC6/7gwVu8Dsjv
m326JeQsUo8SL3s5JqH7vKQDUU0agG/rMAFwo5nIzD5xRGmtg1VB+Vg57/T0K4a4
W99vEqpxwYAZLNQeId2ZTCZHREypDELrwcq0l0JYOOXdsvYa4r34dPep1KDfTvxK
p6fGafsCc1qJ8S9ygxlTGPv/5+56JXyOEB75XXxBK2QaqEz9iHPxgfJsHz7K3DFx
cpZtcEd899PpMbAiW5fag0BJcnUNffFf4CoZU34H8MPsp4DzKs7UvJlbQ79KNz6N
VIjXUsk876G5NuLjwomvkmaxx1cQPbom4YknTav6Zm5dloV36kppnYuZ9+PV8NlW
uudn06BsR8Yp7d2hpCHK6Vou1zbJtQHxQosq3e4e11mnMXxpnftSCuWZCeUedAhG
zufpjdOkX1q24J9odZWGWz8rhGWgJUwtIpF8SOkPromrYAxZK+yJAb7AvepYNQNh
i3X0j8HUnYCWUx7ty20NjF5rVY/GJh5DXncoB5cQqVlLCr8YUvFsOQ9YaUuFa/J5
M/YrTcS9Bi0p3ps9qE3ec5+WY2E85s4+KeG0Z0/GD1ifS+r4fls=
=1cUS
-----END PGP SIGNATURE-----

--mURPCj0PduVIws0V--
