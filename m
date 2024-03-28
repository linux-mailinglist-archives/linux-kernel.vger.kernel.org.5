Return-Path: <linux-kernel+bounces-123435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F51890892
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC24F1C2AB6C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59572137756;
	Thu, 28 Mar 2024 18:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K5LV5K59"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CE07E115;
	Thu, 28 Mar 2024 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711651818; cv=none; b=OAnU+bCjRA4XGujFd4RCxOc2AoiABIuJljW5JodM20Mad9PO8JcA2vijyiZbtYs0x5+k8vYqAITbN8w82LKv/zdaMBj7ySeNWC0QZFvh7lKkCXy9NNkjuxQtDH5hNzoeE9bVnuJeL2kUXSh9hTgT/FAFduA7vJCIrnVKjm+taok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711651818; c=relaxed/simple;
	bh=F/HJwyzJf8Uss0XAVW7YuuqoQ7rS2WoYp45boQWDGm8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dhwx7bQDHORoG5cyPTw31fNNdmGw18ltOCtXS7fvrSdSNpG9qwnCrsfeEjqIOix9hvZ8sVI1tVoyEMkQIvEGpPMTmV340kvtDuf9Prp1sr9jsF43olm2wepn/tYfG9HYaDwcrKD+0QT3JHVCj2Q4nHcKlDIkHTm7F2y4rQvVK2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=K5LV5K59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CDEC433C7;
	Thu, 28 Mar 2024 18:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711651818;
	bh=F/HJwyzJf8Uss0XAVW7YuuqoQ7rS2WoYp45boQWDGm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K5LV5K59HTaPTHPaJcC4ecFQSBf/oze43b5ftafjrU72Xj7wpMsQi280aAjHgoZW4
	 Z5GQuBTFbWstEpa3fqgWc67NWYcF5OoNpHO42A99VouIGVmZ54R5a3pyqByTbP6xGL
	 oXCV4NMgOpspOce8nJxmjNUruKoOZe8tbS5U+YEc=
Date: Thu, 28 Mar 2024 11:50:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 lkft-triage@lists.linaro.org, clang-built-linux <llvm@lists.linux.dev>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 willy@infradead.org, David Hildenbrand <david@redhat.com>
Subject: Re: next: x86_64 defconfig with clang-17 failed
Message-Id: <20240328115017.5c585e5709b0444c31811714@linux-foundation.org>
In-Reply-To: <CA+G9fYvbFMMCmk91vzVXcS5T2Ezkwg8tQDgt_TfF-8Q=c0B0PQ@mail.gmail.com>
References: <CA+G9fYvbFMMCmk91vzVXcS5T2Ezkwg8tQDgt_TfF-8Q=c0B0PQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Mar 2024 19:05:51 +0530 Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> While building x86_64 defconfig with clang-17 the following build warnings /
> errors noticed on Linux next-20240328 tag.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Build error:
> ---------
> mm/memory.c:5094:25: error: variable 'pte' is uninitialized when used
> here [-Werror,-Wuninitialized]
>  5094 |                         writable = pte_write(pte);
>       |                                              ^~~
> mm/memory.c:5083:3: note: variable 'pte' is declared here
>  5083 |                 pte_t pte, old_pte;
>       |                 ^

Thanks.  Presumably ptent was intended, but this may not have had
adequate runtime testing.  I'll drop the two-patch series "support
multi-size THP numa balancing".


