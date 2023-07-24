Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5B575ED06
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjGXICH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjGXICA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:02:00 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF00115
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:01:58 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3163eb69487so3162940f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690185717; x=1690790517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5BZ3qHMKtpaZLuCX+s7e/+q/pcYmf/J0ZH/SwRJMXM8=;
        b=tEIvMw8l8rpvRxjVxpUx25UYutYUpUfBv6u+L4GWFsCFveDge4IrBjqITY6CWjMK9Y
         dEdbdiIj/ccUQyqAsdBq6M0kTZbKpZSl42euxUJw/bZDzSXTqjeN3MilZjOyFBk4XuU8
         YpGpAUfsqLNhFBfLKu7TWW3kAOZIj3QbTbY/ikuH9BxH3nxSNGPsVx3W4Ei2owgCYtlT
         qBM2J8WXefXruZ/1583fNGzwEirFERT7ACLulej3GKLv+j5Rm7DBW7iHwzHLBdjMfx9f
         Q66w/DllvMMAOSyN9beUD8DM/gBTjZVdLFPvRH6sJcR2Yl1nYg6f7nJCH4JAeHnt2SuO
         p/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690185717; x=1690790517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BZ3qHMKtpaZLuCX+s7e/+q/pcYmf/J0ZH/SwRJMXM8=;
        b=d226Pzy5Maekwso1BmFgOsKyR3CI2ejS5VPwtuOXvNdTI0Tl8Ba3yv41ILh8/0oK8D
         IZwQR+uowTj6fDX/Gh6a3AxH4r11Gx2c5gHORiQgocT2PdfNxGwXIY9C+I0XJ3WNng9y
         CAD7MUSnP12lACxEwg9DQJ8QkGyx4ELsE6xTJGTVbl6ljVhE4VY4qyZUO2VI6I+H4xo6
         j/+ry+aIWgtxjT48mS510OImF78XF5TNtenLGXER+kNcVwEEhhvWmS8NLAWTZwcbuk3o
         fStnU/zXwrLA3Brx5u0V4vVMq4ucaDE/zEzM12O+O0U06HQXuQ5t4Ij/qE1oiUtZnX3a
         JNDA==
X-Gm-Message-State: ABy/qLYfGDlke3dk/VSnw432ztRYKRL/vTv2jubn+ZMXRemwXqxEBGCN
        4+zEMz2FBTm+SVJQejPbThi8NQ==
X-Google-Smtp-Source: APBJJlHQzTxAuPKiqAnspN9dLXsqwMkcN7m3i6ZJZ59TAOwyLGH3tp61pF2pOWg3KoDV4xJEhvuMog==
X-Received: by 2002:adf:f54e:0:b0:313:e391:e492 with SMTP id j14-20020adff54e000000b00313e391e492mr7097229wrp.17.1690185717083;
        Mon, 24 Jul 2023 01:01:57 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i13-20020a5d438d000000b003159d2dabbasm11967501wrq.94.2023.07.24.01.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 01:01:56 -0700 (PDT)
Date:   Mon, 24 Jul 2023 11:01:54 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Minjie Du <duminjie@vivo.com>, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org, opensource.kernel@vivo.com,
        LKML <linux-kernel@vger.kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        Nick Kossifidis <mickflemm@gmail.com>
Subject: Re: [PATCH] drivers: wireless: ath5k: fix parameter check in
 ath5k_debug_init_device
Message-ID: <91fe0855-0c78-4dc9-b55a-9dbe09bc9f51@kadam.mountain>
References: <ZK7wqH86hEswxGo6@bombadil.infradead.org>
 <3e831a9c-b469-f1d3-1eaf-c9e275a74da5@web.de>
 <986bc150-1ab3-4ec1-dd76-d3be69bfcef9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <986bc150-1ab3-4ec1-dd76-d3be69bfcef9@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 07:47:53AM +0200, Jiri Slaby wrote:
> On 12. 07. 23, 21:07, Markus Elfring wrote:
> > > > +++ b/drivers/net/wireless/ath/ath5k/debug.c
> > > > @@ -982,7 +982,7 @@ ath5k_debug_init_device(struct ath5k_hw *ah)
> > > >   	ah->debug.level = ath5k_debug;
> > > > 
> > > >   	phydir = debugfs_create_dir("ath5k", ah->hw->wiphy->debugfsdir);
> > > -	if (!phydir)
> > > > +	if (IS_ERR(phydir))
> > > 
> > > Please use IS_ERR_OR_NULL() instead.

The correct thing for debugfs is to delete the error handling entirely.
Checking for NULL is harmless but checking for IS_ERR() will break the
driver if debugfs is turned off.

Debugfs is a special case where the error handling was deliberately
written so that it's basically impossible to do it correctly.  Because
as I said at the start, the correct thing is to delete it.

regards,
dan carpenter

