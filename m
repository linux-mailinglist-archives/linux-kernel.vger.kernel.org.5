Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F1B7EC34E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343880AbjKONJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343870AbjKONI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:08:58 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B49124;
        Wed, 15 Nov 2023 05:08:54 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-35ab17957c3so15695645ab.3;
        Wed, 15 Nov 2023 05:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700053733; x=1700658533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2G7KKhFVeQmxaFRbIzLkNzcWPuqBCIhAsSh4RiIuT1I=;
        b=XcdegPU2vS0dbeCT/5rfm3C3hqLI0VmMGf/71SbmjxfBWgOR2myRVvupLUzqWgJ1h5
         S1bgNWyc0ZJfWqK8QV3BzsUgvQZ2Rvjb0nJM3/ImfuUnGwYREjbsEf2xO/DN0ZUz2cib
         7ccvnbqSU3D36uhZIs1wnu5bzQtFKDjYB7qFGCu++F2oCwsQEuEw9LAWvWpj1TcmMYKO
         HHYP7fl6LoVHcv2K9EvZfVwGHa8ssFhs8w9JiB96os5dubomAxuKV2Hqv7g9KOD5RXtG
         MXU78gq3C5ffEfjTZB2BbyE0bsKrGVssN+INQ51g00mPSs4o7KdxsSvD23oLs2djbre9
         zdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700053733; x=1700658533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2G7KKhFVeQmxaFRbIzLkNzcWPuqBCIhAsSh4RiIuT1I=;
        b=ApDYteb+dzeAi+EoQ5Nql8+NLOx5O83qeQf6Ut8sH62tEiA1nRNgnyYrp4UsDndW2k
         X4LFK5WnFsrXpLM5MQPdcdfRXSod5bIXn9PvrUULmiRyM4Fbqjl+5xI3mxM4JESPqPrW
         IPZ41Bs9NHi6htTFCGY90ZXQHRmkEbbFPW+V9hdNnFCDnx62H5EJ934CJG43uKmFuwY+
         0MDwO1Q8WjMYGrIPdF6S+VY/5MLA9rWrnQIDZeEZvismHO0LngbxEsLDzgL5y86sSA/0
         5fhW6B540487OmE/LYwX+gIGscn2LNQkZS3fbhjsO9jkL/b8ve1wUYTmFBycHAhGJL9T
         KmOg==
X-Gm-Message-State: AOJu0YwDvUc05Jw8lk3HcuuYdMIjuuYflnL7kh4KuaM9PWfTMg6/3UwA
        PYfcN6WO6y4ghePCSirFD4k=
X-Google-Smtp-Source: AGHT+IGncX9Sp484saKBYPhrt6VsYQAv9Vd4w8EynNKUe9Jg4dSABTLWDpVC1bdKnnXmLG7qErBq7w==
X-Received: by 2002:a05:6e02:1d1e:b0:351:5acb:281 with SMTP id i30-20020a056e021d1e00b003515acb0281mr16123680ila.31.1700053733533;
        Wed, 15 Nov 2023 05:08:53 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id g2-20020a63fa42000000b005af08f65227sm1161196pgk.80.2023.11.15.05.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 05:08:53 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 8D3D210D2CF4C; Wed, 15 Nov 2023 20:08:49 +0700 (WIB)
Date:   Wed, 15 Nov 2023 20:08:49 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Anil Choudhary <anilchabba@gmail.com>,
        Linux Regressions <regressions@lists.linux.dev>
Cc:     Jay Vosburgh <jay.vosburgh@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
        Andy Gospodarek <andy@greyhouse.net>,
        Ivan Vecera <ivecera@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: sr-iov related bonding regression (two regressions in one report)
Message-ID: <ZVTC4WYHVdXpMlGj@archie.me>
References: <986716ed-f898-4a02-a8f6-94f85b355a05@gmail.com>
 <32716.1700009673@famine>
 <0f97acf9-012d-4bb2-a766-0c2737e32b2c@leemhuis.info>
 <EFC5ADF4-1EE4-4900-B250-AC35656DC68B@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gSEusbUJJj55spLS"
Content-Disposition: inline
In-Reply-To: <EFC5ADF4-1EE4-4900-B250-AC35656DC68B@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gSEusbUJJj55spLS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 10:13:20PM -0800, Anil Choudhary wrote:
> Its not hardware issue when I do rmmod iavf ping started working .
> So issue is certainly in this kernel and with sriov only
> Iavf id Nic driver for VF(sriovnic)
>=20
>=20

Please don't top-post; reply inline with appropriate context instead.

So you have this regression on vanilla kernel, right? If so, please
bisect (see Documentation/admin-guide/bug-bisect.rst in the kernel
sources for reference).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--gSEusbUJJj55spLS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZVTC4QAKCRD2uYlJVVFO
ozl7AQCiSqoKyASKox740kkcu7j+siyKKyJXruoehKgsCPd1LAEA26VtD2CPSqwh
y4FW2w4+L9KPEdjbyzmPH47DduTREgc=
=YJK6
-----END PGP SIGNATURE-----

--gSEusbUJJj55spLS--
