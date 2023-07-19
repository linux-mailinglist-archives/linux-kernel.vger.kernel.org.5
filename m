Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE9B75946F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjGSLkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjGSLkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:40:08 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EBF1BE4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:39:47 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbc59de009so62804725e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689766784; x=1692358784;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6xWrGmvyahmWXOp2W9pMTWNvuWztCli0WIWaglYWzcA=;
        b=fF2COW0XDHf/EtUsGPj3UP3etaBQZw+DItUT2xU6WMark4A2NV28kW4nWFjK6+/tHN
         rU3okyBv0cp+PRZIs1xnIPiD/OzTYYP7p8zyXNmG3U0Kh/NGpDV32jO8fy5FU1gE9hsa
         tdhc3Z5BMKewIk7p59VPM3aZMEdTp41RXrgeMOr9I8Bx0B9N8iafg5MOlN98IU3vFbIm
         Sf0knfkylwbbpPrykX76hhTcNCwoCQjtAYkzPOXBzU9AoxJBHDqFVaNxyM9OUXaK10iG
         m/108/WTXmTRAMxMaCfCK0g/uR1WfIy2quqzRRBS3lBi2I3XXiHW4aLWEYUERfHPGovP
         ce9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689766784; x=1692358784;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6xWrGmvyahmWXOp2W9pMTWNvuWztCli0WIWaglYWzcA=;
        b=DEKMRwL37Y35n1cYfo40ha07Pk82xD7egQucP4gWx3lNoxqW4ZXuMePZfQymQieIhT
         BtOUcWnN9K6W9Pj44j0d87PlmOXb079dafLOr77eWHjHlsBMJLpINGncUFv0ndO9q0d7
         5QK74049TCc23TJkYE4EUzhjvdAbFw4B+5O1dF/bxBMzylrMxnwVglPNgqxxZyhVox9F
         nCJgS9U53EQEoSJY/si5C6ISv537wATmLHC9vJJqGEkrXKKDSDOLHM1BQPeq6ijrQDa/
         enUPFKlLwc/yzFExVUD6LoOJntH0C8aZ5w3TSE7D1LZGwWrMKthsGObVdNK3i1igCH94
         JX/w==
X-Gm-Message-State: ABy/qLaKhMlTvgGzjDlh/3iKfoDKrzCHSJGdJug55UOrFcT48Js7yBm5
        wSTf9XjFpxFNWstrs9IkX/JpgE4T0IN7cxuAHMAA6A==
X-Google-Smtp-Source: APBJJlFOjB3e9p51PfRvlx+FZqJg8p2IkxuTKJB/Mfx+7qa0F12H2nheFss7zG4r5BQfDeuua0/5Ow==
X-Received: by 2002:a05:600c:2315:b0:3fb:e189:3532 with SMTP id 21-20020a05600c231500b003fbe1893532mr1688194wmo.20.1689766784311;
        Wed, 19 Jul 2023 04:39:44 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.201.220])
        by smtp.gmail.com with ESMTPSA id u6-20020a05600c00c600b003fbb5142c4bsm1518012wmm.18.2023.07.19.04.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 04:39:44 -0700 (PDT)
Message-ID: <ef4b3c72-1676-fc73-9eb6-5ea6539d8876@linaro.org>
Date:   Wed, 19 Jul 2023 13:39:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] MIPS: Loongson64: Fix more __iomem attributes
Content-Language: en-US
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, chenhuacai@kernel.org,
        kernel test robot <lkp@intel.com>
References: <20230718134411.2871477-1-jiaxun.yang@flygoat.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230718134411.2871477-1-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/7/23 15:44, Jiaxun Yang wrote:
> There are some __iomem type casting being missed in previous patch.
> Fix them here.
> 
> Fixes: 5bd3990723bd ("MIPS: Loongson64: Prefix ipi register address pointers with __iomem")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307020639.QCZOKp8B-lkp@intel.com/
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   arch/mips/loongson64/smp.c | 168 ++++++++++++++++++-------------------
>   1 file changed, 84 insertions(+), 84 deletions(-)


>   static void ipi_mailbox_buf_init(void)
>   {
> -	ipi_mailbox_buf[0] = (void *)
> +	ipi_mailbox_buf[0] = (void __iomem *)
>   		(SMP_CORE_GROUP0_BASE + SMP_CORE0_OFFSET + BUF);
> -	ipi_mailbox_buf[1] = (void *)
> +	ipi_mailbox_buf[1] = (void __iomem *)
>   		(SMP_CORE_GROUP0_BASE + SMP_CORE1_OFFSET + BUF);
> -	ipi_mailbox_buf[2] = (void *)
> +	ipi_mailbox_buf[2] = (void __iomem *)
>   		(SMP_CORE_GROUP0_BASE + SMP_CORE2_OFFSET + BUF);
> -	ipi_mailbox_buf[3] = (void *)
> +	ipi_mailbox_buf[3] = (void __iomem *)
>   		(SMP_CORE_GROUP0_BASE + SMP_CORE3_OFFSET + BUF);
> -	ipi_mailbox_buf[4] = (void *)
> +	ipi_mailbox_buf[4] = (void __iomem *)
>   		(SMP_CORE_GROUP1_BASE + SMP_CORE0_OFFSET + BUF);
> -	ipi_mailbox_buf[5] = (void *)
> +	ipi_mailbox_buf[5] = (void __iomem *)
>   		(SMP_CORE_GROUP1_BASE + SMP_CORE1_OFFSET + BUF);
> -	ipi_mailbox_buf[6] = (void *)
> +	ipi_mailbox_buf[6] = (void __iomem *)
>   		(SMP_CORE_GROUP1_BASE + SMP_CORE2_OFFSET + BUF);
> -	ipi_mailbox_buf[7] = (void *)
> +	ipi_mailbox_buf[7] = (void __iomem *)
>   		(SMP_CORE_GROUP1_BASE + SMP_CORE3_OFFSET + BUF);
> -	ipi_mailbox_buf[8] = (void *)
> +	ipi_mailbox_buf[8] = (void __iomem *)
>   		(SMP_CORE_GROUP2_BASE + SMP_CORE0_OFFSET + BUF);
> -	ipi_mailbox_buf[9] = (void *)
> +	ipi_mailbox_buf[9] = (void __iomem *)
>   		(SMP_CORE_GROUP2_BASE + SMP_CORE1_OFFSET + BUF);
> -	ipi_mailbox_buf[10] = (void *)
> +	ipi_mailbox_buf[10] = (void __iomem *)
>   		(SMP_CORE_GROUP2_BASE + SMP_CORE2_OFFSET + BUF);
> -	ipi_mailbox_buf[11] = (void *)
> +	ipi_mailbox_buf[11] = (void __iomem *)
>   		(SMP_CORE_GROUP2_BASE + SMP_CORE3_OFFSET + BUF);
> -	ipi_mailbox_buf[12] = (void *)
> +	ipi_mailbox_buf[12] = (void __iomem *)
>   		(SMP_CORE_GROUP3_BASE + SMP_CORE0_OFFSET + BUF);
> -	ipi_mailbox_buf[13] = (void *)
> +	ipi_mailbox_buf[13] = (void __iomem *)
>   		(SMP_CORE_GROUP3_BASE + SMP_CORE1_OFFSET + BUF);
> -	ipi_mailbox_buf[14] = (void *)
> +	ipi_mailbox_buf[14] = (void __iomem *)
>   		(SMP_CORE_GROUP3_BASE + SMP_CORE2_OFFSET + BUF);
> -	ipi_mailbox_buf[15] = (void *)
> +	ipi_mailbox_buf[15] = (void __iomem *)
>   		(SMP_CORE_GROUP3_BASE + SMP_CORE3_OFFSET + BUF);
>   }

OK up to here,

> @@ -782,7 +782,7 @@ void play_dead(void)
>   
>   	if (prid_imp == PRID_IMP_LOONGSON_64G) {
>   		play_dead_at_ckseg1 =
> -			(void *)CKSEG1ADDR((unsigned long)loongson3_type3_play_dead);
> +			(void __iomem *)CKSEG1ADDR((unsigned long)loongson3_type3_play_dead);

but these changes look dubious.

>   		goto out;
>   	}
>   
> @@ -790,19 +790,19 @@ void play_dead(void)
>   	case PRID_REV_LOONGSON3A_R1:
>   	default:
>   		play_dead_at_ckseg1 =
> -			(void *)CKSEG1ADDR((unsigned long)loongson3_type1_play_dead);
> +			(void __iomem *)CKSEG1ADDR((unsigned long)loongson3_type1_play_dead);
>   		break;
>   	case PRID_REV_LOONGSON3B_R1:
>   	case PRID_REV_LOONGSON3B_R2:
>   		play_dead_at_ckseg1 =
> -			(void *)CKSEG1ADDR((unsigned long)loongson3_type2_play_dead);
> +			(void __iomem *)CKSEG1ADDR((unsigned long)loongson3_type2_play_dead);
>   		break;
>   	case PRID_REV_LOONGSON3A_R2_0:
>   	case PRID_REV_LOONGSON3A_R2_1:
>   	case PRID_REV_LOONGSON3A_R3_0:
>   	case PRID_REV_LOONGSON3A_R3_1:
>   		play_dead_at_ckseg1 =
> -			(void *)CKSEG1ADDR((unsigned long)loongson3_type3_play_dead);
> +			(void __iomem *)CKSEG1ADDR((unsigned long)loongson3_type3_play_dead);
>   		break;
>   	}
>   

