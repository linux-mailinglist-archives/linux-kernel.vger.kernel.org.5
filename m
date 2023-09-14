Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2237A04EA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238628AbjINNFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238525AbjINNF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:05:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5D21FDC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:05:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D38DC433CA;
        Thu, 14 Sep 2023 13:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694696725;
        bh=YHbADKQ6uhUELFMVb5GWya0ymsNBgFatl1XxYxyNA7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KWyJ43+jLMGArriTRLaEhSVb9CDR3iUsmGMnpCRQW7g1WMmbzEI1HqZohhDfDCHs3
         O2eSB3418GU3+/vtDV+wMVBjdmVxxsA/Qmz900QVLR39LFsZa/BoNk70w9Q2NtuBho
         tV3+5HVnP1yNR9jFoXtt1mEbc6wpTPD6RdHiZoBpMJK0kWoj16bv7y2YEdGw03eoc1
         +45inNYAbPlPLUpwj4RYbwgUqEO3QQh6AW3fQ8WCIra/5A25oCjlNazynbPXoIIJ47
         CezSY/QxP4FxPYCTMSd+uNo83d7a9OeIET/x+K2Ah2U4vI6FHg9TOKW4/P5mOBSAfc
         yh9/qaxIUZk0w==
Date:   Thu, 14 Sep 2023 15:05:22 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4] drm/ssd130x: Store the HW buffer in the
 driver-private CRTC state
Message-ID: <4norb2kxq4uxs3imi3qjxhyxpvnyf5cpl4sg7yyf3ydrykqhfl@cb3w4wstak7r>
References: <20230913052938.1114651-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dov6lznkfrfwqaip"
Content-Disposition: inline
In-Reply-To: <20230913052938.1114651-1-javierm@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dov6lznkfrfwqaip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Sep 13, 2023 at 07:29:25AM +0200, Javier Martinez Canillas wrote:
>  static const struct drm_crtc_helper_funcs ssd130x_crtc_helper_funcs = {
>  	.mode_valid = ssd130x_crtc_helper_mode_valid,
> -	.atomic_check = drm_crtc_helper_atomic_check,
> +	.atomic_check = ssd130x_crtc_helper_atomic_check,
>  };

Sorry I didn't catch that sooner, but there's no reason to call that
function a helper.

With that fixed (and feel free to fix while applying)

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--dov6lznkfrfwqaip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZQMFEgAKCRDj7w1vZxhR
xXIhAP9OFI6JCdZluvIUtxdFCWKErbu4NsjR8lWb+91ICcT0mQEAmOI1mtSwaYXY
8foP5Le4d57nb7aRnPbzxWptxjeoOgI=
=wLxW
-----END PGP SIGNATURE-----

--dov6lznkfrfwqaip--
