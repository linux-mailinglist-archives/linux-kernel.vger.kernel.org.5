Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608D77D8DCE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 06:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjJ0Eie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 00:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjJ0Eic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 00:38:32 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE801BF
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 21:38:29 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so259014666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 21:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698381508; x=1698986308; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=frH4yJkEgXqgTfgCib1fGkByILTuSnogO/76sANZ2P8=;
        b=k13Y7N4OvbzEuf5AQB1U4YvwaEky/UTiPMGzqGF5LUSWVZz7ANdWoSYDLeAHv73T7G
         nLwTAqO7DbK4MBS4BF7wAJG29teNRwhGHip+2O6zuO0S90YgrgSNZ0E1KHHRPNTHk1mY
         IGqHeXzBYmT4DsO7twVCaJtx0bjgdpPMkSxLQ19QSuHXggjhoBGEHzlIEE4BCAL8KX2t
         pMtPfhOEjk1JzKdLwSWWv0k0gjuybdknM+tdP4o3ZcwSmVK/iZPIwp25CsUADMIkE1UQ
         Eg9jPRaL+L9DPGa8ppgEXe1iQjYYzQdN+4txf21931FkFERzYbT7JFK5sMbGKz1ypwWE
         LLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698381508; x=1698986308;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=frH4yJkEgXqgTfgCib1fGkByILTuSnogO/76sANZ2P8=;
        b=RhLz26nblC924edRTWEpeThJMfj99pdTbAd7v98KdyYEyN0oJxqZTKvp3wZNHSwoX7
         hjrVcRu10MrWmTw2oESQ+oOVz08yQ2rxzsekkgMjVggvXsfYUFYhutvv60QuExehUdJX
         MrkQXAB4Ylsm88Ln8Lb/BDOgGCfTmyAu8VVDdgLAWudM/irhCRTEMQIX6qb3KWnZuR3O
         lpXGFJr3aH67YLpCI9aArL8YJJjdiDkpWfO6FDOW/HNBiJKHTAW9fihwlvBqi+0ge2yx
         XFPCbk/sqyKqhfqmMI+FZDBgl4q4nhAwFNSXuGI51XhqLzTckw912ptYbcIiTPtazPfl
         lzYg==
X-Gm-Message-State: AOJu0Yy687Vuy6jzyxzgK7C7Ll71S0QFW9MWHRSpccUMOzgPnKDCCfLs
        ckwC91pTSHgRduiRkBf3oZRtdQ==
X-Google-Smtp-Source: AGHT+IGjJa1LbVHYTYwKBrD6xiKfLTzfmk9anQXCBhZgPDmOxIx1s+7SIDPmGxGpMNXP+CVvj5zJbA==
X-Received: by 2002:a17:907:7baa:b0:9be:705:d7d0 with SMTP id ne42-20020a1709077baa00b009be0705d7d0mr1427154ejc.0.1698381507653;
        Thu, 26 Oct 2023 21:38:27 -0700 (PDT)
Received: from localhost (h3221.n1.ips.mtn.co.ug. [41.210.178.33])
        by smtp.gmail.com with ESMTPSA id lf19-20020a170906ae5300b009ad89697c86sm556618ejb.144.2023.10.26.21.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 21:38:27 -0700 (PDT)
Date:   Fri, 27 Oct 2023 07:38:19 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     joel@jms.id.au, andrew@codeconstruct.com.au, robh@kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org, roblip@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] soc: aspeed: lpc: Fix impossible judgment condition
Message-ID: <b0fb2821-42e2-40e1-88f4-0a697cdb2a97@kadam.mountain>
References: <20231027020703.1231875-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231027020703.1231875-1-suhui@nfschina.com>
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 10:07:04AM +0800, Su Hui wrote:
> smatch error：
> drivers/soc/aspeed/aspeed-lpc-snoop.c:169
> aspeed_lpc_snoop_config_irq() warn: platform_get_irq() does not return zero
> 
> platform_get_irq() return non-zero IRQ number or negative error code,
> change '!lpc_snoop->irq' to 'lpc_snoop->irq < 0' to fix this.
> 
> Fixes: 9f4f9ae81d0a ("drivers/misc: add Aspeed LPC snoop driver")
> Signed-off-by: Su Hui <suhui@nfschina.com>

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

