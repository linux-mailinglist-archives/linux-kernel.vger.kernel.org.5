Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28C97DB191
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjJ2XvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjJ2XvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:51:05 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6003291
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 16:51:01 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cc330e8f58so4659645ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 16:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698623461; x=1699228261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tnaUx4F8KrZZ3PGoAEtrzlrFKiWjXS8sFp/d/9HvjiA=;
        b=HVgjwKBCtKjS8HUtp1zYBn2AopfO+5HygEo1KbpOAkAFCcHkAxPTEVY6VfU+AC4Yz0
         qQuXFUWrZyf6Squ6rJGGX7VIzlfFEIO+OV2kL20XR4WXURuvAjLeBywt5QhMs8EgeQwE
         0quvasZPOxRFovAdajyNQCyLaAHtxU9kMPid5RnNbgfM0nSnMi+bbvTHpzS6yv3YW1rP
         2InwsOMnr7zsGK/zHZMpoPoMvdh0dbg7P0Rh/rQn3eJzKi5lb48rcbwAkK3DzAkttEJO
         n8rlyErpTkEeVSka1cvktxcuALM9BuhH8vY1rt7DM8YDdBXvlcezooIHAy5yBtNTf4JR
         IjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698623461; x=1699228261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnaUx4F8KrZZ3PGoAEtrzlrFKiWjXS8sFp/d/9HvjiA=;
        b=Lc0TTudYGRei5zBdTnY2QT/fYUwTeTUR2GS0+aAg5ErlrEXVeb6bTGR0+nptW4uPUK
         71vEI+oz2/USXoLrPr82HHORZJZUxPX9ny/XYk7/RuNf56pPPP5ahH/EC9069jO/Efpx
         n6+V3IRHXKp8Q/c4YpTGIvTibpAJ/T5UxEPF8RZzlqB7iD2Lb9B98c/QQxLglA6guEun
         MbtijUNB8WSOJ1iGugXQr41P3p1ucymM7fhUItAPUFkTYXSCsXjViNoGBDhYIGsVhfRK
         LP1qo+sCA0B2qn8iQoVCsLJyREnoO1GDtZTxfXhaH992MrCC0c/uc9r+iIHB7GWBsa9N
         V9WQ==
X-Gm-Message-State: AOJu0Yy027J/93lMO+YjmwtBK7xAILKXbUPzXsws4XzFVBZN0XGPh97N
        OcRa4DXQQnQtR0XPCtU1JXs=
X-Google-Smtp-Source: AGHT+IHxBs7QaWgZIVC/mTGf2u0/bmEMVPy6LqzGkKMozIa2+zb2CUBE2+Sgs/lTnSYfa4r0xCiPgg==
X-Received: by 2002:a17:902:db09:b0:1cc:3065:9167 with SMTP id m9-20020a170902db0900b001cc30659167mr3416006plx.23.1698623460693;
        Sun, 29 Oct 2023 16:51:00 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902bd0400b001b06c106844sm1077916pls.151.2023.10.29.16.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 16:51:00 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 461598039BBC; Mon, 30 Oct 2023 06:50:56 +0700 (WIB)
Date:   Mon, 30 Oct 2023 06:50:55 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>,
        Dorine Tipo <dorine.a.tipo@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Helen Koike <helen.koike@collabora.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nick Terrell <terrelln@fb.com>,
        Daniel Stone <daniels@collabora.com>,
        Rob Clark <robdclark@gmail.com>
Cc:     Linux Outreachy <outreachy@lists.linux.dev>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH Resend] Fix line Length
Message-ID: <ZT7v39jG4WTxPYjm@debian.me>
References: <20231029144312.5895-1-dorine.a.tipo@gmail.com>
 <alpine.DEB.2.22.394.2310291610030.3136@hadrien>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hxSAXAGVE2cfMdh7"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2310291610030.3136@hadrien>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hxSAXAGVE2cfMdh7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 29, 2023 at 04:11:01PM +0100, Julia Lawall wrote:
>=20
>=20
> On Sun, 29 Oct 2023, Dorine Tipo wrote:
>=20
> > Signed-off-by: Dorine Tipo <dorine.a.tipo@gmail.com>
> >
> > Fix the line lengths of lines 8 and 49
>=20
> The Signed off by line should be here, below the log message.  Please see
> the patches sent by others.
>=20
> >  export IGT_FORCE_DRIVER=3D${DRIVER_NAME}
> >  export PATH=3D$PATH:/igt/bin/
> > -export LD_LIBRARY_PATH=3D$LD_LIBRARY_PATH:/igt/lib/aarch64-linux-gnu/:=
/igt/lib/x86_64-linux-gnu:/igt/lib:/igt/lib64
> > +export LD_LIBRARY_PATH=3D$LD_LIBRARY_PATH:/igt/lib/aarch64-linux-gnu/:=
/igt/lib/x86_64-linux-gnu
> > +export LD_LIBRARY_PATH=3D$LD_LIBRARY_PATH:/igt/lib:/igt/lib64
>=20
> There was a suggestion that it was better to keep this as one line.
>=20

Hi Julia,

The submitter touched one of CI scripts for the DRM subsystem. To test
this patch, there must be a way to run these scripts locally (which
may requires non-trivial setup).

Cc'ed DRM maintainers.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--hxSAXAGVE2cfMdh7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZT7v2AAKCRD2uYlJVVFO
o954AQD8oXo0ltpyVgNj+W2HrUdj0qfZcYHTNndycvvkv2Y9hQD+IgA8U6ryTDQ/
pvwMNit/pa5/2yFf2sQWJmC+jlJpKAo=
=Wy7e
-----END PGP SIGNATURE-----

--hxSAXAGVE2cfMdh7--
