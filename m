Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527F57D6C0B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344078AbjJYMg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344113AbjJYMgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:36:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01861AC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 05:36:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405C6C433C8;
        Wed, 25 Oct 2023 12:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698237380;
        bh=wyBTthqKcfkO2ojgR97LQEfheUDy16wEYDsyyZztt1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VF7DP9hWihFTYldQ4VlETRZme+Ag7HiUQmcOZgvH8zqbgLchlmqDlwdbofg/cEPGE
         boahSAC7v2SIV8XypOtiWLxzIzszuTJv7Q4Fb8tf/GOeHwGHaMpk+TKXDNI3KVtx9C
         1VoJ5dhJhMnu5OR8sqKdqyJqEPIUcBkdSqbXhh+VmiDMTPn77XgnEmVYUPPJc6UJsk
         au7pRyp5HtTE4nG+yQnZ/6RQFBZfEx6zzTmJdlkBWystY6f+mRMdRQk8ehONPRUYXB
         U4ujeJ+WgNOys0dUY/qPedw5EspK3hj+yMxuWrSzYpKD4uCi74L0pgigA8udbwB4F9
         vU6c3esvXIkjw==
Date:   Wed, 25 Oct 2023 13:36:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        johan+linaro@kernel.org, steev@kali.org,
        dmitry.baryshkov@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 3/4] ASoC: codecs: wsa883x: mute/unmute PA in correct
 sequence
Message-ID: <6df45f92-5fe6-4b44-af04-c528d540ac06@sirena.org.uk>
References: <20230323164403.6654-1-srinivas.kandagatla@linaro.org>
 <20230323164403.6654-4-srinivas.kandagatla@linaro.org>
 <ff3eb88a-6941-4303-a4ba-17cad3842b88@sirena.org.uk>
 <2a0aabf5-41a3-cc07-3203-9b0bca6b71aa@linaro.org>
 <ZTjKWHAAfSYfc5px@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rt5zetGAX6yWh0JO"
Content-Disposition: inline
In-Reply-To: <ZTjKWHAAfSYfc5px@hovoldconsulting.com>
X-Cookie: There's no time like the pleasant.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rt5zetGAX6yWh0JO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 25, 2023 at 09:57:12AM +0200, Johan Hovold wrote:

> I understand Srini has looked at this but has not yet been able to come
> up with a generic implementation. Would it be possible to merge the two
> codec fixes as an interim workaround for 6.7?

You're talking about two fixes here but this is a 4 patch series...

--rt5zetGAX6yWh0JO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU5C70ACgkQJNaLcl1U
h9AXWQf/T9xZ70IX74zqgGEQvJQW8f5WuAjh3quFZ3EGIn0VgypXfRhXm36u8tDQ
B62+t6eMRRNj0YL8nyACWJUJ/MJebuPDNaNU+GUbE0yd5uZ0ByLwDKxN46IOD77V
oNkhPcf6GYPBzO76cNcaZJbkceN2dvGhLImmwGOEZGrspk9dVl/MGMUVUkEoHOgH
l/V2B+WwMJDLMOmzdqyq/FCU26+XpdNhwaR8pELO8VbjyNfa0Z+eu2qKx3TZ7LY3
mrVl+w95kK4H61ilMF3VsJ9NECYjUIGq83lr8SeHtm8qIPpnh2ydz5SNKmkuCFmf
SmfKJZPfodlipTiHHGVeFfZKr/n7lQ==
=btYs
-----END PGP SIGNATURE-----

--rt5zetGAX6yWh0JO--
