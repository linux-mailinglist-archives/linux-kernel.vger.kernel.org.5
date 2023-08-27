Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6033E78A362
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 01:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjH0XXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 19:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjH0XXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 19:23:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B7EB2;
        Sun, 27 Aug 2023 16:23:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AEDE621871;
        Sun, 27 Aug 2023 23:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693178584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AsliRhNO73Wv1qvoNEQSZWjnPMwo7kcWIi6QH+B2CEU=;
        b=qIIdDsghos2WLe4LD4cwZE1jD4Hf01jLRp8yrIUzupkuy5wlr5VozAVxM1txKWI94ZXdNn
        xoug/avYO5zPsS32TZgCpvyanU3tjCMDTt9+MkXRZRARP4VkXdJUpicv6p6AHxaq1wGyAc
        3xGt+3N8/JJwR68XLzawqieoj1tErU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693178584;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AsliRhNO73Wv1qvoNEQSZWjnPMwo7kcWIi6QH+B2CEU=;
        b=iSWMIOCby7V3jVlYAVB9I4px58hvver7jeoslCyol6fg+YIyBeuzT2Y6Zrj70vQhGVW9D2
        ZhK8AJledPoK/IAA==
Received: from lion.mk-sys.cz (unknown [10.163.31.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A20692C142;
        Sun, 27 Aug 2023 23:23:04 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id 808E72016F; Mon, 28 Aug 2023 01:23:02 +0200 (CEST)
Date:   Mon, 28 Aug 2023 01:23:02 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Gang Li <gang.li@linux.dev>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org
Subject: Re: [PATCH RESEND ethtool] netlink: Allow nl_sset return -EOPNOTSUPP
 to fallback to do_sset
Message-ID: <20230827232302.gktg5g7vi7onql3l@lion.mk-sys.cz>
References: <20230821033419.59095-1-gang.li@linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pc42tpph2gx3mqxw"
Content-Disposition: inline
In-Reply-To: <20230821033419.59095-1-gang.li@linux.dev>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pc42tpph2gx3mqxw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2023 at 11:34:19AM +0800, Gang Li wrote:
> Currently, nl_sset treats any negative value returned by nl_parser
> (including -EOPNOTSUPP) as `1`. Consequently, netlink_run_handler
> directly calls exit without returning to main and invoking do_sset
> through ioctl_init.
>=20
> To fallback to do_sset, this commit allows nl_sset return -EOPNOTSUPP.
>=20
> Fixes: 392b12e ("netlink: add netlink handler for sset (-s)")
> Signed-off-by: Gang Li <gang.li@linux.dev>

Applied, thank you.

I only changed the Fixes tag to commit 6c19c0d559c8 ("netlink: use
genetlink ops information to decide about fallback") as that's where the
need for special handling of -EOPNOTSUPP started.

Michal

--pc42tpph2gx3mqxw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmTr2tIACgkQ538sG/LR
dpW5wQf/TCyyGUeLJq99yBV7LMYpnUWQgiW0ua4XIxu3EMkE8SPuxQQ8bGRLaf06
qFDEkFj12ZC8UX8InAJW2Y9O+pqCuou5u7w8Z1icqzhC6lXWJEhYTLdsJXQcOkaJ
LYQTf+wnx7ahyj8jxFlFqFHdcgT77B8e1yXPoABMRSSchMFvvPdygcVGtiZ+5kC2
PplxxkJ3oNmEBOujtvNQHjN20G+isCUYz7KziVp0V/mn3YefsRP7JW+3T40K04QJ
X4x6xHVtwY2iwHihPY5V+6b7bVVOt2L5G3wDlAqlrIFLwhxRZb6yvspT8gH8A8rv
tYQGZfeTUn9hJ4UbaomgRSrGLZr4Qg==
=dvS/
-----END PGP SIGNATURE-----

--pc42tpph2gx3mqxw--
