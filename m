Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD5B80A26B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbjLHLlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbjLHLlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:41:07 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926A210F9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 03:41:13 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54f5469c211so582172a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 03:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702035672; x=1702640472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g6EppStg4OGdv0sXM93P4da5XFpuxMt5RLtYpnGf+AE=;
        b=jpVToGRfe8J6P7styZFwsSNJmDxZgNVjD6OjoIiD23Xk8Nbu2PH18xMRbR1gDHQeAF
         T3hyyNlSaTgpiL1YhdaFfOxxKVYB+dgZQkiil3hW7KrlhulFcaiT45qRfDZqIl9z8WbZ
         iFz0rIg6wkSOatvUkBSU3Mz5znavQD1sJnnOnA2E8wWqKqyoO61RAScLxvTbnb5l5Nkr
         DUNZNRejJFTAh4DYXakxk2CJX7Zx9OjxkKsKYtwGad6o4JnHsmakwglFT+ERv0W7p9ig
         cCU6P5m62B5zp7XTMb6EiVcxTbdp8N9MvsA8wUy3HhiJNHtF2ZsAJwixxyurEBuA6GCa
         QEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702035672; x=1702640472;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6EppStg4OGdv0sXM93P4da5XFpuxMt5RLtYpnGf+AE=;
        b=L1BdUH7rgQpPsCGu+ROBqwUbtJgdCFwTSShwubX9BWUwVpF/TSa0FkzRyZiX2bDABC
         Yvw2FRvCOICgkHtEDMSHJxXj4MVOZsi/Log98LVkHctREJCS/zBcoc8nZVhE+rIgbqFi
         0ZpcJYZx9Cl1O75kkU46OFvvYYecFBihaD943QqlrBtoUBA3t7vDJFgL9M2GdT6H+zGW
         Ow9x6svx3RewZxtUVAGnZaL0y3JA2kD/aNmfEBNeGbB1WLdqjSZVxuURFCxqSwJErLK7
         jGcEv7tUpqxJUd2djMO/mcQpcsg9U6+ffj91M0YaWUwqDSeq1ejSyRkdQjfmhrnkg/qv
         d+Rg==
X-Gm-Message-State: AOJu0YzXlhzXxj/bpiVQvkn7WFz9VEMWz44t/N8KKky7ZWkSIKXV5k34
        xguSkcyIQFHvcBkh528LdfRtwCtByqP60xmuYwc=
X-Google-Smtp-Source: AGHT+IHG56Hptk894BErnOmH9PrsepI+mBh7Uy01m9AKYmJGGI0NUAMpd+OVngVOSR10inXu55I3ZQ==
X-Received: by 2002:a17:906:3bd2:b0:a1b:7608:f962 with SMTP id v18-20020a1709063bd200b00a1b7608f962mr2372304ejf.54.1702035672072;
        Fri, 08 Dec 2023 03:41:12 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id tl12-20020a170907c30c00b009fd585a2155sm908079ejc.0.2023.12.08.03.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 03:41:11 -0800 (PST)
Message-ID: <296be5ed-47a6-4701-a7f5-968e9e65b5f8@linaro.org>
Date:   Fri, 8 Dec 2023 11:41:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nvmem: sprd: Fix memory overflow issue during memcpy
 operation in efuse driver
Content-Language: en-US
To:     Yanxin Huang <yanxin.huang@unisoc.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        huang yanxin <yanxin.huang07@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
References: <20231208061134.26354-1-yanxin.huang@unisoc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20231208061134.26354-1-yanxin.huang@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

thanks for the patch.

On 08/12/2023 06:11, Yanxin Huang wrote:
> The efuse driver didn't determine the size of bytes, resulting in memory
> overflow during memcpy operation.
> 
> Fixes: 096030e7f449 ("nvmem: sprd: Add Spreadtrum SoCs eFuse support")

Please add CC Stable for all the fixes.

> Signed-off-by: Yanxin Huang <yanxin.huang@unisoc.com>
> ---
>   drivers/nvmem/sprd-efuse.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
> index bb3105f3291f..24b63620d217 100644
> --- a/drivers/nvmem/sprd-efuse.c
> +++ b/drivers/nvmem/sprd-efuse.c
> @@ -311,6 +311,7 @@ static int sprd_efuse_read(void *context, u32 offset, void *val, size_t bytes)
>   	ret = sprd_efuse_raw_read(efuse, index, &data, blk_double);
>   	if (!ret) {
>   		data >>= blk_offset;
> +		bytes = bytes > sizeof(data) ? sizeof(data) : bytes;

looks like sprd_efuse_read is only reading upto 4 bytes max, and 
silently ignoring reading requests data after 4 bytes.

Is this working because consumers so far only requested 4 bytes and less ?
does dumping nvmem sysfs actually show real content in your case?

--srini
>   		memcpy(val, &data, bytes);


>   	}
>   
