Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277A475749F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjGRGsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjGRGsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:48:42 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F275912D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:48:39 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3158a5e64b6so5078259f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689662918; x=1692254918;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jSzEA78JVNMRd4ky4z/eTmdwkJFg8wh7jFQtOF2e7Xo=;
        b=tfP0OmNC1aanFQcEkMfnyxqDPeh53bHL0cCvuSODJztNCea1nJB6c3+m5of3wtERib
         0Z+n9HiHq/7XPNjFQJnkc7hVuiS6jZQrpaEiAufDaabLK9z203cBbOSBhNSia7naZ2FM
         Tch3Dl4yrs0R/bC5kV4SS2ynbUbXl/mRWcUISmNNtIlA2NeVntawZpCobPHvbMTPOG+k
         tAJveG1+qDvP+YoxU5Qwpz3D8hDrN+d5bZ/rA4F9OFjNwYaNSDRPoadfdowP6SusJEJQ
         q9PP4v9YaPBmzHfXsnIFD/67QAGfMdRzFoY0D+jD3YinNEgRO6gCuERn1iTv8c1BTHHm
         X9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689662918; x=1692254918;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jSzEA78JVNMRd4ky4z/eTmdwkJFg8wh7jFQtOF2e7Xo=;
        b=ge3HJ2ZcIedIkbGaQRAXankkEqZZaHVXZfjYCWAdeQhQysdrF4xBf8EiNZr/V9Dahe
         k8wv/lWaRDaketIF2OrSNPS1MAjwTxyW4IstDoead6hYu6ZLF1hM8K3NaPrZ3iMYO5dd
         cyncti5qo8P6LCkW7uIDlfuzOCccuXzEW0H3DXlU1Bo0pdkp2hgtWRKLg4mdJao2Ndpo
         MBzRq5GfRhJsdBY5DDX11mRL4qYeS893B1sqrL6wrMrxm65uonoN7wEPxBxg/csRQRn1
         FxUXQ0Vse8/vbQOZwn87cwq9YAeKWZc22LiSYrNOU/7KWDRWI9N55RGpGL5v86hwtpdm
         n9YA==
X-Gm-Message-State: ABy/qLZoMVgDNCcFwQPVkgwfJIYLR/XgS73VVr0GWoNwGTY1DDZ9wXxT
        GVVWsL8xwlEsH/Oka8BZMSdf7A==
X-Google-Smtp-Source: APBJJlEguANht0pn5H3k9Pke+PYYno5UgRZk9yEBpWKlAmJKSTz6D2SF0joBnVBOBjCd5hgyQgMqQQ==
X-Received: by 2002:a5d:52c5:0:b0:314:545f:6e8e with SMTP id r5-20020a5d52c5000000b00314545f6e8emr10631760wrv.62.1689662918475;
        Mon, 17 Jul 2023 23:48:38 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.222.251])
        by smtp.gmail.com with ESMTPSA id k15-20020a056000004f00b003143ba62cf4sm1393938wrx.86.2023.07.17.23.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 23:48:38 -0700 (PDT)
Message-ID: <72c44b42-0ed3-9eea-22dc-4b35b24c8ba7@linaro.org>
Date:   Tue, 18 Jul 2023 08:48:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] KVM: x86: Fix error & warning in i8254.h
Content-Language: en-US
To:     shijie001@208suo.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org
Cc:     hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        seanjc@google.com, pbonzini@redhat.com
References: <tencent_EA89B0582F8F8C3CC33C9F7AE407FC956F09@qq.com>
 <f1a0806ffdb74240f9bfbba9f4ece732@208suo.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <f1a0806ffdb74240f9bfbba9f4ece732@208suo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/23 08:02, shijie001@208suo.com wrote:
> The following checkpatch error & warning are removed:
> WARNING: please, no space before tabs
> ERROR: Macros with complex values should be enclosed in parentheses
> 
> Signed-off-by: Jie Shi <shijie001@208suo.com>
> ---
>   arch/x86/kvm/i8254.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)


>       struct mutex lock;
> @@ -52,7 +52,7 @@ struct kvm_pit {
>   #define KVM_SPEAKER_BASE_ADDRESS    0x61
>   #define KVM_PIT_MEM_LENGTH        4
>   #define KVM_PIT_FREQ            1193181
> -#define KVM_MAX_PIT_INTR_INTERVAL   HZ / 100
> +#define KVM_MAX_PIT_INTR_INTERVAL   (HZ / 100)

This looks like dead code, maybe better just remove?

>   #define KVM_PIT_CHANNEL_MASK        0x3
> 
>   struct kvm_pit *kvm_create_pit(struct kvm *kvm, u32 flags);

