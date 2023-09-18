Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8B07A430A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240318AbjIRHm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240093AbjIRHl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:41:59 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8723CCED
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 00:40:22 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68fc081cd46so3600137b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 00:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695022822; x=1695627622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jYE1PmwGI48qu45rnC2t2CT34fWKqdW5IxOG5V0vDZU=;
        b=RtURKfTL8LN/X/1FkLXIXRHC4UJNbu4HWW2bfCPcCFVPWBKmVkiWyRKjPvsQYw5Pj7
         rHxywoV5fOViTKIBc4lGxuN761jzxNJ35+WpdfUnZ74ah50ndoCN63d8vcCxBSpPnttx
         0I90z5YkRpu6erIEiOXDRHy3hbiaa9H664FsFx3YyH1ma3qSM5P8gIRUSswDzANtwjOL
         +WvybJreZ0P1o0QKfZiocxFG8bzG9AuU+OOYwPloNTPHgK3AMr1YMxWC88U0q2n+MLb/
         a7LHRgNRdzlYPgvq4anFlKE3+TKlBVGT3h4wmLbG3EbffQVdSua1VGxsTorXDRHrXMV9
         4VMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695022822; x=1695627622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYE1PmwGI48qu45rnC2t2CT34fWKqdW5IxOG5V0vDZU=;
        b=xKj5+eWdgS58QB529UwkXnQFn+AUCcJQDy6+gx1FnDaKHbdRpw0TOWQdLdnhKDE1nm
         GfluFb5gAyPBiPeqgkPlmm7LmB3hV0C2O8fTQNTyTSruCXeooCmCt6TJqfubJ9htpRd+
         xa0EFiWxc97PIvSYxd+Ik0aG1YR1Ff0zIad0T1PNY+mVHauU177p2wo/fBVS7GpI3KxV
         jAM8UQT5kNIlkJgHap3S5CFuasAq0YbDPEWWTZzwNPxTa7eJmnQuogZ4ew5upkxq7ZYg
         rVexOiOQu0aPl6pgKA/pTKOL1bakv42LVeytVg0kmIg1x0+5wkLFUlG7iQzdVvPdzWQ1
         gmWw==
X-Gm-Message-State: AOJu0YyS0jEWvjf0fZrOc4QQ8GYanmqZBmXjvN64CCBQTUxWxb0SFE3+
        Hi2+mnthnggSLII6Nol/90E=
X-Google-Smtp-Source: AGHT+IFBY9iVIRBuVg6dN+6n28kVZBaQ3QpU3pvyd80I1f86lsgh4AzZzEITsYThn6COBiwc+ysWdg==
X-Received: by 2002:a05:6a21:3e0b:b0:156:e1ce:d4a1 with SMTP id bk11-20020a056a213e0b00b00156e1ced4a1mr6476863pzc.9.1695022821893;
        Mon, 18 Sep 2023 00:40:21 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id k7-20020aa792c7000000b0068be3489b0dsm6827221pfa.172.2023.09.18.00.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 00:40:21 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 941E480D9E27; Mon, 18 Sep 2023 14:40:18 +0700 (WIB)
Date:   Mon, 18 Sep 2023 14:40:18 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jaak Ristioja <jaak@ristioja.ee>, dri-devel@lists.freedesktop.org
Cc:     Huacai Chen <chenhuacai@kernel.org>, javierm@redhat.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: Blank screen on boot of Linux 6.5 and later on Lenovo ThinkPad
 L570
Message-ID: <ZQf-4r1K1Dx_LQ5t@debian.me>
References: <7c50e051-eba2-09fc-da9f-023d592de457@ristioja.ee>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t9fjxRqYgtt2EzW7"
Content-Disposition: inline
In-Reply-To: <7c50e051-eba2-09fc-da9f-023d592de457@ristioja.ee>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t9fjxRqYgtt2EzW7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 03:02:26PM +0300, Jaak Ristioja wrote:
> Hello,
>=20
> Upgrading to Linux 6.5 on a Lenovo ThinkPad L570 (Integrated Intel HD
> Graphics 620 (rev 02), Intel(R) Core(TM) i7-7500U) results in a blank scr=
een
> after boot until the display manager starts... if it does start at all.
> Using the nomodeset kernel parameter seems to be a workaround.
>=20
> I've bisected this to commit 60aebc9559492cea6a9625f514a8041717e3a2e4
> ("drivers/firmware: Move sysfb_init() from device_initcall to
> subsys_initcall_sync").
>=20

Thanks for the regression report. I'm adding it to regzbot:

#regzbot ^introduced: 60aebc9559492c

--=20
An old man doll... just what I always wanted! - Clara

--t9fjxRqYgtt2EzW7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQf+4QAKCRD2uYlJVVFO
o1LjAQCyinSeRmWO5M3jxuESwFV9c/eJAgHm+YsA35cHfR8mBwEAsDAhYG4Bnm8h
/2YyuCaC0lYoTEIdf+2AEN/OKWxH9QA=
=hSUf
-----END PGP SIGNATURE-----

--t9fjxRqYgtt2EzW7--
