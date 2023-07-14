Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1832C753147
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbjGNFbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbjGNFav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:30:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3611E30D8;
        Thu, 13 Jul 2023 22:30:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF78161C11;
        Fri, 14 Jul 2023 05:30:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637C8C433C7;
        Fri, 14 Jul 2023 05:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689312647;
        bh=eP4rvD32IiRFK3b53YSMUyRHpfzKOoFQIT68Y2DGi/k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Mvn8CVU9ZCb56TEx2VCqADBlSCknlXoFIFYyxNS7yUWotg1CrsLx/o5z+bZeC3Vy/
         YR4pCdHdqN5IDezgK2/Zbwe3y10qDKEjWX7P2bSGyw0HkQ9NnXyko9TaeiMZ13C8x3
         phRZ5/bMbr4DaS0fT19V2l1n1903XZjCu9OvrHC7U5nUR1CEetYeYgqR0k7rW4Ico/
         HCulNSyYxDf80kd6vfMXPGkFzPWGqLENGBDK8cxhvVroMG5fVKel6XAJk1ygvDGIWV
         jq76rkZo42K1lXLmVbTzW4L7XsgdSpa15xFViDFwkuaZ0D+gEswcTx4TonbUKjLYMd
         2FMEzN8oa76zg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: sm8250-sony-xperia: correct GPIO keys wakeup again
Date:   Thu, 13 Jul 2023 22:34:02 -0700
Message-ID: <168931284124.1538684.8412063237085574592.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711063011.16222-1-krzysztof.kozlowski@linaro.org>
References: <20230711063011.16222-1-krzysztof.kozlowski@linaro.org>
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


On Tue, 11 Jul 2023 08:30:11 +0200, Krzysztof Kozlowski wrote:
> gpio-keys,wakeup is a deprecated property:
> 
>   m8250-sony-xperia-edo-pdx206.dtb: gpio-keys: key-camera-focus: Unevaluated properties are not allowed ('gpio-key,wakeup' was unexpected)
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8250-sony-xperia: correct GPIO keys wakeup again
      commit: b8fbeea0253211d97c579eae787274633d3eaf0d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
