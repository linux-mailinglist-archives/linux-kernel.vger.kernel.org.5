Return-Path: <linux-kernel+bounces-75499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B9E85E997
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E4721F24AA4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B36126F3D;
	Wed, 21 Feb 2024 21:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="e+G5mbqn"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7090F86AE6
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549801; cv=none; b=n4jyeLZiYUYvjSiOeDHwiVXDQn/WIj8NDxGw39bc4dEvndRIopbIspbtVvuiI9ggdyMK22wBJUfrvguuXeOJTmbxqAikDhToEIzez4nwopXu4UBTLngSIErDUH1ARdkGhWTNb7l7uAb5ZCt+nbYtEIF9cfyyyXYpi4ezIe9x8bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549801; c=relaxed/simple;
	bh=6G+unPQpsnHPop/GA0eV3gHBK3dDdnNrDGYdK1/13VM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dNXtDe/vaZFZkKrLl3GM+KCtiHse75sef9BuP82Qp0Uer/RD5/cBLu9Oihb22DQR1+VkrqooHSAWlCkca8kC6Mm4ag2efUNGtXEb6uqqlaLKYUYhV2WGecM3wojp5KUwd3MvWc2XW7bnxCPPovT0cwvGtJIbVunuRP786elI+vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=e+G5mbqn; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-42dc86cc271so37875931cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708549798; x=1709154598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6G+unPQpsnHPop/GA0eV3gHBK3dDdnNrDGYdK1/13VM=;
        b=e+G5mbqnwfVcZfCDCbvTTzq7jGtQao3+ljNOQCApBH1Or7jjEbck/m99Tqi7OZuUuN
         VHrjxvPGI1XvNcckdp07xBlec7/cV1+OA8rq3PsA+bx9xSY0/tsTZ/Yx6sA2qVK5ECm6
         90pO1gMJjgvDkOuX3a3aVoTQkHNPoXEefexVQpRz5vThiKoPiSX9wjHnofpAOKxifsbr
         IP2L0czeTZW9pHYkoRwEKfnsCcz5C9a4s4Km0KtOQPnenrQqMi66vIBjWnsGGlm4jXT6
         DpSLqXXX/7Mq02PhPVS5BQ7gYkj56SAQ7cZLdgVUUTbNSs4oQR9xqMlT5Wt/xsDgMblq
         IznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708549798; x=1709154598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6G+unPQpsnHPop/GA0eV3gHBK3dDdnNrDGYdK1/13VM=;
        b=tRmFUJrZacjuCEG+ndAGl3sJb0xKTgrp5HnKS+Fi1P72SSswnisNmjivGVhPmXtacc
         q0fwut8/1h7+YGsGaOxFODgoXu1UA53Klxwqhyk8qX752j5FbXtjxbMt3UvhHKAaD2uB
         0gy8JPKSQYOBksVP9N6usudK9IYVhfm2GPhYN+JlricGVo9Cv5spDY0WcWg3tKKWOaR8
         6O77dFg5PhZjlemChBjnqRnFS24hQmN8PcYBDjRU22bfzKfp0wbJedza4xErpp03UZHd
         lZtdnz4M/e94JjkBfVirHiXutXvGF4/kJamtrEbS00eJM3Xz72eF7mEyrKmWbWiQJql8
         uRcA==
X-Forwarded-Encrypted: i=1; AJvYcCU9kCUAa6ytGLhTSo2ncX6cmVkKd5MVt7MogJZk4fH2lRWbSVSeLu+3DnslhL4vvx4F/gBXpVS1DeC+PJiH8l7Mv8sCOKtsAVzd7DAB
X-Gm-Message-State: AOJu0YwHQpzRnRkgUD8DEpg1+V02jJ33xWBr50E++lsIyY1gq/8wZI1f
	ay3OEFCL+8u1jIxaWVNvtLEzgAb0qCGk4/TlKlE1STVGhpHZ7iQLtK+u1qWlpMEJ4wp+mk57Chh
	SXMbVkAeLlmxEL22u7vmpLMdwpxM0yUpu5LP2dw==
X-Google-Smtp-Source: AGHT+IFbNMG/eKGQfBxsEnoPFbDK6eYpGm1SWVL/cnzGi2c/1PCKaMW3zu0j9J+G8MGsPPZg33mj4TrwQBKh2/fVuMA=
X-Received: by 2002:ac8:5f06:0:b0:42c:3b86:acb7 with SMTP id
 x6-20020ac85f06000000b0042c3b86acb7mr18725477qta.39.1708549798307; Wed, 21
 Feb 2024 13:09:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-2-surenb@google.com>
In-Reply-To: <20240221194052.927623-2-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 16:09:21 -0500
Message-ID: <CA+CK2bC-uMw6hSNRCeWQjKDihd7=fd01g9VyQ_Y1iRwcq0LAaw@mail.gmail.com>
Subject: Re: [PATCH v4 01/36] fix missing vmalloc.h includes
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:40=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> From: Kent Overstreet <kent.overstreet@linux.dev>
>
> The next patch drops vmalloc.h from a system header in order to fix
> a circular dependency; this adds it to all the files that were pulling
> it in implicitly.
>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

