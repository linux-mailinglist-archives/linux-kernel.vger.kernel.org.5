Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E666A78482A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237991AbjHVRDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjHVRDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:03:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5DDD7;
        Tue, 22 Aug 2023 10:03:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50D8B65219;
        Tue, 22 Aug 2023 17:03:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C30C433C8;
        Tue, 22 Aug 2023 17:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692723810;
        bh=8wMhVveLF8PjIobLdGG6n7O8n0YBi7GDfqfSSGbmszQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Jfp25yXGkhHJ/wEA2m58vqN/Z7elwNST+xEs+96v7HU3Fh8PxY08hfWPwiC8QVzcO
         CbO0AG9ZhbSxjsIrn7/UUH/Dz4SgQ+b3h5EDpmfFKMGFkFY6xPuHdtWPIUDKJZ/S41
         GJKw8IvczlbFbC0kQnU2WEew54kvk1ToX5Xoqi2E+vlV9LRpHct8NC4qFYTcNNrenw
         EB7hSpxwtwvpWWyLXo2Y5x/sMYmNOl8UpMiFpCehL++FlbTr2a0aTfkvZ9ChHk/2zg
         ANeAoYG7lC3OVkGgH143hBt7J8oIBtYEPEbCc3TC3yUOA9yr7fZYVwBaGRTdksJQC2
         UNVFuRugByodQ==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20230822-topic-sm8x50-upstream-rpmh-regulator-suffix-v2-1-136b315085a4@linaro.org>
References: <20230822-topic-sm8x50-upstream-rpmh-regulator-suffix-v2-1-136b315085a4@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: regulator: qcom,rpmh-regulator: allow
 i, j, l, m & n as RPMh resource name suffix
Message-Id: <169272380811.78906.9773466229058057452.b4-ty@kernel.org>
Date:   Tue, 22 Aug 2023 18:03:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2023 12:03:43 +0200, Neil Armstrong wrote:
> Add "i", "j", "l", "m" and "n" to the allowed subffix list as they can be
> used as RPMh resource name suffixes on new platforms.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] dt-bindings: regulator: qcom,rpmh-regulator: allow i, j, l, m & n as RPMh resource name suffix
      commit: ed7c6a2ba6a682f191f289de01e8eb0a1366c3eb

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

