Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CA37D22E8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 13:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjJVLbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 07:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVLby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 07:31:54 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8E4E9;
        Sun, 22 Oct 2023 04:31:52 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5ac865d1358so1228956a12.3;
        Sun, 22 Oct 2023 04:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697974312; x=1698579112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qHpL2z0CuG7al3rf922b7WTCtXZClfeTh1eh1r/Moj0=;
        b=kKCvFHmtWu5tqLILXX0AedG84M7fH4kHZYt+gr3jw7HHXeOcp5WaBgwjRq6rdha3Qo
         Dgi/KvkCwzvZrdniKRc9afNRgjYb2kDvVcmCrxrv/UNg5TypeSSLga/mdi3mBbBwJ3A8
         1KGhFhf867IId5VJS4jhoiG/QgVwDKyF9VlKLvaoO225h/WSzkngCsnj04RhG1O18+u/
         IV3jwa7xr+MW5Hf7aMxgo7SjOcjdkfnrDSACtEgtsdaCX8VkNLM5kkpIDIO0CBW2UKxt
         9mvZ/YhOdFH+uXyAeXger52+gJEmAb0mOkRXDFBypY4wA0unbUT1FpxJ/aK9UrEJzR0T
         8WLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697974312; x=1698579112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHpL2z0CuG7al3rf922b7WTCtXZClfeTh1eh1r/Moj0=;
        b=ch8W28QtCTDJMDPtLCW+GdXunki7MESh3Bun8000lmg/T5JnoKk+GvEr7wxyxu/QRw
         UncwXDcjXBTVS8nxqUF2O4ddiXVD+w1AXZn3TV5pJ8isBEX7APMhzbNaiaQT4YLGg42i
         Dm6a+OQ0NOGLOr7/P46hkXAQohU5B26zIuq8nOkzrTTW9nEJKpg14f6cHWT6B2zqiqrU
         K9A+6iR+fq2o3et2UKcQEvcr/YETSimHEbuGaDp81fSkwfrtnjCSsKQ/knU5D7Grgw3m
         6/PLo/ha7mCP48uDbN2wSkZauPomXnRuK14B+jOJuYju8yQP/RDk0xk8+6EMQUEz/vKC
         gtcA==
X-Gm-Message-State: AOJu0YyScEbhTEZOU0pla9YqfBqIE7AKxedYKbnzqOKpVVvKhvl7xLvn
        vtrZ3gL3TKSd8tP3OPAZ4hB642J6TjE=
X-Google-Smtp-Source: AGHT+IEM6DFjYHYDarRMyd0/IV6lbMNl6C3UkgpHkbUg7yuK36W08HUQM+y8SBM0+lAw8OjRMabC0A==
X-Received: by 2002:a17:90b:a06:b0:27d:23f1:ddeb with SMTP id gg6-20020a17090b0a0600b0027d23f1ddebmr4779740pjb.38.1697974311987;
        Sun, 22 Oct 2023 04:31:51 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id h6-20020a17090acf0600b00273744e6eccsm4152824pju.12.2023.10.22.04.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 04:31:51 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 0A49D8322DD7; Sun, 22 Oct 2023 18:31:48 +0700 (WIB)
Date:   Sun, 22 Oct 2023 18:31:48 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Rostislav Lisovy <lisovy@gmail.com>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>
Subject: Re: Old WiFi modules -- for testing?
Message-ID: <ZTUIJHf1vdSxkXeX@debian.me>
References: <ca929e1d8197ace414a06b20151b84de3dd160f4.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LioeYb2fbIOpCQfJ"
Content-Disposition: inline
In-Reply-To: <ca929e1d8197ace414a06b20151b84de3dd160f4.camel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LioeYb2fbIOpCQfJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 22, 2023 at 12:16:04PM +0200, Rostislav Lisovy wrote:
> Hi,
> I am interested in donating the following WiFi modules to the "Linux
> wireless project". I guess they can be used for some automated testing
> or training or something like that?
>=20
> https://photos.app.goo.gl/sfootr3X8KVUBYf48

=46rom album link above, I can't tell exact models. Can you list ones?

--=20
An old man doll... just what I always wanted! - Clara

--LioeYb2fbIOpCQfJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZTUIJAAKCRD2uYlJVVFO
o5tHAQCP7ybF2+BIoWuVdO1b9i4PErFhJjufHUYo92BvWv4DgQEA1Ol/FXygsgxF
XfJynOzItd3MH8JqfxMim68K5Vl0vg4=
=KMhm
-----END PGP SIGNATURE-----

--LioeYb2fbIOpCQfJ--
