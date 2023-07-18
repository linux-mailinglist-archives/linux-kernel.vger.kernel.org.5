Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37881757265
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 05:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjGRDiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 23:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjGRDiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 23:38:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E90F4;
        Mon, 17 Jul 2023 20:38:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D4B061405;
        Tue, 18 Jul 2023 03:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6996AC433C8;
        Tue, 18 Jul 2023 03:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689651499;
        bh=IXlI0Jr3i6MrXrSjeX+OjQHDZdhIEQLfE6pP5F3f+qM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BH1XuqHI15FpYeJgy1SI3T+I86ZdQ7KSSpoBToR8lvyKCodZsWX8/jVWYSsPq62a4
         rK54WtZWLritXhAZV7eQX71GlCJ+hYSnchrjWMOO3goqmChx7p7B7Jtb2JsBMlLxaQ
         8I2DD/tNvVs5FyldD5Nr5+Qy60wxk0OVDwQZpmGEcSnYWReSky4QIU6jrBb44sSdpJ
         EonxMUSlPjX18TI+JM2WTN+MjtiAzpoCu992Hu6rbkMxmDG3As/SUwNMu/AVRbtYaC
         96jpKNvnPc0OzjKb9nz4oIU5rJyW7zUULHg3YfBznoxWSMREPoiMsdx5GOhA1Ht4bF
         nu/M5sudu/bjQ==
Date:   Tue, 18 Jul 2023 11:38:08 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        shenwei.wang@nxp.com, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH V3 1/3] arm64: dts: imx8dxl: remove "fsl,imx7ulp-lpuart"
 compatible for imx8dxl
Message-ID: <20230718033808.GF9559@dragon>
References: <20230627025332.11133-1-sherry.sun@nxp.com>
 <20230627025332.11133-2-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627025332.11133-2-sherry.sun@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 10:53:30AM +0800, Sherry Sun wrote:
> Drop the i.MX8DXL backwards compatibility with i.MX7ULP since they
> differ from clocks handling point of view.
> 
> dtbs_check has the following warnings:
> linux-next/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: serial@5a060000: compatible: 'oneOf' conditional failed, one must be fixed:
>         ['fsl,imx8qxp-lpuart', 'fsl,imx7ulp-lpuart'] is too long
>         'fsl,imx93-lpuart' was expected
>         'fsl,imx8qxp-lpuart' is not one of ['fsl,imx8qm-lpuart', 'fsl,imx8dxl-lpuart']
>         'fsl,imxrt1050-lpuart' was expected
>         'fsl,imx8ulp-lpuart' was expected
>         'fsl,imx8qxp-lpuart' was expected
>         'fsl,imxrt1170-lpuart' was expected
>         From schema: linux-next/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>

Applied, thanks!
