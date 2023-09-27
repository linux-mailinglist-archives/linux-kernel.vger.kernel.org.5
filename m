Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546E97B0798
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjI0PEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjI0PEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:04:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D52139;
        Wed, 27 Sep 2023 08:04:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E849EC433C8;
        Wed, 27 Sep 2023 15:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695827049;
        bh=Fh7uxefVzjYj+SNOl9+w47xMZ9VhHXNUi7h48gwdBh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OoYRbQhnlWD7NYoeVEzx8sS/nAb65g+FNCHqp+ywdfIprHlT/QzZGQLSbeOj7Y2LM
         IMGOdlwjm+7kasFVsfUSiKLPFEGhvQSNyQz535K21nFdaeX6KScBgAfsM3ilqdExTv
         Xxb1qhd6S/mCRgalO1Zlr6moHX6/MvF/IR7666OrBxaPa51LTQ5gj8Pqxa6/R2RQc6
         CDP7DlmODJfbNNsbXhtMnWpjmVVdkAubl1QVR7BAKhUA9VuxLgSobU9cxLpXbVht2H
         IbhZTwUbCD03D5sTI3lS1AdMFNQiOQCLTJoJBmVmDf2RcFBJdUsAptDJpkNCis2N7R
         yNgtJHlkl7VLQ==
Date:   Wed, 27 Sep 2023 17:04:06 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, srinivas.kandagatla@linaro.org,
        bgoswami@quicinc.com, Thinh.Nguyen@synopsys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 00/33] Introduce QC USB SND audio offloading support
Message-ID: <ZRREZl6XLzyY4K95@finisterre.sirena.org.uk>
References: <20230921214843.18450-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v5MN6DoLWR8mu6Uc"
Content-Disposition: inline
In-Reply-To: <20230921214843.18450-1-quic_wcheng@quicinc.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v5MN6DoLWR8mu6Uc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 21, 2023 at 02:48:10PM -0700, Wesley Cheng wrote:
> Several Qualcomm based chipsets can support USB audio offloading to a
> dedicated audio DSP, which can take over issuing transfers to the USB
> host controller.  The intention is to reduce the load on the main
> processors in the SoC, and allow them to be placed into lower power modes.

I had a few small comments in reply to some of the patches but overall
the ASoC sides of this look fine to me.  I didn't really look at the USB
side at all, I'm not sure I understand it enough to have any useful
thoughts anyway.

Thanks for taking on this work and pushing it forwards!

--v5MN6DoLWR8mu6Uc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUURGYACgkQJNaLcl1U
h9Dqbwf+IjGM0SqVY6JygsCSY//2jwGE9TwO7eKPIstE59vTT8nUChjguFf/r4fA
yntz81LedOC/DpouBDxrsmSo9RE0YK9Dz5G5jQblfdR5ezb6lNsuYImHiDf0rDqF
59UW9ToO4gBFmb+fejb8P8bBYv0Ujsph0giOCxV43qnV0+sqpJwJ61ljpsp9nsdG
/8nPW67BrOuCnyVZiB6/nObyEh1hs3yaFJLwTcYePx1/fSBgvpdcnXZeM/XZXKKp
ePHfKstLMBqYwYjgkKtO/dCYjTyPwAYOSew8XUSkwhzITEd77oxS3Ekk7eTebZEJ
UZ0RbZmQ9jOt4uNmDAujdrkq4KvcaQ==
=IXNE
-----END PGP SIGNATURE-----

--v5MN6DoLWR8mu6Uc--
