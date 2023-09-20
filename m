Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D867A8395
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbjITNiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235925AbjITNiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:38:51 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83309CA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:38:45 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-690fe10b6a4so179965b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695217125; x=1695821925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FQHKdw1+gvxaPiEF/Hup4thLIlh9e9IPK8GfAFiq8IE=;
        b=B2mRd2BbXASl7BC1MX37KHJRd8H0POij2/MgUe/yQnp9ziYWCxjvwv9eTZmt7wueZD
         PkoqVBJKrf6J17yxBblR4E0zJz3QZ/rwDhc/OLgTiwdcB4/t+4LCKRlLpzKsIgwVV59T
         yCCBzLVwsX3e40m+ZTYiblVW/57bE9Q7+/tqbLyo3sh9CtqVvkQB1yXjBJlzVkOHGRFh
         C7UiA9qiSSVYzQwCsLqZWw2f2mJxatfHEzV7Wer41Xe1mOWcNwDK7URyiwG5TQY4DK88
         8QIvW99I+s1BYzfaP5yOtyA8K8XSB17Beaz1UBvIuVCQJnDWp8uyZmmseyAkZaoBGqLM
         dDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695217125; x=1695821925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQHKdw1+gvxaPiEF/Hup4thLIlh9e9IPK8GfAFiq8IE=;
        b=YIjmyLQSBaDqwqH1GCpRazzWDB3oRFjHljDSOKYPib04P88614XItiRMnybAjbRsJG
         Sp0Q+3qQCScu99rx8DpFYzQKDHRzjJZATgHDXw4dpCl40v6/JfWB1ER3soGYWz7MIM+9
         4VvOaHSnp5VZxryEzrhMGdzJKq1vcW/NYG33k85rbrdn6nU37rpMYRml7mheWHYMgnhB
         q0JoCSRL0Ev0FKvM5uv9wm7QP2wAQI1Dsd7B6ZZKAihpo+49/CFRw3DfqwaBUGPn2x2L
         SKC82ojmsjeZzU8v1Hr8NGuBdQatMZ7jEDQ0VrXmDv8FjgCK33S20OcsxizR7Yllpa0J
         9UAQ==
X-Gm-Message-State: AOJu0Yxwh9mz98fz4WONkdN12FAVlzaG2WBSe8eQnsd/I/rJIyXo4J3N
        R+2EcavXMipzvutiJ3uw00zAHaNo4aU=
X-Google-Smtp-Source: AGHT+IFliT6WJiLpmKJwPmQWbJDiZ0YUGdE2tlBLacbpZm99tQmi3X2ooW6ThDzGU96xNS3RqpDsrQ==
X-Received: by 2002:a05:6a20:13da:b0:137:db14:e88b with SMTP id ho26-20020a056a2013da00b00137db14e88bmr2442572pzc.29.1695217124829;
        Wed, 20 Sep 2023 06:38:44 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id q13-20020a656a8d000000b00564b313d526sm8571343pgu.54.2023.09.20.06.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 06:38:44 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id F007A81A3119; Wed, 20 Sep 2023 20:38:40 +0700 (WIB)
Date:   Wed, 20 Sep 2023 20:38:40 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Lucas Tanure <tanure@linux.com>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How to support maintainers
Message-ID: <ZQr14F3PGYJTLaXt@debian.me>
References: <CAJX_Q+2VNu6eBN1NWC-pcG_-DfAQ82dEVUznBJO2jb3itnyugQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bB1/XFbiDKAK/9sY"
Content-Disposition: inline
In-Reply-To: <CAJX_Q+2VNu6eBN1NWC-pcG_-DfAQ82dEVUznBJO2jb3itnyugQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bB1/XFbiDKAK/9sY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 02:16:04PM +0100, Lucas Tanure wrote:
> Hi,
>=20
> I have free time and want to support maintainers in their roles.
> I just saw this:
> https://www.linuxjournal.com/content/linux-kernel-reduction-longterm-supp=
ort
>=20
> Is there a page, contact or email list where we can receive tasks that
> need to be done?
>=20

See MAINTAINERS for subsystems you wish to participate. Go to mailing list(=
s)
for that subsystem, and help reviewing patches. You can also submit your own
patches.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--bB1/XFbiDKAK/9sY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQr14AAKCRD2uYlJVVFO
o3VPAPoC4QHYjKPjSRqHg7Z63RDYeORpUtDMWzOBdknZ1RoWEgEAiBIkcYUhqV95
dB+caIdGInG7FgTPk7dChXVoLc+Nug0=
=Qf4H
-----END PGP SIGNATURE-----

--bB1/XFbiDKAK/9sY--
