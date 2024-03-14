Return-Path: <linux-kernel+bounces-102921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFDE87B86A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E2771C21854
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186BD6FB5;
	Thu, 14 Mar 2024 07:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dHIMVnJN"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473AD5C61C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710400785; cv=none; b=F7ZtMaO4gyy34TVjzB2H/WJo6gKLayjqQsIiE5IFQH2bI8cda3McsiPxzi/rT4OKA6YQWfcJIkZWSfgeYuSHgO7Hr1mH/7f220BN6oS9g3sJnj45Jkff1Fv1SQdYduBzp0j5cpxibrrbfM2dHTbK1JjY4qQTBNb+RwNgJM7J1Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710400785; c=relaxed/simple;
	bh=ojH9YgZdQsTdhM/5DOp0sR2SpKlzVwEvHTXac3BNoo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MprnRJu+t3BYSxy8gBJrvIk62fnMjPIVHSIHpyeJRrgpYgBQRM5JDS9CaD2MpwoR6pssRBg1XW4+kJjW5rNt83m6fqcgSaQpu7Yo8bgNdFlTzn0WjEtTwjMZ6iFrie25BsXL0+W+BnBG0qnFNlsgeRQiq2AQ3biVBFIEFeut1tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dHIMVnJN; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4d37e76a3dfso900450e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 00:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710400782; x=1711005582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ojH9YgZdQsTdhM/5DOp0sR2SpKlzVwEvHTXac3BNoo4=;
        b=dHIMVnJNZyu9wR5geyJVPDj4comCj9wjcuOeFrKBDzqLgGw+CQBPZ1Rmihoo5GCkQk
         gydtmwqK3bAyUQ83K7aML4v1hC9BZsKaZY0525UWagjZ8fsfJjDvJCfTzPWBJIkRmnUw
         aqsxskaVNMTLF/3Z9nA5isBPT4u3Yq4jYupi2OgSKlS9m8HMCQRgUMFlHHuDSHNq1156
         fe20i6sKg0KFcplI/SjlxLz5IVdQUpSXorjm5CgzoGPqRpdOLawFaN1HF8KKz8kq7kL1
         bQm1n65uWSarY1LTrouE2yAnbqFw/ncMm7t62skCvSwOMTp5rQvjdSJYjYug/MnRNZrc
         YT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710400782; x=1711005582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojH9YgZdQsTdhM/5DOp0sR2SpKlzVwEvHTXac3BNoo4=;
        b=I1ETg+D8cjvDxzZaSlDu9f3LRkpEsdxqmZrhJ/qT2VFP413hbBqnEoBwMVacEb8J+r
         Kirl64m8t/OxBYocMcaR1ZW0gHuGyEzbOOA5hIhAvSlIHtLyjSAbaA4F4kQ+4kUldas4
         MjI7q6axg9B/sihnIY9lGkKuU/BM4DJZvYPjSMT9b8PEvs1mCfK5eFl2b7AyU791fZuO
         lIcNc9A2yBm2wl0ifcjXp9Dso0tGzouPzIPOmtn5C5vbixcMNW9ePI6xtZ6DB/rZkCBS
         ANfM70gm+8yd2yB6MiZJg8OFmSlAI4NBUiPAwd1ZvjxgWRXZ51Ej6Whm0AB9+jBcEY1K
         Q8dg==
X-Forwarded-Encrypted: i=1; AJvYcCXWl+oIEXI/Q1UZdHjO/0CJFCkkh4ARjncCbB/RZuP86fyqHuuqgPPmjuJT8+krNCrZZGlZl89YqRrU654xOfJgr1J5cxHnQON9m2I6
X-Gm-Message-State: AOJu0YzGCllaHdlx39Tm4LGvBCL08paTYxEaO/SGCdINbsUKnEqZrHpc
	TOPYmiJFVK/3BlhaZtLlUBDto6wztTzG/vNICekYXBb0KMfvsk9LdaM0I28BhP+0DHdpScVOmE0
	4zcH3RGfBaIv/8TtDpmyIitFQ1dhHNmAVMFfd4g==
X-Google-Smtp-Source: AGHT+IEu7MNUInwIY97dleYnWeWXfcA+5F5T/ApvKi6n0MwxHEqr/RR8abTAy2/zINbSlyHB23weCyfflgDg+RLDw2Y=
X-Received: by 2002:a05:6122:1296:b0:4b9:e8bd:3b2 with SMTP id
 i22-20020a056122129600b004b9e8bd03b2mr431224vkp.2.1710400782181; Thu, 14 Mar
 2024 00:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312170309.2546362-1-linux@roeck-us.net>
In-Reply-To: <20240312170309.2546362-1-linux@roeck-us.net>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 14 Mar 2024 12:49:30 +0530
Message-ID: <CA+G9fYsHhTLw3c1Eg-L6G3H2g7-mPf9zdR+hKDCV10RhHk5vhg@mail.gmail.com>
Subject: Re: [PATCH 00/14] Add support for suppressing warning backtraces
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Kees Cook <keescook@chromium.org>, 
	Daniel Diaz <daniel.diaz@linaro.org>, David Gow <davidgow@google.com>, 
	Arthur Grillo <arthurgrillo@riseup.net>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Maxime Ripard <mripard@kernel.org>, 
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
	kunit-dev@googlegroups.com, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	loongarch@lists.linux.dev, netdev@lists.linux.dev, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Mar 2024 at 22:33, Guenter Roeck <linux@roeck-us.net> wrote:

<trim>

> This series is based on the RFC patch and subsequent discussion at
> https://patchwork.kernel.org/project/linux-kselftest/patch/02546e59-1afe-4b08-ba81-d94f3b691c9a@moroto.mountain/
> and offers a more comprehensive solution of the problem discussed there.

Thanks for the patchset.
This patch series applied on top of Linux next and tested.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


--
Linaro LKFT
https://lkft.linaro.org

