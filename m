Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F84E8013D6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379568AbjLAUBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 15:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379550AbjLAUBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:01:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E05FA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 12:01:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AF5C433C8;
        Fri,  1 Dec 2023 20:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701460901;
        bh=eO0+A/HoDSUXkRzZYBTH4WJttajSMnTAC/ilJrr2b+g=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=Z0yVGh7M8sUHaxzmBGXP/uhJvlMZo1QvDo+u38ssMkZSwc4XX7TlReiKiCdk6P/2k
         VU7OFp+IfVGwH55/whD1sHyzxSVso4oGqclMT4LZHeEph5Xx6rgwZnKxbCj+r6Lqio
         UrZGc58gBfjaCTR/yuGRok0EZ2SvS9R4+5lSA0aEfm+DlJOWuvaAjsdgHHZpwV2S0q
         bw9lEmUSZnYJJSloJarRf7YkQ5S6GG2N/kl5CHZm/xWdoPcEPtsL/uqp7siUZw3h9h
         m98lDoPMJCfy3ngUCOXKGybzXiMH6au43I9kcBaECH5HMnfrUexYgqhyx0Faxgi2hx
         kL77x2GoS4cYA==
Date:   Fri, 1 Dec 2023 20:01:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Reichl <hias@horus.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org,
        jslaby@suse.cz
Subject: Re: Linux 6.6.3
Message-ID: <dea2db44-2e13-47c1-be0b-8548bfd54473@sirena.org.uk>
References: <2023112811-ecosphere-defender-a75a@gregkh>
 <ZWo45hiK-n8W_yWJ@camel3.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yLjAKkh/iKJFbDI8"
Content-Disposition: inline
In-Reply-To: <ZWo45hiK-n8W_yWJ@camel3.lan>
X-Cookie: The early worm gets the late bird.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yLjAKkh/iKJFbDI8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 01, 2023 at 08:49:58PM +0100, Matthias Reichl wrote:

> I'm not familiar with the regcache code but it looks a bit like the
> return value from the regcache_read check is leaking out - not
> assigning the value to ret seems to resolve the issue, too
> (no idea though if that would be the correct fix):

That looks sensible, can you submit as a proper patch please?

--yLjAKkh/iKJFbDI8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVqO58ACgkQJNaLcl1U
h9BZUAf/R0pVAXDalAF0Bfn7Of6eKAwLqYXSIdXvgq+CKZ6wfJlzAO6nKAbnEIc0
R/dhGkURtTHhE9XNVoFYLiIx5xfOxlAi0D03I753lKOYmTspm0alp+BgoVvFWnpy
uE2Kl8mCycb7BwO17BFIc1Lf8PPdHTzGEhDiG4uWX/2wnjGVBnKaYuTNdOIr4jc/
iC0PdgWCJxvGYKz67wJ4DSO8lKV9/oky4Etcgcix1ZOCrvAgXXICsgzpDDuc1BDJ
29Cm77qEqckdPfyt8UO5ziZtPQeBxw93QDpFTJOtUo9rhtKrwPUObNqJNNFhuqEM
Sh5gua5CigMj0MpxQOPDTF/QTiZEFQ==
=FoTj
-----END PGP SIGNATURE-----

--yLjAKkh/iKJFbDI8--
