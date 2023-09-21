Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895EA7A9A63
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjIUSix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjIUSiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:38:14 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9261D66C0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:27:14 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-991c786369cso166198566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1695320833; x=1695925633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w+HrO7ldsgAqMO34/GLDqrs/oKiBjOHaDyijQN4RwUM=;
        b=augSRktSCZNcD6JNpeM2IqVcSMln2gwUUSbOJ9F4R+5+sYBocI3a9jgU2g5v5xTwgU
         OsGN2VM0OExTpCtZFqPwSr7RJL335s16i6sHbme1HROuv3G0T3+X7fNbk1pDXE2/oWhe
         /fIBtYpmHCdAvVxEidnLA3jOVd7iZGg2zTXSppwX9kGJPQDGwN1pZrOjXsr386CPqNtI
         7oj+VypYWgqP6W85ryX0aw1MnLUM67hhRqDb2MPe73QKsXzgVyr7NPZgQaCVUTBlO8SY
         SeK73q75ooMbBaXoSGeP9iDfEV5IfqdsYHyCj+y6ZSYLdG7CwMUi/EpPe64GN/dsEJqA
         qc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320833; x=1695925633;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w+HrO7ldsgAqMO34/GLDqrs/oKiBjOHaDyijQN4RwUM=;
        b=gKVHOFr9mzCndh/sLoW9HwqLRB4nXtBq8u4zI0AlWRpHm1DpZQgcCcQAWkwQFhyDlq
         vuGzxd1KY6x/4sHcVJ5f+jQQjfJNOV40aBi6RIci1ncS00uoLjmRAr+ZfjWZ7J/h3I5X
         tn/QwZDitUZH19v2x8ku/tUVynG1Upw7rI9SfrjXhbju/em/NxM6j93+5o7QoWqmsk4J
         M8CeIgrO9lrCx/vS2ZUPS3gK2oFFRwm7qZSvVpxOGoaEWbtmrCqFTGcxpsh9R8U34tLr
         GEO6wH2S203iGS+iYcEr9V6oGhqaSSZOcs1K0VqVYcU/7M+6C0qLKQXSQt0wQoSqL+5T
         e4QQ==
X-Gm-Message-State: AOJu0YwoW5gliuT0vneVvmbPInqvLtfw8vmXHymfeQ+uuJdRErHUk8Tn
        8tBYp+MUOP9vjDgWcB52M3MuLw==
X-Google-Smtp-Source: AGHT+IFoiM8ZrUT3KpUeDhjFlq2CsLrGEc9c8+nNF8YnzwiEcwY3AeVRUIhAlkjNH2m5vxDQXIrgqg==
X-Received: by 2002:a17:906:2ce:b0:9a5:846d:d81f with SMTP id 14-20020a17090602ce00b009a5846dd81fmr4951426ejk.17.1695320833244;
        Thu, 21 Sep 2023 11:27:13 -0700 (PDT)
Received: from ?IPV6:2003:f6:af0b:f500:9282:fc17:35d3:acf0? (p200300f6af0bf5009282fc1735d3acf0.dip0.t-ipconnect.de. [2003:f6:af0b:f500:9282:fc17:35d3:acf0])
        by smtp.gmail.com with ESMTPSA id k19-20020a170906159300b00985ed2f1584sm1405990ejd.187.2023.09.21.11.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 11:27:12 -0700 (PDT)
Message-ID: <49e81d87-baee-4ba5-873c-ba32615beab0@grsecurity.net>
Date:   Thu, 21 Sep 2023 20:27:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/hyperv: Remove hv_vtl_early_init initcall
Content-Language: en-US, de-DE
To:     Saurabh Sengar <ssengar@linux.microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com
Cc:     ssengar@microsoft.com
References: <1695185552-19910-1-git-send-email-ssengar@linux.microsoft.com>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <1695185552-19910-1-git-send-email-ssengar@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missed it in my review, but the kernel bot already noticed it, so....

On 20.09.23 06:52, Saurabh Sengar wrote:
> [...]
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 033b53f993c6..83019c3aaae9 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -340,8 +340,10 @@ static inline u64 hv_get_non_nested_register(unsigned int reg) { return 0; }
>  
>  #ifdef CONFIG_HYPERV_VTL_MODE
>  void __init hv_vtl_init_platform(void);
> +int __init hv_vtl_early_init(void);
>  #else
>  static inline void __init hv_vtl_init_platform(void) {}
> +static int __init hv_vtl_early_init(void) {}

static inline

>  #endif
>  
>  #include <asm-generic/mshyperv.h>

Thanks,
Mathias
