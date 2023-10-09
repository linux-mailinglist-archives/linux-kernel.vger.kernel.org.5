Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996FD7BD2D3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 07:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345112AbjJIFeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 01:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345049AbjJIFes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 01:34:48 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93AF9E
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 22:34:45 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-45269fe9d6bso1808606137.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 22:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696829685; x=1697434485; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z0qIh7N601V8ZDv+VU22d/EvZslgLn6R5kTfS7DGg8Q=;
        b=YY3K/G41DVkgPimg02ZHCJS1V+OLuM7hX534o8baS+GS0mlM9B1b74Mf9hZ00XzVlK
         Ak4BjDs4ATfgkDs+SzY+fgBIFktGid/GvYk2hQr/2ZB4aH6FDYC45Rz7KAJXseSy2C6j
         WC7XAWl30fU7Ww1aZzAuVYjc/ctUcjxh21paRYt8v2oFXIWMNppshESVe0X/5cKwB0n/
         CaVEoekL2P91gO/ROm/wUaa3agOjA24hmgxcmVHNFkSFKc3fqK3P8RwZHcj21AydAaSI
         z/NptfmwXRNzMn23SpKj/ihwJt+/iDVF/hduDs5FsaAJx0CPGfwDvvWqY3Vmwvau0O0M
         zp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696829685; x=1697434485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0qIh7N601V8ZDv+VU22d/EvZslgLn6R5kTfS7DGg8Q=;
        b=ut8REz2+U9qkoPyot6c92f09V/jornGkT8niRY0Czq+TBaINNXjISd0qeC0aZX0kYN
         TL8r0hkc9juTArVDcEE7wA0ADY2BQU/teJT9gFPoxyawlcRLmcCIkwh/3ROB6LdbM1e9
         O4iM5ln1LUpQPyjpywUtS3+gpZAVfrSQFudIal1/kLya0/TPqWzctmbzIZE3ZkGB3GPL
         7aLN2n4UnwlJ2yeZ5PF/Vb47AoY9gNmCO8UQ/0s6ryTbL7DBgsrFLg+Q4fZKXxW+BWTc
         3Pv8mGX24VaGGV899oR8aEmL7EJ2f8oYlG/mOV/A9Pde6Aaa6YWly5veY2si/8fxlj2u
         LZnQ==
X-Gm-Message-State: AOJu0YyUs8a32sPVQHtelrEfU+zkcH/lmQpAk1inLVcq6Jck7L3sVpAl
        /45naJcvEzesW2iny7q1rOifBeYWAT3Z66bszYYIiQ==
X-Google-Smtp-Source: AGHT+IG1I9qkvp0Xl76fa7iKyNOnNPP8qt7dy0JbBgVpSFnmCX9TWCcomF/W5vlYe0F8xbyRLHNX3TgWVR3LB9j5kdE=
X-Received: by 2002:a67:efc6:0:b0:44d:5a92:ec43 with SMTP id
 s6-20020a67efc6000000b0044d5a92ec43mr12955216vsp.24.1696829684930; Sun, 08
 Oct 2023 22:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <2023100613-lustiness-affiliate-7dcb@gregkh>
In-Reply-To: <2023100613-lustiness-affiliate-7dcb@gregkh>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 9 Oct 2023 11:04:33 +0530
Message-ID: <CAFA6WYNbMsEE7OF0SpLN5gQx5-TNPXD7Zm+2tVu21xdpzKU=Xg@mail.gmail.com>
Subject: Re: [PATCH] tee: make tee_class constant
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2023 at 19:30, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Now that the driver core allows for struct class to be in read-only
> memory, we should make all 'class' structures declared at build time
> placing them into read-only memory, instead of having to be dynamically
> allocated at runtime.
>
> Cc: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tee/tee_core.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>

Apart from nit below, feel free to add:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 0eb342de0b00..5ddfd5d9ac7f 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -40,7 +40,10 @@ static const uuid_t tee_client_uuid_ns = UUID_INIT(0x58ac9ca0, 0x2086, 0x4683,
>  static DECLARE_BITMAP(dev_mask, TEE_NUM_DEVICES);
>  static DEFINE_SPINLOCK(driver_lock);
>
> -static struct class *tee_class;
> +static const struct class tee_class = {
> +       .name = "tee",
> +};
> +
>  static dev_t tee_devt;
>
>  struct tee_context *teedev_open(struct tee_device *teedev)
> @@ -919,7 +922,7 @@ struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
>                  teedesc->flags & TEE_DESC_PRIVILEGED ? "priv" : "",
>                  teedev->id - offs);
>
> -       teedev->dev.class = tee_class;
> +       teedev->dev.class = &tee_class;
>         teedev->dev.release = tee_release_device;
>         teedev->dev.parent = dev;
>
> @@ -1112,7 +1115,7 @@ tee_client_open_context(struct tee_context *start,
>                 dev = &start->teedev->dev;
>
>         do {
> -               dev = class_find_device(tee_class, dev, &match_data, match_dev);
> +               dev = class_find_device(&tee_class, dev, &match_data, match_dev);
>                 if (!dev) {
>                         ctx = ERR_PTR(-ENOENT);
>                         break;
> @@ -1226,10 +1229,10 @@ static int __init tee_init(void)
>  {
>         int rc;
>
> -       tee_class = class_create("tee");
> -       if (IS_ERR(tee_class)) {
> +       rc = class_register(&tee_class);
> +       if (rc) {
>                 pr_err("couldn't create class\n");

nit: this error message should be updated as well.

-Sumit

> -               return PTR_ERR(tee_class);
> +               return rc;
>         }
>
>         rc = alloc_chrdev_region(&tee_devt, 0, TEE_NUM_DEVICES, "tee");
> @@ -1249,8 +1252,7 @@ static int __init tee_init(void)
>  out_unreg_chrdev:
>         unregister_chrdev_region(tee_devt, TEE_NUM_DEVICES);
>  out_unreg_class:
> -       class_destroy(tee_class);
> -       tee_class = NULL;
> +       class_unregister(&tee_class);
>
>         return rc;
>  }
> @@ -1259,8 +1261,7 @@ static void __exit tee_exit(void)
>  {
>         bus_unregister(&tee_bus_type);
>         unregister_chrdev_region(tee_devt, TEE_NUM_DEVICES);
> -       class_destroy(tee_class);
> -       tee_class = NULL;
> +       class_unregister(&tee_class);
>  }
>
>  subsys_initcall(tee_init);
> --
> 2.42.0
>
