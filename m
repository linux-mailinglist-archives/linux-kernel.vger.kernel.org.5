Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379A2787A98
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 23:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243730AbjHXVeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 17:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243767AbjHXVd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 17:33:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E8619A0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 14:33:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2AF067748
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 21:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E23C433CA;
        Thu, 24 Aug 2023 21:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692912835;
        bh=fxrovyzR2qyC/35gzQwS0Hw3bLbJVs+APQFunkdyr+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SB9N2Q4pPc0p20vrS5xm9Ra/6gEXNj9Rq8yx9+uMQF0dT1+Ycd4QWR5N1Eh5ZuVlX
         7t5JG/98gp4bx3e/EQUX3nybfGmZIxRt6KhZrACpvamWAkk6YpdtqEFtvwUwSIglxi
         85R15dricbrSuvbUWHOEhDcbhlcOZB59TAWhDzNqKM9RFrkYxnsQvo1aOlNZkXKmbC
         guO43Yo6pI+aDlfZ2LWhEBDsl+/tN2K8FhOtM3moFF8N5V4fhXEo7tH8Y8SOIkroAb
         Nmob/8H8SaCszKMhLbFWqnJDamlab9UFqEhHYULA2TbuzoqjlcamlO6ln+QYhpja/D
         scNvCvztPtluQ==
Date:   Thu, 24 Aug 2023 22:33:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marian Postevca <posteuca@mutex.one>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ASoC: es8316: Enable support for S32 LE format
Message-ID: <ZOfMo4Cb2zd1Km3H@finisterre.sirena.org.uk>
References: <20230824210135.19303-1-posteuca@mutex.one>
 <20230824210135.19303-2-posteuca@mutex.one>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="izoXqi0eacbdbANQ"
Content-Disposition: inline
In-Reply-To: <20230824210135.19303-2-posteuca@mutex.one>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--izoXqi0eacbdbANQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 25, 2023 at 12:01:32AM +0300, Marian Postevca wrote:

> To properly support a line of Huawei laptops with AMD CPU and a
> ES8336 codec connected to the ACP3X module we need to enable
> the S32 LE format.

What's the issue?  The AMD code looks like it supports plenty of other
formats in most places.

--izoXqi0eacbdbANQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTnzKIACgkQJNaLcl1U
h9De4gf+NyKcVoNzicgu5JcsQYUbDa6aMnVmNzuump5WcxgPiDL0KM43cksATvmN
5MBo7FmLmm5IYP/mAkMTFZuJG8zLhSxYEgTasFi17DvbLUC8I+FxkOFkMjdW0bV0
J9wZqlTsLt770U2ZV11rZ8wiRKBJSlS7PxpUBYxLq/urPHnqUoMbE93+og5qFTgC
WDVGKmoNIsVgt7ntjjhaFCRgup/Cjh4bP4ye70ing6jIVdr27CNnGBJsB0GvmXbo
z5DgT7ovi76hPqZfh6Bque5142yJZDrR4ETyKwyT1vWvpawNQlCkG4tVCYWa3SzI
DzHpDfMrm/tlNoxrTQymQbT+FBLtWQ==
=QjEU
-----END PGP SIGNATURE-----

--izoXqi0eacbdbANQ--
