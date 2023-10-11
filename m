Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE70D7C5F34
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 23:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376315AbjJKVjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 17:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbjJKVjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 17:39:03 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CB99E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:39:01 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c8a6aa0cd1so2830605ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697060341; x=1697665141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wQYo9++dcgxg2nv6IP2UpMdMgwP0vkzDdfVUM+eI3FY=;
        b=I09895eLrI5XblTDto+MsftearTwecZ1+uKPTERgGj4Z6oY7xkmJZDleh9w+DZunJ9
         YRZ0ejocqqe7cwz5L7fDnrZgCVh1e1YtIZyXyH4R7t+w9OD5Wlp4iURUOxvPV25ZfgU0
         IL6CX53TbjqWpEqtTFu5TbvqAQmLkYihhtaz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697060341; x=1697665141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQYo9++dcgxg2nv6IP2UpMdMgwP0vkzDdfVUM+eI3FY=;
        b=ld7fnVoEvIwdkn1gSZFEl/v9n8s42ObkZk8AenCCE27w9JsLRmhUExu8Fc/TN3kGaP
         EFRQR/GTN/5Yz97MgWlXBUIS4DyMjrJo9aBMHTLXBMadWTCsN6ARFzKMM693n7ClZXN7
         GFjZwLaMFxDiZ09bAHQZn3BHieTAdw7zWMufRmlWKgTmB7PN58NCTN4Wmg2fw+x9UpN+
         taJEQ2Krvu42Jm7ZleglymdpimInB33N+Po5YpAXxSr0a8sU8Dw2jDZgMzP8aBEZYK3K
         zMOIWnSdCT07hCugbm2OK1GkoKR9t2DwIlc1+sqdd9mjkakR5/nhRZQsnlxuR5Uw0Wgl
         7+Zg==
X-Gm-Message-State: AOJu0Ywm39IdrIzYUn1GekLkoI9vemGq2z45ulzN/p2Str9T1dGbGBhH
        Q687O0BQZnMwGsuHzWWjDqBtzw==
X-Google-Smtp-Source: AGHT+IF8K3Psvkfh1b6MDcUT6LfA9+V/N9SI10hvEG8lDfYQ/D8Ss8oCO45dIi8LZzUECZ4tb7vggA==
X-Received: by 2002:a17:903:120f:b0:1bb:994c:bc43 with SMTP id l15-20020a170903120f00b001bb994cbc43mr22837597plh.18.1697060340983;
        Wed, 11 Oct 2023 14:39:00 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902ec8e00b001c55db80b14sm305424plg.221.2023.10.11.14.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 14:39:00 -0700 (PDT)
Date:   Wed, 11 Oct 2023 14:38:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2][next] clk: socfpga: Fix undefined behavior bug in
 struct stratix10_clock_data
Message-ID: <202310111438.2D0168C@keescook>
References: <cover.1697059539.git.gustavoars@kernel.org>
 <5dd8483177dc8cd91d021170b6717f2e570bab03.1697059539.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dd8483177dc8cd91d021170b6717f2e570bab03.1697059539.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 03:34:03PM -0600, Gustavo A. R. Silva wrote:
> `struct clk_hw_onecell_data` is a flexible structure, which means that
> it contains flexible-array member at the bottom, in this case array
> `hws`:
> 
> include/linux/clk-provider.h:
> 1380 struct clk_hw_onecell_data {
> 1381         unsigned int num;
> 1382         struct clk_hw *hws[] __counted_by(num);
> 1383 };
> 
> This could potentially lead to an overwrite of the objects following
> `clk_data` in `struct stratix10_clock_data`, in this case
> `void __iomem *base;` at run-time:
> 
> drivers/clk/socfpga/stratix10-clk.h:
>   9 struct stratix10_clock_data {
>  10         struct clk_hw_onecell_data      clk_data;
>  11         void __iomem            *base;
>  12 };
> 
> There are currently three different places where memory is allocated for
> `struct stratix10_clock_data`, including the flex-array `hws` in
> `struct clk_hw_onecell_data`:
> 
> drivers/clk/socfpga/clk-agilex.c:
> 469         clk_data = devm_kzalloc(dev, struct_size(clk_data, clk_data.hws,
> 470                                 num_clks), GFP_KERNEL);
> 
> drivers/clk/socfpga/clk-agilex.c:
> 509         clk_data = devm_kzalloc(dev, struct_size(clk_data, clk_data.hws,
> 510                                 num_clks), GFP_KERNEL);
> 
> drivers/clk/socfpga/clk-s10.c:
> 400         clk_data = devm_kzalloc(dev, struct_size(clk_data, clk_data.hws,
> 401                                                  num_clks), GFP_KERNEL);
> 
> I'll use just one of them to describe the issue. See below.
> 
> Notice that a total of 440 bytes are allocated for flexible-array member
> `hws` at line 469:
> 
> include/dt-bindings/clock/agilex-clock.h:
>  70 #define AGILEX_NUM_CLKS	55
> 
> drivers/clk/socfpga/clk-agilex.c:
> 459         struct stratix10_clock_data *clk_data;
> 460         void __iomem *base;
> ...
> 466
> 467         num_clks = AGILEX_NUM_CLKS;
> 468
> 469         clk_data = devm_kzalloc(dev, struct_size(clk_data, clk_data.hws,
> 470                                 num_clks), GFP_KERNEL);
> 
> `struct_size(clk_data, clk_data.hws, num_clks)`	above translates to
> sizeof(struct stratix10_clock_data) + sizeof(struct clk_hw *) * 55 ==
> 16 + 8 * 55 == 16 + 440
> 		    ^^^
> 		     |
> 	allocated bytes for flex-array `hws`
> 
> 474         for (i = 0; i < num_clks; i++)
> 475                 clk_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
> 476
> 477         clk_data->base = base;
> 
> and then some data is written into both `hws` and `base` objects.
> 
> Fix this by placing the declaration of object `clk_data` at the end of
> `struct stratix10_clock_data`. Also, add a comment to make it clear
> that this object must always be last in the structure.
> 
> Fixes: ba7e258425ac ("clk: socfpga: Convert to s10/agilex/n5x to use clk_hw")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Nice find!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
