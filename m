Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48048099AF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573093AbjLHCxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235713AbjLHCx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:53:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A25619A2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026B0C433BF;
        Fri,  8 Dec 2023 02:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702004007;
        bh=aSWILFwu/oQmJ57P5F2M3EaIkFjiiJY4+2urq78ilXs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NIrStDXd5xEU5laPkdBc5Br9pZwncfHyugKTlV3S5iFxozriJBfveSIM8YM4rpMHl
         EIOSn+qxUkqCHdqhqXKVhuFuCHYi1PQKYNL8rX2JTTmvDJIpBkIsQYJ7mrVsQ8Z8kA
         +CMewyFoXukJeHRYQN/fRFSmiSy0WJwkWR5iVa4FCwd1ZjqC3KUGUeFXebmjJOj/jk
         wOOrQfqfBk2/AhsSVJQfh4K7RGETGlVlpgFtRvD1sn4WM4+E7Ybu550tWAnEj8tHOR
         IktBShNcXBqcfcLMo4kedtfDLt5byHgyD3YxHi9KGO9Zpb3Eq+wA2PVNiB6ivQL3en
         kk+/0RPUYIixg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: qdu1000: correct LLCC reg entries
Date:   Thu,  7 Dec 2023 18:57:31 -0800
Message-ID: <170200426915.2871025.17631856635875176410.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107080417.16700-1-krzysztof.kozlowski@linaro.org>
References: <20231107080417.16700-1-krzysztof.kozlowski@linaro.org>
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


On Tue, 07 Nov 2023 09:04:16 +0100, Krzysztof Kozlowski wrote:
> According to bindings and Linux driver there is no
> "multi_channel_register" address space for LLCC.  The first "reg" entry
> is supposed to be llcc0_base since commit 43aa006e074c ("dt-bindings:
> arm: msm: Fix register regions used for LLCC banks"):
> 
>   qdu1000-idp.dtb: system-cache-controller@19200000: reg: [[0, 421527552, 0, 14155776], [0, 438304768, 0, 524288], [0, 572293416, 0, 4]] is too long
>   qdu1000-idp.dtb: system-cache-controller@19200000: reg-names:0: 'llcc0_base' was expected
>   qdu1000-idp.dtb: system-cache-controller@19200000: reg-names: ['llcc_base', 'llcc_broadcast_base', 'multi_channel_register'] is too long
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: qdu1000: correct LLCC reg entries
      commit: b0e0290bc47dd1bc8b1bd0c6b9ec0347564f3f21
[2/2] arm64: dts: qcom: qdu1000-idp: drop unused LLCC multi-ch-bit-off
      commit: 468cf125e4796e8ef9815e2d8d018f44cf8f1225

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
