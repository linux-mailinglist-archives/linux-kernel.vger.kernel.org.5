Return-Path: <linux-kernel+bounces-163925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9BC8B75F0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CCFA1C22737
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB02171652;
	Tue, 30 Apr 2024 12:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rCUkLJkh"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111F817107D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 12:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714480891; cv=none; b=rqmYU2mj1n5Mh2qlc0vodHnD0iFjjzJRZQYgONDHU7HuaP7p4L9HyJt9XmyNh5+wNP8TQg/Ur/FcalLdFarp/cbZUT0IhJm+iGFtIdCuwZYAGKOT8fJ9nYDwwuenMNku5eBP27OWVvVDfNwoP0BKSil8kIJYfRH3ARd5Ywd7GDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714480891; c=relaxed/simple;
	bh=EAkzlUPf87vK95pHRAftB3pj+wg3xtsMqv6zZ2xItvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gGn20xYNfz8oTK/1XBTKgp1Un4RwVH04uh+46B7cmiOD9GalZDllN0zLk8QY3Jq3Qpo12M53vWRhL5CoSc2DN3Cr7oAcJtiSpI29pGEtY/4dnsakfp5MiKRVaStjRGi9SKu0XNB8tutTZT3AijItAYkFTaIPNAMMMZRjQu4G+XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rCUkLJkh; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51d62b0ecb7so4351918e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 05:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714480887; x=1715085687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z1zoRl9JNX91wxTFZ95WC2aOVdcvQqQ9ebO1YgbX9Wg=;
        b=rCUkLJkhLTkgj0vZihEKMMlayMlyQ0cFd5TjQa4r0Jddy9PM8aCO1E3l7kk3Jz+SUF
         GTxeTJy6Av4km5bpOTg+yOSdPvXLSxOOjQOnHQ2TvI4NWTmDRXUzyCtCI6w4n7BCRqGX
         v4+oj/UExjkdmINHO5kKztJkDTG3sBR9dELu5NYmlYuEYKnM0rCgpyyvYeDrL9ZYplzq
         iS3G0yI2yJVRGCkMXuuwWC4nn+VzEi5zzi8/pE6CeziV9EPrz4BvedgrUJ9mrXQ5Csgr
         13a2BhyUlVwR/HKh44guz0Y+9aQRhc91cb/h1t+FvIAqWHgb/xjcLN8z5V0kus9g72LW
         4QRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714480887; x=1715085687;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1zoRl9JNX91wxTFZ95WC2aOVdcvQqQ9ebO1YgbX9Wg=;
        b=VifFfzon+Yc7bZepPLtverQVV4WKGw62nBrme/An10Ra/E1De42thJwMxbynGT1EuX
         cLElEPfE/VeSv/xkf/L5ztlx+6NYILz/DqKmz7mBKnRcPRjHVVGVw/yONK3KJI21iHuN
         cI6sHuHpKMv7WMo+mJ+Uh6LnO6kEfVYtimR7mWlgmqCzHV58m0G3PvNBdNwUysRl4O5M
         gfQImQHADDfmdiwvQpmgTFe/bL1yGJZgr/BbrFiLQCQ5GWlR+zv9UQZwJuF/IuOMbfl2
         nzhMlB1eMWLx4OqfCBXyVNy9YAo/+YWcNxlDzC1TEhJ3X1tWOHVqC+RDjaEmsKqu9WD2
         z9ww==
X-Forwarded-Encrypted: i=1; AJvYcCXYZRp/7SzmJGgmQ0eIz4dAVZWymhtTSjsKjfoGmgWhk9TenmChGOuXMCgiNyYfhdxpyh6IalZjK9Mqtr1NvNc8XAH+ILldrTL5GY7E
X-Gm-Message-State: AOJu0Yww+Q+DcLC835lK3xcGha2vGgjZ5+68YdGmb7qm8+NEZMZLtFPL
	SyX0TMhDSe5rLCMUsYxl5YuJyLMAURR4KtttM2QuQLuiH0rcwXNPmnURo/m2uE0=
X-Google-Smtp-Source: AGHT+IE/W9/dkxBso0irV5VrVX3LkNO5o5h+kLfYM+38G90SJ9h02blz/dj31DJFXSXcVMXms6NQew==
X-Received: by 2002:a05:6512:45c:b0:51c:2c7e:ac92 with SMTP id y28-20020a056512045c00b0051c2c7eac92mr11527071lfk.23.1714480887229;
        Tue, 30 Apr 2024 05:41:27 -0700 (PDT)
Received: from [192.168.69.100] (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr. [176.184.55.179])
        by smtp.gmail.com with ESMTPSA id i27-20020a17090639db00b00a58eab2bf0fsm3928326eje.179.2024.04.30.05.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 05:41:26 -0700 (PDT)
Message-ID: <c5248d22-672d-4acc-9b12-86815d6e22dc@linaro.org>
Date: Tue, 30 Apr 2024 14:41:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/16] module: make module_memory_{alloc,free} more
 self-contained
To: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>,
 Donald Dutile <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>,
 Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Huacai Chen <chenhuacai@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Luis Chamberlain <mcgrof@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Nadav Amit <nadav.amit@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Russell King <linux@armlinux.org.uk>, Sam Ravnborg <sam@ravnborg.org>,
 Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 bpf@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
References: <20240429121620.1186447-1-rppt@kernel.org>
 <20240429121620.1186447-6-rppt@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240429121620.1186447-6-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/4/24 14:16, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Move the logic related to the memory allocation and freeing into
> module_memory_alloc() and module_memory_free().
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>   kernel/module/main.c | 64 +++++++++++++++++++++++++++-----------------
>   1 file changed, 39 insertions(+), 25 deletions(-)

Nice code simplification.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


