Return-Path: <linux-kernel+bounces-101329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9067887A5A1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E629F1F21F42
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532B239AF1;
	Wed, 13 Mar 2024 10:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AD1lDp0o"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBABC38DDD;
	Wed, 13 Mar 2024 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710324919; cv=none; b=f5eu+Fdjx+YW4PbWGgUUHaC06Qjx+xoSE7hQoPdZfNPpczAfWc74u34h8hdfEDEXRek5K4ZXfbq+kGqZhR22SuqFa6ZWNE4GISajg1tuEpJMwBnxivgZTxdjI7M2O2wKTG4yW31t5jKgITPRU0uXr9jXI5KvxhQ4pSHWNgY/MgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710324919; c=relaxed/simple;
	bh=3xD+8JCwf86jkD5e60v0HwEHcqYhgbc7VhIyD3Yys0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8z/7Pjq/MWoRQGacCGZlCyXW59ux5azyFlCV7EdoFWtDDf08Jw+CTADKOzRTqsmM2XFOJ+Y8Q8uKrClIiHAb4TwGoC6jw689mb9L6D34RjYkYkyjetw0ZiUA4RRvo++9BLsyb3I7NXcpYEB1L40F8+s2eIv3UaTrWPrT8nGTMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AD1lDp0o; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33e9623c3a8so681055f8f.0;
        Wed, 13 Mar 2024 03:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710324916; x=1710929716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kheSY2qAqbE3EfWUfZ/cCoYdLw7ZBN3sckQtrZLqZmQ=;
        b=AD1lDp0oaBzqO69zR9pEISPlDO57BXHpmJtpmqeyk/kQ9FlED9vL3w+/cnA94D/XaI
         I8w3ck+sRb5zAe7x/9ItGSCiuECGUjwGXp5WhiemUS3VhAltt3/Lt8R1uzRcvJqgUuvA
         8Lk0Vz2XzCS+UofKogYIXvuyLrfChAOAX2L8TPB5pElKO67RZdzCalmzzTsIOOSNkvxm
         K1yFnYA1wr4nG08qC2st+xuK3Bl3hUPVfVYZyUhBCoe50rYZzmiPHmqVCZJ6S9C299VY
         ALTTlltPqP6Um8Cc4Hh3RJXu4qJcUdlsIwyISX33r7KuB1ZdSLN2KzOX+oPYAQ4YZJ64
         X0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710324916; x=1710929716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kheSY2qAqbE3EfWUfZ/cCoYdLw7ZBN3sckQtrZLqZmQ=;
        b=iRcI1MuxtgiL1E0uBGaVKnPKV0FHtdWzb3PLyLLBB+r5xRnoa3PYPEB2jPWSuOF1M2
         Qb0uMt4nJBtMqojx39VPY/xKzKddrXyDlD6XZp4MEHQUAeEUdok4WvdekyDjjUNuaFyg
         G6OaVspWO3akCTqMEoobOXWjbFGnuAmro2apA1BETr5YXaST/MrnsG8o/HgtxeOgrPLQ
         iL3BtE5EUGBcX/WXkEwQv6c1PNNtzM5sJK6VKPF9CQOHrevR4m3//Gz0rjIBYkNYIj13
         7EJcM8kB6mmzy7r7b63M3gjFMBd94AeHAu6+L44s6EJb8z2kiO8JIHN41RKxAG5Uf8A9
         DBiw==
X-Forwarded-Encrypted: i=1; AJvYcCXE/AMqyOIDiH14XLshPQWYiZ0x6+pMpOdTxtXu8w8atrx/k7TDAO6/m0Y+YK2G7Cre+Tsc6ecOv1LJ9xvil1XFnPoyCPqkB53s4JiV
X-Gm-Message-State: AOJu0YwIzQx7b2nmP9iWRaT8d9l8u32JpkNu8bgCgISw21sY5V+Ymd7g
	JH6LH8UD4jDAan/jY+VxF51ksJfwWSfrkdmrAktoMX5On7A34bpu
X-Google-Smtp-Source: AGHT+IFSt3/f3TSk6zw5n5Q8Lw6ZL0o9c38dSklyPWwS/Cvsr/znwMlO8pvtoidezN3tn4MCQmxkLg==
X-Received: by 2002:a5d:5646:0:b0:33e:be35:d459 with SMTP id j6-20020a5d5646000000b0033ebe35d459mr110131wrw.48.1710324915413;
        Wed, 13 Mar 2024 03:15:15 -0700 (PDT)
Received: from gmail.com (1F2EF295.nat.pool.telekom.hu. [31.46.242.149])
        by smtp.gmail.com with ESMTPSA id p12-20020adf9d8c000000b0033cf60e268fsm11324713wre.116.2024.03.13.03.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 03:15:14 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 13 Mar 2024 11:15:12 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	namhyung@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
	bp@alien8.de, eranian@google.com, irogers@google.com,
	mario.limonciello@amd.com, ravi.bangoria@amd.com,
	ananth.narayan@amd.com
Subject: Re: [PATCH v3 1/3] perf/x86/amd/lbr: Use freeze based on availability
Message-ID: <ZfF8sIol5xQcJM9F@gmail.com>
References: <cover.1706526029.git.sandipan.das@amd.com>
 <12f378d5c9459e765c6c3a14b092e6f91da596e3.1706526029.git.sandipan.das@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12f378d5c9459e765c6c3a14b092e6f91da596e3.1706526029.git.sandipan.das@amd.com>


* Sandipan Das <sandipan.das@amd.com> wrote:

> Currently, it is assumed that LBR Freeze is supported on all processors
> which have CPUID leaf 0x80000022[EAX] bit 1 set. This is incorrect as

That's X86_FEATURE_AMD_LBR_V2, right? Should probably be mentioned in the 
changelog.

> the feature availability is additionally dependent on CPUID leaf 
> 0x80000022[EAX] bit 2 being set which may not be set for all Zen 4 
> processors. Define a new feature bit for LBR and PMC freeze and set the 
> freeze enable bit (FLBRI) in DebugCtl (MSR 0x1d9) conditionally.

What happens on such Zen 4 CPUs that don't support LBR Freeze? Does the CPU 
just ignore it, or something worse?

> It should still be possible to use LBR without freeze for profile-guided
> optimization of user programs by using an user-only branch filter during
> profiling. When the user-only filter is enabled, branches are no longer
> recorded after the transition to CPL 0 upon PMI arrival. When branch
> entries are read in the PMI handler, the branch stack does not change.
> 
> E.g.
> 
>   $ perf record -j any,u -e ex_ret_brn_tkn ./workload
> 
> Since the feature bit is visible under flags in /proc/cpuinfo, it can be 
> used to determine the feasibility of use-cases which require LBR Freeze 
> to be supported by the hardware such as profile-guided optimization of 
> kernels.

Sounds good to me.

> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 4af140cf5719..e47ea31b019d 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -97,7 +97,7 @@
>  #define X86_FEATURE_SYSENTER32		( 3*32+15) /* "" sysenter in IA32 userspace */
>  #define X86_FEATURE_REP_GOOD		( 3*32+16) /* REP microcode works well */
>  #define X86_FEATURE_AMD_LBR_V2		( 3*32+17) /* AMD Last Branch Record Extension Version 2 */
> -/* FREE, was #define X86_FEATURE_LFENCE_RDTSC		( 3*32+18) "" LFENCE synchronizes RDTSC */
> +#define X86_FEATURE_AMD_LBR_PMC_FREEZE	( 3*32+18) /* AMD LBR and PMC Freeze */
>  #define X86_FEATURE_ACC_POWER		( 3*32+19) /* AMD Accumulated Power Mechanism */
>  #define X86_FEATURE_NOPL		( 3*32+20) /* The NOPL (0F 1F) instructions */
>  #define X86_FEATURE_ALWAYS		( 3*32+21) /* "" Always-present feature */

Could you please port this to the latest upstream kernel? The 3*32+18 slot 
is now used for another purpose, and we need to define a new synthethic 
CPUID word, word 21 if I'm counting it right.

Don't forget to increase NCAPINTS from 21 to 22, and consider the fixed 
asserts in the x86_bug_flags[] definitions in <asm/cpufeature.h>, and the 
asserts in <asm/disabled-features.h> and <asm/required-features.h>. This 
new word should probably be added in a separate preparatory patch.

Thanks,

	Ingo

