Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAD277B023
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 05:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjHNDZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 23:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjHNDZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 23:25:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B409E6D;
        Sun, 13 Aug 2023 20:25:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F893628D1;
        Mon, 14 Aug 2023 03:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4ECC433CD;
        Mon, 14 Aug 2023 03:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691983510;
        bh=MDxcmIqRnZAwUCJ0nlbAwb5XYys3Rn1XAlOYQktn/uA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DaNoaWaQALZbje26swZ2x4X3SIeYM/CVzjZxOZlOw5buzslFKoEQ84Pc5FLbF01O6
         7Akt8fg0NT5F7AiN/dMUkEYfJxhBkDDuig2A0VZn7HR97LT+8hUc7SiugW8nrbwH3o
         OUMiufd6AguPfvHFstbhi8hXKT65zFx06SD5CtI2MwENWewUp01vvkmChOGRom9R47
         xZJAWgk0XQ22W+AGp7YpAaILpNziAQNo8v9uf3x3RHFUNqnjMshWhptdEWhdu+3F7H
         cFG6OayAmu+D2k7kQT7m6QCJQHyrIOQ7hqFLMd1D7+LqYY8pvXffyWlEMFHW1lxlCg
         twJ0d65zo2bDA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nikita Travkin <nikita@trvn.ru>
Cc:     David Wronek <davidwronek@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Split up TF-A related PSCI configuration
Date:   Sun, 13 Aug 2023 20:27:39 -0700
Message-ID: <169198364318.2443702.2186962304407432621.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808-sc7180-tfa-fw-v1-1-666d5d8467e5@trvn.ru>
References: <20230808-sc7180-tfa-fw-v1-1-666d5d8467e5@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 08 Aug 2023 15:10:13 +0500, Nikita Travkin wrote:
> When initially submitted, the sc7180 support only targeted CROS devices
> that make use of alternative TF-A firmware and not the official Qualcomm
> firmware. The PSCI implementations in those firmwares differ however so
> devices that use qcom firmware, like WoA laptops such as aspire1 need
> different setup.
> 
> This commit adjusts the SoC dtsi to the OSI mode PSCI setup, common to
> the Qualcomm firmware and introduces new sc7180-firmware-tfa.dtsi that
> overrides the PSCI setup for the PC mode and uses TF-A specific
> psci-suspend-param. This dtsi is added to all boards that appear to use
> TF-A.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc7180: Split up TF-A related PSCI configuration
      commit: 4fb40b22e97ecea2d18a0c450c24388909e5b44c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
