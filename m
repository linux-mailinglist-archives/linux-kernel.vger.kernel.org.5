Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CB8805C80
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjLEQ45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjLEQ4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:56:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D408D4D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:56:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD04C433C8;
        Tue,  5 Dec 2023 16:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701795416;
        bh=YM7uqQFgFylVnBaV96PfrIqHs4D83OpxPgtBcpTxdwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MOMu2QYtTduNnbFsm3f7kSxVTMqUD/4C6zQpMgjD8/tkSeoOfpuNJtizIF1cj3DmZ
         zrLJS1ExlmgrB5IdZGAP4aKeQqRkWfLMzETAlNM0SyLreaubPanyc3TQ9NrCpxEdtA
         OYpnVaeVJkuUmCZevuivccVAiCtdkZpYSx4ahpac2n3voQqea1QZT29nTlno8PEqEk
         cXiCOc8G+FYhMf4FXBPFu+3XCv4dfw7hvhkONR3MPrLF0fOHl0MmhEkxx384a5m1Fp
         XPxHr27eLoB+pHeW+j/cKP6wZUa87DRWr1XUFlmvTValMflv8yFMBq/mTuCXAirKHb
         Zk3LGYdzNKxtQ==
Date:   Tue, 5 Dec 2023 16:56:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        wanghaibin.wang@huawei.com
Subject: Re: [PATCH] arm64: Delete the zero_za macro
Message-ID: <953cf17b-9476-4215-8c33-b4175a331181@sirena.org.uk>
References: <20231205160140.1438-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PdxnRDcAi7VRmw5r"
Content-Disposition: inline
In-Reply-To: <20231205160140.1438-1-yuzenghui@huawei.com>
X-Cookie: I've Been Moved!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PdxnRDcAi7VRmw5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 12:01:40AM +0800, Zenghui Yu wrote:
> zero_za was introduced in commit ca8a4ebcff44 ("arm64/sme: Manually encode
> SME instructions") but doesn't appear to have any in kernel user. Drop it.
>=20
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>

You're right that this isn't used, though OTOH it's not exactly doing
any harm either and as a macro doesn't inflate the image or anything.

Acked-by: Mark Brown <broonie@kernel.org>

--PdxnRDcAi7VRmw5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVvVlIACgkQJNaLcl1U
h9DDQgf/d4SUiQSTz43dN8CbaNJV/HB6Lo2OlFyvLav6WIzIbNN+KG9rtVEJI6dr
momGgpcJMg0c6fVgo5ShI4wro/WZ31c9jUo/FfJOsTbRCsLX3VhiJ+BgkGqLmwIi
rp2SOJkOEgb/3WC4MrEPuS+5xD9gTYLHv9cI+aIZbExNTLlt3DvsnOCBtxfTFRVH
saqEVfOmjnXWhFdm8vBFy2lWMIHa3h5KAU9EbbdWrm9ukHvzvTleG7zlmIYvz4ML
cyYM+I87RHhdunCFyYeB3nrs2Fw2ZDXHvM75vB8KUJqvT+iVk1mwtbhg7kq2zIDA
CmqQBaRONfort/v/FIJOCw7FMumxmg==
=uD6d
-----END PGP SIGNATURE-----

--PdxnRDcAi7VRmw5r--
