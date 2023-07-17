Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049197568D8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjGQQQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbjGQQPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:15:55 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C011704;
        Mon, 17 Jul 2023 09:15:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689610534; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=RyU5zRnsNts+F9LR15WKMN1yVx+NvZHYKiDUrweAvA9Cnk7vYYmArO9SeCNW0EWB0y
    qMyt3vwFlrb+Uw1DRqVyjn1aSCHdY6fSfk5QzzlEmxeC/bQBak7UtZOLiqb7el924Kte
    dZq3i7j5TIKqXLKSN3vu7pZpDMyDjG4RPHEKKxKbWZrfqTyqkJXKFJdhSXC/HU4KI2Th
    TNF506DE+peuz3qZieB8CPgREt7AhA6XnPooCL8Dpnoajv4YDRLEr9WnkO+Ocj949wDj
    giXdbIiBpa7nmnA73baDYsZ9wLRU19fT1BvX9BZN07+yEnmL6RlNcBl5DJn5WvMEgZMj
    cbaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689610534;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=7o1y24nDxAXUsEGUTyN7EYG8cwLxo5GclfTp1QDE3z8=;
    b=d1MA2BApMCWJGfX5QlCwqg1zJvdgTswaD4WKakO9a1C3D/06nH746Um54inp5GOnQk
    ufWkogpA5n82qXIV4wy3Vvhtrv2XWUbl1ecviYNZvmlwBTIjoDn/epNtELZq7bQBz8u0
    n0D1lfKzCJ7rnMERUGGjMwHPHChKPoYoW2varMrndz4DCieyx5w9ZIWBDnewkrlwwSvO
    ziN/hbFjYOJt1qXjvqDeITQxF2zk3w0w7EBrcOXeZsTHckxIH5VgtpVZbnxGqLg7ZURS
    tp3bpF7wTwHv7AH6+cBiSroZlzIKVdxKw5NuoUMJSL8E+D/j/bgJ9+B5785Y0G1FvHbD
    CeyA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689610534;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=7o1y24nDxAXUsEGUTyN7EYG8cwLxo5GclfTp1QDE3z8=;
    b=j7BlEo+sv92R3gTer7+ChWgW9Btni1gAAUJrAe4/PxUmN+S8a1686zyLYBgv26GEw2
    N+lj+lfj8wOaRnydDkQ0liLPbKp7Tjk5xdvLrDLNsb3ad6nK/kmKLvf+2TsK6J6BOony
    +zhJHgfIxSAvz+nBSa6rkO/er37CFlm9vScfL6XWju89GDo4BoI2s2JWgCrmpKc8u8hq
    xPlnLqVbTOY3MnuV1mFPLr9d1Z3rZcxuxY+4EigSYdZNBLs4cbm4JOh8sX0DGXpMOUcX
    qTbf0qPCXWxMw5zzipWB28nxBOqGEO/t+g/nD4wCwm/LfitT0KsWEByjxNHZXlGBQb+r
    z2uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689610534;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=7o1y24nDxAXUsEGUTyN7EYG8cwLxo5GclfTp1QDE3z8=;
    b=eTl9/G65H+kp8FxBzc3QZQbIj060cg1ZvAoqJ03qrbwF4GFabW0RFAyMomTraxQn3c
    mouRJNwBKh6OGpDZ61AQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8Z2L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z6HGFYZAS
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 17 Jul 2023 18:15:34 +0200 (CEST)
Date:   Mon, 17 Jul 2023 18:15:27 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 05/15] clk: qcom: gpucc-sm6375: Unregister critical clocks
Message-ID: <ZLVpH16co7wXWInI@gerhold.net>
References: <20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org>
 <20230717-topic-branch_aon_cleanup-v1-5-27784d27a4f4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717-topic-branch_aon_cleanup-v1-5-27784d27a4f4@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 05:19:12PM +0200, Konrad Dybcio wrote:
> Some clocks need to be always-on, but we don't really do anything
> with them, other than calling enable() once and telling Linux they're
> enabled.
> 
> Unregister them to save a couple of bytes and, perhaps more
> importantly, allow for runtime suspend of the clock controller device,
> as CLK_IS_CRITICAL prevents the latter.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/clk/qcom/gcc-sm6375.c   | 105 ++++++++++++++++++++++++++++++++++------
>  drivers/clk/qcom/gpucc-sm6375.c |  38 +++------------
>  2 files changed, 97 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-sm6375.c b/drivers/clk/qcom/gcc-sm6375.c
> index 4b2de545d3f8..a8eb7a47e284 100644
> --- a/drivers/clk/qcom/gcc-sm6375.c
> +++ b/drivers/clk/qcom/gcc-sm6375.c
> @@ -1743,6 +1743,21 @@ static struct clk_branch gcc_cam_throttle_rt_clk = {
>  	},
>  };
>  
> +static struct clk_branch gcc_camera_ahb_clk = {
> +	.halt_reg = 0x17008,
> +	.halt_check = BRANCH_HALT_DELAY,
> +	.hwcg_reg = 0x17008,
> +	.hwcg_bit = 1,
> +	.clkr = {
> +		.enable_reg = 0x17008,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camera_ahb_clk",
> +			.ops = &clk_branch2_aon_ops,
> +		},
> +	},
> +};
> +

You seem to revert PATCH 03/15 here.

Stephan
