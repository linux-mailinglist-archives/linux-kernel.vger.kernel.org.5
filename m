Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AD175E2C7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 17:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjGWPFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 11:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGWPF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 11:05:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92157D1;
        Sun, 23 Jul 2023 08:05:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FA9760DCE;
        Sun, 23 Jul 2023 15:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C40C433C8;
        Sun, 23 Jul 2023 15:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690124727;
        bh=WcXx4NgqcHBwrVmmKu93EsH2r7eDAFkO3ZuwoqC1YYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vHFIkgxv1Rlc1mnL6cK/9dJHedqR8geu3dqcf6azy+dG/D7deNWK+L/xFNaGtwQd4
         6bxyG+NsZI0ScCL4rqmudh5IkBr1PsDoeQ5QeJexSlFxOnajcwuj2I9uwVRtXR1jHT
         k62wBJzeoXp/cAZRTE+Q1IRuEZIEjRny/+hBga0fYbUnWLwREZHxS4iFAgGwcKsBjw
         N9uUEy9yAt2eb9Mu9S6oyMd8hrg9IRKZLkYfkn2kjyavR7AAz6nY36DebcIRD+vznE
         XLRXQK8kOMDhJWV6e6uGaiYgLruBi0Ul2BleUgiuMpU+5kW8WfuK+Twgh8oHs5Fn4G
         8bxqvD1DpGeMA==
Date:   Sun, 23 Jul 2023 16:05:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Icenowy Zheng <zhengxingda@iscas.ac.cn>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, Icenowy Zheng <uwu@icenowy.me>
Subject: Re: [PATCH RESEND RESEND] thermal/of: support thermal zones w/o
 trips subnode
Message-ID: <ZL1BtOZp/2Sw5sFL@finisterre.sirena.org.uk>
References: <20230722122534.2279689-1-zhengxingda@iscas.ac.cn>
 <ZLw4CnzLI/QHPGWx@finisterre.sirena.org.uk>
 <6d1c0915-1485-d9d6-9fff-0413fb16bd3f@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0yLVx62uXzvty8Jv"
Content-Disposition: inline
In-Reply-To: <6d1c0915-1485-d9d6-9fff-0413fb16bd3f@linaro.org>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0yLVx62uXzvty8Jv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 23, 2023 at 12:12:49PM +0200, Daniel Lezcano wrote:
> On 22/07/2023 22:11, Mark Brown wrote:

> > This makes sense to me - it allows people to see the reported
> > temperature even if there's no trips defined which seems more
> > helpful than refusing to register.

...

> If the goal is to report the temperature only, then hwmon should be used
> instead.

Sure, that doesn't seem to be the case in the impacted systems though -
AFAICT the issue with these is that it's a generic SoC DT that's not
fully fleshed out, either because more data is needed for the silicon or
because the numbers need to be system specific for some reason.

> If the goal is to mitigate by userspace, then the trip point *must* be used
> to prevent the userspace polling the temperature. With the trip point the
> sensor will be set to fire an interrupt at the given trip temperature.

I'm not clear a trip point prevent userspace polling if it feels so
moved?  Is it just that it makes it more likely that someone will
implement something that polls?

> IOW, trip points are not optional

I can see printing a loud warning given that the system is not fully
configured (there's a warning already, I did nearly comment on this
patch downgrading it all the way to a debug log), perhaps even
suppressing the registraton of the userspace interface, but returning a
failure to the registering driver feels like it's escalating the problem
and complicating the driver code.  Suppressing the registration to
userspace seemed like it was adding more complexity in the core but it
would avoid any potential confusion for userspace.

For me the main issue is the impact on devices that support multiple
thermal zones, in order to avoid having working zones stay registered
their drivers will all have to handle the possibility of some of the
zones failing to register due to missing configuration which is going to
add complexity both at both registration and runtime and be easy to miss.
If the core just accepts the zones then whatever complexity there is
gets factored out into the core.

--0yLVx62uXzvty8Jv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS9QbMACgkQJNaLcl1U
h9DjxAf/SNrHtzc1AbU+CBWeWdCjcn8YM2RPDP8lWcvrVBLBy/DndTm+zf7kdxSU
pmTIIia9nc9Xy0InPTq0lrxTALv9KBqqihXxrkjp5wzBmviBCRgy/p4zw32phlEh
b/Di1wpHttDFt62t2jofB6JrG1ZGWbgLCX7yS1iyexMol53aQfECNPUT9k6uKuIf
6pba2ACFAgWJ5vQ67k6aFB2hfjj272+gf3eS7aq1gR7TLdjecA2dY6Q6ONlPCaTo
vS8JzyJUqb3G/l+nqdMx/or08+NrYkSTsW2XcbpMVlA50l6ffp2CpFJZMwjG1prV
qmmC4fCTisbgvkazd7cQ0XY4SwCzkw==
=0EMm
-----END PGP SIGNATURE-----

--0yLVx62uXzvty8Jv--
