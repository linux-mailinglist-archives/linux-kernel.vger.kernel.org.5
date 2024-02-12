Return-Path: <linux-kernel+bounces-62196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD2F851CE1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC7F282626
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CB445018;
	Mon, 12 Feb 2024 18:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vk0DFFjQ"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556344176D
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707762987; cv=none; b=pnL+dxJ7Ey3YzudIGK8kjiH733OXmHam+laMr0bxUS+rFvjZ6l9sH5DCzzKqBNB+Z+oIfvGOSKNCDcwbmbk6IcnIlymtX3F+tPVibzS7640cFVlLHLwFzT8zj3nKNCM7dlmzo0VDB0o7Of/4ygQJeydGveHIzYslaaeq7oH1CFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707762987; c=relaxed/simple;
	bh=WXKqSYyybXp6uV6dewa2nvBTpPzl9LPRGTDSAu1cgDM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=cj8txtmA5koK2B1311TzkIT71epKKro6weE0YtxEiW1q6pDxJQsGr+qlvtiME3G5CZTfU8xPdlPqBXHXpGwheWPj4PXYhm02pCqp8JiSPjGyGYNmyPrDrYEeHapKdf9VY9z4EoAkGVbC6+Fc5Dulh/qMAZi0MuP9Fd62kQt7M5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vk0DFFjQ; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7d6024b181bso1273233241.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707762984; x=1708367784; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WXKqSYyybXp6uV6dewa2nvBTpPzl9LPRGTDSAu1cgDM=;
        b=vk0DFFjQA04k1ypGjRU9WCB47IMT1XjhG3otYGAKvggPQK8ujFDKCs5mFHeq3Cbv/d
         pLknOTfAoAz9FltE5o05OC/AhRbIhd8Q+aC7cb3t6kpg4Qns2Ms3b2DZPbiw3X3JHQGs
         WdqFXDfTXVHsBEFURF4CcJWDT6wd1suVtRwSDNfas9ynrMuaCFOmhDQmOhUugLtnkgn7
         pNVRfnocaWnSxx3adv/r5v5mp4SoBftQtbs+RdKe+7LkJNvRW/dZw+nNGF7sKVjnRorR
         mZ2JZ1FD25u/irR75UBHDluBpuNGlLFW4wa16Jx9r1gZR4n0H6oNZ4DbF1dfa/sQBzIQ
         UQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707762984; x=1708367784;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WXKqSYyybXp6uV6dewa2nvBTpPzl9LPRGTDSAu1cgDM=;
        b=jQcsPRp5F/6X4vFAj7tZJfXS24OOx+fjoHwxaWoTLK8EeGvzxFgx//+xtk6ttkSF0u
         JBj+P9UTOvSPTaWqmVQkLI29UBeorvz3KYc3ESBTd6sOBMBEvtltRwat744yKrab+0lp
         AZd8KJ7SnDCJmw+ANRfvVRHhluQ7N2xLXUidI4Lcz4N77V3iM0dhC0ecQp58/CtMnc6b
         4kgPiEkU0ZFPN7SwoHMFzJhmnFI45v75xg5cxwbdKGoxMmJMmTFlniH90wfq4JKvL4Ih
         80THoP2xqS6blrV7oUMUBJXmYzIlREJl7wmsIfCBeEZ7/hX83278SoJgzN9Cvuc6BZrL
         FYnw==
X-Gm-Message-State: AOJu0YyJcNaFoJqn9UkFTAWLr2Fi/Ew+GiIwplSLkNSRH5haih1IpdNK
	CM2GvPoAXbvjJL5mrr7HkjceHZyhGoNhDeAEzFv79ywCnxrL5sK2kGaoWwa4z1ATcNwL4kpJGQu
	7VXARH7Vr82W2nv9b4gHacqwKPJtcry8EPkJIzg==
X-Google-Smtp-Source: AGHT+IEGZANl6emZY1UqGcSik514xyBzWU+XBPYnRHQZC/PhIexcuWbWZ04L9aeTVXS9UkOAD0ILzGf2zegYmfLzUl4=
X-Received: by 2002:a67:e445:0:b0:46d:19df:f3b2 with SMTP id
 n5-20020a67e445000000b0046d19dff3b2mr6250849vsm.7.1707762984219; Mon, 12 Feb
 2024 10:36:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 13 Feb 2024 00:06:12 +0530
Message-ID: <CA+G9fYuRwO6FLZ4do1wR0RdiZh9NGpRLKckQcKN2aAkqBH7k0g@mail.gmail.com>
Subject: Powerpc: ps3av.c:(.text+0x19e8): undefined reference to `video_get_options'
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	clang-built-linux <llvm@lists.linux.dev>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Javier Martinez Canillas <javierm@redhat.com>, 
	Geoff Levand <geoff@infradead.org>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

I encountered the following build warnings/errors while compiling the powerpc
kernel on Linux next-20240208 .. next-20240212 tag with clang toolchain.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

powerpc64le-linux-gnu-ld: drivers/ps3/ps3av.o: in function `ps3av_probe':
ps3av.c:(.text+0x19e8): undefined reference to `video_get_options'
make[3]: *** [/builds/linux/scripts/Makefile.vmlinux:37: vmlinux] Error 1
make[3]: Target '__default' not remade because of errors.

Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2cFkli5H02fikrpga6PluAWLAMa/


--
Linaro LKFT
https://lkft.linaro.org

