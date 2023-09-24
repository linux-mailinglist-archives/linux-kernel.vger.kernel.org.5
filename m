Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C97D7ACAD8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 19:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjIXRGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 13:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXRGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 13:06:35 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6B3CF;
        Sun, 24 Sep 2023 10:06:29 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5043a01ee20so5583305e87.0;
        Sun, 24 Sep 2023 10:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695575187; x=1696179987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gG8vnWQHvQhRnrvCqdEqT6JTTQ016xPNLohZ4GJlrMs=;
        b=izTK4OoNLhWkjZEtI25JEFgNhwssqHSu4NJitCOmmkBopTZ/AvX2Hv/t0MFffFQS2+
         EMTAR2XMXfA+HhSX1qJHPIkJtOx54KGFw0IFEYae0FA1JZNdepFIwZACH+sDVFHZSPCA
         iPCBL2tyawmSUNrsQPKnz5BEaTwR0q3yuwozJKMtRXDUl0MPCPyjWF5G7QAWOhgM01D2
         C0q7SGgZJ3CO8QM9j270aLDxfQHYGoUUru9PkQW63JIgBA2MhJdyNUbVa392dVFaigSA
         DVP2CwujcuM7gDtuIYA+hLxOYMD1xF60K9cJaF0K/8DXZcTZxTZN74MIsGgscuUjXlBt
         HR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695575187; x=1696179987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gG8vnWQHvQhRnrvCqdEqT6JTTQ016xPNLohZ4GJlrMs=;
        b=ck3Gs++ZjBbt8UsGj563EK9/ZTuw930UjJYfo45xzrmvTCMYNE/bSd6ESZdSlwxU06
         YiXh5GGhxlCLZJYS3p3Xz6kPok3wuxMGPSRjoV6gZcv6jqxs4wmKadh0ITi2c7qyN+d2
         QR6RC1+Nqv+6eYdb5+aE9yhJ5S/9XIeq46NpkDKWguCV8Y+PVqbqhkJ4xn+vSS0X0dgr
         yJtD4cnozHmp0k02Pewq6VmBoW6Bv285uAuEwXFYyz1UMnDCaWRF8L2kyMIZPz764I9p
         sJhEyavlVnj6gl3edpl4XB5A1YhzB2yMIQsYH7gkAvNZJ6sQwcbclL2wn0ZMDYav7YKB
         9nDA==
X-Gm-Message-State: AOJu0YyFqgAxUen6rPdQGykJUjWrxNd1koKpfbN92+iWHxYKxg3WB1Ti
        cMveJzvq/Dr5ck7rEQmnu5s=
X-Google-Smtp-Source: AGHT+IEtoFr2Pbg8fZweBJMsD1JXTiezgzBgcOIx0X/hI7Iqh7usEJ41J/mea3D1UezDz38TmVOXRg==
X-Received: by 2002:a19:2d01:0:b0:503:36cb:5438 with SMTP id k1-20020a192d01000000b0050336cb5438mr4050615lfj.21.1695575186869;
        Sun, 24 Sep 2023 10:06:26 -0700 (PDT)
Received: from [192.168.178.40] ([146.52.231.36])
        by smtp.gmail.com with ESMTPSA id y19-20020a056402135300b0052fdfd8870bsm4476566edw.89.2023.09.24.10.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Sep 2023 10:06:26 -0700 (PDT)
Message-ID: <bc42418d-117e-8d69-2630-0f072b9e196b@gmail.com>
Date:   Sun, 24 Sep 2023 19:06:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] scsi: target: tcmu: Annotate struct tcmu_tmr with
 __counted_by
To:     Kees Cook <keescook@chromium.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922175300.work.148-kees@kernel.org>
Content-Language: en-US
From:   Bodo Stroesser <bostroesser@gmail.com>
In-Reply-To: <20230922175300.work.148-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.09.23 19:53, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct tcmu_tmr.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Bodo Stroesser <bostroesser@gmail.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org
> Cc: target-devel@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   drivers/target/target_core_user.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
> index 22cc6cac0ba2..7eb94894bd68 100644
> --- a/drivers/target/target_core_user.c
> +++ b/drivers/target/target_core_user.c
> @@ -201,7 +201,7 @@ struct tcmu_tmr {
>   
>   	uint8_t tmr_type;
>   	uint32_t tmr_cmd_cnt;
> -	int16_t tmr_cmd_ids[];
> +	int16_t tmr_cmd_ids[] __counted_by(tmr_cmd_cnt);
>   };
>   
>   /*

Reviewed-by: Bodo Stroesser <bostroesser@gmail.com>

Thank you,
Bodo
