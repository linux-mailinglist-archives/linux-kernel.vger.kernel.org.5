Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6A17657AD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjG0Paj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjG0Pah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:30:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C561BE8;
        Thu, 27 Jul 2023 08:30:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A94561EB7;
        Thu, 27 Jul 2023 15:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39D7C433C7;
        Thu, 27 Jul 2023 15:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690471834;
        bh=LV9IdMEKBlOBEGAGePEhzi2kc2fezNPmOEVfMNlLjys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FZy/ku0cvhtPJi8f2uLN5ISCJ1Wb27sZg+Y5bgUW1OaVXOmAN5LZ5jrqXKoMz31lv
         lIP9TD8kZLHbFrMOAlhfwPna908tLjt10hpaV8Cxi8cUIFOfMOdCF/79aBNfgUP2K5
         tpLZcYlPjXfcF60ZHVgzixdZeu+MYhyH6e+QgUZMOhDdYhCD5sjN9UjHrgk+h4ljTS
         B3vmvyiOFPivULQbcUHX7F0wkpGN1Nb2iZ/rKde+/KwDT8qu3AM4DTjiC8GqQY/qd6
         rYCGDBXbH/wjvnW1ZisUsGVASvuqqcqLZaJNNe2dHW85cvDiH8sliXOhgQoxnr+Zem
         kQM0/bpWqollw==
Date:   Thu, 27 Jul 2023 16:30:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     Lee Jones <lee@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Jerome Neanne <jneanne@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
Subject: Re: [PATCH 6/6] regulator: pca9450: register restart handlers
Message-ID: <c24f49f3-0c92-4da4-b307-1b4faabed626@sirena.org.uk>
Mail-Followup-To: Benjamin Bara <bbara93@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Jerome Neanne <jneanne@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
References: <20230727-pca9450-reboot-v1-0-c8edb27bf404@skidata.com>
 <20230727-pca9450-reboot-v1-6-c8edb27bf404@skidata.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U32jEgo6AMZIU2Ba"
Content-Disposition: inline
In-Reply-To: <20230727-pca9450-reboot-v1-6-c8edb27bf404@skidata.com>
X-Cookie: Go 'way!  You're bothering me!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U32jEgo6AMZIU2Ba
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 05:26:41PM +0200, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
>=20
> The PCA9450 supports both, a warm and a cold reset. Implement both and
> register the respective handlers.

Acked-by: Mark Brown <broonie@kernel.org>

--U32jEgo6AMZIU2Ba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTCjZAACgkQJNaLcl1U
h9CkKQf/beIKM3fR6bqol0blFHGwSkmD0ijxm51wpTgD2lbkX1z5qxND/LzBw7Y9
oPL/RyyiKHcwC2wSWNCD5VOwu55xQoYPUJZRUYdgszlBzwto+M3rj5i/RLxQiovd
U/GZxtoS1Il9FTobQ3Xc5m9cwuoIpDeLFebaD8BbCNhCXWgaDMhSskcq3ZP3Ojjs
NnNKQZuWzXTtQ+3V3Ec06w+P4X7180eqgAYcrn36dm4QvCBWhvoiKZlvhxzyaSr0
hUHFK3mNqUgOd1sqUZqS78XaTojE1QkxbtfmWybyl3P/wOzPrkOsqtvwCIURKAfH
3+S1kTeDpSbXG198uAOtbQZVIbRg7A==
=uM02
-----END PGP SIGNATURE-----

--U32jEgo6AMZIU2Ba--
