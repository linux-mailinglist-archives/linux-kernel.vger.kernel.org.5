Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B34D7FB963
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344579AbjK1LZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344558AbjK1LZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:25:14 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5812FD6;
        Tue, 28 Nov 2023 03:25:20 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54af0eca12dso5617002a12.3;
        Tue, 28 Nov 2023 03:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701170719; x=1701775519; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNUOJ8uqp2dGRLuoBkbadBA/67h+j2C/uKAs+8CYKXM=;
        b=cAE7czg6I3oNenklweRaFBjEdrf+2YjUL3e3znEXmQ3+sxR2VTF3qAdLi2p3tySGeA
         MB6IQd14yIhvlt/3JwhHJ6jRyOLBBdnSWphjpR4+TrC/wlkH4kno93yNerevUhhcwtFD
         ltE0ryzwVLkeZClWZoAe6qp6pBDt8UfxlDQrlp+/YzqSiiWHWBod8/2M0JjJUVX0R958
         mt13vNhBFPEoGr17cPhuiMQ8vBKV3bDKqpRRsxy7S/kQMFj4p8fmIL+EQyfuWcnJOPEc
         MMxIhnA1hGL88vJ9yGx3jW8+bhI9nIbyvbKpL7kPbT7MjRAZTD/KEe5xtZlwl8EIcv1y
         sJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701170719; x=1701775519;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NNUOJ8uqp2dGRLuoBkbadBA/67h+j2C/uKAs+8CYKXM=;
        b=Je81wdYKviKlHsQ8ttWJNcQ6NeZTvih1vRvKakTFFuOd6JFb05KZKm5NR5H6frH18e
         4jZHmYKERWnYE2xHhrXJehshiaE7kGUn7k3RFKIwc9FNy5jDLb+qxavUld8CE9IqAUXW
         7XGr/47AGHAV7G5oNsGzn0otmfRuBCAS961kOHRT4xuwLKMGLGwX8SOq/I0MO/T7qDBo
         ayVpyECjrlaP9u1rnXE4Ivm/PNmQBMJyr31mA55H/jez6DIjd7yC+POVdp6QJnEEQrUP
         fxsb2N216sgxrH3GBTFV11S2Ec1GGb2rwR4pn7R3Bvw1s5A5POuThZNBmL0qvQazCemL
         SQfg==
X-Gm-Message-State: AOJu0Yw6AoLnQNrBVMQ6QSKj6WZefZMGTaShPNW5YTspSrwINVJrkBbr
        MfncQVECKgoBvFZ7ouhmxao=
X-Google-Smtp-Source: AGHT+IHqbMoYr9M/PBSf9Q1XSD3aTt9QqOplQiVgAE1r6Wwb8HV4II+bQf9Ppd8QDWo6j6Q7X3fGSg==
X-Received: by 2002:a17:906:7691:b0:a04:837e:87af with SMTP id o17-20020a170906769100b00a04837e87afmr11132340ejm.33.1701170718549;
        Tue, 28 Nov 2023 03:25:18 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id pw11-20020a17090720ab00b00a0f1025b17asm2417847ejb.130.2023.11.28.03.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 03:25:18 -0800 (PST)
Date:   Tue, 28 Nov 2023 12:25:16 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org, Baolu Lu <baolu.lu@linux.intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2] iommu/tegra-smmu: drop error checking for
 debugfs_create_dir()
Message-ID: <ZWXOHI48GyIJsdnT@orome.fritz.box>
References: <20231025152609.2042815-1-dario.binacchi@amarulasolutions.com>
 <ZWRhDMgPCjP_hlZW@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nNpisfqc0N5bJikl"
Content-Disposition: inline
In-Reply-To: <ZWRhDMgPCjP_hlZW@8bytes.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nNpisfqc0N5bJikl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 10:27:40AM +0100, Joerg Roedel wrote:
> On Wed, Oct 25, 2023 at 05:25:58PM +0200, Dario Binacchi wrote:
> > The return value of debugfs_create_dir() should be checked using the
> > IS_ERR() function. The patch, however, drops the check statement without
> > fixing it because the subsequent functions (i. e. debugfs_create_file())
> > can handle the case where `@parent` is an error pointer.
>=20
> This deserves a comment in the code explaining why no error checking is
> needed.

This is a duplicate of f7da9c081517 ("iommu/tegra-smmu: Drop unnecessary
error check for for debugfs_create_dir()"), which is already in v6.7-rc1
so I think we can ignore this one.

Thierry

--nNpisfqc0N5bJikl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmVlzhwACgkQ3SOs138+
s6HGDRAAgujp8COqpO6Y7LdZQaRa4p7ssRczFgQWmdy2vpheWyCgu7OyKfl+9EHL
tT5/soH/rqrC0i3oq8qqWHOUjRSYYoIqCGz8j/4y8KkdVYQ8GTto0mp4rtIpB1ie
g1Cc32zVimxrZHqaxU4K0U6Jq6fWM5WWs12ZCzlbdjl7U8hwD44vNh/kS76Y6JZh
XNVuTL1ijVskDAdxQLULdoBW7S5qCOWjfDbNbW3v9AxOyr789oW5llERZwddvw5G
ndiKBnvtfCsA72jGO71z7A/Vg9gXKkfBJLxTsd1aShhOCW/psC3s+jVC27AJ82xo
giT0rssa9TQlgy4foU+N0JRJ30GODYFF5vRApYREIIHU2bb2qaiG3s6Oavl51gVY
jdihwdz31vjcHrHcj4lC93AvIjl+N418uzaAjvGPhPrVsOw3qQI5onR4WMQ0ZwP+
Tk40z9FyDHFQQKpseUo8+S+qrmlUVYZUm950DMA0mzk7d+KpCKEsPswNnTcStsKU
MnPMzS4w35d8k9JOwfILR5cy5ouXtAwOXbrnKdjLMazFNhlpAYyb3MZgMnCQgLtz
f97/E56oMdODosYuc5S42wKn8CR5Xmd7vnXy7+DXXg8aS4LubEE5jk1YGAgdHh3V
A332A20cCAWZKvgFYbE46Tj6A0eQBD4O5edw0bJZxQQofvNYOfY=
=mBlz
-----END PGP SIGNATURE-----

--nNpisfqc0N5bJikl--
