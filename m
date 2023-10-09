Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBE37BDEFB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376626AbjJINZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376522AbjJINZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:25:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7F0A3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 06:25:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF059C433CB;
        Mon,  9 Oct 2023 13:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696857906;
        bh=Z6eqqE3jHcCQCoAk0iVQ+k59tYwfIx9uCwy4N9r4o0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b+eN7QGEqBqyeYp1jqsSW5+PiQNJQFkRelMQ/0ODCc+7mY77gT6u+Mz2+0anJDzgG
         d7J4l14NnH+HUgxRXt2UlPSMMsB/vPEfPmcf6okO1Z8titMoaZwmnfclvVtjVfd/js
         Lw4P29oED6p8HpJIzgG6/+VeLXC5XdEP+VJfjJeBeJI05bBTgPAhK5gYsq8CFCTD/C
         VdqtIrGdpaKKZZ4dyktzXfVB/ZrY74OO2qXWYYe5FxI7ex4eWDXlqFyJ2V972nXXLA
         vJ1VHq1foWWIDybuUS/adMOaGe3d6/KEnRC7ypdvFmjDOBROhlq5+HkhxnDrAsEA6e
         /FoMIRJ9RVlow==
Date:   Mon, 9 Oct 2023 21:24:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: ls208xa: use a pseudo-bus to constrain
 usb dma size
Message-ID: <20231009132455.GE733979@dragon>
References: <20230925151015.4449-1-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925151015.4449-1-laurentiu.tudor@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 06:10:15PM +0300, Laurentiu Tudor wrote:
> Wrap the usb controllers in an intermediate simple-bus and use it to
> constrain the dma address size of these usb controllers to the 40b
> that they generate toward the interconnect. This is required because
> the SoC uses 48b address sizes and this mismatch would lead to smmu
> context faults [1] because the usb generates 40b addresses while the
> smmu page tables are populated with 48b wide addresses.
> 
> [1]
> xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
> xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 1
> xhci-hcd xhci-hcd.0.auto: hcc params 0x0220f66d hci version 0x100 quirks 0x0000000002000010
> xhci-hcd xhci-hcd.0.auto: irq 108, io mem 0x03100000
> xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
> xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 2
> xhci-hcd xhci-hcd.0.auto: Host supports USB 3.0 SuperSpeed
> arm-smmu 5000000.iommu: Unhandled context fault: fsr=0x402, iova=0xffffffb000, fsynr=0x0, cbfrsynra=0xc01, cb=3
> 
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Applied, thanks!
