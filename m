Return-Path: <linux-kernel+bounces-126481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FEF893880
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD97E2816AC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 06:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E580D9468;
	Mon,  1 Apr 2024 06:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="MFlBSyA0"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484FF9479
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 06:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711954601; cv=none; b=gIe+XxG6C/fBOkwNCAQaxsT0EwhoMUWJdQn+LCe6lsM75P3D/crJt+qMBhmgKCO6Eclg9YuI9+OF1EooIHhD8HEkh9l1XtePB6b2TUyIGr4MmuJwHF18NQYGUOShXYKwZZVBR/TuM3Y0ADhdcZz7pw0kw3yZOyXfVrL16HwVGec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711954601; c=relaxed/simple;
	bh=Yg6ZAZ9PYBDDNgkzym8CB2lmZAjdjykvvduvHFcu4ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYBOxlx6F5Q1YJ0rqX3T91bGgA6VZGx/KSlTeFdJzrI+DXPW25sEwLaSyWvPNPQJvD4DRDJjBmihhX40hyFBN462ZV4PUzfd4Bh/J7SEVQ8TAVUh8n9/mav9tKRZmMAnmpudDroQfD0kQEuMfKN3ySG39KO7v5fKbnkl4S6mKxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=MFlBSyA0; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a558d9c33aso2423700eaf.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 23:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1711954598; x=1712559398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k5QMc5A+3aApya8s9m/eSM60TrmnXCfV5wxTtT8TbHU=;
        b=MFlBSyA0bJ4CA4QK54HHyxL2JnJEOLwkKd/zJMBp49nih59P1uzsceUReutVAeS/O3
         n/zDYPkGPNvvRTwjI3AgtiYAIMphEm1rwr1/a/ZyZ9o3ReU7rKmMeAVhEybQs8mF25Sn
         t5BmYH1QkUeNpna6oU1dpYeAyl7ZOwAToxH54yZZW6E61YvjIhYrFkLJ6kZmOUyHsi6M
         jyXHdGbRV0MByaYWzRaHGfqXD8EDtCHZn5+T9N2rTrjc7kFI9xZubLi0pTGJ6yO4NfFE
         5/s3stM1bQOprEXe0g1AT4/1i4sgsqZDZKzBUxg2HVhnBWj6NgSENO3E6dbIPMH8gZXm
         gnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711954598; x=1712559398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5QMc5A+3aApya8s9m/eSM60TrmnXCfV5wxTtT8TbHU=;
        b=Kz5pscTVtwFoVRBeHJqkUIunOfmS4sWdLPBn0gNTlqNpdAfIy823LfqXWnHuPaOqIl
         NP/iDnsMA4o2BrpWHZ5+UvRjUkZFJ0O1mAM4lj1hRFQePxu2U4FYyg+AxQQb2cfYeyVD
         xU0gkgOd2uVMuZve07ymFO9eIGiczwtQAj2m6c1QCJ2NfI33UugPV/19+fCImiIvR216
         2dxhFamkun16p1aIxDDhdBpX8BKm2xGLsT8s0OY5LedQXsMWYmNlU/QUvaWpSf5WlD1p
         JK8603J8iN5yj0mWgD1xAkDEyNumIUpPVperz81dNnoQIrvS2Nor5h+/clnrV4S8HHUN
         n3Og==
X-Forwarded-Encrypted: i=1; AJvYcCUnLzcLRFDelHyb8Xr1c0nBDD+oIHizqlYx9xBfd7QdcPXG3BZbitYwjTv17iJR0Ho8+VrCdx2xWEB/2ENGtolLqDJ8lKGg394iCmDU
X-Gm-Message-State: AOJu0Yy6QHyEx7s3v6UPG1Lg41U8K8YWg3o36A4ZpGSNjts8WV6ViFBH
	gyTdlf/qyUMmt8+Sqh01cYTNT1zA57Hdg4BdNGtIa2h57Bd+P1LIZPJxNpQiKxQ=
X-Google-Smtp-Source: AGHT+IG8xxvNtnP4w16j8PGzc8Gm8jhbFwQdMjb0A7TOdZGH0K91xBxYft+WGV5HplTsEJ33lk1W0Q==
X-Received: by 2002:a05:6870:95a4:b0:22a:9d77:f654 with SMTP id k36-20020a05687095a400b0022a9d77f654mr10088415oao.31.1711954598213;
        Sun, 31 Mar 2024 23:56:38 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id hu20-20020a056871529400b00222b4f5a5e0sm2695353oac.18.2024.03.31.23.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 23:56:37 -0700 (PDT)
Date: Mon, 1 Apr 2024 12:26:21 +0530
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
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Sia Jee Heng <jeeheng.sia@starfivetech.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Zong Li <zong.li@sifive.com>, Jisheng Zhang <jszhang@kernel.org>,
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
	Baoquan He <bhe@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	James Morse <james.morse@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Evan Green <evan@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Ard Biesheuvel <ardb@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Yuntao Wang <ytcoode@gmail.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v2 3/6] ACPI: NUMA: Add handler for SRAT RINTC affinity
 structure
Message-ID: <ZgpalRJPbP1/8VBL@sunil-laptop>
References: <cover.1709780590.git.haibo1.xu@intel.com>
 <91a4bc39444c80ea960bbd070bea489d27628cb6.1709780590.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91a4bc39444c80ea960bbd070bea489d27628cb6.1709780590.git.haibo1.xu@intel.com>

On Thu, Mar 07, 2024 at 04:47:55PM +0800, Haibo Xu wrote:
> Add RINTC affinity structure handler during parsing SRAT table.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  drivers/acpi/numa/srat.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 0214518fc582..1946431c0eef 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -165,6 +165,19 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
>  		}
>  	}
>  	break;
> +
> +	case ACPI_SRAT_TYPE_RINTC_AFFINITY:
> +		{
> +			struct acpi_srat_rintc_affinity *p =
> +			    (struct acpi_srat_rintc_affinity *)header;
> +			pr_debug("SRAT Processor (acpi id[0x%04x]) in proximity domain %d %s\n",
> +				 p->acpi_processor_uid,
> +				 p->proximity_domain,
> +				 (p->flags & ACPI_SRAT_RINTC_ENABLED) ?
> +				 "enabled" : "disabled");
> +		}
> +		break;
> +
>  	default:
>  		pr_warn("Found unsupported SRAT entry (type = 0x%x)\n",
>  			header->type);
> @@ -448,6 +461,21 @@ acpi_parse_gi_affinity(union acpi_subtable_headers *header,
>  }
>  #endif /* defined(CONFIG_X86) || defined (CONFIG_ARM64) */
>  
> +static int __init
> +acpi_parse_rintc_affinity(union acpi_subtable_headers *header,
> +			  const unsigned long end)
> +{
> +	struct acpi_srat_rintc_affinity *rintc_affinity;
> +
> +	rintc_affinity = (struct acpi_srat_rintc_affinity *)header;
> +	acpi_table_print_srat_entry(&header->common);
> +
> +	/* let architecture-dependent part to do it */
> +	acpi_numa_rintc_affinity_init(rintc_affinity);
> +
> +	return 0;
> +}
> +
>  static int __initdata parsed_numa_memblks;
>  
>  static int __init
> @@ -501,7 +529,7 @@ int __init acpi_numa_init(void)
>  
>  	/* SRAT: System Resource Affinity Table */
>  	if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
> -		struct acpi_subtable_proc srat_proc[4];
> +		struct acpi_subtable_proc srat_proc[5];
>  
>  		memset(srat_proc, 0, sizeof(srat_proc));
>  		srat_proc[0].id = ACPI_SRAT_TYPE_CPU_AFFINITY;
> @@ -512,6 +540,8 @@ int __init acpi_numa_init(void)
>  		srat_proc[2].handler = acpi_parse_gicc_affinity;
>  		srat_proc[3].id = ACPI_SRAT_TYPE_GENERIC_AFFINITY;
>  		srat_proc[3].handler = acpi_parse_gi_affinity;
> +		srat_proc[4].id = ACPI_SRAT_TYPE_RINTC_AFFINITY;
> +		srat_proc[4].handler = acpi_parse_rintc_affinity;
>  
>  		acpi_table_parse_entries_array(ACPI_SIG_SRAT,
>  					sizeof(struct acpi_table_srat),
LGTM. Thanks!

Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

