Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906C377B009
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 05:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjHNDZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 23:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbjHNDZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 23:25:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8377E62;
        Sun, 13 Aug 2023 20:25:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76F5B627FA;
        Mon, 14 Aug 2023 03:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CB8C433C9;
        Mon, 14 Aug 2023 03:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691983499;
        bh=dI0C1QfebGKIZuREVgeF1dR2P9vADYI1ASRNQhGCcL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lRGdtW6moe3NEiEYogUfW1SsgXXAyNMLJRrUQw+7vM5GwprcamAl5YpP4NhJa6Kxt
         bwHWahZ3GmTKfmPfD0xT3dmTS3ubMraMMoI4Mwj8KjSez5wKnILaeN5Vcb9CyjlFAI
         8bEXJ2Km1XPm9z85T8MMpLsQOkX/cqCLgI7DCMOtpBKxptWjkUAo5nihocreGlsZOx
         tWPISABXosFnmxlKznDqT066ehPnTbhsCu3IDdYEfzamSJK5zS/B/2A7DnCjdS9lTj
         jMeTTaCHM/wL9PF1K7jiU86xGCuMvNQv+O4IZPEK0I2jcpgr499FDoPDvRBOAjJpIB
         imO/l2kuQOUog==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        David Wronek <davidwronek@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH] arm64: dts: qcom: msm8996: Fix dsi1 interrupts
Date:   Sun, 13 Aug 2023 20:27:30 -0700
Message-ID: <169198364313.2443702.15308521942128444829.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230805130936.359860-2-davidwronek@gmail.com>
References: <20230805130936.359860-2-davidwronek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 05 Aug 2023 15:09:37 +0200, David Wronek wrote:
> Fix IRQ flags mismatch which was keeping dsi1 from probing by changing
> interrupts = <4> to interrupts = <5>.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: msm8996: Fix dsi1 interrupts
      commit: bd3b4ac11845b428996cfd2c7b8302ba6a07340d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
