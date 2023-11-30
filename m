Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B006B7FEBD5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjK3J2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjK3J2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:28:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8C28F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:28:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF0BC433C8;
        Thu, 30 Nov 2023 09:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701336488;
        bh=Y40c7C5K4pqWqN0+ur797YDI/9mVEZ6Ks1ldvsmx7Xw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lSmW7sAIr40qs7sVpiByKw3836RtLyslE4Z2pCVp3ew1G0O1xzzAsFv4yur2AXeyx
         sXP+tyITN0rH4VVwwj07rJQMQqgZHYVE5dP4QVUa0VcZmX2RZGLgfkM/feLGuQ9lOx
         1c0dLsarzcFBOlZGBwJg8kX15ElE/1TcrEB4X3E9uiYvuVMxW5yUp9XZyFnGorT7r/
         np56DQaUUst/8Kp3878aen7ewEQrTWEevW0RVYwLcdBO5jqS9grXW64J8x3ZzNcXNY
         eekN+VtCQ3H7pWBk0NeOO7e6HN24GuVu41fRuJ9H7gXv5ATVSIevXADeREdTktXfXI
         2+N3DUq05FyEw==
Date:   Thu, 30 Nov 2023 10:28:05 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Donald Robson <donald.robson@imgtec.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        matt.coster@imgtec.com, frank.binns@imgtec.com,
        boris.brezillon@collabora.com, maarten.lankhorst@linux.intel.com,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/5] drm/imagination: Fixed warning due to implicit cast
 to bool
Message-ID: <lb5weoobtasmrj2iknhstdphvflapum4mqjuiu4vlkn6qn2n5a@fssce52lpkeu>
References: <20231129153703.162642-1-donald.robson@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ochkfrngyobckdx7"
Content-Disposition: inline
In-Reply-To: <20231129153703.162642-1-donald.robson@imgtec.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ochkfrngyobckdx7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Donald,

It looks better, thanks :)

On Wed, Nov 29, 2023 at 03:36:59PM +0000, Donald Robson wrote:
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311241752.3iLyyFcA-lkp@intel.com/
> Fixes: 1ff76f7a5b45 ("drm/imagination: Add GPU ID parsing and firmware loading")
> Signed-off-by: Donald Robson <donald.robson@imgtec.com>

However, we'll want some commit logs for all of these. You can have a
look at Arnd's which are very good example of what we expect, but some
small description of the issue, the fix and the warning from the
compiler is usually what we go for.

Thanks!
Maxime

--ochkfrngyobckdx7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZWhVpQAKCRDj7w1vZxhR
xaS3AQDeq06UyHiu9THDsZTzr/zSZGHR12FDZ6s2HLy2D8THJAEAri1zu23eIU61
pAxOLvvYxy90pzq5U0RpJXweNGo/HwI=
=Naf4
-----END PGP SIGNATURE-----

--ochkfrngyobckdx7--
