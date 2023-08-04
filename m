Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287EC770167
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjHDNZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjHDNYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:24:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD8119A4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:23:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB61862005
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910C9C433C8;
        Fri,  4 Aug 2023 13:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691155357;
        bh=kJ3pdmHTuhq47H6UlFhigNWiYfJFQX6elbr0RgltItI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T5UFIDSDFUfQHcNJBfZpyO5slT3/sOudk8IwrnWIKxkN1XXRlJLwzU8DYOef0TYlg
         KSFXPuwtNNIx3xATSwe/ETWF92qswYNeNfejerIygSECrAAFeCHI2wjwqnyaAPj46B
         7ryOa+ThNipB+mfvdLyu0UDxkNVACgYHtTLHYcobnen3m/BCyLy3hum689/ewoo/HQ
         rGlja0L8wlAxQX6RDJk3VXWYUcEfU7F6RBD2HQlNCS6RpjcTqUnLjEOsrXlvLYl4PM
         mKEETEJI3pcLp1pqHwZXE4YfG6X+WdLmgjXdwlHjrYcw8WQuDutVrzxvOqfsylNIgK
         eK4RT17eDu1Ew==
Date:   Fri, 4 Aug 2023 14:22:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        alsa-devel@alsa-project.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>
Subject: Re: [PATCH 04/27] ASoC: amd: acp3x-rt5682-max9836: Map missing jack
 kcontrols
Message-ID: <0a14cab1-f0ca-4428-866a-8ca29be5721d@sirena.org.uk>
References: <20230802175737.263412-1-alpernebiyasak@gmail.com>
 <20230802175737.263412-5-alpernebiyasak@gmail.com>
 <277be798-9bd0-baa0-9e0d-8a7a9ac67f02@gmail.com>
 <a0ba4144-7763-4d55-8517-f1c44fa4257e@sirena.org.uk>
 <3d6794c9-60d3-b8f3-99d2-afdc69593d9f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pMcfcRe7WFXk8xDk"
Content-Disposition: inline
In-Reply-To: <3d6794c9-60d3-b8f3-99d2-afdc69593d9f@gmail.com>
X-Cookie: I'm hungry, time to eat lunch.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pMcfcRe7WFXk8xDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 04, 2023 at 10:19:43PM +0900, Akihiko Odaki wrote:

> I see. Alper, can you add a patch to remove SND_JACK_LINEOUT to your series?

Please send an incremental patch on top of the series rather than
resending the full thing given how big the series is.

--pMcfcRe7WFXk8xDk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTM+5YACgkQJNaLcl1U
h9DHOwf+JkJDoTNDDi6E0mUdg+FTXiAjqI93Kkb165ham65WQaBHKUOmI3frfHZn
ZUB+RusbQEGSajFxjPuHWuZjQyb2eM6E1WPnO8dCoctwtAj4eXL4kqSxot8ydqtl
8KwWbrFMtolBBqsnCYxqvemiCIGVaBcSfRUbQx8UhcOy07c4jBxxO8ORK324YGuo
767aJGdUHFmQG8UUwy+gpCIPhMA53+G9BjPTlWf+Ov+hfu/7cdSoGsyFdJmaWrqp
y1bbKneCeTJUlfRBnCzSKNZWLgFxD3W0ai1jguajbtLS5aJHeoWSKIEc/8Vulzhb
hexjd82CB4DH1X/1MV0tvjeAVa2cbg==
=ToLN
-----END PGP SIGNATURE-----

--pMcfcRe7WFXk8xDk--
