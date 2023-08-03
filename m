Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A187A76F375
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 21:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjHCTd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 15:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjHCTdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:33:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7579A3C3B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 12:33:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB55160C5B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 19:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C3AC433C7;
        Thu,  3 Aug 2023 19:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691091202;
        bh=Na39kC0nP6XiW875V274Re2PU/Nlj2wRY/n4Ot8HLjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vq2BHfXd0gAouZIkgnzf1DfzUa8NZDzU1x8y7+3dNLTFUILMcNkIJvKYBfYJQSzW3
         RYYZmW45VHl7DbGGghUJpfaBpUH7es8pY2cMU1BfFMZQEQ0Iqz4ZnMGRTfEr/XRwBy
         1bvtHux6jRaWV01Q2gCrU44FeWfqiLUgX1Qmj6zGCNRK+gxK98jY1X++g7wIfP24If
         a0E9MgRAXWgIB39M4D8d9tda3B8eJkLwYUhbevvI8+k6Nuu8n7GvRO8ULiKUfic2JV
         G3TZQwTX9hYfUSjPpfhPafGmOTpya0qnfqCkV8UxYslk+fOkc8JquUxObDallXK/R7
         /lKiMhto7KJrg==
Date:   Thu, 3 Aug 2023 20:33:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jiaxin Yu =?utf-8?B?KOS/nuWutumRqyk=?= <Jiaxin.Yu@mediatek.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "ajye_huang@compal.corp-partner.google.com" 
        <ajye_huang@compal.corp-partner.google.com>,
        Chunxu Li =?utf-8?B?KOadjuaYpeaXrSk=?= <Chunxu.Li@mediatek.com>,
        Allen-KH Cheng =?utf-8?B?KOeoi+WGoOWLsik=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "robert.foss@linaro.org" <robert.foss@linaro.org>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [v3 2/3] ASoC: mediatek: mt8186: correct the HDMI widgets
Message-ID: <9c90185c-9cd4-4a08-9925-be5d460af54d@sirena.org.uk>
References: <20230730180803.22570-1-jiaxin.yu@mediatek.com>
 <20230730180803.22570-3-jiaxin.yu@mediatek.com>
 <25e6ab45-ecad-4bc3-bf4d-983243c939ad@sirena.org.uk>
 <c6ae8630d06138b6d0156c19323afebf0718f522.camel@mediatek.com>
 <089fe457-1c61-4b7b-ad37-a67e7f46cb56@sirena.org.uk>
 <6aa6947865795fc534b61f5b8a80b3c42fd5a0cd.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+mbNnAHmVhFc8DSv"
Content-Disposition: inline
In-Reply-To: <6aa6947865795fc534b61f5b8a80b3c42fd5a0cd.camel@mediatek.com>
X-Cookie: One Bell System - it works.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+mbNnAHmVhFc8DSv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 07:20:15AM +0000, Jiaxin Yu (=E4=BF=9E=E5=AE=B6=E9=
=91=AB) wrote:

> I agree with you, in fact the speaker is indeed doing this way. But
> about the hdmi that on the board, I did not find a defination link
> snd_soc_dapm_hdmi, so I use snd_soc_dapm_line to replace. The purpose
> is to control it link speaker. Or what do you suggest I should do?=20

I think the sensible thing here is to define a DIGITAL_OUTPUT() which
can be used for HDMI, S/PDIF and anything else that comes up and isn't
clearly wrong like reusing one of the analog descriptions is.

--+mbNnAHmVhFc8DSv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTMAPoACgkQJNaLcl1U
h9CWewf/XtBsII8aM+PvwnIJ4Sr4fN16oOfY1UY32SAMvG5kfv55GzqucnYVEkQW
a1Xs2el6AlSouSelQ12FvpaBAXjHAlQpyUoMwI0BYjncBoJ1aHZEGgwE54710y5H
eRQmJH2oarBgD4MbO5N1pqUVbajjCg4mtU61yWgPhYlniAMILOmzyF5jxcpE7EET
7cd0djgpIZHR/osfIG3EA7WQKjuZyMtB/0YKncA1qRoUP0pqZQfetbeHqtchfqJy
3YvmkidEFoaROm7dSZWbNImhDbRVPNal4iot/8JUghN+yo867eidr/0i1kgzgJ8j
+A+PCUclKZDIDoGbmL2M5hlTe+Ihbg==
=3kqt
-----END PGP SIGNATURE-----

--+mbNnAHmVhFc8DSv--
