Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1EB7E2431
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjKFNTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjKFNTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:19:16 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A18394;
        Mon,  6 Nov 2023 05:19:14 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b2018a11efso4598203b3a.0;
        Mon, 06 Nov 2023 05:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699276754; x=1699881554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=chBp0c2H1AOjgpm073E/0LSCNHycI9DtFBsa1gzati8=;
        b=SEr3Of3RGXMLwBoAgJ3DYl1yRA1Ee6Vqt9BiTHL4vLIDntPgqcdJuQ9OcXTqD0hgzp
         KbG1UBtV6d/h+JSG0F2LLnoay83krMwedPQ6abhYVzOjr8yNbweVSTKRxQ6PqKMYfUoR
         avUmrFAI3fpevv+dDzqdGj9LDIsI6eJePEQxEFPhnPNF2jhJUOCDOX3cMGAOxLNk7h3y
         XH9twf2lX3l4mQ02HVWLX1fF5IIkIPdIH+wa1T++yboS4S3ZgHWZ8B1JJOqLBJElO0+t
         gy4Paw9rqKFwRdExPu9+fMGqbmKO2ktpWB5TGZv5Lxa1nsOT5jvSVsgW3gSwkxBe/dqV
         ZvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699276754; x=1699881554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chBp0c2H1AOjgpm073E/0LSCNHycI9DtFBsa1gzati8=;
        b=tsrHe2c45AcJ+kHrDbvqrhIMKaTcJVdRSzDO8Yz0f7mRDLOFVOiTSsTMMc31zERR5m
         KLInyoY21kHgNWnRaTnrvZMzRR5dC1FtVAw2amns0FamYMMv0W88j82VBkgExODWFmcu
         QSRr3cWbG1hb2L66FR7/m4mpx9xBwsEnksdrD2DqbmvzsgC4+Un/xWDpJLNlZj6/7n+/
         CYPSFdbsM+K/QQPHV6SkQeBvQABFVUzI+HTOOPE/dnj4fVT1+vH8LZRNvejyfPSZjEMj
         4PXfzgLCsPkpps/LZVRDMWWfQOo74bQRf6pqz6lpBU3FjgSlnkISJkr/KJ6n0Cmq11gA
         OHHA==
X-Gm-Message-State: AOJu0Yy6S2pCVze+Im5ZM/G+tNhSX/tXGMrk+b8mtHJdeB6EDsKzuzzR
        hqjATrgTM7XYdOz2h83CAGo=
X-Google-Smtp-Source: AGHT+IHUQ6Z7qSYKU+hBoeLA+kbz9hl5AQRtQpiHAX90PUW/NvlibvuwgpYKImASI5xzCqd+qJkj/w==
X-Received: by 2002:a05:6a21:6da2:b0:17e:2afd:407b with SMTP id wl34-20020a056a216da200b0017e2afd407bmr38264150pzb.9.1699276753788;
        Mon, 06 Nov 2023 05:19:13 -0800 (PST)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id 13-20020a17090a004d00b0027782f611d1sm6096806pjb.36.2023.11.06.05.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 05:19:13 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id EB878815BAB0; Mon,  6 Nov 2023 20:19:08 +0700 (WIB)
Date:   Mon, 6 Nov 2023 20:19:08 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux LEDs <linux-leds@vger.kernel.org>
Cc:     Tim Crawford <tcrawford@system76.com>,
        Jeremy Soller <jeremy@system76.com>,
        System76 Product Development <productdev@system76.com>,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Johannes =?utf-8?Q?Pen=C3=9Fel?= <johannes.penssel@gmail.com>
Subject: Re: Fwd: sysfs: cannot create duplicate filename
 .../system76_acpi::kbd_backlight/color
Message-ID: <ZUjnzB2RL2iLzIQG@debian.me>
References: <b5646db3-acff-45aa-baef-df3f660486fb@gmail.com>
 <ZT25-gUmLl8MPk93@debian.me>
 <dc6264c4-d551-4913-a51b-72c22217f15a@traphandler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mLSYxFe79vSgKXQn"
Content-Disposition: inline
In-Reply-To: <dc6264c4-d551-4913-a51b-72c22217f15a@traphandler.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mLSYxFe79vSgKXQn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 04, 2023 at 01:01:56PM +0100, Jean-Jacques Hiblot wrote:
>=20
>=20
> On 29/10/2023 02:48, Bagas Sanjaya wrote:
> > On Thu, Oct 26, 2023 at 02:55:06PM +0700, Bagas Sanjaya wrote:
> > > The culprit seems to be commit c7d80059b086c4986cd994a1973ec7a5d75f8e=
ea, which introduces a new 'color' attribute for led sysfs class devices. T=
he problem is that the system76-acpi platform driver tries to create the ex=
act same sysfs attribute itself for the system76_acpi::kbd_backlight device=
, leading to the conflict. For testing purposes, I've just rebuilt the kern=
el with the system76-apci color attribute renamed to kb_color, and that fix=
es the issue.
> >=20
> > Jean-Jacques Hiblot, would you like to take a look on this regression,
> > since you authored the culprit?
> Hi,
>=20
> The offending commit stores the color in struct led_classdev and exposes =
it
> via sysfs. It was part of a series that create a RGB leds from multiple
> single-color LEDs. for this series, we need the color information but we
> don't really need to expose it it via sysfs. In order to fix the issue, we
> can remove the 'color' attribute from the sysfs.
>=20

OK, see you in the patch!

--=20
An old man doll... just what I always wanted! - Clara

--mLSYxFe79vSgKXQn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZUjnyAAKCRD2uYlJVVFO
o00MAP46Ar3NgVvRankXk1V4h3zoLCr89KoQ1Lfibtd5doJaUQD/cn2uxDs4aSlz
/9jB4eJEcHBWxonDhaWcpvJGoxYoRgw=
=lEvF
-----END PGP SIGNATURE-----

--mLSYxFe79vSgKXQn--
