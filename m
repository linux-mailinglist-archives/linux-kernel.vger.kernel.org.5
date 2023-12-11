Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9EF80CAB0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343622AbjLKNU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343541AbjLKNUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:20:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A4CD8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:20:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC935C433C8;
        Mon, 11 Dec 2023 13:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702300830;
        bh=NL2ENmBjIwcpp92HnkgEm9ykKOp6EQ6nvP2PwYBmzhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MPXvfAwbh8hwH9ldAT97ah+Dne6RHbK0ZuNig1YOpLC+t55X4eYoHwuUdAaaqdqTM
         WGFT9Tpt0Z59zzIQmiMNJkuku9/WKo8NIY8u4T75iZ04mnEyj8qEer5tPykpp072DA
         TycX5gHHaqf0ZGER6vu/JXpABZHDqKQn1gqZfi2ow5U686W/Hi6w0m65tIAbuB7SUD
         aWTxug3ffsCwizNBclY8bZmVAIMJp53/tXOvbZqlaULxn+6MhZaGJCrBQHR4+mw2zZ
         uZsk7ItY/8cHhZ7Hi8iUfnltXOMkNtBdPvSAZhDSOYgR04NhPGF3aPzpP4nBZUC6xx
         yMyiEvlMtPupw==
Date:   Mon, 11 Dec 2023 13:20:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jianhua Lu <lujianhua000@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC, PATCH 1/2] ASoC: qcom: sdw: Add TDM support
Message-ID: <01cbe664-f344-45ee-a049-1c27b78ac9a7@sirena.org.uk>
References: <20231211095357.4629-1-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="76L5gXG0TJhXaYup"
Content-Disposition: inline
In-Reply-To: <20231211095357.4629-1-lujianhua000@gmail.com>
X-Cookie: Better dead than mellow.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--76L5gXG0TJhXaYup
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 11, 2023 at 05:53:56PM +0800, Jianhua Lu wrote:

> +	}
> +}
> +EXPORT_SYMBOL_GPL(qcom_snd_tdm_hw_params);
> +

Why is this exported?

> @@ -125,6 +186,9 @@ int qcom_snd_sdw_hw_params(struct snd_pcm_substream *substream,
>  				*psruntime = sruntime;
>  		}
>  		break;
> +	case PRIMARY_TDM_RX_0...QUINARY_TDM_TX_7:
> +		qcom_snd_tdm_hw_params(substream, params);
> +		break;
>  	}

The only caller is in the same file.

--76L5gXG0TJhXaYup
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV3DJgACgkQJNaLcl1U
h9Cr+wf/Rh5mzsWfkvyzZL0kVpdllXEeA8Mjsmn1CqPrug3j1L5NGY75yRi15YFa
36Rq1DrvIR+rkp9HNzNRR/ME1rekfzACkvglWhuPWsvw00KrMqp0FuUHlL7z0Q4Q
ZRlQCS5qZb+UBbh2R+ePA9ImNeZcqqL/FS2XokbZt4SyFLXWqz68gVbAzVX+z2Ic
xJa8JERXDFzpZxSCmTGS1BmvlirtPMBJl1HrkFZzlkfEfp/9n9Ws+KJDCgeHMrxU
xC6PjSN/OOk/or784TaG0E8JCBh0zd0KaoDalQpeCB+qy0i5HygEnS2Rkxa6FIrs
VW4dV6u1NZ5wyIjoNqaORFiQ5W8TyQ==
=ENse
-----END PGP SIGNATURE-----

--76L5gXG0TJhXaYup--
