Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2334B783706
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 02:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjHVAWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 20:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjHVAWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 20:22:00 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1563183;
        Mon, 21 Aug 2023 17:21:57 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bf092a16c9so30776335ad.0;
        Mon, 21 Aug 2023 17:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692663717; x=1693268517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lzGJhAZomF9VjAddAdD5cPoeE1mKlbl8y//hkF3jGws=;
        b=Oo8Qe0Lwf9FTT7biPMj5/dQvlt+KS1NjdX2zQEiy/8IqUw9Ycg+KkYZcyQCQKxSNHD
         WX5p+2D4xwesL0ER1gJADBotm9PE5K7RkXm+qwnUbKwYnrnU72lcJ8tVZwFgP1A31F8p
         zj+QSOvxnT8InhhFo0etmdFGNsRnRRvknpVqW+vH6gw3D3tZVoG2XuP6/wTJpVBWiZBb
         KW7eVZuE+UMM+SkZi/ROndH0K2zfuN4Q+y76sJEFp4xpGtGdYdx+397PnfA3Y0gkxlTZ
         fwpvrYFasd1RMfrOtdoH5IZ3rLpqtGBxepKkpndImgW2hdxFuz/wun1w17HZOMlPOd1N
         VddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692663717; x=1693268517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzGJhAZomF9VjAddAdD5cPoeE1mKlbl8y//hkF3jGws=;
        b=kC8BEzEI41C+2bQ93lBDRnCf/xRSAC3kHzaGek+oFO3cZuMLghaDUJ84DKMTIC3tUw
         5Hp0WwwqDNLxj6IR37M1Ky0oESlyo5RlR70N0jkzpp6+iyqCh7PFkDh8ssHXgtti7vAp
         t2FvzIb/y9QC+0aRLa+wdM2PnTRNaNFzLRR0hxP5gezwD2vIB8kIxIAoN6vXJAgDPZt7
         Ly7df3fG1ZO/10+s73en0tALNfl3Hn4itAjfoWkUZLpiSO3d+QIodZ441ZHWC3aN7WAA
         ltXU9XmAtN8BmksFu5j5LFoSrkwu2IXctq8N8OoJZEs4YN9NF7M3zEZ790khjqBSwiC8
         RcOQ==
X-Gm-Message-State: AOJu0YwJ/g0d3CdQazDsFAFxkJXSS6DAJiwj6ViatyhPMWA8WFGoxb4T
        BWuDINekRyaYa7UOgPrhBsc=
X-Google-Smtp-Source: AGHT+IFZWX5jwMMKfwXmN8vUNmfVHXNBCFCr/f6QTshV9afB5VUnnUgnx/MHDdTxRs0USyPVy8ePOw==
X-Received: by 2002:a17:903:4c5:b0:1bd:ec9e:59fe with SMTP id jm5-20020a17090304c500b001bdec9e59femr8037603plb.68.1692663717101;
        Mon, 21 Aug 2023 17:21:57 -0700 (PDT)
Received: from sol ([220.235.36.234])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ec8c00b001befe0ac506sm7596285plg.175.2023.08.21.17.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 17:21:56 -0700 (PDT)
Date:   Tue, 22 Aug 2023 08:21:51 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [libgpiod v1.6.x][PATCH] tests: mockup: unbind mockup devices
 before unloading the module
Message-ID: <ZOP/n30hYR/8zN60@sol>
References: <20230821153339.26305-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821153339.26305-1-brgl@bgdev.pl>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 05:33:39PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> gpio-mockup relies on the GPIO devices being registered in module's __init
> function and them being unregistered in __exit. This works with the GPIO
> subsystem as it only takes a reference to the underlying owner module when
> a GPIO descriptor is requested and not when the GPIO device is
> instantiated.
> 
> This behavior may change in the future in the kernel so make the behavior
> of libgpiomockup more correct and have it unbind all mockup devices over
> sysfs before unloading the module.
> 

Never knew that unbinding was even an option.
Maybe update gpio-mockup's documentation?

Just clarifying what the potential impact of the existing libgpiomockup
behaviour and future kernel behaviour is - the kernel may log errors but
otherwise correctly handle userspace unloading behaving badly?
So this patch is pre-emptory noise reduction?

Cheers,
Kent.
