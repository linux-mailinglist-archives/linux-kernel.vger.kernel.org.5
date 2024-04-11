Return-Path: <linux-kernel+bounces-141406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C32E58A1DE4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEDF21C24C74
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8762762CD;
	Thu, 11 Apr 2024 17:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="e5h19efo"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725365FBB1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 17:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712856649; cv=none; b=HebW7mBnrGeJwEQz9XjqIE8gI2HCD1sQNNTqt/FFszBxxTsVPyizQlK3Eu/3xeKbOk12a0FdDh0ilyvmTGapchAT+FHmlYSLgbIQ5b6xyfNeYxBt9t1xHCHBuxPjCCl+u6voX6YXpgpZaGXqxJr1rXjPRFhogi4MgQ6EQDOIUIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712856649; c=relaxed/simple;
	bh=3PkwqQkO6dIHQdTSHshUiLVbhfmQ6aY/jws2kagcCEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HI0mmzKHTmkD3bckVK+0iaIRphjFat/G6kUdYTZY7Y7ddUOqmyiXlA1IwGqZxYVWD2rgWpxo0jucDcK8OgVIcOce/udLvamLYHIsEG4amp2R2s82SD9uGKxxW39C50w/XMxm5eWAklzQJQr23jQUZPku9D/ed5llVxGyqDTAyXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=e5h19efo; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6edb76d83d0so136888b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712856648; x=1713461448; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GGDMriGqMWX2SVCYOCeQKA5ixlUpINxXv13ekIsefu4=;
        b=e5h19efoGzjh9FC7YvVBylvOODVzorSoY/Rm68WxH2rrtCxsKwQmgBkfNiu7qm0fmo
         tOWy+2ceVDCoz7CkFDqyEnpGIoCD9AlcPTkieWvQ1fDWH6UzzHip7T9cGnXFR8Utth5C
         7mXUMS8XpPHUJesb22k/xQYRWHU0VxAuCEl7zfg/OfZw8AhOmjQs6rPLPWxCLVmN4ju+
         IeJhYRn0QhIk7loTgyd4F+uGxFtSx0eiFcgc41iT7sr8t51cJkOG+8uucTeHwPfnwRN4
         088Y+PnynU5/2WE+eyH0hgXEevKx8TeakfpcixZ45HVgjafHswHoKjUxwGVAzysvlj2i
         IXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712856648; x=1713461448;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GGDMriGqMWX2SVCYOCeQKA5ixlUpINxXv13ekIsefu4=;
        b=xHqDYZyYF/0lWbTgvw1o9DQoyAxifxz271FzgWkOVagY4eryrCwn7kqFxZibkXWkNm
         9wR2QIQI9YjZ1tuR34qQhS8338i16y4NW6d/7dajaiTsQnkmrA4qXguEFpCTGxRUFx/0
         /8d6lxwliHvNMBqou06BbM4VWQEsTGbjPfjEdfUWXwfVr/V2XYajiA5GB8i96CzHHjKn
         gxbHtTGXkXdZO+5Gii/9pT+crPyAMGePZWP+cN/U17TYeJ62GeFKAB/g68KHjjYHOuwC
         ZF7yeeO0ebHX0emxhWR52PjaulTzMi5Es1zAaakPzFLSE+uCZKtaZv3QlaxKBUkTBR8C
         NnhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLZiy1XT/OTZBeYJG3k7PxdT043u0r7ydJs0r/lFoUV0EguIGR01PZeXevVFujHoKv/IlhEQcZht6dByVzPIKB9bpXjfIPyJq8uWN2
X-Gm-Message-State: AOJu0Yx8QkxG6HXIXFfgE3Z9X5VewUmux2Houh1XumN2QvOsvcE8kEBK
	hWNZdKXxYuy1G/cx+EWnC6aiLkEj3K87RuCP5n//pqsHf50/eQe+inKzA7vYPAM=
X-Google-Smtp-Source: AGHT+IEiCzzp+1vro1jXejp7+//Vm+SCAsdvTNELFf+yEQKsv8bqhP5mexbLlJAAyee/qs+Xz2R5zw==
X-Received: by 2002:a05:6a00:2d20:b0:6ed:4a97:5dec with SMTP id fa32-20020a056a002d2000b006ed4a975decmr493911pfb.20.1712856647747;
        Thu, 11 Apr 2024 10:30:47 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id x33-20020a056a0018a100b006e6c61b264bsm1436542pfh.32.2024.04.11.10.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 10:30:47 -0700 (PDT)
Date: Thu, 11 Apr 2024 10:30:44 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, nathan@kernel.org, ndesaulniers@google.com,
	morbo@google.com, justinstitt@google.com, andy.chiu@sifive.com,
	hankuan.chen@sifive.com, guoren@kernel.org, greentime.hu@sifive.com,
	cleger@rivosinc.com, apatel@ventanamicro.com,
	ajones@ventanamicro.com, conor.dooley@microchip.com,
	mchitale@ventanamicro.com, dbarboza@ventanamicro.com,
	waylingii@gmail.com, sameo@rivosinc.com, alexghiti@rivosinc.com,
	akpm@linux-foundation.org, shikemeng@huaweicloud.com,
	rppt@kernel.org, charlie@rivosinc.com, xiao.w.wang@intel.com,
	willy@infradead.org, jszhang@kernel.org, leobras@redhat.com,
	songshuaishuai@tinylab.org, haxel@fzi.de, samuel.holland@sifive.com,
	namcaov@gmail.com, bjorn@rivosinc.com, cuiyunhui@bytedance.com,
	wangkefeng.wang@huawei.com, falcon@tinylab.org,
	viro@zeniv.linux.org.uk, bhe@redhat.com, chenjiahao16@huawei.com,
	hca@linux.ibm.com, arnd@arndb.de, kent.overstreet@linux.dev,
	boqun.feng@gmail.com, oleg@redhat.com, paulmck@kernel.org,
	broonie@kernel.org, rick.p.edgecombe@intel.com,
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH 08/12] riscv: dynamic (zicfiss) shadow call stack
 support
Message-ID: <ZhgeRA3XplDw7kmm@debug.ba.rivosinc.com>
References: <20240409061043.3269676-1-debug@rivosinc.com>
 <20240409061043.3269676-9-debug@rivosinc.com>
 <CABCJKud622jAHZGiYed-2veynA6rd_=1mnTwnTT1WNQ6203q6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABCJKud622jAHZGiYed-2veynA6rd_=1mnTwnTT1WNQ6203q6A@mail.gmail.com>

On Thu, Apr 11, 2024 at 05:05:38PM +0000, Sami Tolvanen wrote:
>Hi Deepak,
>
>Thanks for the patches!
>
>On Tue, Apr 9, 2024 at 6:12 AM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> Adding support for dynamic shadow call stack on riscv. zicfiss ISA extn.
>> enables protection for shadow stack against stray writes. This patch
>> enables scs_* macros to use zicfiss shadow stack pointer (CSR_SSP) instead
>> of relying on `gp`.
>
>CONFIG_DYNAMIC_SCS implies that runtime patching is used to select
>between software SCS and an alternative hardware implementation (in
>arm64's case, PAC instead of hardware shadow stacks). I understand
>this series is still an RFC, but I didn't see runtime patching
>support. Are you planning on implementing this later?

Since I didn't see any example on selecting PAC when `CONFIG_DYNAMIC_SCS`
is selected. So I had that confusion but wasn't sure. I thought of doing it
but I don't know how to binary rewrite all the functions. It might be too much.
So I went ahead with using `CONFIG_DYNAMIC_SCS` in this RFC series.

Question:
If arm64 were to use PAC with CONFIG_DYNAMIC_SCS, how would it fixup the code 
sequences already setup by compiler for shadow stack push and pop in runtime?
You expect this to be some offline process using some object editing tool or
a runtime decision? 

>
>If there's no plan to actually patch between Zicfiss and SCS at
>runtime, CONFIG_DYNAMIC_SCS doesn't seem like the appropriate choice
>and we might need a separate config option that still allows you to
>reuse most of the software SCS code.

I wanted to avoid "#ifdef RISCV_SPECIFIC_HW_SHSTK" in arch agnostic scs code.
And that's why went with CONFIG_DYNAMIC_SCS which sets dynamic static key once.
And then I use `is_dynamic` everywhere else in arch agnostic scs code.
>
>Sami

