Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061C576953F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjGaLu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjGaLu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:50:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369B2F5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 04:50:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C901E61085
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE103C433C8;
        Mon, 31 Jul 2023 11:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690804255;
        bh=AOWwhYv+t8CDvyhND2LxS4NNrNKJuWikV9QiBFJH92s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uL2XhCM5GgiizRO+1NueJqOprVve9jG9ZNiTVFaZmlT0Q/zpwS7OIGkH1wOpYJzo7
         qRZ3NRfxvT0zTMbGLyJBm8HEDAzDE1VXzpskPjW9Z6koCwUQOj5yZKHR+1uBw6j1rn
         mqu+TreQdXB+3DlMYLWHSARGlScVJQ5XQf3CG4lN2fqdQjsYkmtsO0n1jAABoOItNk
         yTG4BJbMlq8NUZhH6CTPE2kfSEIYlVlVwkzKKeY73KOAAHsw1WyQH8K/e84e2ePbqv
         RtzsDIHhnQ3Ulw1hrtEaBMOf8RZPDpmzuEN04Y89w3ZWgWgoU4pF2vlmlUFYS+g80n
         kWNXkGQ/y6fjg==
Date:   Mon, 31 Jul 2023 12:50:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        kuninori.morimoto.gx@renesas.com,
        angelogioacchino.delregno@collabora.com, nfraprado@collabora.com,
        chunxu.li@mediatek.com, ajye_huang@compal.corp-partner.google.com,
        allen-kh.cheng@mediatek.com, dri-devel@lists.freedesktop.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [v3 2/3] ASoC: mediatek: mt8186: correct the HDMI widgets
Message-ID: <25e6ab45-ecad-4bc3-bf4d-983243c939ad@sirena.org.uk>
References: <20230730180803.22570-1-jiaxin.yu@mediatek.com>
 <20230730180803.22570-3-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m510aG4cVtaJEGRZ"
Content-Disposition: inline
In-Reply-To: <20230730180803.22570-3-jiaxin.yu@mediatek.com>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m510aG4cVtaJEGRZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 31, 2023 at 02:08:02AM +0800, Jiaxin Yu wrote:

> Use SND_SOC_DAPM_LINE instead of SND_SOC_DAPM_OUTPUT to trigger
> DAPM events to hdmi-codec when userspace control the DPAM pin.

Why?

--m510aG4cVtaJEGRZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTHoBcACgkQJNaLcl1U
h9DXVgf9HxthKv6tquZ80eqHswbBmda73YJgF+PneFtfjX5EUD8siEFTvhlHJOPb
itkNuLs0xwuvU/ocou1TJ3JVkd4SlhXF2AQUB2MKqUJlOMYiEthVhAj2RWNMEMWb
M6hNPAHydcz2O6rmMD0wknYpUUHLE+1Xv3EXeMZEKYLh8qZlrfstrqI1s/fhuQaJ
TmQTCMTZ8AmSRgZ9ENPYon30oN6/7qeEvKbyW+PnOTCqSv/Zhz1pOVf21YoY2nhO
94QnTgSNXrSZINA/rfNDUwEvG2W/OY4N/hb+gKf6qbraNOVxbw1o//Cc2tfTTWlL
P2wCPNxJJXNDAizWmcN9zeH3ZZ4Iqg==
=H16t
-----END PGP SIGNATURE-----

--m510aG4cVtaJEGRZ--
