Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8F6765706
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbjG0PJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbjG0PJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:09:28 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3463594;
        Thu, 27 Jul 2023 08:09:26 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-992e22c09edso138942466b.2;
        Thu, 27 Jul 2023 08:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690470565; x=1691075365;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FB0Mu6CQitl3uGPBuw3gYGWubWUzRLIdyK0yGcHdmk=;
        b=E5gpNNQQSQLUjCxzHZ7XzUFT2lN5Lw9foE+4CAVZYhu0vBciVnxQtzgfUcAJBzDCRk
         JPcB/EAVtUMOdBv7RA4OdpEJFuWt/Gq7u1SMjCtJzKvmqLXZAV4MRYmGNQgfChXHgD6y
         I95+tOQE7x78i/sg1Swf3tdtxfZjkO6xXZ4ubXPIzMWXkTPm8vVItbrAtP4rbqgc1FS5
         5u3p4bqpFZnSn2bhYVz8I3EG2yEtJZoii7ppgTum84gGgt/0i1IQrIgsWJQbRAZO2Tsf
         JZJQ/1uCxYjsMYaBVLDE1Co4PYERzMbpUvBAoQ9aXJ2Y27mvkT4BHGvjtH1A0nUYtq21
         V1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690470565; x=1691075365;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FB0Mu6CQitl3uGPBuw3gYGWubWUzRLIdyK0yGcHdmk=;
        b=b0UcvPX2pR7rsivtBZ6jaqFQ4GNi/QJtehgZqFI9KfJyBDBi0hng6Hba848bxkA7CO
         E0H9IAttDm7XWS5Vueln7eL+bh/xPxezWUKA9KUWFho9k3Sydk97be6fk0rfvlSRGlFP
         DsGwB+7ClN6P1JoSfLEe0Vly6eSiAEBSiwnobcGEPYVr8ZYcrPuEThAF1+UCT7Uu1UHy
         dF4sg/EVzZDC6HcPBA+x+qabgznUhHcKY8q8NvP3CMLGoPlXYB2prqigJi3rL4drV5Xz
         wS/e2SqVIRN2TqtZDzyF4c7AFhLionFQnQMmPiKzax1oY4G9FmH88xRuZCENObON44Zh
         Louw==
X-Gm-Message-State: ABy/qLaBbAekjD0NNqowlhvcW7pd+MTkwyHbWtplTpJDNh0PoXpE5tui
        V+itcztx4HkJtmUGTDMFCTfVRTqyJTo=
X-Google-Smtp-Source: APBJJlG8yRxMzYrSipyn4gvwiPU9sImYe1d0p4LVvl4FntQ5ezFymj1AH7T+8eHfQ634k7O6bpgmHA==
X-Received: by 2002:a17:906:20d4:b0:992:a90a:5d1f with SMTP id c20-20020a17090620d400b00992a90a5d1fmr2528350ejc.68.1690470564692;
        Thu, 27 Jul 2023 08:09:24 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id l6-20020a1709067d4600b00988f168811bsm886621ejp.135.2023.07.27.08.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 08:09:23 -0700 (PDT)
Date:   Thu, 27 Jul 2023 17:09:22 +0200
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
Message-ID: <ZMKIonuTnoXcuc95@orome>
References: <20230618085046.10081-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uMCXxZT0Gx+zE47A"
Content-Disposition: inline
In-Reply-To: <20230618085046.10081-1-clamor95@gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uMCXxZT0Gx+zE47A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 18, 2023 at 11:50:44AM +0300, Svyatoslav Ryhel wrote:
> This patch adds support for the bridge/connector attached to the
> HDMI output, allowing to model the hardware properly. It keeps
> backwards compatibility with existing bindings and is required
> by devices which have a simple or MHL bridge connected to HDMI
> output like ASUS P1801-T or LG P880/P895 or HTC One X.
>=20
> Tested on ASUS Transformers which have no dedicated bridge but
> have type d HDMI connector directly available. Tests went smoothly.

If I understand correctly, we still need the drm/tegra patch to be
applied before the DT change, otherwise the driver won't know what to do
about the connector, right?

That shouldn't be big problem, but it means that the patches need to be
staged in correctly to avoid breaking things.

Thierry

--uMCXxZT0Gx+zE47A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmTCiKIACgkQ3SOs138+
s6GLhQ/8CVmQ+Rk2WO/b4ELhB6NjDctiVYxrILxGYxoX0UjvsPyIZx44re5qkGbt
IvXSctvz2Dx4GhARbuQOwjCwJO4EhUExjCYPvSyJt9cI+5sLm5Y4/GCPT/AMqQiv
7yrnGGYhD7s3rvTeTrQtIeCG9dj9x7nEMccEfaqc/Cys4Q3xal7KmbuuFKIs+trq
GYj0jAEd6tc2FDY7Y2r4aEVzDroBe8dLKTrg4qv7kMGoeLp1e19uzz0aJP1O8F6r
uXKXDFUPDLDhn9Ktl5vOceuOFozOAn2hTSNP2sLvlbNgWQpBh5PrXtahniN6Vits
W64TFUeCvoGGT47Dlyn333cM7C66GKumB3eXixhkMoC9djVhXgf+u5hYbxSDlz68
rn9l6aK1Es8taTnnXW30GZSzmo63151y2fy4/rzZXAVyMswn40O34YoX71HiVBwl
1pRTf9IwZWE/EucFoYRjP2qlgpvPwmXTaMsYusoZ2KvtAsw6/rnXfxmFqxmQv4bQ
5j4KoHh+4m/At4rqhPYs/c4TsODFJ+g+K6HN/Fb06zc61c7gOnjzllcYeUeRmmGv
JJhudKBH15N0hHnn6+IguE+3yMlhM+TBabZnJSX9q6DNl6ofhmlu0qA1ktDKXwaO
we5XIrIP0UlfDwO9FELcP/KHEACG/LjxKf0qRgJfcQWqjYrey5c=
=W3/D
-----END PGP SIGNATURE-----

--uMCXxZT0Gx+zE47A--
