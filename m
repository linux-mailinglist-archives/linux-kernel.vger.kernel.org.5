Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CBC77C4FE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbjHOBUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjHOBUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:20:05 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8781723;
        Mon, 14 Aug 2023 18:20:03 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686bc261111so3363128b3a.3;
        Mon, 14 Aug 2023 18:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692062403; x=1692667203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=50kNZu8aE9KP4TudZVTqOVOHGwRE3VIGmubW18jTrUQ=;
        b=IrgbaCf+o6oj+RCfd/u4cnr3AMHuE08gbErfDEr8HVZYFbmwmRGgWocx4wxWG+DOtU
         u9PWmkhUyYgatFM1duyiKagcDKkYV2XygkEdheuZkP5YsWTAuA0wKCnVPd0WiB4tF12n
         LVsOnczPj9xiT8mDOeY08hv8H/ltcI9ItTxPndz4ELhCAeUClazuj2LQt9Wwo0iLgRt2
         EVyOmWy13kZ/TeRfQx+xMat7BpWejTUBfbEkpQFDyV10EQPSoGJtVeTw08jXFJY1j7Dk
         +mcHb3xeiaI3KYDpPiFNbTUfHB4gtkPlwbK6JvRfs0oVFpc3TBT8HmE07+NwY/LrZpYx
         +pKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692062403; x=1692667203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50kNZu8aE9KP4TudZVTqOVOHGwRE3VIGmubW18jTrUQ=;
        b=YFB+fdGNlxI4o/xvfPMMyZSPRzrL5zYYA85+Ail4u/j5+tL9G1EbUG/jWRMlO3HY0f
         t4VE4JM7+V9+DtaTKevEzRWTmzvQCe9dXqjY9k9KOaq4GLGwrYeiiVLup5vyHyo+f+LW
         TnXh4nbfoOMRYrBp6gs48l2fn2jPcnLvltCeLRf2TGwKANihPfPMta7e/QXpDYvKJSs8
         n7c0O1RmUnfXcFkhqNhdmvcQ9twMTG55dJvMjkZWYSwY0cc4ljXESIhPd0HSyyMzwP4R
         kQd3tCVQqeFbdqAABwjbF9ItN+QqB6v7SU+Xq1m+b20oesEJJgM4PjtVrM4X4Uq5Lqpz
         G5fQ==
X-Gm-Message-State: AOJu0YxH9G4qwiP23belPcwabDvUtnBbAbP4m1Yqsqro/l5gnRtM9sic
        dCmiPlgaqZRUQaDOLGH1icuOHNrBgjE=
X-Google-Smtp-Source: AGHT+IHxS0i5N6XHm2dT7e7NgwDDvGaOtG+i4GcYE8loK1y5XQS7S3aKZ6l+kYkD1dfbLK/CTCl0KA==
X-Received: by 2002:a05:6a20:3d0d:b0:133:be9d:a8d3 with SMTP id y13-20020a056a203d0d00b00133be9da8d3mr13278551pzi.14.1692062403149;
        Mon, 14 Aug 2023 18:20:03 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id jh15-20020a170903328f00b001bde77f3d0esm2506247plb.117.2023.08.14.18.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 18:20:02 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id BB45581A2F0A; Tue, 15 Aug 2023 08:20:00 +0700 (WIB)
Date:   Tue, 15 Aug 2023 08:20:00 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Leslie Rhorer <lesrhorer@att.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Ariel Elior <aelior@marvell.com>
Subject: Re: Failing network hardware
Message-ID: <ZNrSwBqP1vPW8OKz@debian.me>
References: <ddbed5c6-4ded-df22-fae0-bd256e40d6b3.ref@att.net>
 <ddbed5c6-4ded-df22-fae0-bd256e40d6b3@att.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Dy7BoKZkUw2j6BHX"
Content-Disposition: inline
In-Reply-To: <ddbed5c6-4ded-df22-fae0-bd256e40d6b3@att.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dy7BoKZkUw2j6BHX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(fixing up netdev address)

On Sun, Aug 13, 2023 at 01:53:58PM -0500, Leslie Rhorer wrote:
> Hello all,
>=20
> 	About a year or so ago, I upgraded one of my Debian servers to Bullseye,
> and it killed the 10G NIC on the server due to issues with the device dri=
ver
> in the Debian repository (it was missing).  I jumped through all sorts of
> loops and hoops to try to get it working, but I finally had to give up and
> resort to using the 1G interface.  Recently, I tried a new install on a
> different server to the new Debian Bookworm, and it worked for that serve=
r,
> so apparently the issue has been fixed in Bookworm.  I reported a bug
> against the Buster distribution, but it was never fixed.
>=20
> 	With that in mind, I went ahead and upgraded the original server to
> Bookworm, but the NIC remains dead.  Unfortunately, I cannot find my notes
> on what I did originally to try to get the 10G interface working and to s=
hut
> it down in favor of a built-in port.  I do recall I tried compiling what =
was
> supposed to be the correct firmware driver and also changing the udev rul=
es,
> but I do not recall the exact details.  I have tried several things,
> including re-installing the firmware, but nothing seems to work.  The
> Ethernet interface does not appear on the system in order to be able to
> specify it in /etc/network/interfaces.  What can I do in order to try to =
get
> the 10G card working?
>=20
> 	The card is an Asus MCB-10G_PEB-10G NIC and uses the bnx2x.ko driver. The
> system uses an Asus AMD-64 motherboard.  The bnx2x.ko driver is installed,
> and lspci shows the card in the system, but ifconfig does not see the
> interface.
>=20

Too many moving parts here, hence allow me to rule things out:

If there is any of your system haven't been dist-upgraded to bookworm, can =
you
confirm this issue on vanilla v6.1 kernel? And also, can you check latest
mainline? If all have been upgraded, though, you need to reinstall bullseye
first.

As a side note, when you reply to mailing lists, please don't top-post;
reply inline with appropriate context instead.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--Dy7BoKZkUw2j6BHX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZNrSwAAKCRD2uYlJVVFO
ow6/AP4vueGUbpcCqCnpTwf4tvmv06d0rMEHk5d7Uc303mCl0AD+O49Z5fOrIroT
3RqT4tSWg1iL5M+K+xYMq7cHnVcXhQc=
=VNFs
-----END PGP SIGNATURE-----

--Dy7BoKZkUw2j6BHX--
