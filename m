Return-Path: <linux-kernel+bounces-65857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5244C8552DF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E8E228F15C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A648713A276;
	Wed, 14 Feb 2024 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NwkZPBsj"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1987C60DE5
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 19:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707937452; cv=none; b=sGKCsuLgp43IgiVxsJi6PgQpR8ENus9+LpSeJXsrLZgi+mwe4DpGOS0IIlx5B1WNNb8e/jlsxMMFjkni3Z4l+6TRpqUe7lHWP/HnHxqFpt7rcer2tLOLlqKP6aPA9w00tnhfDn8cAuk7xc99qCBQaP05woH1A1sBgEu4o+LQH5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707937452; c=relaxed/simple;
	bh=T1B8PjP1AIUWWTdJo24fyn84sVFnmmuoOYsaM3cR1Ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wp2heKT+WdWM0Y9pkcOmmX1pjcNlRP79dZyB3IdVf9IjY/Gm99Be0OoP78WUnnTgHsSw7ztLEWt/UPmpEXFSMtx5fieHxRWwSspDMduHKTMJZxYocpOLur+ptARXCv1G/3kqorR1zMbSYpn37tVdDy071msdaJdl6JXdZ+cY9Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NwkZPBsj; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a28a6cef709so4181866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 11:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707937449; x=1708542249; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=02Qc7c7VkuaWWM5w5oi8WQdKbPvcP4h+Wa+jjfebFsI=;
        b=NwkZPBsjO2x7hHjJ3brbUvryHatJDtqLGeiBH9rLHPHzV2Rz1mwGyD2npYEr5IxOB2
         hxf0glUPqHCp4bGIPfuuD8uXb2N6sS3N+7RCwT6FHa2N4Nh9Z7XViTKysm452SHl1IIc
         +r7+2lqrt6kLsOuaP/mucBVCCsGEeN2vxM94k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707937449; x=1708542249;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02Qc7c7VkuaWWM5w5oi8WQdKbPvcP4h+Wa+jjfebFsI=;
        b=sFcBCZFfO3s83P4XAcAbT3nSevXWvYwkd3WIxbR2SUlLUnm0ca/zbQkNvksANsGY+A
         +G4nOX9V1lq+MC60bAQWn5omxXRb98NgFI1MxCTnztyOPLaE8dBRJUiHCAhOLSSxeC7A
         A14s5nc+43xnIj3ilOkfUKBWcqZBKRszoL6BX+fQ6F0chGJ7hCYaFFlSOOLTTwNKtIKz
         jNPFKNy67EpB/4DgnGq5k2LxzoMZOIA1A2jVKue9cYggVWMqwCB0bk1m8+otB1xOtk5j
         Pu9JXXHoaR9K6IXsgy6COCbrZzSGAHi0brqMlAdvOzyj5GpjKqvD0vR1sPX0sL9OUsWJ
         QIhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXURhUodmTOcoKeKwtKjjetTblnabDweHU23o+9NCCD8SzYpPrVHD77SMXEB0o7czm8GWWQhVIVNkNo1Jc4+6E5rJg0fKFsHtSy8dsS
X-Gm-Message-State: AOJu0Yxg4o1OIY8NP5qgpEr29jqGbh0hMfLp8+1NrK1r2O5V8/Nrotif
	sY++cvR9xhWb4K5kd4m39RA3bSTGmlteKa6BIzgQu3RWV+Jpz0tACVwrI3nMH4VkE2/2idqFKUv
	20as=
X-Google-Smtp-Source: AGHT+IGrx4jpm+wtOiFeFcRuNUDGzGVkvpYK3An9SiO25/wegDf4R9Un9LnFFTUQ5gLSab/ktRqQrA==
X-Received: by 2002:a17:906:749:b0:a37:b8fb:50e0 with SMTP id z9-20020a170906074900b00a37b8fb50e0mr2428188ejb.52.1707937448896;
        Wed, 14 Feb 2024 11:04:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWNsSrt8G9CYZ6BdvmU2yIZ6MxH3/vZIdlmE2A4Oup9M38aM2qCsmWWB3RnO9eSciGIYmdx5euQyG+c/IGIJxY7rPKKuinLaO98xdJ+
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id q19-20020a170906361300b00a3d25d35ca5sm1325208ejb.16.2024.02.14.11.04.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 11:04:08 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so126923a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 11:04:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUUoDL8yiSLVuq2YabN+3nOTDPdAlxwLiy826f0EC1XtpKK5lZhxZUTThEZeNd9C5awKOS9cl9E1tHC8auSNeg0qu+QPNgJQDv+FAfM
X-Received: by 2002:a50:fb06:0:b0:55f:f7bb:40fd with SMTP id
 d6-20020a50fb06000000b0055ff7bb40fdmr2668640edq.2.1707937447958; Wed, 14 Feb
 2024 11:04:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zc0IzeM6tAvm1NTl@mtj.duckdns.org>
In-Reply-To: <Zc0IzeM6tAvm1NTl@mtj.duckdns.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 14 Feb 2024 11:03:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiVWmTfaCUjZYrV6pVh3O6hYksKsWx4bJY0EhNNat9QDg@mail.gmail.com>
Message-ID: <CAHk-=wiVWmTfaCUjZYrV6pVh3O6hYksKsWx4bJY0EhNNat9QDg@mail.gmail.com>
Subject: Re: [PATCH wq/for-6.9] workqueue: Fix queue_work_on() with BH workqueues
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Feb 2024 at 10:39, Tejun Heo <tj@kernel.org> wrote:
>
> When queue_work_on() is used to queue a BH work item on a remote CPU, the
> work item is queued on that CPU but kick_pool() raises softirq on the local
> CPU.

Now, does it make a lot of sense to ask to queue a BH work on another
CPU in the first place?

I don't think tasklets supported that. And while the workqueues
obviously do - and you fix that case - I wonder if we shouldn't say
"that operation makes no sense, please don't do it" rather than
actually support it?

What made you notice this issue?

                  Linus

