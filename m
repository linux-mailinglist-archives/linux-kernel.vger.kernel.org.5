Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0487E7AD253
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjIYHvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIYHvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:51:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CBFB3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:51:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8D4C433C8;
        Mon, 25 Sep 2023 07:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695628262;
        bh=/6MQSmGx1mb5dR3VLVPR+9qcZhhjqAAHj5u1c/tknOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tZIp4Iqg3VKmt09dKZioQPk8WETvjFp8oTQCek7f6iVWCROCjCBBzKaeEp6+KJvbh
         3Q+R2Nedw6rkzlFfJ4fVsh81d8W6fp1Fy2Ba7J85IM5Y7RbK/gJe0bj44H8u5Ydmua
         cqse6hKu36frwl1JcUDF3p3DfCbBA7wzgJYGywIY9mbQa1J63bv8u1eRV6srzVIxg6
         35VswgrGZJbLndKKHXzCkZHnB0u95AIJgthON9gP+/FtmdN1nd/gofopniaAzwZxlw
         pijZhFm0XrHxpplekK+TCFyAnnIWm63w2RVsn/MDxYDpMWsbNji+n9j/gWaYZdFAnt
         CHgwIIZu7GPnA==
Date:   Mon, 25 Sep 2023 09:50:59 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     wens@csie.org, airlied@gmail.com, daniel@ffwll.ch,
        samuel@sholland.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] drm/sun4i: dw-hdmi: check for phy device first
Message-ID: <a7nckzgnv6swcsig3me6p6cm2dyhkyq6ztwchfjmhrcm3swnjt@z4gqt3eoxxs6>
References: <20230924192604.3262187-1-jernej.skrabec@gmail.com>
 <20230924192604.3262187-8-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kdzhfjnsdzu22ejc"
Content-Disposition: inline
In-Reply-To: <20230924192604.3262187-8-jernej.skrabec@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kdzhfjnsdzu22ejc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 24, 2023 at 09:26:04PM +0200, Jernej Skrabec wrote:
> Let's check for phy device first. Since it uses much of the same clocks
> and resets it also lowers amount of possible deferred probes.

Much of the same clocks and resets than what? The HDMI controller?

If so, with the commit log modified

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--kdzhfjnsdzu22ejc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZRE74wAKCRDj7w1vZxhR
xfxeAP9gKhUvRbvUz+wdBFc74vLeovJgrKMtmy0FqKc1bxqtRwD7BdEXE2Jmpi75
N8hJgWrTfthY7MyzLNtdSGGcOPceDw4=
=4u+c
-----END PGP SIGNATURE-----

--kdzhfjnsdzu22ejc--
