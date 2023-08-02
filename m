Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F013B76D559
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjHBRbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjHBRar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:30:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6BF4482;
        Wed,  2 Aug 2023 10:28:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1BB661A7E;
        Wed,  2 Aug 2023 17:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DCEC433CD;
        Wed,  2 Aug 2023 17:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690997308;
        bh=fZOqG176cU7NTL9kF5IUl1tJY6WVyVd2yvYUysK5c4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s2qTYnVTVxmoM/7E/k8f+YVgG+VoGlUIkCW4hUuPFLuW45Gpukag9xjM4G3yNBRFf
         F9fCcepA0IJAxVfYgBXTi8XC7/fq7AcFLOvA/w5RvjjHUI+sm7qsyIdmxRSymToi9l
         yElDU1nHeyyAjVpoQg5Q5NsbrP+YDFUWrR1m5qES87cZqrJ3NPRmGCKpcEEFbO18tz
         PjSrySyhW7OxIuJFh+AsVT0s3SIttTqOByGvWzsj/DE8J1hbh+ezaer48zzC6FqYxG
         UbTNdG7cNb+U30jy6EPoOvwQU08wmaPJKQecvoO+Q9ZB6nl+DEYqcINItbtYUY9/HA
         OxkuVgfo611Cg==
Date:   Wed, 2 Aug 2023 18:28:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Takashi Iwai <tiwai@suse.de>, Hans Verkuil <hverkuil@xs4all.nl>,
        Shengjiu Wang <shengjiu.wang@nxp.com>, sakari.ailus@iki.fi,
        tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 0/7] Add audio support in v4l2 framework
Message-ID: <844ef9b6-d5e2-46a9-b7a5-7ee86a2e449c@sirena.org.uk>
References: <1690265540-25999-1-git-send-email-shengjiu.wang@nxp.com>
 <47d66c28-1eb2-07f5-d6f9-779d675aefe8@xs4all.nl>
 <87il9xu1ro.wl-tiwai@suse.de>
 <CAA+D8ANmBKMp_L2GS=Lp-saMQKja6L4E6No3yP-e=a5YQBD_jQ@mail.gmail.com>
 <87il9xoddo.wl-tiwai@suse.de>
 <CAA+D8AOVEpGxO0YNeS1p+Ym86k6VP-CNQB3JmbeT7mPKg0R99A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MdG0m2yIP0FKio4T"
Content-Disposition: inline
In-Reply-To: <CAA+D8AOVEpGxO0YNeS1p+Ym86k6VP-CNQB3JmbeT7mPKg0R99A@mail.gmail.com>
X-Cookie: Humpty Dumpty was pushed.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MdG0m2yIP0FKio4T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 02, 2023 at 10:41:43PM +0800, Shengjiu Wang wrote:

> Currently the ASRC in ALSA is to connect to another I2S device as
> a sound card.  But we'd like to the ASRC can be used by user space directly
> that user space application can get the output after conversion from ASRC.

That sort of use case would be handled via DPCM at the minute, though
persuading it to connect two front ends together might be fun (which is
the sort of reason why we want to push digital information down into
DAPM and make everything a component).

--MdG0m2yIP0FKio4T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTKkjQACgkQJNaLcl1U
h9A05Qf8DvVF+7HkTrWpZeLLTiun4dI0bUwdJ7dBv/9eO2gLeD8aonbFN/iOGUS3
6HQafM/WVAHT67s9CThpIHGG8oWuubOG2Na3mKSs3xD+zRf4NVxpUN9+2JclaYtt
zKwBd+OYExLP/x/6qTGyqQi5BC0pmgpk73+mQtRRVClGOdjsfE3ke6TWvOBsIUsZ
+l3hAMxeKmIgczEq5MkPahD2mfN0CZgbCwaFA2zriaJXCPxPP/YFvYf+Mli8KDBK
6eRZS7e6SHICYPyqngTDICpj6MbiIxCHm7qIKEboyK5C0cW8PR52o6fbyN0XAHxc
sNfbpJop+bjYwFJQnjwlPTzGqO5cgg==
=0H5v
-----END PGP SIGNATURE-----

--MdG0m2yIP0FKio4T--
