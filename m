Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC1C8099A1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573058AbjLHCxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjLHCxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:53:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3A6172D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D4EC433CD;
        Fri,  8 Dec 2023 02:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702004003;
        bh=bXhgR4rPKkc2OF+NtTFOutIEpipf+5yKGwGL7Eh8gxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PumYDt0jekOSa9/slw4A9+gDIoPQFEwzMfxr3y4/z8LrPwqY4OQlrk7Dk1w4nVnUK
         kTUejw8FAH8GNVzZdJWq/sr2UDMBv1FQ8GVJO+2J/EhRGTXEQGvBYMSwN7ltNJJkI+
         ks8S40pGG7ceqSP9NRartyj88bIC6VCDowPJ5TvNmSlrq6Www576rP9QM9Nq2u9mU1
         xfD+aZnH+yY/0bbhVs6kBqttNDIAhtwzoBC7Oi5t+sbJ3i5e8Mc1Z7RvWFdAmCnXpm
         OQrZTM8PHBc/p+VB84ESJphQJCBmUw0tw39JBenD6/4OmLtMX5qunr//uar64UHaEv
         ZCix56WYHpGiw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Douglas Anderson <dianders@chromium.org>
Cc:     swboyd@chromium.org, linux-watchdog@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Kees Cook <keescook@chromium.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Tony Luck <tony.luck@intel.com>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 1/9] arm64: dts: qcom: sc7180: Make watchdog bark interrupt edge triggered
Date:   Thu,  7 Dec 2023 18:57:28 -0800
Message-ID: <170200426906.2871025.5763243784808512013.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106144335.v2.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
References: <20231106144335.v2.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
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


On Mon, 06 Nov 2023 14:43:28 -0800, Douglas Anderson wrote:
> On sc7180 when the watchdog timer fires your logs get filled with:
>   watchdog0: pretimeout event
>   watchdog0: pretimeout event
>   watchdog0: pretimeout event
>   ...
>   watchdog0: pretimeout event
> 
> [...]

Applied, thanks!

[1/9] arm64: dts: qcom: sc7180: Make watchdog bark interrupt edge triggered
      commit: 7ac90b4cf107a3999b30844d7899e0331686b33b
[2/9] arm64: dts: qcom: sc7280: Make watchdog bark interrupt edge triggered
      commit: 6897fac411db7b43243f67d4fd4d3f95abf7f656
[3/9] arm64: dts: qcom: sdm845: Make watchdog bark interrupt edge triggered
      commit: 263b348499454f38d36b9442c3cf9279c571bb54
[4/9] arm64: dts: qcom: sm8150: Make watchdog bark interrupt edge triggered
      commit: 9204e9a4099212c850e1703c374ef4538080825b
[5/9] arm64: dts: qcom: sm8250: Make watchdog bark interrupt edge triggered
      commit: 735d80e2e8e5d073ae8b1fff8b1589ea284aa5af
[6/9] arm64: dts: qcom: sa8775p: Make watchdog bark interrupt edge triggered
      commit: 48d5cf4772ec6268853158d9ffc54612e988ebe6
[7/9] arm64: dts: qcom: sc8280xp: Make watchdog bark interrupt edge triggered
      commit: 6c4a9c7ea486da490400c84ba2768c90d228c283
[8/9] arm64: dts: qcom: sm6350: Make watchdog bark interrupt edge triggered
      commit: 5b84bb2b8d86595544fc8272364b0f1a34b68a4f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
