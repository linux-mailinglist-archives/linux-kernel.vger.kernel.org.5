Return-Path: <linux-kernel+bounces-38579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EF683C27E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A967B1F25353
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5D245C0F;
	Thu, 25 Jan 2024 12:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2UZZoeN"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1615945974
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706185724; cv=none; b=Kv5MbsZgXoIQ7AWD3hFfcI7ope0koxZmgVhw6MMdirXFijPzWDn2Xo02T2qZKP00Cv0x6TNldFcp7u2rP+b6oNQhJ93teX+QBt2Xj9OlaXEzJHCzq9/2P6lTGwyqjkk5tzpKEqbpkDuZUuziPM/tBktV+iQwUHxmbXnVZIobwQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706185724; c=relaxed/simple;
	bh=FsEMNDz/TCbZ3OWB1+o43WxaCaXQ2tk62us41F8uHDg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NoS7V5T5x1yj2XyFh6OuWjGru5Ts5Fog9sGd6SBsKHTNrIt7UjUHENwveX1g8NEp+a7au5M7mRWfDNwwETqZ1Hd4r8xMObO1crpzxeZQh2Hy3KwkUhzOa3YmuSzfglF1Q0B0GQYWwPA5ZrdJXD+i40ECx6AXankL+52sePOUUkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2UZZoeN; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso6268430276.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 04:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706185721; x=1706790521; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FsEMNDz/TCbZ3OWB1+o43WxaCaXQ2tk62us41F8uHDg=;
        b=X2UZZoeNurJ/xrGW+KSGw3Vh2KvYYRVh1eRU0SsNJvoPghB4vFrNSxRa0L/OK53izc
         qFWufUaFDU+C9EbJ/424uyxaOMdZMHHiWXo3JAv3RCQCaKjBYOwSkHRIu2tKZAXxze9r
         8OUK2kOVUbaEdUhtb4dApmlJafRerGY5ZHODihfGqD3GKZYcN5+UfB6zxgZJHNhHnFZq
         +CXcyTbP/whNG/xkZOj4Ng9pH9Fx3DT637oNzbYG8MLzGFHN5v+oEy5S5fjpJ4tDSyQL
         qhFSK0YAaMHK9YygWuwYTPRusXcpQUH82niZPA1xIqal+mjbZEiHSw7yEq7u2bSpA74v
         MfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706185721; x=1706790521;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FsEMNDz/TCbZ3OWB1+o43WxaCaXQ2tk62us41F8uHDg=;
        b=dzxpA0mRfeMw6KUNW7NPj7SWLWvMgskM4pbYX1k0NLcG7vWAai20Yqq9lnlgkb7RYf
         rEym812hDncsvphiZncSTHInBF+pWx4IFm5RaZsLH2LXmjfhgmeYn6MFf1yknJlPLRPZ
         x35o44OzEYG2xoNMzF8xyNOwxuEaqQ+4CTWXKyQQv/Xw0NKCBaq4x5sI7Z84diC1+GaJ
         M2q7bjyXtpI9d2hn34xLaaF3miNnomXzTuF4xugSD3k3fRJbIXQ6ZH3WolckHb/ef0r+
         LIfSgXkQP+5JsSRt56uYvqfVzLOx5cFyrzberB1BgtfviUDnG6ajdGA8bHBzU3NTM4I1
         4RHw==
X-Gm-Message-State: AOJu0Yw/jlIsGK9ow8SvwLa2u1hsxzb4SAcAiBJcG5R6GMHxyITKagWB
	yZ8JPZoxSqCrLPyUVxeJWKG+0TJIHBWitcb70yF1MZQYeHJs18sVINeCPURD8YQGFNpYzhueKZH
	yQOpLafO+fdKC/krgenuBFHmKHzMunmXxHZA9lSg+6yHhSw==
X-Google-Smtp-Source: AGHT+IEpdt3UvjbFwRYPy9eemcVY69jID/MnPXS/Og2ZuflLOp3ifa2QO32mEciL8A6P7qCy8i+BfNHNLvju966Um4A=
X-Received: by 2002:a25:a2d2:0:b0:dc6:9a3:b95b with SMTP id
 c18-20020a25a2d2000000b00dc609a3b95bmr764196ybn.108.1706185721027; Thu, 25
 Jan 2024 04:28:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 25 Jan 2024 20:28:30 +0800
Message-ID: <CAK1f24mZcxdxKA5hyNaMy-jX=dGtEoZEY8imXKrTnZ0EC61_gw@mail.gmail.com>
Subject: [Issue] mprotect+madvise may be better than mmap for permission
 changes and page zeroing
To: linux-kernel@vger.kernel.org
Cc: Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Hello Everyone,

I've noticed that using mprotect(PROT_NONE) with
madvise(MADV_DONTNEED) is much faster than
mmap(PROT_NONE, MAP_FIXED) alone for changing
permissions and zeroing pages.

I have maintained a chunk-allocator internally at the
company. It allocates a chunk using
mmap(PROT_READ|PROT_WRITE, MAP_ANON|MAP_PRIVATE, -1, 0),
releases a chunk using mmap(PROT_NONE, MAP_ANON|MAP_FIXED|MAP_PRIVATE, -1, 0),
and reuses a chunk using mprotect(PROT_READ|PROT_WRITE).
Recently, I replaced mmap(PROT_NONE, MAP_FIXED) with
mprotect(PROT_NONE) + madvise(MADV_DONTNEED) to
reduce the latency of releasing chunks.

Test code:
https://github.com/ioworker0/mmapvsmprotect/blob/main/test2.c

Here are the test results on my machine:
CPU: AMD EPYC 7R13 Processor
Kernel: 6.2.0
Elapsed Time for mprotect+madvise: 3670 nanoseconds
Elapsed Time for mmap: 5520 nanoseconds

Thanks for your time!
Lance Yang

