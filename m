Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5A275E4D3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 22:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjGWU0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 16:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGWU0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 16:26:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EFD1B8;
        Sun, 23 Jul 2023 13:26:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50F5E60E98;
        Sun, 23 Jul 2023 20:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482EBC433C7;
        Sun, 23 Jul 2023 20:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690143962;
        bh=LyrK5xXC8EJYilE6Mh1xjWU8trzIouJgLVGPPFNgsYQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uKjKp/9T7tdBFgTeiqUyADsQ3/yESfaMi0xILJXjxHjxXFOxU/Lk89Od46uTnwELR
         s7CZ8JOEWj+B/ZE410JShYN3zwmLRNbu1DOyYb1Nu9P9zqJWrFhWEwuQaHgia3ENwe
         QQtNI+fThgx8gpwMZlfg5gRM3xTZWGQJGGOJyXsDqnDTmj/oJ+ooGxpuCQ/K0wcRiq
         89o1dEeHTYxRIaYuo46L3AjSGij01pP8dbceprT1FxJe/c+Hvc+vCoxElspBCMavYK
         TBUsMBRQK0E78nsSuV6gg9H3fIRPXDLx5qRmcjBXI5wW5m2j0eBFAvAXylDEoD4m1n
         TXr9VYEnVKCkA==
Message-ID: <c84a78c6-1582-a9fa-e0fd-43c0faac5a75@kernel.org>
Date:   Mon, 24 Jul 2023 05:26:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] PM / devfreq: Reword the kernel-doc comment for
 devfreq_monitor_start() API
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230720084854.18975-1-manivannan.sadhasivam@linaro.org>
From:   Chanwoo Choi <chanwoo@kernel.org>
In-Reply-To: <20230720084854.18975-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 7. 20. 17:48, Manivannan Sadhasivam wrote:
> Current kernel-doc comment doesn't specify the default timer used for the
> load monitoring. Also, it uses the term "default delayed work" which could
> be misunderstood as "default delayer timer". So reword the comment to
> clearly specify the default timer and also reword the last sentence to make
> it more understandable.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/devfreq/devfreq.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 7686993d639f..e2939c1b7d1f 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -472,10 +472,11 @@ static void devfreq_monitor(struct work_struct *work)
>   * devfreq_monitor_start() - Start load monitoring of devfreq instance
>   * @devfreq:	the devfreq instance.
>   *
> - * Helper function for starting devfreq device load monitoring. By
> - * default delayed work based monitoring is supported. Function
> - * to be called from governor in response to DEVFREQ_GOV_START
> - * event when device is added to devfreq framework.
> + * Helper function for starting devfreq device load monitoring. By default,
> + * deferrable timer is used for load monitoring. But the users can change this
> + * behavior using the "timer" type in devfreq_dev_profile. This function will be
> + * called by devfreq governor in response to the DEVFREQ_GOV_START event
> + * generated while adding a device to the devfreq framework.
>   */
>  void devfreq_monitor_start(struct devfreq *devfreq)
>  {

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

