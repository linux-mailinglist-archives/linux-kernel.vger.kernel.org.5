Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786997C5F96
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 23:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbjJKVxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 17:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbjJKVxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 17:53:48 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F42D6;
        Wed, 11 Oct 2023 14:53:46 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-536b39daec1so604453a12.2;
        Wed, 11 Oct 2023 14:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697061225; x=1697666025; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSScds+GJQ6D93Fb0cWNRZ+D6voBNtXqMw6bvzbLln8=;
        b=FzlGInvYo2T1/xVjhyAUNBXA0V/qlVNJj/e7FE1P6fN/9xJEeP3jPPV/9FfUyAcB/P
         x5EotiJnmaL78O8Uux+3FLd6GIBCGjkM/XqjqjmM4PErR7i8rsdsKyczp4BKVlPn9lHP
         digi6RXBi0pIWh9egiAPJPWfaRVQ6pHJ+uAXtiNafJv0DlLXlM1etChTb9uegggE1Gr1
         nNPz5K80Qgf+Svkfb1HRred6wi2InZDGVQbUPiHFCXCacd3u4C4mxIacEcT5Wum3HoG1
         Nkl+jrkaXhEEVuVllADJsvoe+SRiohJIbsp6A57kekQWws36u4aPRvvmkaUEv3GWigcZ
         nxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697061225; x=1697666025;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSScds+GJQ6D93Fb0cWNRZ+D6voBNtXqMw6bvzbLln8=;
        b=bU9y8LoYZ7GW+rp24rPtvvUJhzNBvbHlDtB5TM4vT7VsowgV7TLKsco8DLXV9v67qO
         nArNt+TjotG07mCa8bb6UU+/Yz1R+o9CWHXA80fq9rf66v2bqFXDPIS98f+3bH6fVPFl
         LlKyC08gPYG9oJz/7/eFLLrlErV5qSDxA9tv8bWh9Sf3dM9qqmjNen4a2Q1j/iwso+mq
         u5AHad4D8R7tWEu2yFrFg2kc1kwZ438CSYcwk3gM4e1qcLyIBke7HcgmxkCPDI/rCdt0
         Tzi9++EUT2WR+aqCODzCAm4WKngSOGSTZBreXpJoRJC0b8qZ2mCFzLnr1nwCCTIzugvQ
         ebTg==
X-Gm-Message-State: AOJu0Yyz1osDLhHSdNRsoXhwUPJX69soKOSz0K1Aae/bBE7iS2t+/Z3u
        sePzO4H1HW2t5LHKcxg9Nmg=
X-Google-Smtp-Source: AGHT+IFpY65P9BPWCyH+AKHIBxbhMgtZ8QSz6/S7tZ5lBAY/78hJuPHGTQFcHAEKLoOyBo/R2qRJNQ==
X-Received: by 2002:aa7:d902:0:b0:52c:9f89:4447 with SMTP id a2-20020aa7d902000000b0052c9f894447mr19407023edr.4.1697061224833;
        Wed, 11 Oct 2023 14:53:44 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id f17-20020a056402161100b00537666d307csm9387655edv.32.2023.10.11.14.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 14:53:44 -0700 (PDT)
Date:   Wed, 11 Oct 2023 23:53:42 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Thierry Reding <treding@nvidia.com>, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] usb: chipidea: tegra: Consistently use
 dev_err_probe()
Message-ID: <ZScZZqRYvLHxa2HI@orome.fritz.box>
References: <cover.1695934946.git.mirq-linux@rere.qmqm.pl>
 <43d03aad1c394d9995f69d13ca1176f9ff8a8dab.1695934946.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NIjWg3bSNQ0mxaxS"
Content-Disposition: inline
In-Reply-To: <43d03aad1c394d9995f69d13ca1176f9ff8a8dab.1695934946.git.mirq-linux@rere.qmqm.pl>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NIjWg3bSNQ0mxaxS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 11:06:04PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> Convert all error exits from probe() to dev_err_probe().
>=20
> Acked-by: Peter Chen <peter.chen@kernel.org>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/usb/chipidea/ci_hdrc_tegra.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--NIjWg3bSNQ0mxaxS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUnGWYACgkQ3SOs138+
s6Gjyg/9Fp/5PJpk4a76rLzVEmaDglABgYvF+GOflqVvG9ugRJyAO7HqA/+xRWG5
uf0hn/YKpNIjgA9h7memtWUeePZedwQ5lCZr0okb7MTmJS/t6XG2DeZ/FjegWQXO
A3Ljtm+hQ5MQSdUm4E0zptKHe/lS3ks8GUrM4uijQYFEYFMWwvmHAvd0ESHU7pcD
EGESHZwnNbtL4zbHP3sYcCY6ydPkmbl0YOT2xKb+Yy29SZDaEncyVOAb1MAGeO7s
E8VVbNgXi73vIrzgHNmUC//pglINynwn85RfIrO8cgSZOMva4oqQDWPkfAk+BWI5
/uCAR6A4AFBvDUYH1E3XSblcNI2lDldEGgoeXeebI71+vqM3UM4PAhJsfB3PCaMC
WyU4f4EnGQSdmnBIbrsg34M+6nIhwcyKxiM5UIXtsLpQWGXWpMpRrk5SDawvwQxD
bMx8t4VI7TOFHcYRPgQcnrm1N/U1Aah2GFcCKJ5ctlIxOEWfRzHDAI+PblpfiVxb
77/lWU774M5P+zTh5L32wO8Mozz4DQuqeoW+x57GpvddQwb3ftChdD4+vp1fodh3
cPMK5Gcw6Rjg9CF4O/d9/WA6chuyM8Cs3k+XivSHqITGLmxXLHU5F7y6ax1IcnN4
w9fVt2egKmUzSfDbbYfWjy5yhw2d0mohMpGzdF6xNSTMhCuuAd0=
=ofw1
-----END PGP SIGNATURE-----

--NIjWg3bSNQ0mxaxS--
