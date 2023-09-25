Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2648B7AD244
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjIYHr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjIYHrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:47:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E928A10A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:47:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C379C433CA;
        Mon, 25 Sep 2023 07:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695628038;
        bh=ai0ndMiQTr1EgM1mkMSEcaZf/fv6l0ZrtbSfG0oo/dA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ae/o+N14zek9vY+lt5L+r231MVLkY11Kfh0zo33ZxOyod/sJna5kxFd1taJzqjmvL
         AApBTF/+uHBFSHD3ZHc8zuoRJc8iC7RFDv/wBLWevcgz6847H7+InmCCDazqM/s8hj
         HHnfJGPwjrVrt9g7CeO+dUZr4s0zoR1LU2UbNNl3zOs9YSgBmjnB6rjfPk5eHaUDxJ
         Pvr4r8tLwk6+zjfBWeUIkr7cYOtj9JLRcPG8poEHH3DEWdikSHnL4sBUaJoLPHgwcW
         6c/3EoMXerwD9ZzvQ4Yu4+rkQjBUIebQ6MPAxEhlStWRx28v7p6Sx5cvFnKposvKHz
         KhJ5C7u2A2BeQ==
Date:   Mon, 25 Sep 2023 09:47:15 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     wens@csie.org, airlied@gmail.com, daniel@ffwll.ch,
        samuel@sholland.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] drm/sun4i: dw-hdmi: Split driver registration
Message-ID: <rvqcfohw4i4y7amod3a5e4u4tkorqmaekvikyqg3fibvy53dsd@be4lk4ae35hq>
References: <20230924192604.3262187-1-jernej.skrabec@gmail.com>
 <20230924192604.3262187-6-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eocwwgd3x2awngfp"
Content-Disposition: inline
In-Reply-To: <20230924192604.3262187-6-jernej.skrabec@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eocwwgd3x2awngfp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 24, 2023 at 09:26:02PM +0200, Jernej Skrabec wrote:
> There is no reason to register two drivers in same place. Using macro
> lowers amount of boilerplate code.

There's one actually: you can't have several module_init functions in
the some module, and both files are compiled into the same module.

Maxime

--eocwwgd3x2awngfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZRE6+AAKCRDj7w1vZxhR
xU0jAQCEM+c6zLXLlT5j6S8sGRwxntW1Bcyw5my0XKT7j4XSbgD+JtiNnKl2B/qf
51/BgWAYSfhdkCz0N7MFiMbhOasGLAY=
=zuMY
-----END PGP SIGNATURE-----

--eocwwgd3x2awngfp--
