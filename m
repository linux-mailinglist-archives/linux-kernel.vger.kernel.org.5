Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814937B5DD5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 01:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236823AbjJBXrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 19:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjJBXrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 19:47:08 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DDA83;
        Mon,  2 Oct 2023 16:47:05 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-578b4997decso186005a12.0;
        Mon, 02 Oct 2023 16:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696290424; x=1696895224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MsrzhgDbcJtwYX/2EGwafIR0w5juOFXJIQAbPgvHjTw=;
        b=BNSzChieo1c8zE1ZESxP6nS9C1dZj3+U/zZh8dQO/EIFTc9BygTKvbStJ0QubiPjVO
         MZWdunWKvI50eGCFKxWO/kzTiIgioa2Wvfl8iyX7ufSxL4jBWnJ1LVwobMh+mdmqYnJS
         mwnxA9mr53RiVdpoYYty3GOx1Np5XmUmdxolIKcTSY0YK3k+y/6o3Ww8Zy+y87vcZ5Lp
         m2VluND9St5oi2ShkwZay6PHuKf1xw4GgEQ2TDTUsbPHvAD0vX7uSypyY5cBNKnSgduG
         V6gKz4eTlsoLe4RgB/Eh4afmlO4s++gODKpFK3Cf7ky3RCrtxPwsEDxXC8aATEP76W2a
         pWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696290424; x=1696895224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsrzhgDbcJtwYX/2EGwafIR0w5juOFXJIQAbPgvHjTw=;
        b=AX4NzU/c4tdYrJ2IXmVjY1O2HYoKhcwsQzv5AbyVARFMLS2+L7wbqI4UK4U2XOsNWR
         I421oAi5LuA0HGsyFOoYmtIaLqu3JN5uoQEvp4M0ShM2OD+RDcHivoTOZZaIYF18HQSl
         5zLsSjVGab/IyY27kyRLbZ3VC1AyV9A3X8B1DNIUg6rR5X3B/31qIDwCBj5fjBiJhsEG
         p/MUXqb1v162tvJuJ3hu4Q0SLub2IpaEP3Qh9lQgI4phDutbpOWmfyQK/kPb1ZyH8/S+
         fknZ/MAJNOCfZkpQ3oALsmh7044X5ZX+uCCflJUgp58orcoD0+7IL48JdxorSCYeysab
         7Bqg==
X-Gm-Message-State: AOJu0YypGlm7iznDNKlwe8PoNFF8hSEB8pbIUU8GU6v4y6IpIfNe/G+e
        XiBhjhwq4MzDhaTUPIzUK0Y=
X-Google-Smtp-Source: AGHT+IEBCTbSZM/8E/uKaeav4fYt2K5qKUh3CuUFJFJQXANJT3CbxyYRJqvtwNk3zj/OuJrUW2TzCQ==
X-Received: by 2002:a17:90b:1194:b0:269:32d2:5ac4 with SMTP id gk20-20020a17090b119400b0026932d25ac4mr13277538pjb.25.1696290424438;
        Mon, 02 Oct 2023 16:47:04 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id ft13-20020a17090b0f8d00b00276b60aa43bsm6884452pjb.17.2023.10.02.16.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 16:47:03 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 8117881A3121; Tue,  3 Oct 2023 06:46:58 +0700 (WIB)
Date:   Tue, 3 Oct 2023 06:46:58 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Erik =?utf-8?B?RG9iw6Fr?= <erik.dobak@gmail.com>,
        Linux Stable <stable@vger.kernel.org>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Mediatek <linux-mediatek@lists.infradead.org>,
        Linux Regressions <regressions@lists.linux.dev>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@nordicsemi.no>
Subject: Re: bluetooth issues since kernel 6.4 - not discovering other bt
 devices - /linux/drivers/bluetooth/btusb.c
Message-ID: <ZRtWcgiH5JhD5NU2@debian.me>
References: <CAH7-e5sb+kT_LRb1_y-c5JaFN0=KrrRT97otUPKzTCgzGsVdrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fW063juLwqeEFwfL"
Content-Disposition: inline
In-Reply-To: <CAH7-e5sb+kT_LRb1_y-c5JaFN0=KrrRT97otUPKzTCgzGsVdrQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fW063juLwqeEFwfL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 01, 2023 at 07:47:54AM +0200, Erik Dob=C3=A1k wrote:
> Hello!
>=20
> I bought a new laptop fujitsu life book and everything is going fine
> on artix just the bt makes trouble:
>=20
> /var/log/error.log
> Sep 30 18:43:48 nexus bluetoothd[2266]:
> src/adapter.c:reset_adv_monitors_complete() Failed to reset Adv
> Monitors: Failed (0x03)
> Sep 30 18:43:48 nexus bluetoothd[2266]: Failed to clear UUIDs: Failed (0x=
03)
> Sep 30 18:43:48 nexus bluetoothd[2266]: Failed to add UUID: Failed (0x03)
> Sep 30 18:43:48 nexus bluetoothd[2266]: Failed to add UUID: Failed (0x03)
>=20
> i searched a bit the webs and found a new commit at kernel org that
> does do the trouble:
> https://bugs.archlinux.org/task/78980
>=20
> follow the linkeys inside the commits there or read this one:
>=20
> ---------------before------------------------------------
> /* interface numbers are hardcoded in the spec */
>         if (intf->cur_altsetting->desc.bInterfaceNumber !=3D 0) {
>                 if (!(id->driver_info & BTUSB_IFNUM_2))
>                         return -ENODEV;
>                 if (intf->cur_altsetting->desc.bInterfaceNumber !=3D 2)
>                         return -ENODEV;
>         }
> -----------after----------------------------------------------------
> if ((id->driver_info & BTUSB_IFNUM_2) &&
>     (intf->cur_altsetting->desc.bInterfaceNumber !=3D 0) &&
>     (intf->cur_altsetting->desc.bInterfaceNumber !=3D 2))
> return -ENODEV;
> --------------------------------------------------------
>=20
> the dude just hooked up 3 conditions in a row with && where before it
> was 2 conditions in 1 condition. + the comment was removed.
>=20
>=20

Try latest mainline first (currently v6.6-rc4). Because you have to
compile your own kernel, please refer to
Documentation/admin-guide/quickly-build-trimmed-linux.rst if you don't know=
 how to do the compilation.

Also, don't top-post when replying; reply inline with appropriate context
instead.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--fW063juLwqeEFwfL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZRtWagAKCRD2uYlJVVFO
o0d+AP4oNwd9Cjay1Ao/Mm5lLmmn0rZYovuJO9UIOSdBN/w/sAEAuTvELS2Y3NZ+
a45nNYc16F/Qn5lYdAjNfJcrgNQwyQE=
=X3ML
-----END PGP SIGNATURE-----

--fW063juLwqeEFwfL--
