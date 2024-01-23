Return-Path: <linux-kernel+bounces-35512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96951839235
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C7729547E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620AB5FDB4;
	Tue, 23 Jan 2024 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="tUWJUe48"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706AC5FDA1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022669; cv=none; b=ZXCUjrQADVfKFtG57W12Wf9AiP8Qyuyqm0/XsjFYlw6MqrlxsI3HjBdYzy8QyzyOEym4Bw9lIZzwdB65hOVhSjsLR4OQIJDPpxpFWQ0y/KUR7xFslZiUlzDVlgSUIO3llJJ98mU/GxTYgKu4q97sTWj7hGBVlzR7cQKpP+A66T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022669; c=relaxed/simple;
	bh=zfo4K02LIHKNeJfY1nYMveQnev4v7V0gPyH1RcMLZT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PakYkzJP4qzRYeqkTLx50RhschTqYvRUr1GCnd/VVLTNxmnvC/b3E1+DxPBRZuWi3YUBTUtNWT6gx9DAG2UxRuKgLe54d7gshCeJNTdu7pqidI+9aqZS2ddgpdak9IPYRexZrO4tbHce7kqMMVPs7YI/8VxVPrpKI8M3/EwFWfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=tUWJUe48; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3394446205dso605311f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1706022666; x=1706627466; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zsl/7GB8mLkTbghZ8k3RJP7xDY8xQ2VmTN1DxHEnNkg=;
        b=tUWJUe48XHunZ9Rfw3W40bEG8eqcybv5AC5t3wODvEyKDheYefsWbEr4QurHqbQYP7
         JeBeR2inmLEN9aRz5SoQ4zJL5XP+aBbT3B3dBkEfxueNGGkUtS8LUcJgfdvvfycCY7Rp
         4qg9kmveN7vrNCwN0tevgXvL6kV/NUqXqnTKjPq+FJTZv4dCxIeCkJTP41glK2EAWdHK
         N5YyFqcEvmkHLEql+SzSUa7tCcGMl5CxxJ6NOgCotO24Y7B7TZZW0YI+e4VALtLjUOAb
         6XbCGBDIfOOuuiMcysQ8dHBZKMQ5quIs1Tv4tPClSE7r9nZqNDFijmVx1j+5GK+vqc8h
         g2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706022666; x=1706627466;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zsl/7GB8mLkTbghZ8k3RJP7xDY8xQ2VmTN1DxHEnNkg=;
        b=uwSKk3P+AZrHpGXMeHNUOWTLp82TkcgsIeJxQOIcG75bNi6sbD3ghisPfbc3L6mCzi
         mq1w++ExcH2m/UsjrvMWPNIyXhfyle2TVm+Iq95kKE7+JnKf5Wo97MOzpC/eJiIoe2JG
         UtbOYkLrLGl12VoBh97xxJ6z2CiGNhD0tx11mAvb0VSa+Z/cJKb4Q2fBobTgd6z1DDKb
         EtjHORKmQoST+uRUS4v5FmyjfZxClmTXYVV1UkTXlkYMCsXXWiv7UIEnv6lvK4P/4uXJ
         xJ5rbIah6OktLxKWXYcRsLBZv/agK1F30hH7GpSzAXwq7RmHUnE32574tI0yiqmQ0GdG
         AO1w==
X-Gm-Message-State: AOJu0YynJxGJxah4/5LFOxrsJntexWGVuY5E1foupjbRoiGxdtqhhGI5
	srna93r7qZ119pKgIjVDPqgUnViCyd8UW9WiHDumeRmBNu690i7Ev2at/os5Ios=
X-Google-Smtp-Source: AGHT+IGwFc3cfRZvt0Bggv2cC3e4b5nf882Tcy4F+xnhQwtxfGuC4Wl/QsA7DXC4/1RG6BiJTLDRXA==
X-Received: by 2002:a5d:4d0a:0:b0:336:ee8a:a44e with SMTP id z10-20020a5d4d0a000000b00336ee8aa44emr2558160wrt.94.1706022665555;
        Tue, 23 Jan 2024 07:11:05 -0800 (PST)
Received: from [192.168.0.20] ([89.159.1.53])
        by smtp.gmail.com with ESMTPSA id u7-20020a5d6da7000000b00337d735c193sm3583401wrs.49.2024.01.23.07.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 07:11:05 -0800 (PST)
Message-ID: <d21298d9-fed6-4e08-9780-dbcb388b9ccc@smile.fr>
Date: Tue, 23 Jan 2024 16:11:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] kconfig: remove unneeded symbol_empty variable
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Vegard Nossum <vegard.nossum@oracle.com>
References: <20231125163559.824210-1-masahiroy@kernel.org>
 <CAMuHMdWm6u1wX7efZQf=2XUAHascps76YQac6rdnQGhc8nop_Q@mail.gmail.com>
From: Yoann Congal <yoann.congal@smile.fr>
Organization: Smile ECS
In-Reply-To: <CAMuHMdWm6u1wX7efZQf=2XUAHascps76YQac6rdnQGhc8nop_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 23/01/2024 à 13:54, Geert Uytterhoeven a écrit :
> Hi Yamada-san,

Hello,
 
> On Sat, Nov 25, 2023 at 5:36 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>> This is used only for initializing other variables.
>>
>> Use the empty string "".
>>
>> Please note newval.tri is unused for S_INT/HEX/STRING.
>>
>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> 
> Thanks for your patch, which is now commit 4e244c10eab345a7
> ("kconfig: remove unneeded symbol_empty variable") in v6.8-rc1.
> 
> When running "make <foo>_defconfig" with <foo>_defconfig an SMP
> defconfig without explicit configuration of CONFIG_LOG_CPU_MAX_BUF_SHIFT,
> the aforementioned commit causes a change in the generated .config:
> 
> -CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
> +CONFIG_LOG_CPU_MAX_BUF_SHIFT=0
> 
> It looks like CONFIG_BASE_SMALL=0 is treated as a string instead of
> the integer number zero?
> 
> init/Kconfig=config LOG_CPU_MAX_BUF_SHIFT
> init/Kconfig-   int "CPU kernel log buffer size contribution (13 => 8
> KB, 17 => 128KB)"
> init/Kconfig-   depends on SMP
> init/Kconfig-   range 0 21
> init/Kconfig:   default 12 if !BASE_SMALL
> init/Kconfig:   default 0 if BASE_SMALL
> 
> Note that reverting 4e244c10eab345a7 is not sufficient to fix the issue.
> Also reverting commit 6262afa10ef7cc8f ("kconfig: default to zero if
> int/hex symbol lacks default property") does fix it.

(Since I'd really like 6262afa10ef7cc8f ("kconfig: default to zero if int/hex symbol lacks default property") to stay, allow me to try to help)

The problem is quite easy to reproduce:
  $ make x86_64_defconfig
  $ grep 'LOG_CPU_MAX_BUF_SHIFT\|BASE_SMALL\|BASE_FULL' .config
  CONFIG_LOG_CPU_MAX_BUF_SHIFT=0
  CONFIG_BASE_FULL=y
  CONFIG_BASE_SMALL=0
Here, CONFIG_LOG_CPU_MAX_BUF_SHIFT should be 12 not 0.

For what it is worth, CONFIG_BASE_SMALL is defined as an int but is only used as a bool :
   $ git grep BASE_SMALL
  arch/x86/include/asm/mpspec.h:#if CONFIG_BASE_SMALL == 0
  drivers/tty/vt/vc_screen.c:#define CON_BUF_SIZE (CONFIG_BASE_SMALL ? 256 : PAGE_SIZE)
  include/linux/threads.h:#define PID_MAX_DEFAULT (CONFIG_BASE_SMALL ? 0x1000 : 0x8000)
  include/linux/threads.h:#define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE_SIZE * 8 : \
  include/linux/udp.h:#define UDP_HTABLE_SIZE_MIN         (CONFIG_BASE_SMALL ? 128 : 256)
  include/linux/xarray.h:#define XA_CHUNK_SHIFT           (CONFIG_BASE_SMALL ? 4 : 6)
  init/Kconfig:   default 12 if !BASE_SMALL
  init/Kconfig:   default 0 if BASE_SMALL
  init/Kconfig:config BASE_SMALL
  kernel/futex/core.c:#if CONFIG_BASE_SMALL
  kernel/user.c:#define UIDHASH_BITS      (CONFIG_BASE_SMALL ? 3 : 7)

Maybe we should change CONFIG_BASE_SMALL to the bool type?

I'll poke around to see if I can understand why a int="0" is true for kconfig.

Regards,
-- 
Yoann Congal
Smile ECS - Tech Expert

