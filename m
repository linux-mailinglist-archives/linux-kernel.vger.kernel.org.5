Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57597A6F13
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 01:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbjISXEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 19:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbjISXD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 19:03:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C44D9;
        Tue, 19 Sep 2023 16:03:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C1FC43391;
        Tue, 19 Sep 2023 23:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695164629;
        bh=Cvf1kg5rPSVb3dgmOVgVEB6Gg/q96WLqe4JnbgiLtR8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=I7xnCwYowl8JzVC340VQm+ijrk1nyICKoNxX1oHQ2NFLxJJeJ1yb8ZacBGov4OY8a
         RJ13x0kWeT6s2F6vK954Ikov+yUcW+P6t25w3uZXvEtRlPMc4FmfALjCmxyh+cZEyn
         nHIyH2trVCFPnArah5lDZRIkY7Owf642+3EM3vvnU9xk4gRG91N42svu3XYgiPuWD9
         tF9yO+31rDYuQeRP4bmVHkwjgTuU3gepdu9uF/FEx0+v9hl7YBKxHlTLDokAjWmQww
         mPYFo8m4XVmAlToP0jPmsMlYwA0g4gmHBdhZDWOpcQzVcNnX+kbLADehfHq/5LQ06u
         VQ3Et6xDpEIsA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [RESEND PATCH 1/2] arm64: dts: qcom: msm8994: fix duplicated @6c00000 reserved memory
Date:   Tue, 19 Sep 2023 16:07:38 -0700
Message-ID: <169516485987.787935.2863146104390557606.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230720072048.10093-1-krzysztof.kozlowski@linaro.org>
References: <20230720072048.10093-1-krzysztof.kozlowski@linaro.org>
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


On Thu, 20 Jul 2023 09:20:47 +0200, Krzysztof Kozlowski wrote:
> Reserved memory @6c00000 is defined in MSM8994 DTSI and few boards:
> 
>   Warning (unique_unit_address_if_enabled): /reserved-memory/reserved@6c00000: duplicate unit-address (also used in node /reserved-memory/hole2@6c00000)
>   Warning (unique_unit_address_if_enabled): /reserved-memory/reserved@6c00000: duplicate unit-address (also used in node /reserved-memory/memory@6c00000)
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: msm8994: fix duplicated @6c00000 reserved memory
      commit: bf80e606ca8db08c840d1ad394ec75eaabba717b
[2/2] arm64: dts: qcom: msm8992-libra: drop duplicated reserved memory
      commit: f32096602c19e68fb9bf04b494d13f1190602554

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
