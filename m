Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19A17D8810
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 20:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjJZSLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 14:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJZSLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 14:11:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A049C
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:11:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3752C433C7;
        Thu, 26 Oct 2023 18:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698343892;
        bh=zAjZWYKj0X+TeoQ8BBUh2QjPiWJbCoaFCclLInGxZek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U6650vGaeoBL/T54vbOKjzWtko9dk+h0R1MRIYz11PbdSkogb6xFPRiNUfo7EzXOr
         Q4I5i0hMEFOGmmQSfsw3zDJ4mYwr+L0P/nHEhLY62GKkZSQYDHIL7EPte9QdinP5yY
         Y9gCtybfrCmHL58tFSzbUrRFW5c001TDKk1JbbN/wzFR72hvhcPu0zKhRn3jiSZNUf
         zB1wTIh6r4NQOo78uyain9fwBDPQvK0xSwQK6sgmBgDFz0BhSrUk5h38sl7W/oCNp3
         y1ONym/aUFm4xmqDN8OkS1qxTnDbStIzmds5C81nr1kFbI5Q3TGunJRfSan9Se01CE
         SsIKvsAPQ2ERw==
Date:   Thu, 26 Oct 2023 19:11:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Chancel Liu <chancel.liu@nxp.com>, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/2] ASoC: dt-bindings: sound-card-common: List sound
 widgets ignoring system suspend
Message-ID: <3242e162-bb0d-441c-af29-7c08e1f67d1f@sirena.org.uk>
References: <20231023020718.1276000-1-chancel.liu@nxp.com>
 <20231026175842.GA4101469-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HTcFwXshOgNI0QFq"
Content-Disposition: inline
In-Reply-To: <20231026175842.GA4101469-robh@kernel.org>
X-Cookie: I'm also against BODY-SURFING!!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HTcFwXshOgNI0QFq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 12:58:42PM -0500, Rob Herring wrote:
> On Mon, Oct 23, 2023 at 10:07:17AM +0800, Chancel Liu wrote:

> > Add a property to list audio sound widgets which are marked ignoring
> > system suspend. Paths between these endpoints are still active over
> > suspend of the main application processor that the current operating
> > system is running.

> Perhaps it would be better to define components used for low power=20
> audio rather than the OS mode that gets used. Isn't LPA just audio=20
> handling that doesn't require the OS CPU to be involved? So the state of=
=20
> the CPU is kind of orthogonal.

Not really - you can have bypass paths that don't touch the AP but which
will have the power cut if the AP goes into suspend and it can be a
system integration decision which components that will be true for.
Often it's an inflexible PMIC/MCU setup managing the lowest system power
states.  The pure low power audio bit we should already be able to
figure out.

--HTcFwXshOgNI0QFq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU6q8kACgkQJNaLcl1U
h9AzFQgAhv1kIvshMwNbebl4YEDMqA368X4czYNC+zO/doeKPvpLr3ox2HGnTWmR
Nyf4K8yUD5JQDrNir/c/SYLXWQAr4sq5vnn2MyQw3z3LP8TBxG3NM7AiKqEqxQEj
QDIfhI8Izt/86k0FnoS8WVOwK5wbcM8b+HJ3bdo7/b1oA00dVVc3f1dCAHQZHz+U
w+zHZGAY4BBW8gw3tFbGNvNW5AEQUDCHKZbUDECM+PXDVLAUFKrpEz4uho7A4Bq2
LzyGissKaKgzmNDlwvw7yoMEMa51n5nwYCbUSM7B1OmFqYapFpZ+w18Dzqi0KDsS
Eto0aoVQorOv0Qf3Y0rPwaHwhcW3yg==
=z+Ib
-----END PGP SIGNATURE-----

--HTcFwXshOgNI0QFq--
