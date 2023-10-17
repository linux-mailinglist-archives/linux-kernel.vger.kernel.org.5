Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4F17CB97C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 06:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbjJQECm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 00:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJQECk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 00:02:40 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA08C83
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 21:02:38 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c5039d4e88so56808331fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 21:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697515357; x=1698120157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RAFbn1MEbdJCwOyS7whJdaEX4i1Mt1tWVCyQLpsQFN4=;
        b=x1Dv8Mfu0tMDWuTfq15CCChwmMjh4mlZ1Cm8/7tu+Y4E27Mmwnux+DWxCQqxCr5NJL
         S7CGUaM7wqXEN4kVUNRpfuRFpx6nzkoYXGbPJItun0Fzk3sLIZtirxz6Un1LSd+jwUaj
         LPMZKvcBqnapATtXpWGiIAqLtqalBT91zr29oiQnvQEuJdoNxyX87sWW/PE+Tygyqv3c
         Q9zCM3PVAftaU7vHm41zOCwL0hdyzXuvW5m11ZTx+YURCQhsZKyVQTrFAvmsADIs6ZLL
         bHH6ezwyIbo+hw6dWbMgua3YZ2KVhCmAA2TzYaJzF9ZYkSuydzL9Yu/PhdGlRTsRkR8F
         eSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697515357; x=1698120157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAFbn1MEbdJCwOyS7whJdaEX4i1Mt1tWVCyQLpsQFN4=;
        b=QOAti7K1Vn4CgdLBkoE22+e1aR95Ijfp0pTLSWmCSDU2grTGnFWmE5St9fT/ueAhVG
         vnPrKN+HaZYGdu0EuHdmEuabPc7OwIrqW9D3NPj3V4ghR2l6tA/MEg79JDfKSURyR/oZ
         6ofZy3JT/S9lBBM0RFjyP40+8DTPvuSMxI5kX0lyJeGJqBTw0E8VusZtrfoSvZQq4q5D
         jXcfzqYC8jdtJTWE/JVr0d2UmsEFMsENRHXNq8R6SlsPdzHpfQbnAFpi/+ImATKMGbZn
         Xq4m6EGdqmmQg/qGioigCoH9f0jMo1IQN7pvKU6czLDXiJis/Ty/yj5/UuuOQvke0Uli
         vwZg==
X-Gm-Message-State: AOJu0YxTMTmeJ/QMwGpeo9N4ODl6PG0lf2+tqhV8N7r0s3rayHt9D+3Z
        dtzvcjBCRs6PZlcSLu9/8P1Gsg==
X-Google-Smtp-Source: AGHT+IFGKM4MqZPIl2yECM5ZvuixRBZJXyNJZUkfeDkxxPNrLk7s3L0yLs96bcpjTkiONIitq5f+3A==
X-Received: by 2002:a2e:390f:0:b0:2b5:7f93:b3b0 with SMTP id g15-20020a2e390f000000b002b57f93b3b0mr688315lja.17.1697515356953;
        Mon, 16 Oct 2023 21:02:36 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c26-20020a05600c0ada00b003fc06169ab3sm8531314wmr.20.2023.10.16.21.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 21:02:36 -0700 (PDT)
Date:   Tue, 17 Oct 2023 07:02:33 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Replace the occurrences of (1<<x) by
 BIT(x)
Message-ID: <433b9d45-bb21-49eb-8062-c03bcffa90ff@kadam.mountain>
References: <20231016201154.GA14625@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016201154.GA14625@ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 01:11:54PM -0700, Nandha Kumar Singaram wrote:
> Adhere to linux coding style. Reported by checkpatch.pl:
> CHECK: Prefer using the BIT macro
> 
> Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
> ---
>  drivers/staging/rts5208/rtsx_card.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/rtsx_card.h b/drivers/staging/rts5208/rtsx_card.h
> index 39727371cd7a..9d2504fddb13 100644
> --- a/drivers/staging/rts5208/rtsx_card.h
> +++ b/drivers/staging/rts5208/rtsx_card.h
> @@ -338,7 +338,7 @@
>  #define DMA_DIR_FROM_CARD		0x02
>  #define DMA_EN				0x01
>  #define DMA_128				(0 << 4)
> -#define DMA_256				(1 << 4)
> +#define DMA_256				BIT(4)
>  #define DMA_512				(2 << 4)

No.  :P.  Look at the lines around it.  Now it's the odd duckling.

>  #define DMA_1024			(3 << 4)
>  #define DMA_PACK_SIZE_MASK		0x30
> @@ -542,7 +542,7 @@
>  
>  #define BLINK_EN			0x08
>  #define LED_GPIO0			(0 << 4)
> -#define LED_GPIO1			(1 << 4)
> +#define LED_GPIO1			BIT(4)
>  #define LED_GPIO2			(2 << 4)
> 

Same.

regards,
dan carpenter

