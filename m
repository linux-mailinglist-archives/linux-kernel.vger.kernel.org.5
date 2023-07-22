Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3EA75D94F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 05:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjGVDGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 23:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGVDGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 23:06:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E442C1701;
        Fri, 21 Jul 2023 20:06:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82C0D61DC9;
        Sat, 22 Jul 2023 03:06:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9549C433C8;
        Sat, 22 Jul 2023 03:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689995195;
        bh=KUTKLk5UQU1eQ3o/4T29UfkmMj56iplYzd0kU3H4bdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=srxDZApCLCRYxXZXtnwbgCKSP1bHmf5Y046vZgL1x6wlEW/oyyCP1uFOZOT6co5sG
         X6iY1csyuMoxV3XFbTNjgmMZZVJmePSi6mxSQVEsBC2f/SfNS1wf2ne9p6ClGYWrir
         fY5aThnjYxoR+kdkY9/pLbNRgGbqERysM6ZAYmCbZ7ob5lSeq/jCJ9GKbbhn+byRlW
         +UAnAM/CxHP7Yu5PUvbt+MPvdLf11I6eWKZpF/xniLXOW5Yq1i75bbLQxsieqeO94U
         HwCD4aYEJk9aUXtVGsiKttNM8vj5Jr2sTMAnWivpex/efy0iRpwmkCg63r1NNGEoFB
         md/JBSZUy7GyA==
Date:   Fri, 21 Jul 2023 20:09:54 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Kathiravan T <quic_kathirav@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, quic_srichara@quicinc.com,
        quic_sjaganat@quicinc.com, quic_anusha@quicinc.com,
        quic_saahtoma@quicinc.com
Subject: Re: [PATCH V5 2/3] pinctrl: qcom: Use qcom_scm_io_update_field()
Message-ID: <z2isxt5zqaawkfgfdgogkimsutlvem7weoaatulhq2tcqt44rk@em4fvztj3eox>
References: <20230720070408.1093698-1-quic_kathirav@quicinc.com>
 <20230720070408.1093698-3-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720070408.1093698-3-quic_kathirav@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 12:34:07PM +0530, Kathiravan T wrote:
> From: Mukesh Ojha <quic_mojha@quicinc.com>
> 
> Use qcom_scm_io_update_field() function introduced in the commit
> 1f899e6997bb ("firmware: qcom_scm: provide a read-modify-write function").
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
> Changes in V5:
> 	- Dropped the ununecessary paranthesis
> 	- Updated the commit message to indicate the commit ID in which
> 	  qcom_scm_io_update_field is introduced instead of simply
> 	  mentioning the "last commit"
> 
>  drivers/pinctrl/qcom/pinctrl-msm.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 2585ef2b2793..5ecde5bea38b 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -1040,6 +1040,7 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
>  	const struct msm_pingroup *g;
>  	unsigned long flags;
>  	bool was_enabled;
> +	u32 mask;
>  	u32 val;
>  
>  	if (msm_gpio_needs_dual_edge_parent_workaround(d, type)) {
> @@ -1074,23 +1075,20 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
>  	 * With intr_target_use_scm interrupts are routed to
>  	 * application cpu using scm calls.
>  	 */
> +	mask = GENMASK(2, 0) << g->intr_target_bit;
>  	if (pctrl->intr_target_use_scm) {
>  		u32 addr = pctrl->phys_base[0] + g->intr_target_reg;
>  		int ret;
>  
> -		qcom_scm_io_readl(addr, &val);
> -
> -		val &= ~(7 << g->intr_target_bit);
> -		val |= g->intr_target_kpss_val << g->intr_target_bit;
> -
> -		ret = qcom_scm_io_writel(addr, val);
> +		val = g->intr_target_kpss_val << g->intr_target_bit;
> +		ret = qcom_scm_io_update_field(addr, mask, val);

Be aware when you resubmit that this code has changed. So please base
your changes on linux-next.

Regards,
Bjorn
