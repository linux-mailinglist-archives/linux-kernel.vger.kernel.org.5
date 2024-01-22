Return-Path: <linux-kernel+bounces-32804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDF7836040
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3BEB1F2357B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E712F3A8C2;
	Mon, 22 Jan 2024 11:01:29 +0000 (UTC)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363193A1C2;
	Mon, 22 Jan 2024 11:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921289; cv=none; b=RgOSIaqQbCCp73AV2uplbE08ydhmJSJMLjqtd/PjeR1NjFOi8+gYGuyHqH/OHEQA8Y9PGwdvvFo5hFYsciRgdIfDTRRo/LPcu0/VlVyMcWWgrkuqaQv5tMPQGDkvot/7G1XKO7dYkSHqns/3KkWgb9LjZb9udRouqTaT9Ez4VEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921289; c=relaxed/simple;
	bh=0I1hZBX1aIvcU2CFyoaBdQ1SCLCfeODeFuogHzNWc/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JlQ39wvx2VSg8AUgcI1EtwKV2vHzk9NaDCXmRzvIIEdZUh8yWKSTVx++9bC6MaKAKlNej2PjWMU6OOQgJIoKCfvnbOt1xHDzrK6JOsFekZ++MMwAgzc/mv95orBrtn3lm5YYmFHpAJI20NPcDaJNQ0cpHKW8pgQ0vIAI5Pj5SnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-59910dcc17bso637932eaf.1;
        Mon, 22 Jan 2024 03:01:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705921287; x=1706526087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTiz18276Uf+B1qD5cDSM1J5ZYoGHeeO739RJ3mibZ8=;
        b=SwZNR6VsRPNjCFqtb36npR+fNTmRVuqCxMxrRWe/xPL7Lw6nbPnic4iy9uoLt5zt9L
         A28XvLZoQh5bnk1YgJK+SDah1Ad0i7iVBb5GteQLqx5iSbKiGf77NWdcsIWL9HWJDRG7
         BcuNnj3YBAaYHDYimCqX5XCdNfmFZ9cWXLYHklG5BZEfOGFupOnd7BY16AwG/VYeai7/
         hIPdZSXWXXD4jJgcBOl0K8ANw4myoi8h7ep9LqplzyYN+32YTAX+wuI7gmN9SuIfeovi
         EFOh7GkbFquNcFS9F8yrEx4x+6ah3h3IicVlc63fwWInDxC19DrXiZ1N/tCWLMmWpbXV
         uXpw==
X-Gm-Message-State: AOJu0Yzbw84FTAEyCW7Y3ItwS9Oho/sU5K+s8/XDAW1KsAOGWbLCuEVp
	b46+pu2iUWHmlpouLjMoLWOAn2RNqqL3LgkS4SFviC6+9XnkxfN5elT8OB5A6Lzoy3A5cllRrkg
	2xfdFTquKDDm2BKyI24EHMk6XXryJogA+
X-Google-Smtp-Source: AGHT+IFXJ2Nc6UOX/9bZ6Gbyiif7n0uM7HQKKBupDvCF3JrlgDC9sxcsX8Q0tJCWHyxjp9sqFxLe1ehlPI7NuEBUx/E=
X-Received: by 2002:a4a:a6c4:0:b0:599:283c:fc53 with SMTP id
 i4-20020a4aa6c4000000b00599283cfc53mr6629599oom.0.1705921286993; Mon, 22 Jan
 2024 03:01:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118122340.1034880-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20240118122340.1034880-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Jan 2024 12:01:12 +0100
Message-ID: <CAJZ5v0jVKNEnwuep=Jq=cGTpq=NW9Pbu2AEduzmpv+L5Gec2Lw@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: powerclamp: Remove dead code for target
 mwait value
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 1:23=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> After conversion of this driver to use powercap idle_inject core, this
> driver doesn't use target_mwait value. So remove dead code.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> Non urgent patch. For 6.9+ kernel.
>
>  drivers/thermal/intel/intel_powerclamp.c | 32 ------------------------
>  1 file changed, 32 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/i=
ntel/intel_powerclamp.c
> index 5ac5cb60bae6..bc6eb0dd66a4 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -49,7 +49,6 @@
>   */
>  #define DEFAULT_DURATION_JIFFIES (6)
>
> -static unsigned int target_mwait;
>  static struct dentry *debug_dir;
>  static bool poll_pkg_cstate_enable;
>
> @@ -312,34 +311,6 @@ MODULE_PARM_DESC(window_size, "sliding window in num=
ber of clamping cycles\n"
>         "\twindow size results in slower response time but more smooth\n"
>         "\tclamping results. default to 2.");
>
> -static void find_target_mwait(void)
> -{
> -       unsigned int eax, ebx, ecx, edx;
> -       unsigned int highest_cstate =3D 0;
> -       unsigned int highest_subcstate =3D 0;
> -       int i;
> -
> -       if (boot_cpu_data.cpuid_level < CPUID_MWAIT_LEAF)
> -               return;
> -
> -       cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
> -
> -       if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED) ||
> -           !(ecx & CPUID5_ECX_INTERRUPT_BREAK))
> -               return;
> -
> -       edx >>=3D MWAIT_SUBSTATE_SIZE;
> -       for (i =3D 0; i < 7 && edx; i++, edx >>=3D MWAIT_SUBSTATE_SIZE) {
> -               if (edx & MWAIT_SUBSTATE_MASK) {
> -                       highest_cstate =3D i;
> -                       highest_subcstate =3D edx & MWAIT_SUBSTATE_MASK;
> -               }
> -       }
> -       target_mwait =3D (highest_cstate << MWAIT_SUBSTATE_SIZE) |
> -               (highest_subcstate - 1);
> -
> -}
> -
>  struct pkg_cstate_info {
>         bool skip;
>         int msr_index;
> @@ -759,9 +730,6 @@ static int __init powerclamp_probe(void)
>                 return -ENODEV;
>         }
>
> -       /* find the deepest mwait value */
> -       find_target_mwait();
> -
>         return 0;
>  }
>
> --

Applied as 6.8-rc material, thanks!

