Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A987378DDE1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343595AbjH3Syu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243655AbjH3LW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:22:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D071BB;
        Wed, 30 Aug 2023 04:22:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E833629AF;
        Wed, 30 Aug 2023 11:22:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86231C433C8;
        Wed, 30 Aug 2023 11:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693394544;
        bh=sbXwoUnfsg75aRpsvrKxd95gOG3cQb50vpy8i5omPNQ=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=pvfhaesJC1Ch/HgOSY0OQ8bedM9JZ68lhIsl8FYsnC2ytRKuMmed7a2oHHzOopY9s
         tMoMd6fBunXVbAUK1gFrBaslHfjLDS0+tpP5ecEcescsKram5CGN2S/weShHNMP4yh
         QPDKcFdWaLcuEfC6mwvxqI/CKedUwNWDAvxyRf1X5VUlKBgIfiWUvdaGzovEG+yamw
         dgIkB9c2kDIaT2Fhc3m6Ztk0BhXTxbaDJGAYJzedpy1Ph1NPilM5mBVFj9WT2dek/k
         2zTVHtvHzKFcUS5Z2cnYFvpd0BPZUY5IPxWxF4E8pyQejcy7eZuf2mBDQqkvo9ka0f
         KxK/+pPnT+QDw==
Date:   Wed, 30 Aug 2023 12:22:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quic_pkondeti@quicinc.com, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, workflows@vger.kernel.org,
        tools@linux.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/1] scripts: Add add-maintainer.py
Message-ID: <0f7b32e1-1b26-4543-bfec-471641a67416@sirena.org.uk>
References: <cover.1693037031.git.quic_gurus@quicinc.com>
 <141b9fcab2208ace3001df4fc10e3dfd42b9f5d9.1693037031.git.quic_gurus@quicinc.com>
 <2efba6b3-2399-9deb-d0ce-78f7b5e12f30@linaro.org>
 <20230828175629.GC23466@quicinc.com>
 <78aa33f9-ead8-b128-2a7a-40530a1a3ed0@linaro.org>
 <ZOz4XtX3DFRQpvQY@finisterre.sirena.org.uk>
 <670a87e9-2f0c-ec9e-ebb4-9041c8972ace@linaro.org>
 <20230829231638.GA27843@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KnzHrTA7gjifxdYo"
Content-Disposition: inline
In-Reply-To: <20230829231638.GA27843@quicinc.com>
X-Cookie: Immanuel doesn't pun, he Kant.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KnzHrTA7gjifxdYo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 29, 2023 at 04:16:39PM -0700, Guru Das Srinagesh wrote:

> If this script is accepted and gains adoption, maintainers like yourself will
> only be To-ed in patches that touch files that you're a direct "Maintainer" or
> "Reviewer" of. For all other patches in the series you'll be in "Cc:". I
> imagine that this can be very useful regardless of the specifics of your
> workflow.

Given that b4 solves a lot more problems and is getting quite widely
adopted it's probably going to be more effective to look at trying to
get this implemented there.  That might still mean a separate script
that b4 can hook into, but it's probably important that whatever you do
can be used easily with b4.

--KnzHrTA7gjifxdYo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTvJmgACgkQJNaLcl1U
h9BZnQgAhN2il0SqqFg6f1KBrYU6LppQ69MeOtRhzem5cewfBS2Z/bSCt7QkoduX
428E2n4I/LxLzJ0yR4WzJRSfPCp4yTZtxwBLTt1X0fWdT9+LN5UcFIEXwp7Bk+uW
XsBPJiS3GhZ5UQZUQp9niH74hsRnGg+x8NrgirLi6MdAKoIJ/xYP3fY9b3TIBikS
Cgtm6GOjHI7g0u9KgajygrbAHFRyYnttp3pFLtV3K0f7O4rSfgvo4Zs0DqOM7xLg
0RjTSNaoLE+Si2RAAw5QHH6tH6+LW+HWGSsW+mWbhrOQm17LPniGsqN1WJNvZ1/j
3wrUxQZzpHq+9xNZK9StKaqbFDB71A==
=gR69
-----END PGP SIGNATURE-----

--KnzHrTA7gjifxdYo--
