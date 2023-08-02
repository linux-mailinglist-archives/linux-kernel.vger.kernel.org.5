Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF8B76C97A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjHBJ3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjHBJ3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:29:13 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A1B127
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 02:29:11 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bed101b70so824567566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 02:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1690968550; x=1691573350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CEvdWKJwrirYDhttDd02rTV33tBJG9g5L+9AxNoea3M=;
        b=WgRojBwticTI7tlGP4WhwryjFIOTSb45MoUr2Xomsnj5dZNimXNpbmwdtt7+Je4qpn
         TomUFaMgXy0jF9o3axmIL0HPy8hlV/4x5aXy3r2c9bn6YJ4Hg7Y3TQJOh9mvhHpCkZF8
         7ecMIM/3KehtF2nSe519/VXcRJJFE9OgiygnF2jZAItbssoFLRktIhrcyO3vZ6DDgpdV
         dZ6Egnhrxr0Ai+PK8gXu4AFGUD8fO+2tjft3pOngaYXwvwcqHQnUS0k7z43PXF3UlNDS
         DnjnF9Id5ixdw5KIBQOPhR5RtIGtjK2hpEWreQ9AW+PUrojmjfUTyccBFY2LjXFzMA12
         1DPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690968550; x=1691573350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEvdWKJwrirYDhttDd02rTV33tBJG9g5L+9AxNoea3M=;
        b=TO4G7CBiWNK5sZFtZNEdGdCvszP6j/I66yXfgp+5jcpSclPOytyPKZTIIKVw72+RQK
         y14IQ1Tg7G8CcXLLgWui7fNsszjyo91rI5F0KbnmF4QfUPlY7ZpPXnwUwuXpEmvXV89x
         6iOYPFldsMc1KC9SmZeeyOvzgH0+YkGziJPg1VDU2xd+QyOp1XkrejW40CZ76EhkVQDP
         0k7PJfZeHVuE2mJrd9E9sunSassywL8SfX+oM89Ti4+dWZ/mnSzN4kWNlsr4t1JYMElj
         KlnqkZxmcoBd92GRrctbHXsO7e4/06TKmmIRlmbby+TE8C/XPD5wXqqoXsX4dfFwB3qH
         oTdw==
X-Gm-Message-State: ABy/qLYg+FOrFRC6QYyOxSJeE+G9m43wyFwk8DCBGqlNyiTAVPpi/kt3
        u16Zef4vjau1IdPnMYHUHev04A==
X-Google-Smtp-Source: APBJJlFoWQnCKbhEbTUrZCJqYYVW6s4vDSWfgPkrwNS0ATxL1doB6I6qe6yB2sD40AZ6C/w2onWycw==
X-Received: by 2002:a17:906:305b:b0:99b:cb78:8537 with SMTP id d27-20020a170906305b00b0099bcb788537mr4084494ejd.11.1690968549860;
        Wed, 02 Aug 2023 02:29:09 -0700 (PDT)
Received: from localhost (212-5-140-29.ip.btc-net.bg. [212.5.140.29])
        by smtp.gmail.com with ESMTPSA id um6-20020a170906cf8600b009930c61dc0esm8823130ejb.92.2023.08.02.02.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 02:29:09 -0700 (PDT)
Date:   Wed, 2 Aug 2023 12:29:05 +0300
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        =?utf-8?B?UsOpbWk=?= Denis-Courmont <remi@remlab.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v6 09/10] tools: lib: perf: Implement riscv mmap support
Message-ID: <20230802-11f1b3d1ff4cc987bb58bfa4@orel>
References: <20230802080328.1213905-1-alexghiti@rivosinc.com>
 <20230802080328.1213905-10-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802080328.1213905-10-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 10:03:27AM +0200, Alexandre Ghiti wrote:
> riscv now supports mmaping hardware counters so add what's needed to
> take advantage of that in libperf.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>
> ---
>  tools/lib/perf/mmap.c | 66 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> index 0d1634cedf44..2184814b37dd 100644
> --- a/tools/lib/perf/mmap.c
> +++ b/tools/lib/perf/mmap.c
> @@ -392,6 +392,72 @@ static u64 read_perf_counter(unsigned int counter)
>  
>  static u64 read_timestamp(void) { return read_sysreg(cntvct_el0); }
>  
> +/* __riscv_xlen contains the witdh of the native base integer, here 64-bit */
> +#elif defined(__riscv) && __riscv_xlen == 64
> +
> +/* TODO: implement rv32 support */

It'd be easy to implement the rv32 support now (even if it's premature for
use), in order to avoid the TODO (which will likely be forgotten). I think
we just need to drop the __riscv_xlen == 64 above and then extend the
csr_read() macro something like the untested code below. (I'm not sure if
a TODO or premature, likely untested, code is worse though.)

> +
> +#define CSR_CYCLE	0xc00
> +#define CSR_TIME	0xc01
> +
> +#define csr_read(csr)						\
> +({								\

u64 __value;

> +	register unsigned long __v;				\
> +		__asm__ __volatile__ ("csrr %0, %1"		\
> +		 : "=r" (__v)					\
> +		 : "i" (csr) : );				\

__value = __v;

#if __riscv_xlen == 32
{
  int csrh = (csr) - CSR_CYCLE + CSR_CYCLEH;

  __asm__ __volatile__ ("csrr %0, %1" : "=r" (__v) : "i" (csrh));
  __value |= (u64)__v << 32;
}
#endif

__value;

> +})
> +
> +static unsigned long csr_read_num(int csr_num)

static u64 csr_read_num(int csr_num)

> +{
> +#define switchcase_csr_read(__csr_num, __val)           {\
> +	case __csr_num:                                 \
> +		__val = csr_read(__csr_num);            \
> +		break; }
> +#define switchcase_csr_read_2(__csr_num, __val)         {\
> +	switchcase_csr_read(__csr_num + 0, __val)        \
> +	switchcase_csr_read(__csr_num + 1, __val)}
> +#define switchcase_csr_read_4(__csr_num, __val)         {\
> +	switchcase_csr_read_2(__csr_num + 0, __val)      \
> +	switchcase_csr_read_2(__csr_num + 2, __val)}
> +#define switchcase_csr_read_8(__csr_num, __val)         {\
> +	switchcase_csr_read_4(__csr_num + 0, __val)      \
> +	switchcase_csr_read_4(__csr_num + 4, __val)}
> +#define switchcase_csr_read_16(__csr_num, __val)        {\
> +	switchcase_csr_read_8(__csr_num + 0, __val)      \
> +	switchcase_csr_read_8(__csr_num + 8, __val)}
> +#define switchcase_csr_read_32(__csr_num, __val)        {\
> +	switchcase_csr_read_16(__csr_num + 0, __val)     \
> +	switchcase_csr_read_16(__csr_num + 16, __val)}
> +
> +	unsigned long ret = 0;
> +
> +	switch (csr_num) {
> +	switchcase_csr_read_32(CSR_CYCLE, ret)
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +#undef switchcase_csr_read_32
> +#undef switchcase_csr_read_16
> +#undef switchcase_csr_read_8
> +#undef switchcase_csr_read_4
> +#undef switchcase_csr_read_2
> +#undef switchcase_csr_read
> +}
> +
> +static u64 read_perf_counter(unsigned int counter)
> +{
> +	return csr_read_num(CSR_CYCLE + counter);
> +}
> +
> +static u64 read_timestamp(void)
> +{
> +	return csr_read_num(CSR_TIME);
> +}
> +
>  #else
>  static u64 read_perf_counter(unsigned int counter __maybe_unused) { return 0; }
>  static u64 read_timestamp(void) { return 0; }
> -- 
> 2.39.2
>

Thanks,
drew
