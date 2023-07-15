Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8B5754BC4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 21:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjGOTmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 15:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjGOTmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 15:42:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DBEE6;
        Sat, 15 Jul 2023 12:42:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22DD160BED;
        Sat, 15 Jul 2023 19:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCFFC433C7;
        Sat, 15 Jul 2023 19:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689450130;
        bh=tia1RFoe2cmUmM8vAhMEPSDnTqzrkp2gswfXK9IrkZc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=pgDYI4thVFqiYSr9MeOs9su/XfQKGJ7X4UQqp9v4wWPX2KYCs8FRMXoJePYSU0uJj
         fwxH21jg40ro/j7YLjy/1O+ftqqu5tuHe7gqzl/ud7tQ4F9v2eQbwY8JJy/Tg4vVfT
         67ZyzDLqU1LC/ZMqwXEVfUgzFzroN4Y60BBqwRxv3QyIzs+ClDl2ObRbChjUSDGnot
         94KOnxdHpGzELnFJC0MTp/D2U/M13rKzt+f/SpSSbSc2dBce+e32AiSLGuS/W/EKGs
         nosawr9ZdFbYWdl6RKYLVcIBi4EQMrx/cOkQHKaIkMwL/X526si5k/TrKEONlisYlY
         E84ewCZ565K9Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [RESEND PATCH v2 0/4] dt-bindings: remoteproc: qcom: fixes
Date:   Sat, 15 Jul 2023 12:45:33 -0700
Message-ID: <168945033420.1736171.3440401735899315467.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713072242.11268-1-krzysztof.kozlowski@linaro.org>
References: <20230713072242.11268-1-krzysztof.kozlowski@linaro.org>
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


On Thu, 13 Jul 2023 09:22:38 +0200, Krzysztof Kozlowski wrote:
> These were sent in March 2023, resent and pinged.
> 
> https://lore.kernel.org/all/20230331092125.44885-1-krzysztof.kozlowski@linaro.org/
> https://lore.kernel.org/all/5fa6d988-b51a-7c18-b605-ab99ecec8bea@linaro.org/
> 
> I already saw two other tries to fix the same issues.
> Please apply to fix the Qualcomm DTS warnings.
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: remoteproc: qcom,pas: correct memory-region constraints
      commit: 1e5c6933483b7cf8eab9e2b1c8a12af1451df4fa
[2/4] dt-bindings: remoteproc: qcom,sm6115-pas: correct memory-region constraints
      commit: 66530ffe964ce35da6e8d3787c5620b4fba5a9f9
[3/4] dt-bindings: remoteproc: qcom,sm8550-pas: require memory-region
      commit: ed8503220bdd86840eadc5795ae4583c62dd9739
[4/4] dt-bindings: remoteproc: qcom,adsp: bring back firmware-name
      commit: 3aacc3b2e4ea862c21de5a0efbfa8cd59192bc43

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
