Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4B781312C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjLNNR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjLNNR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:17:57 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E75E116
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:18:04 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6da41cd19d3so590113a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702559883; x=1703164683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cr5ba9nOwF1XP5P4qoOLZssWt5hdjlvhrL7SSQiV71k=;
        b=UiHqiWgquYoMlBeRyLfAqHt6lhnGKbNGBUOVHAAGGwCxE+28RfGPWQMSXFQZKi0eF3
         58Si16zh4NTPH008HN00Ood9cjSYqtFk+Op6DnGRXyTeoApuDcg5YYAtYsq/QrLQve8n
         EJ580h43jRXHBGJ1Fq8lrK9xo2q+L8BST7Yq1XyKnIUEQ7JiP4LlkUUBbPc6KxrmD8xz
         dIzfaLIGiPpm/EWZoXY99Or40FrS9QxE0fkFPxhUhk/AtywIZSFmzUdkGUXua3NIiNoR
         U3p2MBhdmPYkYO8TGYjxkHqDYOBmJhQiX/fOQDp7K+vNh291fSmhiFWHYWVrEA6c8+Mq
         LLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702559883; x=1703164683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cr5ba9nOwF1XP5P4qoOLZssWt5hdjlvhrL7SSQiV71k=;
        b=YlFhJG2nnkY1JzCxq0vFa8SYjtn+OLpgZBtZw5TnT+LrXOZoZww3FLzwmVPIMJIsmW
         QkR2+xhnrLrfraOB0tsFBf2sxZy4N5kgi64wmAAUd8R9hvze/YEHObQ9eVeilRuQkNSg
         XeHa/Mki3yGVOjCzsXNTLdX2EGaJ8mlW/QxbCC8TOnxILuMAgrhG7F0k55AEP4GltDW3
         ZhHqypF+jQjXAOGyhoLU0jcw+UNJ1w2NV3yvvDkK39w7gripP3hDLR3tD/l/e0Ok04VP
         UGrgTyT0YIelTj2OBV2ZrguAbeKHc/d5BRtFqe5rclLoVv3412FRgEKn+PBOs/8dptZ6
         WYsA==
X-Gm-Message-State: AOJu0Yzm1sg0mqlazPdNI4/FCkLdno7oczVzjjpYDg1w5+hLbZvAoyfa
        nZbE2fNs/Z6mtqzqZiaAkHEs3R9FS7MooiuhKcrgFw==
X-Google-Smtp-Source: AGHT+IFIu3/6KHffa58xq4ihhkFpsRjzUJQot5X6Hs6XgVOq9uzU8DBnxSxGT0KPg8Bo2vQZS7e//efICPEM4yvZfjI=
X-Received: by 2002:a9d:7f11:0:b0:6d9:a1f8:6b9a with SMTP id
 j17-20020a9d7f11000000b006d9a1f86b9amr9091324otq.47.1702559883475; Thu, 14
 Dec 2023 05:18:03 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdap4LUbMcKv_zi=25A-SZf0DJhXiyR1zn0PfuR+b=3NfA@mail.gmail.com>
 <20231213143954.2541-1-chenguanxi11234@163.com>
In-Reply-To: <20231213143954.2541-1-chenguanxi11234@163.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Dec 2023 14:17:51 +0100
Message-ID: <CACRpkdb-pARMSCe_kugLOFriSrwuQVXJ3L+6TnsnmDNedowDRw@mail.gmail.com>
Subject: Re: [PATCH linux-next] ARM/dma-mapping: replace kzalloc() and
 vzalloc() with kvzalloc()
To:     chenguanxi11234@163.com
Cc:     arnd@arndb.de, cgel.zte@gmail.com, chen.haonan2@zte.com.cn,
        gregkh@linuxfoundation.org, jgg@ziepe.ca, jiang.xuexin@zte.com.cn,
        jroedel@suse.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        rmk+kernel@armlinux.org.uk, rppt@kernel.org, willy@infradead.org,
        yang.guang5@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 3:41=E2=80=AFPM <chenguanxi11234@163.com> wrote:

> >Looks good to me:
> >Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >Please put this patch into Russell's patch tracker.
>
> Hello, I would like to ask, do you mean to have
> me CC the patch email to Russell?I don't really
> understand what patch tracker means.Thank you.

This is Russell's patch tracker:
https://www.armlinux.org.uk/developer/patches/

Create an account, read the help text, you can submit patches
using a web interface or through mail.

Yours,
Linus Walleij
