Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0255177B01C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 05:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjHNDZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 23:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbjHNDZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 23:25:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076DFE62;
        Sun, 13 Aug 2023 20:25:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 910F9627FA;
        Mon, 14 Aug 2023 03:25:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF03C433CB;
        Mon, 14 Aug 2023 03:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691983502;
        bh=3WBnhbj3qUzOfiN0Q6d37L2cHGY9arOpCWxqj+lKLnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GoIwZRIzRH18vbUS79c5xs1fuKP2dwEZ3bZo0gg2icNcXSfTbC2pftvFN6k4qjV4V
         /m/A8y69Q09rUPdr4zLkRoZoSOWHV+3hjcRqR0E9t2XEYXJwZ34WrQRIzCRhrDpvuC
         vMtA2VhfHPE+rWO5yfliA6KKyWSYklBkwdx0D3LEb4A/hOfvoXkGSGi5UU9fjhkeyC
         h9VStLnlMCbpV4i7+Bb+HPaOboAUWsylrZ0TjhaXO2HTPw8pk8Q+S0ffZtThxOADsp
         4drLoWziOOtILFzxVSU/Q4QMFIf3roFLOchgGMBJyXl0Az2tA18tPOR/uZLCbLtRdH
         CmiI06lbwmNvw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steev Klimaszewski <steev@kali.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-x13s: Add camera activity LED
Date:   Sun, 13 Aug 2023 20:27:32 -0700
Message-ID: <169198364315.2443702.6558220427429562871.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230805-topic-x13s_cam_led-v1-1-443d752158c4@linaro.org>
References: <20230805-topic-x13s_cam_led-v1-1-443d752158c4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 05 Aug 2023 11:01:33 +0200, Konrad Dybcio wrote:
> Disappointigly, the camera activity LED is implemented in software.
> Hook it up as a gpio-led and (until we have camera *and* a "camera on"
> LED trigger) configure it as a panic indicator.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp-x13s: Add camera activity LED
      commit: 1c63dd1c5fdafa8854526d7d60d2b741c813678d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
