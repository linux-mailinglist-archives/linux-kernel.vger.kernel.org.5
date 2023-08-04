Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA257704C1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjHDPbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjHDPb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:31:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C89C49FA;
        Fri,  4 Aug 2023 08:31:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AB7362055;
        Fri,  4 Aug 2023 15:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF8DC433C8;
        Fri,  4 Aug 2023 15:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691163068;
        bh=hxuljz+as8AT+zpeXq/iy/DqqC73aBdecpgf/sdIuMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=klEPnspdL15FMXZhCDx9iQmDWkYwf4YOiftzjqB8LoOt3N4xjvt/LAz8gFZehM7NZ
         Jn8JHgs2gckOC3Gc3G84j3/CTLpecGfKOm8WWg2StOrQQJUhtm4CTGv5eu6CATD5u3
         YJhnzoKI4fxtmlYyLS+M89XUQCyhHCi79fZUsV/0XKcNrtT6AR9G9Rq2ob0zhJk/3o
         Viz1YMWyAdzB4vqoW2jDOxQyqgFeGP2hubLzCeghgr0uow5VgQjYx7c+jN/6KfPvvN
         7EmEAhIFplW+ozamyBQQtfHPrxLUJEPRolbJt6LJGGMJ8+BiArM9bJe65Aap7aca9x
         9LDfhR+siUd5Q==
Date:   Fri, 4 Aug 2023 16:31:03 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/9] dt-bindings: mfd: mt6397: Split out compatible for
 MediaTek MT6366 PMIC
Message-ID: <20230804-rift-unvented-1194b51744f4@spud>
References: <20230803074249.3065586-1-wenst@chromium.org>
 <20230803074249.3065586-2-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7uwcHrcVztFuPIhA"
Content-Disposition: inline
In-Reply-To: <20230803074249.3065586-2-wenst@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7uwcHrcVztFuPIhA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 03:42:39PM +0800, Chen-Yu Tsai wrote:
> The MT6366 PMIC is mostly, but not fully, compatible with MT6358. It has
> a different set of regulators. Specifically, it lacks the camera related
> VCAM* LDOs, but has additional VM18, VMDDR, and VSRAM_CORE LDOs.
>=20
> Add a separate compatible for the MT6366 PMIC.
>=20
> Fixes: 49be16305587 ("dt-bindings: mfd: Add compatible for the MediaTek M=
T6366 PMIC")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--7uwcHrcVztFuPIhA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZM0ZtgAKCRB4tDGHoIJi
0qDyAPsHuwCui775ZKeH0xfMeYOmy3RU0RV5Fv5KqB7imiFqfwEA19FJcLsJ+INy
AR2LebWepVlpr+2xxBBkGWmxwLNzPwY=
=47nj
-----END PGP SIGNATURE-----

--7uwcHrcVztFuPIhA--
