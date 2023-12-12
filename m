Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F151880EE4A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376359AbjLLODQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376418AbjLLODO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:03:14 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C6CB3;
        Tue, 12 Dec 2023 06:03:18 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a1f653e3c3dso585140166b.2;
        Tue, 12 Dec 2023 06:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702389797; x=1702994597; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uZijd03LXNPYjeHZjeC7Jq869Ey7f+8xrdH6Ffypg54=;
        b=k8yk9r4uUufQsTcW5zt2CoXBMz3EjZuRFeoupN0Vx2JVhwiGPZE1SxbyDaKbvQryrX
         nSOJEt6HJpNzQt4B7uvQA7eWIuhu8sktmV5CK0NJwSe+7tD6q39P4fNOXUcuJhPfBYqs
         WryZEZ2oawM9LMh+INpuuIfjCkhmKobA9gZr0kzQfuwBLgRpd5xvFUL5q9vxZL9oi1jb
         alHRuCuzMXi4YtV4FnpGwF61jAvO/6tOeYV8NxYwfmGHDWl6ObhFybLC9wu+qdTytSox
         ODrE+yN9XnAxYLN2mZXW5riRDYRDXw7RwxakftrOybhDuOj0GYqJ4G9Bu0oEtwtjrSE+
         Ji+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702389797; x=1702994597;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uZijd03LXNPYjeHZjeC7Jq869Ey7f+8xrdH6Ffypg54=;
        b=G7+ttSaFhMfPmpQRCn2H8UtcriCTtQ4DrR0JpTUuJad2bmsRNiPW2EL15YfacFlLB5
         7CJi1tJ802J/kXgzhLMzRw9Sm/N7YH2wPInUsQaSqCGWZPbFTgV36Cux9Wm5uogVcBl6
         dNoTv3/Ky5+66UkIH1bRKoTTd4ovQyEHoQZC6TB56Ewyxl+w79763+ph8nS+mdsDJ2w7
         q82yDzO60zzp+NrMH4g3uAVedwTkDoURiviyJ5N1Bk4irUqr9zXQN2M8+3eDbWirHwos
         Ak4xYqX8GqcT+cJ59enMPa6BrL2Qzl23jYOZLgkVe+Gy/yRUtCAbtorM1X7sue5mPUaB
         Jlng==
X-Gm-Message-State: AOJu0YzCn7OzzeB3KwRkt4xVnCQl9rLd/C6j9rYlH3KNEJuXUGWfl3AP
        TqS9nU3XCAJQvW1GYEwEg7+yCLWoRFsI/zPmhx0=
X-Google-Smtp-Source: AGHT+IH632PKP0FkzO8rvfQFAe04NwMnCJLog8mBx7LAHu9FgvY4Xy5XVDAMTxm6ZDN+OMsG2rlYc1re9wNhFIJcZts=
X-Received: by 2002:a17:906:1f4d:b0:a19:a1ba:bae7 with SMTP id
 d13-20020a1709061f4d00b00a19a1babae7mr1523005ejk.141.1702389796323; Tue, 12
 Dec 2023 06:03:16 -0800 (PST)
MIME-Version: 1.0
References: <ZWnGV39HJr9uUB2/@gondor.apana.org.au> <tencent_B2D2C5864C49BDAEE0AEC1CC9627E3C6CF06@qq.com>
 <ZWpukgSDlA6UFR6e@gondor.apana.org.au> <ZWqCAsCUGN1cFIIT@gondor.apana.org.au>
In-Reply-To: <ZWqCAsCUGN1cFIIT@gondor.apana.org.au>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Tue, 12 Dec 2023 19:33:04 +0530
Message-ID: <CANc+2y6+jWNbveuBZGa-a7JoUiM++DtAYELoORTBXzt2TiEOrg@mail.gmail.com>
Subject: Re: [PATCH] hwrng: core - Fix page fault dead lock on mmap-ed hwrng
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Edward Adam Davis <eadavis@qq.com>, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        olivia@selenic.com,
        syzbot+c52ab18308964d248092@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com,
        Ian Molton <ian.molton@collabora.co.uk>,
        Rusty Russell <rusty@rustcorp.com.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Dec 2023 at 08:05, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> There is a dead-lock in the hwrng device read path.  This triggers
> when the user reads from /dev/hwrng into memory also mmap-ed from
> /dev/hwrng.  The resulting page fault triggers a recursive read
> which then dead-locks.
>
> Fix this by using a stack buffer when calling copy_to_user.
>
> Reported-by: Edward Adam Davis <eadavis@qq.com>
> Reported-by: syzbot+c52ab18308964d248092@syzkaller.appspotmail.com
> Fixes: 9996508b3353 ("hwrng: core - Replace u32 in driver API with byte array")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>
> diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
> index 420f155d251f..a3bbdd6e60fc 100644
> --- a/drivers/char/hw_random/core.c
> +++ b/drivers/char/hw_random/core.c
> @@ -23,10 +23,13 @@
>  #include <linux/sched.h>
>  #include <linux/sched/signal.h>
>  #include <linux/slab.h>
> +#include <linux/string.h>
>  #include <linux/uaccess.h>
>
>  #define RNG_MODULE_NAME                "hw_random"
>
> +#define RNG_BUFFER_SIZE (SMP_CACHE_BYTES < 32 ? 32 : SMP_CACHE_BYTES)
> +
>  static struct hwrng *current_rng;
>  /* the current rng has been explicitly chosen by user via sysfs */
>  static int cur_rng_set_by_user;
> @@ -58,7 +61,7 @@ static inline int rng_get_data(struct hwrng *rng, u8 *buffer, size_t size,
>
>  static size_t rng_buffer_size(void)
>  {
> -       return SMP_CACHE_BYTES < 32 ? 32 : SMP_CACHE_BYTES;
> +       return RNG_BUFFER_SIZE;
>  }
>
>  static void add_early_randomness(struct hwrng *rng)
> @@ -209,6 +212,7 @@ static inline int rng_get_data(struct hwrng *rng, u8 *buffer, size_t size,
>  static ssize_t rng_dev_read(struct file *filp, char __user *buf,
>                             size_t size, loff_t *offp)
>  {
> +       u8 buffer[RNG_BUFFER_SIZE];
>         ssize_t ret = 0;
>         int err = 0;
>         int bytes_read, len;
> @@ -236,34 +240,37 @@ static ssize_t rng_dev_read(struct file *filp, char __user *buf,
>                         if (bytes_read < 0) {
>                                 err = bytes_read;
>                                 goto out_unlock_reading;
> -                       }
> -                       data_avail = bytes_read;
> -               }
> -
> -               if (!data_avail) {
> -                       if (filp->f_flags & O_NONBLOCK) {
> +                       } else if (bytes_read == 0 &&
> +                                  (filp->f_flags & O_NONBLOCK)) {
>                                 err = -EAGAIN;
>                                 goto out_unlock_reading;
>                         }
> -               } else {
> -                       len = data_avail;
> +
> +                       data_avail = bytes_read;
> +               }
> +
> +               len = data_avail;
> +               if (len) {
>                         if (len > size)
>                                 len = size;
>
>                         data_avail -= len;
>
> -                       if (copy_to_user(buf + ret, rng_buffer + data_avail,
> -                                                               len)) {
> +                       memcpy(buffer, rng_buffer + data_avail, len);
> +               }
> +               mutex_unlock(&reading_mutex);
> +               put_rng(rng);
> +
> +               if (len) {
> +                       if (copy_to_user(buf + ret, buffer, len)) {
>                                 err = -EFAULT;
> -                               goto out_unlock_reading;
> +                               goto out;
>                         }
>
>                         size -= len;
>                         ret += len;
>                 }
>
> -               mutex_unlock(&reading_mutex);
> -               put_rng(rng);
>
>                 if (need_resched())
>                         schedule_timeout_interruptible(1);
> @@ -274,6 +281,7 @@ static ssize_t rng_dev_read(struct file *filp, char __user *buf,
>                 }
>         }
>  out:
> +       memzero_explicit(buffer, sizeof(buffer));
>         return ret ? : err;
>
>  out_unlock_reading:
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
>

Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>

Regards,
PrasannaKumar
