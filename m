Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91F47C6E61
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343951AbjJLMlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343872AbjJLMlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:41:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5B0BE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:41:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46495C433C7;
        Thu, 12 Oct 2023 12:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697114462;
        bh=S+JE9f5yFI5LpkybuTpXi2ppei+deRtKMWJ4sWWwkwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AEhBi5yZTs2RCp/rbxUts8TnzXMLRcM5e48EerX+lfTZX8g+3AOCnW02A7rQwunD3
         52qmFcC2hOdCMXZmBFuzNzPjZqkBcdHx9F/B1joFycUVcG/WcMz9j9xeCVnpL3qmFR
         SSrQ/DH6F63RTp6quwYWRVzV1ZW+/ovYj49vQszbqXbBntVrsfgNSRXMGRv8/DVC9O
         6S/UJW0yA3OYQkwezMbfE8Xe/G092KsiY7K2SKuUEcuK1XXz3/FgjN8scu5ArZcWdU
         Eac+U56OUlL825tgkD4IhALAjVuO5Cva1z3YoHHU25ZIwQJJoVtTz00RpjxXZiCoWs
         9P6RUjb5B1Qiw==
Date:   Thu, 12 Oct 2023 14:40:56 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Devarsh Thakkar <devarsht@ti.com>
Cc:     jyri.sarha@iki.fi, tomi.valkeinen@ideasonboard.com,
        airlied@gmail.com, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        praneeth@ti.com, nm@ti.com, vigneshr@ti.com, a-bhatia1@ti.com,
        j-luthra@ti.com, r-ravikumar@ti.com, j-choudhary@ti.com
Subject: Re: [PATCH] drm/tidss: Power up attached PM domains on probe
Message-ID: <libnfyaftywmfr2gmkdjsv6cptzjyrrx2tkxczusifnwthyh36@olzd2e5hagtr>
References: <20231009075018.2836020-1-devarsht@ti.com>
 <c9f17f9e-b9b5-9685-30ca-6a7d041dd8aa@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dml2l2bctoq47jl4"
Content-Disposition: inline
In-Reply-To: <c9f17f9e-b9b5-9685-30ca-6a7d041dd8aa@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dml2l2bctoq47jl4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 12, 2023 at 05:10:06PM +0530, Devarsh Thakkar wrote:
> On 09/10/23 13:20, Devarsh Thakkar wrote:
> > Some SoC's such as AM62P have dedicated power domains
> > for OLDI which need to be powered on separetely along
> > with display controller.
> >=20
> > So during driver probe, power up all attached PM domains
> > enumerated in devicetree node for DSS.
> >=20
> > This also prepares base to add display support for AM62P.
> >=20
>=20
> NAK, for this patch, as discussed with team there are already plans
> to have separate OLDI bridge driver which should eventually handle
> the additional power domains.

Just for the record in case your current plan doesn't work out and we
need to revisit this patch: my point was that it's something that
deviates by a margin from what drivers are usually expected to do, so we
should document why that deviation is there.

The patch itself looks reasonable to me otherwise.

Maxime

--dml2l2bctoq47jl4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZSfpWAAKCRDj7w1vZxhR
xRRwAP91VGXS8cZOVzri71ykEss+wKMy4btdAbjPDACQgrhVYwD9EfdK3i474qdL
ZCVDRPfwLGIXZo5THQXx4sYZM9RT7ww=
=lW56
-----END PGP SIGNATURE-----

--dml2l2bctoq47jl4--
