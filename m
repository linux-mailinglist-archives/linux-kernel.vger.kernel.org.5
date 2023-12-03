Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31728020BB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 05:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjLCEvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 23:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjLCEvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 23:51:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F0411A
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 20:51:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398D9C43395;
        Sun,  3 Dec 2023 04:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701579107;
        bh=qJSUaV7uPt3ao7shYX3IVV++wIps8Pf53md930UwnS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SVEuysxrjwMEwe0uTlIvmSqvN1nwiHZGyrmrTNBR0Xsld7kkz4X/aDlVFK5/x4AXp
         ngUsnBJEVtQRwjJFNreaNc0jBc6v8ULoGXBQWx+6DGHEn56Sf9BVCdz5ZDoXkU60MD
         LwkAT3kA4YTbNDi4JgWgX4fv0uoeGirPDcigI13ZQZeV3Scu5RBU4mQVdq6W6RvOGL
         aOBtknS2Pt0p7CL9PeTBhI+JsOeEpduqT/A5z46lhrrNYP6Cq8z9V1K8cPj3EM/Rmi
         ANXke02CXUwqI5EsqwZa3LUnKPEztDJxmncqGPtBmzJ7/I1P9nV2JhYYqQDcZxzgQx
         vBBIvrtJJE0+w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: sm8450: correct TX Soundwire clock
Date:   Sat,  2 Dec 2023 20:54:36 -0800
Message-ID: <170157925836.1717511.2434506318908467858.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129140537.161720-1-krzysztof.kozlowski@linaro.org>
References: <20231129140537.161720-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 29 Nov 2023 15:05:36 +0100, Krzysztof Kozlowski wrote:
> The TX Soundwire controller should take clock from TX macro codec, not
> VA macro codec clock, otherwise the clock stays disabled.  This looks
> like a copy-paste issue, because the SC8280xp code uses here correctly
> clock from TX macro.  The VA macro clock is already consumed by TX macro
> codec, thus it won't be disabled by this change.
> 
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: sm8450: correct TX Soundwire clock
      commit: 20e886590a310665244a354e3b693b881544edec
[2/2] arm64: dts: qcom: sm8550: correct TX Soundwire clock
      commit: ead0f132fc494b46fcd94788456f9b264fd631bb

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
