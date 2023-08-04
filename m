Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0368176FFFB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjHDMKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjHDMKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:10:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665C046B1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 05:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0384F61FB8
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 12:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF15C433C7;
        Fri,  4 Aug 2023 12:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691151020;
        bh=kcltGA5VVEwdM01EqRTaL/X48X6FL3SV58PcggBE+Xg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nKd+CvL1baJlWmDSlz4Uzmd1hNnCcEUN+V+q/D57v8C0BabQ0HFn/wmWHXz3FruvY
         JZPbnc8SDQYoohtVIpeWw8JtbEBkeFWzuG3HqBFlD/WZsm4gDYB1VhCg11ak3FDbxd
         8r+Llhmx+02pC6Uy9RXJGf1jL+aw/a9OsOY1lKIW6EVrquZIDjG8EWXGx1CMnH+M0A
         1JblfP2YKk57U4tZOdTZiXO36/wF536zvckUic+W37wqVhI3J6F6hr+1f5Jvw/lHEy
         28s5HqT4oIspGV9nliPu0gtA+g131vSHa9WpfcEaRIonzDI3PApaY7i1MqIn8CjNug
         K4o1V0RFGqf8w==
Date:   Fri, 4 Aug 2023 13:10:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Morse <james.morse@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh@kernel.org>,
        Jintack Lim <jintack.lim@linaro.org>,
        Joey Gouly <joey.gouly@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64/sysreg: Move TRFCR definitions to sysreg
Message-ID: <143152c8-61b8-4a71-9090-7203342b661c@sirena.org.uk>
References: <20230804085219.260790-1-james.clark@arm.com>
 <20230804085219.260790-2-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3kbZh3r3C1unpocv"
Content-Disposition: inline
In-Reply-To: <20230804085219.260790-2-james.clark@arm.com>
X-Cookie: I'm hungry, time to eat lunch.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3kbZh3r3C1unpocv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 04, 2023 at 09:52:16AM +0100, James Clark wrote:

> TRFCR_EL2_CX needs to become TRFCR_ELx_CX to avoid unnecessary
> duplication and make the SysregFields block re-usable.

That field is only present in the EL2 version.  I would tend to leave
the registers split for that reason, there's some minor potential for
confusion if people refer to the sysreg file rather than the docs, or
potentially confuse some future automation.  However that's not a super
strongly held opinion.

Otherwise this checks out against DDI0601 2023-06:

Reviewed-by: Mark Brown <broonie@kernel.org>

--3kbZh3r3C1unpocv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTM6qQACgkQJNaLcl1U
h9BU8wgAg9t9M9QcYBy9wf/UQDBywT7WO5cKpIRHeKsshoqoXQNBEbQhfLb9Mase
qLQbJUQtLQMOD0fNaVKOZX13tVV8m3cDigvN91VdGfhpgGZLUX6qyDxWW92RRlxn
ObB44WMyxj2QI+ab6Fn3YZ24cfAWRr8ChhR/eWdmcRTdA4unl6ooONkK1xzxMcTf
Q1NHuQLw8BjzegrQBicDLHl2UHRddCEo12tgRK/JWnE0Axy1j2J+wovkUHBKf9X5
8PfQAoGwPwLJAmKII4v7AVuCbBlmk6JdRP7mSpfa/lFYFTxiBaEr6l9Rypo5TfDQ
N2DXbHp2baCffYJP6U0kfw/xk26teQ==
=1wa2
-----END PGP SIGNATURE-----

--3kbZh3r3C1unpocv--
