Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B7C77E336
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343496AbjHPOFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343518AbjHPOF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:05:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB103E48;
        Wed, 16 Aug 2023 07:05:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7967164098;
        Wed, 16 Aug 2023 14:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B69C433C9;
        Wed, 16 Aug 2023 14:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692194727;
        bh=FGkS4ih0i9IQrsdNdewKD4GHzQlsrdNCp/QxM1kYKQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NEjc6mlUBLa2InyCxlwS9MCJr/+1GBk2EQTI1yn5mWUCPJFRUgnRlPv1EfcDpp9RG
         +p4kLaIbQ9Ps76p/mBmp7TgPfxnSkKwn/TbUXvrJWXxd8IfUkRdgi3owo9SS8FG+iN
         gp9nhADVRWebs9rETkdrr2oWoUL7OHBQOA3EHIqARUhu3vHcsCQ4qp9SEgeg9lby5c
         B2EBG2ry6+bg46kt/VgAF6JqVt0ibZJd0MfxYKJxXuOni1m6sVs8QQS8n7mCQdCiqb
         5Q/xxBJEvbeSBgCEmZB7fIPYTaJpgOKRhUgXFqqxpEPFsTgnbYVYIxonWCA1twXAMz
         7hIqS7nWElbMQ==
Date:   Wed, 16 Aug 2023 15:05:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Seven Lee <wtli@nuvoton.com>
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, conor+dt@kernel.org, YHCHuang@nuvoton.com,
        KCHSU0@nuvoton.com, CTLIN0@nuvoton.com, SJLIN0@nuvoton.com,
        scott6986@gmail.com, supercraig0719@gmail.com, dardar923@gmail.com
Subject: Re: [PATCH 2/2] ASoC: nau8821: Improve AMIC recording performance.
Message-ID: <2f72d241-7617-48c0-a0c9-86bd14c50ac8@sirena.org.uk>
References: <20230816080006.1624342-1-wtli@nuvoton.com>
 <20230816080006.1624342-2-wtli@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7XHR/LbWkR41hupe"
Content-Disposition: inline
In-Reply-To: <20230816080006.1624342-2-wtli@nuvoton.com>
X-Cookie: Old soldiers never die.  Young ones do.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7XHR/LbWkR41hupe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 16, 2023 at 04:00:06PM +0800, Seven Lee wrote:
> Since the hardware may be designed as a single-ended input, the headset mic
> record only supports single-ended input on the left side. This patch
> will enhance microphone recording performance for single-end.

The new property looks fine but you need to fix the build error 0day
reported.

--7XHR/LbWkR41hupe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTc16EACgkQJNaLcl1U
h9AJ9Af/XZxGppLWjNl8VmVBlE8dAbfXi2O59Rlr7fLtOb0uHm040wM3pQjywMze
8kawuRIWKzHB7KYiUvzne/FsfvYg2qHbnCIKkx9BK4n+zjxk7tMEnqpnMWgVCjcm
OzkC0mSsLjIpXMx1UYeu1qiMrRD/Cvn0RK2VOhkw4ZSyjpKwdQI/1B6+t4E3nIug
DEm54Lwkx2zC7See2ogDVuOujuHmMzZhj79GtaR3r9aKXIEaIx24BaJCofAqCMWr
YMm2piEbpMgQqilGJzLyamQWdmcMZzbAQRegTN/vnKJxT7eHkXt/YkNxG4FcrF9c
gZVHE+nrqoidze9w7rGfJUfrtWVTeg==
=jnGm
-----END PGP SIGNATURE-----

--7XHR/LbWkR41hupe--
