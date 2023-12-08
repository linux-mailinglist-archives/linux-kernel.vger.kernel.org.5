Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D3680A62B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574086AbjLHOwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574126AbjLHOve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:51:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390201BEA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:51:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296FAC43391;
        Fri,  8 Dec 2023 14:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702047081;
        bh=+NSdCIU9xKZjuOomM6eVNr+zZBHKb8GcvYdKwFvQrFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rCE65J8KX8bX5GRfRilS2mwdwe4kmUBCpzdice+WBsWjuxX0scJTEDXcKgSXpKQxl
         16tnUAYwj0JiHOk3fzZuFLHc6exex1T8BDdRwt9aLfuTbou+ioxpS/rxO6VztJian8
         lO6Ee/0g5BCg1tfXDu8JzsRRspcSXuJqMU0MveiSC5Fmx+qZZZKL/j+L17gdbkQHA0
         HY9hGU6wIg6BhkSusYs9fwsjx34pXNDOkS9lhuMqjS6DOU/2uZp+vb5qnW+9Nvyb79
         27z5HcYSZ9mFV+VAnH54kMN48pe+9ZqkkIF7YZsA55a5knNGFv/b1HChTetx7UVEiL
         027yZRbryHAug==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 0/8] arm64: dts: qcom: Introduce SM8650 platforms device tree
Date:   Fri,  8 Dec 2023 06:55:30 -0800
Message-ID: <170204733635.342318.13009978624343160327.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231130-topic-sm8650-upstream-dt-v5-0-b25fb781da52@linaro.org>
References: <20231130-topic-sm8650-upstream-dt-v5-0-b25fb781da52@linaro.org>
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


On Thu, 30 Nov 2023 11:19:55 +0100, Neil Armstrong wrote:
> This introduces the Device Tree for the recently announced Snapdragon 8 Gen 3
> from Qualcomm, you can find the marketing specifications at:
> https://docs.qualcomm.com/bundle/publicresource/87-71408-1_REV_B_Snapdragon_8_gen_3_Mobile_Platform_Product_Brief.pdf
> 
> Bindings and base Device Tree for the SM8650 SoC, MTP (Mobile Test Platform)
> and QRD (Qualcommm Reference Device) are splited in two:
> - 1-5: boot-to-shell first set that are only build-dependent on Clock bindings
> - 6-8: multimedia second set that are build-dependent with Interconnect bindings
> 
> [...]

Applied, thanks!

[1/8] dt-bindings: arm: qcom: document SM8650 and the reference boards
      commit: 78804eecbe5c4d533ae8b7c3a85b278e3594ec94
[2/8] arm64: dts: qcom: add initial SM8650 dtsi
      commit: d2350377997f3606d5b76ee7dc6101c148048951
[3/8] arm64: dts: qcom: pm8550ve: make PMK8550VE SID configurable
      commit: 707060bf2a3cf3329b848e12a038de4d81356579
[4/8] arm64: dts: qcom: sm8650: add initial SM8650 MTP dts
      commit: 6fbdb3c1fac7d48f996098254758736e0b47f6b2
[5/8] arm64: dts: qcom: sm8650: add initial SM8650 QRD dts
      commit: a834911d50c1dda9c3022141e9f9c948e707a0ff
[6/8] arm64: dts: qcom: sm8650: add interconnect dependent device nodes
      commit: 10e024671295184fe7556fcb427444b57d2e0ed5
[7/8] arm64: dts: qcom: sm8650-mtp: add interconnect dependent device nodes
      commit: deb63527ab248301adc302e21d79c0aae5a827db
[8/8] arm64: dts: qcom: sm8650-qrd: add interconnect dependent device nodes
      commit: 0c5b1016b5f30eb2313f942abef5bd7a7be12ae8

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
