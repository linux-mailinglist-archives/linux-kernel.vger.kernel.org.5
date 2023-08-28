Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D3978B5AD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjH1Qyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbjH1Qya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:54:30 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D857911D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:54:26 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fef56f7222so33352505e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693241665; x=1693846465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wAKMQl2kF/7TR8cB8mTWFCehJMfYp3no2txsod+dRhc=;
        b=UhPqgstFoFc8tHvTu+xzUc0mrq4/hKhAa3fkay4ezMkyY5qDQR8tGYpE2Lc7iDz4Zg
         0nFX3Pqy/AHHFzyFrLiN83uxgo7PXY2pu0j2XwtVXcc27s/t4aeDgJe4lnLMBimyRuF+
         3ScGKh/MAigUUOIozg3JJah6XrVPBycmPpH3T+/doPFRmFxKU4nl5Ec4FSWVd2sKnp0Z
         09bPdiVADndS9e14JlG4WdNjbAiC3r0cNM6B+MehliQpQf8ztd5hp1DYpPZg4o8Qp5V8
         H0G2ig07baRXaBjLV6if/7koJNYNx2C2eyFpDHVZt52MDf9ca8Tou9gLwW1tAwMFGdFL
         3XyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693241665; x=1693846465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAKMQl2kF/7TR8cB8mTWFCehJMfYp3no2txsod+dRhc=;
        b=VgDgkuD7FeRcZzULW0vQu4ZiX8G4xfnEviBVExtLw4kK9eoHE3YGSQVj2WoTIMCXuX
         JqBH+51YCdRWKAUXgRwhv1pf4yOjDYXOrs2Pg7nigf5I9o5RvLc0kCVbyd1P78EVy0y5
         tEG+THpn+THTX946Enza3b7fW053ek7eBC/nnZ61xGsRRhKL+93oeko8QbsM0P4quTmC
         12b+37uB9eDY49CL6/kkrZUbPJjdJjXbtk0ZaQlo+mC2XBMt/czFTPcPYAqANwx8MLyV
         Ep4yYYIlRkrpeeQ3HXE884hSK9EZJs4YRDHe9ob2MXaqEwAUknFLgjvjtQIQWQFISVep
         E6tA==
X-Gm-Message-State: AOJu0YzFVTkqEoAI0zQ5//Y4dLHFpoeGHmQgVQgz+toMaXA9rrhVCU+G
        JHvgIi76l5WQtBErbw/dS7kJCyl5b+uUWlIN3pg=
X-Google-Smtp-Source: AGHT+IF9bPaGP0TFAc6Iu2f4KNupye5FZAU7ZlyFc1TcfkSP4FiQ1uDIVHCnJsIVpNpg3TRHRf9o6g==
X-Received: by 2002:a1c:f708:0:b0:3fb:e356:b60d with SMTP id v8-20020a1cf708000000b003fbe356b60dmr20208476wmh.38.1693241665392;
        Mon, 28 Aug 2023 09:54:25 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.201.64])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c231500b003fc0505be19sm11282199wmo.37.2023.08.28.09.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 09:54:25 -0700 (PDT)
Message-ID: <85c8d046-7613-ba34-538f-4b0f4852de9a@linaro.org>
Date:   Mon, 28 Aug 2023 18:54:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2] MIPS: loongson32: Remove dma.h and nand.h
Content-Language: en-US
To:     Keguang Zhang <keguang.zhang@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
References: <20230828134725.103442-1-keguang.zhang@gmail.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230828134725.103442-1-keguang.zhang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/8/23 15:47, Keguang Zhang wrote:
> Since commit 7b3415f581c7 ("MIPS: Loongson32: Remove
> unused platform devices"), struct plat_ls1x_dma and plat_ls1x_nand
> are unused. Then, dma.h and nand.h are useless.
> Therefore, remove these useless header files.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
> V1 -> V2: Remove include of dma.h and nand.h
>            Update the commit message
> 
>   arch/mips/include/asm/mach-loongson32/dma.h  | 21 ----------------
>   arch/mips/include/asm/mach-loongson32/nand.h | 26 --------------------
>   arch/mips/loongson32/common/platform.c       |  2 --
>   arch/mips/loongson32/ls1b/board.c            |  2 --
>   4 files changed, 51 deletions(-)
>   delete mode 100644 arch/mips/include/asm/mach-loongson32/dma.h
>   delete mode 100644 arch/mips/include/asm/mach-loongson32/nand.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

