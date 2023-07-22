Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141F675DA1D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 07:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjGVFOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 01:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjGVFOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 01:14:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE2535BB;
        Fri, 21 Jul 2023 22:14:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78D2F60AB4;
        Sat, 22 Jul 2023 05:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441F7C433D9;
        Sat, 22 Jul 2023 05:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690002860;
        bh=/yEKNG4L3QohxbZpywKDJ0xRraUm02cPZotmD07jKUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YBggezmXvb8vW7MbSV7dA82JwK8f72jURoSYOYe8P2P1qRQjHuOL6tOoE1tB7Kzks
         ii5Wqv0e2PfK8fIBxRBS8eg3vF4qUlIlwrNSCQ/szBatcZXksir7B9p8qCF9kr5d9X
         dXDdtKNsb2jjriOasxUGLpwCNhYezArH82pA18pwi97jVrz+Z1PTQIhr5Lm2mUnzBz
         R86AQbx2ahn/R5YgZBH+VMPTO5vvfd603PnuxWuEGBmut2SYss/tQGaBCIS1D4CqMM
         4SmcivcRtw1+x/HAfTBbnqSSNq2ebTYlteXe57f8meBl7e/QIVyBkXmTU+FvNZHANW
         rk5sLeMmJ0TOw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: dts: qcom: sc8180x: USB TypeC plumbing
Date:   Fri, 21 Jul 2023 22:17:18 -0700
Message-ID: <169000304218.3611206.3255311979983705918.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612221456.1887533-1-quic_bjorande@quicinc.com>
References: <20230612221456.1887533-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Jun 2023 15:14:53 -0700, Bjorn Andersson wrote:
> This wires up USB Type-C and pmic_glink to provide battery monitoring,
> external display and orientation switching of the SuperSpeed pins.
> 
> Note that the external display has a functional dependency on INTF/PHY
> selection in the DPU driver.
> 
> Bjorn Andersson (3):
>   arm64: dts: qcom: sc8180x: Add USB Type-C of_graph anchors
>   arm64: dts: qcom: sc8180x-primus: Wire up USB Type-C
>   arm64: dts: qcom: sc8180x-flex5g: Wire up USB Type-C
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: sc8180x: Add USB Type-C of_graph anchors
      commit: b0246331c51e65c1d7c853bc617904058540d47f
[2/3] arm64: dts: qcom: sc8180x-primus: Wire up USB Type-C
      commit: ab590fa619b562b43f7c31c60d2725e04c63d961
[3/3] arm64: dts: qcom: sc8180x-flex5g: Wire up USB Type-C
      commit: 36bd9fad228e62d029380083e037a6632678cd3a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
