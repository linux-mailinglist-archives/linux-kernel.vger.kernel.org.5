Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB008099B6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573084AbjLHCxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235731AbjLHCx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:53:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB91119A5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1AFCC433C7;
        Fri,  8 Dec 2023 02:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702004008;
        bh=SDWkTg+A9cWrHwwKsWznlTO+KJdRfZK1zHniu+SdssY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=He282uLPRVWVYu+3PoJOKWfIJQpeMUDYqqTT0YgPAo416AZNHukciJM7P9NXlAcI8
         1HjBwgHiVT8Ht4nPQoyTZNw1ZpBa+IEKvxz4IGAYx9kDrClqz5iP2EL9sVUvotp1NI
         kUIQwVc5hSFWrHwrwGVyXwj3GM7BZqy7Bo7kuZiD3ncZtlQN5yWPf+ky01loKlLT6L
         JVS8ky0GgGM+mz0SJUfEK9DoyhTrBLCgKtbdcvbDuaA+RZc0H/w3jfMoZuiAeFitI9
         uQ4Bo1PBnBoRJ8EHmUSCmwNLw8A0z85pqF62IL+IF/MgG0l0yfti1N6zzh4P4/y9i0
         pllO0Zb8qObfg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: sc8280xp: correct Soundwire node name
Date:   Thu,  7 Dec 2023 18:57:32 -0800
Message-ID: <170200426915.2871025.1226788722593683249.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107102111.16465-1-krzysztof.kozlowski@linaro.org>
References: <20231107102111.16465-1-krzysztof.kozlowski@linaro.org>
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


On Tue, 07 Nov 2023 11:21:10 +0100, Krzysztof Kozlowski wrote:
> Soundwire Devicetree bindings expect the Soundwire controller device
> node to be named just "soundwire":
> 
>   sc8280xp-lenovo-thinkpad-x13s.dtb: soundwire-controller@3210000: $nodename:0: 'soundwire-controller@3210000' does not match '^soundwire(@.*)?$'
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sc8280xp: correct Soundwire node name
      commit: 58e8fcf992831ef3642d90115ab119c19bfdd0c5
[2/2] arm64: dts: qcom: sm8250: correct Soundwire node name
      commit: c1f52fb9a128771cfe2cae528c32b302e98398f3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
