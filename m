Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE04F7A6F09
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 01:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjISXDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 19:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbjISXDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 19:03:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189F7C4;
        Tue, 19 Sep 2023 16:03:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91BCC433CC;
        Tue, 19 Sep 2023 23:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695164620;
        bh=qF4/9d6eVhS5IiOnbMCUg5Jo8SdxsHnh1wZSpqLGTW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ABhdGUDFY+QyKtk1C0f9DweY+iaYrvY8dNhfiCe8Py42wGqb3sfEGSXTy9IVnI7wd
         MDlitU6QzJ0d8sJTD1ima1nSr3L1OHjtRAde8u/kACUhfeCq8hvjjWQ0FjbLpFYmb+
         NIK1lD3aeld3GB0qMA/2spgadAwuuksiRPozEd38ls0U+uqmGacFI1nOzOkLoooJpc
         T1uJJnYC7AP+lCRdc2ib2yyHZBcrLVqth4FBzOd1IuPq48av0pTpVuu2C+dlTcWTYw
         Dg+cpjbagYV75OXcV6LuvdCehOM0HHFKaDAl1Gr/iszyZOWmmJncvWgZj3cqvHyPCn
         9CW2Vu5JtMfUg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        cros-qcom-dts-watchers@chromium.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] Clean up LPASS_LPI probe
Date:   Tue, 19 Sep 2023 16:07:31 -0700
Message-ID: <169516485983.787935.11341835418351027559.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230714-topic-lpass_lpi_cleanup-v1-0-dc18b5bd14f7@linaro.org>
References: <20230714-topic-lpass_lpi_cleanup-v1-0-dc18b5bd14f7@linaro.org>
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


On Fri, 14 Jul 2023 14:40:45 +0200, Konrad Dybcio wrote:
> Some SoCs (like SM6115 or SC7280 with various firmwares) expect a single
> clock for the LPASS pinctrl.
> 
> This serires addresses that by simplifying the probe code and relying
> on bindings to sanction the correct number of clocks. That allows us to
> shoot down another downstream-ism.
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: sc7280: Remove qcom,adsp-bypass-mode
      commit: 274926cc4ced14f4e61204c0cd23fd099daa9b16

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
