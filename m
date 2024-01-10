Return-Path: <linux-kernel+bounces-22695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DBC82A1BC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C54691C22421
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3145D4EB32;
	Wed, 10 Jan 2024 20:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="T6RHGr2k"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E3E4EB22
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 20:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50ea9daac4cso4683542e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 12:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704917550; x=1705522350; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j/W48WRbWXjaejLdl98CUbgyVnk/kNZxFwIvFC+Mx98=;
        b=T6RHGr2kUpB1Oof70t8aBlXDJvm7phnHMGqbfoer11UxW/nVcjWDVEIxPRQ2Q0FJAr
         kkEl+Uy8W8cZHXHX04zC3xMldRd7fJfWlmTKEyaNk14DJatB7qY6GpX7N5QSM1qXByJR
         cZ2P0ncev31WjJ6Zz3CTVtE9ePag9Nm1jkgXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704917550; x=1705522350;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j/W48WRbWXjaejLdl98CUbgyVnk/kNZxFwIvFC+Mx98=;
        b=m9UEHMJv9IgzJsqwesq/NBillAtm6oMvEM/PVmvCjRDrnBqVQ6bIlI+dXeFRg9Zqkm
         3etHVN5UxKVlkcHl7PyUt7L8ATF+nt9qVFaHYRLvo+dtDhaeOCH6d6Bgq7fSvNwgI8rq
         o1ab2MNMrDGkZHLHT1rFc4VH90oJwIMJ/vzwQK1GBKM+FFBKcChg89aUzcEzxxrkmNqq
         fIEIGrhApV4INmnWM1JMdbIdC8Q8usXcfEBcRC56WH7JpdhLVDoaVcv3ToM25qdrdeBr
         WGm2ZQQwi6ssX+Pcqf9mBw93nzNogB2d7bvZdYtaxNPlXT6BmCB4DpNXhnLjm09ngwl7
         qvzw==
X-Gm-Message-State: AOJu0YwR0Cy8ut/C1C3ITkc1sTZ15Req9LI6M3c2hlsCgFCNQnmi4n72
	9mZB3HTmGcJQmDC1GocWOP2mUweH0BMy+SnCIwOZMyRrroa2Y98y
X-Google-Smtp-Source: AGHT+IH3Oxxpr766N/uQ1rICB2V8hahJv8ep1vUZWYy8dzVsw0VNm0gvrYE4TpiOzOv68UkPfRuX/g==
X-Received: by 2002:ac2:5edb:0:b0:50e:8eaf:9479 with SMTP id d27-20020ac25edb000000b0050e8eaf9479mr740326lfq.56.1704917550100;
        Wed, 10 Jan 2024 12:12:30 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id y17-20020a1709063a9100b00a26a061eef8sm2388519ejd.69.2024.01.10.12.12.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 12:12:28 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e4d515cdeso26851365e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 12:12:28 -0800 (PST)
X-Received: by 2002:a05:600c:45c3:b0:40c:2b16:1dd with SMTP id
 s3-20020a05600c45c300b0040c2b1601ddmr781757wmo.93.1704917548264; Wed, 10 Jan
 2024 12:12:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401081028.0E908F9E0A@keescook> <CAHk-=wgznerM-xs+x+krDfE7eVBiy_HOam35rbsFMMOwvYuEKQ@mail.gmail.com>
 <D01C78AC-830C-4D73-9E9F-7FD38CEF2E82@kernel.org> <ZZ2W_xzCSyOgltad@localhost>
 <CAHk-=wi75tFVtZdzFRr4hsDeUKmeACbgD46rLe+2bcd=4mHBBw@mail.gmail.com>
 <ZZ3_Jmb1sb2wQWO_@localhost> <202401101120.68DCE0F@keescook>
In-Reply-To: <202401101120.68DCE0F@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Jan 2024 12:12:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=whxOChYqdUs4Ys+tbogUDrKWj+CRwTQBOMACE_b0xPuvg@mail.gmail.com>
Message-ID: <CAHk-=whxOChYqdUs4Ys+tbogUDrKWj+CRwTQBOMACE_b0xPuvg@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.8-rc1
To: Kees Cook <keescook@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Josh Triplett <josh@joshtriplett.org>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jan 2024 at 11:24, Kees Cook <keescook@chromium.org> wrote:
>
> I've been trying to figure out how to measure only the execve portion of
> a workload (with perf)[1] to get a more real-world measurement, but the
> above does show improvements for the "open once early". I'll get the
> behavior landed in -next after the merge window closes, and we can
> continue examining if we can make do_filp_open() better...

Well, so the workload that shows the "early open" issue most is
actually something disgusting like this:

    #include <unistd.h>

    int main(int argc, char **argv, char **envp)
    {
        for (int i = 0; i < 10000000; i++)
                execve("nonexistent", argv, envp);
        return 0;
    }

and it's trivial to run under perf. You'll get something like this
with my patch:

   8.65%  [k] strncpy_from_user
   8.37%  [k] kmem_cache_alloc
   7.71%  [k] kmem_cache_free
   5.14%  [k] mod_objcg_state
   4.84%  [k] link_path_walk
   4.36%  [k] memset_orig
   3.93%  [k] percpu_counter_add_batch
   3.66%  [k] do_syscall_64
   3.63%  [k] path_openat

and with the hacky "open twice" you'll see that kmem_cache_alloc/free
should be much lower - it still does a kmem_cache_alloc/free() pair
for the pathname, but the 'struct file *' allocation/free goes away.

Anyway, you can see a very similar issue by replacing the "execve()" line with

                open("nonexistent", O_RDONLY);

instead, and for exactly the same reason. Just to show that this issue
isn't execve-related.

I really think that the "open twice" is wrong. It will look
artificially good in this "does not exist" case, but it will penalize
other cases, and it just hides this issue.

Without either of the patches, you'll see that execve case spend all
its time counting environment variables, and be much slower as a
result. Instead of that "strncpy_from_user()", you'll see
"strnlen_user()" and ccopy_from_user() shoot up because of that.

The above perf profile is actually quote good in general: the slab
alloc/free is a big issue only because nothing else is.

Oh, and the above profile depends *heavily* on your particular
microarchitecture and which mitigations you have in place. System call
overhead might be at the top, for example.

And the cost of "strncpy_from_user()" is so high above not because we
do a lot of copies (it's just that shortish filename), but simply
mainly because user copies are so insanely expensive on some uarchs
due to CLAC/STAC being expensive.

So even a short filename copy can end up taking more than the whole path walk.

So your exact mileage will vary, but you should see that pattern of
"kmem_cache_alloc/free" (and the "strnlen_user()" issue with none of
the patches being applied) etc etc.

                     Linus

