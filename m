Return-Path: <linux-kernel+bounces-106127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A80887E983
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 612451C20BEE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C56836AE0;
	Mon, 18 Mar 2024 12:43:46 +0000 (UTC)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B7821A02;
	Mon, 18 Mar 2024 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710765825; cv=none; b=ZLELT8CIy+1f5CDldEuiGFi91FcRkgkCIcM7IVWs2Zi19LsExGZ45Y0spnjibc7NawyUUbW7uhRp3Su6lXh8sX4bc+yI5MgSzFBNHR4+ycG3WyvbeQ1LUO0+x1/wIJPvFMbrZQP6kM4ICstDzUKSbMYr+s9xouTZt41UUyhreEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710765825; c=relaxed/simple;
	bh=68oOVcm3FvMUbVv3wvRUV5+bLvQLT9XTOAbMHlYJv4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHr0wCVPoW5hzyoHwT7XJRfs1w0h0nLHuVidTnmisAIgLC9XmVFaFc2h1V2A62Bv67Pj7+fls2e1I+AERjgvkzllxec3ghP4g/E5tUeC8K83HattX2EmRaPvLYeb4NESWcKW7MnsrXJ8f5nTukMrf+Zz4rWmG4im2lmo6pf/0SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a48e9d8574so32593eaf.0;
        Mon, 18 Mar 2024 05:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710765823; x=1711370623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wne08/yfL5ereND4mcOPTHfgvYyATiQRtP8milTivRE=;
        b=XqO7KpEJ+4iFCalnfwmHnuGZ7S7oRZiQ0+7Y6CsZ8lPmu9nS/+eh8vV68HsGduz6sQ
         8qsZT9Hy/hqdoMoVHBZWgjvOZ7PKwhfusA9D9kN1E30CKzutOUbf65AxJoPqBNIKqB0U
         42PXQnAmp++2NA+U93EuRT9IaDUp6PT5lFTc05VYEDStwmBWKGNSYfArlGSTVItW0Esy
         AJtFTt4Oin4QOFKAnPklDxh3cRGWHcYKzw5xkOcHWpufkfy48LrOdIwITf17RYUtK0Xj
         kJrqfp7wvj8R6DPkD29zdyutdk764Ezvp19r+T8KJn7muRiKMs/H54SbeY+lwH5jiKrm
         BRGQ==
X-Forwarded-Encrypted: i=1; AJvYcCURxi66ZypOdXi8IdMCijvvapFrvNl162xZYyfYvrR1KveCsPPpN/RWGYSYKKpQ78DlMK9zPhXRGQOxMWClPgdGZmYyuqLCxpHjwPfGK71oG/ZRlguP4ynfRdpaOM+GMVxrt0A23S8=
X-Gm-Message-State: AOJu0YzqL5JkwHnXTvTZL9xuJrSughcAF/GbAwi2Xub79zYpiW+jtQhA
	DiSPkJc9XgPDouW1nLZSQpDSROXjd3oOhoznoCbw/FqW2jLgDpaEclkV9/w310FYqoUDtG5Ps6T
	HsdEqtgGP9guhofT44CDigV5mMWs=
X-Google-Smtp-Source: AGHT+IF51tuacM5ENMShYBdFzef77uqLor5rSI139Ila3FmFOStMlIFwt9k+zNnBRqxoSLF3qUH7In1+PcshxyOluaY=
X-Received: by 2002:a05:6820:2c10:b0:5a4:7790:61b4 with SMTP id
 dw16-20020a0568202c1000b005a4779061b4mr6998080oob.0.1710765823319; Mon, 18
 Mar 2024 05:43:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710754236.git.perry.yuan@amd.com> <8e617be2b0eef88781973e16a98aac6a4a08d664.1710754236.git.perry.yuan@amd.com>
In-Reply-To: <8e617be2b0eef88781973e16a98aac6a4a08d664.1710754236.git.perry.yuan@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Mar 2024 13:43:27 +0100
Message-ID: <CAJZ5v0gzq2eNWUAk0B93MdFgbsMfPeT4UM5CCmJ+9i1=dktTvA@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
To: Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com, 
	viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com, 
	Borislav.Petkov@amd.com, Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, 
	oleksandr@natalenko.name, Xiaojian.Du@amd.com, Li.Meng@amd.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 11:12=E2=80=AFAM Perry Yuan <perry.yuan@amd.com> wr=
ote:
>
> There are some other drivers also need to use the
> MSR_K7_HWCR_CPB_DIS_BIT for CPB control bit, so it makes sense to move
> the definition to a common header file to allow other driver to use it.
>
> No intentional functional impact.
>
> Suggested-by: Gautham Ranjal Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

This change is fine with me, so

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  arch/x86/include/asm/msr-index.h | 2 ++
>  drivers/cpufreq/acpi-cpufreq.c   | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-=
index.h
> index 05956bd8bacf..41503647192e 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -775,6 +775,8 @@
>  #define MSR_K7_HWCR_IRPERF_EN          BIT_ULL(MSR_K7_HWCR_IRPERF_EN_BIT=
)
>  #define MSR_K7_FID_VID_CTL             0xc0010041
>  #define MSR_K7_FID_VID_STATUS          0xc0010042
> +#define MSR_K7_HWCR_CPB_DIS_BIT                25
> +#define MSR_K7_HWCR_CPB_DIS            BIT_ULL(MSR_K7_HWCR_CPB_DIS_BIT)
>
>  /* K6 MSRs */
>  #define MSR_K6_WHCR                    0xc0000082
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufre=
q.c
> index 37f1cdf46d29..2fc82831bddd 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -50,8 +50,6 @@ enum {
>  #define AMD_MSR_RANGE          (0x7)
>  #define HYGON_MSR_RANGE                (0x7)
>
> -#define MSR_K7_HWCR_CPB_DIS    (1ULL << 25)
> -
>  struct acpi_cpufreq_data {
>         unsigned int resume;
>         unsigned int cpu_feature;
> --
> 2.34.1
>
>

