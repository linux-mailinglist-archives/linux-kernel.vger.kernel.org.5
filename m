Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE737D9DC2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjJ0QFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjJ0QE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:04:58 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4F3E5;
        Fri, 27 Oct 2023 09:04:56 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a86b6391e9so17345937b3.0;
        Fri, 27 Oct 2023 09:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698422695; x=1699027495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=cy9iUp3v6OB4PWeR1/SVWTKFReI9Zajknegp0GS6Lpc=;
        b=fr7FyipSUuc4Tsyd3jy1dKjx0qhPnaQAUd1HmZyoCms5cFMj3X18SiqQcxyYQ99z9f
         HPLRounFqvF9fxKKMWhT4AhfxuGuoj8AWWZ4CJF8RvLtnV9o07r60kw5OhJQgfN3t0t5
         QAX0VQEAsCg+aLf/mtURG79S0SAW3onEyxjoU7QhhXmRevdES/Vud5Ot9crVJuIvzZhe
         wRBRYJBbvbof81RCXlJZV3Ri7nK3tmZKXLkoaw6b2XY4h9LtULLjZyanmCulRg19KvYI
         TSUBO567RVG+rrji/f6Y1VKK43K4FeUQde7v/YVqncsRi/SHCTuuuUegEgnKLkDoGx1E
         pyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698422695; x=1699027495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cy9iUp3v6OB4PWeR1/SVWTKFReI9Zajknegp0GS6Lpc=;
        b=SoiOewXJ7T5vGRs98ncUFTT6+OwUkWi0NovOC5+bMuj+78RwrzKJ02MfvVm60mJsp+
         gTAms4ozQA1wq5HBZPtd8tPBMT1spA1hhbdpDZevOxxUf/E/fib0VvVGPng50KWlHe4p
         xo26be7r023uCp2/gr+9SJhjFHHRG+TnogHMG5E/bxlnxN2ZxlP64Vjsz+6PIxQhb8F/
         HMY6L+TcgAVTv37yQc3Z3JCX0N9tKQQFBFn1T96AZMfDaYLJo213L1pxDHen+m0p0hMb
         /p+9aTE8r4bNEV0aveBk51H7b1ti8SzScZKsZGWnFPPCHg+eskCSVS5I88/vB8UtnjSl
         K4Dw==
X-Gm-Message-State: AOJu0Yy6AD2C53AQ36bHxrbsWbKX4HCvJQfUKP0FUjLxFpVqWEaVdn0B
        BXgt9BsG8mfPiT4PTWYZZ9Y=
X-Google-Smtp-Source: AGHT+IG6R1h698jomRitOYOvER494TrCgf357KB++LKns3L48YxeH5ukAEpFGkjhKE3utqYMlGPHgA==
X-Received: by 2002:a81:c60a:0:b0:5a7:fb11:90f8 with SMTP id l10-20020a81c60a000000b005a7fb1190f8mr2858067ywi.16.1698422695469;
        Fri, 27 Oct 2023 09:04:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m137-20020a0dca8f000000b005a23a62a25csm801418ywd.9.2023.10.27.09.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 09:04:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <aae1861e-be1b-2f12-51e0-48c1a0cc603f@roeck-us.net>
Date:   Fri, 27 Oct 2023 09:04:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 1/2] regulator (max5970): Add hwmon support
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20231027152830.1269895-1-naresh.solanki@9elements.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20231027152830.1269895-1-naresh.solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/23 08:28, Naresh Solanki wrote:
> Utilize the integrated 10-bit ADC in Max5970/Max5978 to enable voltage
> and current monitoring. This feature is seamlessly integrated through
> the hwmon subsystem.
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

