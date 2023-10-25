Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3527D6C74
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344192AbjJYM4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbjJYM4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:56:49 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512C7A4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 05:56:47 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40891d38e3fso29651495e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 05:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698238606; x=1698843406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KRrPxKdD6N+/g+2dK+wqANRJEo4EPu/UcvP8mlbKOo4=;
        b=MKfqzwsr2Cp1oBs2Sx6Qv5JjuOCY7M/sw1lynmYkEdj82lrMOXyCUgFWnjwLZ/oYq/
         6GxNhUjLgpmDW/vS1K55ZNj92J5anOcVoLnwq3eQphtn1Nfnc0/iAtpOFlRDjoJFtmnK
         QJ6Ibkt8NKbn+awjeWnYwI+RxWf1YG5jBZqohVly/eTiSVax8wVeq1kcydUTaDazX2Vy
         pIh6B9tMaoB6xfdWF1i2shRKFeF6Y+7ESMriKWmuiz4FVmvi331I7zVWZWyRa6Ypii6g
         6LQFIRJFxJvzxsCbEELnB03YivWIF9KWZyAOQ18JUuaWzhNQDUNypX+fb6Z46SOKL8PH
         vANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698238606; x=1698843406;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KRrPxKdD6N+/g+2dK+wqANRJEo4EPu/UcvP8mlbKOo4=;
        b=EAV1b24Srwgfr44rEyFUBuIafwdiWqOr9E8rmmTX1QoMGqPdm/GIEhMn8IQqc9tfXY
         9SCaGfsbJSDW0VMO44uMZUbwXvLVfgJnhTAFVVn9uVvNcn/e1jzhOP9KPVHGnwh/7Mh2
         t8EtQMe0tPxOMzyIbdXDYTBWdzQjIRghVGEmez/iKHxWSEdpjttba1VYnO6dYp5FiiDx
         oZrwGIvypLTfdCC5ZyizZkoQvhg7SVivu42yZJ9tMZHjoLTYxaqo6l67VbQWsBxeioK1
         PbaBY/B84xOZksWAXphhScD/QkNtUzi/+Te0JVu1d8yBsYgTIEFDhKnL0zX8vdtEVjjZ
         x+aQ==
X-Gm-Message-State: AOJu0YxyXdMWnjGAwTWg6RdX6Z64CwuFBHR8TuxM7J/GbNAoGXUz3alR
        V12PuxleC6nVYq3+W4KWlOzxLf8CfrPHwc4voJE=
X-Google-Smtp-Source: AGHT+IHzPdQ6td1akWxo15vd0IEPgEJRWfrOUs/FWRsXXjrFRGmb5+OUJo9VVf0HY9ruwmtW7l1fmg==
X-Received: by 2002:a05:600c:34d0:b0:408:3f87:cba with SMTP id d16-20020a05600c34d000b004083f870cbamr10993678wmq.39.1698238605703;
        Wed, 25 Oct 2023 05:56:45 -0700 (PDT)
Received: from [192.168.69.115] (ghy59-h01-176-171-219-76.dsl.sta.abo.bbox.fr. [176.171.219.76])
        by smtp.gmail.com with ESMTPSA id fm15-20020a05600c0c0f00b004090ca6d785sm4439257wmb.2.2023.10.25.05.56.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 05:56:45 -0700 (PDT)
Message-ID: <ee2fa120-a5de-37c9-19c2-91ea84c0d584@linaro.org>
Date:   Wed, 25 Oct 2023 14:56:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] vgacon: fix mips/sibyte build regression
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Khalid Aziz <khalid@gonehiking.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231024054412.2291220-1-arnd@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231024054412.2291220-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/23 07:44, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The conversion to vgacon_register_screen() was missing an #include statement
> for the swarm board:
> 
> arch/mips/sibyte/swarm/setup.c:146:9: error: implicit declaration of function 'vgacon_register_screen' [-Werror=implicit-function-declaration]
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310240429.UqeQ2Cpr-lkp@intel.com/
> Fixes: 555624c0d10b vgacon: clean up global screen_info instances
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/mips/sibyte/swarm/setup.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

