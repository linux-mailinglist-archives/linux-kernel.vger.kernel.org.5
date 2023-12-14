Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999428129B7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbjLNHtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjLNHto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:49:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31761AF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:49:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE14C433C7;
        Thu, 14 Dec 2023 07:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702540190;
        bh=aKjTmmoOVOxRjZC+1SBv+lZ/01Wzl2vD9ezRGCJZItY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CNt4STBKvzvqfafaCOE1wvsddkUjQJJNZpGf9ZPAudcjC/869D3fnoCeiNdThFAYM
         wVc9JAjIcdUfCjGsU3Blit3Px4w2j2K9Jt6A8IAAP0cgRP4KXtdE/W7vbBYU12npn7
         75UCzgabkN3krUJlse/2MJ+CeXKR8TtVOXYLtAGhv9ms71PJemXEPaPyfoBaesTOag
         iNU5qbRYR8z/MjjdUHFhaoZYXIEShXThI1dnjVKtvKSwII3GNoW4JNI3/weK+MWsl6
         deYxvCj+2Gpne+sHrKEG5vXDpRtB+WO8Sg/sFPzNiGbRjGj1r6bIV9DQ+wf6rkFtc2
         rX4R3CIzYPBdg==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rDgTe-0002v0-06;
        Thu, 14 Dec 2023 08:49:50 +0100
Date:   Thu, 14 Dec 2023 08:49:50 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] ARM/arm64: dts: qcom: fix USB wakeup interrupt
 types
Message-ID: <ZXqzntjuvD5ls6IQ@hovoldconsulting.com>
References: <20231120164331.8116-1-johan+linaro@kernel.org>
 <ZXc7KcjF82EgiXWd@hovoldconsulting.com>
 <06354190-b572-46e4-8036-0fae7f15dd15@quicinc.com>
 <6e9c93a6-48d0-4200-903c-caf271e2531d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e9c93a6-48d0-4200-903c-caf271e2531d@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 07:39:59PM +0100, Konrad Dybcio wrote:
> On 12/12/23 10:30, Krishna Kurapati PSSNV wrote:
> 
> [...]
> 
> > SM6375, I think GIC_SPI is fine but I will try to get back on this.
> interrupts-extended = <&intc GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>,
>                                                <&mpm 12 IRQ_TYPE_LEVEL_HIGH>,
>                                                <&mpm 93 IRQ_TYPE_EDGE_BOTH>,
>                                                <&mpm 94 IRQ_TYPE_EDGE_BOTH>;
>                          interrupt-names = "hs_phy_irq",
>                                            "ss_phy_irq",
>                                            "dm_hs_phy_irq",
>                                            "dp_hs_phy_irq";
> 
> the mpm node is not yet upstream (I only managed to untangle the
> related mess recently), I'll submit this soon.

Perfect, thanks!

Johan
