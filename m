Return-Path: <linux-kernel+bounces-168284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 017338BB62B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B07FF286E04
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5453131190;
	Fri,  3 May 2024 21:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A2oROz7I"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFCE131192
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772233; cv=none; b=QQ6jFImbZWbAab0+sS6L8ea9Cb/oLmUkZo1OiJ9zAReqZuHe8VCD50+4J/5RIZDmOeiqRvFpBlVHlQN3kf6ApwIDJP4FQDGB7VFcXNsuM45hrBVNZN6Tco+vE+VckqvNzyZ+pgFF1lIFgWrFvfv9nZ6+e7ZCwwUxbTaIP+pVRR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772233; c=relaxed/simple;
	bh=T78GnKXhmF90EUMcoihJXbtnP3USZWPjBsko2Q+gE0w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HEKZRwkeJkMgvr0cZS0q+sqUTM5Gk2C8G/tfNJMAws5MyhqQpsvETuWGjRys1kkH015H5qkKCgpoBbEalpnO7MF7ItnAES06DImX534/Qk4fjjfaXPOtgLP+nmY5UGVuAnX60YlBe00cFyLvM1nZZ89c4mxZobWzU3qXWuYtDI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A2oROz7I; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ec3c838579so1324035ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714772230; x=1715377030; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pRR7KPd/cLlG8WnQvndczDv6yBxPP3pjh1dorGD2J1c=;
        b=A2oROz7I7ccpF8L/yzqrHr6oyYtnT2BmZL7PsXAbOZ7bNjfCdWLfSIt65r0tC5l5EN
         g1A6ZkgznrVOeWgPVGy+74b7yHtwE9G3ksvHpoePG1lU9Cb5nE9WgRXDNSM1I94tY2Xr
         T1wnJPQzgJdm5WugjhuAD8LBgxF+rzkz1sk8gE1Un7dHuLje3W8RCLtfqw0i7ArimW5x
         o8Nsq5h9fBNv4FZoRT5HWp0vMmXTvQQVsbvjaqVl1SNrs5kpwXVC3ZUORdn624rUpK9B
         W1rOkyydBBkF2KWez2C7QJeMmZ9rYUX/PdMbDnUzw8f+Ell0X6Y4xHjJL69z7fkgDt2/
         yDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772230; x=1715377030;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pRR7KPd/cLlG8WnQvndczDv6yBxPP3pjh1dorGD2J1c=;
        b=Km9QoSkaJf7U4LoTxd5KCAkIo7jDS3lf5XNOyVhaWLztvjxmpIT25cPJFc1LJA81yu
         X4rQiLudQjmTHnlAkilKo0jxvUZXB0ddv5Ipin9JvUfVzqxJ9Br/MvYewU8A9Us41oeP
         ELDc5oXpbtigvDICp/Xa/yWJovC/GHNOGz9frntUUdVm/UPoCS0B+KQFqDq3YelDmUCi
         zRaIccUhagrHrCwv85q3Cju/zS+9Jno0yyvhdFPIRpxBWUlZxrTuxyt9K+EXRqyc94c7
         bS3ZhQVJTtw+cfu7TbExsdqKZ1+eGnZwp996drMWF79VcxXjRV2iTOD102kSuNU+1RvT
         7MpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMDHnJBT2i1qROugkg5Pk+CvTb56ydD3+H53dNTl/YRr8pjEd0CgRTRz0GeG8sc7+5A39O+XY6BJa+4Pxzh/sgNjVGKBmsnWsJMMum
X-Gm-Message-State: AOJu0YzYx7R/GXoRt1arm561MsnXgPwbT1uM70hVneRT3zqnFL6rOrpz
	hm/GBtjyQfb+GgTuyAzHmGR6bJY2PXwN2aH+bBB1NBh2J4DFietFXDFNO8Fw361+qeDijmcxCbs
	VQg==
X-Google-Smtp-Source: AGHT+IGEgo4+diPoiyuTt2VZgasus5eMXUGK6JnD9ACDfLFd+or60o4UK1xIIX86iYt1vb7LAQ+9d2Drm40=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:41c2:b0:1eb:ac97:6c35 with SMTP id
 u2-20020a17090341c200b001ebac976c35mr165223ple.9.1714772230517; Fri, 03 May
 2024 14:37:10 -0700 (PDT)
Date: Fri,  3 May 2024 14:32:26 -0700
In-Reply-To: <20240430162133.337541-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240430162133.337541-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <171469160805.1008906.10298105633797388106.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: Require KVM_CAP_USER_MEMORY2 for tests
 that create memslots
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dan Carpenter <dan.carpenter@linaro.org>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"

On Tue, 30 Apr 2024 09:21:33 -0700, Sean Christopherson wrote:
> Explicitly require KVM_CAP_USER_MEMORY2 for selftests that create memslots,
> i.e. skip selftests that need memslots instead of letting them fail on
> KVM_SET_USER_MEMORY_REGION2.  While it's ok to take a dependency on new
> kernel features, selftests should skip gracefully instead of failing hard
> when run on older kernels.
> 
> 
> [...]

Applied somewhat quickly to kvm-x86 selftests, but feel free to provide feedback.
It's the last commit in "selftests", and I don't have any more selftests patches
in the queue for 6.10, so making changes if someone has a better idea should be
quite easy.

[1/1] KVM: selftests: Require KVM_CAP_USER_MEMORY2 for tests that create memslots
      https://github.com/kvm-x86/linux/commit/8a53e1302133

--
https://github.com/kvm-x86/linux/tree/next

