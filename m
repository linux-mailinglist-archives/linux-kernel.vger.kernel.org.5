Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8F38099B4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573016AbjLHCxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573052AbjLHCxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:53:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B855B19AA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D0DC433C9;
        Fri,  8 Dec 2023 02:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702004009;
        bh=xZdmIwyY8K5lx3uY+q3rAA6tBSRCBzA3ItYlVNTccWk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BSWUtJXJ4JG34G2+IJnDUQzxzpxjJmPpg04TuKDKqyRLLmzuSMZaJHSwA3cVKXD3i
         QaMxA8gDhTe2XpmNmWMcgJWZ3D+7vl19xZgoDysMmbbbZdkwhnYCmMK6cgIv4qyrC9
         L9nI2QPxo+5fZ/CF4ySu0If8/1caxWSMs7memHQ5JfcZLcVsKDQEQEbDJZKUkoM3dY
         cawiIVJcQGmozNSQgy8Hfit/8ix1FbDD/VdbLnRuIFvOEoqx9qc/vK0rWgbHPf3zLv
         /f3Yb0n1dC6bPJ/L0+4i17RKSomssqDFLTRxOOJseUvf5/1AOOOUNFw4GPnH6RZny6
         eYhLxJBCJ8EXA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: sdm845-db845c: correct LED panic indicator
Date:   Thu,  7 Dec 2023 18:57:33 -0800
Message-ID: <170200426919.2871025.9067840242673353894.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111095617.16496-1-krzysztof.kozlowski@linaro.org>
References: <20231111095617.16496-1-krzysztof.kozlowski@linaro.org>
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


On Sat, 11 Nov 2023 10:56:16 +0100, Krzysztof Kozlowski wrote:
> There is no "panic-indicator" default trigger but a property with that
> name:
> 
>   sdm845-db845c.dtb: leds: led-0: Unevaluated properties are not allowed ('linux,default-trigger' was unexpected)
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sdm845-db845c: correct LED panic indicator
      commit: 0c90c75e663246203a2b7f6dd9e08a110f4c3c43
[2/2] arm64: dts: qcom: sdm845: correct Soundwire node name
      commit: 74eed6f467db53b9b8b7fb225f6ac475449ad073

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
