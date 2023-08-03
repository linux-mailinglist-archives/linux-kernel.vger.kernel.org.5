Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5EF76E6CC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbjHCL1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbjHCL1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:27:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020C4198C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 04:27:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DE9F61D4D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 11:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32ACC433C7;
        Thu,  3 Aug 2023 11:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691062051;
        bh=94uq0Bo3QnKTETsWRpHX00Zq/UK65SuO7RrYYlFqiPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oG0KahOFGElnYYGp4HYhmQgvg12UxbdCUyxny5SFkjCOEMA5i4Q2UPxt18674wuma
         Jn8edrfpdKCWlbkX9s6h9Xw0tjVvFCatrcxiOv4ML9SNYiu21qT50URueafImaLgxx
         YSBZvgGLjfHjyEoK1+2pEP8T+k4Gr27Dk1XFZUO+t+6a5LzuG/SGcWQfW46koHrjQR
         IdPRrMxlk63w/H541M7W6UFDa+p5zVbXoUmgRIK5vdfuaW4i/PLVd7KhSVDaacjovF
         ZaE4IorHLntzzTN4qdqb0oyR+cqgz0GnKZ04Ymcdr7DlVE0M92+M1NMJum6uXPdF4l
         D3aJbsziWhgiA==
Date:   Thu, 3 Aug 2023 12:27:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v2 RESEND*3] ASoC: fsl MPC52xx drivers require
 PPC_BESTCOMM
Message-ID: <9581313f-5340-455d-a75d-dc27d2eb3ec0@sirena.org.uk>
References: <20230803025941.24157-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JtDrcl5vLUX5Kj+l"
Content-Disposition: inline
In-Reply-To: <20230803025941.24157-1-rdunlap@infradead.org>
X-Cookie: One Bell System - it works.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JtDrcl5vLUX5Kj+l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 02, 2023 at 07:59:41PM -0700, Randy Dunlap wrote:
> Both SND_MPC52xx_SOC_PCM030 and SND_MPC52xx_SOC_EFIKA select
> SND_SOC_MPC5200_AC97. The latter symbol depends on PPC_BESTCOMM,
> so the 2 former symbols should also depend on PPC_BESTCOMM since
> "select" does not follow any dependency chains.

Take a hint, it's not clear that the patch is tasteful.

--JtDrcl5vLUX5Kj+l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTLjx0ACgkQJNaLcl1U
h9APBwf/Xlz8zi+ScLXchSdGVzlpBaygqFFBp+EYQnQuF+pLp1RgI0dzC3kNdV/b
UiYqKfemmWpNm+E/hBv2DgcPPGbB6d1iQQqpTeuymxO4Gloe06zD6Xwa34VJWB7y
lz8fB2dSwxMLTxBCRKo7zQ+ZvOCVHDBZ6TXUFjMtPNM16Mn6P/IurMUh1GT63csu
ssICm8IKAyCnvZqfjYn2SsfwXKzs2M8h6aVsbSCD2WPjJfHBHrE3SN2jIWhHjkPJ
fXZUi2MGJmGHiUD/rPOjHgFfJX1WCmaABpYQVfoZXsPF/Fk015SNCH2AR+8PU1NF
dT/TaWGwdHn4vBWSFTpsk/0yHjL2KQ==
=Baba
-----END PGP SIGNATURE-----

--JtDrcl5vLUX5Kj+l--
