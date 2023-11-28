Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FF37FBA81
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344738AbjK1Mvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344655AbjK1Mvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:51:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB8210D7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 04:51:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5444AC433C8;
        Tue, 28 Nov 2023 12:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701175907;
        bh=oj4l032/TwDGs1VImtwGCbOjPIx09bJYOhWopM2xSDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rZxKYhYglGfzQh7wHfclq5EI14MPmD7k9MNMGu7DwkJJriVA4Q7l9DSHbJDMwhsZf
         3QX4a5cstBR2H3WUyywAasVi662mshc9jVLZ27qZkt1P1Z6XONys0e7WUrE4qTTPCp
         kaV6c8yaZbbYQfaT7Mzayi8fdEBPvukd9DgJkPi2+T44WVLb9GytQ0dc6RHshzeMFD
         0DPU28tHGs9uTp9NnV1UXXN+IFZKLEjWQPBnSbqt0DmKPfox/zGNmQFnRbwOloAM8n
         xN4AK5AZ5VQm0bNsSzhAViB4FMtKWFUd9HDzKTsRtaxiZ1RnybuYwb8TW8GEpGzmgv
         uIFq7tHs3Lzcg==
Date:   Tue, 28 Nov 2023 12:51:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "keescook@chromium.org" <keescook@chromium.org>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "kito.cheng@sifive.com" <kito.cheng@sifive.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Shadow stack enabling from dynamic loader v/s kernel on exec
Message-ID: <ZWXiYCs45Ryb6UMf@finisterre.sirena.org.uk>
References: <CAKC1njRkpaqbAFWrZpz75u4M-T8mniY2QHVZEENameqnHOOGPg@mail.gmail.com>
 <d36b02fc0da364ea0d660e5e5ecac9df7e327f79.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="B3jt3vEluDvHmqS9"
Content-Disposition: inline
In-Reply-To: <d36b02fc0da364ea0d660e5e5ecac9df7e327f79.camel@intel.com>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--B3jt3vEluDvHmqS9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 27, 2023 at 05:41:16PM +0000, Edgecombe, Rick P wrote:
> On Wed, 2023-11-22 at 16:19 -0800, Deepak Gupta wrote:

> Thanks. As we look at adding some final glibc support, I've wondered if
> there might be enough topics to warrant an occasional meeting to
> discuss stuff like this. I'd also like to discuss the shadow stack life
> cycle issues (uncontext, etc), alt shadow stacks and all of the
> compatibility last mile problems. Towards the goal of avoiding
> unnecessary divergence on app developer expectations.

It'd definitely be good to ensure we're coordinating well, I'd be
willing to give it a go.

--B3jt3vEluDvHmqS9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVl4l8ACgkQJNaLcl1U
h9CQ3Af+PytnRoQfW2nK0CLu6NBsOXpm8XYI2ZIp7GTZx34pn6j3L8r+D9tmoRPa
tv+XYLlLiZIvu+dJxZfX/FxWjdStyrmcTpJiLbcBqoDX4nRraqaoCDGXuHUMiPRA
dWi0DdQBoBFGRYeVl04vLau9ZKYg8mX6ELrrp6NsD/cjQbkfRqn7D/97D/vYuoD1
r3YnmKfmj4x0t4rHEmo3g9IXwEMiJBboXr93jWRWyIb41JWkE8WY1wVp+TB89NOm
mfp5s5W1joWEKurHE0B6fhf6XWftjN5/nvdvyGl9EV8NHuXL711+aEeU1YLZytrW
oqSGwECrsiqVj1bJTCsyl7aeARQMlA==
=P21f
-----END PGP SIGNATURE-----

--B3jt3vEluDvHmqS9--
