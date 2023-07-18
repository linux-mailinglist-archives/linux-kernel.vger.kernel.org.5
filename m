Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBEF75726D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 05:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjGRDkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 23:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjGRDkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 23:40:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D41F3;
        Mon, 17 Jul 2023 20:40:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC7386125A;
        Tue, 18 Jul 2023 03:40:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39A1C433C8;
        Tue, 18 Jul 2023 03:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689651643;
        bh=ApO+HLWK+YRX5/x1OY3KALNgxip6sEEWcklUBcK2dYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IpjAJl7cE9YX/FgD3Qh0WLHhtOwqD0/Gn4c/ivj8bZTh3T1kPEafiV3qq9Wq3FzKF
         IVBmFohrNBRkdk0+5223mmf4t/htenZOAtQCBHJKM6sl2f9S8TNubRocOW7Cn1pGaM
         eDXu9pjNPVUeXbhexFh4qJbtETmNu/k8XR3dKIzz7QN0Ys/0G3PP/IMhWzjjfscU/n
         fzDk7tcYopm8+++sMyRgBbl7EiPgPTvRPmAGlSxe6GtMXsqM5sil8oX7UfNZEpbf1S
         CAUELQFsWpbKkMzd9CpnNYyGh1NLnFrnw9gvzQn2kdZKD2+CIJ0ltPtY/wfh+oNDqD
         /p/hquxEiuW2Q==
Date:   Tue, 18 Jul 2023 11:40:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        shenwei.wang@nxp.com, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH V4 0/3] correct the lpuart compatible for imx8dxl and
 imx93
Message-ID: <20230718034031.GH9559@dragon>
References: <20230705015602.29569-1-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705015602.29569-1-sherry.sun@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 09:55:59AM +0800, Sherry Sun wrote:
> This patch set corrects the lpuart compatible for imx8dxl and imx93 platforms,
> also correct the corresponding fsl-lpuart dt-binding doc. 
> 
> ---
> Changes in V4
> 1. add Reviewed-by tag for patch#3
> 
> Changes in V3
> 1. remove the redundant fsl,imx8ulp-lpuart entry in patch#3
> 2. change const to enum for better readability in patch#3
> 
> Changes in V2
> 1. drop the imx8ulp dts changes in last version patch set
> 2. add both "fsl,imx8ulp-lpuart" and "fsl,imx7ulp-lpuart" for imx93
> 3. correct the dt-bindings for imx93 lpuart compatible
> ---
> 
> Sherry Sun (3):
>   arm64: dts: imx8dxl: remove "fsl,imx7ulp-lpuart" compatible for
>     imx8dxl
>   arm64: dts: imx93: add "fsl,imx8ulp-lpuart" compatible for imx93
>   dt-bindings: serial: fsl-lpuart: correct imx93-lpuart dt-binding item

I've already picked up two DTS patches from v3.  The dt-bindings one
needs to go via serial subsystem tree.

Shawn
