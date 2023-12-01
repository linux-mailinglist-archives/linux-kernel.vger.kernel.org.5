Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A838003DB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 07:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377619AbjLAG1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 01:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjLAG1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 01:27:37 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668B11711;
        Thu, 30 Nov 2023 22:27:43 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5c2066accc5so158165a12.3;
        Thu, 30 Nov 2023 22:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701412063; x=1702016863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ESF0WGIvBwlg+QIjn5rf5uGixR8rngjLyzks6l1dy0=;
        b=SSPl4WBNvgfued4z9mTN1CC/igO2uNNxpdsz0HQ5W9OdYu1f1WzankDYAHxxFcdO7K
         iKARFixy9KDwJxSVSiab//wHsqBOFH2EwIhRREes71lXO4cO57etV/4OMHqB3WwsahNF
         Sjho6oGBF6T06SqvggpT1pXxdblOCbUw9DXcSaULmQ+1v/wkOpmnadP8LxId1C4KJGMW
         Dqh0/YgV3S2uoRjZeBFXz4BTHF+ini2gLoBZI78HFqSS0/h3F9+lwgOLBt3tPyhHjNmR
         YK6dL79nJe8jgB7PMrNaObzMg8+EQ9K4g0lp7q+0dc8mbrbX5A4g04W5APHneZs+WOKF
         5TpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701412063; x=1702016863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ESF0WGIvBwlg+QIjn5rf5uGixR8rngjLyzks6l1dy0=;
        b=uC3dT5L4oYIgXgi+bS6s+TbOGIlr4sRJuB1MLdM8a0jBKn173a+ZylkNQVjnrAZKiv
         NEisi9bh4msK0YfQOO9oLwiysCL1Xxzdc6cSZmh9Ib0/jwOjk6v4JQrjXoz/2Pt4dhj4
         A5NDAq9XbyrIMOM+LfPYzLJdcM1MqnEj9FpCSLDXsGEMbZvSAmy618pXYE5RX1tolgUS
         8LRV+mSGqbsgUjLqFBbXUSt1gIXZyPWgNBYJ7O3miD+eNQPygusxMT/4rLtDI0niE9T2
         4R5xhYQnDRxVDOCvUMmBMfeNlvc3YtLIMwp7ZUqv5g3c3qqRQfJBHnDhhJ8/aP/qN8yo
         AG+A==
X-Gm-Message-State: AOJu0YzsekgRJCjhSZi6jh3EQ17qPF5yiejcMASgMZCWxUrO2BHk9d/k
        GtYyA9B0+qr8QY++fUl1wk0=
X-Google-Smtp-Source: AGHT+IH1t/sI5mhFPWgD7BUVhhtOgDTivetXMTKcDV6qoGS7+icHd6hR+uzTWE2vZ0rrttlwwl9n7Q==
X-Received: by 2002:a05:6a21:184:b0:18b:b04e:6c30 with SMTP id le4-20020a056a21018400b0018bb04e6c30mr27871289pzb.20.1701412062773;
        Thu, 30 Nov 2023 22:27:42 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902db0a00b001cfb971edf2sm2489807plx.13.2023.11.30.22.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 22:27:41 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id BA3101020714A; Fri,  1 Dec 2023 13:27:38 +0700 (WIB)
Date:   Fri, 1 Dec 2023 13:27:38 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Zach <zacheryvig@outlook.com>
Subject: Re: Regression: Inoperative bluetooth, Intel chipset, mainline
 kernel 6.6.2+
Message-ID: <ZWl82n695TIC7nUO@archie.me>
References: <ee109942-ef8e-45b9-8cb9-a98a787fe094@moonlit-rail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XIaTc4XC+xM4WNYd"
Content-Disposition: inline
In-Reply-To: <ee109942-ef8e-45b9-8cb9-a98a787fe094@moonlit-rail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XIaTc4XC+xM4WNYd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[also Cc: original Bugzilla reporter]

On Thu, Nov 30, 2023 at 08:54:09PM -0500, Kris Karas (Bug Reporting) wrote:
> Greetings -
>=20
> With mainline kernel 6.6.2+ (and 6.1.63, etc), bluetooth is inoperative
> (reports "opcode 0x0c03 failed") on my motherboard's bluetooth adapter
> (Intel chipset).  Details below.
>=20
> I reported this in a comment tacked onto bugzilla #218142, but got no
> response, so posting here as a possibly new issue.
>=20
> Details, original email:
> ----------------------------------------------------------------------
> I have a regression going from mainline kernel 6.1.62 to 6.1.63, and also
> from kernel 6.6.1 to 6.6.2; I can bisect if patch authors can't locate the
> relevant commit.  In the most recent kernels mentioned, bluetooth won't
> function.

Then please do bisection; without it, nobody will look into this properly.

>=20
> Hardware: ASRock "X470 Taichi" motherboard - on board chipset.
> lsusb: ID 8087:0aa7 Intel Corp. Wireless-AC 3168 Bluetooth.
> dmesg: Bluetooth: hci0: Legacy ROM 2.x revision 5.0 build 25 week 20 2015
>        Bluetooth: hci0: Intel Bluetooth firmware file:
>          intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
>        Bluetooth: hci0: Intel BT fw patch 0x43 completed & activated
> bluez: Version 5.70, bluez firmware version 1.2
> Linux kernel firmware: 20231117_7124ce3
>=20
> On a working kernel (such as 6.6.1), in addition to the dmesg output abov=
e,
> we have this:
> dmesg: Bluetooth: MGMT ver 1.22
>        Bluetooth: hci0: Bad flag given (0x1) vs supported (0x0)
>=20
> On a failed kernel (such as 6.6.2), instead of the good output above, we
> have:
> dmesg: Bluetooth: hci0: Opcode 0x0c03 failed: -110
>        Bluetooth: hci0: Opcode 0x0c03 failed: -110
>        ...
> repeats several times as bluez attempts to communicate with hci0.
> ----------------------------------------------------------------------
>=20
> Since that email was sent, kernel firmware has been updated to
> 20231128_aae6052, and kernels 6.1.64 and 6.6.3 have been tried with no
> change observed.
>=20

You may also want to check current mainline (v6.7-rc3) to see if this
regression have already been fixed.

Anyway, thanks for the regression report. I'm adding it to regzbot
for tracking (as stable-specific regression for now):

#regzbot ^introduced: v6.6.1..v6.6.2
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218142

--=20
An old man doll... just what I always wanted! - Clara

--XIaTc4XC+xM4WNYd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWl81gAKCRD2uYlJVVFO
o454AP9MIcXq6/Q/cKXeCDwHBfao9jagKweZrpopNuQY+UfePAEA0sf9qtm8qbGy
RWIZlhLIdsRwjsQSnLbWDpdspnusXAw=
=/aU9
-----END PGP SIGNATURE-----

--XIaTc4XC+xM4WNYd--
