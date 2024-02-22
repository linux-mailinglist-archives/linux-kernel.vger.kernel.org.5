Return-Path: <linux-kernel+bounces-75703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FE085EDAA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF9F1C21969
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EBD8BF3;
	Thu, 22 Feb 2024 00:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="WMqOTNgo"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D703B1FB2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708560637; cv=none; b=dhofit8QWMY3YV5mnMtT/y06TdWv/Ss6sM/GiLJLFmPjdsmC6xzaTMcTHJFwA+UzgMtITN4cutiRRMWZQn032OZgz6tME30vozV8Rynpmj7+N9SUWnTxt0ktrcGHN3B8LBbmIpzwaQg3m9yoKtb9h2kNXZcLJJEgZ7u5NAAL2xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708560637; c=relaxed/simple;
	bh=1D0pVaWMlr8hskhdGaW7hZtXBWle1reW17x7OUuU9Uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsP3xLIxT8UFME2hU2PIKHAa8rFuJAXXgnJJzjP7Z0mqtReDOQUV0bJpbCJ2Rzg7rCJTAzMYL2TVbU67W0jxjLc86N5GXawCEI05DheTlVcECvGP3uQ1hm2Vt7RWuZOzj0UtM/1zEoB/+5ZAIauN825R61xFsjWi7ceJKhFiZUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=WMqOTNgo; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7d5c2502ea2so2789213241.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 16:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708560635; x=1709165435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1D0pVaWMlr8hskhdGaW7hZtXBWle1reW17x7OUuU9Uk=;
        b=WMqOTNgoyIMy5Skhg570/S9RfKRo+GGYJCSxO9Wx46wIXQMWTS2sf3E2BFDb9cb/Mi
         SqSc2RwztXYNSaB38gztWThpj5wG20etefD5/vzwCIiRM3djvQYDKyWZLyyB9HFAM9wd
         GMQZLr7NXKp6GOaIasT2JvwkONeaUgvXWnQcOrKHk1+ub3kdjAL8tbRRBT8znhaL2iy2
         quvghVEXB/K/qztLQ/o/HGZdmDIRYb4aRqmqlbUHD9a4EgJ8wr5jPA/6XG4Eo8myvR/W
         T/TCrdyLnp6jiwDXmMDE+CSg3Midm+48pxiNe04wJ4IpdOsHW8Q9uLnJqcwi+xwQqlmf
         Orvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708560635; x=1709165435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1D0pVaWMlr8hskhdGaW7hZtXBWle1reW17x7OUuU9Uk=;
        b=FnjM22o8lnrJ/u+Q+7bVxRGdM+RKgVK7GLtSQhWrmQnFp8PKIh99YNFE/MxfdtHGxW
         TaktzogNAY0UC2IVn02pzxpDZLMEajo4huDfkXlLhxN1HeGeeel44vaRYR/iCt6Bb1Pj
         ZAr2VR6wP2X9YbGikJ2CpICZKtczwIoeBzhs94ff9io3uvzwNV6xS/nSyMIMklFWFXCz
         6zZGxf7gCEUOdeth4IumxI2KcofX+7NDu8ZnGMH8sCSHTgginD1HVk91P1Tsrn3f/AjB
         LsHe2M+86YbxzDiJ4ZiXA4SbOxcwioNVfhbsj5V5EZnUPgiUUujHOWzcbS7kwUb9ZB2N
         4aWg==
X-Forwarded-Encrypted: i=1; AJvYcCU3sXR2j5/cConUPyfAtzOKFkzCIso3ViJmZJcWILTykaEVRYOkAtnx6HobJcIg+DSLiYgMm/UX3x8fw4rZynPGenvazF8uLqPJBimi
X-Gm-Message-State: AOJu0YxHiMi4kGz2JDaAdkAVl8U0DeRgMM0NqGo4OwGUbj14LfONh+3b
	2+OuaxAOoQlp644Lm7XRQ8mu+Q2QRlVD4KuaiRhMdxWSKZ29K4RWyZJsgzhunMuZa2+f68zvqaT
	bk4/k2OSg0HafHHZEbO3Eu2DKJSEuoW7tzrgDRw==
X-Google-Smtp-Source: AGHT+IGvkzT3uz6qELPJtraK+YKtQ9uJucd+Pri79etJZSzYbQUZmm3eTGpEAZMzRr8Ip545g98kCtUJT9vyheZUmog=
X-Received: by 2002:a67:f54a:0:b0:470:3ade:af52 with SMTP id
 z10-20020a67f54a000000b004703adeaf52mr11439980vsn.6.1708560634875; Wed, 21
 Feb 2024 16:10:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-10-surenb@google.com>
In-Reply-To: <20240221194052.927623-10-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 19:09:58 -0500
Message-ID: <CA+CK2bDWkrNapWD7pv47XQo8PD4qJ3O=U99pL3o72KCnrzpsXQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/36] mm/slab: introduce SLAB_NO_OBJ_EXT to avoid
 obj_ext creation
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

On Wed, Feb 21, 2024 at 2:41=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Slab extension objects can't be allocated before slab infrastructure is
> initialized. Some caches, like kmem_cache and kmem_cache_node, are create=
d
> before slab infrastructure is initialized. Objects from these caches can'=
t
> have extension objects. Introduce SLAB_NO_OBJ_EXT slab flag to mark these
> caches and avoid creating extensions for objects allocated from these
> slabs.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

