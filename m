Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BE67BD58D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345456AbjJIIpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbjJIIpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:45:51 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB0CD6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 01:45:50 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c60778a3bfso35496435ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 01:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696841150; x=1697445950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+UYiBL6SRbLOPgrNzGh3TGoyVQnJviY/7sooyahS/D8=;
        b=WtGNAPHl2IPhIbrvDUO+TEVLFRxIfZCCk9oExXAYDcBFSi2tvU+7gM0QtQfQRF3FGv
         8TCQVRq2+IS6RsFTz17xKp5yHDhvsRmPnTU4O4/6OiGF6Tr/CjYmhiIbGaImQtmRgPzD
         L1x8eGpMP+KaYMaOhFLJhexwip/i8rnKQxEiPE/hTbv9qqGkkz4hu1Ji5s02mCG1IaYl
         2XDRnSAp3klIkGFsxgOykEPjsnfMnkUPKAC5o/8KfxnkFdIEqoqVQ+EudtlAwBzqdNh+
         nlqf+NuYGylfMQeswpsFzV50YsTMVrzljfoSWpQpDSThflXjMGiTROLkmPps3JUo+A25
         ftyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696841150; x=1697445950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UYiBL6SRbLOPgrNzGh3TGoyVQnJviY/7sooyahS/D8=;
        b=S540a85O+kzrHJaT1iCHJ9Ip6XR+FKETHr/nbFh36CDGnh6L2BcnYsvuTM5nY259EB
         vc+C1YqvRWrkkOZxZVJEEgouVh5NNafZcXqUkHksjmesZmX1XF0XFDJ9uOAe+AicUchk
         QIKbyqxewj6LnpKGwXDgM3NXpfPvj7Z7LSxQ4aezQbgLx/S5FHpPRTapWVvc6ISWBT1+
         jlHDKkU7bkURACPoqdJK1XZCvER4PnEu6uS2wQJVj5uIRaPZp0kNwt4L97u6nqqJkBuX
         OJTAXw44ARXbkMHvn4VuzS5whADXcz08r5XtJFwZGM7whe60prE+dk26nSC/2PT9+8b4
         wQ6A==
X-Gm-Message-State: AOJu0YwlZA7Cz64aROj9maghKt7Y2olAwM0AT5W5nWHmbXIWTAZwferU
        NW7+0KRFGBL57BUk0euC0XkKP4tktxo=
X-Google-Smtp-Source: AGHT+IF05H4q63Cso7kjB1N3kLjdHmG3CmMzZbm0KtDP2GgiRIwTZqg0Tsw0un0gXDUMCRkfRhFrHw==
X-Received: by 2002:a17:902:d349:b0:1c5:e527:68b0 with SMTP id l9-20020a170902d34900b001c5e52768b0mr15337660plk.62.1696841149660;
        Mon, 09 Oct 2023 01:45:49 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id a12-20020a170902ee8c00b001bde65894c8sm8936969pld.268.2023.10.09.01.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 01:45:48 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id D98058FE13DF; Mon,  9 Oct 2023 15:45:44 +0700 (WIB)
Date:   Mon, 9 Oct 2023 15:45:44 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Jaak Ristioja <jaak@ristioja.ee>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: Blank screen on boot of Linux 6.5 and later on Lenovo ThinkPad
 L570
Message-ID: <ZSO9uArAtsPMPeTP@debian.me>
References: <7c50e051-eba2-09fc-da9f-023d592de457@ristioja.ee>
 <31bdf7b1-0ed9-4217-b459-1d857e53120b@leemhuis.info>
 <CAAhV-H7fRpykesVUEyaTpVnFiGwpP+fPbtdrp6JwfgD=bDp06Q@mail.gmail.com>
 <CAAhV-H7XCmbgS=N4-SE8FnASAws8hnDRZsQJgXE+dwyARaqzNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e+saoYv3HPZRi7+a"
Content-Disposition: inline
In-Reply-To: <CAAhV-H7XCmbgS=N4-SE8FnASAws8hnDRZsQJgXE+dwyARaqzNw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e+saoYv3HPZRi7+a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 09, 2023 at 09:27:02AM +0800, Huacai Chen wrote:
> Hi, all,
>=20
> On Tue, Sep 26, 2023 at 10:31=E2=80=AFPM Huacai Chen <chenhuacai@kernel.o=
rg> wrote:
> >
> > Hi, all,
> >
> > On Tue, Sep 26, 2023 at 7:15=E2=80=AFPM Linux regression tracking (Thor=
sten
> > Leemhuis) <regressions@leemhuis.info> wrote:
> > >
> > > [CCing the regression list, as it should be in the loop for regressio=
ns:
> > > https://docs.kernel.org/admin-guide/reporting-regressions.html]
> > >
> > > Hi, Thorsten here, the Linux kernel's regression tracker.
> > >
> > > On 13.09.23 14:02, Jaak Ristioja wrote:
> > > >
> > > > Upgrading to Linux 6.5 on a Lenovo ThinkPad L570 (Integrated Intel =
HD
> > > > Graphics 620 (rev 02), Intel(R) Core(TM) i7-7500U) results in a bla=
nk
> > > > screen after boot until the display manager starts... if it does st=
art
> > > > at all. Using the nomodeset kernel parameter seems to be a workarou=
nd.
> > > >
> > > > I've bisected this to commit 60aebc9559492cea6a9625f514a8041717e3a2=
e4
> > > > ("drivers/firmware: Move sysfb_init() from device_initcall to
> > > > subsys_initcall_sync").
> > >
> > > Hmmm, no reaction since it was posted a while ago, unless I'm missing
> > > something.
> > >
> > > Huacai Chen, did you maybe miss this report? The problem is apparently
> > > caused by a commit of yours (that Javier applied), you hence should l=
ook
> > > into this.
> > I'm sorry but it looks very strange, could you please share your config=
 file?
> As confirmed by Jaak, disabling DRM_SIMPLEDRM makes things work fine
> again. So I guess the reason:

Did Jaak reply privately? It should have been disclosed in public
ML here instead.

>=20
> When SIMPLEDRM takes over the framebuffer, the screen is blank (don't
> know why). And before 60aebc9559492cea6a9625f ("drivers/firmware: Move
> sysfb_init() from device_initcall to subsys_initcall_sync") there is
> no platform device created for SIMPLEDRM at early stage, so it seems
> also "no problem".

I don't understand above. You mean that after that commit the platform
device is also none, right?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--e+saoYv3HPZRi7+a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZSO9swAKCRD2uYlJVVFO
oydtAQCjpra6tsxV4/98CtIBJeEv9SPFN/GBEOiRr+a0amnAaAD9HnpgYUQGuUI3
Li7bRmsGwGPIno+QwWiW2fiZl9ZcOwM=
=bSd7
-----END PGP SIGNATURE-----

--e+saoYv3HPZRi7+a--
