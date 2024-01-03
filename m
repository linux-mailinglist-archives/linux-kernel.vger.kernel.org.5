Return-Path: <linux-kernel+bounces-15692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE654823059
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B55628604F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCA01B296;
	Wed,  3 Jan 2024 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="G9MMxejv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C7D1A720
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e7dff3e9fso7777428e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 07:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1704295109; x=1704899909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qOnh6GFoMJIg3Fk5aDwenA5FAvHDGXhGVcW2b/3N3Bc=;
        b=G9MMxejvLv3D5PRC5DfObCJVUmNe6vKlhaNd6xjL6bsQmcbL3ulgyh3mDZ1wxYED+E
         0gHoQsKDjb4/6jR5dOqt+MHsH4o9YgLRqkB81HN3aOyb8jwHDdk3gDCugVbUmYCTvIxZ
         FTWV7lORIqlc3LRKx7/oV6MTt3YvWjfgBOVRl1oMidr2ep7AA4IXGcPmjxSHoJf2Mf3K
         u7j4zUyfZLyup/WBYx9moOJG3FMmnb008Au0uPZ+Od1FQU7dHAwUJdYwcaTh415hhZBw
         2cI/jtcZh4dO/hE8fX9K/cmj1CKwKLSXn0LxC9zrF5GpvRmEJdoqnMtciS5DmsiT7JDB
         PFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704295109; x=1704899909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qOnh6GFoMJIg3Fk5aDwenA5FAvHDGXhGVcW2b/3N3Bc=;
        b=C6twtWUunT+WnQH2RGmUU5FhpEynZPgEyPECKVIY+R3yn37bGYVhYfyEl8jB7fcpne
         V4Nh9nfB/r5ob3Xk9R42XrMHiWCLKD1M+cm22kc6zGKxZPkCaHVQJKUiayeFjcKJuIzk
         hgol/ZHTu08/wG5d8VFXsn+l3PXzAgTz9fCVyj7MshM/m8FzDCGM8jYXMwjJWpuWsrKb
         kWiKhIPs/YfvJHNEUm6YS8abxIDux1pH49CRLSaU0eR+D7kBpedwFgplQsCUYd+U3CSk
         V1GbvCOlLBnSyGB5+X5pwVxm3Ip/AaruGQOPQCAPj2Yh9ePgnYqZBjst/OM0RsQ9kDB7
         brBw==
X-Gm-Message-State: AOJu0YzOi1JnP+Wh+zXY/Bn1kGMVEIUgGrC8kmMxUjZgYLXeK2ko77xQ
	O9Y8LDj75qkqmiL+TeUn/F4+O93AGWhBmg==
X-Google-Smtp-Source: AGHT+IGmMNSNCa2FS9YbKliIuuRoRIjkZHFFRQauWfc6RzCo+GBWoTZ+VEYuChLYvzI5/3hshuW9bQ==
X-Received: by 2002:a05:6512:3c8e:b0:50e:7693:7084 with SMTP id h14-20020a0565123c8e00b0050e76937084mr9468630lfv.57.1704295108834;
        Wed, 03 Jan 2024 07:18:28 -0800 (PST)
Received: from ?IPV6:2a02:6b6a:b5c7:0:1b12:a705:8eb0:640d? ([2a02:6b6a:b5c7:0:1b12:a705:8eb0:640d])
        by smtp.gmail.com with ESMTPSA id a5-20020a056512390500b0050e677cb432sm3667596lfu.193.2024.01.03.07.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 07:18:28 -0800 (PST)
Message-ID: <a57b9e19-3466-bb73-1c88-c19417ac6822@bytedance.com>
Date: Wed, 3 Jan 2024 15:18:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [External] [PATCH v5] x86: intel_epb: Add earlyparam option to
 keep bias at performance
To: Jack Allister <jalliste@amazon.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Paul Durrant <pdurrant@amazon.com>, Jue Wang <juew@amazon.com>,
 Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Tejun Heo <tj@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Yan-Jie Wang <yanjiewtw@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <83431857-7182-471a-9ff1-9dac37e5a02f@intel.com>
 <20240103144607.46369-1-jalliste@amazon.com>
Content-Language: en-US
From: Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <20240103144607.46369-1-jalliste@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/01/2024 14:46, Jack Allister wrote:
> Buggy BIOSes may not set a sane boot-time Energy Performance Bias (EPB).
> A result of this may be overheating or excess power usage. The kernel
> overrides any boot-time EPB "performance" bias to "normal" to avoid this.
> 
> When used in data centers it is preferable keep the EPB at "performance"
> when performing a live-update of the host kernel via a kexec to the new
> kernel. This is due to boot-time being critical when performing the kexec
> as running guest VMs will perceieve this as latency or downtime.
> 
> On Intel Xeon Ice Lake platforms it has been observed that a combination of
> EPB being set to "normal" alongside HWP (Intel Hardware P-states) being
> enabled/configured during or close to the kexec causes an increases the
> live-update/kexec downtime by 7 times compared to when the EPB is set to
> "performance".
> 
> Introduce a command-line parameter, "intel_epb=preserve", to skip the
> "performance" -> "normal" override/workaround. This maintains prior
> functionality when no parameter is set, but adds in the ability to stay at
> performance for a speedy kexec if a user wishes.
> 
> Signed-off-by: Jack Allister <jalliste@amazon.com>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Paul Durrant <pdurrant@amazon.com>
> Cc: Jue Wang <juew@amazon.com>
> Cc: Usama Arif <usama.arif@bytedance.com>
> ---
>   .../admin-guide/kernel-parameters.txt         | 12 +++++++++++
>   arch/x86/kernel/cpu/intel_epb.c               | 21 +++++++++++++++++--
>   2 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 65731b060e3f..5602ee213115 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2148,6 +2148,18 @@
>   			0	disables intel_idle and fall back on acpi_idle.
>   			1 to 9	specify maximum depth of C-state.
>   
> +	intel_epb=	[X86]
> +			auto
> +			  Same as not passing a parameter to intel_epb. This will
> +			  ensure that the intel_epb module will restore the energy
> +			  performance bias to "normal" at boot-time. This workaround
> +			  is for buggy BIOSes which may not set this value and cause
> +			  either overheating or excess power usage.
Hi,

Thanks for the patch. Is auto needed over here? It was pointed in an 
earlier review that it could be an option, but it doesn't seem to serve 
a purpose. Its also not how the code works, i.e. intel_epb=abc would be 
the same as intel_epb=auto. Just could add a print if intel_epb=preserve 
is not encountered then an unexpected value has been passed in.

> +			preserve
> +			  At kernel boot-time if the EPB value is read as "performance"
> +			  keep it at this value. This prevents the "performance" -> "normal"
> +			  transition which is a workaround mentioned above.
> +
>   	intel_pstate=	[X86]
>   			disable
>   			  Do not enable intel_pstate as the default
> diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_epb.c
> index e4c3ba91321c..419e699a43e6 100644
> --- a/arch/x86/kernel/cpu/intel_epb.c
> +++ b/arch/x86/kernel/cpu/intel_epb.c
> @@ -50,7 +50,8 @@
>    * the OS will do that anyway.  That sometimes is problematic, as it may cause
>    * the system battery to drain too fast, for example, so it is better to adjust
>    * it on CPU bring-up and if the initial EPB value for a given CPU is 0, the
> - * kernel changes it to 6 ('normal').
> + * kernel changes it to 6 ('normal'). However, if it is desirable to retain the
> + * original initial EPB value, intel_epb=preserve can be set to enforce it.
>    */
>   
>   static DEFINE_PER_CPU(u8, saved_epb);
> @@ -75,6 +76,8 @@ static u8 energ_perf_values[] = {
>   	[EPB_INDEX_POWERSAVE] = ENERGY_PERF_BIAS_POWERSAVE,
>   };
>   
> +static bool intel_epb_no_override __read_mostly;
> +
>   static int intel_epb_save(void)
>   {
>   	u64 epb;
> @@ -106,7 +109,7 @@ static void intel_epb_restore(void)
>   		 * ('normal').
>   		 */
>   		val = epb & EPB_MASK;
> -		if (val == ENERGY_PERF_BIAS_PERFORMANCE) {
> +		if (!intel_epb_no_override && val == ENERGY_PERF_BIAS_PERFORMANCE) {
>   			val = energ_perf_values[EPB_INDEX_NORMAL];
>   			pr_warn_once("ENERGY_PERF_BIAS: Set to 'normal', was 'performance'\n");
>   		}
> @@ -213,6 +216,20 @@ static const struct x86_cpu_id intel_epb_normal[] = {
>   	{}
>   };
>   
> +static __init int parse_intel_epb(char *str)
> +{
> +	if (!str)
> +		return 0;
> +
> +	/* "intel_epb=preserve" prevents PERFORMANCE->NORMAL on restore. */
> +	if (!strcmp(str, "preserve"))
> +		intel_epb_no_override = true;
> +
Maybe add an print in else here to say that unexpected value has been 
encountered for intel_epb if preserve is not seen.

Thanks,
Usama
> +	return 0;
> +}
> +
> +early_param("intel_epb", parse_intel_epb);
> +
>   static __init int intel_epb_init(void)
>   {
>   	const struct x86_cpu_id *id = x86_match_cpu(intel_epb_normal);

