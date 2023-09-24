Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C550B7AC7CF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 13:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjIXLsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 07:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjIXLsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 07:48:36 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B9DAB;
        Sun, 24 Sep 2023 04:48:30 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31dd10c2b8bso4424893f8f.3;
        Sun, 24 Sep 2023 04:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695556108; x=1696160908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WxrXzUZdFoEnyidf/9NrxADttmtIpVLpZeUKjXRx3Xc=;
        b=d/3F4pVJ0FAVhgdE/4OOVXpYrOcqUuBz7pY0n6kAiHa76OvP6yraoqn8Fh1ODQRApG
         0VZDv8J3KYGZWC5kRAe2fJgTMucb5c1ZA2WhE37S/T4DQ4xFHkOah9WqE5dPHMyTXDIr
         tQFsWiuEbac3VMwg1Gpn8+Mya5NIBfKUoo7a3KfsbzdtzM9UEc4p+U05bpps5LEDsotd
         woZLZNxgdL7xmiC/SKB5TuekaIxWcUee3xOpRlR35kDE0aJszKo+4bVBe+7plB7VywBR
         haAY7IfP27J/Zd7v/brfHFRlywJahsugllvNJPGba9/0UMLkG/I+xF4h/dNgRfr/C+jE
         7WiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695556108; x=1696160908;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WxrXzUZdFoEnyidf/9NrxADttmtIpVLpZeUKjXRx3Xc=;
        b=Ov6PggbInxjWElvXGrD12O1aFQc93Gi3gjra5cfQTuM2g0eyLeW2Io/SfATZeI07bg
         o37iRGoz3J4k8R1m2JKaJK2KUI3Czzbk0bdKFCgieQiQccXeOrOnWfOOgagVazzpIa+E
         uoQ4vOKTQO1eIdhKk1vS7noVmdkXLfSu7iPQ6GaUeL4fQG6rQMt/lkq/hkYk2eS1mM6c
         oQ+5HQ2g7+8EDJvktvFocDKmuacIdEbRFI0GHAlI7IqtChZ9XYWsvpNOGGHHllL42UlH
         suSK/0GjCKyuX9zss5e+udgi/iUYRGKRJsQMIRCRUmQF8EWwn4G1yUhCHVFhmMAYTf2F
         6+Hw==
X-Gm-Message-State: AOJu0YybE5OIv75is22baUlSY04uLOUmWrXRlnRDFyGqQj3wvyJ5K3vs
        qeTwvQKv2kavxC7oaiUdXlM=
X-Google-Smtp-Source: AGHT+IHOtjQZIIOHnfbKyFj8xwTuyrfcKwU5lMGoiETzsAtEMOnLHasDQnbASJEUUyKn9mLJuNGH1A==
X-Received: by 2002:a05:6000:1819:b0:317:f70b:3156 with SMTP id m25-20020a056000181900b00317f70b3156mr3423806wrh.28.1695556108404;
        Sun, 24 Sep 2023 04:48:28 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id k10-20020adfd22a000000b0032320a9b010sm1262983wrh.28.2023.09.24.04.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Sep 2023 04:48:27 -0700 (PDT)
Message-ID: <e326ed06-3f72-4552-a26d-5deae0678409@gmail.com>
Date:   Sun, 24 Sep 2023 13:48:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/surface: aggregator: Annotate struct ssam_event
 with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     platform-driver-x86@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922175436.work.031-kees@kernel.org>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20230922175436.work.031-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/23 19:54, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ssam_event.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Maximilian Luz <luzmaximilian@gmail.com>
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   include/linux/surface_aggregator/controller.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/surface_aggregator/controller.h b/include/linux/surface_aggregator/controller.h
> index cb7980805920..5b67f0f47d80 100644
> --- a/include/linux/surface_aggregator/controller.h
> +++ b/include/linux/surface_aggregator/controller.h
> @@ -44,7 +44,7 @@ struct ssam_event {
>   	u8 command_id;
>   	u8 instance_id;
>   	u16 length;
> -	u8 data[];
> +	u8 data[] __counted_by(length);
>   };
>   
>   /**

Thanks!

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
