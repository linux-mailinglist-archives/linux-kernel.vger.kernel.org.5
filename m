Return-Path: <linux-kernel+bounces-57362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E9184D783
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2BC228428D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72E114267;
	Thu,  8 Feb 2024 01:26:28 +0000 (UTC)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DA533EC
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 01:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707355588; cv=none; b=YA7bXUNJz2KST3iO1/hL4J0JHW6GkxQPzgo+XWjUQZWhgLjnqiXjLeFwJM5Hn5LLDZXoXpM1InABQGVicQEKR+SU19aPlM8nHfLj7cpYEQh3ORzYhPyMy9f3DtmqSgoLG9y4pM3zPd9IyBtIgEaMNyvHljIi/swIjUvaRZv54uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707355588; c=relaxed/simple;
	bh=3LdDc0P1I1qPCW8EeOKAPUsdUPuJFgjm90Igx+uG7vs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HEX6B7LqCHhUDHOGvJDsjMAFstfRpTuCqRN+nW8WbNutX7WeTp5jXnAhGSOOENxRgcSQ4MG5Llfu3QCv//h0WQ/d29zK/qCWkiTF8lf8PvO+KO2ZzHiRDx2KSGA8P88KN1140QYBclItrXxlJQT1brVTmmLwu+IQmNy8sfRPoaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bff34ff1b0so137925b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 17:26:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707355586; x=1707960386;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+sMWjkrvn254ZBwpCLOdzMUBS2BcELxfGOsGSPNqxM=;
        b=NIk7LuMkT/JjKQ4s4ZLdqpD1mHhY5QqHXl+Z+LepvQ2fBS5b9F8t+2OSgnjmLT2XId
         4GUTZral9HmpwX8u5aqdnuZj1zrisrGNob2RWlrgaRufYW6NAoOOX4RxFr1bQWis2wPH
         qsXOeznAbyPWMDlHl+FW5aa2YH5ffRiLUoXPqvafpKJjMX9rdOxR/midBOepCnQF0cRg
         Y1oLW2nGHlswYZgslZtQKIFLrvjwecpy+JtLuBXWGy8vqi3DG3DbqrloXmCam6Hgcsu5
         c4Qf5Ipjy5VoYfSjcDshBTZVvXH4nxJOPAYjG5AoYHbvfx2Ros1c3vld33sjsOKfmCfL
         l4vQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+HnEaKWRdRu1xWiR42jGL4uZxqzui/advCclE5welbM5IgZPMsUM6gYmK8gsAthdXBvsM8/nk36OkypXDvesjWd27BCYirpEgCbE+
X-Gm-Message-State: AOJu0YwY278V+gi+dVYfCWrMNQP5sxDMLdmwvwG4iiIXcY1Z1k4slJzS
	Dn4qlzNWXXEb+q2PRrI+7rO+xUpvuTdgFmF4edzpWFxrI1gX1NpR
X-Google-Smtp-Source: AGHT+IFzzMXQx7kYJ1+CJC5KcZeIoTI5ev4Xhf5fdJtlHRRVWNpAd1dWrRW3hCFcX2Ko6jGY/EPW4Q==
X-Received: by 2002:a05:6808:14c2:b0:3bf:baf5:851b with SMTP id f2-20020a05680814c200b003bfbaf5851bmr8505794oiw.8.1707355585851;
        Wed, 07 Feb 2024 17:26:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJLgXTCopez17dUHy7qqoXJn6ZMBfHsjX4nk5JgzgQW8c1txS4Q1NKtRuzcrfuLbuS1o2VF20umFTTC/YWql881R59vDrs8hQhy3dF8w7J51ve4W3Vj4INK4glrbkY/3qpRA9rmypryGLWx2J65qY0l8xzn7zFdCfHV32O3oJiAWBmnsWifRX4A65uil93Buj4hxkeHJ4O6c3MJnPtDD9uL6/HBhdwHPi8+uCZ56pd9bmXqJ9Bqpfoy0fn
Received: from snowbird (136-25-84-117.cab.webpass.net. [136.25.84.117])
        by smtp.gmail.com with ESMTPSA id a24-20020aa78658000000b006da96503d9fsm2340336pfo.109.2024.02.07.17.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 17:26:25 -0800 (PST)
Date: Wed, 7 Feb 2024 17:26:22 -0800
From: Dennis Zhou <dennis@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] percpu changes for v6.8-rc4
Message-ID: <ZcQtvkrWhIkRVfS9@snowbird>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The PR to enable the percpu page allocator had a tlb flush parameter
mixup of end vs size.. This contains the fix.

Thanks,
Dennis

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git tags/percpu-for-6.8-rc4

for you to fetch changes up to ebd4acc0cbeae9efea15993b11b05bd32942f3f0:

  riscv: Fix wrong size passed to local_flush_tlb_range_asid() (2024-01-29 00:53:19 -0800)

----------------------------------------------------------------
percpu:
 - fix riscv wrong size passed to local_flush_tlb_range_asid()

----------------------------------------------------------------
Alexandre Ghiti (1):
      riscv: Fix wrong size passed to local_flush_tlb_range_asid()

 arch/riscv/mm/tlbflush.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

