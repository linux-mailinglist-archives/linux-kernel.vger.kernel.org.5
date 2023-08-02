Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D55276DB76
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 01:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjHBXXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 19:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjHBXWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 19:22:54 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24B1D9;
        Wed,  2 Aug 2023 16:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1691018568;
        bh=s+wJuNHRcXYhlpADMo06g8Fz7nrpZ9yYMbSWWaXuWCE=;
        h=Date:From:To:Cc:Subject:From;
        b=UrTM6UqB+P6V1xZ1F8md9RIfXE9XHfMDu6QPbvIDFa5COXX3gn5poDUGQjbXmBM6n
         7nsRyZwr+uXys7tPJ31OhLfc/CV5eywFmZOk28zFkGGv0TFG3jMgWVklPIXusW00Kl
         NiAU/SQQ6aDhCrQD2hVtECB6oBFSX1Cco7Za6eMXqB5uo8p4s4k1JBsLEPm7DRnfD2
         8h0TcN2bUHfpsWMxxn2WW5het+QE08R7QGTK/kveRnr/Zq9e04OYutWamhkQHn7uKo
         /HCe/QPyjwcN3FX2dezfkM/JRg8Z3V8CeFqrhJWPXdVvx7rtipBFUm233SO2LTrGmP
         4FoyGN3RohRVA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RGSgr1CK1z4wZJ;
        Thu,  3 Aug 2023 09:22:47 +1000 (AEST)
Date:   Thu, 3 Aug 2023 09:22:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>, Udit Kumar <u-kumar1@ti.com>
Subject: linux-next: manual merge of the ti tree with the imx-mxs tree
Message-ID: <20230803092245.4c0fc299@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Tu2vuV8DJFVY+E_42AY.OxX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Tu2vuV8DJFVY+E_42AY.OxX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the ti tree got a conflict in:

  arch/arm64/configs/defconfig

between commit:

  b940e6846cf7 ("arm64: defconfig: select IMX_REMOTEPROC and RPMSG_VIRTIO")

from the imx-mxs tree and commit:

  8127ab5fbaee ("arm64: defconfig: Enable various configs for TI K3 platfor=
ms")

from the ti tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/configs/defconfig
index 03fce1752521,700d5571f12b..000000000000
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@@ -938,8 -929,8 +943,9 @@@ CONFIG_SND_SOC_GTM601=3D
  CONFIG_SND_SOC_MSM8916_WCD_ANALOG=3Dm
  CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=3Dm
  CONFIG_SND_SOC_PCM3168A_I2C=3Dm
 +CONFIG_SND_SOC_RK817=3Dm
  CONFIG_SND_SOC_RT5640=3Dm
+ CONFIG_SND_SOC_J721E_EVM=3Dm
  CONFIG_SND_SOC_RT5659=3Dm
  CONFIG_SND_SOC_SIMPLE_AMPLIFIER=3Dm
  CONFIG_SND_SOC_SIMPLE_MUX=3Dm
@@@ -1255,7 -1246,8 +1265,9 @@@ CONFIG_ARM_SMMU_V3=3D
  CONFIG_MTK_IOMMU=3Dy
  CONFIG_QCOM_IOMMU=3Dy
  CONFIG_REMOTEPROC=3Dy
 +CONFIG_IMX_REMOTEPROC=3Dy
+ CONFIG_TI_K3_R5_REMOTEPROC=3Dm
+ CONFIG_TI_K3_DSP_REMOTEPROC=3Dm
  CONFIG_MTK_SCP=3Dm
  CONFIG_QCOM_Q6V5_ADSP=3Dm
  CONFIG_QCOM_Q6V5_MSS=3Dm

--Sig_/Tu2vuV8DJFVY+E_42AY.OxX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTK5UYACgkQAVBC80lX
0GzoRQgAiRfAOFYqze+KUqtVAAosm4u/4U9fFVu076q+jeJ/eegrdPjhjq9Y3l4J
rjBlslqu+YSiMIH69RrllOOxkpbUZnYOo7ddBZZUpXpICxqZ/I16+m7fM+fWsyjW
9N6uyTgnamLdKUFrl4SRzernmBRuAJOcdHrPvqJPXdz8bLbA5CEsCkwCiHG8YVe+
CFflxp98B4ujagcCMnUiCyksQIFLRCralVfnrdve9yyqF9RyFpBlLq/sIPSgl1EK
LbJpw04L60WeJO8SH+fDxx1YHvsY0RSrLxAKA3PAL+RFyt/fw/3ze5m1AnOvmeuy
ty5R1lB6DFNYjxexO29rmCWEKjKYMQ==
=kU2V
-----END PGP SIGNATURE-----

--Sig_/Tu2vuV8DJFVY+E_42AY.OxX--
