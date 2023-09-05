Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A77792942
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351471AbjIEQZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242863AbjIEAbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 20:31:19 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E459197;
        Mon,  4 Sep 2023 17:31:14 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68a529e1974so1047857b3a.3;
        Mon, 04 Sep 2023 17:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693873874; x=1694478674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KahAxRhz3wgRQR6LYRmsSMVDqlviJZ+3n3aTM3fwp30=;
        b=afQ2k1vTQ5KN61ZqVFn6dzQdYoJLroDRNM5H9qhSymUFFmrVRLZebOgFzi+VxKsObR
         FGfVX2fV0ClOOlVt9g1/cuOFW07a713YSuNMm9jawpo6KJvIhysm/fKhozPNr5inSb9w
         ajbJpDYsaf9Jvs8bAPVaO71hgUU/YoIVGml8XSLnTbRwi11AJak2uSXIvNz8rWwJvE0a
         lLcbnQW8gbA5tAr2tn2HtEmpbktaRb6JB9lNckqq6IiLH9MDyGbUd8LW9XgHS7aRC4Sf
         Wbsg+6r6XUPvnH5K8zviHcxO72QktAPrKmknTr/KympR9K1JPD1yGuUGtpoe8glveK4g
         i2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693873874; x=1694478674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KahAxRhz3wgRQR6LYRmsSMVDqlviJZ+3n3aTM3fwp30=;
        b=P3GIjOzJOqSsgVbD5OZbztc/GWvPWEoRPycY2mB6VeIjx9F91C7Q5/ub1Vl8pEWla5
         GFSJb3NFmTkV3RVcI6PT5Dy7eSjSgZGJVzHDPitSBRsw325m0P+4+WGAYOX0RwDgnLfE
         8Q3IpRxHC+IB6cHXO867EulJgdKzvHH8xwOkkK3XzmfXn/KUJFVlqb9yoUqqm9R1ju3V
         +NbDGetRwgweHaSnnzdEZ66eyXLS89/WOo7F+1sjJhJ5tbMoK/kDwCprNUg4NaiWnZdO
         bh6Fq4kdjJGNUKrfBLvEBfmtno7KCJ9wbGAgysAAs0sVtTQKxPyAHiFw5Z64Szbn5kx/
         vWzg==
X-Gm-Message-State: AOJu0Yysz6gqyYLcvaIXwUSYuYiALZaSyFCkfUFRVl21MmW4kG/rbsQL
        O8hbOy2RLZxe6EUtsol2x/VzA+1F6E8=
X-Google-Smtp-Source: AGHT+IH2Nn8EYpPw2lv1daEhr7GqVp/qmLMwcHTb+vcj7H9xfK/s+1xTMyzOZol0NEzvBYUNI0eNQA==
X-Received: by 2002:a05:6a20:a103:b0:135:38b5:7e58 with SMTP id q3-20020a056a20a10300b0013538b57e58mr11807695pzk.37.1693873873895;
        Mon, 04 Sep 2023 17:31:13 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id e5-20020a63ee05000000b0055386b1415dsm7185342pgi.51.2023.09.04.17.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 17:31:13 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 98525991F66C; Tue,  5 Sep 2023 07:31:09 +0700 (WIB)
Date:   Tue, 5 Sep 2023 07:31:09 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Adam Ford <aford173@gmail.com>,
        Linux OMAP <linux-omap@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Linux Stable <stable@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 6.1.y Regression found on AM3517
Message-ID: <ZPZ2zTS9loj06u31@debian.me>
References: <CAHCN7xJjK=BaNHa=+OKzOmFtNRYKX_APTp5Zj3g-X_iQcpyK6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4TN05Y37ezUfG4hO"
Content-Disposition: inline
In-Reply-To: <CAHCN7xJjK=BaNHa=+OKzOmFtNRYKX_APTp5Zj3g-X_iQcpyK6g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4TN05Y37ezUfG4hO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 04, 2023 at 11:37:46AM -0500, Adam Ford wrote:
> I have an AM3517-EVM board that I am trying to use the latest 6.1.y
> stable, currently 6.1.51.
>=20
> With git bisect, I narrowed the regression between 6.1.15 and 6.1.16 to c=
ommit
> eaf9b5612a47 ("driver core: fw_devlink: Don't purge child fwnode's
> consumer links")
>=20
> In the regression, 48002000.scm appears as not ready.  This affects a
> variety of dependent peripherals making them unavailable:
>=20
> wl12xx_buf platform: supplier 48002000.scm not ready
> wl12xx_vmmc2 platform: supplier wl12xx_buf not ready
> 48050000.dss platform: supplier display@0 not ready
> 48064800.ehci platform: supplier hsusb1_phy not ready
> backlight platform: supplier 48002000.scm not ready
> display@0 platform: supplier backlight not ready
> dmtimer-pwm@11 platform: supplier 48002000.scm not ready
> hsusb1_phy platform: supplier 48002000.scm not ready
> gpio-leds platform: supplier 48002000.scm not ready
> 480b4000.mmc platform: supplier wl12xx_vmmc2 not ready
>=20
> If I build 6.1.51 but I checkout drivers/base/core.c from commit
> 2455b81afe68 ("driver core: fw_devlink: Add DL_FLAG_CYCLE support to
> device links"),
> the regression is gone.
>=20
> I checked the 6.5 kernel, and it appears fine, so I think there is a
> possible backport commit missing, and I was hoping Saravana or Tony
> might have a suggestion as to which one(s) I should try.  I don't know
> if this is found on other OMAP3 boards, but I wouldn't be surprised.
>=20

Thanks for the regression report. I'm adding it to regzbot as stable-specif=
ic
entry:

#regzbot ^introduced: eaf9b5612a47f0
#regzbot title: keeping consumer links of child fwnode doesn't prepare AM35=
17-EVM suppliers

--=20
An old man doll... just what I always wanted! - Clara

--4TN05Y37ezUfG4hO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZPZ2xwAKCRD2uYlJVVFO
o5IOAQCIGavurK5E7nfTaIRDBoo892kQOqYZMQk0+2UlRBIopQEAjVjV5/kU645H
VdDDpJxC+ONryhpYy6J5KLZwuF+6wQA=
=czyX
-----END PGP SIGNATURE-----

--4TN05Y37ezUfG4hO--
