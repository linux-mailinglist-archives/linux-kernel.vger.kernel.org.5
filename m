Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315D47CE0C0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345119AbjJRPIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345132AbjJRPID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:08:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D268109
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:08:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74810C433C9;
        Wed, 18 Oct 2023 15:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697641682;
        bh=mBkZiAJw0cAZ+8K45DFZn1KTs545PbO0X/BQKA3Y8Dw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S25cZry5EckSmUckAngr1pga2GQsoTavq3XDjyGIfITI3GKBU5hevjH1UeUxdLi+b
         7rRfl5IWifnWIWbjdDa7VWmTzC0LH+XUv5ccmYAdANSds74BzlmsPFhoFoAQeZgUaQ
         H0OxSQKRl6Y1Hl+NHJD55QiSu4qf046Gwr3YvewnK38u33gWHDHcOtO2HC8nr2ZWsZ
         2dDwLswfJMna47Sv2cg7IZOd4BgTGIUSV9x6NAP4MwtQtfAVL61tE9ED/HsWT1r/wp
         4BBAoisf1U7RXpfoyiWEFAEEc0Kwomq5u6L6Lf1Vxp+OiPKhM7UR5NUN00zQdJWylR
         3QRUeMEw9Y1bw==
Date:   Wed, 18 Oct 2023 16:07:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: codecs: wsa884x: allow sharing reset GPIO
Message-ID: <c17f56c1-a629-4b05-b807-42010f206f6c@sirena.org.uk>
References: <20231018100055.140847-1-krzysztof.kozlowski@linaro.org>
 <3aa9e3a7-9417-44b4-87d8-fcf1a8b46daf@sirena.org.uk>
 <84f9f1c4-0627-4986-8160-b4ab99469b81@linaro.org>
 <b7aeda24-d638-45b7-8e30-80d287f498f8@sirena.org.uk>
 <b35a21a2-6e69-4033-8d51-2b67b08ac7b3@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0DVAadVcjJVHZ/F3"
Content-Disposition: inline
In-Reply-To: <b35a21a2-6e69-4033-8d51-2b67b08ac7b3@linaro.org>
X-Cookie: Santa Claus is watching!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0DVAadVcjJVHZ/F3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 18, 2023 at 02:57:59PM +0200, Krzysztof Kozlowski wrote:
> On 18/10/2023 14:56, Mark Brown wrote:

> > I'd expect that the GPIO users should coordiante directly rather than
> > rely on the GPIO API to do the coordination for them - there aren't
> > enough semantics in the GPIO itself to do much more except possibly
> > provide discovery services (which would be nice).  Look at how the
> > regulator API manages multiple regulators sharing an enable GPIO for
> > example, it adds an additional layer of reference counting when it
> > identifies a shared GPIO.

> OK, it is still regulator core, though. Not individual drivers problem.

> Several other existing drivers have the same issue, so this should be
> solved in a generic or shared way.

Indeed.

--0DVAadVcjJVHZ/F3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUv9MwACgkQJNaLcl1U
h9Bv+Qf/Rvb5zyWFaHHrWVDS/7ye9dIL/po1Jvc9RP6d4AYn6QD0oyu/NbUNIHFm
LeB/Xwa73t6cIk7NqGMfpiGr494gsJIZkIYFXA2sRbIViBed9lfXkPIp/lbosz5P
sPjpR/gzT3+PqyyaRdEzXfmc2Ninu10PEvR1US8HUfNntlkGOjgnJLp8mXM0whUm
U+Fbl5W2+2TrIstqes8bJRzBSzpZgM5EqkhXUapqmr0EBVHOn7OjfB1e2/DqA+PF
k3ZedVR9V7xi7S3nhLurr5zS4E8OYUebnt61PfdxqsZjqlQNjEQrQfMtwALjarOg
yOL/dyC9UX7+UUWQlxh5j1GOYjBCdA==
=sw3k
-----END PGP SIGNATURE-----

--0DVAadVcjJVHZ/F3--
