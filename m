Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF247DDADC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 03:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjKACLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 22:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjKACLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 22:11:34 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BACCF3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 19:11:32 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5b9a7357553so1973058a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 19:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698804691; x=1699409491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PkwyaILwsX+VKZTDFEUltkIi2zr5qDA6qHFMO6lWAZw=;
        b=j8vgYfssa+BImXbw8i/M83FSIWOBck/fzS7Y/sQCw28zpR8rQ+YaYxVAUKVQ9QinY8
         iAoKWdjZZvU/kKdtyoxHa/DKSNGSDlFlpScqGfcFgCsTE+BCv0zBcsuU9Mfd7N1kCH2t
         4uvCdMqci7i17vcgeLZwG+7Bfvr+UUoeZji/F9epujQ7JXklAXISps7UjwoDeOeX+fGC
         Z383gZCzBj9P3lX8/JEXQi2xm2HyAJ1jp8NScIcbYCnUqE3kCkFRkeBs20oRlGcHlK9J
         TBAnT0Td4G8TEj7EG3XZWBjXhfjwdBN5sW/mvvjxnxmRxASbHw8HLM50Qm57S31y/ck0
         2/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698804691; x=1699409491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkwyaILwsX+VKZTDFEUltkIi2zr5qDA6qHFMO6lWAZw=;
        b=pDSNFTEMv2EpKRMOVkPMP+DVmC/UNUxOa76ND0CX2XR2CfyD02PYdTKxT08tKDG7+6
         MZqme7g62nSFSOmsgXA7huE9cI9UWdSFYReXIzY0Y9fxDR5lr7WrjCW1ogqb6mquMbrF
         QBfXAQsnhwaEqF2jopMQr9JSxzaebjRovqH6huzNx5VkBGaxGhml5V8vY9E+AoBrOudX
         OXnYkNtw2j8BfITNPjWBM/6Mm8osCHvP7RNf3/f1P2cDy7f3qRok7+aTA1YeQP1zzdcg
         n2Ri75A1j/I/mjTEOT0fR3ZaLUFextKCl/mtP9XmB7I3Y8KLZhsEAfZsn1mEBrl+32uv
         st2Q==
X-Gm-Message-State: AOJu0Yy1MVFktuCbn1BaphwDIj1c7tq5vZQ6memLFmhWsdPaofrkKoUx
        vLdhJhBQTvL+tJigGQooKds=
X-Google-Smtp-Source: AGHT+IED9CeFPa2E+EjUNPDryeGPow3qOhz0APJeFNDxLSOX0Ztnwop3hA9Qhu4rcOE+I85CHm8FpQ==
X-Received: by 2002:a05:6a20:2d2c:b0:17a:f37e:ddc2 with SMTP id g44-20020a056a202d2c00b0017af37eddc2mr16632463pzl.47.1698804691275;
        Tue, 31 Oct 2023 19:11:31 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902d38900b001a80ad9c599sm204872pld.294.2023.10.31.19.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 19:11:30 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 589A5819CFCE; Wed,  1 Nov 2023 09:10:56 +0700 (WIB)
Date:   Wed, 1 Nov 2023 09:10:39 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Helen Koike <helen.koike@collabora.com>,
        Julia Lawall <julia.lawall@inria.fr>
Cc:     Daniel Stone <daniels@collabora.com>,
        Linux Outreachy <outreachy@lists.linux.dev>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nick Terrell <terrelln@fb.com>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dorine Tipo <dorine.a.tipo@gmail.com>
Subject: Re: [PATCH Resend] Fix line Length
Message-ID: <ZUGzn-xcoymIfoQA@debian.me>
References: <20231029144312.5895-1-dorine.a.tipo@gmail.com>
 <alpine.DEB.2.22.394.2310291610030.3136@hadrien>
 <ZT7v39jG4WTxPYjm@debian.me>
 <alpine.DEB.2.22.394.2310300712310.3533@hadrien>
 <3f1fdfa2-e30b-42c6-b290-bb02283b3589@gmail.com>
 <318c568f-c813-4d16-b577-28f37cde92c7@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dooGvATdJTR1HNc3"
Content-Disposition: inline
In-Reply-To: <318c568f-c813-4d16-b577-28f37cde92c7@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dooGvATdJTR1HNc3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 03:36:30PM -0300, Helen Koike wrote:
>=20
>=20
> On 30/10/2023 08:36, Bagas Sanjaya wrote:
> > On 30/10/2023 13:12, Julia Lawall wrote:
> > >=20
> > >=20
> > > On Mon, 30 Oct 2023, Bagas Sanjaya wrote:
> > >=20
> > > > Hi Julia,
> > > >=20
> > > > The submitter touched one of CI scripts for the DRM subsystem. To t=
est
> > > > this patch, there must be a way to run these scripts locally (which
> > > > may requires non-trivial setup).
>=20
> Instructions to test it is on the docs:
>=20
> https://docs.kernel.org/gpu/automated_testing.html?highlight=3Ddrm+ci#how=
-to-enable-automated-testing-on-your-tree

Thanks for the pointer!

--=20
An old man doll... just what I always wanted! - Clara

--dooGvATdJTR1HNc3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZUGzYQAKCRD2uYlJVVFO
o3Z4AQDaWdOvXjwiZ0Oc4b0iaHgCHKe7XwNerDY/r1vhieslYAEAquSuTvqW3nD4
fc8XKmmvpMJ4l+G56RFFk2paFOoc6QA=
=+axy
-----END PGP SIGNATURE-----

--dooGvATdJTR1HNc3--
