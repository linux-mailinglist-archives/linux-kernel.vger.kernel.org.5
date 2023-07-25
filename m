Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577F9761C49
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjGYOwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjGYOww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:52:52 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFD0E78;
        Tue, 25 Jul 2023 07:52:51 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bbc7b2133fso1296205ad.1;
        Tue, 25 Jul 2023 07:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690296771; x=1690901571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7jwpwv6DwxSGl4WJ9F4giH5nvpoG0Ao/sihqhBU6r4=;
        b=UFrpIIhVmFswA5Vy3iZEBJPAym7h6CwLfcXnqnM/XQf+znrHoIlNgYbeqWnIaWdLbr
         HYk2Rjrd1ntigP8ybgaSfCopOxdidy2GtCuXrCCtQewRqPW8/kalDykFIUCb0Jb7yH5O
         OF7lPlW+TQWHETQoC0X6rqgdyFoXPT6Ffmxs+UqoW5Mg9wgJDTVVnJMH77ISJsWo/Dgc
         lXUQtt4MDkd2SIK+RRJGLyqjYvjPYVehDCDwA1vt5GhNt00q8FIr66TqOmoyCyDxsF1J
         f7gcxoN2wp+az6l/UradG47ZWJgzeul3mmrgPkc048nBqva/g2tLM3TOuaRco4tjjCUr
         C1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690296771; x=1690901571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7jwpwv6DwxSGl4WJ9F4giH5nvpoG0Ao/sihqhBU6r4=;
        b=GbjPWXRsz/sMSykR+bYo0QeR7RHuoE3xjTbviElSmVbNGSr0x4pO/YpijwK9HExua8
         Xe/JT4K8WgVL96DGtv9zUB8GUGl+K9AjOyBmRh8TRUvpJYRarSb5fr9GFXN4bO/tK5WN
         notQEtMKLvS2UylaKudwxTJp1zLMiXpJTxjsh+NTn05Lg+rvNXTYwy7cZhxhrMYkiytS
         rCaAzuzN0c7wsuLaVCyLpBgx7mdY5sTLWuBZPB888lKERjBspYD4ZPV6SUNc84OVQiSq
         Kvh7CM9cWJnMuvYJK5qdXVunoP5Wj83CKCTE9Q3oSo42+UvwnWTtSbCo0rW4NTCJXhyt
         xaWQ==
X-Gm-Message-State: ABy/qLbJK24GZO+Wj5avpFRGXffFI4CXrBwTNJjzIyhFDBj7KIF1tN4P
        VLp1XHrilOBX8I3JQb6yzmg=
X-Google-Smtp-Source: APBJJlEJrkeVee0GzjDW0IDaByHvy4fir4/nKLCNC+JnQRY/65NPXZITIey/j4C740laBqhsd5Mt3Q==
X-Received: by 2002:a17:902:dacc:b0:1bb:a922:4a1a with SMTP id q12-20020a170902dacc00b001bba9224a1amr4726005plx.6.1690296770810;
        Tue, 25 Jul 2023 07:52:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n8-20020a17090ac68800b00268320ab9f2sm1631383pjt.6.2023.07.25.07.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 07:52:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 25 Jul 2023 07:52:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] pmbus_core: Refactor pmbus_is_enabled function
Message-ID: <484dae92-0141-4d65-bb8b-5f54171c03aa@roeck-us.net>
References: <20230725125428.3966803-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725125428.3966803-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 02:54:25PM +0200, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Refactor the pmbus_is_enabled() function to return the raw status
> without any additional processing as its already done in
> _pmbus_is_enabled function.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

Applied. I rephrased the commit message so don't be surprised that
it looks different.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> base-commit: 55612007f16b5d7b1fb83a7b0f5bb686829db7c7
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index fa06325f5a7c..42fb7286805b 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2768,7 +2768,7 @@ static int __maybe_unused pmbus_is_enabled(struct device *dev, u8 page)
>  	ret = _pmbus_is_enabled(dev, page);
>  	mutex_unlock(&data->update_lock);
>  
> -	return !!(ret & PB_OPERATION_CONTROL_ON);
> +	return ret;
>  }
>  
>  #define to_dev_attr(_dev_attr) \
