Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131E876A510
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjGaXtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjGaXtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:49:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E9010C7;
        Mon, 31 Jul 2023 16:49:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61F676135D;
        Mon, 31 Jul 2023 23:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238B8C43391;
        Mon, 31 Jul 2023 23:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690847384;
        bh=bj0pCBNZ9hVqX76Wy0UM89XCtV+ZI2fa5wffdBYeMVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d9Qhr11zvXK7fwo4kYEHzDwmYhA0t2OczBc+HP3J0OoGjAPu7rz79ze7dfTzycd3v
         ik8ehLKC2HPwsS1mCd561+jbzg8t+Q8HUqiLqim6Q77vo1U/zQ7pvP2oSBJJs90wUn
         42gbJePHXql4zH5vYFXkEUSHFCB8l9GqxyRAlForunYCjBEJ06I3YKnl4PcFITm1JE
         Bo1lEA1GxldkburLtOE4jPkhZNJFMi15cHPod1wpAUxpeAj69y4oHiqp9EgOa3+4B0
         8oIybJhlCEBacA0pETqtHhphDzXOUGNW6FliOV3ZX3Ahi5Zmis8u4PCjCYXV4q1yX1
         Hl0oiWq4CN9nQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v5 0/6] arm64: qcom: add Type-C Altmode support
Date:   Mon, 31 Jul 2023 16:52:42 -0700
Message-ID: <169084756379.3010488.13071901069410623969.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v5-0-9221cd300903@linaro.org>
References: <20230601-topic-sm8550-upstream-type-c-v5-0-9221cd300903@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Jun 2023 10:07:12 +0200, Neil Armstrong wrote:
> This adds the missing bits to support the USB-C Altmode
> support on SM8550.
> 
> These are the following changes since the previous SM8450 SoC:
> - No more GLINK altmode events for USB only changes, only DP
> - Type-C orientation is available on a PMIC signal connected
>   to a GPIO line
> - When altmode is disconnected, an 0xff mode event is sent.
> 
> [...]

Applied, thanks!

[4/6] arm64: dts: qcom: sm8550: add ports subnodes in usb/dp qmpphy node
      commit: 243f1a6d3df947874827a9a8837145621cbef7d3
[5/6] arm64: dts: qcom: sm8550-mtp: add pmic glink port/endpoints
      commit: 7a69845b3a08eb28dacbef35f47d979e4908e21f
[6/6] arm64: dts: qcom: sm8550-qrd: add pmic glink port/endpoints
      commit: fd42c8ec68905bfd093ce08ecf893d995d8f1478

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
