Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7BA77F41B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 12:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349785AbjHQKLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 06:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbjHQKLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 06:11:03 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BC02D50
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 03:11:01 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-79af014b555so2131274241.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 03:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692267061; x=1692871861;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pUE8zxkwWqoGXHeb1zOCYx+1mln/AtzyGTguaS9ON94=;
        b=bsGBaVypJvjdmhoX/hGR0JtLCedSpRr8XIw5j5TRtSIaoeOMmpL5ZT/AKYVON6g0bh
         9jKjhRzQdr71KYpGoUk3fAq8C/VB+ThlK+NAlSIXvASu36pln9EqA90Hh9NZObBzWNUP
         71zg59UhuvjX/Voj1Dqp0/Z77jN5NzGIsXWOvY3D98OtUY5tru2fM2gD6VwtpJw4wU8X
         lHX758SREfuNDmaRFHju0ovl0hJip9hWsZ6oM1PMLkf6XsrdrtD03oIeXyj8cIl0K7ZY
         p6vaNPPFIc1at5dcsnaD+DkhbI87OR71vqzr/5UNxK0iueX2p5JeAIhcOy0Yup2F484w
         UfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692267061; x=1692871861;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pUE8zxkwWqoGXHeb1zOCYx+1mln/AtzyGTguaS9ON94=;
        b=ST3W0rMDjfqXV+1bPRCIJZ1D0fMTj6HqVgf/TNL0d9000eEf0h6c5X6hX212Zib0E9
         KyH8FOw1QhzTO1YHwrhVqQ7YhQX3ibLq1PQ0gdfUabBRHOcvUSgbswOXC2thOrPWPQiO
         gIXHHMVvlcK0YbYpPrW7VlaW1x/LzqN1ozHBqlA5xHPGyJHHzknYEAZ79hTsA4KlwZjx
         4YqVgDCUa0ad64tQIDm5CJ4+2tKhry0ZrF4rI2czdggleQol03UQGMmUPUoDsHueee9S
         lky5oHlqpbzv4lqxCKsJIHd32Sl/P/hrBgreT7/BhlQHD3h24UN9Qj2sbFxgxMtN7cWD
         /EYw==
X-Gm-Message-State: AOJu0YyjAMa1w4SkBcV8f6kGjXM8aPdjVJqq3LNGMIZ4ACtkSsA9M+vk
        wHtesMTrroJs3VUD907vJGXQNIhyeBTqrkw5bXpGcVlpZAY++72gaJ8=
X-Google-Smtp-Source: AGHT+IEaqgUh29Sb8dWCa0584RGmfh818iengK6GnjPlZ0wRP0FewuRPY5l+7fsMybIw/BBvMgnpy+QqXO26U/VvIo4=
X-Received: by 2002:a05:6102:3578:b0:447:6c24:7d86 with SMTP id
 bh24-20020a056102357800b004476c247d86mr5093992vsb.4.1692267061076; Thu, 17
 Aug 2023 03:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230810144943.34976-1-yuehaibing@huawei.com>
In-Reply-To: <20230810144943.34976-1-yuehaibing@huawei.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 17 Aug 2023 15:40:39 +0530
Message-ID: <CAFA6WYPsaJdGT9kS4ygHNRYDpX8bRaY__EwZWuCF-x-DgWUDhQ@mail.gmail.com>
Subject: Re: [PATCH -next] tee: Remove unused declarations
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     jens.wiklander@linaro.org, etienne.carriere@linaro.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 at 20:19, Yue Haibing <yuehaibing@huawei.com> wrote:
>
> Commit 4fb0a5eb364d ("tee: add OP-TEE driver") declared but never implemented
> optee_supp_read()/optee_supp_write().
> Commit 967c9cca2cc5 ("tee: generic TEE subsystem") never implemented tee_shm_init().
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  drivers/tee/optee/optee_private.h | 2 --
>  drivers/tee/tee_private.h         | 2 --
>  2 files changed, 4 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index 72685ee0d53f..6bb5cae09688 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -238,8 +238,6 @@ int optee_notif_send(struct optee *optee, u_int key);
>  u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
>                         struct tee_param *param);
>
> -int optee_supp_read(struct tee_context *ctx, void __user *buf, size_t len);
> -int optee_supp_write(struct tee_context *ctx, void __user *buf, size_t len);
>  void optee_supp_init(struct optee_supp *supp);
>  void optee_supp_uninit(struct optee_supp *supp);
>  void optee_supp_release(struct optee_supp *supp);
> diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
> index 409cadcc1cff..754e11dcb240 100644
> --- a/drivers/tee/tee_private.h
> +++ b/drivers/tee/tee_private.h
> @@ -47,8 +47,6 @@ struct tee_device {
>         struct tee_shm_pool *pool;
>  };
>
> -int tee_shm_init(void);
> -
>  int tee_shm_get_fd(struct tee_shm *shm);
>
>  bool tee_device_get(struct tee_device *teedev);
> --
> 2.34.1
>
