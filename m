Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC0D75B0E6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjGTOLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjGTOLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:11:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7129211F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 07:11:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A42261B06
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC06C433C7;
        Thu, 20 Jul 2023 14:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689862268;
        bh=G8euv+WfQDtkbWySwB4rZDIeP/Tk4RHlZrv1viz5hVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ifyMOxLspguRukAdTr0+Jg4UA5BvKsQrOw7Xkq1XGN397PzpCgrjUEx8BJL9Hu9Pt
         iUaIzumQsLWzupbQDDW8t4JDOWT12cogKuy4hUgpyAey/6AM8jt1ILIf6p6h+fuzqm
         qxFZ0GTaaa2a/IwIC8onB3RPm3aZHbH/ksvtqo5fIcuLU+u9t/kFHscGpLoTp63kxo
         bt2tOntVwhS/lu/U0R56IrJg9RzGS79U/izn6uU1CbuIlHWvSGW2LFmQ5eBZ9YyVCT
         7sMST+Y0YaeA3PoFxpBqfMbxA8aNbF55/eU2y9N7o0C7wuJH44uCJ0JSfPuCfUxwst
         fMlOw23wSnLMg==
Date:   Thu, 20 Jul 2023 15:11:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v1 01/11] ALSA: cs35l41: Use mbox command to enable
 speaker output for external boost
Message-ID: <56e50829-b93d-48ef-9691-5c78229a4b5c@sirena.org.uk>
References: <20230720133147.1294337-1-sbinding@opensource.cirrus.com>
 <20230720133147.1294337-2-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6K/jTXohBWi27Iqj"
Content-Disposition: inline
In-Reply-To: <20230720133147.1294337-2-sbinding@opensource.cirrus.com>
X-Cookie: Ginger snap.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6K/jTXohBWi27Iqj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 20, 2023 at 02:31:37PM +0100, Stefan Binding wrote:
> To enable the speaker output in external boost mode, 2 registers must
> be set, one after another. The longer the time between the writes of
> the two registers, the more likely, and more loudly a pop may occur.
> To minimize this, an mbox command can be used to allow the firmware
> to perform this action, minimizing any delay between write, thus
> minimizing any pop or click as a result. The old method will remain
> when running without firmware.

> In addition, to ensure the chip has correctly powered up or down,
> the driver will now poll a register, rather than wait a fixed delay.

That should probably be a separate patch.

Acked-by: Mark Brown <broonie@kernel.org>

--6K/jTXohBWi27Iqj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS5QHcACgkQJNaLcl1U
h9CSggf/fWKATarmWnlKrAg5ClZia9/eeWSg0KKHc06sQbmmP/KEhtCBpkvFTBOP
I15i7IhT3RoZgCuxf7TnbYKKJa5kfk38EIjVALr8tFA2JdhZduFP8uT25kcAoeMO
G6o5abKdyupUKaB0Aw40lDDZ125HszaGVkN7iz/xDGTdtnPnpvhL1Py6r9jBbxDk
YdOAxE0V3shZLMfpeKa1zPjlS/yg0PF+jIuYW/nb3Ebp8GuNaF5bSxI1Zqaq9u4s
7ecg09LG+cVWG2DcrJ2O559FEQ0Apvx3bvVBDX2vG0ZuO7tDPFgrZrfKpmXnGW56
RWZlhomLpsJYb82MQVGLNzSLd7gIng==
=b/2M
-----END PGP SIGNATURE-----

--6K/jTXohBWi27Iqj--
