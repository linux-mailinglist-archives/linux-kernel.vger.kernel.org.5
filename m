Return-Path: <linux-kernel+bounces-126483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 229FB893886
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F5E1F213EA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 07:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D768B664;
	Mon,  1 Apr 2024 07:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="egK3d1qg"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531778C1E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 07:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711954875; cv=none; b=DBOW5no75l9J/uYlVv0XH/RoH3307Y6iMP16amx1t7ZthFitIJgT+bQserfxiADOJiOfsZ30+UQPR2r/Iw3JwyK7D28P/qQ34KH9cL2tq94Ehwk42yM2zUajcmsErQTp9TEnlNKbuST42kbIAgf7vKnMD6rntxmUEguHmeMEqYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711954875; c=relaxed/simple;
	bh=0UxXqbvneBknkvUjHFo+1LfyNPC9qRMw/RiQNbhnucc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ul/nKzaM1BqdSjX820p778deMKhhHWi4AcRYsb6/nRJCuY53Td8ji4ZT7RDb9B+t0fDION+ZoZfVslo/KOvCWbKUct/qwFky/5N95UFbJsVMgVAbnxbvyunU0DzCnf1qgDbehJtKjG9Kd9Do8MfyB53NW0idXqjW92brT/6at+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=egK3d1qg; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c36dcb305cso1708327b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 00:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1711954873; x=1712559673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CR3iwkHe4Np8Vng7wVF9RKBPosLNIp8pBnmcewjQ5aU=;
        b=egK3d1qg4W4lD4JFjbAq+9xx5AxNe4XE4FYQiK9xs7kThX7CJlt+53zfl2w1jpiSgB
         wCjDC+X0oc/rI9qmtrACpQrcllt3LOCQo2XkuCCnq7L9E8BQ9OJyCHJbm0QOxLorJ6TH
         fWt0nLTWVvtHMytpmaJvbuNo15RXQgXekAcwAqkddvFwBVwF9LrPZh13SytEfQv2Emss
         zn3bfybg21YGOh87dab2DZpFongr7rK65dCr0mOYyfJ9nvBIDt+dCNpYiCAQKruKcx9N
         haPaQ+6Vdl5jnC0/thwUEph6pgG8sb/mV9wbwJyJm6jtQGBm5JmxpfXGKHDzyY++zKOP
         BC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711954873; x=1712559673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CR3iwkHe4Np8Vng7wVF9RKBPosLNIp8pBnmcewjQ5aU=;
        b=JGypd52AFMpBNmo8KsnE96k+FNlSOWLOKBckS8u+1xFHkg5kfVZqivMvGYIyOo9NP6
         /JaCS0Vzfx06SQLDc8qceuZUtgLLJ5qDaTI2u3vcJyAGiCDK/BjVlz0+liAqSBZhAzhd
         QVF99503aQCIcNnHemlc/5GNukPHePuQLkuuu9HyiLA1rOMpo6809q6GFjOdrr+9+tLG
         dJjYaUUPwzaoY4MXZdZAaO5DAK+My/LOHaax3zNhp73upqMs7wkbL53bFkeLmy01m3fO
         IPlG3HjHxgCV0yYsWvivZEigaW8f2yFKRhbNphqKzAsBrVwQ3tmGSooi5+/1xr9Fl3gn
         vLCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNVOLt9tOc3wyhxlYGIloP7FHT5pRyE6gNEab5G5BTVbyFxVh06oxRtx8U+y0uKAUD7uFAi+EBsaB/+TPA3Bws+wpezRETavD5FQ1z
X-Gm-Message-State: AOJu0YwDiPeGJnoc/ajQE7RmcfH7phXWY0eiQn0E+ZRP7AWo6mBJ1MLj
	1HP+nYL9+0RjKqSQXtdnZluilSb7wC7WGpE++m8OMhlxiYCWgHbIavRbfT8jfcc=
X-Google-Smtp-Source: AGHT+IHNVXbtf4nFi0CjQtWkGz+KO+8YX+Nli7rw8a7TjQYiIWVV4PVHNMdRC2/hIgsRYyvZbdhOXQ==
X-Received: by 2002:a05:6808:309c:b0:3c3:c157:5dc7 with SMTP id bl28-20020a056808309c00b003c3c1575dc7mr3557976oib.13.1711954873346;
        Mon, 01 Apr 2024 00:01:13 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id l7-20020a056808020700b003c4dac3b55dsm1018840oie.3.2024.04.01.00.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 00:01:12 -0700 (PDT)
Date: Mon, 1 Apr 2024 12:30:56 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Haibo Xu <haibo1.xu@intel.com>
Cc: xiaobo55x@gmail.com, ajones@ventanamicro.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Guo Ren <guoren@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Anup Patel <apatel@ventanamicro.com>, Zong Li <zong.li@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Jisheng Zhang <jszhang@kernel.org>, Baoquan He <bhe@redhat.com>,
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>,
	Evan Green <evan@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Tony Luck <tony.luck@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v2 4/6] ACPI: NUMA: Make some NUMA related parse
 functions common
Message-ID: <ZgpbqAraGbQqZv5d@sunil-laptop>
References: <cover.1709780590.git.haibo1.xu@intel.com>
 <c8b86184d9e6d078e9b9949d4837bc6e392c3f52.1709780590.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8b86184d9e6d078e9b9949d4837bc6e392c3f52.1709780590.git.haibo1.xu@intel.com>

On Thu, Mar 07, 2024 at 04:47:56PM +0800, Haibo Xu wrote:
> The acpi_numa_slit_init(), acpi_numa_memory_affinity_init()
> and acpi_parse_cfmws() functions are common enough to be used
> on platforms that support ACPI_NUMA(x86/arm64/loongarch).
> Remove the condition to avoid long defined(CONFIG_ARCH) check
> when new platform(riscv) support was enabled.
> 
> Suggested-by: Sunil V L <sunilvl@ventanamicro.com>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  drivers/acpi/numa/srat.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 1946431c0eef..938c4adb7ec4 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -219,7 +219,6 @@ int __init srat_disabled(void)
>  	return acpi_numa < 0;
>  }
>  
> -#if defined(CONFIG_X86) || defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH)
>  /*
>   * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
>   * I/O localities since SRAT does not list them.  I/O localities are
> @@ -351,13 +350,6 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  	(*fake_pxm)++;
>  	return 0;
>  }
> -#else
> -static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> -				   void *arg, const unsigned long table_end)
> -{
> -	return 0;
> -}
> -#endif /* defined(CONFIG_X86) || defined (CONFIG_ARM64) */
>  
>  static int __init acpi_parse_slit(struct acpi_table_header *table)
>  {
LGTM.
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

