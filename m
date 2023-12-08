Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA8080AFDD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 23:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbjLHW1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 17:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjLHW1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 17:27:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A4F1718
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 14:27:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F0DC433C8;
        Fri,  8 Dec 2023 22:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702074479;
        bh=GeJ8jPpWnuk5wFJ1Qh8x+xE86n20BfQfexL29S2dxSM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jR8r8WfJoWWbjMTcWJMOYjLsiELGL8CtkpmzLE+WMtMYtB9mPJY1Epy1GANz1dAYQ
         1Y1Y3klNDCiRaiFmfbKu57Ft8qdpsOa8CSXRNi26TFDFp+ShHfCrojvz7+uBXbMsJg
         h9wnGZIzCGrt/8X0Bl3I9qmMXKuqk3KrkPlkR++VaZ9TDTXSLMd2HwOdBaOb+aBpEx
         yk4C2Y3keM80kAH/+VImWWG50PKyc3G3bMDXEw05NzaD1UApwIHzeskr0sH5JjzEi9
         +CSpRoJa8qKnufe1vmDFMmb3AHug/Sds98vopQ5CcuHp9K7i7+t5MjjvQbolzaxg6r
         ydh+5zZ2PtRZg==
Date:   Fri, 8 Dec 2023 16:27:57 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Sherry Sun <sherry.sun@nxp.com>, hongxing.zhu@nxp.com,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: imx6q-pcie: Add host-wake-gpio property
Message-ID: <20231208222757.GA834524@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208205545.GA2675840-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 02:55:45PM -0600, Rob Herring wrote:
> ...

> And they should start going into root port nodes rather than the 
> host bridge node because it's the root ports that correspond to slots 
> rather than the host bridge. We've just taken shortcuts because many 
> host bridges only have 1 root port.
> 
> Note that I'm in the middle of splitting pci-bus.yaml into host bridge, 
> PCI-PCI bridge (and RP), and common device schemas.

Hooray!  Thanks for working on that; the conflation of host bridge and
Root Port is a real annoyance.

Bjorn
