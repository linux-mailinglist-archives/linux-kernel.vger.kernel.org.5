Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21BB7FDBA4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343765AbjK2PiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbjK2PiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:38:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CA9D67
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:38:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B9FC433C7;
        Wed, 29 Nov 2023 15:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701272289;
        bh=SyJI1koM3ChrX3JfAvIjzNnOMB63jorV18A8rozU04E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h19jTs9r4FzwzHT96ZNDDekE8fzebNbxj3hS7JtSgruoIZLgArNAe+3LFSv4AAppw
         9HkUnUxrZ3/h1KA1fdSzzGx73oNDdq3utTF6nQi86EiUVGM6eXIIS1CR1KzN4Ocgq0
         D3RlvkNEzE6LgdpheLl3iN/AdbObAXRCR+OJrH4EBT7+gMoOgVlQqQgf6qBiKYqlJ/
         TYOv68ES9JA6Cdt3iPz+s5vZUkzx5lM00TOxTTDsgxdp8Jz5drwaJWMnsdQKsRYED1
         Rn9PknViP23++toTb21t3HX6h/WWBrmhrvQZD5IOHCtTX3tFCX3OAvDnmp6STnHeZK
         OE8hqNpZhZemw==
Date:   Wed, 29 Nov 2023 15:38:04 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Thomas Richard <thomas.richard@bootlin.com>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, u-kumar1@ti.com
Subject: Re: [PATCH 1/5] dt-bindings: arm: keystone: add ti,j7200-sci
 compatible
Message-ID: <20231129-crawling-gaming-76077ed03c57@spud>
References: <20231129-j7200-tisci-s2r-v1-0-c1d5964ed574@bootlin.com>
 <20231129-j7200-tisci-s2r-v1-1-c1d5964ed574@bootlin.com>
 <20231129-caress-banister-5b5ccbf183e6@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9EBarYguRYNMy8wU"
Content-Disposition: inline
In-Reply-To: <20231129-caress-banister-5b5ccbf183e6@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9EBarYguRYNMy8wU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 03:34:20PM +0000, Conor Dooley wrote:
> On Wed, Nov 29, 2023 at 04:31:17PM +0100, Thomas Richard wrote:
> > On j7200, during suspend to ram the soc is powered-off.
> > At resume requested irqs shall be restored which is a different behavior
> > from other platforms.
> >=20
> > Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Un-Acked. Your dts patch contradicts this one.

Is the programming model compatible with the existing devices? To be
compatible, the existing device only need to support a compatible subset
of behaviours.
If so, this patch is wrong. If not, then the dts one is.

Thanks,
Conor.

--9EBarYguRYNMy8wU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWda3AAKCRB4tDGHoIJi
0p3tAP4lUjMdujHJ8+n8CF2yi20ahruH0ivCP/N+J//GBpYR+AEA5HmQtO8ZCbvG
a/y8JXzutWlvCpqIVklpt6M7Bc3jbg8=
=tma5
-----END PGP SIGNATURE-----

--9EBarYguRYNMy8wU--
