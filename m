Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A147CF18B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344893AbjJSHpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbjJSHpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:45:05 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B05213E
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:45:03 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4083cd39188so11959095e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697701501; x=1698306301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5pmXZfNDgHWU97eVG0ao9ZDPxa8/NusQS8x4RuYWhWk=;
        b=iZWOzNajhWf3yU3oCewYpD2OUdH0ARGWLZ4rj91MZvBr6MGURqHWgXt53Y/CbaD/H1
         3En+jtm90Q6JThv8z87H1h6VnnICzay2rrVWCIL+TfEKFMxDv0DR0XxxhZncnE66OEnJ
         oHxwLI5irsn44RwZjOXLsPVqkr9jNXYRpkCBvozGyI1+tCh2F6c2wOSxPRWr9NKiFRYV
         DAFBA89sVAtvQwvzsH+5pwhNJVDW8krDzFjc4vOI1ya+ylqt3ep04naCqDfirKBJqxka
         yW3bM2N+iG8EGM6zU6FL1K61xlHa1SXRQhBmhc64AV4sr0nFg6b+KuO8iCFqyodkdOtL
         5hCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697701501; x=1698306301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pmXZfNDgHWU97eVG0ao9ZDPxa8/NusQS8x4RuYWhWk=;
        b=flM8sIJw0yD/zi5GLPZKXpedT1Bgxkn2Es44jE6zh8qsSdJbeQxF5kOvvroWCzu7fe
         zLVLskBZ/3dRfXfwkS0k1A+t+gDOzjv50GKt/EN3iZC7YCb1HrCSPEUsKL1JjgBXb3yB
         zaniZlm05QsNJVCE4PMIR29Kz1zHbP+nmrYHOmZU40IXMhzl2S7U7OkSCjgSJ+RtBV8U
         g5NSm3snV8STaa3tg1HcMu23Pf+TQuN6i9PGO749T2VZqbbBZZbhs4z7T1pQNneICkvn
         fl1ZL/ZD6QbMORHVOJ7wc/wvfxGF3RYhhNomrYN5ws7PSVY4qTJzuYPWZ/cPXKcT8zwP
         5a8w==
X-Gm-Message-State: AOJu0YwCp2eA1P3NAicLxn11IYKKp9SZA8eIYojF5sMFhQqVEoHi9Zpq
        tII2wOmKDTTZ9dgB/XtV/XQoWA==
X-Google-Smtp-Source: AGHT+IF7BQxJkgtIKhJz33b7TksgaeCJ/FKlTDLOVy2fY0p9glVw/wOjAaJE92kUJE4r9I59EYQnCA==
X-Received: by 2002:a05:600c:3b95:b0:408:37aa:4766 with SMTP id n21-20020a05600c3b9500b0040837aa4766mr1021340wms.5.1697701501064;
        Thu, 19 Oct 2023 00:45:01 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c028100b004077219aed5sm3630164wmk.6.2023.10.19.00.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 00:45:00 -0700 (PDT)
Date:   Thu, 19 Oct 2023 09:44:59 +0200
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
Subject: Re: [PATCH v2 1/8] RISC-V: Add defines for SBI debug console
 extension
Message-ID: <20231019-5e24c756f19e98cd9d3f89bb@orel>
References: <20231012051509.738750-1-apatel@ventanamicro.com>
 <20231012051509.738750-2-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012051509.738750-2-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 10:45:02AM +0530, Anup Patel wrote:
> We add SBI debug console extension related defines/enum to the
> asm/sbi.h header.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/sbi.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 5b4a1bf5f439..12dfda6bb924 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -30,6 +30,7 @@ enum sbi_ext_id {
>  	SBI_EXT_HSM = 0x48534D,
>  	SBI_EXT_SRST = 0x53525354,
>  	SBI_EXT_PMU = 0x504D55,
> +	SBI_EXT_DBCN = 0x4442434E,
>  
>  	/* Experimentals extensions must lie within this range */
>  	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
> @@ -236,6 +237,12 @@ enum sbi_pmu_ctr_type {
>  /* Flags defined for counter stop function */
>  #define SBI_PMU_STOP_FLAG_RESET (1 << 0)
>  
> +enum sbi_ext_dbcn_fid {
> +	SBI_EXT_DBCN_CONSOLE_WRITE = 0,
> +	SBI_EXT_DBCN_CONSOLE_READ = 1,
> +	SBI_EXT_DBCN_CONSOLE_WRITE_BYTE = 2,
> +};
> +
>  #define SBI_SPEC_VERSION_DEFAULT	0x1
>  #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
>  #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
