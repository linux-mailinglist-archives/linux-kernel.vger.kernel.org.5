Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A168767F75
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 15:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjG2Nmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 09:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjG2Nmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 09:42:52 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA389CA;
        Sat, 29 Jul 2023 06:42:50 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-997c4107d62so421043366b.0;
        Sat, 29 Jul 2023 06:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690638169; x=1691242969;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u4ZkdZcNSkn4KYrs0rpO5END+0pEqIEjvI/iJp6BL4Y=;
        b=PZheVjVHjG6uP7ztujdA46LOGBJMfGFJeFemOKtOTulyYvSdFTyKQ7hPCoJtHy7B1L
         iAs5u6PTSK51u8UkWr0DYW0hOJLgjMXohKC8cVqKlDUh+eUMHLR2dwY5hDhgpM/xZpdV
         2nKN6kwoG/UIilNP5uCmOuV79YETq6nJXT9REyQmojigpxJsux37UR3dnxJmeL+YjSO6
         5LpOUVCceG6u8U0WhfOHdA9/dDqEoAUYvLFdghQWJqsZUpL25o8/nmin8tsfesb9CHvY
         W6+0jBJsMm75e2yqx35K4r8QqH1oDVzu6U5NZnIh4v0mi1CLMQq5d+UvM26T6ZcDZPgL
         IsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690638169; x=1691242969;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u4ZkdZcNSkn4KYrs0rpO5END+0pEqIEjvI/iJp6BL4Y=;
        b=IPWOSDh7j9If87v5U198nC30nN2oyB+754bwEVB1MLowST74D2N7u5nVQ0uDCrer26
         50bEsbqvwVVcECDLY+K62ojdixMeHUCuWwGygkojImV5rv8ua9214q5t5cx0sfO8mDX4
         /7wWwTHpY3nncybY0zLcw74JIBd/Yrx43J/I4QlxTIKDbKpx0q3CF4uE3v1Q/3Pz0ay9
         ROvF+jaQ0skRyFYo3qsbL+8WzmU+orVfwm08g1ECCi0wc+ikv+2tu7ITvik7NGBSqRgf
         J4NhFNm/4ryJEekXTIrfPAYXCugMiMZilhIuGir56PE2Krx3pgWsbLdfYsdlgSTnwdZe
         B0jA==
X-Gm-Message-State: ABy/qLa3v+PZe3kH4evPJJqlmd4lWGJ2VGybNeOQDY0DQWDSjSbpTCKa
        CRaw01awi3xBLHsF7Nq54GfhxuP3m9+irw==
X-Google-Smtp-Source: APBJJlHLwiRvjJCDb8fQ+dClwxLzUqp98D1KV1rfOmk2xUrRMRKQvwJHG3Q3nOQ/iIL+gUCtLLeibw==
X-Received: by 2002:a17:906:64cc:b0:993:eef2:5d5d with SMTP id p12-20020a17090664cc00b00993eef25d5dmr2315998ejn.27.1690638168884;
        Sat, 29 Jul 2023 06:42:48 -0700 (PDT)
Received: from [192.168.0.28] (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id ci18-20020a170906c35200b0099bd682f317sm3264875ejb.206.2023.07.29.06.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jul 2023 06:42:48 -0700 (PDT)
Message-ID: <d7ea15aa-5348-3fd0-b399-ec03af438c85@gmail.com>
Date:   Sat, 29 Jul 2023 15:42:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     savicaleksa83@gmail.com, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (aquacomputer_d5next) Add selective 200ms delay
 after sending ctrl report
Content-Language: en-US
To:     linux-hwmon@vger.kernel.org
References: <20230729133112.462023-1-savicaleksa83@gmail.com>
From:   Aleksa Savic <savicaleksa83@gmail.com>
In-Reply-To: <20230729133112.462023-1-savicaleksa83@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-29 15:31:12 GMT+02:00, Aleksa Savic wrote:
> Add a 200ms delay after sending a ctrl report to Quadro,
> Octo, D5 Next and Aquaero to give them enough time to
> process the request and save the data to memory. Otherwise,
> under heavier userspace loads where multiple sysfs entries
> are usually set in quick succession, a new ctrl report could
> be requested from the device while it's still processing the
> previous one and fail with -EPIPE.
> 
> Reported by a user on Github [1] and tested by both of us.
> 
> [1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/issues/82
> 
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
> ---
> Changes in v2:
> - Added missing <linux/delay.h> include
> ---
Sorry for the noise, I didn't include the Cc: stable@vger.kernel.org
line from v1 in v2. Do I need to resend?

Thanks in advance,
Aleksa
