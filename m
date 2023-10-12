Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F767C7063
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbjJLOhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbjJLOg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:36:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9619DC0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 07:36:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DA8C433C7;
        Thu, 12 Oct 2023 14:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697121417;
        bh=tqPqmHok1AyU/GG626kkM4PFGH7XQeQEOYooofFbE+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BMAjov1X2fVRTyegaWW28iHtNCwbmTe1ER+CCckjzVHEl8moiISR5Ys0Ad3QBESNC
         XCzNCnYLVTCqKSaKM+X5dbQ2oQl+p2lhzVyGRJsx9HwFVTyNZp6hYbj2fa7b8H5Sy/
         3n81yeRGgGcmV45bY/mg97c7o6NNjMa/NIXvkR4apDIyYaVJ+nwDo/YyMLqmrx8Wil
         nssBNW5fPPVUqURzE76CFjUp/JAzjV5vThzwy8HIRpmt8FpQ3euJxC1qiF9Qrwl8iI
         THEa9ERLSlWS/JtSVovdCGce8bL3D1XBQ35AbEWpKtQJsSEbs4nHjn1kZTBV1jil2W
         SLIyA23D6wRCA==
Date:   Thu, 12 Oct 2023 15:36:53 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: Re: [PATCH v3 1/2] riscv: errata: thead: use riscv_nonstd_cache_ops
 for CMO
Message-ID: <20231012-pranker-usage-09a85a36356f@spud>
References: <20231012141456.4078-1-jszhang@kernel.org>
 <20231012141456.4078-2-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tLH7qnMb79tGa+m2"
Content-Disposition: inline
In-Reply-To: <20231012141456.4078-2-jszhang@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tLH7qnMb79tGa+m2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 10:14:55PM +0800, Jisheng Zhang wrote:
> Previously, we use alternative mechanism to dynamically patch
> the CMO operations for THEAD C906/C910 during boot for performance
> reason. But as pointed out by Arnd, "there is already a significant
> cost in accessing the invalidated cache lines afterwards, which is
> likely going to be much higher than the cost of an indirect branch".
> And indeed, there's no performance difference with GMAC and EMMC per
> my test on Sipeed Lichee Pi 4A board.
>=20
> Use riscv_nonstd_cache_ops for THEAD C906/C910 CMO to simplify
> the alternative code, and to acchieve Arnd's goal -- "I think
> moving the THEAD ops at the same level as all nonstandard operations
> makes sense, but I'd still leave CMO as an explicit fast path that
> avoids the indirect branch. This seems like the right thing to do both
> for readability and for platforms on which the indirect branch has a
> noticeable overhead."
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Tested-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

=46rom v2:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--tLH7qnMb79tGa+m2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSgEhQAKCRB4tDGHoIJi
0oQqAP9E3GPMvuDoXMFDfJdL0fEkQ1D91Q115ThR1vWUqlcKCwEAmZexxPc2Ytz3
XSpUhcOVF4jxrEhP3FjNPNvYpXJp6wg=
=NXCq
-----END PGP SIGNATURE-----

--tLH7qnMb79tGa+m2--
