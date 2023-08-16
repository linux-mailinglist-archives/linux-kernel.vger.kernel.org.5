Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8538C77E785
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345199AbjHPRYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345202AbjHPRXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:23:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6E0E55
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 10:23:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4C2B61DC0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 17:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184C8C433C7;
        Wed, 16 Aug 2023 17:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692206633;
        bh=QdESuSYnL8AsE26Bme+ZtkoXkjk2KxVm4wYp+9LcAt8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aVAdaz4QQvvfZS8r6Ev1hVPnCBGdi7GtkXz8CO2CHkmosyC7vMnJL04duQHYAi1wo
         CGVhRxCFvb1ajS0kdvi6gmcrqt4p0dlA1fv5CcCo+8IykTorg5LwRrv14TjLDKnmPv
         YCvc+Sb3bTscnoGfHR0/KWHh1GgD5KYn7zj27TCtHrcdwVTcCdXtfFsGn9mYE1odlm
         KkFo1l+TQKxw/+WNCf1Ug/KOSLhSYRdLw/YoBoZAuyapfIfqeX6khBIQsIPs/NsI9P
         cK6pGxUT2i3d+D4YL5nM28o9RuaByjrTH/G4gxsAYUHmLJCzKaujZacY6yZ/ElHdFr
         fGVHwn8r0L3HA==
Date:   Wed, 16 Aug 2023 18:23:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Maciej Strozek <mstrozek@opensource.cirrus.com>
Subject: Re: [PATCH 2/2] ASoC: cs35l56: Read firmware uuid from a device
 property instead of _SUB
Message-ID: <df6c3dc2-e530-46f6-b4c8-0619ae23a794@sirena.org.uk>
References: <20230816164906.42-1-rf@opensource.cirrus.com>
 <20230816164906.42-3-rf@opensource.cirrus.com>
 <c3e42efc-9ddc-4788-85f7-cfa350d75d43@sirena.org.uk>
 <b244708a-414e-1f56-61a0-7c183f8ff45e@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v+mClJTOr4lcjffQ"
Content-Disposition: inline
In-Reply-To: <b244708a-414e-1f56-61a0-7c183f8ff45e@opensource.cirrus.com>
X-Cookie: Old soldiers never die.  Young ones do.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v+mClJTOr4lcjffQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 16, 2023 at 06:09:52PM +0100, Richard Fitzgerald wrote:
> On 16/8/23 18:03, Mark Brown wrote:
> > On Wed, Aug 16, 2023 at 05:49:06PM +0100, Richard Fitzgerald wrote:

> > > There is also a need to support instantiating this driver using software
> > > nodes. This is for systems where the CS35L56 is a back-end device and the
> > > ACPI refers only to the front-end audio device - there will not be any ACPI
> > > references to CS35L56.

> > Are there any existing systems (or might there be given that the driver
> > is in released kernels already) which rely on _SUB?

> No. Nothing has been released with CS35L56.

And nobody's going to pick up a kernel with the old binding when they're
putting together a product?  If we're going to make this change it
should be sent as a fix in order to minimise the risk of that happening
but this patch doesn't apply against for-6.5, could you rebase please?

--v+mClJTOr4lcjffQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTdBiQACgkQJNaLcl1U
h9AwiQf9H6t3O03JUodNHMdEYNm7NMS9jN/Mdov3ejbqZreMqcjwICluPuixXxSx
KjEcrQhr/zmFHd569MLWNJ0rkyWoYUOyVS8NAfMmvWpGFGbZtlY/omtwAdefh0v4
2yNtmVIPaay58PXqv51rPog/3g7uP03kRUwdNY8LKBWJ7mT6SmqzwVxpgzl8Wv9G
1bERXadY3EUQwcKV8njkXDVAdouHKhEU0FINLflDD4WIdvxwGbBvWt0iHGvcgvOH
gU0sLDkaZiIz4bbnywn8RoYun5LcvHgvFYyrJQcK9VpMLBpzGgCHM/uY1zfVsimQ
bqmNmWDeOEP75fgE/jAKFxIEMaLeLw==
=l2IT
-----END PGP SIGNATURE-----

--v+mClJTOr4lcjffQ--
