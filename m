Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BEB763E51
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjGZSWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGZSWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:22:02 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAE69B;
        Wed, 26 Jul 2023 11:22:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1690395714; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QKDUeY2c4KMFmPhWbOh17l3C3JCuHOnrKsMPyR3JQw0SXsdtGKQScgX9PElA09VXQH
    CAKtxNUScJlkaOlKmY+lsvLFXR7/+9cIsQHR3qUS0u7EH0UeqGUuMBlKA1htbSe2aMLb
    nf1BiwX5XxZq3trnDh2lCxkz5chVGxy6nnnParfnXGBegDq2/PaOptiPdtWy/yWBWyR9
    sh/+vik6NMuMl2xjD7kZWOB17kxLBWnJ65E429M0SkHOqe3ZahCio6Shkr1bFo9wl7/x
    FgYwWsQ+V3UcxNm6QL8L6n6QPza8YIKEsfb8CMDGqVlTaAjY9QRQUEiw/Fx9rkKBTnrk
    0LCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1690395714;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=pAxjLnIoaNbujX0TER+0fFkItda8fdcC2Nx7HZvipWU=;
    b=PEHVxDqsDduVF047VhmXBM5LB8R/mg70nVhpDJckSu2QHmwo195a5Pkb14Fb5W6dkU
    3+NxK3J5OVHhunakVLWY353nMzcECxHeCrXvrJ8IeL4ZiiDIfJsSqmFjGzTxP5ZOQyX0
    ZIdZAO5LB025h9meYYsWOC+ssdSIDlr3s+FLDLN8U1hlrKyGfmAe+RuiMPrcEDTXappQ
    VgMWXzqZmeoupvOhtVyW2wtc7D3Ar/KytAlT8tceURIKQ00qF9HjmwNZJtIGd4zbZj9v
    w7YIShDZnVU+Khv89QGPBv8RwuXVu34Q242A97jzR1Mk1xZhEnSbNvem89y8ZNZFtetj
    QxSA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1690395714;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=pAxjLnIoaNbujX0TER+0fFkItda8fdcC2Nx7HZvipWU=;
    b=KPaMD6gee/+/3sSj2zd4CCW6CV64fAXhZMU85T6kmu4tdV1Ur3ZnGS2eAnyQYcqWI7
    OjU2VFwzXzHQU8x5u/aNVZe4p7IsUmPAFF8E0VsyiZR7Fl0my6zp+H1ACFushBUg6ALD
    3GifpjZg1JIjV7dPwjZh0lws8cjC1cx1c0tXKA4w1POEI+J7BU5T05Q+ZJLMEc7twXXr
    K7a1dItccBAaxuN01wydfK4JwRdUpM3aYcWztq3Axgb9JufA4s/2WuJVdzSjkVQa2TFk
    WZMEQWJB5RsQwASy3q8kMYguuXjH++QmVonT14S4VqpzPO7ICIZiO499B9KOPDy5WTUy
    SRNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1690395714;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=pAxjLnIoaNbujX0TER+0fFkItda8fdcC2Nx7HZvipWU=;
    b=tZCt7VeO50i5IwJTy/HTGAj5p8Y3QO7kDQFoZa+0CyGCy9zYv0uOyB8FunRJrTLMg3
    OceV0WbSZACFQzmQ7+Dw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA95vh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.6 DYNA|AUTH)
    with ESMTPSA id k61817z6QILr8Kd
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 26 Jul 2023 20:21:53 +0200 (CEST)
Date:   Wed, 26 Jul 2023 20:21:47 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 1/2] clk: qcom: reset: Increase max reset delay
Message-ID: <ZMFkO5aAT5I5kBac@gerhold.net>
References: <20230726-topic-qcom_reset-v1-0-92de6d3e4c7c@linaro.org>
 <20230726-topic-qcom_reset-v1-1-92de6d3e4c7c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726-topic-qcom_reset-v1-1-92de6d3e4c7c@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 03:26:19PM +0200, Konrad Dybcio wrote:
> u8 limits us to 255 microseconds of delay. Promote the delay variable to
> u16 to hold bigger values.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

It would be clearer to change this together with an actual user that
needs > 255us. AFAICT atm MSM8909 is the only user of this and it has
just 15us.

Thanks,
Stephan

> ---
>  drivers/clk/qcom/reset.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/reset.h b/drivers/clk/qcom/reset.h
> index 9a47c838d9b1..fe0561bf53d4 100644
> --- a/drivers/clk/qcom/reset.h
> +++ b/drivers/clk/qcom/reset.h
> @@ -11,7 +11,7 @@
>  struct qcom_reset_map {
>  	unsigned int reg;
>  	u8 bit;
> -	u8 udelay;
> +	u16 udelay;
>  	u32 bitmask;
>  };
>  
> 
> -- 
> 2.41.0
> 
