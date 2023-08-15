Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135FB77CCFE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237105AbjHOMy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237150AbjHOMyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:54:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877989C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 05:54:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CC446164D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:54:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3732C433C7;
        Tue, 15 Aug 2023 12:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692104085;
        bh=dDxA4P/ZLn0zQb28IKxF87UEdyaPxIaZJh97gjQPCRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QWVFPbj8W++h4LpRMo1kgy+7LokGjP+dYNiWn9M/OiNenkud+wNPDjergae57ty2d
         jnI/+/NGZmyNnAaf6VxdGgvOyY1CxIZC/kYOcEquOde7/RfPvrI1UupMj89qfoH/d7
         04lNatHOWvkk1GjeW+pkT/LXeko9fVSXyTPN1ccmWLTS2fYVk/KJBkrKuCO9ZJMNB6
         1qrbSaxSPV2AFjMKT+MMJgJ2WUQDdxUXsmsdOYF/G5lPa+v8y/yblTUEObJd1K7dbS
         m0kUoci+TqG18GhSv6Qnj1UYK8gfBhI1A7+YGh9h2rVI6h4aWXgfUovPB2/IB2L8EJ
         8NslK7xU1FXRA==
Date:   Tue, 15 Aug 2023 13:54:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: fix -Wvoid-pointer-to-enum-cast warning
Message-ID: <94c059a6-07bf-4887-8c67-b8b0724baa49@sirena.org.uk>
References: <20230814-void-sound-soc-codecs-rt5677-v1-1-5c468c60fa37@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EmsSKH7ZmGf/qlZE"
Content-Disposition: inline
In-Reply-To: <20230814-void-sound-soc-codecs-rt5677-v1-1-5c468c60fa37@google.com>
X-Cookie: The meek don't want it.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EmsSKH7ZmGf/qlZE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 14, 2023 at 09:58:56PM +0000, Justin Stitt wrote:
> `match_id->data` is a void* and as such is being truncated when cast to
> `enum rt5677_type` which is only int-width.

This doesn't apply against current code, please check and resend.

--EmsSKH7ZmGf/qlZE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTbdY8ACgkQJNaLcl1U
h9AUKgf/Vhx88QCeNdlUEOFEPe17Q9i+vhTRysJ3Y1UFUFNv8cZ5HOebgWf5eYTO
lf5rHb+Y+tuT0+8HCQHVJtVGI3/gZwDzIVusQvcBRsLjBtEafkkGqfswhD8k8e9d
nQ8XT6a4kPc4/GYvS+YXeZoOSiq97cPdbbdODPuQB6UmaQreXLChHHan1ya6gfcH
bCr12qm48qfAJsK9EUUTcvPFyMpnrwC5CWIBoGrdi6eSzRHbOa+rGxdgFWorYPxE
ua34eCXIOxhBhbF15pCD5VyuRTbitN7/fhQo6HC2eszsMyv7u7wKTS3pBFl2roDc
b67QT9S3kboOvHRDaJYu+Ekcxo8WBQ==
=77Zb
-----END PGP SIGNATURE-----

--EmsSKH7ZmGf/qlZE--
