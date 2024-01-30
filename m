Return-Path: <linux-kernel+bounces-43707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E22841817
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C3C2B22091
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A49233CD0;
	Tue, 30 Jan 2024 01:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UbDicfoP"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3217B36118
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706576738; cv=none; b=nawyR3gVHCC5O8Ef+AkmXq7BaepECBqjHQ0aBzU/keiwprgPxECmUzM7CeQaZmhsMv0RL6IGNQqmKSTDsviflz35G/RUSU5Exujw1bKeY+Gg2ck6DC5UV+lsY/IVPMCHBzkv7lnL1KcLehf4ZKHoIAFPIhaN4zSpdB0aDnXycrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706576738; c=relaxed/simple;
	bh=bP5uiJ/5RnXIvoYIehfl5o60E8dgpUf1Hp3tp0SJCB4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LN4svDS+q5yun2cHXjxZ6a9iSUjsjLUQD3danFeK/kw9x+Cm90265aYQsxA29q6AiVtpdM9DvzB7qUgE8TQsnDFANL4lBHMIUVVqRsP5t0NssRuPmAii6AAbEbllIcpk1zLmmQw+m7H0DTXVN8K6l+QwKDwNqfyPDCFbWnXT408=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UbDicfoP; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc652e598e5so3890308276.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706576736; x=1707181536; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vw6COnvcr34EckSRXJ+rxQe1Z7hZfWxJzyine5oZCQQ=;
        b=UbDicfoPxA64JJMREM06iQh5KwpgEscQp+x60KNeOkS7y64t/IST6S9Ap+Y84PIwYp
         U+xvHOTQgnIKHa+JDDZIX4d+iw7xt+mY4EcmpJjTOsvN58ggL44ndH/PRXrFFF2Z/gZk
         9F/9EREBaJFl1q13NTVxNCh42pq9P2gU4zEHXVABkt2LOwPOu+SpOCl0XbB41d0IytM7
         Zt1h/IjeAYS4wJV1L9wmv4qrfuEl38vbO1Qu8GQnOZAa7F7iuylWr06K7nRc2xc1YszC
         7b+n8jqygaUNcNNHf6yk6N3+BzahUjy1Vo5NYxt7yhgO4Q2tVphmRXc1FcIJ+Vm/Dlmi
         yjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706576736; x=1707181536;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vw6COnvcr34EckSRXJ+rxQe1Z7hZfWxJzyine5oZCQQ=;
        b=AYH88zqZ1Htzh44+z6ezfObqewqe25ILDEzCt148MMX6bup2yXzhJX906uFo50u5Du
         1ARfk7/Jt8UsDIlODn+lnmFykrIk8C06rlYtE6vmgg7RQJ/6a/cN/brsVBeww2TzdaYf
         +Goh7hx1OBvbmcOrVYbjLkjsJ/hKimRqGb4HZMtCwgDDj3LtKloXiccq0xmUB8qy1It0
         MlOKLdOalkHV9uWIfd2xdNFvq0j44PnG3/e9tOARcm1qdHqZKSRyBp3o684xcV7dz1IC
         Cxm5KU0z6tsHbl0jQpqwP36xa24RTHZ/12ODMekqBCWw3QySrmcUA/pTgotcsC26l70J
         jl1A==
X-Gm-Message-State: AOJu0YxHzweFKr7blQQMl07UES4vC8j2IcS+h6NOviwoAzjM3cLBpVdE
	19X67qOeM+DV34NRU2ZTB4dBpjE6G8UJOQI/7TxFawhNwljTNR8hFEhXjToigAvrknPonCK2Kf3
	KPL1BdzKp72bj4zaVCQ==
X-Google-Smtp-Source: AGHT+IGe0NvY4HXE6eFA0hpwVc6vgidpZ8bbGhfiv2RgcaV8cAbmIjcxpghn/hAx94smBwwzRwWCzi/M/FDlWP05
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:2503:b0:dc2:661d:11fc with
 SMTP id dt3-20020a056902250300b00dc2661d11fcmr390539ybb.8.1706576736085; Mon,
 29 Jan 2024 17:05:36 -0800 (PST)
Date: Tue, 30 Jan 2024 01:05:34 +0000
In-Reply-To: <20240129224542.162599-3-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129224542.162599-1-nphamcs@gmail.com> <20240129224542.162599-3-nphamcs@gmail.com>
Message-ID: <ZbhLXoOw8Zs2AQ7X@google.com>
Subject: Re: [PATCH 2/3] selftests: fix the zswap invasive shrink test
From: Yosry Ahmed <yosryahmed@google.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, hannes@cmpxchg.org, 
	tj@kernel.org, lizefan.x@bytedance.com, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jan 29, 2024 at 02:45:41PM -0800, Nhat Pham wrote:
> The zswap no invasive shrink selftest breaks because we rename the zswap
> writeback counter (see [1]). Fix the test.
> 
> [1]: https://patchwork.kernel.org/project/linux-kselftest/patch/20231205193307.2432803-1-nphamcs@gmail.com/
> 
> Fixes: a697dc2be925 ("selftests: cgroup: update per-memcg zswap writeback selftest")

Looks like this should go into v6.8 too.

> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Acked-by: Yosry Ahmed <yosryahmed@google.com>

