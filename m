Return-Path: <linux-kernel+bounces-17436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72876824D38
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117C1286991
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506EE5228;
	Fri,  5 Jan 2024 02:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="QmvXvQLw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00153C3C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 02:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d6b4e2945so11913895e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 18:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1704422825; x=1705027625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2H2S/jHoCdguv51SwRMhYVlu24yA+4PCf+eoTYNKKCo=;
        b=QmvXvQLw6qwPenzWB7kJ+lHJyxvwesJvdj/IvkHNqh5SQ4A3+lJOSWWaGz2AjK3Yma
         t8KTyT2cAlNWsvwDMLQUG4Ka1YIGZdN2px0Z0x6z5QpIIyLw9S91JMLR9iYrKrAAn7yn
         Iib5r7TXQJzz6Xb6OrKmDFZOgSn6ohPsz+MQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704422825; x=1705027625;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2H2S/jHoCdguv51SwRMhYVlu24yA+4PCf+eoTYNKKCo=;
        b=UC2Zv0o54KzBqZM4MlFwtnp8Kmx2/NFwv4BHdf5FfoJ9JfDiVwcd5vGgKgQJRurxT4
         x3XMGXnomW0pr780Gt/lqoAewHPNFqH0epvexMZnUBzXfKEMWtr8HxwAu5WDErAkllXe
         /cB/JjvTpSRL22aaxlp7HA6ujcYvIqLn4GZR42AFXn2MpfdcKF7+Qbfk0uFXf/nv+UUK
         gnQXJ++URBwhRB8h75xCWhb5TBK3wixfWuGslA/Uik+GkbDE2epNzEJ9NuGXppGGpQDR
         bJQbKUr+E4cXje3gOcCQdUvga7Wwqo6Bk2sxaxCd92xL3hrYP4/hKlUfpEsLz2d8zxsH
         oFOw==
X-Gm-Message-State: AOJu0YzFlBTKqsbNz5u4Bx33A9dgBp5xpKD3U6tUj2GN9hhNujCqIjyC
	g3OQtjfZc/RkGLbmMwTHxQnWYJ6z0vqs/w==
X-Google-Smtp-Source: AGHT+IHFK7rpfIKRWxDzlZF+K/r2ul/qxYlFZduNtGOQ7E8MqQmNW0yCENllbtQqDp7CzMvE8xIYeA==
X-Received: by 2002:a05:600c:2055:b0:40c:26a3:d778 with SMTP id p21-20020a05600c205500b0040c26a3d778mr547186wmg.208.1704422825051;
        Thu, 04 Jan 2024 18:47:05 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-110-223.as13285.net. [92.26.110.223])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c4e8c00b0040d81c3343bsm97237wmq.42.2024.01.04.18.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 18:47:04 -0800 (PST)
Message-ID: <11f2135c-2b64-4a90-95ee-358c3f6117b5@citrix.com>
Date: Fri, 5 Jan 2024 02:47:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: x86 SGDT emulation for Wine
Content-Language: en-GB
To: "H. Peter Anvin" <hpa@zytor.com>,
 Elizabeth Figura <zfigura@codeweavers.com>,
 Sean Christopherson <seanjc@google.com>
Cc: x86@kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, wine-devel@winehq.org
References: <2285758.taCxCBeP46@uriel> <ZZV65qJuJ67E_n9O@google.com>
 <1C37C311-CF8A-44EC-89B5-D826EF458708@zytor.com> <2451911.jE0xQCEvom@uriel>
 <B042BACA-839E-4A42-9BAA-AC7E58624250@zytor.com>
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <B042BACA-839E-4A42-9BAA-AC7E58624250@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/01/2024 1:02 am, H. Peter Anvin wrote:
> Note that there is no fundamental reason you cannot run the Unix user space code inside the VM container, too; you only need to vmexit on an actual system call.

I know this is going on a tangent, but getting a VMExit on the SYSCALL
instruction is surprisingly difficult.

The "easy" way is to hide EFER.SCE behind the guests back, intercept #UD
and emulate both the SYSCALL and SYSRET instructions.  It's slow, but it
works.

However, FRED completely prohibits tricks like this, because what you
cannot reasonably do is clear CR4.FRED behind the back of a guest
kernel.  You'd have to intercept and emulate all event sources in order
to catch SYSCALL.

I raised this as a concern during early review, but Intel has no
official feature to take a VMExit on privilege change, and FRED
(rightly) wasn't an appropriate vehicle to add such a feature, so it was
deemed not an issue that the FRED design would break the unofficial ways
that people were using to intercept/monitor/etc system calls.

~Andrew

P.S. Yes, there are more adventurous tricks like injecting a thunk into
the guest kernel and editing MSR_LSTAR behind the guest's back.  In
principle a similar trick works with FRED, but in order to do this to
Windows, you also need to hook checkpatch to blind it to the thunk, and
this is horribly invasive.

