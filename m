Return-Path: <linux-kernel+bounces-4574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC310817F84
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695141F244A0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953AA1842;
	Tue, 19 Dec 2023 02:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASA4Y0sy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29A61381
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 02:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d3cb1ccccbso1340001b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 18:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702951342; x=1703556142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Ddi859lp+o2Q6bh4j/OZybTU0nSFexpQuGGRFkYZ+Q=;
        b=ASA4Y0sy72eHWO+1rcrrwAneyt6+Ec3tKgzKe341R5gNxEQaDryqE7zI/JO33HffU0
         E9xS/tygg9sAmsqGxX9xrSte9lrYTGm0uwPSvCZZBTMXXCY2JcyGSjw8TSdfRnrnI0Ek
         Mx3UwBeq+L0kn3CV8P9gHYXlWD1xyGLrJZvdGW3SbBCLYzFntJx/glsRjIu/ZTp5rr2S
         tLWjeazrwohRwiH1Lsp3b5UJywQN9ogQvG59HCRxM57IdxXUS1D8xexKTotWA9jf71jU
         eeAUUz5Mgti6uIxIG/FZjY235KR45d1kNpXoE2yrn988jQIi0gZKe/dixxEbD1y6DFS2
         t5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702951342; x=1703556142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Ddi859lp+o2Q6bh4j/OZybTU0nSFexpQuGGRFkYZ+Q=;
        b=o9dJEPnoNlAWcsvsx+9nxgUVC8+PfAexn0ToEZmHcqaC4qXjJoJQFTi6fQ/mb+ImFy
         /dSb3zaY3psLxFlHtlfQIIJ9ux0ePe0wGgaLZx48nO98qbX6aSr/Voi02qbnG3Cy7xbu
         N9hWRjW0yISrdVSUQF0ji582Nmkvntu1aqCGF6Zg8UwFYgpsuPfiCvrhEZhrEMdxgLcj
         x7uYK+kYV4E3F7ZxzVnIXZSsiVYRKk+p6u5SD1K29P6q+eiBtI9YDMQYHEYLWr/WdycS
         Rksjj40WELp6PfWWAHjQMFqRqkz1oJRsG+isIe5q3l9zz7sw5Vn2wH30YPQYLrzJacQy
         +daw==
X-Gm-Message-State: AOJu0YwnNcr4KimTt267pveuAj4ccjWIQsc1V6sa00eg8FkDar0NATVl
	nABqJlxIxN4dV2moK8RvG/r7z83j88w=
X-Google-Smtp-Source: AGHT+IGQO/yFNZRfAGAkPq9RAOAcRyZY4vqOZcfY41afjOC0Kujo77iPoG2Qc09j95EsprDRcHz5kA==
X-Received: by 2002:a17:903:124b:b0:1d3:34cb:2324 with SMTP id u11-20020a170903124b00b001d334cb2324mr7974429plh.88.1702951341872;
        Mon, 18 Dec 2023 18:02:21 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id q19-20020a170902bd9300b001d06df5c1absm19791823pls.86.2023.12.18.18.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 18:02:21 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: akpm@linux-foundation.org
Cc: bhe@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	dyoung@redhat.com,
	hbathini@linux.ibm.com,
	hpa@zytor.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	seanjc@google.com,
	tglx@linutronix.de,
	tiwai@suse.de,
	vgoyal@redhat.com,
	x86@kernel.org,
	ytcoode@gmail.com
Subject: Re: [PATCH 2/2] crash_core: fix out-of-bounds access check in crash_exclude_mem_range()
Date: Tue, 19 Dec 2023 10:02:13 +0800
Message-ID: <20231219020213.33197-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218092902.9fae480cfcad3874e9e7236f@linux-foundation.org>
References: <20231218092902.9fae480cfcad3874e9e7236f@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 18 Dec 2023 09:29:02 -0800, Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon, 18 Dec 2023 16:19:15 +0800 Yuntao Wang <ytcoode@gmail.com> wrote:
> 
> > mem->nr_ranges represents the current number of elements stored in
> > the mem->ranges array, and mem->max_nr_ranges represents the maximum number
> > of elements that the mem->ranges array can hold. Therefore, the correct
> > array out-of-bounds check should be mem->nr_ranges >= mem->max_nr_ranges.
> > 
> 
> This does not apply after your own "crash_core: fix and simplify the
> logic of crash_exclude_mem_range()".  What should be done?

Hi Andrew,

I actually prefer the "crash_core: fix and simplify the logic of
crash_exclude_mem_range()" patch as it makes the final code more concise and
clear, and less prone to errors.

The current code is too strange, I guess no one can understand why there is
a break in the for loop when they read this code for the first time.

Moreover, I think the current code is too fragile, it relies on callers using
this function correctly to ensure its correctness, rather than being able to
guarantee the correctness on its own. I even feel that this function is very
likely to have bugs again as the code evolves.

However, Baoquan also has his own considerations, he suggests keeping the code
as it is.

The link below is our detailed discussion on this issue:

https://lore.kernel.org/lkml/20231214163842.129139-3-ytcoode@gmail.com/t/#mfd78a97e16251bcb190b0957a0b6cb4b0a096b54

The final decision on whether to apply that patch is up to you and Baoquan, if
you choose to apply that patch, this patch can be ignored. But if you decide not
to apply that patch, then this patch must be applied, as it fixes a bug in the
crash_exclude_mem_range() function.

Sincerely,
Yuntao

