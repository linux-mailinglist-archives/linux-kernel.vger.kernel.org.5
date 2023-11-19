Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1296E7F065F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 14:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjKSNYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 08:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKSNYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 08:24:42 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E9BC2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 05:24:39 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ce656b9780so8482105ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 05:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700400279; x=1701005079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+BRkKo1UDNyPwLET0kko4yMFYg9wtyizgbwaduapHpU=;
        b=lqgxbWIboKY/tc76jc6y+qa54tZRT6jXumv8uZgQryL3CPHwo/cY5IYUfQF8vri6E0
         eJr801M9yWijuusrIjMB5pfFX5HWyFXmjB2aff60mogwZKyXDS0gmFsrYLSiXHwznpes
         dETHxdhdEwVImiabDCVbMPHpVPWgRGlNFnR4hpVsliNgXEUilbJH1yTiLRCIJIovuDRH
         Ts4sMnmFEaZSAY2URbSy1GHsY4J3RG9OiluHgv9eY61tVic6WATz+uoLaCQRU47ZJK4e
         tPSFfyREf/MS72hxPmok2HlvHd7pXFOtWwv5NMYZo/ZfhIyKuChuKyDIKQS2FbehPbVW
         QaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700400279; x=1701005079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BRkKo1UDNyPwLET0kko4yMFYg9wtyizgbwaduapHpU=;
        b=uQguzQHGRcUe10MWgNdLevgX/ySWxSSaQdcPPcXYpwgjSSRwFPeuTwJJDcqvIZxNcf
         xIFEgqnPlGspUJPbUnWIlfX7ZY0BANq9/NL6SEwUdGxqKsYGwKgxakD2+iGNG5wr7t4k
         GW5SkhjM4QOaKfsfhmlEmoYmd/1jihMeot01PCk1s441G/232h0lxAjQfyYR0GkbWQGw
         FcnKh9izMunfdor4+DSDqukVZgsPMtGfv0o17rodNdXjkMwYMkEDM1f7mlBNgqU/pHNt
         LiMlIV7OORqJHtrHRtCBRRS7dLIV4JYRxWDlhVX7oF98e0tiBgO8IF80/f16Vl6IqUkW
         u2jg==
X-Gm-Message-State: AOJu0YxWR+utbo0+XMFtZeDiHraRO6I3VMiRgBD0ZULFklCCls7nxSKg
        vRwtKkyVriCHIwDQOXq+oDE=
X-Google-Smtp-Source: AGHT+IH+GUySa5SoJL2NpO5wI6AD3djXnM6Z0QKKx43P1ujsH4FL99jFgWVrO0t4Qct9yRRYsyuIag==
X-Received: by 2002:a17:902:70c8:b0:1cc:ef37:664a with SMTP id l8-20020a17090270c800b001ccef37664amr2876743plt.31.1700400279063;
        Sun, 19 Nov 2023 05:24:39 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id n4-20020a1709026a8400b001c5dea67c26sm4292539plk.233.2023.11.19.05.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 05:24:38 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 3FFFF101D92E3; Sun, 19 Nov 2023 20:24:35 +0700 (WIB)
Date:   Sun, 19 Nov 2023 20:24:34 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Dave Airlie <airlied@gmail.com>,
        Linux Regressions <regressions@lists.linux.dev>
Cc:     Phillip Susi <phill@thesusis.net>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux AMDGPU <amd-gfx@lists.freedesktop.org>
Subject: Re: Radeon regression in 6.6 kernel
Message-ID: <ZVoMklvIVClr_IIH@archie.me>
References: <87edgv4x3i.fsf@vps.thesusis.net>
 <559d0fa5-953a-4a97-b03b-5eb1287c83d8@leemhuis.info>
 <CAPM=9tw-8pQWFso0zuLqpsqd5BSHWtc4As9ttdjY-DDr70EMqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="A17eLGPWZDe3T98X"
Content-Disposition: inline
In-Reply-To: <CAPM=9tw-8pQWFso0zuLqpsqd5BSHWtc4As9ttdjY-DDr70EMqQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--A17eLGPWZDe3T98X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2023 at 04:47:01PM +1000, Dave Airlie wrote:
> >
> > On 12.11.23 01:46, Phillip Susi wrote:
> > > I had been testing some things on a post 6.6-rc5 kernel for a week or
> > > two and then when I pulled to a post 6.6 release kernel, I found that
> > > system suspend was broken.  It seems that the radeon driver failed to
> > > suspend, leaving the display dead, the wayland display server hung, a=
nd
> > > the system still running.  I have been trying to bisect it for the la=
st
> > > few days and have only been able to narrow it down to the following 3
> > > commits:
> > >
> > > There are only 'skip'ped commits left to test.
> > > The first bad commit could be any of:
> > > 56e449603f0ac580700621a356d35d5716a62ce5
> > > c07bf1636f0005f9eb7956404490672286ea59d3
> > > b70438004a14f4d0f9890b3297cd66248728546c
> > > We cannot bisect more!
> >
> > Hmm, not a single reply from the amdgpu folks. Wondering how we can
> > encourage them to look into this.
> >
> > Phillip, reporting issues by mail should still work, but you might have
> > more luck here, as that's where the amdgpu afaics prefer to track bugs:
> > https://gitlab.freedesktop.org/drm/amd/-/issues
> >
> > When you file an issue there, please mention it here.
> >
> > Furthermore it might help if you could verify if 6.7-rc1 (or rc2, which
> > comes out later today) or 6.6.2-rc1 improve things.
>=20
> It would also be good to test if reverting any of these is possible or no=
t.
>=20

Hi Dave,

AFAIK commit c07bf1636f0005 ("MAINTAINERS: Update the GPU Scheduler email")
doesn't seem to do with this regression as it doesn't change any amdgpu code
that may introduce the regression.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--A17eLGPWZDe3T98X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZVoMjwAKCRD2uYlJVVFO
o2QaAQC6Z6Oet9ctoQNb/3mlbO7qKOQNiQjysEw57sJGJ5fCrgD9EY2N+PxFc4ZM
7JJJBQvw63BIl4tWd1RfxzxM4knFaQw=
=1kus
-----END PGP SIGNATURE-----

--A17eLGPWZDe3T98X--
