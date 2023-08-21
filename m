Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F44782777
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 12:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjHUK7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 06:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjHUK7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:59:20 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8160DB;
        Mon, 21 Aug 2023 03:59:18 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bf078d5fb7so18829285ad.0;
        Mon, 21 Aug 2023 03:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692615558; x=1693220358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b6YFpODidN8i7T/aP4iShz2e2fi5e15POjDGjX+rUFg=;
        b=gu5GWaz87DfV65dOTC9F5iRJQ16BaGKY75Tq4b9NFx0I7DYD4c/oPXIM80+ux050wQ
         GAmcaOq1WotiU/Wr4WPoEnlzLC/c5I2YuEBHwB0D2dWNIG3FIpBOZLiYXFzOX0p0d5Y6
         scZH5csVhg9qSBKpoYlJuTLCov62FlU/EAwmUj+xYwBw3R+gm5ZHM7+0d7KxLW5zv3hc
         tzFHhl5SeM9C1mOoFOIqcAScHiH0yZDelwfxTMTZr2Lc8d4SZVM6i030YUdobAI9/ije
         yxoQr81I4gqHF1oq/PwpfYluOfEppE0fhXtHQAn99xNSqbxggUnNgJ9v/V2yQx7pJ7hg
         vy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692615558; x=1693220358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6YFpODidN8i7T/aP4iShz2e2fi5e15POjDGjX+rUFg=;
        b=apG6KJYXRUyNaf5nUC7gDsAIKu5z+JkJmGHbu7VI1WMuF09LVwpTiuqAqN2J7j89W6
         /7c0QwuF4FOBMdYKiyJo4NTcRlaxRE4KnYHWbiAet0/uqNTOCodw0I7Kj1nPu9qN7bkS
         osfQ//OtbhWXhruNT2K4E+gX1DwOIjeAG3F2kZtmOOdIrl/1exsCN4am42kn2kDYcjDW
         R3MU8SgfmA5t63HcjTj6WDU6CXPIxvNsqLNJmjk838RKb1/oWO2cNs3osgHr7vEwD8sq
         4HPMQfEiHvk7n0VyYCMxVlOtnPMDs64L+EvbU6uVdfn9l9Sc6eAi9ZMuE0xw7TU/tEt0
         LtZg==
X-Gm-Message-State: AOJu0YzNCzkqwg0OQrQB5pfuJK7YRE4F5oDFpyFyN+Y1S2mu8KyMqpzh
        9Yeg557C9oIycQRIB/ns7GY=
X-Google-Smtp-Source: AGHT+IFl9SuBL6vPLEQ85TvOumpA4k6la5gh99FaD1LoRKvveEV35/YUilJYWxc1+VXGZVBXNJneLA==
X-Received: by 2002:a17:903:44a:b0:1bf:574d:d206 with SMTP id iw10-20020a170903044a00b001bf574dd206mr3891099plb.36.1692615558191;
        Mon, 21 Aug 2023 03:59:18 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id g9-20020a170902c38900b001a1b66af22fsm6786879plg.62.2023.08.21.03.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 03:59:17 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 8F717819DE4A; Mon, 21 Aug 2023 17:59:14 +0700 (WIB)
Date:   Mon, 21 Aug 2023 17:59:14 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Luigi Baldoni <aloisio@gmx.com>, linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: Video glitch with Hanftek Astrometa
Message-ID: <ZONDguFpqRTHf_UV@debian.me>
References: <trinity-4a9cf567-5613-4ace-8e63-fa27d4450df6-1692446595564@3c-app-mailcom-bs14>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/8dnAOMNvZulVrcy"
Content-Disposition: inline
In-Reply-To: <trinity-4a9cf567-5613-4ace-8e63-fa27d4450df6-1692446595564@3c-app-mailcom-bs14>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/8dnAOMNvZulVrcy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 19, 2023 at 02:03:15PM +0200, Luigi Baldoni wrote:
>    Hello everyone,
> last year I replaced my old RTL2832U/R820T DVB-T dongle (which worked
> perfectly) and replaced it with a Hanftek Astrometa (RTL2832/CXD2837ER)
> DVB-T2 one and my troubles started.
> Every channel I tune to shows a periodic glitch, as per included sample.
>=20
> I tried the following things:
>  * connected a regular TV set to the same antenna cable and the picture l=
ooks
>    fine
>  * replaced the usb cable
>  * switched distros (from debian to arch)
>  * installed a current kernel snapshot
>  * replaced the minipc on which it's installed
>  * used usbip to access the hardware from my desktop machine and tested
>    it directly with vlc, mpv and kaffeine: at best the stream was glitchy
>    and at worst the app crashed
>  * toggled every parameter available for each involved module
>  * ran tzap directly
>=20
> None of the above made the slightest difference, therefore I'm asking you
> if there's something I might have overlooked or if this is truly a bug.
>=20
> Video sample here, captured with tzap:
> https://www.mediafire.com/file/qantvq916uy7o4k/rai1hd.ts/file
> https://www.4shared.com/s/folTulDcljq
>=20

(also Cc: RTL2832 and media subsystem maintainers)

What kernel version are you running?

Also, can you try with different dongle (ideally with different chipset)?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--/8dnAOMNvZulVrcy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZONDdwAKCRD2uYlJVVFO
o/AJAPoDxA+QbdrImZNvSwhpl/6j7mvhm1LD120OrR0KfWf7UgD+NmwraDJfqIqa
LEoOwDTq84brr8qeHuSF8EyduV1EKgQ=
=fINR
-----END PGP SIGNATURE-----

--/8dnAOMNvZulVrcy--
