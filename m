Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF3C79A343
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 08:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjIKGEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 02:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjIKGEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 02:04:50 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973E4125
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 23:04:20 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so68542181fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 23:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1694412241; x=1695017041; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2KvbN0xSe+fQMEJJmG0O5jJh3sXJf6he+0T08Dj3Uwg=;
        b=It83mQmHBBfN54tvvstTPucTMbcP2NCNQPs+Zm3PTQHix9IYbR6kYvLsrkoK5oQWim
         0vcGOH4VlnFA7oRwses47IwMuKQFEx3Qof9EGqiOTn9Z1sD75CtEx9sfw0naltvpoKHA
         RiPYfq0Y4/w/O/D17b6tqOsdiFCgpSaZw0DmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694412241; x=1695017041;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2KvbN0xSe+fQMEJJmG0O5jJh3sXJf6he+0T08Dj3Uwg=;
        b=FeIv6GvPsek9bv1ZIer5F2BR2c+spUhRSvhAafp8eCQK/aCknsv07zDnVg2imGBi8T
         skPZmokmMoBppDXi11tHG4vi0Vw/irbYv+dvkrAWXGgohQb8QljiMeuezeXqUFUz7soe
         rfaqj1Pq00oN/hsNjVba+1S+mDGTlWUXTcv1cBus5iIPb4Q7fDQsVG3Hh78zpNlW6RIc
         QxIV48C3IL3xv1CJmAay6dgYy+5G16zM5SJeymdG36VYd+FqDTNbRQ0j5y3DgjBj0mZI
         E59CAZWM1HLCSX47XBVEYq0rug5i0N001lSsgcqNpVFQUCD9iGGXWXIsWP7xpZpmsZtT
         u2Ug==
X-Gm-Message-State: AOJu0Yxlj6u6uGYkuJMalGixSYGzREljczIRHlbR52+nwZfuV0nZcCam
        uH1f8VbHsr20SoMm6Wy51xa+ougJxKTokrjTBBY=
X-Google-Smtp-Source: AGHT+IFQo70GTMiCO9GWSsbmqaS2t4srbGdKr3cj5fBI8BpHo5fhos0Zh07NMm8+NZXdwDaDhTsNtQF7EVvXcpaKaeQ=
X-Received: by 2002:a2e:8017:0:b0:2bc:de11:453b with SMTP id
 j23-20020a2e8017000000b002bcde11453bmr7406614ljg.1.1694412241069; Sun, 10 Sep
 2023 23:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230907221016.2978802-1-ninad@linux.ibm.com> <20230907221016.2978802-2-ninad@linux.ibm.com>
In-Reply-To: <20230907221016.2978802-2-ninad@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 11 Sep 2023 06:03:49 +0000
Message-ID: <CACPK8Xd_pjt5Ok5CR_oKNBjWiuYMWKq8ByV_ounREL3PGKf3Hw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] fsi: sbefifo: Remove write's max command length
To:     Ninad Palsule <ninad@linux.ibm.com>
Cc:     jk@ozlabs.org, alistair@popple.id.au, eajames@linux.ibm.com,
        linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sept 2023 at 22:10, Ninad Palsule <ninad@linux.ibm.com> wrote:
>
> This commit removes max command length check in the user write path.
> This is required to support images larger than 1MB. This should not
> create any issues as read path does not have this check either.
>
> As per the original design cronus server was suppose to break up the
> image into 1MB pieces but it requires restructuring of the driver.

When you say "driver" you mean the kernel driver, or userspace?

This isn't a great justification for removing a bounds check.

> Today driver sends EOT message on each write request so we will have to
> send it only after all pieces are sent which requires large change hence
> we decided to remove this check.

This paragraph could be clearer. Could you try rephrasing?

Assuming we want to make this change, what is the expected maximum
transfer? Could we instead make the check be that value (3MB?).

>
> Testing:
>   Loaded 3 MB image through cronus server.
>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  drivers/fsi/fsi-sbefifo.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
> index 9912b7a6a4b9..b771dff27f7f 100644
> --- a/drivers/fsi/fsi-sbefifo.c
> +++ b/drivers/fsi/fsi-sbefifo.c
> @@ -113,7 +113,6 @@ enum sbe_state
>  #define SBEFIFO_TIMEOUT_IN_RSP         1000
>
>  /* Other constants */
> -#define SBEFIFO_MAX_USER_CMD_LEN       (0x100000 + PAGE_SIZE)
>  #define SBEFIFO_RESET_MAGIC            0x52534554 /* "RSET" */
>
>  struct sbefifo {
> @@ -870,8 +869,6 @@ static ssize_t sbefifo_user_write(struct file *file, const char __user *buf,
>         if (!user)
>                 return -EINVAL;
>         sbefifo = user->sbefifo;
> -       if (len > SBEFIFO_MAX_USER_CMD_LEN)
> -               return -EINVAL;
>         if (len & 3)
>                 return -EINVAL;
>
> --
> 2.39.2
>
