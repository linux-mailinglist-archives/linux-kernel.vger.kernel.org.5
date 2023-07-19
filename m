Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BC07591DC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjGSJoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjGSJog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:44:36 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EB910A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:44:35 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc244d307so67140615e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689759874; x=1692351874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BEGbSD7Bjs/eDaJPOd5e2uMPDg1yiM7Q38BpjFCMfrI=;
        b=wX8Tx/XEx0VEZeOObfZqo6H1FFSJdGf5cWR1jSwwof1pC7Nc3p77DyAnt1BF3ocKZC
         nmDY4EDsQIbusAhROxcZ4WDTfwb5GIBJV9/1hpVdirJYdI3dWGXA92XwSX23fBNA1RkG
         WcLsqkzEJ9bkjwMbBm5oggwcPmw8rjSYyHn0WV8HgwlRDt7Mg/qn9/AyeJyRA1+PtKSS
         /tYdi+oBLu/6WV8QT2yfoRIgoEidcQ+ZA2cVB+8HaMnRer+KSiETFbPTy9EnloF1eSBO
         aA74xptLCJca+Ko9kA/4Q/5Doknu5zQLSKdkIffQsm6kBW9qyrlQr754PYq0zD3Lib5m
         d/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689759874; x=1692351874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEGbSD7Bjs/eDaJPOd5e2uMPDg1yiM7Q38BpjFCMfrI=;
        b=fhH8sDP+q3N1NkEj+pps66DEzffdPAM/amYXWAhLe5Uin6uDfXqRQIikIvRBJZjtvD
         tRcTCZjIsttx6Rcb9RdOp5WWD4VwCYnjwk1/2BohIgulVJ6VKQ07kFERWcVJSlpCGNaN
         LruYiGeRFrb6SNXVz/6Vu6yNMY35G8dsVySP4e0w0ZkCa2Q6QlXaQRdN6l0taDVeQ/p2
         nQaZRsjcmO8JOqNhkguqYPhLRkZTSPfER6iJ1uFptcvzRH+QXQBCBI31QZNVM4vGzfcm
         0kk0FAHQVI8ByQ6glWJdVlFBBeCnzx4+F9TuUk0mnexT8utIQMiVZlFcz4ZuFHOMJtFW
         hg4Q==
X-Gm-Message-State: ABy/qLbdQsdyJunYCoC88leraXFmrBUvg6+LNSPKlV24ApCXjdafTTMb
        hpaa11aNsD0KXiBSOOUC8xCzrQ==
X-Google-Smtp-Source: APBJJlHuFKrVTIOQn09Y40jgIzTkU6W+gcJFi/EI3cnQXhcvh8uteAVd29DdycOIgLeI13PhsB2hDQ==
X-Received: by 2002:a5d:5506:0:b0:314:3358:d57f with SMTP id b6-20020a5d5506000000b003143358d57fmr14709214wrv.56.1689759873861;
        Wed, 19 Jul 2023 02:44:33 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z3-20020a5d4d03000000b00313de682eb3sm4835970wrt.65.2023.07.19.02.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 02:44:32 -0700 (PDT)
Date:   Wed, 19 Jul 2023 12:44:29 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy@kernel.org>, Marek Vasut <marex@denx.de>,
        Marc Zyngier <maz@kernel.org>,
        Dan Carpenter <error27@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: mxc: fix unused function warnings
Message-ID: <319ee5f7-2dbd-430d-8ab1-a7b072ac7a9f@kadam.mountain>
References: <20230718193913.3578660-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718193913.3578660-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 09:39:08PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The new runtime PM support causes a harmless warning about
> unused functions when runtime PM is disabled:
> 
> drivers/gpio/gpio-mxc.c:612:12: error: 'mxc_gpio_runtime_resume' defined but not used [-Werror=unused-function]
> drivers/gpio/gpio-mxc.c:602:12: error: 'mxc_gpio_runtime_suspend' defined but not used [-Werror=unused-function]
> 
> Change the driver to use the more modern helper macros that avoid these
> warnings, and remove the now unnecessary __maybe_unused annotations
> 
> Fixes: 3283d820dce64 ("gpio: mxc: add runtime pm support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

The patch is nice, but I don't understand why __maybe_unused doesn't
work?

regards,
dan carpenter

