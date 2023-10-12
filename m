Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582EF7C7051
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379132AbjJLOa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347299AbjJLOaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:30:21 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9986DE;
        Thu, 12 Oct 2023 07:30:16 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53e2dc8fa02so208134a12.2;
        Thu, 12 Oct 2023 07:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697121015; x=1697725815; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zp4wVCfS4MuzC+8sZiTH1CMTD77leYtWSl6pm5bOwTo=;
        b=j7ZQ3wNGC9zNq9Z30DonZ87Dn8Yny6tEbGXkqXh5zD7f1mPWANl/CJHa+aaxVdmKKj
         eV9eUxnoI4hfFD8jEpw2vcRCYyz7IrpdXDhgSJfklMk44UPKEnSzq9YfVAIX+m4vnDwH
         J/SNcIvNIV7tcXvRoExSU0/FPGZfJ8KuCey8PQmy0BgxoSkvd5rV77UxgOX+f2NRRWc1
         Sxl77xOWqNiQw7b11hVk7JMCSPeWYRfdkaGD06yscMx2vvhXSFeUaNZ/hrry/3pe2dPW
         p2sY05liSErXPb7fIrEWbhSXC6FE8WyzbyyAjwz9iqsl+tWGoHieBf1Esf9l8y3mKZKu
         bvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697121015; x=1697725815;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zp4wVCfS4MuzC+8sZiTH1CMTD77leYtWSl6pm5bOwTo=;
        b=aqXl8TG812H3ZWoSNFdEMoK1VXtuzFmk36JmI+bf2/lttZ9o98tjhcNAcn1h+v/zVq
         KZfhISxiJMXKyyUqh9jmixVRpgS/iSzzq7FBBPtEG5K70YW8+pw+z7Ohv9ecib9yhQkG
         LYsMn0BsoSdljmpru2heADjMyf+oPDMS6+jhDtbm9/Z48ngKcY+3WI+WiZdXk7zLJLsL
         DeI7sMeqbeYjQeqTH5xLj5yY0q8GDLBRUs0CUNDbt9dmnn4M1sHC4ZqHtUw2pksUNwJV
         7IsvcpZ6KCoFa8sitqtS+okO7xhvdfSWJTOcXsXycQ9S2ZSHKfP7fp5z4NdtdAAKmTdC
         DlEQ==
X-Gm-Message-State: AOJu0YyBBN6qNyIHsecmWJancMQY0Hgb7DS9XUyP69s02wwxuX1d7JH6
        Wf77qb1TF0MGQjagIgR1t8Bm0bq1tE4=
X-Google-Smtp-Source: AGHT+IHLzI8ne8OuqeIuLuJv4sq6vNdVpgCeX5faLw3CVHMUIUANnnos38xMW3g5gCPk+okf6wXx9Q==
X-Received: by 2002:aa7:c154:0:b0:522:b112:6254 with SMTP id r20-20020aa7c154000000b00522b1126254mr21621650edp.4.1697121015055;
        Thu, 12 Oct 2023 07:30:15 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id cy7-20020a0564021c8700b0053de19620b9sm1911874edb.2.2023.10.12.07.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 07:30:14 -0700 (PDT)
Date:   Thu, 12 Oct 2023 16:30:12 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] thermal/core: Hardening the self-encapsulation
Message-ID: <ZSgC9DxVXC-bHleo@orome.fritz.box>
References: <20231012102700.2858952-1-daniel.lezcano@linaro.org>
 <a6b51de7-4f56-4db9-a7dd-60555ac6c37f@arm.com>
 <d9f3bd7b-a5db-4d37-bb1f-f97e40c8a63a@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cSV4NKVWE6plEgmG"
Content-Disposition: inline
In-Reply-To: <d9f3bd7b-a5db-4d37-bb1f-f97e40c8a63a@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cSV4NKVWE6plEgmG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 03:14:23PM +0200, Daniel Lezcano wrote:
>=20
> Hi Lukasz,
>=20
> On 12/10/2023 14:01, Lukasz Luba wrote:
> > Hi Daniel,
> >=20
> > On 10/12/23 11:26, Daniel Lezcano wrote:
> > > The thermal private header has leaked all around the drivers which
> > > interacted with the core internals. The thermal zone structure which
> > > was part of the exported header led also to a leakage of the fields
> > > into the different drivers, making very difficult to improve the core
> > > code without having to change the drivers.
> > >=20
> > > Now we mostly fixed how the thermal drivers were interacting with the
> > > thermal zones (actually fixed how they should not interact). The
> > > thermal zone structure will be moved to the private thermal core
> > > header. This header has been removed from the different drivers and
> > > must belong to the core code only. In order to prevent this private
> > > header to be included again in the drivers, make explicit only the
> > > core code can include this header by defining a THERMAL_CORE_SUBSYS
> > > macro. The private header will contain a check against this macro.
> > >=20
> > > The Tegra SoCtherm driver needs to access thermal_core.h to have the
> > > get_thermal_instance() function definition. It is the only one
> > > remaining driver which need to access the thermal_core.h header, so
> > > the check will emit a warning at compilation time.
> > >=20
> > > Thierry Reding is reworking the driver to get rid of this function [1]
> > > and thus when the changes will be merged, the compilation warning will
> > > be converted to a compilation error, closing definitively the door to
> > > the drivers willing to play with the thermal zone device internals.
> >=20
> > That looks like a good idea. Although, shouldn't we avoid the
> > compilation warnings and just first merge the fixes for drivers?
>=20
> Yes, we should but there is the series for nvidia (pointed in the changel=
og)
> which need a slight refresh for the bindings AFAIR. That series is since
> March 2023 and Thierry seems busy [1]. I'm holding the hardening since th=
en.
>=20
> So I don't know how to make progress on this? I was assuming we can merge
> this series and let the compiler recall what has to be fixed.
>=20
> [1] https://lore.kernel.org/all/ZK14edZUih1kH_sZ@orome/
>=20
> and as soon as it is fixed, we convert the WARNING to ERROR :P

Yeah, sorry about that. This has been plagued by bad luck. Since then
the device that I need to test this on broke and it then took a while to
get a new one. I still need to find time to set this up and do some more
extensive testing to make sure I haven't regressed anything.

Thierry

--cSV4NKVWE6plEgmG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUoAvIACgkQ3SOs138+
s6FWNw/9Fbxna4WnbhzeH/lRKiMZOxQ2Qw7RCAatQfzWLSzU0+A1G1VxwDmlTyj8
toZiJy/NkAfRGrR7Avbc6nmdnx20x4syCu9zjWcbnJcwQh+mmo3Vqg4hEW1OkbSC
GnkXEckyRIPYbOScbEElOyoxFredVScWdyddHGka+9C1H1tXE7BR+P/I2zJZP/M9
zAgo1/bvC3QHTgY3TK9yQRsZ5X10t4N14n4Q3h+RzrAQQl6Zsc5BBUh8OHt3+XTI
hIeubvBJS7dXehCA0llu9iLIqCDMBv6z/tVbjdPQZJNsshPYqpwCYEm6t3k/pnxj
EFGCWN/taqKHJi4Q36jjOFkCwoCXnKzhS1ViRcXkcZaC13n6ljiZM1/RzS3/wW2t
CP6/7IG3dWB6euXSY8LGGxHxYN17epdICpIXmH1i6Ua1vfcjY2ynISDb2Ao+4Bvq
89T7F9lGth9MneWGiDUm4n9OhEH5+q00u9sfus/MDWGLPzTqGiHKxcmjQQP0VDui
nimpP/LnPXvD3Z4CUYHZpYkE0nnIHYF4utUfeuM5lCsRp8cHtHcVpB8KN8VZR+Fl
LzUb1K6585hC28Vm87+EDI4HAZ9PpbxoJGGUsZZdBO2mzE30maU02l9UWEabEWeT
4CfdVdBuWY2mw63GiHB/tOaFvz5D5EV9lhTxib8cO46f90lEd9k=
=k0xl
-----END PGP SIGNATURE-----

--cSV4NKVWE6plEgmG--
