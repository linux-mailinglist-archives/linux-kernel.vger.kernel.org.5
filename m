Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE5F7D859D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345391AbjJZPJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjJZPJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:09:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C80196;
        Thu, 26 Oct 2023 08:09:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850A2C433C8;
        Thu, 26 Oct 2023 15:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698332984;
        bh=yFCeUvYUN8ddW5lXFRkDIKczNrKiL8ahYwXjs+NIZKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UGjKSJXgr1kKDUyBqpmKI4u63Y1D3+ATox6a9sFyG8bTXklDrSPk0un68G/IEpTrY
         xRl9pKhjg6Apujz783DfKuKOMmuhqEDmLNH895Y5S0bK8ExZEM+j88oy7pZztRNfj4
         s+F6x9iZkpZXVRMwT7n2vwTViltYp444oIS14sq5vtD0z3upWaA2Dw6wKwmloIoiWv
         HPmDRsiieiUGrmbyWFaC10HjWHmofhgtOfMrJWa9P+CbIcYHvgwWZR+Q3E6pVOG2Gu
         mrzB0//dIcwdKipr7w4jeHvDg6F70BJWG4ATBock1yAlUENgzanSE0X3wQumtDJ73B
         eaS0wmPCTIqaw==
Date:   Thu, 26 Oct 2023 16:09:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-sound@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v1 8/8] ASoC: cs35l41: Detect CSPL errors when sending
 CSPL commands
Message-ID: <baeccbb4-5015-454d-a60e-861f67ce0f3d@sirena.org.uk>
References: <20231026150558.2105827-1-sbinding@opensource.cirrus.com>
 <20231026150558.2105827-9-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0HftNnHLLsLtjwh6"
Content-Disposition: inline
In-Reply-To: <20231026150558.2105827-9-sbinding@opensource.cirrus.com>
X-Cookie: I'm also against BODY-SURFING!!
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0HftNnHLLsLtjwh6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 26, 2023 at 04:05:58PM +0100, Stefan Binding wrote:
> The existing code checks for the correct state transition after sending
> a command. However, it is possible for the message box to return -1,
> which indicates an error, if an error has occurred in the firmware.
> We can detect if the error has occurred, and return a different error.
> In addition, there is no recovering from a CSPL error, so the retry
> mechanism is not needed in this case, and we can return immediately.

Acked-by: Mark Brown <broonie@kernel.org>

--0HftNnHLLsLtjwh6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU6gTIACgkQJNaLcl1U
h9BNxgf9ERaHvIciC5wdcj6QKeS1hbJ/n9tkYPUFkD6jh60PrHm5MdAnEPokRYyE
gjiT8Y1t/MDRw8oVp+LMQvUFoMvmIxfkcNic9ks0VN5zdXt5wmZYCUZb3mowY7lC
SCUwOrtZLVJutWMc16v+wl0Gc0MmeTFue30PsxCvh2FIGdqiDnE0cPJe3c+1II9T
F9R5bwaYdYsGFjnCmWw6RmNWK+f8UYUqW6u/CyrcMg26hsMAPuBEG6zSkaORJIKF
uvxh+d6vUKAe3SBz81iT1pYFy5Ets+13lUQ+0KPKL2GjMdWzHqm4qJ23mk9z8La3
rgrQHeA4m+PAVqlZhZ3ZfWypxPvVdg==
=JNLG
-----END PGP SIGNATURE-----

--0HftNnHLLsLtjwh6--
