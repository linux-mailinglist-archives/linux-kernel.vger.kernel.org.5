Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92DB80C6F3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbjLKKpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbjLKKpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:45:46 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC2FCF;
        Mon, 11 Dec 2023 02:45:51 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54d0ae6cf20so6028131a12.0;
        Mon, 11 Dec 2023 02:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702291549; x=1702896349; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1N2/J6JuqJLhRuV4xjOtAP39+2raieKGXxMe/+IOvM=;
        b=OcAZUhr1jVaK5oqiULRZaTRKlM8LNN4quKAIaKRdhOPprZBp43Lh67it/Djp5d/LfD
         OH7VzOcXmbswULIxj3GIwC9LA0szwe+xe6GDOldZNkU5yFIIZI/eLWl45tbd3/D4udYs
         Ghp+HZtCWGE137mbR2kP9A8Ga8O1D3k+8x7yR94OE2dev+Z42PlcYzMix2x1HWaF5mnM
         dVqq/AxQdzkh32WnInLLYaaijwo1RXitC4SOqEvC7PFhQ9ELJHWWgPfLnDStiQe9c5Om
         Hi1AGefiGrd0HGwFkXEesf8a2E2i2PIiLk0gnvDkmkNg8JE2va7WehwJB+H0KVsPFQlJ
         3upg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702291549; x=1702896349;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1N2/J6JuqJLhRuV4xjOtAP39+2raieKGXxMe/+IOvM=;
        b=fIc/Ez8F3XiKiTY54RSAPYsqN8e9uoALcdWCKakl67yENHNCT94zjpUvbKfvRYN65F
         bOkzMrHvpErm6Y2iFY2+OhnZTQVHW0VPUihreax+INy8P9iPtsnB2iLl/CNjh6ESl5It
         BPyWeVPKXk3gBdQyeNajyTremCA/DMylr0lcDkMUILWSxwDccu0Ukai3Jnc8HX6ZfeAx
         BweuMSewhyycg4mJRPX5HwNzq3iYcFJx5qhkjfrWsLAzMOUN6ccm1bFgwEVl92CQSlad
         GMi+ZJEKpPLqF73TLSzZRZpTYvDuhkW9oPPiyZC8amzy+pz33Y+InAYjKcS51EAusbsp
         RiXA==
X-Gm-Message-State: AOJu0Yw2/zPEWcMC0VuYOp002LVSGfD0+dyCiqLD0ADDrOmtZ6P9t/oc
        lEwnq9uBbQ6t5HTexPmrbf0=
X-Google-Smtp-Source: AGHT+IGAcrvccN5W82VKMxYQhM31//DyH+tulrFa7mhx1Ada8kbo3zayltrYfBMK8JlyxsnWMhxZSQ==
X-Received: by 2002:a50:8d18:0:b0:54c:8f76:cdb9 with SMTP id s24-20020a508d18000000b0054c8f76cdb9mr2717863eds.32.1702291549278;
        Mon, 11 Dec 2023 02:45:49 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 27-20020a50875b000000b0054cac2a0715sm3634695edv.93.2023.12.11.02.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:45:48 -0800 (PST)
Date:   Mon, 11 Dec 2023 11:45:47 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/4] media: pwm-ir-tx: Trigger edges from hrtimer
 interrupt context
Message-ID: <ZXboW5ufZ4v4uoXh@orome.fritz.box>
References: <cover.1702282806.git.sean@mess.org>
 <b3c2f84c54219234eec96f165cd0bf1147a7ee80.1702282807.git.sean@mess.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wnx2BPmIukpQ7gdk"
Content-Disposition: inline
In-Reply-To: <b3c2f84c54219234eec96f165cd0bf1147a7ee80.1702282807.git.sean@mess.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wnx2BPmIukpQ7gdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 08:24:55AM +0000, Sean Young wrote:
> This makes the generated IR much more precise. Before this change, the
> driver is unreliable and many users opted to use gpio-ir-tx instead.
>=20
> Signed-off-by: Sean Young <sean@mess.org>
> ---
>  drivers/media/rc/pwm-ir-tx.c | 79 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 76 insertions(+), 3 deletions(-)

Hi Mauro,

are you okay with me picking this up into the PWM tree?

Thanks,
Thierry

--wnx2BPmIukpQ7gdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmV26FsACgkQ3SOs138+
s6Gviw//S5072+tyJHmRBfl7AN5P4HsSoGIPclGlqO+yRuXSqPz0/wLI3qOaqfMf
3WJkt03MRP15oHf7N126YyvtKbc6bRo4KN+DJdtxK/VBKdfy0HxopCpz++16OEjU
4xNCN1iC27hQKHKVzccgQSKgMePa/Hk5smL9/J9Oq4BuFpJis3KSjShF8QmaJZyu
muDAcEmjD+DVcWPKw4SrKMVDEPuMzMn5DSzcI30giO1B84conBlO2Jm4l4tLMdKE
Br/0cnDZ2z2y9+sIqZmDj0BT3sQQYl5zcJPahN4+cUhwjsx08ZLHghN6pJ/n5FCf
aBzGEk2tOku/OTpozz1W7zXHMd1AsBj5V2elY1a8MtbQ4ICVr9Rcu10KOMDsOjgu
kD5qvPx54tuqLt/sj6Ii2bFj2qCG8AdWzO/JjtKS5GBN3A1ZC/Bq3vqEf3KQ8xoY
je+QzRcfa9/5ZKpUpDt+YQ2HFBrT1aZj4GQpIoDLtjtSJ3w5RE9zeiq7nb3TDcds
7qjn4LrtI4Ehtt6qn+I6ClYwu5zJPPgmqiW+lKlb0bOzVq9QK6H9fUkNQ5s37u5+
qjqBCeaYxNp9DqekP078AhNKV04VLqsQwdI+nYLqoPdsASE1+yNLo5SdwmsUbXNO
d/COSj9apojs5kXbdGa5umOQXZ93y9EapKRX17zQgu6ddT9bUpo=
=+Xoo
-----END PGP SIGNATURE-----

--wnx2BPmIukpQ7gdk--
