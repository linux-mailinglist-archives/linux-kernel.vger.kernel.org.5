Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4441C783B32
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbjHVHwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbjHVHwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:52:36 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51678193;
        Tue, 22 Aug 2023 00:52:33 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5259cf39154so5238994a12.2;
        Tue, 22 Aug 2023 00:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692690752; x=1693295552;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0US/9vzbx+c8F2WOJrOOVtzNnNHMJoadK1FXJ0ylzVc=;
        b=Nc0oOBn0CTXc0LVwa0AuE9FI24wT1the3uRU2Y75Eox0+gl4XNACh8ltYciU5eyFAy
         eRG+klHKncENMLlN4KeVTRHpQ8/4a2GVnL6PK+i6ZBNvq58dq6SEia0B1sOu9zbJfmr/
         wgBXw0k7dGPBcvBv1ti3kN4bqm1vQmD2SBZf9+KY8OMV+nPqeVAd1fG7uGFLXWX9USeL
         5X+5CKmcW5Jw3VBkUg257Ph1d5HyYwoWdWLUITSi2NNCUdMCS9oP5y/UPpmi9lSr0A3m
         pBRu1Zvw1yH/wGyArKD8dPDFWDYiNE/TiBH5j6jrGV9q0i0QKMGWrQf+8zr6eYcJbYsO
         7gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692690752; x=1693295552;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0US/9vzbx+c8F2WOJrOOVtzNnNHMJoadK1FXJ0ylzVc=;
        b=F5bj/BewEZwPTE6uLm8sqYkA2S9tAcbqweJ6V5ypVstkEEr2KP1hgJ+zN05x0EYSlD
         OUBpzy8EYX2ILwrUgctluuNDeJDucD6QXYIU7bFqhlKzb/AtA4o8OjOyAW9ACO1LUF/9
         sVYX4MRgGkASLBXRmAflsdDMuoBqfxi0I+t/IPJHX95EhsXe6cZXiFcMNJxHg2WGyp0g
         Bk/4rs476izOQ+Ip0m3yGpBkvtkuMGFuWJHbaQx6gl7u0VWsEMgbikKeMBttdgzBOg2w
         iL0nJMleDfLAVU2LuQy5QKPbHHGHI1O4qbXUTludD6HkVUWZ1TGcNdwbFi3zF9voVGpn
         oRtg==
X-Gm-Message-State: AOJu0YwjmZ+YyE8at9os5IGCSabXj+K3+8Mh5vZjqqiEVTdJsP4AysJI
        jBfBgh7bIZUcbqNdkftdIFU=
X-Google-Smtp-Source: AGHT+IEhOGZA7NHDv5ED8bUuE4okXlUJbiEMbWdIwcfIULbFUGXosC2Peqs4fbDpSHOEuhpTCX5VfQ==
X-Received: by 2002:a05:6402:b29:b0:523:102f:3ce0 with SMTP id bo9-20020a0564020b2900b00523102f3ce0mr7071365edb.21.1692690751654;
        Tue, 22 Aug 2023 00:52:31 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id p1-20020aa7cc81000000b00525c01f91b0sm7345294edt.42.2023.08.22.00.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 00:52:31 -0700 (PDT)
Date:   Tue, 22 Aug 2023 09:52:29 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kartik <kkartik@nvidia.com>, arnd@arndb.de, digetx@gmail.com,
        frank.li@vivo.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        pdeschrijver@nvidia.com, petlozup@nvidia.com, pshete@nvidia.com,
        robh@kernel.org, stefank@nvidia.com, sumitg@nvidia.com,
        windhl@126.com
Subject: Re: [PATCH 1/6] soc/tegra: fuse: Add tegra_acpi_init_apbmisc()
Message-ID: <ZORpPYYczxRN_wuI@orome>
References: <ZN9wdTLK1rwnVK/e@smile.fi.intel.com>
 <20230821113220.4255-1-kkartik@nvidia.com>
 <ZONZaZ1QaWKBCMYj@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3tebZ8yOd3fV2Qwz"
Content-Disposition: inline
In-Reply-To: <ZONZaZ1QaWKBCMYj@smile.fi.intel.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3tebZ8yOd3fV2Qwz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2023 at 03:32:41PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 21, 2023 at 05:02:20PM +0530, Kartik wrote:
> > On Fri, 2023-08-18 at 16:21 +0300, Andy Shevchenko wrote:
>=20
> ...
>=20
> > >>  void tegra_init_revision(void);
> > >>  void tegra_init_apbmisc(void);
> > >> +void tegra_acpi_init_apbmisc(void);
> > >
> > >Why do you  need a separate function?
> >=20
> > Function tegra_init_apbmisc() is called from tegra_init_fuse() which
> > is invoked at early init and it also has `__init` keyword. If we use
> > the same function for both ACPI/DT, then we will get init section
> > mismatches when the Tegra Fuse driver probes using ACPI.
> >=20
> > We can use the same function by dropping the `init` keyword. But
> > the way we are getting the resources for device-tree and on ACPI is
> > slightly different. Hence, I kept a separate function for ACPI
> > and move the common bits to a function shared between
> > tegra_init_apbmisc() and tegra_acpi_init_apbmisc().
>=20
> So, you mean that behaviour is different for ACPI and DT cases.
> Then obvious question why DT case can't be delayed to not so early
> stage to be run? This requires some explanations, more than given
> in the commit message and here.

We've done some experiments in the past to unify this and unfortunately
we can't. The reason is that some of the old 32-bit ARM code needs some
information from the APBMISC registers very early during boot (among
other things for SMP support), so delaying this doesn't work.

I agree that it would be good to put this into some comment for later
reference.

Thierry

--3tebZ8yOd3fV2Qwz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmTkaToACgkQ3SOs138+
s6GJFA//bjlGLsSf/pP4BdoONw7NWXEk7RaSkK3HRBfiOFctHxyp+Gjl3qvTAbPM
MRV9y/z6v0V7DIBNeRh1PFFGDTMNxcY+ikL7iwTX3gHcBdvgifxfAJWtsK4Q5Y5a
DbFtpIEN58rbzGJkYCYOo54LGYeo7MSmKAMxXK0YtnPAc5DPY6beYyVY28ucE2gy
RupL8CYRZ+dFGPkJosJpzNGhsYtb1iM234zST/hsRpqLxKVcbGc54ISv71Z2EiKQ
xWAHQHl08BvmRQPYwtIPnbOkT0mSOOJISVoFx1vTFZW008RylNTcZZC9KZnJ0zX3
p38yHo0OoTMu2YTU2VCmWoe9KJwyMaSn7mhA3xqIMJJ6YuOQVtOyglagh8kmx5XB
2znXl4vq20xfQqujNYfrOqnmtG8Uw+gB+Wd8kwf3m3FLitF7T9wOi8Sm9O6veW1D
O/WST8seudDBMX0ARCAMqtP0OZvmZ2V3oTFC13gTgP1IhH1wRuBrdSDTuqFDNcmF
vJwOwV6KbBbDZfgdfPRBNZ10uqqHBKhThRMvRkkEPqmfCZAQU8RmPs1rU9vUn6ay
+W0hVrpvXvrYH2dfrkM6KVxDBANAVK73xryACAzd2W5nVtqvEk4DOOxqIhwGeImz
ZmSwk9RkSegYOfCxM6r4W28BWEwRgvsv0Vmi6Ah5QGisb5IlrZk=
=Xo4J
-----END PGP SIGNATURE-----

--3tebZ8yOd3fV2Qwz--
