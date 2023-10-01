Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60007B46C5
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 12:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbjJAK1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 06:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbjJAK1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 06:27:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1B6EC
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 03:27:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815A4C433C9;
        Sun,  1 Oct 2023 10:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696156056;
        bh=DxGyjWjHTUQSGvAYneZAx2lx1uJSp6o0TO6XeuUGZmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lx7PzT+VXZnHJG1WevUCUKF1YNah83tz+T7s/Cqkt6y+cwQ2WvvPTUJmEYngV3sUL
         LsTH3/nQrN61nNdAD+9yhwxkhPsl5rKzx3O5AIbrlb1KbZGvozLHAdjWiAGk/no7sU
         x8fSClmDfKoPmq65W6H1cLmz6niUYDGzdC/bbae7v+/R0F+L0mvsr8pPvbLygXYepj
         JOx1BPyX1XH/tO031631FtlukHz/5fLRZMUEQejPYCP764ybKhI2RijC607E+Lezxc
         ul/3HiOzeJ3eFGYhCfOf2W5c6O7HADw3vQReLWDPZL7ex1z88cxB5PEE8y/QPebDxc
         Kfn7EM80k9n9w==
Date:   Sun, 1 Oct 2023 11:27:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: adv7511: Convert to use maple tree register
 cache
Message-ID: <ZRlJlW/6fZeWjEpF@finisterre.sirena.org.uk>
References: <20230929-drm-adv7511-v1-1-b871b28ee594@kernel.org>
 <20230929213817.GB28737@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UUmRimESPwoHTN8f"
Content-Disposition: inline
In-Reply-To: <20230929213817.GB28737@pendragon.ideasonboard.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UUmRimESPwoHTN8f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 30, 2023 at 12:38:17AM +0300, Laurent Pinchart wrote:

> Out of curiosity, is this part of an effort to drop the rbtree cache ?

Probably, yes - there's probably some drivers where it will make sense.

--UUmRimESPwoHTN8f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUZSZUACgkQJNaLcl1U
h9BxmggAgqyJ81ofkMwsTZ+GzDAAAwBb+/SIJtB7aqJg+Vh1/L4NYvaHarCvxL8t
je7RCjIbkQQGB8BXBEeGunr6FqJoj1+37SmV4Qy5MDQhOC8DNempCqpzMgEAbgrB
2OaryKHXgZRF0xKfCmJT2kPQcMK3Ibn+YK//0Y9Ee2LvrAuU5gQtHFwmI5mZCh57
pESuf+mi5QIC4XWI+7g1sBCqsMtIVcDTfAz8/ZtH3JEgRmEr1rYJKkd91nGSJ6SO
Cv0RrbTyjrWsPy7jPDD2HUoRh/rDXIg++YaBfccOuuW8YsuIbDDQ8tGWR3+Wi0z+
+9CngyLjEXD1PWVHR4LGh42s84LSWA==
=03eq
-----END PGP SIGNATURE-----

--UUmRimESPwoHTN8f--
