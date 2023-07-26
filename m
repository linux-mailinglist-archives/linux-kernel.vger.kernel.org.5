Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBA2763E99
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjGZSes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjGZSep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:34:45 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806E226A8;
        Wed, 26 Jul 2023 11:34:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1690396481; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=T2PM9yD9a0crRhectNsAhFx+wpNndAFZNVY76rYG6GGTWNGJlaRUvFqlMLWvcTV2UZ
    iX+NV+kBd5+rEXnMP6z2ErW4Hegy1s89Il8U81v8Ao6t6UZH9lgcAW7MEFBsj/xzwkYS
    tx0WLx1gHQTs4AVDAjzT+LkMdNamHqTJWsE+8l5uUijTCMY/XkL7HtUWNpCJsHPxRqBm
    CsKMFD3R3CAEunykUQigY07PjqaXOD1lSuwOQqz8ImZjlVow5jFnATIcTBA26WEAm9aB
    opZlbLaltH7mSrP8tnNLo5vc06Dgwf9N4OUcAc/nG5UE6/+IV3u51FuQYQaY6jI4y6S0
    YBBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1690396481;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=v99TLR9s3Jobhk6R2/Uwwj9cFwwPW97dVpbSxgWChMo=;
    b=H2YDsY/if4tPJPcFJTZt9AV0QEjAoZYgjr6E2XiqRdSRLZkAZOnr3z7h3CXnx4A9pK
    zinnh82b4OtlLAyjh3PZn/o6NjKLj3fpNKyk1o6n/5Gh4biXu8LLC0pl6deZcGYJ0P5u
    uv3XtR9tCHB6gXe+ljGIE7Nyg20qv7jJjymQs3tm0G0gFjHqFaNV4NMXII5tdTPkFJCk
    ZUvqbqlJEoR+MNQGExOnBpiUxt4s9v/Mfqx6P5pqWIDLfyujVj1nj+a0IS7arv7MVARr
    RqS1PLRDQPzKEk2RudCgqpQAM62YZ1suocuisagLJImgaJu5ypF43wotiEXshBSwm3fl
    cuWg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1690396481;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=v99TLR9s3Jobhk6R2/Uwwj9cFwwPW97dVpbSxgWChMo=;
    b=MNB/s5uwZFR0yKJTOQwgTU/+iP9wn5yZMNcXX6usyM7ZnEeaRTuGVOfC9TeLPEQzo2
    KpKiqr7LGraFfBYQZ+tRY+UDJY3w1X9L/q129ZLRCtcLvAmDzggdcxTwyjTsp+na/B8+
    9PKKTuThve4wlFoQ5pigVd+3FhclgJE8fUSdJXhsRj7iDsAw2jJFvD+Z/D20olTT1dEr
    1jjvvC0L5MAqBV4prXwPB8xKqrAf79eMs+Xzm8r+ckgF17VJNQj3t4gKTpfDTrknrnIe
    xH+Gc8x3yGKIerJVKJPbAXa0+4Uds1UtRPoVOEvaArVCwMrDo4PVYoEWYKw4G6K7JHuz
    T4gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1690396481;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=v99TLR9s3Jobhk6R2/Uwwj9cFwwPW97dVpbSxgWChMo=;
    b=rzW0lkw7xf1EgUd5KFik7NQIp+MLOCwSG4r/V/rH/ih8CQcuAqlZoFtE7ixP9H31LW
    KxpKQhnR9YP6jXozjdBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA95vh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.6 DYNA|AUTH)
    with ESMTPSA id k61817z6QIYf8Lb
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 26 Jul 2023 20:34:40 +0200 (CEST)
Date:   Wed, 26 Jul 2023 20:34:39 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] clk: qcom: reset: Use the correct type of
 sleep/delay based on length
Message-ID: <ZMFlhlml1yifewHY@gerhold.net>
References: <20230726-topic-qcom_reset-v1-0-92de6d3e4c7c@linaro.org>
 <20230726-topic-qcom_reset-v1-2-92de6d3e4c7c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726-topic-qcom_reset-v1-2-92de6d3e4c7c@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 03:26:20PM +0200, Konrad Dybcio wrote:
> Based on the length of the delay (see: [1]), use the correct sleep/delay
> functions.
> 
> [1] https://www.kernel.org/doc/Documentation/timers/timers-howto.txt
> Fixes: b36ba30c8ac6 ("clk: qcom: Add reset controller support")

If anything this would fix 2cb8a39b6781 ("clk: qcom: reset: Allow
specifying custom reset delay") since before there was udelay(1)
hardcoded (which is correct).

But given that we just allowed small delays <= 255us so far it was
probably okay-ish, so I think it's not worth bringing this to the
attention of backporters with the Fixes tag.

> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/clk/qcom/reset.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/reset.c b/drivers/clk/qcom/reset.c
> index 0e914ec7aeae..928995c3f369 100644
> --- a/drivers/clk/qcom/reset.c
> +++ b/drivers/clk/qcom/reset.c
> @@ -14,9 +14,15 @@
>  static int qcom_reset(struct reset_controller_dev *rcdev, unsigned long id)
>  {
>  	struct qcom_reset_controller *rst = to_qcom_reset_controller(rcdev);
> +	u16 delay_us = rst->reset_map[id].udelay ?: 1;
>  
>  	rcdev->ops->assert(rcdev, id);
> -	udelay(rst->reset_map[id].udelay ?: 1); /* use 1 us as default */
> +
> +	if (delay_us < 10)
> +		udelay(delay_us);
> +	else
> +		usleep_range(delay_us, delay_us + 5);
> +

There is fsleep() that implements this logic in a similar way already:

	fsleep(rst->reset_map[id].udelay ?: 1); /* use 1 us as default */

Thanks,
Stephan
