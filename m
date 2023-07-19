Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A15C759F5A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjGSUJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjGSUJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:09:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7F592;
        Wed, 19 Jul 2023 13:09:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 989FF61812;
        Wed, 19 Jul 2023 20:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F24EC433C7;
        Wed, 19 Jul 2023 20:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689797363;
        bh=klqOWFOUh1QB5odPiLwWfeNWJcVb2PU7gijJT32YqNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A/2dYFF4KVhoHbqExV9WPBfS6C4fOHioJbj1B0mpePbgVhxjl+2zzBPGfp70rL5Dk
         LC0wykkcZrebfGspQLokwey+kP4xeSWCPaQO7vxVeq5rmNY8Ma0TYwI5c3G56Bdksn
         FQcFBYnlefuUVlBkvyEcDtZWip7j1OtLXXGDst3abhqiNtPIAz7j7JmXh2FX/kVk0b
         LqlA6yfDeEJJQmkrp4xAuI2511AJKjSBzRC63H85DyePlqWPkMmV0IF3bMMp6T9/Ns
         4lVVS593VTU/O7DQN2AmYKl027Xxu2ccsdR73CTL6Ly/qBtPWkdEw0kL3rKywZPEe/
         KGn90hFEjFTSw==
Received: (nullmailer pid 687249 invoked by uid 1000);
        Wed, 19 Jul 2023 20:09:20 -0000
Date:   Wed, 19 Jul 2023 14:09:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Bryan Donoghue <bryan.odonoghue@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dt <devicetree@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Sean Paul <sean@poorly.run>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: display/msm: mdss-common: add
 memory-region property
Message-ID: <168979735935.687074.3349593216589059012.robh@kernel.org>
References: <20230713165238.2814849-1-amit.pundir@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713165238.2814849-1-amit.pundir@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 13 Jul 2023 22:22:37 +0530, Amit Pundir wrote:
> Add and document the reserved memory region property in the
> mdss-common schema.
> 
> For now (sdm845-db845c), it points to a framebuffer memory
> region reserved by the bootloader for splash screen.
> 
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> ---
> v5: Moving the dt-binding to mdss-common schema with
>     updated commit message and property description.
> 
> v4: Adding this new dt-binding patch, in qcom,sdm845-mdss
>     schema, in the v4 of the follow-up patch for
>     sdm845-db845c.
>     https://lore.kernel.org/lkml/20230712130215.666924-2-amit.pundir@linaro.org/
> 
>  .../devicetree/bindings/display/msm/mdss-common.yaml         | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

