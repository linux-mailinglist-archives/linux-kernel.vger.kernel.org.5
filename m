Return-Path: <linux-kernel+bounces-20585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FA18281E3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6108287AA9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAC7364DB;
	Tue,  9 Jan 2024 08:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnkKTu8n"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3210364CA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 08:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2b4aba3a8aso36021466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 00:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704788917; x=1705393717; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=12NVFfjg6W1Zi5ETWmGcRAxyHlBNBpcW/SmCJ7rMyZU=;
        b=OnkKTu8n9LL9OHSXgNKZ4jtSuOJwJVa3ck1wZGyDmNKYHJDZLxtRDuGkwIfgfvbnjy
         ELXwALawZJLrfVc8NjUSHmD/sToyKeFXu1O581es978LX4R12W0/huVbDT/S9iG11MWf
         hS7N5St7sDKwwIH96z3FpvA0cBldxPWyT3m/mE1qWOotTsnxIGRIXoqRuDFfGtiQoj79
         AELvuS+vRpBjemjPkxNwXW+jCrWfcfQyof5BJFn2MX/JF4bhQbuHiP6hzvLfoskQPLj1
         Xc+L7nZY8BUMJsTkjB4yUCT8fmKvxclDjJ3Q+ox1QdkAsBhc/SqN6rnrTA635uRv2vfW
         VvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704788917; x=1705393717;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12NVFfjg6W1Zi5ETWmGcRAxyHlBNBpcW/SmCJ7rMyZU=;
        b=cNtBVpj16z8g0FTBiN3SxVqYOKnisZrdgTMeIGM1U7dSEQFl1oXBjdnZoTVmMkMfD4
         Tsj5lOF7aEU/AaOpUYp5IlW5hUCJnMu+BK8AZvvxe8D6+eStiTMqJ6t+xyMexVybIIGG
         X+N+5SEfVS6FY+QoNjXmQEePjZJTzK8DfJTbsIAX9gbXe4Y4nI1ssjyhiIsciKnuzCrQ
         uMY+UXcAQeu2gGOqmitAiOLERm6EsgLAfWz75KQj7JXWQcpYtMcbkoFeYgJiWePLxFAj
         Cw0ibkE6XY39URpxUOsZDp84QbSLVi1y3cTF/S9zBQvFhit+tUeEbQSYcpTjxf3PoRCd
         8Juw==
X-Gm-Message-State: AOJu0YzjmKOt50iaZHJW6W4u7fpMT6SlIP69/1VmnAsD3SXg2YF96DdT
	gXfbicgxGjOP1LcQ8Bn9+ub+O8dK3Hg=
X-Google-Smtp-Source: AGHT+IEtdNDiWhR6Lu2MoNrRV+FFwaUB7OCLNoQuEFe+Y3ttvz8IzAsXcdQRFDZ2Qh+f5KFc9714Pg==
X-Received: by 2002:a17:907:c1a:b0:a28:d0c5:535 with SMTP id ga26-20020a1709070c1a00b00a28d0c50535mr429135ejc.110.1704788916640;
        Tue, 09 Jan 2024 00:28:36 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id a23-20020a17090640d700b00a2a9dddb308sm753383ejk.121.2024.01.09.00.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 00:28:36 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 9 Jan 2024 09:28:33 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [GIT PULL] x86/mm changes for v6.8
Message-ID: <ZZ0DsS7LGJO0NAq6@gmail.com>
References: <ZZvd5KZKVXAtM1+F@gmail.com>
 <CAHk-=wi9aEe9BuiM2DQNsGoUg=ZeQS6EfOs+0pz3kTZ=qvf=pg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wi9aEe9BuiM2DQNsGoUg=ZeQS6EfOs+0pz3kTZ=qvf=pg@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 8 Jan 2024 at 03:35, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >  - Robustify pfn_to_kaddr()
> >
> >  - Improve the __untagged_addr() code: RIP-relative addresses are fine these days
> >    and generate better code, and update misleading/outdated comments as well.
> 
> This does not even compile for me.
> 
>   arch/x86/include/asm/uaccess_64.h: In function ‘__untagged_addr’:
>   arch/x86/include/asm/uaccess_64.h:25:28: error: implicit declaration
> of function ‘__my_cpu_var’; did you mean ‘put_cpu_var’?
> [-Werror=implicit-function-declaration]
> 
> WTH?
> 
> Maybe this has worked in your tree by mistake because there was some
> branch dependency that just happened to work out because you had
> merged things in a different order.
> 
> But that would very much not be ok regardless. Those branches should
> be tested independently, and clearly they were not.

Sorry about that and agreed. Indeed the build failure was hidden by another 
branch, and while I did test-build and test-boot the x86/mm branch before 
sending it out, but my test config didn't have CONFIG_ADDRESS_MASKING=y ... 
which ... masked the build failure. The bots that do per-tree testing 
didn't catch this either.

I've now sorted it out in our trees, will send the new x86/mm in a few days.

Thanks,

	Ingo

