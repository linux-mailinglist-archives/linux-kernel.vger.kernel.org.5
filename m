Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D49777057E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjHDQDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjHDQCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:02:55 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C68D2D71
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:02:51 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31751d7d96eso1904904f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 09:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691164969; x=1691769769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOHAPZJIyf1nvT44zbs9xcZKeI5Rx3Lp6m910v0C5nE=;
        b=FCci7qzbL2drmMD/LBqpcM5b7bHBbLOlwDL5VcTKhKfswJwkz+/BO8ZugjiTrcR5Nn
         CSHkzSosjbuUa1FtkIoUAV/73Kr63FhfeRxf14uJjSp7pqqlkPR5JwC8reA4rh1IKMyd
         0+NKF4Ohi+LZ0YiZSex6e7rTwCr6AWmyCBJhMhM+7J+E+La2UWIYYKc3mL44VrMQnBoK
         6rwluKIrAh9lEYJGkU6w61SFzJqnjgTUU3OeZpEWDZYo6HPDrr51eBKS++e/zOu/02jD
         9tKFOIj3Oxm99ku/iJ0yNVhVDaO8GI9kUldzftq1qt+hYM/0IJ6zsJeUFDvAnRfbWgP+
         E5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691164969; x=1691769769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOHAPZJIyf1nvT44zbs9xcZKeI5Rx3Lp6m910v0C5nE=;
        b=U85530GjHqScZ9ryXlp/Q4JWD3Mg3NsgpkLZo1btyHVe7sJwhnP59NjvSWhU0NXRTT
         U02pHD9hm9bmpDU3dldnk0u7FFyZA++rwBS6/C/My2sifbtZm5v9BnOEaPS51cKMtqMA
         xJMDwz7qXtcmoCG/UBTOvJ9NfskuVZfydeW38os5lvjlAFtRt7yCEnj6qy3atX3niIAg
         zJ4Npz4V8ammZEg54EM5t0hWZzb9xGOk5kr/Fxp5PoDhy9jDW4chCg2pHcDkkDIHE6L3
         RywqMkge7VpwsFQkTF22UCdi06/X6zldYPz5+DUexlbbCSmRSmswxBUXlmLm7JfjoKxk
         GdKQ==
X-Gm-Message-State: AOJu0YzsrTL5WSAIWTKm+CENILzqRUQeVNRHroVCAwEqRQQPz4dwGK3t
        hYSoNywkqg0ajBt88HeHc9hcKw==
X-Google-Smtp-Source: AGHT+IGxDY1CYcywGuX0HnIuOGY0yx+9NZTfW7Br7zSQ5hgiDNN/UCDEsDmnF80RF/oItrhVioyJKw==
X-Received: by 2002:a5d:4b03:0:b0:317:5af3:caa4 with SMTP id v3-20020a5d4b03000000b003175af3caa4mr1623600wrq.38.1691164969434;
        Fri, 04 Aug 2023 09:02:49 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d40c7000000b0031423a8f4f7sm2874664wrq.56.2023.08.04.09.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 09:02:49 -0700 (PDT)
Date:   Fri, 4 Aug 2023 19:02:46 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     oe-kbuild@lists.linux.dev,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH v7 5/7] nvmem: core: Rework layouts to become platform
 devices
Message-ID: <15cfd153-314a-4eeb-8de9-97a888905bff@kadam.mountain>
References: <20230801182132.1058707-6-miquel.raynal@bootlin.com>
 <b9040273-aca8-432a-83aa-b0d6b1b88529@kadam.mountain>
 <20230804173903.2b298cd3@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804173903.2b298cd3@xps-13>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 05:39:03PM +0200, Miquel Raynal wrote:
> Hi Dan,
> 
> dan.carpenter@linaro.org wrote on Thu, 3 Aug 2023 13:13:04 +0300:
> 
> > Hi Miquel,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Miquel-Raynal/nvmem-core-Create-all-cells-before-adding-the-nvmem-device/20230802-022331
> > base:   char-misc/char-misc-testing
> > patch link:    https://lore.kernel.org/r/20230801182132.1058707-6-miquel.raynal%40bootlin.com
> > patch subject: [PATCH v7 5/7] nvmem: core: Rework layouts to become platform devices
> > config: x86_64-randconfig-m001-20230730 (https://download.01.org/0day-ci/archive/20230803/202308030002.DnSFOrMB-lkp@intel.com/config)
> > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > reproduce: (https://download.01.org/0day-ci/archive/20230803/202308030002.DnSFOrMB-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit
> > (i.e. not just a new version of the same patch/commit),
> 
> (Nice addition, a lot of newcomers would always add these tags
> otherwise.)

The Intel kbuild devs add this stuff, I just look it over and hit
forward.

> 
> > kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > | Closes: https://lore.kernel.org/r/202308030002.DnSFOrMB-lkp@intel.com/
> > 
> > New smatch warnings:
> > drivers/nvmem/core.c:1003 nvmem_register() warn: 'layout_np' is an error pointer or valid
> > drivers/nvmem/core.c:2130 nvmem_try_loading_layout_driver() warn: 'layout_np' is an error pointer or valid
> > 
> > Old smatch warnings:
> > drivers/nvmem/core.c:761 nvmem_add_cells_from_fixed_layout() warn: 'layout_np' is an error pointer or valid
> > drivers/nvmem/core.c:802 nvmem_layout_get() warn: 'layout_np' is an error pointer or valid
> > 
> > vim +/layout_np +1003 drivers/nvmem/core.c
> > 
> > 266570f496b90d Michael Walle         2023-04-04  1000  
> > 00d059fd6702f0 Miquel Raynal         2023-08-01  1001  	/* Populate layouts as devices */
> > 00d059fd6702f0 Miquel Raynal         2023-08-01  1002  	layout_np = of_nvmem_layout_get_container(nvmem);
> > 00d059fd6702f0 Miquel Raynal         2023-08-01 @1003  	if (layout_np) {
> > 
> > So, ugh, of_nvmem_layout_get_container() return NULL on error or error
> > pointer if either CONFIG_NVMEM or CONFIG_OF is turned off.  I feel like
> > that's a mistake.  Normally when a function returns both error pointers
> > and NULL then the NULL means the feature is disabled and the error
> > pointers mean there was an error.  Here it is the opposite.
> > 
> > I have written a blog about this:
> > https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/
> 
> Nice (besides the huge spider which stared at me unexpectedly :-) )

Those are a species of jumping spiders.  They are shiny and golden in
real life, but it never shows up properly in photos.  :)

> 
> > At first I thought that this was to do with CONFIG_COMPILE_TEST but
> > actually that is disabled.  The issue here is that CONFIG_OF is turned
> > off.  So this is a genuine bug, we're compiling a module which will
> > always crash.
> > 
> > So I guess the fix is easy that this should return NULL if either
> > CONFIG_NVMEM or CONFIG_OF is turned off.  That was a long explanation
> > which is no longer required now that it's not a COMPILE_TEST issue.  :P
> 
> I wanted to disable CONFIG_OF to make the test, I totally forget, I'll
> handle this case and return NULL when this happens.
> 
> However I don't understand why you mention CONFIG_NVMEM, because if it
> is not defined, this file will not compile at all?

Yeah.  You're right.  I wrote this email thinking it was a
CONFIG_COMPILE_TEST issue and didn't edit it properly in the end.

regards,
dan carpenter

