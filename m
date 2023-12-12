Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5CA80E980
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjLLKzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjLLKzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:55:14 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905FCE3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:55:18 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6d9ac148ca3so3858247a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702378518; x=1702983318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bScNdgNv6YXsrptwEeKrxreKyYys5leCiEspcf0W9HU=;
        b=yCMaqZg78GCKiv2BiZNz2c7bXBRqLsOYPZNlkjoqOioKUQ3xcz9WeudsSFWLPX+xRu
         nAipTBPnig0dtXG0PdLhxd9FkY3yxB8YahGpgAECeh0jvM72JAXdKaBckp0rmVAN8LzZ
         m0WewqCld+IMb824Quf0QYQdTO5VUZdv5IzzqQ5LgJ8v+74OKmdfXclCJPA8xU0W9vA3
         cjenGuFZ7QRUKwnYnLRMyx8HZsMGHz+35Qd/n2aldZfFXuD4a/RqowVirvTRA00ANubH
         Ictsg/BF+C5u0kmMX2EWZmSlR66T4Ihd+BcoJDFaMWum3NHw5/cWNLasDeCvz+U3t/DV
         lAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702378518; x=1702983318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bScNdgNv6YXsrptwEeKrxreKyYys5leCiEspcf0W9HU=;
        b=wQK7UTAN/zwjqz1vIkk2TMfBUnJG8FDyaDSBi8hRFQK40LpBdF6qvWhDt5jK7u2JLX
         6p0f1dkJYOMA0++3G7PE4Vur5xoElfBh4RMKi83yCSM7VjoqfiCzOHjQOhRb56Babku/
         UjtOiL5/FOhoYmPv1GgYCI57QiDmbHbhkzpUrSsCInqiHW0pNb9/sGvculyBH7jyzbLm
         O0eSR+N5+UhTmxs3GyQFFc94+ZP0nYoeFl1PVZVMY5/3fZCCuEROeg+AAb3Eriy0utIe
         N4WEZwglZhRpOM74H5/04PyKjEHv7D4IIeo9T0cN+f+ahc6GTVoQ2TlfC+Vum3dlx6V9
         pE/Q==
X-Gm-Message-State: AOJu0YxopQSFnbp7/RmQs7gegv+2Y+Zn2+516y5QIoGEz9hjijSlMFjx
        5ee5gwiG3ySOAt48dRXNiPB+dKaHXAMhtnmEvvE=
X-Google-Smtp-Source: AGHT+IFZASSZHAv0Q80MdBReOZkXVCPcp99T8waa6xoBARQCP3NMGw+9NIRSIhvAO08wiFGLeCW+Fg==
X-Received: by 2002:a05:6830:344c:b0:6d9:da4b:4dd0 with SMTP id b12-20020a056830344c00b006d9da4b4dd0mr5628197otu.0.1702378517877;
        Tue, 12 Dec 2023 02:55:17 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id du6-20020a056a002b4600b006ce97bd5d04sm8139985pfb.140.2023.12.12.02.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 02:55:17 -0800 (PST)
Date:   Tue, 12 Dec 2023 16:25:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "xiaowu.ding" <xiaowu.ding@jaguarmicro.com>
Cc:     Tushar.Khandelwal@arm.com, jassisinghbrar@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailbox: arm_mhuv2: Fix a bug for mhuv2_sender_interrupt
Message-ID: <20231212105515.hldboytb5ibpqaia@vireshk-i7>
References: <20231212093147.773-1-xiaowu.ding@jaguarmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212093147.773-1-xiaowu.ding@jaguarmicro.com>
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-12-23, 17:31, xiaowu.ding wrote:
> From: "Xiaowu.ding" <xiaowu.ding@jaguarmicro.com>
> 
> Message Handling Unit version is v2.1.
> 
> When arm_mhuv2 working with the data protocol transfer mode.
> We have split one mhu into two channels, and every channel
> include four channel windows, the two channels share
> one gic spi interrupt.
> 
> There is a problem with the sending scenario.
> 
> The first channel will take up 0-3 channel windows, and the second
> channel take up 4-7 channel windows. When the first channel send the
> data, and the receiver will clear all the four channels status.
> Although we only enabled the interrupt on the last channel window with
> register CH_INT_EN,the register CHCOMB_INT_ST0 will be 0xf, not be 0x8.
> Currently we just clear the last channel windows int status with the
> data proctol mode.So after that,the CHCOMB_INT_ST0 status will be 0x7,
> not be the 0x0.
> 
> Then the second channel send the data, the receiver read the
> data, clear all the four channel windows status, trigger the sender
> interrupt. But currently the CHCOMB_INT_ST0 register will be 0xf7,
> get_irq_chan_comb function will always return the first channel.
> 
> So this patch clear all channel windows int status to avoid this interrupt
> confusion.
> 

Fixes: 5a6338cce9f4 ("mailbox: arm_mhuv2: Add driver")

> Signed-off-by: Xiaowu.ding <xiaowu.ding@jaguarmicro.com>
> ---
>  drivers/mailbox/arm_mhuv2.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mailbox/arm_mhuv2.c b/drivers/mailbox/arm_mhuv2.c
> index c1ef5016f..9191c5b69 100644
> --- a/drivers/mailbox/arm_mhuv2.c
> +++ b/drivers/mailbox/arm_mhuv2.c
> @@ -542,7 +542,7 @@ static irqreturn_t mhuv2_sender_interrupt(int irq, void *data)
>  	struct mhuv2_mbox_chan_priv *priv;
>  	struct mbox_chan *chan;
>  	unsigned long flags;
> -	int i, found = 0;
> +	int i, j, found = 0;

Please reuse the variable 'i' here.

>  	u32 stat;
>  
>  	chan = get_irq_chan_comb(mhu, mhu->send->chcomb_int_st);
> @@ -553,7 +553,8 @@ static irqreturn_t mhuv2_sender_interrupt(int irq, void *data)
>  	priv = chan->con_priv;
>  
>  	if (!IS_PROTOCOL_DOORBELL(priv)) {
> -		writel_relaxed(1, &mhu->send->ch_wn[priv->ch_wn_idx + priv->windows - 1].int_clr);

I vaguely remember that only the last bit was required to be set to
clear interrupt for all the channels but I must be wrong, now that you
are reporting a bug here :)

> +		for (j = 0; j < priv->windows; j++)
> +			writel_relaxed(1, &mhu->send->ch_wn[priv->ch_wn_idx + j].int_clr);
>  
>  		if (chan->cl) {
>  			mbox_chan_txdone(chan, 0);

-- 
viresh
