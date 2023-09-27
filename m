Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A227AFF93
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjI0JNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjI0JN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:13:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D434CC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 02:13:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1247C433C8;
        Wed, 27 Sep 2023 09:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695806005;
        bh=5ni2a/DB+QDF/FumPKPmxhwyxTIswmMyT0P7nFDDOjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ol/Uxc7PcT/MtG/rPG+r7m+HvHrK7JO+Z40E79QzTlG7bW7aKNMPuoLcyB30Oev2u
         yJnnJUKl+pf2JidNgW7Uw7J+XSQ9mUzfviLiYb5wHE4YO3/CJSlluw83Wih1+TlMD9
         VMWvLPtA/SUgt0wLYBt4GnUmmDxY4TVaXUGuqoMDVTzbBKGcs0bzUUPMpkIhP0h8r5
         H9Y7w/9v571/uQQJPGwtRfZHzP58g+8XjwZNGjKUc2QnuU33HuoYU5yrqKicyjuV1A
         8e72codJFL4mEsdffKV+PW1jLf+xcb/wXxOsYIKFGRipodHP9B5RrTIFIqZ7WK0lC3
         YLo/abeR+foMA==
Date:   Wed, 27 Sep 2023 11:13:22 +0200
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang@richtek.com
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Allen Lin <allen_lin@richtek.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: codecs: rtq9128: Add TDM data source selection
Message-ID: <ZRPyMolOIjLBWXPC@finisterre.sirena.org.uk>
References: <1695780376-32301-1-git-send-email-cy_huang@richtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5fIGTM3mlZcEO9YK"
Content-Disposition: inline
In-Reply-To: <1695780376-32301-1-git-send-email-cy_huang@richtek.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5fIGTM3mlZcEO9YK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 10:06:16AM +0800, cy_huang@richtek.com wrote:

> Since rtq9128 can support 4 channel I2S mode audio data, there are two
> dedicated data input pins for CH12 and CH34.  But in TDM mode, input
> source was already drived on one data pin for multiple data slots. In
> this case, only one input source is needed for TDM mode.
>=20
> This patch is to add the data source pin selection for CH12 and CH34.

> +	SOC_ENUM("CH12 TDM Data Select", rtq9128_ch12_tdm_data_select_enum),
> +	SOC_ENUM("CH34 TDM Data Select", rtq9128_ch34_tdm_data_select_enum),

Is this something that's going to be changing dynamically at runtime or
should this be a device property that's set either by firmware or when
we're doing the TDM setup?  This sounds like something I'd expect to be
fixed by the board design.

--5fIGTM3mlZcEO9YK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUT8jEACgkQJNaLcl1U
h9AD9gf/XjwqNVU01O8geeDs/n0uPuij3TFEV+9FdQXoWkepHbUHI3z9MKx9QH2w
mrLYz27YdS0unjrkqXZk6L53daybs2KxJQCb1HlV3/YsFiwsWII6ZCYeAZASTwFs
SOXf8ZJmdkgXJxf0lYq+m7dNCG6e9EVqC2XlUWvbnUdVkYstni7TKSK7i/lvoT/1
+4WezkK8onTaoz3mprbc2TBDGfwATC5LA7E2CGZ0734rZd9XjyzY0wK8SPJn5cL3
1rNPGqvjzdc+f6VtpVKvZHK3JhONqKMCX+DWrf6Wx24QxjA5xzYpKMBviVSzEbMh
MDPRg6Bo5Dl8fezHnz75NQjf2hUBog==
=oiAQ
-----END PGP SIGNATURE-----

--5fIGTM3mlZcEO9YK--
