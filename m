Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE407572B8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 06:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjGREOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 00:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGREOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 00:14:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8F81B5;
        Mon, 17 Jul 2023 21:13:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64EF86143F;
        Tue, 18 Jul 2023 04:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A31C433C8;
        Tue, 18 Jul 2023 04:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689653638;
        bh=USxk2ZdP2/KgT3pGcYnYgxZvCjfxQ8Ic9alDnz+4y+Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RRaAOzXRvn4+oE45FyjI+hXfK1fvt301lBjYkAYC6f2DYSB2zklngwRUVu5p4HVsF
         pzvl4UiXDQ7j+MtJPaU1wJinHmEWqS2o2s2h4a5IliASQ9HgDhyKXqxoJNSU/4iKjs
         N+CIp3y7JxojXR5v+HOEdZtER3wYrw/0c5m42o/s7jV6konoc4lqMiOHwoO33zKwJa
         Z2mlKx9ULG0fbsbPVvK+S8D58iKJ8dyxnsuyrH+xiQRjVfDpBd078HZtbF79lVPV8X
         pL1hlVFY6NwTXddEDvDw2URajmirZcsvVOQnemthlfNdOTLxHcVMvgp5sdC9oY5Ct8
         /tZUHJageY9CA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: sc8180x-primus: remove superfluous "input-enable"
Date:   Mon, 17 Jul 2023 21:17:22 -0700
Message-ID: <168965383898.3325964.1624518936272585011.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230717210055.21979-1-krzysztof.kozlowski@linaro.org>
References: <20230717210055.21979-1-krzysztof.kozlowski@linaro.org>
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


On Mon, 17 Jul 2023 23:00:54 +0200, Krzysztof Kozlowski wrote:
> Pin configuration property "input-enable" was used with the intention to
> disable the output, but this is done by default by Linux drivers.  Since
> commit c4a48b0df8bf ("dt-bindings: pinctrl: qcom: tlmm should use
> output-disable, not input-enable") the property is not accepted anymore:
> 
>   sc8180x-primus.dtb: pinctrl@3100000: hall-int-active-state: 'oneOf' conditional failed, one must be fixed:
>     'bias-disable', 'function', 'input-enable', 'pins' do not match any of the regexes: '-pins$', 'pinctrl-[0-9]+'
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: sc8180x-primus: remove superfluous "input-enable"
      commit: 37e93c7c99e140584be9cacad598a2c3e274ce99
[2/2] arm64: dts: qcom: sm8250-pdx203: add required pin function
      commit: 26834b452f40830011294497788bbc82bf1b14af

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
