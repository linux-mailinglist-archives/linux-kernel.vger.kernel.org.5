Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAE581096D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 06:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378527AbjLMFW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 00:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjLMFW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 00:22:57 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF4EAF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 21:23:03 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7b6fe5d67d4so237080839f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 21:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702444983; x=1703049783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SCd8C9LQLauZmTjmS+uugY0Prp+1ozkiZ2K2RQqgUOA=;
        b=J6SLJv2Z7+majbra1X5oG/5GbSMHtbR+17uXKp6tUMJlhJQCteIkA85a8adz/ENnx+
         254Lw5T2STA1DLztxUnnW8qpzQlqUkLH7sqgrzM9v3HP9Qyj7LzH0su3gGfhxYASRZC+
         ij62/X0a9h8Pnyv8q5UDmjMRuDJ/cTxZry1xPCGK0NdXunAoc7rwgABJAZj/w9+O0ZMY
         AZ2mU8m2oB2jm6CBkPPugvTpj4XVe5A9e7Q5BtP2wfhwbHO7PDcFAaP6Vou1uVpc8ufB
         sQGo1w9SlA3rO7eW1uwqkG7GuFBCK/SlazgA8T89CcDTBGSDVGIeYpX8oGtwPIKhBfi2
         b6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702444983; x=1703049783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCd8C9LQLauZmTjmS+uugY0Prp+1ozkiZ2K2RQqgUOA=;
        b=pd1OPqkC8ZhQoHzJ4/EgV/9hm6bJ0gp0DCpwap0ath5WWCJz4+qsJyaoAHI8Z7uVoM
         E/EvGZLF0G3CJCNwrBPX7bd8y5K2Lk4ybGLjPvmBfsV8ZpqzT0RuQQMM8mdJ27Ai7Xpz
         KUOIUoKRrt3CcArihcq1YMJEFladvRTDx6o+rssd5kCFwMbn2f9weW0+FrcVBt53Xsdt
         /OikHo/1h7ouFLfutWo/PWk12GIIYjXMY/nDjAyLr99IXToXF9GMJDMXmQx7DaBo1CJT
         +nn5Mkz0ue8DYBrRhldSA4YNKK6r2sB+SSZcIcCWiUlOwckw4TdBEAH5pY+LpcAyV5Mb
         FgeA==
X-Gm-Message-State: AOJu0Yx0xGHGUFtzeyBHd5oV8StARQfcntoUHlKI9K0FQ3f4mJwZAwdW
        HTQSVcntUMcjHvdWx48q/MPgUA==
X-Google-Smtp-Source: AGHT+IH6vC497QRuriHAwx9cjT1xvkr2slqYEpsEM7UHO1qEE/V0oO6mf2iBvMSCW2LXTx7+g4dgnw==
X-Received: by 2002:a05:6e02:1be5:b0:35d:59a2:a32c with SMTP id y5-20020a056e021be500b0035d59a2a32cmr7764399ilv.46.1702444983025;
        Tue, 12 Dec 2023 21:23:03 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id s22-20020a170902989600b001ce5b859a59sm9549668plp.305.2023.12.12.21.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 21:23:02 -0800 (PST)
Date:   Wed, 13 Dec 2023 10:52:59 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "xiaowu.ding" <xiaowu.ding@jaguarmicro.com>
Cc:     Tushar.Khandelwal@arm.com, jassisinghbrar@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mailbox: arm_mhuv2: Fix a bug for
 mhuv2_sender_interrupt
Message-ID: <20231213052259.ug4j7tnmqt3qaxuy@vireshk-i7>
References: <20231212113722.863-1-xiaowu.ding@jaguarmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212113722.863-1-xiaowu.ding@jaguarmicro.com>
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

On 12-12-23, 19:37, xiaowu.ding wrote:
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
> Signed-off-by: Xiaowu.ding <xiaowu.ding@jaguarmicro.com>
> ---
>  drivers/mailbox/arm_mhuv2.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/arm_mhuv2.c b/drivers/mailbox/arm_mhuv2.c
> index c1ef5016f..15021c90c 100644
> --- a/drivers/mailbox/arm_mhuv2.c
> +++ b/drivers/mailbox/arm_mhuv2.c
> @@ -553,7 +553,8 @@ static irqreturn_t mhuv2_sender_interrupt(int irq, void *data)
>  	priv = chan->con_priv;
>  
>  	if (!IS_PROTOCOL_DOORBELL(priv)) {
> -		writel_relaxed(1, &mhu->send->ch_wn[priv->ch_wn_idx + priv->windows - 1].int_clr);
> +		for (i = 0; i < priv->windows; i++)
> +			writel_relaxed(1, &mhu->send->ch_wn[priv->ch_wn_idx + i].int_clr);
>  
>  		if (chan->cl) {
>  			mbox_chan_txdone(chan, 0);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
