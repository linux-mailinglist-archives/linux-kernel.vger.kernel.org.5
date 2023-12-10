Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896F280BE25
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 00:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjLJXVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 18:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJXVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 18:21:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3ECEB
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 15:21:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBCCC433C7;
        Sun, 10 Dec 2023 23:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702250472;
        bh=cYa9J1ieXiNcVmac3GC210D9qnNDg5hPHhQXN5DdsbU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PJG/QnmF+SSe7sxvcxKWBSFKBXVU5hObbY49NBOwyZBJkkQg7vpBTo0W1J6Qir8kH
         +kKUayKPLLmgIqGzQLOmc7j4q9pwa9AZRToPo9Coa/Cfx+dLJmUBGHPZdMFi3yhXqv
         FbePG0qe+wg3b8tsbES6OAheEoeQkIACfPYCK2kOjt0EACj/PKB2A5pPJ9nLUXikV2
         VkdJrIbW8BB1otr09jHhLhEjEfc3IBh+E7Q4P0DVr437UnSrxTo+gILIAnb6rCZRdv
         QvWtom9ux3QKNoJMVion5yZyu1kK9w7ROfUg2kXQaNiRlEsSW5x9nzz8XYE9TTPYaZ
         kBVo4+KjwUSIg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: pm8550: drop PWM address/size cells
Date:   Sun, 10 Dec 2023 15:25:35 -0800
Message-ID: <170225073869.1947106.15081606683916739366.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231208124332.48636-1-krzysztof.kozlowski@linaro.org>
References: <20231208124332.48636-1-krzysztof.kozlowski@linaro.org>
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


On Fri, 08 Dec 2023 13:43:32 +0100, Krzysztof Kozlowski wrote:
> The address/size cells in PWM node are needed only if individual LEDs
> are listed.  If multi-led is used, then this leads to dtc W=1 warnings:
> 
>   pm8550.dtsi:65.19-73.5: Warning (avoid_unnecessary_addr_size): /soc@0/spmi@c400000/pmic@1/pwm:
>     unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: pm8550: drop PWM address/size cells
      commit: a1c7da5fb02c0c24e5d8b2d78d449482bce5e92b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
