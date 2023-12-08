Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5952980A5EC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574060AbjLHOvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574011AbjLHOvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:51:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F63F1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:51:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F34FC433CC;
        Fri,  8 Dec 2023 14:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702047067;
        bh=OOSG2z2H6unvPrg8WJZMqPGKC5UIGuJtfqrzdP2lRYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EC4pKFyO5VaHe4xsYYtycR5gLba7A0Ij/M6At7MUNL4bgqlu2S7H4fqpH6iPTsUDC
         /LDu1p6sgrN5T1LvL+LPTFnnuTOtVDSKvDnTdWXcuP1i2d8eaUIya4aheS24Jqgi9b
         942MldcpSRuT+RURtoSR8JsAWkWIASPc6gNOYG/dRGY7lUS+4g9yr10FG31r4P9i7E
         MdMNNTlGbMT8R/IjhkbLs/tMxSIR8Z0l5aS9i5+6nfo5Jjtu2X8qg3FU+yZESYn3oG
         B6WFasUp2V1+t/qmEMlzOgWSe1jdi+Qyzn58I3KH30GvepgFF7qAIjIhoXcYCeeFKh
         OB96OoSR//WJQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 00/11] ARM/arm64: dts: qcom: fix USB wakeup interrupt types
Date:   Fri,  8 Dec 2023 06:55:17 -0800
Message-ID: <170204733623.342318.1053426997273097691.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231120164331.8116-1-johan+linaro@kernel.org>
References: <20231120164331.8116-1-johan+linaro@kernel.org>
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


On Mon, 20 Nov 2023 17:43:20 +0100, Johan Hovold wrote:
> When testing a recent series that addresses resource leaks in the
> Qualcomm dwc3 glue driver [1], I realised that probe deferral can break
> wakeup from suspend due to how the wakeup interrupts are currently
> requested.
> 
> The following series fixes this by no longer overriding the firmware
> defined trigger types for the wakeup interrupts:
> 
> [...]

Applied, thanks!

[01/11] ARM: dts: qcom: sdx55: fix USB wakeup interrupt types
        commit: d0ec3c4c11c3b30e1f2d344973b2a7bf0f986734

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
