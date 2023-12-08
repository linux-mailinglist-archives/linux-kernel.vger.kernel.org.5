Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8ED8099CE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573065AbjLHCyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573048AbjLHCxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:53:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A51E1BD7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D8AC433AB;
        Fri,  8 Dec 2023 02:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702004014;
        bh=mY4Mc6uwF0vHasw2kbyA/nmgIFXLTBWx3yvpd073w74=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=e+GyhKvCK2FU4wcc8owpUaopc+YJ5Hxl5OuN8axsGqLxWCedVUyQPOniIpd5HWBqf
         YP/WspXw5L2Td364/B3ofHx45mSe50vyFkHem1DM40sD3o1pvmRwprSq6dg7cJoMkS
         FXkVV9rwIO/1cuDYYReJIVKjpKAIdNz1ThyXpxvFVwFzYdcg7Kk96pUCOXfGTWv7Yz
         UYe+8dFDJ4mSz/7snLJScOINEawliYnp/IDt6ubrAsMwghMBPKTBEcrpMVvQTnSGQB
         quR04sc5m96xaZ+/ls+vC0ruOIyCk56F5fe7EqomTN7Y5FYe9WPtekjr+QXXdpNhh0
         cG+XiIbCNuMvg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc8180x: align APSS with bindings
Date:   Thu,  7 Dec 2023 18:57:38 -0800
Message-ID: <170200426920.2871025.8560389508354811931.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111204725.35707-1-krzysztof.kozlowski@linaro.org>
References: <20231111204725.35707-1-krzysztof.kozlowski@linaro.org>
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


On Sat, 11 Nov 2023 21:47:25 +0100, Krzysztof Kozlowski wrote:
> SC8180x APSS Devicetree bindings expect qcom,sc8180x-apss-shared to use
> qcom,sdm845-apss-shared fallback:
> 
>   sc8180x-lenovo-flex-5g.dtb: mailbox@17c00000: compatible: 'oneOf' conditional failed, one must be fixed:
>     ['qcom,sc8180x-apss-shared'] is too short
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc8180x: align APSS with bindings
      commit: cdecce12d55cfd25b4b8755abc3c0b320e45d1d7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
