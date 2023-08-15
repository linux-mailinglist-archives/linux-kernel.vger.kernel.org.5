Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BD377D262
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239458AbjHOStV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239451AbjHOSs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:48:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47DD2100;
        Tue, 15 Aug 2023 11:48:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4B4560BA3;
        Tue, 15 Aug 2023 18:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912E6C433C9;
        Tue, 15 Aug 2023 18:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692125190;
        bh=FTj7B8yRepFuZM4x0fLmXtGm2n/f1qdVDqS5RRDrbXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQEVcRIID0XFxtOKcpWZbGK4BXem5jJkHKOD47Hk7de3BGwiJeVZIAS2q0I1gjY3q
         Zryfx5FaFrYNNyP/76StB9nbzhyv3NkPOCyFB6icC8dUspamx6gYWK/FJGTfcOlVdf
         H2568ChnELSbBKCSSuJaR4GBphE2UO+tF6K+6eawMLSWl8S2AynKIMDOElqgoDhXfg
         f3859VFZVZDiYglA9o0l0xbx0fPBPr4XUfX70nitABZnRQAa7WrdF17YU/w76Uw5SE
         KdCfb0ZMBDnvulVV+1LfYPBWXPgExRAW3Bu2zMgIY5Gwe7k0C+wz6Y18/YURFWxdr2
         w6uoP7rhNpRkA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/6] Add missing wakeup-parent to TLMM
Date:   Tue, 15 Aug 2023 11:49:12 -0700
Message-ID: <169212535064.2466993.8926492212243299407.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811-topic-tlmm_wakeup-v1-0-5616a7da1fff@linaro.org>
References: <20230811-topic-tlmm_wakeup-v1-0-5616a7da1fff@linaro.org>
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


On Fri, 11 Aug 2023 22:48:33 +0200, Konrad Dybcio wrote:
> Some TLMM pins are wakeup-capable, but not all platforms described that.
> 
> While MPM is not yet hooked up, PDC platforms can and should utilize this
> functionality. This series attempts to do so. As part of it, I had to add
> PDC support to SDM670, as it apparently hasn't been introduced yet.
> 
> 
> [...]

Applied, thanks!

[2/6] arm64: dts: qcom: sdm670: Add PDC
      commit: b51ee205dc4f21ca26dd8ca6e17a1580e14f57c5
[3/6] arm64: dts: qcom: sc8280xp: Hook up PDC as wakeup-parent of TLMM
      commit: 57ff519a644cb5be33b28b7848ddde648a60d262
[4/6] arm64: dts: qcom: sa8775p: Hook up PDC as wakeup-parent of TLMM
      commit: a74883a0de4ecee0c5a07ec732dd75acedb57723
[5/6] arm64: dts: qcom: sdm670: Hook up PDC as wakeup-parent of TLMM
      commit: 71f080633d1ee1233759484d790e86847d2434a5
[6/6] arm64: dts: qcom: sm6350: Hook up PDC as wakeup-parent of TLMM
      commit: 902824035fa5f2d2e9d20937cec331cbe52a1ab4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
