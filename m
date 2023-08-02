Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B27676D8A0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 22:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjHBUYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 16:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjHBUYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:24:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961E9FF;
        Wed,  2 Aug 2023 13:23:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB9F061AF9;
        Wed,  2 Aug 2023 20:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BFAC433C8;
        Wed,  2 Aug 2023 20:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691007765;
        bh=kJR5VYhsLcd26FRln9kp7D7T+g0liOZIpeMz7LbRKvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HAsVJtmd+xwsfWAoq8Pxa8wmmHJv/sqOdYeyFmPkmEikyIRDrqBvetHVX4F27btYJ
         zcRk4+X63UL4qPuIkpsGFt3evh6aOmjb1qUcM3zYlDJ1wF/BVYbtnPiF5oHhESxhj1
         f53TGsl/hAFLGiivG++hzpnko6iqwnuAs507xcx6QCuLE5sL1TK6EBgmGXpVifXSHc
         UWzW54g3h6bq1VxzK0FFTfEGGKN9oGCRKvB2e53bpW1noyN3+BnshlxSa2aB8Ceu0e
         h4jc2Lh7z1C8YTKNl/6ir+bzfBSV7kxU+8DYZ58YHvthEFZo3wE1pHvDWXMeWP/5aB
         FxidBj0fc1gEA==
Date:   Wed, 2 Aug 2023 21:22:41 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] RISC-V: cpu: refactor deprecated strncpy
Message-ID: <20230802-overwrite-casino-491979427162@spud>
References: <20230802-arch-riscv-kernel-v2-1-24266e85bc96@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ll5zcIRttVRYEd0J"
Content-Disposition: inline
In-Reply-To: <20230802-arch-riscv-kernel-v2-1-24266e85bc96@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ll5zcIRttVRYEd0J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2023 at 12:21:58AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
>=20
> Favor not copying strings onto stack and instead use strings directly.
> This avoids hard-coding sizes and buffer lengths all together.
>=20
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v2:
> - Use strings directly instead of copying onto stack with `strscpy` (than=
ks Kees)

Yeah, that is what I was thinking of when I decried it as being horrid.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--Ll5zcIRttVRYEd0J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMq7EQAKCRB4tDGHoIJi
0iONAQDvkdrvxLwjFA4k7Ta7UGh+90nAGAA+VslRU5pB4QrFTwEAxNmnJuahK1IX
UT6wu7/2wDjIFon1o7pctoFyaM/SBAs=
=eYZ0
-----END PGP SIGNATURE-----

--Ll5zcIRttVRYEd0J--
