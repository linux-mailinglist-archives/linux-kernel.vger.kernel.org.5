Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22A77CC8DA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbjJQQaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJQQaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:30:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965CFF0;
        Tue, 17 Oct 2023 09:30:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1FCC433C7;
        Tue, 17 Oct 2023 16:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697560207;
        bh=sU2EMCsv3DyJAITFKB0Lfb/v6BJGj0xKNJXbC1q0U2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ipwinJZRe1Qem4MsMt0wxqnSCi+eYwNMvo4Xvdd1c35q/sgyWNNn8lV7carjVR0u2
         h+lLFLw7ECnIavEltzuXMWVVfdSkrMARGbTqB2M6DOnfVy4RcFjW9i4YB4/yfE/aEy
         zf4gjfKHJNXvwccxehbfVlQeqr1FrNR0uVfcT/syoY2XYUlBS3/5nuu6OHXmuOr3KX
         s9hNUqk+I5qoL6pRWYWyZqmxnsztNOD0SH8YpEAyz61t/8FGhfEORB4ttTF9sMQ84+
         0SD4UExWqSJuehVvOYXCHFn0SuqeBvz5clnkuVFId05q+R71wbjtk8Tz4Dc1IISlvx
         /qZcdfRu9vp9A==
Date:   Tue, 17 Oct 2023 17:29:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org,
        tiwai@suse.de, vkoul@kernel.org, gregkh@linuxfoundation.org,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: Re: [RFC PATCH 2/2] soundwire: fix initializing sysfs for same
 devices on different buses
Message-ID: <4815c8d6-635d-415c-9e02-4e39e92a3d6d@sirena.org.uk>
References: <20231017160933.12624-1-pierre-louis.bossart@linux.intel.com>
 <20231017160933.12624-3-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pDDQ5Cun2wSytVh2"
Content-Disposition: inline
In-Reply-To: <20231017160933.12624-3-pierre-louis.bossart@linux.intel.com>
X-Cookie: Santa Claus is watching!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pDDQ5Cun2wSytVh2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 11:09:33AM -0500, Pierre-Louis Bossart wrote:
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> If same devices with same device IDs are present on different soundwire
> buses, the probe fails due to conflicting device names and sysfs
> entries:

Acked-by: Mark Brown <broonie@kernel.org>

--pDDQ5Cun2wSytVh2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUutoYACgkQJNaLcl1U
h9CIxwf/UPXnwjJuk+a9OL59oPDEk05nXN4hCn4ZyLLqYCrhVb0c7xe+WRXVPB2i
MVb/MYBXnGT89Fq1jAkrEG0RDke6vNmP8IzsBm7gykoHTT27eIjhbLbmcGb5FMtg
Z18c3YHTa2BYt4f/xyFRLYG5vEFlh9r/6PECuGrScXita3Xrz67vggnN0R+u+uQP
7kMq3ii5ULx7oDsRoQuERV9+WurLIAkZVGkfMVqFUmu1e7NiAXc5phj3YVcSnaFj
9+DW12wntF2N+NyYs6/+tCZjosxxRayygvt2UL8j8SyM/WT1HCx2k+H6Gq8QvM4e
oZFmY80WCCUUyBO0ZRmip+Nmzby6Hw==
=2Yub
-----END PGP SIGNATURE-----

--pDDQ5Cun2wSytVh2--
