Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1D175DA10
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 07:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjGVFOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 01:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjGVFOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 01:14:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C510E3583;
        Fri, 21 Jul 2023 22:14:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A9D8609FA;
        Sat, 22 Jul 2023 05:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47E0C433C9;
        Sat, 22 Jul 2023 05:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690002853;
        bh=08+GIs9Zk9Jc68wosXMz6nSLtt9F6pVVFNYJ4pKShRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gK65LRndSKCrGAsNIEbENCMbnJJVvscQmt3+k6cLSdnBWIN04/+YmnLLJXsJ00vi4
         /JEJ7JXlLgDmhbZaJAHJ1TtmtJi5+VOyr2uPEHnBX30gBElckjOHM3gNjhT7F8kFXa
         sN+hpLunGGkIy9o4dTZaQEj7IbV548MmDbaRvH6jcYTbbv+AqieP21WSXQr0+sy4Nz
         jT1dw8Tpq4SyjqVkOEiIWi/WHmD7p4o77HwW0mnn66XcnkGQSWZOROXApgxyDYnRKY
         /mqAX2N4d2C7mqp1ld26qV3/77g5CeNHxj2iH+YMXpQE1k+WeajghyL4FGU6/NQrld
         D/BOEBbeSpuEw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Gianluca Boiano <morf3089@gmail.com>,
        Eugene Lepshy <fekz115@gmail.com>, Luca Weiss <luca@z3ntu.xyz>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     stable@vger.kernel.org
Subject: Re: (subset) [PATCH 1/6] arm64: dts: qcom: msm8953-vince: drop duplicated touschreen parent interrupt
Date:   Fri, 21 Jul 2023 22:17:12 -0700
Message-ID: <169000304223.3611206.1306126109299012114.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720115335.137354-1-krzysztof.kozlowski@linaro.org>
References: <20230720115335.137354-1-krzysztof.kozlowski@linaro.org>
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


On Thu, 20 Jul 2023 13:53:30 +0200, Krzysztof Kozlowski wrote:
> Interrupts extended already define a parent interrupt controller:
> 
>   msm8953-xiaomi-vince.dtb: touchscreen@20: Unevaluated properties are not allowed ('interrupts-parent' was unexpected)
> 
> 

Applied, thanks!

[4/6] ARM: dts: qcom: msm8974pro-castor: correct inverted X of touchscreen
      commit: 43db69268149049540b1d2bbe8a69e59d5cb43b6
[5/6] ARM: dts: qcom: msm8974pro-castor: correct touchscreen function names
      commit: 31fba16c19c45b2b3a7c23b0bfef80aed1b29050
[6/6] ARM: dts: qcom: msm8974pro-castor: correct touchscreen syna,nosleep-mode
      commit: 7c74379afdfee7b13f1cd8ff1ad6e0f986aec96c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
