Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198DE80052D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377798AbjLAIGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjLAIGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:06:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40506170C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 00:06:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9066FC433C7;
        Fri,  1 Dec 2023 08:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701417971;
        bh=rSTgwpB4g0HFcXSHaBEs360QwFlsfjE5INflcdboa6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bxgvgbWMEJ996BM61zZpPKE1MFIbj/k5V8TbNU7apa3Wb1IQwowCQR8wyo+Vc8UbW
         gtAd2d0aA9g1Eke/dZmv5v4yHxQKmoo2AW7Hpe+trJfxlhIR+lVal1W/1O2KH0lksH
         1ds/DqxuZYCb1bQ5rHCwI+zvhr/KjA5BoufD5hDsReZ2+31HYGTsxw5/x90mZXiz9v
         9oPc+3PwFG9L1uczidEz60/ufBYaPuKwTT6HvBFUzV6RFLi1HxmbCrZ1Y4beb1C+3a
         9n39e2EEv2A0TVsXhUA10xh7KDMblgJn9Opzw2llVou4V2GrB8NZBQmTEPU1ddD0Ed
         2X4Im0pVhtn/A==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r8yXt-0005H6-2b;
        Fri, 01 Dec 2023 09:06:46 +0100
Date:   Fri, 1 Dec 2023 09:06:45 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: Add missing safe_lut_tbl in sc8180x catalog
Message-ID: <ZWmUFdWif3QGrqQc@hovoldconsulting.com>
References: <20231130-sc8180x-dpu-safe-lut-v1-1-a8a6bbac36b8@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130-sc8180x-dpu-safe-lut-v1-1-a8a6bbac36b8@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 04:35:01PM -0800, Bjorn Andersson wrote:
> Similar to SC8280XP, the misconfigured SAFE logic causes rather
> significant delays in __arm_smmu_tlb_sync(), resulting in poor
> performance for things such as USB.
> 
> Introduce appropriate SAFE values for SC8180X to correct this.
> 
> Fixes: f3af2d6ee9ab ("drm/msm/dpu: Add SC8180x to hw catalog")

Missing CC stable tag?

> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Johan
