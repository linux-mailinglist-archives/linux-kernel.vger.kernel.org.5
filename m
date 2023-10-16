Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B3E7C9DDE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 05:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjJPD22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 23:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjJPD2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 23:28:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA6DC5;
        Sun, 15 Oct 2023 20:28:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0543FC433C7;
        Mon, 16 Oct 2023 03:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697426903;
        bh=oMOPLQgD3iWGapH/3B59TLY7Lv23EB8oNxoTvl8H7yg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CltrR/13sdu+pWcti8uaSC/at59R+e7GsQ/lf8kDOJCjZXr6TcwdrGuYzH2r/2CIq
         tLWVgZBBmPCzgfcwRKuUCitxxFxW9EST0j0YNqWtmbcBH0WrSpEpnFyBcT/W27smTu
         phztd2Dnind37defHBfMi+iPbgKqY6aumsiiyvuhgR4m8F2pgMSD73CoAd5joqSxtx
         Yn8Et2AV8gvY6fcmLEdY5ym/AUOwXODqA+fCSrAJueu8R4dYarO3cqf4OTvZgKHMkl
         3WC/c4yB3dFsEAi4LkUxltJxwswmgdFo8nd3m2gyo0NQWh+Mxc3LckrvN7+yRxcmZJ
         YpHm4Jj8pz8iw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Om Prakash Singh <quic_omprsing@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: (subset) [PATCH v4 0/5] arm64: qcom: sm8x50: enable RNG
Date:   Sun, 15 Oct 2023 20:32:08 -0700
Message-ID: <169742712187.930433.14209128354915292443.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231003-topic-sm8550-rng-v4-0-255e4d0ba08e@linaro.org>
References: <20231003-topic-sm8550-rng-v4-0-255e4d0ba08e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 03 Oct 2023 09:10:18 +0200, Neil Armstrong wrote:
> Enable RNG on SM8550 & SM8450 by reverting the PRNG bindings & DT
> for SM8450 and correctly document it as a True Random Number Generator.
> 
> - SM8550 QRD test run:
> 
> smccc_trng qcom_hwrng
> 
> [...]

Applied, thanks!

[4/5] arm64: dts: qcom: sm8550: add TRNG node
      commit: 3b3ba999046e246cfd570e5399adea2f82df9312
[5/5] arm64: dts: qcom: sm8450: add TRNG node
      commit: c2c9fa136253daf6b3e25c3ea4952d9f2c4da8cf

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
