Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B14678E9CD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 11:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241725AbjHaJxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 05:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240255AbjHaJxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:53:36 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E601CEE
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 02:53:34 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a7d4030621so306174b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 02:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693475613; x=1694080413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+GDJQNvk1I3RU9eHa9L6NV+dyMRSPGsdEAWk45bEPSw=;
        b=Z6p2EOaab0QT7yNKxq4F2tEX7dBjgqbzt+X99/c0V+/HtV/al0Q67aLf6gZQvAb/3v
         UP2uhue8YSOgUKmqTf45g/0/a8H1U164hsynP8hNvGejz9WTZc9bzOjOzX+ozHcppb0a
         0RLaAor4b/uMMtONfhunp/cEaz2ug1Au+VBi5wj8E/OZX1CPaxD/YIJVZzGVm1T4fjNK
         hhCJNrgXqDOMB2G/uYnQJ1YKCW00fTBE0ttbpc+FPXtqR15dp5r34KUpynmCeFw7bMQ5
         K2G19LwlnH7guZIGf0Lw51470sAJCvtz4wlEZmL6ls1MU+WdYelXoEnxqONZ7ycRe/YE
         /Q4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693475613; x=1694080413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GDJQNvk1I3RU9eHa9L6NV+dyMRSPGsdEAWk45bEPSw=;
        b=bdle5zKQAlT2dW870EDqdp85MO1IVRq3Equ29rdcXDpEsuop+QX5whLyMsfGEe+4ns
         9lJeYfXrUfVKWs/Zg6cHgHFNs8e6BmiCP3966sP8z7s3XL7c4h/dGNXmoGdiWY/+o8tl
         NBhFcTIndxQHGuU7KfjDGsIF1a+qmW54IjqEBYDVOy0aDSLM4sf3mcoZ32WghQrnT/I2
         iFdQIgefMqtr1OVCYxkEFUcGBBo4q30FuTwlN+wq5pz5jonZk0W3KZk7Xu1rC8wwPVjX
         DMIEb3Im9Hn/+8Y59ErikR05YqkbKkYuDoqmE720r+LZeDAf/B+L3pwCAgLbNHgtDURJ
         +SaA==
X-Gm-Message-State: AOJu0YyCHfnLVE+VxYXICMsOrKgYAhq5wWGy0ta7rz9CvyAVmRpPdmfk
        tWT8LIdf4tv2UAX7WDXS0KI=
X-Google-Smtp-Source: AGHT+IFuTxBBnsClMiDGJuvLuCYgceaKjoXiFCmcN4xiYtVXao8M2f7wxtZGIsYY6C6Re0yFiTRAlw==
X-Received: by 2002:a05:6808:210a:b0:3a7:72e2:f6be with SMTP id r10-20020a056808210a00b003a772e2f6bemr5295000oiw.2.1693475613564;
        Thu, 31 Aug 2023 02:53:33 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id v3-20020a655c43000000b00565e2ad12e5sm924535pgr.91.2023.08.31.02.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 02:53:33 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id DB0A18BF2F99; Thu, 31 Aug 2023 16:53:29 +0700 (WIB)
Date:   Thu, 31 Aug 2023 16:53:29 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Frank Wunderlich <frank-w@public-files.de>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc:     Daniel Golle <daniel@makrotopia.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Riabchenko <d3adme4t@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: regression with 33140e668b10 thermal/drivers/mediatek: Control
 buffer enablement tweaks
Message-ID: <ZPBjGWPjSfl-HmDJ@debian.me>
References: <trinity-6713557b-fe0a-4dae-84aa-1aa86f7619fa-1693473911557@3c-app-gmx-bs12>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RJwfJEiQhwB0+FtO"
Content-Disposition: inline
In-Reply-To: <trinity-6713557b-fe0a-4dae-84aa-1aa86f7619fa-1693473911557@3c-app-gmx-bs12>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RJwfJEiQhwB0+FtO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 11:25:11AM +0200, Frank Wunderlich wrote:
> Hi,
>=20
> The commit 33140e668b10 "thermal/drivers/mediatek: Control buffer enablem=
ent tweaks" is merged between 6.3 and 6.4 and causes a regression where tem=
perature cannot be read correctly at least for mt7986/Bpi-R3.
>=20
> bpi-r3 ~ # cat /sys/class/thermal/thermal_zone0/temp
> -274000
>=20
> after reverting the commit and fixing some build-errors in 6.5-rc7 becaus=
e new members used in mt8365_thermal_data too, we can read temperature on m=
t7986 again.
>=20

Thanks for the regression report. I'm adding it to regzbot:

#regzbot ^introduced: 33140e668b1020
#regzbot title: incorrect temperature on MT7986 due to tweaking buffer

--=20
An old man doll... just what I always wanted! - Clara

--RJwfJEiQhwB0+FtO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZPBjFAAKCRD2uYlJVVFO
o0mFAP91QuKCfgQVlixmP/Pv1pO2ZddoCUNEegbRBqxDSCFtvAEA+K4HSholbqcJ
NGGQtAZxl6iJbR5W9KtqFAjrr34MLgo=
=1gyx
-----END PGP SIGNATURE-----

--RJwfJEiQhwB0+FtO--
