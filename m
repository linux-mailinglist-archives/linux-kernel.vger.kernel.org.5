Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA38787FB7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241400AbjHYGT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234731AbjHYGTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:19:37 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941771BF1;
        Thu, 24 Aug 2023 23:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1692944374; x=1724480374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1+p0zY/IBQSsqQ7CeXy3RYnB3en+Ol+WgPS2hbi2Ohs=;
  b=Qi2lAKgrUXxXl9jnAfoFVarbxhQ5eNq27r/CdDhRcwoUageuxD8fSAuS
   LKm15eU2CMfO8mVuThQNmmU42POInGasOZepOI+cy25QZHGWwnOQK1Zu0
   htGIpUSzBS5RhB5F3wmhHhT2PxddKJmZcn4ohBivlZfgu6sdXFiLFg0N4
   1KdiCPL9sJJS2+0OP4WkSjI5QEAe2jYMHs2wy6ynNGaBCbH1V0wXko8h6
   Btd/NhTA70CheL8Qljv9kszUT3qi+71I0aTuWU2UD6vxH0nNFkxafqmSU
   BPAICg4dmLasMezrjngKXjWxyZG/AWMJc2u/Ey46JvHNJtTy8y6L2KN+P
   w==;
X-IronPort-AV: E=Sophos;i="6.02,195,1688421600"; 
   d="scan'208";a="32620719"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 25 Aug 2023 08:19:32 +0200
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id B05C7280075;
        Fri, 25 Aug 2023 08:19:32 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Lee Jones <lee@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file patterns in TQ SYSTEMS BOARD & DRIVER SUPPORT
Date:   Fri, 25 Aug 2023 08:19:32 +0200
Message-ID: <11135245.nUPlyArG6x@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230825055821.30508-1-lukas.bulwahn@gmail.com>
References: <20230825055821.30508-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

Am Freitag, 25. August 2023, 07:58:21 CEST schrieb Lukas Bulwahn:
> Commit 77da3f22b3d5 ("MAINTAINERS: Add entry for TQ-Systems device trees
> and drivers") adds some file patterns for files in arch/arm/boot/dts/, but
> those patterns do not match any files in the repository. Hence,
> ./scripts/get_maintainer.pl --self-test=3Dpatterns complains about broken
> references. The files of interest are actually in the directory
> arch/arm/boot/dts/nxp/imx/.

Nice, I didn't know about --self-test=3Dpatterns. But you are right, the=20
patterns do not match anymore since arch/arm dts restructuring.
I also suggest to add the Fixes tag:

=46ixes: 77da3f22b3d54 ("MAINTAINERS: Add entry for TQ-Systems device trees=
 and=20
drivers")
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> Adjust the file patterns to match the intended files.
>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Lee, please pick this minor clean-up patch.
>=20
>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 52277ee9c1b8..f5d4058b7ff4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21817,9 +21817,9 @@ TQ SYSTEMS BOARD & DRIVER SUPPORT
>  L:	linux@ew.tq-group.com
>  S:	Supported
>  W:	https://www.tq-group.com/en/products/tq-embedded/
> -F:	arch/arm/boot/dts/imx*mba*.dts*
> -F:	arch/arm/boot/dts/imx*tqma*.dts*
> -F:	arch/arm/boot/dts/mba*.dtsi
> +F:	arch/arm/boot/dts/nxp/imx/imx*mba*.dts*
> +F:	arch/arm/boot/dts/nxp/imx/imx*tqma*.dts*
> +F:	arch/arm/boot/dts/nxp/imx/mba*.dtsi
>  F:	arch/arm64/boot/dts/freescale/imx*mba*.dts*
>  F:	arch/arm64/boot/dts/freescale/imx*tqma*.dts*
>  F:	arch/arm64/boot/dts/freescale/mba*.dtsi


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


