Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3B176C980
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjHBJcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbjHBJcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:32:20 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0C819A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 02:32:16 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98377c5d53eso915925866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 02:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1690968735; x=1691573535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qF0aEgee+FPFz+iaQY2LrH7Juz8N6fO4KHzo5d0J5po=;
        b=WK07xQ3FGA5WcpC5zdx0uDh/Lh1f8FHSywlLFabT48BunC8cffyAwiJnKW6W9ZHRhv
         bdiDZKh6i0P4XosyLhKvMsVWmygqgp4Nn80eYXDBOUZZTPbZk/2eUYXuKJaH7TpmOyts
         uouA7nAqrPVIUuVFeiYhOUUhrv3QHDWqOuZx2kCNJDNh2aH2eXWJ9YAiQWrdJMqwx2oh
         9t1va6KIgdxlTSaxnMg37rZ9D2boo1lpHhH6ebbDqA3WQFowchWEJzIXd+bS1suntkFe
         z/mJYKfIdrEi0/aoJC3VfeRW0y2kGAdMru/7TdNZy1piXEQ2WKmynJZBN+YHfGfUccEv
         Txrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690968735; x=1691573535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qF0aEgee+FPFz+iaQY2LrH7Juz8N6fO4KHzo5d0J5po=;
        b=SyzfzyeboOkuNIFPqc9DQxSQO45Z+6+abA3DieKs0UFmVlWvJy4FH8UUA4cmNoEYap
         MCxUc+s5TE0DPnNomzdLFMmeOqr1M2EyMSSBN6K/rJntp0DDvIltq+Ayi0kvjbfIM7ve
         CzTv3sjQOJhSgt7/oVWxWBinK7Xhyp8/wRQMtGv8lfNH9DB1fw1I2UhGHwTynm7KMKhA
         yRaaUgtPKQtaOupfRYnSDVb61+Tk2jkc3L4ST/h3KSviKkfXUiiVpmGrTVJ7IfemXiXX
         6gYLD4xzQ1cpKeEEuTz3uXuIKo0y0saB+ePZuVcMEUX1zC3rdybM4/moloTiOIZiCDh6
         rBSg==
X-Gm-Message-State: ABy/qLbSGoghh8WV/WRhZmichVnJ7bMQp8snChvJGQ7/Rpc7jpck4iEk
        Jmplagjz+AhGYjvwNpggP+VJHw==
X-Google-Smtp-Source: APBJJlFF191bxevEKrX048Spx8AHXhdbVnhFYercC2XbYZV/VYGT7ptsY6UpNsEbfdmWvraciuM69A==
X-Received: by 2002:a17:907:2bd7:b0:96f:e5af:ac5f with SMTP id gv23-20020a1709072bd700b0096fe5afac5fmr4440341ejc.47.1690968735457;
        Wed, 02 Aug 2023 02:32:15 -0700 (PDT)
Received: from localhost (212-5-140-29.ip.btc-net.bg. [212.5.140.29])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090690c800b00997e99a662bsm8741929ejw.20.2023.08.02.02.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 02:32:15 -0700 (PDT)
Date:   Wed, 2 Aug 2023 12:32:12 +0300
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
Message-ID: <20230802-7c19a712ae071f68030ab5f2@orel>
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
> +
> +#define CSR_CYCLE	0xc00
> +#define CSR_TIME	0xc01
> +
> +#define csr_read(csr)						\
> +({								\
> +	register unsigned long __v;				\
> +		__asm__ __volatile__ ("csrr %0, %1"		\
> +		 : "=r" (__v)					\
> +		 : "i" (csr) : );				\
> +		 __v;						\

nit: no need for the indentation or line wrap,

({
	register unsigned long __v;
	__asm__ __volatile__ ("csrr %0, %1" : "=r" (__v) : "i" (csr));
	__v;
})

Thanks,
drew
