Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB34763654
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjGZMbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjGZMa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:30:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9879A2;
        Wed, 26 Jul 2023 05:30:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8304161AE1;
        Wed, 26 Jul 2023 12:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF25EC433C8;
        Wed, 26 Jul 2023 12:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690374656;
        bh=KCDUnueU+WhAiA+jJhgNine9Y3qf6RqCwzYlIIe1x1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jLDyrYcIQh+ZM54+eQkT3yEyz+eluN4T6NnSgjjFxWxsQ/kNVzO5IsXCsoHrrooPf
         2cVqcomZ/vfyhdSWYIeyl8NNqXmCjpGNBW1mitAt5G+JUX8ZOL73blrdl4fq8uXU7I
         hTq/Ope9BcqnQes5YrJjS+X66A+pLGIfcXJlihgkqF/pX6CCsGbx/SFDFAoqv0yVbj
         /wYFKZPkJzKp4yt91cWr+p3fFCuczrbyTmvmr47vz4YcK0DkEz18TgO/rd7eJKhAo0
         SAXdsEkH681f6GQ96bdi95R+kHRSx8MOB6IjugP+JyRvZCbya7KLxni9XXomZdwAX/
         iPF8NVUW0xVzw==
Date:   Wed, 26 Jul 2023 13:30:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Eric Jeong <eric.jeong.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] regulator: dt-bindings: dlg,slg51000: Convert to DT
 schema
Message-ID: <34edabd6-8dd1-42f8-8309-07dfbf157dff@sirena.org.uk>
References: <20230725063132.42132-1-krzysztof.kozlowski@linaro.org>
 <d33e5dbc-ca38-4702-903a-b36f9a824391@sirena.org.uk>
 <1c3684e3-b88a-0476-9376-19d07956e261@linaro.org>
 <4859d289-f4e2-4676-9be4-182f7dbda8b6@sirena.org.uk>
 <2df8d695-62aa-329f-f355-d6081d970ec2@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N2x11oktUS3a/mAo"
Content-Disposition: inline
In-Reply-To: <2df8d695-62aa-329f-f355-d6081d970ec2@linaro.org>
X-Cookie: Life is the urge to ecstasy.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--N2x11oktUS3a/mAo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 26, 2023 at 02:18:43PM +0200, Krzysztof Kozlowski wrote:
> On 26/07/2023 13:55, Mark Brown wrote:

> > Oh, you mean if the regulator is in use in the system rather than if
> > it's enabled!

> Enabled as "always-on" or "boot-on" could be encoded in the schema with
> multiple if::then:. But it is not enough, because regulators can be
> enabled on demand by drivers. So that's what I meant by "used".

Right, you said "enabled" in the changelog bit though.

> >  I suspect that there's a requirement that either at least
> > one of the supplies be provided so that the chip I/O works, or there's
> > some other currently undocumented supply that is required for that
> > reason.

> I can add requirement of at least one supply. I don't think it changes
> much, but sure.

I wouldn't, I suspect it's the latter case and there's actually another
undocumented change.

--N2x11oktUS3a/mAo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTBEfoACgkQJNaLcl1U
h9B/2wf9GLt8MjXjvoaddPumlnyhl9yl4kXwgazu107RuLQhwRDvk72E5VHhRtjw
1tA9EpqUyI3HdidABF0H/h2Ur0wvd/bXkXZGm9p7Ln6O/Km7dAic9mvXXfq2gmyb
Z0ZYdYXoq+BFZG2pZXsh5UU4pmyBlqfTnixyGjir4Sr5ll4Ln4OTjWbokD/QXG08
ni9kXVvktJVYfRVQUf46ZmX46dNN/BIjBaMFCXId/DtNd9S61ErevFqbYffgQatu
fzh+AJgIxkf0s4bmnUxi4J06DoI3oVsk3aDNZdyB68IsoTLn4quXKjTTifSJZTbV
njtK9fsPQdRuVp0IeJgBSsc5JpxMMQ==
=SxCf
-----END PGP SIGNATURE-----

--N2x11oktUS3a/mAo--
