Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EBD7CF1EF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbjJSIEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbjJSIDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:03:50 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84893183
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:03:47 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32d9d8284abso4970414f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697702626; x=1698307426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PH3CTrts87/bU27l3EN5JAWxWDeGWRQ9EMGON+8aZg4=;
        b=gMTUlmtnfk+4ygnaS28gWJ1F0cOGkdJsD8RqieWbofx8z9aUdiGQzf+y49rvw8eMji
         NYF3wqk4CdeEf/s9x3YcmFtOaemW8dzt1Nz3gy7AdOe8wyKLRJxykSUTiE0Q6TGwri1A
         tiZ1lG41ecgSPiahPtGdtQKRYeKpdxgz5gRJgQxSDqCSUOMo9F25sc6nkipivZ9GVrM9
         Jf3kWzL15UsKfujybgFfFr5iKWxtaZOFO8TmT6qy0KdUp8592aMcZc9ZrklWqDbtGJez
         jirbapSwpADuM6J+IbCL431h+zPQwxnPcFEqDPaummcGWmeRslxa9i/Jk9YevTb34VMf
         2Ahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697702626; x=1698307426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PH3CTrts87/bU27l3EN5JAWxWDeGWRQ9EMGON+8aZg4=;
        b=E4ElrqWRbouNo/BGlwapeDrBfOpxy7N2lfv8kMqI4d2vLbkyVEn/pOAcPnZZgg/SjF
         hsTkelXt+U5DHjQzhYelCIn7RHrmpm4AScCaLmmzFwInksBvmqErzzqFS6jxems8oJgy
         siOzbYwpg5GkNWqWk1r0RWM8BREBkSJ3COaTtZe0lejqABfHy0U/xKXU1/qHQhY2a8Lq
         7ijSd+i5eAXKkDWYzWaNsk72SYXCkwv1R4+2puPLxJ//++G9+YluoBqoEpZX1QxyrKxM
         lLDfOAQSRzFos4W7oNJrWoBSB1jyL451GkqjrLIY3OIwj2sRxorHZ0FYpdytVwtIN3Kw
         kaSg==
X-Gm-Message-State: AOJu0YyJHFHvY7wVK3aFVbKUv+EE4waltdcCfcMKL+ncRcksSP/nGtke
        gt8aqLFPJQ/USyASgsi9A7SNQg==
X-Google-Smtp-Source: AGHT+IHYgrLP95m19T8VV4j4IIENiIUl+y5B0n5FUWHPqZ/oM3kMO8SamCcDgZ0NeNrUiRnd8JBlpA==
X-Received: by 2002:a05:6000:11c9:b0:31f:b120:143 with SMTP id i9-20020a05600011c900b0031fb1200143mr887639wrx.59.1697702625844;
        Thu, 19 Oct 2023 01:03:45 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id c12-20020adfe70c000000b0031c6e1ea4c7sm3818471wrm.90.2023.10.19.01.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 01:03:45 -0700 (PDT)
Date:   Thu, 19 Oct 2023 10:03:44 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor@kernel.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] RISC-V: Add inline version of
 sbi_console_putchar/getchar() functions
Message-ID: <20231019-61b3653a98a1c021623b091e@orel>
References: <20231012051509.738750-1-apatel@ventanamicro.com>
 <20231012051509.738750-6-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012051509.738750-6-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 10:45:06AM +0530, Anup Patel wrote:
> The functions sbi_console_putchar() and sbi_console_getchar() are
> not defined when CONFIG_RISCV_SBI_V01 is disabled so let us add
> inline version of these functions to avoid "#ifdef" on user side.

nit: Here and in the summary I'd probably use the word "stub" instead of
"inline version".

> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/sbi.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 12dfda6bb924..cbcefa344417 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -271,8 +271,13 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>  			unsigned long arg3, unsigned long arg4,
>  			unsigned long arg5);
>  
> +#ifdef CONFIG_RISCV_SBI_V01
>  void sbi_console_putchar(int ch);
>  int sbi_console_getchar(void);
> +#else
> +static inline void sbi_console_putchar(int ch) { }
> +static inline int sbi_console_getchar(void) { return -1; }
> +#endif
>  long sbi_get_mvendorid(void);
>  long sbi_get_marchid(void);
>  long sbi_get_mimpid(void);
> -- 
> 2.34.1
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
