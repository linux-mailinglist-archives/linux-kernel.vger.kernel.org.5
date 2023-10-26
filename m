Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E93E7D7E15
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbjJZIHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjJZIHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:07:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8870AC;
        Thu, 26 Oct 2023 01:07:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C32C433C8;
        Thu, 26 Oct 2023 08:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698307663;
        bh=MRgZsiUVmIfZKqCwNfNZ0a7KfMg57CWlHCRug7dRYiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h4BZUaWNpPw0JlhG/Aqlkb6iJ3x6gBmrkWVdvfMKm1Vcpsx5D2OFmlCecVVOI60pS
         MPEMTlRIOMTF+mBiaE1Kkjwm6SPOPTJzk7p18x/eSJOtErkRe986WGLnOOiT7j42No
         J2WvuZscQ3o9v89HAWZpvH+SRgCprj9P55k1XTNCKICa39ZENF+0lFSwT3IISmBi7H
         pkL87DzM9AOHRtDt5HgVxkXv74Q2K8zYYnRCc107VAY40bm/myYUM3IqHF/9GfYBtZ
         RJ0YUxhTJdrGN8uP0MC3FE+Rt/4/7h6yprElSn+8KGiRYr2g/JfZ3LHj7wusiScWrG
         zEUttswk1AJJg==
Date:   Thu, 26 Oct 2023 10:07:40 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Keith Zhao <keith.zhao@starfivetech.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Shengyang Chen <shengyang.chen@starfivetech.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jagan Teki <jagan@edgeble.ai>,
        Rob Herring <robh+dt@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Shawn Guo <shawnguo@kernel.org>, christian.koenig@amd.com
Subject: Re: [PATCH v2 6/6] drm/vs: Add hdmi driver
Message-ID: <3twc4zoohon7uujypgjtlnryfmebx4osvpykagnwr5nemmqz2w@w4vw55uswebh>
References: <20231025103957.3776-1-keith.zhao@starfivetech.com>
 <20231025103957.3776-7-keith.zhao@starfivetech.com>
 <70805ff2-56a8-45e1-a31c-ffb0e84749e5@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l2pgpleihh7nbgyu"
Content-Disposition: inline
In-Reply-To: <70805ff2-56a8-45e1-a31c-ffb0e84749e5@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l2pgpleihh7nbgyu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 01:23:53AM +0300, Dmitry Baryshkov wrote:
> > +static int starfive_hdmi_register(struct drm_device *drm, struct starf=
ive_hdmi *hdmi)
> > +{
> > +	struct drm_encoder *encoder =3D &hdmi->encoder;
> > +	struct device *dev =3D hdmi->dev;
> > +
> > +	encoder->possible_crtcs =3D drm_of_find_possible_crtcs(drm, dev->of_n=
ode);
> > +
> > +	/*
> > +	 * If we failed to find the CRTC(s) which this encoder is
> > +	 * supposed to be connected to, it's because the CRTC has
> > +	 * not been registered yet.  Defer probing, and hope that
> > +	 * the required CRTC is added later.
> > +	 */
> > +	if (encoder->possible_crtcs =3D=3D 0)
> > +		return -EPROBE_DEFER;
> > +
> > +	drm_encoder_helper_add(encoder, &starfive_hdmi_encoder_helper_funcs);
> > +
> > +	hdmi->connector.polled =3D DRM_CONNECTOR_POLL_HPD;
> > +
> > +	drm_connector_helper_add(&hdmi->connector,
> > +				 &starfive_hdmi_connector_helper_funcs);
> > +	drmm_connector_init(drm, &hdmi->connector,
> > +			    &starfive_hdmi_connector_funcs,
> > +			    DRM_MODE_CONNECTOR_HDMIA,
>=20
> On an embedded device one can not be so sure. There can be MHL or HDMI
> Alternative Mode. Usually we use drm_bridge here and drm_bridge_connector.

On an HDMI driver, it's far from being a requirement, especially given
the limitations bridges have.

Maxime

--l2pgpleihh7nbgyu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZToeTAAKCRDj7w1vZxhR
xQohAPsE2kzpXlr9RqQPDtJRNj8AtNNrqzpApALpLI553biaLgD/RpyXbzEyRIo3
cDu23rmpQ4eOQdldwjqobLYIqhayago=
=B4HD
-----END PGP SIGNATURE-----

--l2pgpleihh7nbgyu--
