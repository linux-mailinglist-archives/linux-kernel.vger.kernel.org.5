Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424F47BBD4F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjJFQyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbjJFQym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:54:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E749EC2;
        Fri,  6 Oct 2023 09:54:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EA1C433C7;
        Fri,  6 Oct 2023 16:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696611280;
        bh=MdieDKCo2DSTUIjEnuP5J1PpUDXZyJx/S+iF2rRsaaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kko/ueaWF42t2FC5fwhK4NFL8EU/io7v8XknmVWpLTakCOvsIphLZEcc/x3dJ+E7z
         RLV7JpncvbsWqTDIcCzysjRm1AFAqAI6Do19sY9APsNl+L4KlAwI1aRqWhOCgXxtwl
         a9HLGq0gd3O5PyfvRATkv+W92u48jKPgpFOrusIndcoxmsZ7zs8c/kH3aXwyZsTafs
         tChG2JOc/5bmun7F4Xo46s3kZdAoCRCzTEA/HXWQidMbXS8loJMy3+cPHUVYcm2xmH
         yXURDRYLn9YSo+eM1w9BDXYVAkGD5cpwz3epUqcnqmc3hj534Vtwna9PqjGd+Cz865
         jEYfVp0ssasRg==
Received: (nullmailer pid 4064407 invoked by uid 1000);
        Fri, 06 Oct 2023 16:54:38 -0000
Date:   Fri, 6 Oct 2023 11:54:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 07/11] dt-bindings: mfd: syscon: Document EyeQ5 OLB
Message-ID: <20231006165438.GA4061751-robh@kernel.org>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
 <20231004161038.2818327-8-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004161038.2818327-8-gregory.clement@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 06:10:34PM +0200, Gregory CLEMENT wrote:
> Document Mobileye EyeQ5 compatibles for OLB registers that are
> misceallanous SoC related registers.

typo.

Please state what OLB is and what kind of things are in this block. IOW, 
convince me this is not just a skeleton placeholder until you add a 
bunch of providers in a real binding.

> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 8103154bbb52..70bc6e8d15ba 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -53,6 +53,7 @@ properties:
>                - mediatek,mt8135-pctl-a-syscfg
>                - mediatek,mt8135-pctl-b-syscfg
>                - mediatek,mt8365-syscfg
> +              - mobileye,eyeq5-olb
>                - microchip,lan966x-cpu-syscon
>                - microchip,sparx5-cpu-syscon
>                - mstar,msc313-pmsleep
> -- 
> 2.40.1
> 
