Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7867F789CD2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 11:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjH0Jsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 05:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjH0Jsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 05:48:43 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEAD10D
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 02:48:40 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31aec0a1a8bso1422807f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 02:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693129719; x=1693734519;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SJNNVgrRVQL7c5pbhPjz9Gf5Pj28bPWzD3qJ9aTL+/s=;
        b=JzIlOcyLne6Uoo2jYZndhS99aWgxnSff5fBa6kvwc/CnQz5B6DeXLELiqhd7D+tOqf
         AR/ZoyMGc5CYHTUPKwWm69Z6A/IdGW3xJcWXRVHvtxp5HrfWTdraak9BiK/YmsuX7gUY
         b7z2q6qQh60Nsk/W8SzTGKa9CR4Aqdri714oDGMNyxNyvF4puSUawnmWrOfbUdR04hGn
         si0bJ64ZEKavhgn+l3VV/V8qDkLcpeHGl5wLJXT3emNQKd9Zv74Ynzp6Emh5C2UhAHhC
         drz9BQJ6je4pZenQGLharWJVEonrjSYxmKuPCSywhNtutE/U+tnxQtG4VJCSBS+g7jV4
         UyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693129719; x=1693734519;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJNNVgrRVQL7c5pbhPjz9Gf5Pj28bPWzD3qJ9aTL+/s=;
        b=KkAJvFlkJS1uIaOcnIDsId6H2Qa9HG/B0m7YuOSFq3B6UK15t0ri/1DDTsvhgZKfwP
         dWyBSbdJFG3WX+xN7ptAo0b3Ky8uTpGDR6r3PpbWGWFcj5fyUqpLs5HbJyYeDNWz03DR
         en8Em7t+0UQPOjUjVcD9NOy2/Uos2I7s+WPevuZrDK1lC5oqtWDd4UiBWXnUy8qYwwHG
         tshqb0zobvtA/o6kwlrE4bu5wInkl2M+RR+1oVFd+pTCYG+uLohplPd2Y799TdLtA8ly
         G7csYJKY91JkGa8n7Azceu3+3Lsvu7udOD/ukbSE7Y97p3CB1zzAYDBLyn7t3Ju4dTIl
         3unw==
X-Gm-Message-State: AOJu0YwmPTMIvIp0IG/tl7/uwIH9y1VoWkGAWSoS6rrXBEYVCCN3DQfA
        zbcz0J1upy5dW6CX+09QceaYXieWZzGhZDK4X1OeKw==
X-Google-Smtp-Source: AGHT+IFyYSVmg96H/v92sjJ+IDfGQO6CLmaJ2hV7K5fhbi7+XHiRFVoEDfb2YLomtTbo92BK2A9i8g==
X-Received: by 2002:a5d:4ac2:0:b0:319:70c8:6e90 with SMTP id y2-20020a5d4ac2000000b0031970c86e90mr16793479wrs.24.1693129718694;
        Sun, 27 Aug 2023 02:48:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8865:2133:756f:b886? ([2a01:e0a:982:cbb0:8865:2133:756f:b886])
        by smtp.gmail.com with ESMTPSA id b7-20020a05600c11c700b003fbb25da65bsm7343975wmi.30.2023.08.27.02.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 02:48:38 -0700 (PDT)
Message-ID: <7bf9e716-0ff2-56d5-07ab-db027901454e@linaro.org>
Date:   Sun, 27 Aug 2023 11:48:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2] Revert "tty: serial: meson: Add a earlycon for the T7
 SoC"
Content-Language: en-GB
To:     Lucas Tanure <tanure@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20230827082944.5100-1-tanure@linux.com>
From:   Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20230827082944.5100-1-tanure@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

Le 27/08/2023 à 10:29, Lucas Tanure a écrit :
> This reverts commit 6a4197f9763325043abf7690a21124a9facbf52e.
> New SoC will use ttyS0 instead of ttyAML, so T7 SoC doesn't need a OF_EARLYCON_DECLARE.
> 
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
> Since V1:
> - add Signed-off-by:
> 
>   drivers/tty/serial/meson_uart.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index c4f61d82fb727..790d910dafa5d 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -648,8 +648,6 @@ meson_serial_early_console_setup(struct earlycon_device *device, const char *opt
>   
>   OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
>   		    meson_serial_early_console_setup);
> -OF_EARLYCON_DECLARE(meson, "amlogic,t7-uart",
> -		    meson_serial_early_console_setup);
>   
>   #define MESON_SERIAL_CONSOLE_PTR(_devname) (&meson_serial_console_##_devname)
>   #else

How do you use earlycon with this removed ?

Neil
