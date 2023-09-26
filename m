Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DFF7AE323
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 02:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjIZAzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 20:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjIZAzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 20:55:12 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2115109;
        Mon, 25 Sep 2023 17:55:04 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3ab7fb1172cso3878206b6e.3;
        Mon, 25 Sep 2023 17:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695689704; x=1696294504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0CXYLwtV6hI1Lwk84mbKyAHp+fTnm6/oOKkcYYEM0gg=;
        b=Pl93fit2efnmI0rMGnBC4h3iPQHzM+wTmmWMZE2YpoEVRyslEA9fJVeuOgprO/zAoy
         Sp9F9tTkVnVBtQ//mBGkOunMPk1OsS4DlLGx/sj6Am2WJBG9aBt77rpuiac9x3gqc3av
         bLdkYENL6ejDG3szumTaMTYt9BY56VpU2Gg8jsA2/JQHuCLQz466Dd/ulsModuRxRcqf
         EQgylGbFrYg5MKY4sEZx33TpXHWmVGywqWGrztgdcC03ngi8ZD2l2FySQFDf8k7gEVMl
         JBsJGcEe6kpq2qqNMwPTFik0H/MKBPq7HRmohWLq/qR0Lls0oi397bbcMzf0yyH/fzLY
         bWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695689704; x=1696294504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CXYLwtV6hI1Lwk84mbKyAHp+fTnm6/oOKkcYYEM0gg=;
        b=ip17vbM+A+lwmzmxKytckMNh5IA5uKcMVMVZSHvR0jWk8f1T8LrbqwsJdEjuFZVhlU
         cC1sJ35kSzDNB79nOR4TlfeIkd+PIrtteB2WQ2tjLr2svan9XtvRfHdBazMqGcMjtIEO
         3JdExhduLGkSthw1tt9ejgSrzC3wSvYDjQnXO+VWxqRA6PYx1v0Av89bj0D6VwQSUfjQ
         GVwRSrBmc7XjChBMssd5XyXvXyZ2ufiVsuhG0zQ4oh/FfbCf3bMwIaXjXQw8Ut2svzxY
         Xn09JrYP98hEtuyZh1xsZ6/qYOgKSaL1bNmbYjCR8jR4FZIPmhXQpvW2ucIS72j9b1Qp
         IhJA==
X-Gm-Message-State: AOJu0YyIMSG1Fh3pGzX2j5sL6VT8N3aMYHtO4E/FFy3+I7OWsiU8zvTy
        Tmwb6Q0MIuFKWOcKnJ7VXeg=
X-Google-Smtp-Source: AGHT+IGRPQKNCawBo+MIk51/Ou91oPvmW1z8tu8Kdu8Tn3tbO1vseAeAhM3xQggtwn7ms17BTXXKuA==
X-Received: by 2002:a05:6808:1a88:b0:3ae:e0d:1548 with SMTP id bm8-20020a0568081a8800b003ae0e0d1548mr7579294oib.15.1695689704020;
        Mon, 25 Sep 2023 17:55:04 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id h5-20020aa786c5000000b006889511ab14sm8654484pfo.37.2023.09.25.17.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 17:55:03 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id ABC7B8DABD81; Tue, 26 Sep 2023 07:55:00 +0700 (WIB)
Date:   Tue, 26 Sep 2023 07:55:00 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Verot <verot.wrongdoer713@simplelogin.com>
Cc:     Linux Input Devices <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Stable <stable@vger.kernel.org>
Subject: Re: Fwd: Kernel 6.4.4 breaks Elan Touchpad 1206
Message-ID: <ZRIr5E2FAFVqhtmw@debian.me>
References: <42bc8e02-5ee0-f1c8-610e-e16391e54ee2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H68YQ2lTD34t8/zF"
Content-Disposition: inline
In-Reply-To: <42bc8e02-5ee0-f1c8-610e-e16391e54ee2@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H68YQ2lTD34t8/zF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 07:00:21AM +0700, Bagas Sanjaya wrote:
> Hi,
>=20
> I notice a regression report on Bugzilla [1]. Quoting from it:
>=20
> > Description:
> > When booting into Linux 6.4.4, system no longer recognizes touchpad inp=
ut (confirmed with xinput). On the lts release, 6.1.39, the input is still =
recognized.
> >=20
> > Additional info:
> > * package version(s): Linux 6.4.4, 6.1.39
> > * Device: ELAN1206:00 04F3:30F1 Touchpad
> >=20
> > Steps to reproduce:
> > - Install 6.4.4 with Elan Touchpad 1206
> > - Reboot
> >=20
> > The issue might be related to bisected commit id: 7b63a88bb62ba2ddf5fcd=
956be85fe46624628b9
> > This is the only recent commit related to Elantech drivers I've noticed=
 that may have broken the input.
>=20
> See Bugzilla for the full thread:
>=20
> To the reporter (Verot): Can you attach dmesg and lspci output?
>=20
> Anyway, I'm adding this regression to be tracked by regzbot:
>=20
> #regzbot introduced: 7b63a88bb62ba2 https://bugzilla.kernel.org/show_bug.=
cgi?id=3D217701
> #regzbot title: OOB protocol access fix breaks Elan Touchpad 1206
>=20
> Thanks.
>=20
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D217701
>=20

No reply from the reporter in regards to required bisection, thus:

#regzbot inconclusive: not bisected, reporter MIA

Sorry for inconvenience.

--=20
An old man doll... just what I always wanted! - Clara

--H68YQ2lTD34t8/zF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZRIr5AAKCRD2uYlJVVFO
o+6iAP98gFN37T7GtXeidZpgcd13kL448gj8ctLYAeJCo5rDLgEA4SxE9qTuQslN
rHvLTpJT8v9HsUWYqm0ApWfaI4nE9QA=
=7F3z
-----END PGP SIGNATURE-----

--H68YQ2lTD34t8/zF--
