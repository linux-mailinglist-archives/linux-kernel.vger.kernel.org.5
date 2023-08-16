Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA15877EB18
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346283AbjHPUz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346328AbjHPUzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:55:44 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E492727
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:55:43 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-565ea1088fbso1395631a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692219342; x=1692824142;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C00XHrqX2JehVx2BBEXfXecV7OVkf6gSj4eigV0sDaQ=;
        b=Wd+2qwQqJLbcXOZfZxHK7QeYcunXx/JB1n8i5nb0p6eHz8dT9PSiVtuZHXF9om1+hX
         afleLuXxjUJI+9b6oL+ivcB0pCk60ar2sDz6igfDLeBu8b+zpuhIB3GoyLlDBFfcGP0S
         eF8L6NfDlEdKuwAYRfjUf1/T0y843DHuXwRPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692219342; x=1692824142;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C00XHrqX2JehVx2BBEXfXecV7OVkf6gSj4eigV0sDaQ=;
        b=QSBBkSzzD6toT0swmREU6v1sZRjorozzjYBliil2P9l7zmR/rFV106Dxh15Swd4R9G
         EIfYLRRN3qlp83vagVjx/wx5xfGdVqz+G9vkTYN65BnydDwCG1mrAU9pdKBD0YMv1A6n
         jjPiBG3tTC9040KM/dsf7A1TYqz3X19ds5NIuqibSOfucjSgeeyyy55q/vUB7+c5DWL+
         K2qvtImMKHOGlLBfr/ymIU6mS7hC6FnI3uYR+4YfWPASJCZOyAZeP/hQ5dRvdl4Yi8vh
         EuNTqXruYDdMwYhKd8s0Ogks7HTfBTB9hwPf7ekVhJUV30Lts4PLINMXu2BQmHrTQwEI
         d1oA==
X-Gm-Message-State: AOJu0Yz6bk5LGtoovx0X39Swumc53vUY3HhAc54xtfhMXpo5Z50+HtN1
        rEMlalLgSpTdO4GdPwKuVDbTfA==
X-Google-Smtp-Source: AGHT+IHJW+AH5vlrIhdUlHgmZMHwz/lc7DRwSMYiYs0PBq1i1vK5obxcxfHOGdznenzbMzBFW6xmFA==
X-Received: by 2002:a17:90a:d988:b0:262:f0e6:9e09 with SMTP id d8-20020a17090ad98800b00262f0e69e09mr2633351pjv.14.1692219342574;
        Wed, 16 Aug 2023 13:55:42 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a018500b0026b26181ac9sm178867pjc.14.2023.08.16.13.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 13:55:41 -0700 (PDT)
Date:   Wed, 16 Aug 2023 13:55:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Waqar Hameed <waqar.hameed@axis.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, gongruiqi1@huawei.com
Subject: Re: [PATCH v2] iio: irsd200: fix -Warray-bounds bug in
 irsd200_trigger_handler
Message-ID: <202308161355.9EC0D12C@keescook>
References: <20230810035910.1334706-1-gongruiqi@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230810035910.1334706-1-gongruiqi@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 11:59:10AM +0800, GONG, Ruiqi wrote:
> From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
> 
> When compiling with gcc 13 with -Warray-bounds enabled:
> 
> In file included from drivers/iio/proximity/irsd200.c:15:
> In function ‘iio_push_to_buffers_with_timestamp’,
>     inlined from ‘irsd200_trigger_handler’ at drivers/iio/proximity/irsd200.c:770:2:
> ./include/linux/iio/buffer.h:42:46: error: array subscript ‘int64_t {aka long long int}[0]’
> is partly outside array bounds of ‘s16[1]’ {aka ‘short int[1]’} [-Werror=array-bounds=]
>    42 |                 ((int64_t *)data)[ts_offset] = timestamp;
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
> drivers/iio/proximity/irsd200.c: In function ‘irsd200_trigger_handler’:
> drivers/iio/proximity/irsd200.c:763:13: note: object ‘buf’ of size 2
>   763 |         s16 buf = 0;
>       |             ^~~
> 
> The problem seems to be that irsd200_trigger_handler() is taking a s16
> variable as an int64_t buffer. As Jonathan suggested [1], fix it by
> extending the buffer to a two-element array of s64.
> 
> Link: https://github.com/KSPP/linux/issues/331
> Link: https://lore.kernel.org/lkml/20230809181329.46c00a5d@jic23-huawei/ [1]
> Fixes: 3db3562bc66e ("iio: Add driver for Murata IRS-D200")
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
