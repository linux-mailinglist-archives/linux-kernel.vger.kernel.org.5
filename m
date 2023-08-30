Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBC678E1A1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242837AbjH3Vwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242811AbjH3Vwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:52:32 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07316E6B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:52:02 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31768ce2e81so39779f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693432259; x=1694037059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XFgqEWtVuYdRSUZpjBvrGjrECLnZnCx4HSWx8oAmcF4=;
        b=Qx2drvD7DdYL8AaaH8t9syWQlSFKVskJez14UDOBfhjLR3eMcv2sd/EoQ98rWF2Hix
         K2dG+nPsia/Ctvg4K6HNKWDho2eV5ceQIpVGUGCKASFl5VN2yeE9Q73hE9NBqJttjEJG
         aAoe2UDPtns/jAi48NES45yanqwWUL+4F9b3FlsblVU6birPWyeV/61RzCDx+1Zg/QZ4
         dEB/uLmUpoQXCng8tBc2BwII/yMqTekJK13wt3oBf+LRHKtYS3InUZ8Eh28KgOcwhJhU
         u5/v3YVh7MKI5z4OhsXirbdxAZ+B9J8xcbY0UpyxQay15zfJmG/9NgPkMELT67bPk4HC
         hBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693432259; x=1694037059;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XFgqEWtVuYdRSUZpjBvrGjrECLnZnCx4HSWx8oAmcF4=;
        b=gC1knuKATj6VpOA/+bsMLN8NmuYbznoogdSiyBZPGPvYAbHCO42Iv2T3aMj6CBqLDl
         F0BgXJb9uSknwskgBpn5+FO8i6wAq23z7u2rwJx2wLCy+E0vnzuoPh4ew3omA4q9Pdw8
         9mjWqV7em1whSa6S+mkgtDdqL0D+4fhl74a1nhjLQrxObuoQe0AcI4pxpH4nzTsT/32X
         H/AqDGFYXtYBvpLdOYeIaR0t+D3Pn89BuCdtsPZA/z9yHqjLcrOrNHOlW5xzK0gjOvwp
         ydpXTON4drpPLzJ0iwX7/SYPUbtvV/pJoD6b8I3GMdkD9o4fOQ765YZBHOS0z6yHG8ar
         MqAQ==
X-Gm-Message-State: AOJu0YzWWhe05UVGQmc2bu1UwoabEDnpfqtFYD4FYHnAI6XYuTojgYs+
        yBcbj9ZPMkFTDRzDORpcSGhXepROYd9JmmF0fb4q/hWY
X-Google-Smtp-Source: AGHT+IG21XBSa1NpHpt7D+LPwmJ7vTfz0uF1Uy6n+9CUCNidaI4H0QF7ZDd2THIXqsoHVG3zSka6Mw==
X-Received: by 2002:a1c:7704:0:b0:401:daf2:2735 with SMTP id t4-20020a1c7704000000b00401daf22735mr2467982wmi.31.1693429884760;
        Wed, 30 Aug 2023 14:11:24 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.89])
        by smtp.gmail.com with ESMTPSA id w12-20020a5d4b4c000000b0031416362e23sm17719142wrs.3.2023.08.30.14.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 14:11:24 -0700 (PDT)
Message-ID: <34466e53-9cab-4094-7a9e-ae1f65385194@linaro.org>
Date:   Wed, 30 Aug 2023 23:11:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3] MIPS: loongson32: Remove dma.h and nand.h
Content-Language: en-US
To:     Keguang Zhang <keguang.zhang@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
References: <20230830133505.505597-1-keguang.zhang@gmail.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230830133505.505597-1-keguang.zhang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/8/23 15:35, Keguang Zhang wrote:
> Since commit 7b3415f581c7 ("MIPS: Loongson32: Remove
> unused platform devices"), struct plat_ls1x_dma and plat_ls1x_nand
> are unused. Then, dma.h and nand.h are useless.
> Therefore, remove these useless header files.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> V2 -> V3: Fix the build error
>            Add Reviewed-by tag from Philippe Mathieu-Daudé
> V1 -> V2: Remove include of dma.h and nand.h
>            Update the commit message
> ---
>   arch/mips/include/asm/mach-loongson32/dma.h   | 21 ---------------
>   arch/mips/include/asm/mach-loongson32/nand.h  | 26 -------------------
>   .../include/asm/mach-loongson32/platform.h    |  3 ---
>   arch/mips/loongson32/common/platform.c        |  2 --
>   arch/mips/loongson32/ls1b/board.c             |  2 --
>   5 files changed, 54 deletions(-)
>   delete mode 100644 arch/mips/include/asm/mach-loongson32/dma.h
>   delete mode 100644 arch/mips/include/asm/mach-loongson32/nand.h


> diff --git a/arch/mips/include/asm/mach-loongson32/platform.h b/arch/mips/include/asm/mach-loongson32/platform.h
> index 2cdcfb5f6012..f74292b13bc3 100644
> --- a/arch/mips/include/asm/mach-loongson32/platform.h
> +++ b/arch/mips/include/asm/mach-loongson32/platform.h
> @@ -8,9 +8,6 @@
>   
>   #include <linux/platform_device.h>
>   
> -#include <dma.h>
> -#include <nand.h>

Doh I missed that one in v2 :/

Thanks, R-b stands.
