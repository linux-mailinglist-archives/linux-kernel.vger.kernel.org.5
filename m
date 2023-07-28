Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CDB7667FC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbjG1I7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbjG1I7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:59:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6223CB6;
        Fri, 28 Jul 2023 01:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690534753; x=1722070753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MiL4JcDaa63IArou+91r6pY5u0LcbVgPl5qQ2hlkSVE=;
  b=Aci547Ddl/b9rgct6PAMHn/ZGEbywszOomZ72hT12UI/i1SjkkEaAKqw
   uSh5vLrMt7jBUMAN7bunjHZ42p9TmVpHNobfnviUacRA6BHfmAlM7x9V1
   zDyT+W3k+KHxEdrmuLAuY1DqMLV6c+knsLoGcPZ4YGcLD15IQ2sveuOwd
   m/syT2iFtRKP6+N7kEGLgOnJdTeQSdxYwWeqSJUpweCiagarSaeq+21g0
   yeCvusOuHq76p4K7tyeL6C7CkKAGEKLJfIhtNwoqAvMtvbgVlm+ENlTr0
   UL6BBvwRJ9J4WZ4qiMfN1XTIyWY5AAZj0iBxBGHtmqTtkiu9VvbAp1BHC
   A==;
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="asc'?scan'208";a="227039084"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 01:59:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 01:59:06 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 28 Jul 2023 01:59:04 -0700
Date:   Fri, 28 Jul 2023 09:58:29 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     William Qiu <william.qiu@starfivetech.com>
CC:     <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
Subject: Re: [PATCH v5 2/3] spi: cadence-quadspi: Add clock configuration for
 StarFive JH7110 QSPI
Message-ID: <20230728-retread-starch-3399b921718a@wendy>
References: <20230719092545.1961401-1-william.qiu@starfivetech.com>
 <20230719092545.1961401-3-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xNYFoGrA1aUBT3jU"
Content-Disposition: inline
In-Reply-To: <20230719092545.1961401-3-william.qiu@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--xNYFoGrA1aUBT3jU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey William,

Since you pinged things, I had a quick look.

On Wed, Jul 19, 2023 at 05:25:44PM +0800, William Qiu wrote:
> Add JH7110's clock initialization code to the driver.
>=20
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202306022017.UbwjjWRN-lkp@i=
ntel.com/
> Reported-by: Julia Lawall <julia.lawall@inria.fr>
> Closes: https://lore.kernel.org/r/202306040644.6ZHs55x4-lkp@intel.com/

These, as pointed out on the last version, should not be here.
kernel test robot complaints about un-applied patches do not get a
reported-by etc in subsequent versions of the same patchset, just as
comments from human reviewers do not require reported-by tags.

These tags should only be used when the code has been merged & you need
to create a new patch to fix the issue.

Hopefully, if the code is otherwise fine, Mark can fix this when he
applies the patches.

Thanks,
Conor.

--xNYFoGrA1aUBT3jU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMODNQAKCRB4tDGHoIJi
0mzeAQCBPYWIWHeooX+CXBqGc/l9282J1oE6BHOrLzocw8kPYgD/W6c8DOiiyTgN
vgn7W2EhtJn/VjCn1htwnUyT49JAdw8=
=BRBz
-----END PGP SIGNATURE-----

--xNYFoGrA1aUBT3jU--
