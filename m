Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3036376DEAD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 05:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjHCDCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 23:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHCDCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 23:02:34 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776CA10A;
        Wed,  2 Aug 2023 20:02:32 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37331tVS044579;
        Wed, 2 Aug 2023 22:01:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691031715;
        bh=VQMZXzoWOg82MUkkbOLIpp636ppSLPT+gJSM5jaRhGo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=GTmtmlQ2IG7wMsE8qvharWtTgYgP2e9MsPuUChyVD1043o2seP1UMyKx7GuZvskMH
         to1Uz/kgeffIq+f607vArAzMwa5SPopzI+kH9TVK7e8mzFp5pnlPhtnTfV92iFGANz
         dPGIIgG4iN+Nju8WFjC097yO/9ycqd4BA73QwK0Q=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37331tn5027442
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 22:01:55 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 22:01:55 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 22:01:55 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37331sk3104606;
        Wed, 2 Aug 2023 22:01:54 -0500
Date:   Wed, 2 Aug 2023 22:01:54 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: linux-next: manual merge of the ti tree with the imx-mxs tree
Message-ID: <20230803030154.fq2gcb3fx7tz773e@impose>
References: <20230803092245.4c0fc299@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230803092245.4c0fc299@canb.auug.org.au>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09:22-20230803, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the ti tree got a conflict in:
> 
>   arch/arm64/configs/defconfig
> 
> between commit:
> 
>   b940e6846cf7 ("arm64: defconfig: select IMX_REMOTEPROC and RPMSG_VIRTIO")
> 
> from the imx-mxs tree and commit:
> 
>   8127ab5fbaee ("arm64: defconfig: Enable various configs for TI K3 platforms")
> 
> from the ti tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thank you, Stephen. I had suspected something of the sort would happen
as I picked the patch up, I will let Arnd know as well on this incoming
as part of PR.

> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc arch/arm64/configs/defconfig
> index 03fce1752521,700d5571f12b..000000000000
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@@ -938,8 -929,8 +943,9 @@@ CONFIG_SND_SOC_GTM601=
>   CONFIG_SND_SOC_MSM8916_WCD_ANALOG=m
>   CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
>   CONFIG_SND_SOC_PCM3168A_I2C=m
>  +CONFIG_SND_SOC_RK817=m
>   CONFIG_SND_SOC_RT5640=m
> + CONFIG_SND_SOC_J721E_EVM=m
>   CONFIG_SND_SOC_RT5659=m
>   CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
>   CONFIG_SND_SOC_SIMPLE_MUX=m
> @@@ -1255,7 -1246,8 +1265,9 @@@ CONFIG_ARM_SMMU_V3=
>   CONFIG_MTK_IOMMU=y
>   CONFIG_QCOM_IOMMU=y
>   CONFIG_REMOTEPROC=y
>  +CONFIG_IMX_REMOTEPROC=y
> + CONFIG_TI_K3_R5_REMOTEPROC=m
> + CONFIG_TI_K3_DSP_REMOTEPROC=m
>   CONFIG_MTK_SCP=m
>   CONFIG_QCOM_Q6V5_ADSP=m
>   CONFIG_QCOM_Q6V5_MSS=m



-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
