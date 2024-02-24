Return-Path: <linux-kernel+bounces-79856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7808627A5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CA74B21AF6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33994CB57;
	Sat, 24 Feb 2024 21:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="evNOEqwE"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47BD4C615
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 21:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708808561; cv=none; b=Wtf3nMoHW5mwXROwFZTj1PlBA4VLfqXjLpXpRN1gnpIHU81Qo9o4npd3vf9bvAJlkehU21YP386InMDDssrsmVcVDpnzzQnRI2AFofGRGxHhZgaZI8LxaxHLsvC+fsa/SP+3YpW6mbYdgu+/IUG8Cs0GLT8LzDwa3IMkZka8NBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708808561; c=relaxed/simple;
	bh=JeSfqNzV+hjrodRVul1OWjCnx52kVLE0+GAVqZKqcsQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NxFNZaLLtkbWoHeVKIcJeF5VLVmgW8rfJqYw7oj9SsM/ByhD2XRLWQAK+byTM1+GF2jlYeFkfHvy33z8BeaPvBGZy042Hgs3m6a4lacd3uZX4CkvQifrrnYoKqzWmHV1Ye/wJU6ehUWwq4wv1N+NXWjwe/xN8UECkqdRDIMdKWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=evNOEqwE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dbe7e51f91so84325ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708808559; x=1709413359; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1bYqSsxfIR9raHGk2lM7F1xz8yf+qiSkrL7Pgn11QAY=;
        b=evNOEqwETZDHqwn16aQKkzF7wU3KJK23BJ77MUTyxfbybr+lBSOIW5GXw8z+8QYG0v
         Pj9SCbXxI5HnivJEAyCs+l0EKPUFaGG3zQRMZhPRn3/BFtDlAZTKciTqQ8usxa23a1bX
         p0AtxWrllprUa/049wKdicdFRl50yPLPibarsDRwrh9raubA7/mw/J0lCBuidikdlsN3
         ZteKs/Fmihcqa0RTlU/rLyBP79A8VGzh3wdSCQIDspeD8X24D3CJolka6PuF2o02hKQM
         mesCWLLG9JQ1SW5ZCbDU0TUzc0cHMG+2pJOZ9pbzQAo0HIoUK5myJ4cDHvAQi6E93zBM
         Bhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708808559; x=1709413359;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1bYqSsxfIR9raHGk2lM7F1xz8yf+qiSkrL7Pgn11QAY=;
        b=vchuZ6vQRcXeuwAWyYf222sFe/8iZ7JwBx3Wv6pc+a8I/jGjK8ZRhslyzzxV37yK6h
         Y/TTLM17/0Ca8tICgMM1k4eILxVhUjV3YYx6hu7Z6hsMXACytEYL8GNbSViJhTKJfyRQ
         L53BafY8RKqun1vZcbTAqHYkcJ2f3CKipF5xFtkfZ3UxL6oIFqvLIlyZAFYTdLcYz2Yd
         zzNu8pq8SqFlObWQsuK242AWrUfPIETGLWIny1s4WpnbI3GCTYi7kIDLL9xOU8Xm3+RK
         gYxtcwkUNyT6KO1udHme9i51AfjXQVoS0iUi/8kakXHjlsrjsQt53Dl8+RXLJoxloxvZ
         c5Ig==
X-Forwarded-Encrypted: i=1; AJvYcCWe+6s5AD/NbKX8MydREc/FCzb56+9MMF2Isi7iJcDAHbTpigb9JnOnHY9fI06w96WgeZFYz3TbqxYxcxLTR4uPaYyQR0S5mDD7yqcW
X-Gm-Message-State: AOJu0YzYIrPKb1c91QdBO0adjq/lkXIjvyBJIIJy3q7TvSk9Ri5q0udi
	qnZHgVJ9wFtMkiGuj7ocoQNEzJWTnotIMm87M6Lem0gRSR2uKci+nKoM7KvqZw==
X-Google-Smtp-Source: AGHT+IGGyN0+Lq0dJjkH/u6UzcVRpqCLoMm58Et5/84c8134LsHcFyGkJu9hOwFdD4fqhywSU7MU+Q==
X-Received: by 2002:a17:903:32cc:b0:1dc:7b9:196d with SMTP id i12-20020a17090332cc00b001dc07b9196dmr190478plr.18.1708808558515;
        Sat, 24 Feb 2024 13:02:38 -0800 (PST)
Received: from [2620:0:1008:15:ce41:1384:fbb2:c9bc] ([2620:0:1008:15:ce41:1384:fbb2:c9bc])
        by smtp.gmail.com with ESMTPSA id c10-20020aa781ca000000b006e4ce93dc28sm1468928pfn.104.2024.02.24.13.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 13:02:37 -0800 (PST)
Date: Sat, 24 Feb 2024 13:02:37 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Vlastimil Babka <vbabka@suse.cz>
cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
    Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
    Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
    Alexander Potapenko <glider@google.com>, 
    Andrey Konovalov <andreyknvl@gmail.com>, 
    Dmitry Vyukov <dvyukov@google.com>, 
    Vincenzo Frascino <vincenzo.frascino@arm.com>, 
    Zheng Yejian <zhengyejian1@huawei.com>, 
    Xiongwei Song <xiongwei.song@windriver.com>, 
    Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v2 3/3] mm, slab, kasan: replace kasan_never_merge() with
 SLAB_NO_MERGE
In-Reply-To: <20240223-slab-cleanup-flags-v2-3-02f1753e8303@suse.cz>
Message-ID: <78910de2-097d-9dea-4e00-acaf40af0299@google.com>
References: <20240223-slab-cleanup-flags-v2-0-02f1753e8303@suse.cz> <20240223-slab-cleanup-flags-v2-3-02f1753e8303@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 23 Feb 2024, Vlastimil Babka wrote:

> The SLAB_KASAN flag prevents merging of caches in some configurations,
> which is handled in a rather complicated way via kasan_never_merge().
> Since we now have a generic SLAB_NO_MERGE flag, we can instead use it
> for KASAN caches in addition to SLAB_KASAN in those configurations,
> and simplify the SLAB_NEVER_MERGE handling.
> 
> Tested-by: Xiongwei Song <xiongwei.song@windriver.com>
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Tested-by: David Rientjes <rientjes@google.com>

