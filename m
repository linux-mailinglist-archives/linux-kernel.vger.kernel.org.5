Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99ABA7694A5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjGaLVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjGaLVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:21:03 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5119E10C0;
        Mon, 31 Jul 2023 04:20:59 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bc02bd4eafso12782515ad.1;
        Mon, 31 Jul 2023 04:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690802459; x=1691407259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GbS8Qlfzn1Dgn19TT0BgR1SE8o6tzPgDzghenWvydYU=;
        b=sRCcK4ssYdzJDLDSbo0yHQAjwvp0lQNsICeu+cMBU7PpbD1tn7ltLqdRMuaXo69ayJ
         hKcB5meML4awt66h7oX0OgMARkqHoPr76z5ch4UtcllKCW1Zgy+NXGdgTSfZowFLCfFI
         ZSIKC9ktL/ddceCz6m25B3eZpOR7HhyEBnt1tZmAfKOAk3xHvA8GvPBK+sjwwPs6kvJX
         OCBoPKG608FjwEDZn59JhhR8/oyG1praX41izhWO2bzLUIMZIYb37vaihS2VqE392TiT
         gIs9HQvUrqUZaKk1W0GYZ3Gr38VZbYvblaDljdOpyIdBU01Uc8bQjwKmj2Pe2segDZ7a
         bGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690802459; x=1691407259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbS8Qlfzn1Dgn19TT0BgR1SE8o6tzPgDzghenWvydYU=;
        b=hB/bPrememDDZgFkUQiJvdrvm+KAcKvXFKbJ8RamjicLfcEZVjnio/XTP0DGi+JsFd
         3wk978d7ja4Ovk5ahFmFjDfop/fG7iDoDvFouNrbyjj2PfQxsm0fQAsg4qCOobsPnjJM
         VTRJuu+6QrahIthiojM6RumjWuZ95FGcPSiOGI71BBqy30Jod3aGfb7LXmHsGW3z+PhB
         X8xjNpzJBdlXs4vpHBV+bBCFgEeHJeyKNWgKt7PYsjF7JAcrb30+mSIQgu/svHTB7NPP
         VS+UoxVmcYlC6zXc3cVkV2LVx66peIsNevyyiurUbeRE3nUNQDrKyRsqVtp0Un2IQH1W
         pteQ==
X-Gm-Message-State: ABy/qLZUvthxFh53K5UWBXVIRdyoaGQDu6jFeyX7o4ZJFPkAFWXn6yzk
        ikQfAHV3h9phandXA7Fo1Jqi+kBCqJ7c6A==
X-Google-Smtp-Source: APBJJlHv2G80hlFmeMpv+4Stl2gbXUp1TxFjAU/Su1Dbul/HlEpmoIKIGA+9ssxjhFXnsCAIJQx4lA==
X-Received: by 2002:a17:902:c407:b0:1bb:dbec:40ba with SMTP id k7-20020a170902c40700b001bbdbec40bamr12244217plk.16.1690802458589;
        Mon, 31 Jul 2023 04:20:58 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902cf4600b001b8c6890623sm8382932plg.7.2023.07.31.04.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 04:20:58 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 2B5F380001D5; Mon, 31 Jul 2023 18:20:53 +0700 (WIB)
Date:   Mon, 31 Jul 2023 18:20:53 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     "Dr. Greg" <greg@enjellic.com>, paul@paul-moore.com
Cc:     linux-security-module@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: TSEM feedback.
Message-ID: <ZMeZFRz/lH8Uz2mX@debian.me>
References: <20230731103822.GA4093@wind.enjellic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8e9Ag2A/xFjBJvzI"
Content-Disposition: inline
In-Reply-To: <20230731103822.GA4093@wind.enjellic.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8e9Ag2A/xFjBJvzI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2023 at 05:38:22AM -0500, Dr. Greg wrote:
> Good morning Paul, I hope this note finds your week starting well.
>=20
> We submitted the patches for the V2 release of TSEM three weeks ago.
>=20
> We received some feedback from Randy Dunlap on some documentations
> issues that we went on to address.
>=20
> Haven't heard any reflections from you.  Was just wondering if you
> were swamped or had possibly missed the submission?  We didn't include
> you as a copy on the notion that you didn't need two sets of patches
> landing in your inbox.
>=20
> You can find the series with the following lore link:
>=20
> https://lore.kernel.org/linux-security-module/20230710102319.19716-1-greg=
@enjellic.com/T/#t
>=20
> Will look forward to any reflections you might have.

OK, please reroll with all reviews addressed.

As for the documentation, it seems that you missed Cc'ing
linux-doc@vger.kernel.org list, hence I didn't see your series. In any case,
run ``scripts/get_maintainer.pl`` to find maintainers, potential reviewers,
and lists that should have received your patch (series).

Last but not least, it'd been great if you can also link to public Git
repo containing your series (you already have the repo locally when
developing the series, right?), so I can simply ``git pull`` when about
to review yours.

See you in v2!

--=20
An old man doll... just what I always wanted! - Clara

--8e9Ag2A/xFjBJvzI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZMeZDwAKCRD2uYlJVVFO
o5G2AP44MMyRCB5jI3G18XNUpGnaFZJZ+ZByyOHDT8GlgPHXiQD+LC+N301nHZ9d
ssPqQozSwvnWKLLtcfOQ0u00wFgV8w4=
=I09p
-----END PGP SIGNATURE-----

--8e9Ag2A/xFjBJvzI--
