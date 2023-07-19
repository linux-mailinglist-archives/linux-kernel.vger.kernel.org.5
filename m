Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1EB758BF5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 05:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjGSDSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 23:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjGSDSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 23:18:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FE11BDB;
        Tue, 18 Jul 2023 20:18:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BB3F61703;
        Wed, 19 Jul 2023 03:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8904C433CA;
        Wed, 19 Jul 2023 03:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689736708;
        bh=TKU2PITle78zXgGpulShFx6AXQktvjO/QjNTWggpW9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cl4phdJxiNxLXiaB0Eutk1WkuyYmrKZ8DLosVAw1Q3TtsxwU9XiEueX9sFmMEU5jZ
         vIamZLg3bQ2F4vtd1jnMuTBcMxPLYpQw0eMUgA07G+2SCM4y+8E3yCkgIfytPON135
         0W4fuFzx1zgQmZa2Bt4cdtAuelvcniHQftyWbem8b4gdRzaMjQlQsgg6i6mfgay5lu
         RRhLiNN89p6bRbqiDwhAaHq6JdLh0WG3nbsczSYmraKECau2axoj0lLkMr20oqVsJf
         zZRfqSAUeu9uDsdfSoF325x6cUO7PsNs4r4JI6WPiS9oScsO5LETAL+qiD2FJUiBPf
         hhV3uNd5evWHg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: (subset) [PATCH 0/7] random msm bindings fixes
Date:   Tue, 18 Jul 2023 20:21:49 -0700
Message-ID: <168973689572.3446802.6302697371902788749.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626-topic-bindingsfixups-v1-0-254ae8642e69@linaro.org>
References: <20230626-topic-bindingsfixups-v1-0-254ae8642e69@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 Jun 2023 22:00:22 +0200, Konrad Dybcio wrote:
> 


Applied, thanks!

[2/7] dt-bindings: remoteproc: qcom,msm8996-mss-pil: Fix 8996 clocks
      commit: 7784311cad42e67a1a51a9d1b961752c0f9b7200

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
