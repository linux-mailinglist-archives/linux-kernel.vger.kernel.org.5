Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091307E2A6A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjKFQyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFQyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:54:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E409C0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 08:54:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB4CC433C8;
        Mon,  6 Nov 2023 16:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699289680;
        bh=3xXxDMffdKTQLBQnTzP0e5UhT4Stidfa/ERx0ZrGjwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RR/0h139Zyd+825gFUPbn/Da1UOshWwS2bhxATJ8tVlAkE/Vr5s+SCCKfWHuErZDt
         +rPZvHoBjOCF53p/qstq1vAM/cqAxvgLyv7/Fd7uorisjkOknPQaPArzXDW3BuZVH6
         dlbonxwgM4VBxpsNo7wAju/M8lUvxRj5cuYJdzAwAvUbJKrZj7Ujn2H/C8Nv41egyE
         BMaahPFHSla7YttBG32l7jb+epo2eY/kqL74Vc84V16fYUcEuULVjt4kcYS3uCURSw
         2nDVwr3tlszQdIYaax8i9uf/f/ttpNiQTdYHNG8KnREZLC0V7kIw95zhieuFczV5yP
         vhkKe4yHmaBvQ==
Date:   Mon, 6 Nov 2023 16:54:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Brandon Cheo Fusi <fusibrandon13@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: add regmap_update_bits variant to autoshift mask
Message-ID: <ZUkaTcV9cYxKjmap@finisterre.sirena.org.uk>
References: <20231106163406.33952-1-fusibrandon13@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fDKSb34zooPaposF"
Content-Disposition: inline
In-Reply-To: <20231106163406.33952-1-fusibrandon13@gmail.com>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fDKSb34zooPaposF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 06, 2023 at 05:34:06PM +0100, Brandon Cheo Fusi wrote:

> +static inline int regmap_update_bits_autoshift_val(struct regmap *map, unsigned int reg,
> +				     unsigned int mask, unsigned int val)
> +{

Really not a fan of the name here, and in any case if the shifting of
the value is an issue wouldn't this be a good case for using a field?

Please also add kunit testcases for new APIs.

--fDKSb34zooPaposF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVJGksACgkQJNaLcl1U
h9BpPAf7Bnykb22GZAW2TLe5X+BWpxuHcrWH3eKNLm7UAzwl03PmGcFmf8bT1C5q
jF6nSL1PkO1xyNnpdXDPyC7xi+qMhiK4rc7eA9/1wkydf0aXjVIlpr9Thdfk5XpF
yJ+mAPI2RBklovOFxWt6nQJAolu8k4Itfd5WzNXuB/OgrVwVneNzE0CLMZjcoDeM
WBnwKFB/3WaTZ3pIeLrd9UCHuOwdNOIV6hm2/a2LWlafjc656/10VpGfjGXj4mR/
vpwVLgeljfz+FkjFAN/InksjJyOSB/fKRUTRlJ7SWfM/8N7e1MrzUbzehpHKO59y
pkhgAk7dy2Devl2o7A0RMeiP3ylv3w==
=qlyF
-----END PGP SIGNATURE-----

--fDKSb34zooPaposF--
