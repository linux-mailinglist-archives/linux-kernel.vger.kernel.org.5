Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6739F80CE49
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343847AbjLKOZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbjLKOZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:25:00 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FEC5B89;
        Mon, 11 Dec 2023 06:17:32 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a1d93da3eb7so525087666b.0;
        Mon, 11 Dec 2023 06:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702304251; x=1702909051; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjgDoH5wpFTvBtjku8JEMjQ8hKrrQC8Hfkdc8NZQjks=;
        b=FR6iqYo4r0ATlem3wbq4NcI62K62L4+Oom6+PvSCOn+jPjJnY+vUwt9cgQFu0EETQ5
         57EqkROIKrr7aE9TOWQ6CmTZBEJiwdJoCUhsXfkK2xsJLM53cp+66859nrloFABybCza
         osKVUfQ2ZGfbv4pgu9ZXiGmq7yaBnEaOKmuE8z1vsbxoz+7j4DpL5kR0swHGpfeTpANX
         zhSJ5FhI/L5vPbHY243UGG3ehksjlxUGADF+G+4gm+a5FqXevtjc2njkf0dNbiiPkOHN
         NqTdQjrA7T3IpBm6pRPa8jDHvM1VrUPfYNc3UZVYjGKtWVB1DS54PC6h3SB1f8AFf6Kc
         5DbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702304251; x=1702909051;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xjgDoH5wpFTvBtjku8JEMjQ8hKrrQC8Hfkdc8NZQjks=;
        b=PY380t9i3U4aglAXgA65ICNJoaFvP8sMYEyKJao9vBQuodToSpsSO06oP++sB1pZpQ
         YXI8KpJ9ouc0pwu75p7qpSo1xmnbZPTJY0PqPdTXxrGzEfmAq78bA7nvM8vrtHhusk/A
         1F/MgfdKhrF6pAvh9YBSU+JdIxnKVV8xyyn8FPVKeSlCLUR3O8RCeFN3jq0RlxqeRh6X
         utx3a7EGkTzwUsQVv4pouyrNfgE2pUPsEVVELhvWxrnh7CTNfS5gQvjS5i3VIpq2omJa
         cSR7GNtfl13b5F7Ddv0mqu6cisIlhrZjrwpMu1fQjezcBqitfalB8/wC3wrVXqJTFKnE
         jl1Q==
X-Gm-Message-State: AOJu0Ywf3MjpRodt/m7L78bAJuu+ZwhUelUhAOzVEKYjKYr7RuhVdh/W
        xfidIJ0/hTOWra1sjVnp0X0=
X-Google-Smtp-Source: AGHT+IGvtRp1DsOkZJ5XmsG/dnogTspAPXgW486VHcUzxU/sxVwTq6S7cWTfJRA7TFXSMcwnZYFJ4w==
X-Received: by 2002:a17:906:512:b0:a19:a1ba:8cb6 with SMTP id j18-20020a170906051200b00a19a1ba8cb6mr2088159eja.84.1702304250718;
        Mon, 11 Dec 2023 06:17:30 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id vc11-20020a170907d08b00b00a1ce58e9fc7sm4849982ejc.64.2023.12.11.06.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 06:17:30 -0800 (PST)
Date:   Mon, 11 Dec 2023 15:17:28 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/4] pwm: bcm2835: allow pwm driver to be used in
 atomic context
Message-ID: <ZXcZ-D2Bc58ydsIn@orome.fritz.box>
References: <cover.1701248996.git.sean@mess.org>
 <179dc1ce85702a8b64b43c0e0df656b0c5e3ce30.1701248996.git.sean@mess.org>
 <ZXNC3JYy7CTfYsyC@orome.fritz.box>
 <ZXNL5upeUPc4gC1R@gofer.mess.org>
 <20231208172040.mgw7aicmwlw6yjyb@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gN2yPszgClY7v+2k"
Content-Disposition: inline
In-Reply-To: <20231208172040.mgw7aicmwlw6yjyb@pengutronix.de>
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


--gN2yPszgClY7v+2k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 06:20:40PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Fri, Dec 08, 2023 at 05:01:26PM +0000, Sean Young wrote:
> > On Fri, Dec 08, 2023 at 05:22:52PM +0100, Thierry Reding wrote:
> > > On Wed, Nov 29, 2023 at 09:13:36AM +0000, Sean Young wrote:
> > > > clk_get_rate() may do a mutex lock. Fetch the clock rate once, and =
prevent
> > > > rate changes using clk_rate_exclusive_get().
> > > >=20
> > > > Signed-off-by: Sean Young <sean@mess.org>
> > > > ---
> > > >  drivers/pwm/pwm-bcm2835.c | 31 +++++++++++++++++++++----------
> > > >  1 file changed, 21 insertions(+), 10 deletions(-)
> > >=20
> > > s/pwm/PWM/ in the subject. Although, I guess you could just drop the
> > > "PWM" altogether because the subject prefix implies that this is for
> > > PWM.
> >=20
> > $ git log --no-merges --oneline drivers/pwm/ | sed -r 's/^\w* ([^:]+): =
=2E*/\1/' | sort | uniq -c
> >    1197 pwm
> >       1 PWM
> >   ...
> >=20
> > The vast majority of the commits use pwm: as a prefix, only one uses PW=
M:.=20
> > In fact if you look across the tree almost everywhere lower case is used
> > for the prefix.
>=20
> Thierry doesn't want you to change the subject prefix, but only the
> second "pwm" to make it read:
>=20
> 	pwm: bcm2835: allow PWM driver to be used in atomic context
>=20
> While I understand Thierry here, I'm fine with a lowercase pwm here,
> too. In my book a PWM in all uppercase is the type of hardware and pwm
> in all lowercase is the framework's name. If you use "PWM driver" or
> "pwm driver" then doesn't matter much.

I'm not fine with a lowercase "pwm" in what is clearly text. Text should
be grammatically correct and PWM being an abbreviation it should be all
caps. The framework name is also PWM, not pwm. We use the lowercase pwm
as prefix because it represents the directory where the subsystem lives
and we usually don't use capitalization in file and directory names.

Thierry

--gN2yPszgClY7v+2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmV3GfgACgkQ3SOs138+
s6G4gQ/+JdOurEDhll7cImaJ6eu6WXI6EmxsPcFtvXqydrGyPaoLvSaw1eKq9cYU
QUWpM6rdBZW3kQTlx+6766tmW5GMa4hK9LZiRUpH5wQfJrq+TMTyp+sOqq2pIw9C
voiT2ShRE8Z5uYu4lRr+mp08Ws9RcL44wvIYOLXm6V+xNe4IS5kup9N3ObX+HvK6
OIlbZKPgCLt4zmlDyYDOy0A5v7uAmaaejjx1jeVmBeDc9pIspK7CrNBZSmKS5jVY
SNJydpNNmoDcGmkPhkTjzB3nyolXuo/UyqdaDGfd7YkCO7sIBhYoxIcXxyF7/6mQ
1lPy5QM0WxhAjeU2ScfKoHXoPH9YATPYj2Mf2ZQp8ltchmmXnZGLX64WfPcgp8f2
bJs19PfF24c52n5HvdHkVMVM0loWpbNp+ozY0o/wcKDna6UksuLNkEf2PJ8bS9gD
vUoBH/uTVRFXtl7QXSRk1Vnbn20dwPoORFmLdBSGQI44K7hcEaUkQtS3/t5PXpBW
bIOkYwMB5jyARmUgbnFld2wT/6t5FV7hNseEyRHszZc1CFn1gSiPz9j4TRkCAoE8
CvlZ5QG/6BzU1haNEplHPn9wfsYKOdJ3k/GNfgYAEfWpB7Pi1gkgameq57TuUxSA
B+Z7nhZCd3hWoNF+oRlqe1e0zH7CuTRIgQ3yBxjX9nNjeclKo5c=
=FV2f
-----END PGP SIGNATURE-----

--gN2yPszgClY7v+2k--
