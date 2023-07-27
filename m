Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEFF765939
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjG0Qwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjG0Qwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:52:35 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ED3271B;
        Thu, 27 Jul 2023 09:52:34 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-992dcae74e0so155182466b.3;
        Thu, 27 Jul 2023 09:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690476753; x=1691081553;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJllZA/hraC0sGa6pdxU7i7KaLRbEl/1PrBlJ7UILBI=;
        b=h4p6ZXuU1vBEdSNIlOBnFuw7qqVQhirfehuF2YLpk2ocsttal5BhgebbKvctlmB4F0
         XyKMJP7UueyCw0y1Mgz+fk+fqt81Lhxb8Jbdy7ihMZ9HRmsA6jq0iZQn+k9P6Aq/8fWJ
         A1aeurTe7LQy+rN5H65VZH9i+o1m128BkwIRPkn+659fev3T1ABYOl0CbJGmsTOyri96
         J2NgAZ4zBY5SCfiAlIGYbC6oRtC2vx8b27YZuj10xGTqN7RzXxqJBexCfHKx2cm98S7Q
         JHN7C5stc/2PAkrl3+MercEf0DNKcAjUAJ5j90AOHT5MVaqVPcUQgr/nYB9gO34dZ3w1
         BRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690476753; x=1691081553;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJllZA/hraC0sGa6pdxU7i7KaLRbEl/1PrBlJ7UILBI=;
        b=OSiCMdKjEI/qLN+jLAgLSU44Nb9JxF68VzEEUB5ODwrHlNih7pXgRK/+cyBd52IEiK
         rS6JQcZgmN1JKuRpAp6QRcNYkfu7bczk9ytypSlX3qq6ctgE0Lb3UWzeo8FeLBu/ii+h
         5N8Roe0OlymUDP+n4/OwjC+qkHTwkQpFFHdOSXsY30/Q2IN6WCRBIHXZAHSQpDPk4Bdj
         SPOmdOqDx5GFSNgmeam1cPo5oE5DZDa+4s6nhkHlTFiIJYi84GnLkQz/hWLKsjhmTK57
         MqqjylUGZYVRFw6pIByHbYQdSOtth9pWvYvhd67paYG3LOjCanEUBMKVIGPVKUL2ntxO
         3NDw==
X-Gm-Message-State: ABy/qLY7p35pYIvJRKLbEVbi0paedHwG0L1zobQjFTWdJ1Jct7UD1tF4
        nt3dZkJLbNcvf7cOBnKLp/s=
X-Google-Smtp-Source: APBJJlExqeBOXFYv5p5Mp+mstGgDsEmtwT2utg6+6JlXRrZAxSp13C7iJaOCi05XZSssVb3al3ifxw==
X-Received: by 2002:a17:906:292:b0:992:4250:5462 with SMTP id 18-20020a170906029200b0099242505462mr2748008ejf.50.1690476752525;
        Thu, 27 Jul 2023 09:52:32 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id k13-20020a170906970d00b009893f268b92sm983139ejx.28.2023.07.27.09.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 09:52:32 -0700 (PDT)
Date:   Thu, 27 Jul 2023 18:52:30 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 0/2] Support bridge/connector by Tegra HDMI
Message-ID: <ZMKgzmVCCGqpuVEQ@orome>
References: <20230618085046.10081-1-clamor95@gmail.com>
 <ZMKIonuTnoXcuc95@orome>
 <97EE0F0B-D1EE-43B1-A13E-510DB8FA2798@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NiHFY5kYNQQB57jG"
Content-Disposition: inline
In-Reply-To: <97EE0F0B-D1EE-43B1-A13E-510DB8FA2798@gmail.com>
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


--NiHFY5kYNQQB57jG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 07:24:56PM +0300, Svyatoslav Ryhel wrote:
>=20
>=20
> 27 =D0=BB=D0=B8=D0=BF=D0=BD=D1=8F 2023 =D1=80. 18:09:22 GMT+03:00, Thierr=
y Reding <thierry.reding@gmail.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=B2(-=D0=BB=D0=B0):
> >On Sun, Jun 18, 2023 at 11:50:44AM +0300, Svyatoslav Ryhel wrote:
> >> This patch adds support for the bridge/connector attached to the
> >> HDMI output, allowing to model the hardware properly. It keeps
> >> backwards compatibility with existing bindings and is required
> >> by devices which have a simple or MHL bridge connected to HDMI
> >> output like ASUS P1801-T or LG P880/P895 or HTC One X.
> >>=20
> >> Tested on ASUS Transformers which have no dedicated bridge but
> >> have type d HDMI connector directly available. Tests went smoothly.
> >
> >If I understand correctly, we still need the drm/tegra patch to be
> >applied before the DT change, otherwise the driver won't know what to do
> >about the connector, right?
> >
> >That shouldn't be big problem, but it means that the patches need to be
> >staged in correctly to avoid breaking things.
>=20
> Patchset contains drm/tegra patch

I understand, but my point is that if we apply the DT patch before the
driver patch, then the display won't be correctly initialized because
the old driver code only looks within the HDMI node for the additional
properties. Only after the drm/tegra patch is applied will the move in
DT be recognized by the driver.

So for now I've picked up the drm/tegra patch and then I'll apply the DT
change later on.

Thierry

--NiHFY5kYNQQB57jG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmTCoM4ACgkQ3SOs138+
s6EMFg/8DWd4RP4PN5NZCmhwr4RSpxepUKij2HEMxzuYsXkeK4MnmAV3WfQi9eWT
6X4gUfyxo+OenRA80NfmbkmfTg6XnS3UwcMXXtPvwWTrbsQsxB6PiTQ+LgV2Az9w
pTtaP2bUSxVm8T6QPq+mAsoXLHJivaT+ynAbPZXDdAIJ8p+72QNkyQO2QjFSoEbl
QoCMCKWcnp4yxnmrCYtTKBQNYKZC15Bwi8VLkQCmaQQ+30ioe6BYfSoKNvmClKMu
ZLu7sbVVQrzddTVVng0gt/04eQuqMSbBgp0gRGmcwGZav3b7RwMK4ZUpbyCFN2De
TqtJOhR3XzWhPx98IGmsN0NbcfGPk4lBXYvcD9SxL2aZwMzwTCwpAsorH+tTBI1I
bjCa5Iebi3aqIl88Te+z3ec4vxHk2X+++7YZOaid8JBtOXlPR+ece8KA551MBgUJ
8zHP5ESGPm1onjW07aotlTLOIBYYVGA+wKtBtaHbFVWLGWEzZPKAwjcgqAanSwyv
jYICptKYIsK/HIhTdIHP3kXEuXUk9MDKMseBky4gVrq2odu8qQG8zGZJjDVakCMx
nQKwA8T5xYlr3/eAqZ9fFnDWRfVuC7Il5Z/CHwRRJr6S5dqlUjp1EFlVvqkKqrfC
j/h/dz/fVouHa8Spx0W03i1sWaFckYcYELF3u/aJSYnnzr4tFC0=
=QV1N
-----END PGP SIGNATURE-----

--NiHFY5kYNQQB57jG--
