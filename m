Return-Path: <linux-kernel+bounces-54562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB02284B0BA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AEF21F2674C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CDA12D777;
	Tue,  6 Feb 2024 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R5ASdkTv"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7B712D74F
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707210264; cv=none; b=GLBC4oryOYEWVQ1m9RgO8BrJRJJFZ+74h7bPVfp9S+/cR4yUsckFBp4aX/6Bv4QcYC/hgr4D7SvwuUbebB0GNYWCM5SRmepGiPxQDZo+r7fj2FZryVBAl/IzlCUDJKXBTaafUspXI9NXzBNc5D1QRkbEvEcq3FxsG0DWcYzT6dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707210264; c=relaxed/simple;
	bh=Gp35uNMc518ajDUT+cimYa69HEsvONtpg4a3sm+E5kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPHmxpqUYSxSCKtGOpABku3f34s6lcaXIEew1FHRRPFgW8kQGJqatHOFsdTzMP2eILq0DcB8eWF9j/AMZ0DnB26sFrgjAtXl+qooXikpD1idciKGZ+PKOXzF7CAMG2lsJXYASuM2fYz/mErgCCMNcac5Bb8c5ILvjPny/xXEU2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R5ASdkTv; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56077dd7936so2024988a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 01:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707210260; x=1707815060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oT9eQF6EDyoyZsgVEyZNBHLPqezkyA6nguMaS8W3x+A=;
        b=R5ASdkTvxgylxekuA9je68pNt2bL2E6YftZlDXd4F2sZ4j2dhDuZ8RxTexiVSXlI/c
         F1+CVGN46UedV775iPAcK4YJGhxXvTVA6AxtavewWvUd5X/VmtFJA3Xib22OkcRIZsq0
         qDv8p7XDiIxg4RgqTd+L1/MPd6whNwwKSjoN1MXHkuF/ti5Gxmj14FF/ItBqamuO+oD2
         JGkxxjbj72gPT7v45Ayv7qWy5y/muPEs+5AZys93x4Pd/3doar+gSrSC4sak1L7JMi3G
         urDYjL0npZeEwJxd76qI+DqzKbKuzzwXVc0fKder3l5Dp7PDe8utJ+2U45A//5p+hVt7
         OgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707210260; x=1707815060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oT9eQF6EDyoyZsgVEyZNBHLPqezkyA6nguMaS8W3x+A=;
        b=ehXIwXBS3j/ypg5QJ8UpYXfXg2b8vmPLA2v+icSlLAwePeJgqikZkiizdoji6KOTeV
         codjFeJy8R0ltmcNAR+T2UIBB/P6L8A6fHwVcQdAstxUzKVU8ZlTO4aoJjjNRY+OYW6T
         P6eWFCh04JVdCFn+oaNCgRQKOZFE6W4P2yfhbLEaHapVQkTeexrspbWLKReEn2iWGqYv
         JuWdbaaSfP7Iia8+lEShPg61llH6/9TYrqffJFyalK1mc0m8i46LkyG3kzxM80xyvjfx
         v/j8Y5F5fYq2LxYzJAy3OfzTqgnQP+hvxnmSVb0RN9Mm3eE1AXQasnR0+hLO182ziLQF
         lU9w==
X-Gm-Message-State: AOJu0YznqPB0HaCSSi9P3uQOqkMR8KqBVO63/4gTi/Ktn56kospqiZLd
	vSXKnDdGKCufojMjPOK/5/7MHcFXiqJjcN2CLdHc44eM4wk/vHZOVhApRholFjo=
X-Google-Smtp-Source: AGHT+IHiM9uAumR+z22zTjpJ85plFmRYDxP1RdptBN/LMoDG9XbGtOvtI9Zo9Eq/Qwcb7wfE9rDM1g==
X-Received: by 2002:a17:906:7105:b0:a37:19f6:b4e7 with SMTP id x5-20020a170906710500b00a3719f6b4e7mr1410042ejj.24.1707210260659;
        Tue, 06 Feb 2024 01:04:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWjdEfLWTNrLTJxSl//LlhmFifLaLlKWAEvnFqcOgZ3nYQJpdSh/BWOkJBb4d1XHzLKWYFcIIRXU/WnpzE8AO8b5CpNtpHpkvLeXGwZsSnMHOmMqqpu/ZbFAEctlbG9Mj1ssHOqtg7XHJeSTlOCPnlRgIX3rh1LSF67Mc4o2q8t+rw4WtOO5cZcgwPbaZiba+bM95zsK7TNNtwesWt5Mh0c4Glf7hGxwUk7+Tma8zq+IHJ6VJtb/mmjAclwRs+2DvnYrF5Wz+CUvBPenGN7QMmjzXHZrSxQkUs2226VtpmAAK+YkUysmvqdkAGBRZQOL5S+oz0FBiZ0fSFUTJkJSji1fVKfd3Z85JKJVmQv7fz4672vQdLsSCwS82/iYCzZ+jXqesZVMnnGgWeir8W6BhmcvxXhXLNcTbyExmhEeBtH58wHU/RRCio8hKhGVZESWOHwu13zFZrcPILDgdmJEWoryvO5G+zT7Q/qBiyOnHu30G/J1LonCLCo43b/cTncTgfvxSUnCEnYTeySSwlTzoaPXw+aRByfJh4M7Knqnn0aPwmNmdSzM+KFTW72QJzpKCsbxDRtZ8T6lw4jzrHd8CNE5Vma1CaA/3PVW9riG0TOYp6tpcE8zXpxJvwd8tWOPmQIN+8mXRcbLZGlCdVc/g4AXGan/3SnnlTH4kDTeeqqzmgbB5unmLTwM+fzahS5OH8jXF87900B34PFw+QwPvdOBsV8+rBrgE4Cn869eAj25FNm27N/64JXtAvfjtLbqm316h2G
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d23-20020a1709061f5700b00a377ac3730esm897261ejk.2.2024.02.06.01.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 01:04:20 -0800 (PST)
Date: Tue, 6 Feb 2024 10:04:18 +0100
From: Petr Mladek <pmladek@suse.com>
To: Yoann Congal <yoann.congal@smile.fr>
Cc: linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	x86@kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Borislav Petkov <bp@alien8.de>, Darren Hart <dvhart@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Josh Triplett <josh@joshtriplett.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v4 3/3] printk: Remove redundant CONFIG_BASE_FULL
Message-ID: <ZcH2ElZd4BaySeGV@alley>
References: <20240206001333.1710070-1-yoann.congal@smile.fr>
 <20240206001333.1710070-4-yoann.congal@smile.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206001333.1710070-4-yoann.congal@smile.fr>

On Tue 2024-02-06 01:13:33, Yoann Congal wrote:
> CONFIG_BASE_FULL is equivalent to !CONFIG_BASE_SMALL and is enabled by
> default: CONFIG_BASE_SMALL is the special case to take care of.
> So, remove CONFIG_BASE_FULL and move the config choice to
> CONFIG_BASE_SMALL (which defaults to 'n')
> 
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>

This might also require updatating the default config files which
unset CONFIG_BASE_FULL. I mean:

$> git grep BASE_FULL arch/
arch/arm/configs/collie_defconfig:# CONFIG_BASE_FULL is not set
arch/arm/configs/keystone_defconfig:# CONFIG_BASE_FULL is not set
arch/arm/configs/lpc18xx_defconfig:# CONFIG_BASE_FULL is not set
arch/arm/configs/moxart_defconfig:# CONFIG_BASE_FULL is not set
arch/arm/configs/mps2_defconfig:# CONFIG_BASE_FULL is not set
arch/arm/configs/omap1_defconfig:# CONFIG_BASE_FULL is not set
arch/arm/configs/stm32_defconfig:# CONFIG_BASE_FULL is not set
arch/microblaze/configs/mmu_defconfig:# CONFIG_BASE_FULL is not set
arch/mips/configs/rs90_defconfig:# CONFIG_BASE_FULL is not set
arch/powerpc/configs/adder875_defconfig:# CONFIG_BASE_FULL is not set
arch/powerpc/configs/ep88xc_defconfig:# CONFIG_BASE_FULL is not set
arch/powerpc/configs/mpc866_ads_defconfig:# CONFIG_BASE_FULL is not set
arch/powerpc/configs/mpc885_ads_defconfig:# CONFIG_BASE_FULL is not set
arch/powerpc/configs/tqm8xx_defconfig:# CONFIG_BASE_FULL is not set
arch/riscv/configs/nommu_k210_defconfig:# CONFIG_BASE_FULL is not set
arch/riscv/configs/nommu_k210_sdcard_defconfig:# CONFIG_BASE_FULL is not set
arch/riscv/configs/nommu_virt_defconfig:# CONFIG_BASE_FULL is not set
arch/sh/configs/edosk7705_defconfig:# CONFIG_BASE_FULL is not set
arch/sh/configs/se7619_defconfig:# CONFIG_BASE_FULL is not set
arch/sh/configs/se7712_defconfig:# CONFIG_BASE_FULL is not set
arch/sh/configs/se7721_defconfig:# CONFIG_BASE_FULL is not set
arch/sh/configs/shmin_defconfig:# CONFIG_BASE_FULL is not set

Best Regards,
Petr

