Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0027C752403
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbjGMNho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbjGMNhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:37:42 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ECD139;
        Thu, 13 Jul 2023 06:37:40 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbdfda88f4so6284205e9.1;
        Thu, 13 Jul 2023 06:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689255459; x=1691847459;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQE/VgxXrW5415xy8a3ZrtQH2T3C5+Sp5MkegO9Ijlo=;
        b=IR/va+ZEckiCKso3ZhwiYFoQOFofB8JivDmayKo3QFsFq/xeWmF/FxMB3Q8nrezhca
         v0KBqNmszBxbk8O3VI/ZF3sWdRZWnWFKhnDFYR76DSoQ3nG2O/VCriajqZWWZA+Ry/6A
         4tFaEpaLvL1NTqIyrE5vrDjxPKLU2AU82lLeAclwzzTbGNrg7f9FCi20eAFc+uMuSaly
         LJzXC0gaWV3ab32Vp/k7BAk3057aH49fb/i4ou1LyFPAAjt605a7TfK3QsACpXcTJDtj
         QkJDyF0YgrkjQEQItwSyVnR/rMYgqQrOsXm28W/GXhWm3ku+IXcXVdsVbIIXKObtk8jU
         9pfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689255459; x=1691847459;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQE/VgxXrW5415xy8a3ZrtQH2T3C5+Sp5MkegO9Ijlo=;
        b=ClDbJAl4Fn/rT5OhzDwKysAtRBTUMNSM5Ykx3tTG6XCmaqD2Q1uWp3tM86xrh/9ltA
         aJ4xj8HucI0lgA1G5mzNiIGh7/g7PxARpSJQomhD0QCqqRp+oojwuj3fpC0LRCEiK77I
         4DX1dHrvfMQSbaJCvOSV3HeCRmshF52l2SKZLyD9iFFg7deColMjs+Vy/glBONQzLI8p
         pL/pIUsovn/+IpcDySvFz7cwJYH2B4lXemFp7z5uBf9FZvmqYbBwK6tiJcl+kjfw1C0F
         XL7RpFZJs6MQcRHB0QjZAJT36994iVVmqGGO7aFvM0Zf0fY8aEcWEGaWTPDtnGEpoM27
         lTew==
X-Gm-Message-State: ABy/qLYiDBpLOuoLloGbe6nEV5duwwgdWER4kAaqmGQMrmGe32i9659S
        Qw+sEF/3mpnszbT3VhR/i+Y=
X-Google-Smtp-Source: APBJJlHeIojkWJWD9///yoLn6P9yUbEK1BghkiFo9F7xwYri0JXbUuaEPfjHZ9Pb0IJaUgsHMKuqRA==
X-Received: by 2002:a7b:cbcd:0:b0:3fc:5d2:1f47 with SMTP id n13-20020a7bcbcd000000b003fc05d21f47mr1489010wmi.20.1689255458629;
        Thu, 13 Jul 2023 06:37:38 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c378600b003fbb9339b29sm18397591wmr.42.2023.07.13.06.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 06:37:38 -0700 (PDT)
Date:   Thu, 13 Jul 2023 15:37:36 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Stanimir Varbanov <svarbanov@suse.de>, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Krishna Reddy <vdumpa@nvidia.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC PATCH] iommu: arm-smmu-nvidia: Add default domain type
 implementation op
Message-ID: <ZK_-IHPEv_DNbKPd@orome>
References: <20230710082252.9702-1-svarbanov@suse.de>
 <ZKxQnKhqKziyxX8f@ziepe.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="K6L+rgi8a0xrphCK"
Content-Disposition: inline
In-Reply-To: <ZKxQnKhqKziyxX8f@ziepe.ca>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--K6L+rgi8a0xrphCK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2023 at 03:40:28PM -0300, Jason Gunthorpe wrote:
> On Mon, Jul 10, 2023 at 11:22:52AM +0300, Stanimir Varbanov wrote:
> > Add def_domain_type implementation op and override default IOMMU
> > domain Kconfig option (CONFIG_IOMMU_DEFAULT_PASSTHROUGH=3Dy), which
> > could be enabled on some distros. The current quirk has been done
> > for Tegra234 machine, because I found the issue on it. The issue
> > itself appears on USB host controller which cannot be initialized
> > without IOMMU translation. Something more, we proved that IOMMU
> > translation is needed for display and GPU drivers as well.
>=20
> Generically, if you find HW combinations where certain end points
> cannot work with passthrough (which is really weird in the first
> place) it should be narrowly quirked - not just an entire platform.
>=20
> Also we don't really have a way to force non-passthrough, ARM32
> systems will always run in passthrough, for instance. Broadly the
> kernel expects it to work.

As I mentioned in my other, lengthy reply, passthrough is a very
undesirable configuration on more recent Tegra (Tegra186 and later at
least). Passthrough support (or more generally non-SMMU support) is in a
sad state at the moment because we rarely ever test it. I don't think it
can't be fixed, but it's going to take a bit of effort and is likely to
regress again in the future if we don't keep testing it continuously.

Thierry

--K6L+rgi8a0xrphCK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSv/iAACgkQ3SOs138+
s6FW9A/8CPOq8hT0bw1HMqwikDFHs3kIJo2slRYyZG/bYKaqO1FSCrS9jTLiqaog
iFsbxMgg3fBvrpOjSmRsjRtr9o6pXRM4v81xwuLQonfLWFtBmyGXBLKp/CHJmfbc
Po9mJcX6iP8Y5o6jmIJr7qHy9bp1rYmpqkR6+jV3wyvHA0mqfgADVD9VhcwhX1QW
pAeAv+6xCG5rWbJoW5TMdtgQtGUSikiNKOoAfBO03WjNGTzvCVZyNEI30N47LB0D
x5DQqg+5MFmEkXeOPXpxvWkcNkcD/UhJ+VB/BFRLlIn9Nkk0ca3esubCdTpjouWn
YSQGuOVh9e02oGyTjxtNcUWWnhQCwJ9aj+03Ve9bVJ6wZTdKnyP9ttAa3cR+1fun
i/EGGMvpZr098vbmxfcfeu95L2T3qHelVKCH93zvh2CoThJurrZusB3P377Zv0sL
18oT0h0lbRZXqWXI+d6ijdiXJ6hVi1Es+Wi2QttVHDE2IMP+Fn9gnkOGcORvt6o7
B+rGBbiVcDkyDxCSKTt7Q0R60KsmVwU1FnWDdKNONcJ2+1ovBGiw8ym/rSUGnWMX
PyA4++GXMYBSFHQ6Fb7NBohOzbPntH0Y5p1Qp5mDnrDTaNRhrjGujxWmaK8c+hDI
I55ozVVEbPHNwSrInGIzDge/useJNKzZZDLiHF3h+U16Dt5+2YA=
=+uje
-----END PGP SIGNATURE-----

--K6L+rgi8a0xrphCK--
