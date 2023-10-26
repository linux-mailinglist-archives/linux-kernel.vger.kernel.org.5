Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0E87D84BC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345252AbjJZOaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345235AbjJZOaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:30:09 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337291B2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:30:07 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6ce532451c7so595437a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698330606; x=1698935406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2n+ghG7acJgH7zVagE61XUCcCU4fU97sE0ZmR2fozaQ=;
        b=NVyw0hObzCRzzFhEwjakOO8qbaOM/48pDKU4W+sBTwtlYnXi4FLsIuMESqE49eRjhv
         Cu9Vb9vSw24kzc8C3iLTGdBS4Zn0uHKjmuZl9coUO9jLktRRlao4oaWrkgRvaiDtK3BK
         47GMdQkNHo1/wjdR8omul/+ey25LGMvc3BIYeNdlV+e9kc8biLNcyBm62IZLbr2wc5YY
         jYVA607xFYWWsKETgpuu8jCjRP5HcYxnBQsJra77RLdmm15U3u8r8z08aqEuC75y0IjK
         OvelBLFgZh5e5vore6QhtG3B9kGXLB7ooDfJPkFLlex7E4WYydVrpcveer6pgkFddQy/
         5Atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698330606; x=1698935406;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2n+ghG7acJgH7zVagE61XUCcCU4fU97sE0ZmR2fozaQ=;
        b=TaIqg1jgGtycb+8WUrBcKFQPXXWZY2tJGfN+oBDcW70//uj9uwDFdimaUyY6dAKo1t
         7srWbUq/DdmNj+NSvPa9PeXrwQCmlAX083zoQnqkiCHlFZN5RClB+EAjLznBDv0AS9bP
         +MD7bUJSOTWScABxCaZJmLg16cUe/Du6SHCh+PBKGJMUVv029k7RcuglzOT0XR9Q2/ev
         87FnSxtC4OhRkbt3EdwHtf251i84RF64//ZCG9xm5HOgikRiLL4On5AZ/czgAxypG8Jn
         pGsCjfWI1mXONvKcpcyZupqmYcxSUu0dwvDbSRJde6ZreBAe/OEJTmv6xawSUfQp3Xfa
         eGiA==
X-Gm-Message-State: AOJu0YwD8XWyScbTQhWFTbDNO1VjqqjgpKT9iXbhzQB75VgCac8gGEQj
        mDvMnxoi3FvTNiaycLFM+Zs=
X-Google-Smtp-Source: AGHT+IGiyOf7GmjI4GS4FWrkOukwx3VjyjHz64QTMY+vTcWptuNP0Ud6ZSIWEbl2ytje90JgPeUPKQ==
X-Received: by 2002:a05:6830:2693:b0:6c6:4843:2abb with SMTP id l19-20020a056830269300b006c648432abbmr19827437otu.12.1698330606288;
        Thu, 26 Oct 2023 07:30:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u9-20020a817909000000b00577269ba9e9sm47443ywc.86.2023.10.26.07.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 07:30:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5ad3be17-3011-15bf-26c0-9f9055034d1a@roeck-us.net>
Date:   Thu, 26 Oct 2023 07:30:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 1/1] watchdog: mlx-wdt: Parameter desctiption warning
 fix
Content-Language: en-US
To:     michaelsh@nvidia.com, wim@linux-watchdog.org
Cc:     vadimp@nvidia.com, oe-kbuild-all@lists.linux.dev,
        trivial@kernel.org, linux-kernel@vger.kernel.org
References: <20231026082558.12142-1-michaelsh@nvidia.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20231026082558.12142-1-michaelsh@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/23 01:25, michaelsh@nvidia.com wrote:
> From: Michael Shych <michaelsh@nvidia.com>
> 
> Add parameter desription to fix warning.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310241044.lvqeOGli-lkp@intel.com
> Signed-off-by: Michael Shych <michaelsh@nvidia.com>
> Signed-off-by: Vadim Pasternak <vadimp@nvidia.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/mlx_wdt.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/mlx_wdt.c b/drivers/watchdog/mlx_wdt.c
> index 9c5b6616fc87..667e2c5b3431 100644
> --- a/drivers/watchdog/mlx_wdt.c
> +++ b/drivers/watchdog/mlx_wdt.c
> @@ -39,6 +39,7 @@
>    * @tleft_idx:	index for direct access to time left register;
>    * @ping_idx:	index for direct access to ping register;
>    * @reset_idx:	index for direct access to reset cause register;
> + * @regmap_val_sz: size of value in register map;
>    * @wd_type:	watchdog HW type;
>    */
>   struct mlxreg_wdt {

