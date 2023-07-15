Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C1F754CB7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 00:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjGOWK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 18:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjGOWKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 18:10:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD7E272B;
        Sat, 15 Jul 2023 15:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A51160C4E;
        Sat, 15 Jul 2023 22:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4F7C433CC;
        Sat, 15 Jul 2023 22:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689459015;
        bh=1Tvx5XWVRaZW9cpQ7hdXR0QaZDjW8M1hvrSwLrX4P5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CbWIulcbbNuV3BIlxXBRRtAd9Bum/dq3r3+4aCEq6bVE2t9vcZzyY/8KNBzf6MyEX
         3bBxqmzm/QkMhu2kXWdACkhZanQ9KJAT8JKp8zM8WCJrj5hIBMsB9hXJvjfeRHi3uQ
         pRFwU1QVKLtSFAtv7lxI/MIVmi2FP68se6urG8La2Re9jDa1aINmtmI+Lt80kiFdeF
         HDWMZ1Dk/H1Hfv0r2LGEmLPAZaVRto8GgowhdPpwwD2lnbCJw7X6ejO1yYlHXuSMsG
         YfnM24eauUymHvK5MnjoqxPiykATUyNMlardQSkrMAqwVmbu9Iz4yy9TYu1RY/vCay
         3YHVwwN0tD9Yg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>
Subject: Re: (subset) [RESEND PATCH 1/3] dt-bindings: remoteproc: qcom,pas: correct memory-region constraints
Date:   Sat, 15 Jul 2023 15:13:31 -0700
Message-ID: <168945921475.1805013.9506103419243222480.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230331092125.44885-1-krzysztof.kozlowski@linaro.org>
References: <20230331092125.44885-1-krzysztof.kozlowski@linaro.org>
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


On Fri, 31 Mar 2023 11:21:23 +0200, Krzysztof Kozlowski wrote:
> Qualcomm PAS devices expect exactly one memory region, not many.  Also,
> the memory-region is now defined in device specific binding, not in
> qcom,pas-common.yaml, thus also require it in the same place.
> 
> 

Applied, thanks!

[1/3] dt-bindings: remoteproc: qcom,pas: correct memory-region constraints
      commit: 1e5c6933483b7cf8eab9e2b1c8a12af1451df4fa
[2/3] dt-bindings: remoteproc: qcom,sm6115-pas: correct memory-region constraints
      commit: 66530ffe964ce35da6e8d3787c5620b4fba5a9f9
[3/3] dt-bindings: remoteproc: qcom,sm8550-pas: require memory-region
      commit: ed8503220bdd86840eadc5795ae4583c62dd9739

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
