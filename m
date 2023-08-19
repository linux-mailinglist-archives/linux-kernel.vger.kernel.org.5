Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED64781740
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 05:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbjHSDoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 23:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjHSDnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 23:43:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6A8421B;
        Fri, 18 Aug 2023 20:43:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F2B263E1B;
        Sat, 19 Aug 2023 03:43:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB2EC433C8;
        Sat, 19 Aug 2023 03:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692416628;
        bh=WSE734VY3ZnmlV6G0lUar/9DJf0XC0U6UkYAUOV3ACI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AXTyCP+UWMMgiqgYsTyHl8tUeQmXeaQjmcFQLxx7Ey4xL+FAcoAnPUTAFrn6g8EKT
         Qwag9GMj5XxSp+0geXKrIlfDioXyBqFmMsssf+0O4kN6bLo3dNKDfAICmMZXf3pQjg
         W2SfyWDsFJddmk30udPhF82RZcFwMzDpFvKV5rnZe7KXijlPC+H1vHvp7DPYGGWPk2
         KJOE369/Sg9TAgtyzThKRTK2aqB2eSID3rCSAiFvXHr7jTmRFlGpg5VdftaXLTbegd
         6KlYAm34hkBaBWkJepnEs4tzDh4Ln4e9QabTqxgVRj5GsHPeW8F8lpMiysnPtHDswc
         ImJvCNFdKaf7w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Bryan Donoghue <bryan.odonoghue@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Amit Pundir <amit.pundir@linaro.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: (subset) [PATCH v6 1/2] dt-bindings: display/msm: mdss-common: add memory-region property
Date:   Fri, 18 Aug 2023 20:46:27 -0700
Message-ID: <169241678226.2537898.15004991100741182949.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726132719.2117369-1-amit.pundir@linaro.org>
References: <20230726132719.2117369-1-amit.pundir@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Jul 2023 18:57:18 +0530, Amit Pundir wrote:
> Add and document the reserved memory region property in the
> mdss-common schema.
> 
> For now (sdm845-db845c), it points to a framebuffer memory
> region reserved by the bootloader for splash screen.
> 
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: sdm845-db845c: Mark cont splash memory region as reserved
      commit: 110e70fccce4f22b53986ae797d665ffb1950aa6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
