Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CB6779167
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbjHKOI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjHKOI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:08:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33429D7;
        Fri, 11 Aug 2023 07:08:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C68906501D;
        Fri, 11 Aug 2023 14:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0458DC433C8;
        Fri, 11 Aug 2023 14:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691762907;
        bh=MMu9144jysbkgPQyng6LyeHAwzfEw60hJu9CmbI/hFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eAgyKKG0z/BivdQQI8Z+LE7cP+5K1+mF+RYduLZc0CV9SzlwmtnvXo86m58jeRxoK
         duHOZwHrw0FU/JH374LkYAL2kq1kauB9X4GIpRPI/Gp5zjoKyB+qvMGmV2Pc4MFNzY
         uOANCcsLzsUQH3eEMebnlBsfuT4lyiVMoJ9qK0tYXTj7wzhR+wp9WNEy8ya1XLypzU
         fQpqzXK/X7Elz4yOrcDV1I5jlEQmlo8c33hwHb0C5GfPmFVktysuVYFFMuM0MdiUiB
         qBM6nhrGNdVWLSfCZDzlPtfC3AZ7Ko4m1RIHok0oZRkBCuAbWMwI45XXR/UTsGhy51
         XnxLTmkmSVqzg==
Date:   Fri, 11 Aug 2023 22:08:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, tharvey@gateworks.com,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH] arm64: dts: imx8m-venice: Pass "brcm,bcm4329-fmac"
Message-ID: <20230811140815.GV151430@dragon>
References: <20230806233333.815702-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230806233333.815702-1-festevam@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2023 at 08:33:33PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Pass "brcm,bcm4329-fmac" to fix the following schema warnings:
> 
> imx8mp-venice-gw74xx.dtb: wifi@0: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['cypress,cyw4373-fmac'] is too short
> 	'cypress,cyw4373-fmac' is not one of ['brcm,bcm4329-fmac', 'pci14e4,43dc', 'pci14e4,4464', 'pci14e4,4488', 'pci14e4,4425', 'pci14e4,4433']
> 	from schema $id: http://devicetree.org/schemas/net/wireless/brcm,bcm4329-fmac.yaml#
> 
> imx8mn-venice-gw7902.dtb: wifi@0: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['brcm,bcm43455-fmac'] is too short
> 	'brcm,bcm43455-fmac' is not one of ['brcm,bcm4329-fmac', 'pci14e4,43dc', 'pci14e4,4464', 'pci14e4,4488', 'pci14e4,4425', 'pci14e4,4433']
> 	from schema $id: http://devicetree.org/schemas/net/wireless/brcm,bcm4329-fmac.yaml#
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied, thanks!
