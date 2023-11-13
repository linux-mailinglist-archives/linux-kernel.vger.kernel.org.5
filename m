Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DE37E9D81
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjKMNpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjKMNpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:45:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1C9D44
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:45:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC87C433CD;
        Mon, 13 Nov 2023 13:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699883103;
        bh=MWxOr26uLlWPy3C99XP8rMs9jIFJ4texhTXtwq8qd2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aDPvNBio8D3W3YHpBrYTERDAAVrQeSmiWWi64HLLfuYhNgEg8fHN5g0yn7JYaleoz
         UPi1B1yqOzsHqnDkCSsO0MDhxLX6fqGbqqI/+Qs28EucA//ih/SGQGjF5mYtVfYhyy
         GMg/3LqCWVJz0D+BYVedZXjLpwBrQE54dQCrSxArELCQk3YO8N65JLSnV49DPxJ/pg
         A/tk0/Fxy1Wb5RiiprWByxPUrjF0fhJU7Woc/U5ap6VE87k+XkbginQFZlQBo2b8Wq
         PwqzTI4BgS1g/GlK0JZaNX/Hmi2VwAJVOmwUlQqnQ6INsOdbRQwud+Q3ol5DqIfPNK
         GU8pshyvQ7JLw==
Date:   Mon, 13 Nov 2023 13:45:00 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf: starfive: Add StarLink PMU support
Message-ID: <20231113-grip-unstamped-7d5cb2e39d3e@squawk>
References: <20231113042231.457882-1-jisheng.teoh@starfivetech.com>
 <20231113042231.457882-2-jisheng.teoh@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WKmVL2o0UKfz4Sy4"
Content-Disposition: inline
In-Reply-To: <20231113042231.457882-2-jisheng.teoh@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WKmVL2o0UKfz4Sy4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 13, 2023 at 12:22:30PM +0800, Ji Sheng Teoh wrote:

> +config STARFIVE_STARLINK_PMU
> +	depends on SOC_STARFIVE

Please s/SOC/ARCH/ so I have one fewer instance to delete.

> +	bool "StarFive StarLink PMU"
> +	help
> +	   Provide support for StarLink Performance Monitor Unit.
> +	   StarLink Performance Monitor Unit integrates one or more cores with
> +	   an L3 memory system. The L3 cache events are added into perf event
> +	   subsystem, allowing monitoring of various L3 cache perf events.

--WKmVL2o0UKfz4Sy4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVIoWQAKCRB4tDGHoIJi
0p50AQDEmAFBeaPIHV8PQTfCU8diGLUj16p5aPyx7zsBQDql7QEA5ptwtjWCQPob
6kV/vvqV/oGdEM/dt/J7M1fVzMY1+wY=
=Zw9w
-----END PGP SIGNATURE-----

--WKmVL2o0UKfz4Sy4--
