Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E506F7E1E5B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjKFKcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKFKcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:32:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DEDD8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 02:32:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37502C433C7;
        Mon,  6 Nov 2023 10:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699266762;
        bh=PTBD7C7fHaLaaDpSPhX3CMSbWdu69dXBxjUtIf+7cYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DYs2SZMLRNz5aiPEe1hfLDeOnsS/HgdLLvXAkdykmZHXTsuDktn5q85N16gJBcERZ
         JghTPUYUj/WiqwIKuy4rWBdgbBD308mJSQsBGPFGLUHXqAfNLl/rPaho6S7tx3JUUk
         hZnPPG5b3V7+9UV6e//ikWXvt+aFtD8FA769pbbR5xF3C6J4MI/gayR/v3d0Psc7+m
         xs4hn5iYLdL+uFzHzM+H9bmyMUl1d15HjhYZ7GRXsZ8atuPi4dEasln34vzdLGcugP
         IMLD30dYtURF0XfMyw50SwkjZSviObD4QYJtRnm7X8S7AMfD9p/3KBi+vQzqZDzbP2
         DKSQ4AWHpp1YA==
Date:   Mon, 6 Nov 2023 11:32:40 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     oushixiong <oushixiong@kylinos.cn>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/atomic-helper: Call stall_checks() before allocate
 drm_crtc_commit
Message-ID: <6yqalig6nvnlpt7loetugjdgp5z4w3qwhpqpzzsygffp5w32d6@guq6v3g2z7tq>
References: <20231106073742.158905-1-oushixiong@kylinos.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bagq6jfn47h4mlnv"
Content-Disposition: inline
In-Reply-To: <20231106073742.158905-1-oushixiong@kylinos.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bagq6jfn47h4mlnv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 06, 2023 at 03:37:42PM +0800, oushixiong wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
>=20
> Calling stall_checks() before allocating drm_crtc_commit not after that.
>=20
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>

Generally speaking, we need much more context than that.

What bug did you encounter that makes you say that it should be moved?
How can we reproduce it? How long has that issue been in the code? What
makes you say that this is the right solution?

Maxime

--bagq6jfn47h4mlnv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZUjAyAAKCRDj7w1vZxhR
xQw6AQClvst8daaSOBV5ptS1/p9TCemvn6ZjiXg0Vqm+6z8yxwD/aAgROmtskcol
T+ZUxPYGekPgmrBGoCVcitgZ3Ztc8Ac=
=ghBa
-----END PGP SIGNATURE-----

--bagq6jfn47h4mlnv--
