Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FAA7A1B35
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjIOJui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjIOJue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:50:34 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5B03AB7;
        Fri, 15 Sep 2023 02:49:05 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c3d6d88231so16519175ad.0;
        Fri, 15 Sep 2023 02:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694771343; x=1695376143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/TVQJoENhu00vx5rI/GikJKd4kuvFkeP8vi3vVfEcfo=;
        b=aym6NrPvVQ8Sm+0tt8v2wWjHOuxq34mWO/MH9zvIWrBmb43xTjfjMe+DriZsj2t1Eo
         5e93AmlnOQu5OAWuWDAYS/TQvKJmMp6U5+fc57LUgWk+uV8xILolSnPg6Zkt0CFfGFCa
         VnIRe1G3xEiniJueRFvXZq4XZ90dWbQNjeGfRLEt13EPTtzaVEmnr41gzj3sIyIDiQgU
         mfLDJzFUMvKOjzaHzdQMQhItpRo4w035ajIE0Rn5UCrVZfB+8LcnXbgfDBBVJOYFyeZt
         3XFcDZNKTCC4H5fFR3O/szUhBeiGWY/zBcqvd3PeTVgQ6Ks64+XpFWNfkbK/N7FSMZag
         ObCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694771343; x=1695376143;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/TVQJoENhu00vx5rI/GikJKd4kuvFkeP8vi3vVfEcfo=;
        b=C8R1VSEJVAzKEWwk50aw8F0gGxmGkpg94JEgYK24GEOFrOriRnTXBHtEQVvqmZ3Nox
         pb5eCWj8fTL3Ek595KlPzxGx5hAzxowtf3tWtMQjgG0VhpVPBVPOmtRfWBy9QRw8J7DI
         d4Jq+nRvoF8o8nNOQK/W5909w2Lp1Tzc4D6TsGQghFY/U7bFvq0OASCkwAyGxMSZYGFr
         ULSlPc+qwtUa610A58R0SL87UPAtH0unkm3EkBakl/GcHOojxqf4EAm4qWeFFZkwSRuY
         RDM+uKBGkY3Ae5jbZpnkCkJQsLFxXlMp3XcWsrF5mVXWvoxRgY6H/Gzh1XqBNG9XqtUf
         tlAw==
X-Gm-Message-State: AOJu0Yyw8oYmSjjY4FjBe4kCnXDyUvWPtXis66ep6I7lA0BYE+e5RAGt
        JjBlhV3f+ckMqnW7rWRkddE=
X-Google-Smtp-Source: AGHT+IFKZZ7G1kbjDLssD1PYTqUJNDMyGB0g5aLVlwvvAL1wsMt77xEH5dArwfKSWKapUwbINpHEvg==
X-Received: by 2002:a17:902:e9d5:b0:1c1:f1db:e86d with SMTP id 21-20020a170902e9d500b001c1f1dbe86dmr880494plk.7.1694771343330;
        Fri, 15 Sep 2023 02:49:03 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c20c00b001b8c6662094sm3062686pll.188.2023.09.15.02.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 02:49:02 -0700 (PDT)
Message-ID: <d4e74e31-246c-1f8c-1465-b0bb6ce8454c@gmail.com>
Date:   Fri, 15 Sep 2023 17:49:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] tty: serial: ma35d1_serial: Add missing check for ioremap
To:     Chen Ni <nichen@iscas.ac.cn>, ychuang3@nuvoton.com,
        schung@nuvoton.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20230915071106.3347-1-nichen@iscas.ac.cn>
Content-Language: en-US
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <20230915071106.3347-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/15 下午 03:11, Chen Ni wrote:
> CAUTION - External Email: Do not click links or open attachments unless you acknowledge the sender and content.
>
>
> Add check for ioremap() and return the error if it fails in order to
> guarantee the success of ioremap().
>
> Fixes: 930cbf92db01 ("tty: serial: Add Nuvoton ma35d1 serial driver support")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>   drivers/tty/serial/ma35d1_serial.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
> index 465b1def9e11..4a9d1252de35 100644
> --- a/drivers/tty/serial/ma35d1_serial.c
> +++ b/drivers/tty/serial/ma35d1_serial.c
> @@ -695,6 +695,9 @@ static int ma35d1serial_probe(struct platform_device *pdev)
>
>          up->port.iobase = res_mem->start;
>          up->port.membase = ioremap(up->port.iobase, MA35_UART_REG_SIZE);
> +       if (!up->port.membase)
> +               return -ENOMEM;
> +
>          up->port.ops = &ma35d1serial_ops;
>
>          spin_lock_init(&up->port.lock);
> --
> 2.25.1
>

Thank you for this update.

Acked-by: Jacky Huang <ychuang3@nuvoton.com>


Best Regards,
Jacky

