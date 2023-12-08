Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876818099C6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573046AbjLHCyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235766AbjLHCxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:53:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73341BCE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920C7C433CA;
        Fri,  8 Dec 2023 02:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702004012;
        bh=TlJi6eYI0lB8fAkWy8E1xUasWzuI+5TcOkZW2KYTiWY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=WwcElSzWCTmZbzjPUcTk94pwpEiT6DbVb8bd5jvml/lEnJfgG17s8i/FUFzU+tZ8d
         opm97faS4bpI6QuZAV1KoSwzy7ybKUP6A+2fLqCkR/XfXVkrTl7hJk3mXnFHS2bs8W
         KSBWC1dSj0Nc8uuUMd4JJP0ohA+71d2GMtQCyCfxAQTVT8vNW/hTWQbch/z1fbXolv
         gR5+dlmV/TviDaY+ohfUcLk163+iqBn/zvCJaT7uLsVCzTSeROUPyAuUxZrxWQPWex
         K6WqYs3/HNNoEFIlRDvsWc+o6A2rzDXElEui76Vv4R93/Qh5SS/XAW3jk6w3iAfqoH
         6UAa/Ml9Qun6A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/6] arm64: dts: qcom: sc8180x-flex-5g: use 'gpios' suffix for PCI GPIOs
Date:   Thu,  7 Dec 2023 18:57:36 -0800
Message-ID: <170200426920.2871025.15755406031779105330.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111164229.63803-1-krzysztof.kozlowski@linaro.org>
References: <20231111164229.63803-1-krzysztof.kozlowski@linaro.org>
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


On Sat, 11 Nov 2023 17:42:24 +0100, Krzysztof Kozlowski wrote:
> Linux handles both versions, but bindings expect GPIO properties to
> have 'gpios' suffix instead of 'gpio':
> 
>   sc8180x-lenovo-flex-5g.dtb: pci@1c08000: Unevaluated properties are not allowed ('perst-gpio', 'wake-gpio' were unexpected)
> 
> 

Applied, thanks!

[1/6] arm64: dts: qcom: sc8180x-flex-5g: use 'gpios' suffix for PCI GPIOs
      commit: fdff2141be44696f5cc69f2f6c20c26b9ac00760
[2/6] arm64: dts: qcom: sc8180x-primus: use 'gpios' suffix for PCI GPIOs
      commit: 9a1bd36aeb31649bc499f87671b76c7d117197e6
[3/6] arm64: dts: qcom: sm8150: use 'gpios' suffix for PCI GPIOs
      commit: af6f6778d34cb40e60368e288767f674cc0c5f60
[4/6] arm64: dts: qcom: sm6115: align mem timer size cells with bindings
      commit: f52f11271d90b1361a8364729a63a36b7456bc89
[5/6] arm64: dts: qcom: sm6125: add interrupts to DWC3 USB controller
      commit: 67e4656f4487b95a39e45884c99235f62ebfaa47
[6/6] arm64: dts: qcom: sm6375-pdx225: add fixed touchscreen AVDD regulator
      commit: 0d10ac7d2d9420d143ee738abbb06a9201e611b9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
