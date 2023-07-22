Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6C775DA02
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 07:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjGVFO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 01:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjGVFOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 01:14:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786E63583;
        Fri, 21 Jul 2023 22:14:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1760060B05;
        Sat, 22 Jul 2023 05:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA949C433CB;
        Sat, 22 Jul 2023 05:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690002852;
        bh=3C5gRiFrVNXKCGITGywTOjqbopal9Y2cyxPCW/stNEQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=R+d/HRgY+vdPVN4ks+2PJ2lJEhULFM6tBX8bJHVHWeL5JT0BKjuWn2fbwrq9ld3WT
         sz6n4PNkzt8wHOMYpvcHw2OO0lh/Mh1WtRboy7IlmGe0kySMueioOBZaURn1B3zN8v
         KXlny6UGqQ0JgeHAEGRr7uf7dAwLlkjldCDiQQ2zisCKejjVRJ6eh8ecN2RnuzfE9T
         CIPnn0vPvwemi76PgYyLFdfU+Mxd/AUgHj70dDr9I3nU8Nvf3w1g1Lktgei6I39o/0
         5pFbxLvoqhAHlGXtR0qFbz8ceSABz9hLjJGAeD9BWz6A/AkK+UMzlgiCrbcVfigPI/
         D+kosA1I2FdMw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 1/4] arm64: dts: qcom: sc8180x-pmics: add missing qcom,spmi-gpio fallbacks
Date:   Fri, 21 Jul 2023 22:17:11 -0700
Message-ID: <169000304224.3611206.18378754069803638383.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720083500.73554-1-krzysztof.kozlowski@linaro.org>
References: <20230720083500.73554-1-krzysztof.kozlowski@linaro.org>
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


On Thu, 20 Jul 2023 10:34:57 +0200, Krzysztof Kozlowski wrote:
> The GPIO children of PMICs should use qcom,spmi-gpio fallback:
> 
>   sc8180x-primus.dtb: pmic@0: gpio@c000:compatible: ['qcom,pmc8180-gpio'] is too short
> 
> 

Applied, thanks!

[1/4] arm64: dts: qcom: sc8180x-pmics: add missing qcom,spmi-gpio fallbacks
      commit: 0304fc1de3d930db83749cca6ccb3a4f89918fc4
[2/4] arm64: dts: qcom: sc8180x-pmics: add missing gpio-ranges
      commit: 565951b1202e1984154abaae4567f16f8073fca3
[3/4] arm64: dts: qcom: sc8180x-pmics: align SPMI PMIC Power-on node name with dtschema
      commit: bf520227bd32381c587fa36271475e035daab3d7
[4/4] arm64: dts: qcom: sc8180x-pmics: align LPG node name with dtschema
      commit: 4af302a7e29e70bd930e80ab8f967da48a99a31a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
