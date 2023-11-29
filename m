Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CB17FD7F9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbjK2NYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbjK2NYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:24:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9609A8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:24:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E75C433C7;
        Wed, 29 Nov 2023 13:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701264284;
        bh=0c1R02PnwYq0+FlI1qP0ID1uLpms1is5f0YCY9QwT38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r8tkyT5IFfPH2UXTYO6NqDaApWvLjwudsJxux32s+Ofxpjo0V9oMRdtDFSYm2FLWb
         zoJts9J4U6P/2RDchfWQXzsFewah3TJXtnA/pOkup9f1WhTo1I/EJHe6ZeNejnKFbD
         WaGldZIAU2GVDvySWmR4LgV4d59lUIsRTP0fM/5fSypgFu9NCawlgFmpW1R8st19p7
         /RMP/ZDLpqQuUuPUv1rU9WN2ep2maAX4Re8uaVFdXGURx6pfUT14QLNdpLA+BDi9Xw
         fIqKJ6MT5Y6tA4nduRG7mfjyWV8zlTtdtnv09DnOWhkkeAQqqp+m2tRhrAATboxkpM
         nV4ZL4PlgOjJw==
Date:   Wed, 29 Nov 2023 13:24:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Haoran Liu <liuhaoran14@163.com>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [regulator] pwm-regulator: Add error handling
Message-ID: <4165978e-bf57-4530-82f6-657ed7296a92@sirena.org.uk>
References: <20231129130530.33744-1-liuhaoran14@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iV+/8zORaZ+pF8Ur"
Content-Disposition: inline
In-Reply-To: <20231129130530.33744-1-liuhaoran14@163.com>
X-Cookie: Are you a turtle?
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iV+/8zORaZ+pF8Ur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 29, 2023 at 05:05:30AM -0800, Haoran Liu wrote:

> +	ret = of_property_read_u32_array(pdev->dev.of_node,
> +					"pwm-dutycycle-range",
> +					dutycycle_range, 2);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"Failed to read pwm-dutycycle-range: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(pdev->dev.of_node,
> +					"pwm-dutycycle-unit",
> +					&dutycycle_unit);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"Failed to read pwm-dutycycle-unit: %d\n", ret);
> +		return ret;
> +	}

These properties are both optiona..

--iV+/8zORaZ+pF8Ur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVnO5cACgkQJNaLcl1U
h9DouQf/b0JOKd43U7N/K/15XqWqlFJ3imsTQxCelzXZFtXPDGEpUAFddfT/KrEi
A0LDeCWe/KYavm8TROTu74Da5zZ7E9m/qLtZgh4vu8LR02WuGH29yiHoDI7gPfaR
dDBe7tPaXCUP0zg0mj0ThuH5+hrgN7TfTP37WhFLQ6+4xlAPtrXe9SC0fGsWKc1+
auzExbRGSlC4JP+7dQqhGCKr7nGDVxZ+l0bmJxm+8qsPDJqmsLAQwG/jDTpYfI4z
qb/8s6RmXP8wNt5ReF2ANAY9g+hH4HS1WJjzR1X+EMkdqvE+3iUjUyL3ogTIc6Vd
bu/6fkeiVhfG8FQJZoYdz/wzpRIbkA==
=hFFq
-----END PGP SIGNATURE-----

--iV+/8zORaZ+pF8Ur--
