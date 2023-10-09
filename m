Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B94E7BDF52
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376969AbjJIN2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376962AbjJIN2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:28:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5C7D6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 06:28:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CB4C433C9;
        Mon,  9 Oct 2023 13:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696858119;
        bh=pGZdqxaNbSq8zH8pddJczhlBAt0WXXUqziSW3uxHY+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bCs4bRIUD+5WgYumsAXYu+nalONVyN4lPVv6fX2VhweZRjn18F0q0rCk0+07kBi9b
         WM5891lcDys06zCyjAQehaq6wO87hxXPJIyttyB2Jya+BXeeV3A9tcuvpfwRBkdxGK
         GOszUBSXUcNBF7Z9p42OOIE9tJwtmEHH5Idwm2nYAfdp8aD5pUyfeSJUejeyB/zu8U
         6D4F6/1yI1w7YVJGxX8ETgaWquzkGyXfVvpfY79EW3uk/KKO+jHhlVPETMUloExr0u
         kkkGunMavXEAzDUEuqOgKCPeVZqOnQtq3jHA3CIXwP7ShQHWr6c/1PPTs5XjSSXgrU
         TqCLFyA3XNCqA==
Date:   Mon, 9 Oct 2023 21:28:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     clin@suse.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
        eagle.zhou@nxp.com, festevam@gmail.com, imx@lists.linux.dev,
        joy.zou@nxp.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, pierre.gondois@arm.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shenwei.wang@nxp.com,
        sherry.sun@nxp.com
Subject: Re: [PATCH v2 0/7] arm64: dts: imx8qxp add emda support
Message-ID: <20231009132819.GF733979@dragon>
References: <20230925204913.3776656-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925204913.3776656-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 04:49:06PM -0400, Frank Li wrote:
> eDMAv3 patch was accepted.
> https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/log/?h=next
> 
> This is dts parts.
> 
> Add 8qxp edma support and enable lpuart1..3 dma support.
> 
> Change from v1 to v2
> - rebase scu-pd.c to 6.6rc1
> - change "F" to "f"
> - Add 8qm edma dts change.
> - Add lpuart0 dma setting (console tty will disable dma)
> 
> Frank Li (7):
>   genpd: imx: scu-pd: fixed dma2-ch domain defination
>   arm64: dts: imx8: add edma[0..3]
>   arm64: dts: imx8: add edma for uart[0..3]
>   arm64: dts: imx8qm: Update edma channel for uart[0..3]
>   arm64: dts: imx8: update lpuart[0..3] irq number
>   arm64: dts: imx8qxp-mek: enable 8qxp lpuart2 and lpuart3
>   arm64: dts: imx8qm-mek: enable 8qm lpuart2 and lpuart3

Applied 2/7 ~ 7/7, thanks!
