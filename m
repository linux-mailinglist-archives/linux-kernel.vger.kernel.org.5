Return-Path: <linux-kernel+bounces-129153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0940896607
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C5CA285191
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D410758AA9;
	Wed,  3 Apr 2024 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdYQY1D0"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B08C5674A;
	Wed,  3 Apr 2024 07:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712128753; cv=none; b=aDVdBdnZI8T4tJya2Q1dqNtjpGzkfGzWXP2EBLyyt2XR9Tsmc1pYoFISt6RxCvYO8JahYBM3ZEKLKdfcbdRYgIzFppeO6daJlPqL4Fwuxa8vr6rbTKELPAmhrTKA4pFp5w3+fFU5GHiooXigtEcQa68PxAoj1nlTQC2LqsO2zS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712128753; c=relaxed/simple;
	bh=v45mk+BONJ/8h3rercxajOQAQulxAi8eA/hXvztu0wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yq7Wqhw63DapHrQ+c9mgh5fXy6nA3ZamYMMzLSdGuEA7qfOCikPtN+bijPhWVhzcPAc9YEFBv4UZrsh1ctee6gg5iasnE0qg1D6w3wCuOBkymGHjOa0GaQNETLy9W3Ujc3tcDLA4SqGB39+NZsft2SfbNbCbdgNW/APV2n1Lmxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdYQY1D0; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56b8e4f38a2so7257957a12.3;
        Wed, 03 Apr 2024 00:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712128750; x=1712733550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s49hobKIVDPzW8tIlZcGSj9ukdWmgD47R+ziOoaqb7g=;
        b=kdYQY1D0c4319EjHZk44Z0l5yU5T+bGDnW9eEZci7rHQtjA8JiSExxA4HTCxGFZSA9
         5VnHGV9wt9BfuG40d88WCWLKS/i5EwfAUqb4rKbC0h8oilKM1OmFfmaDaAQB130HnthE
         c9dE2pegUHFslonnt2Z58ftedPsLLizIiQd8TSMrI3dukYZzntElikwvmxn5JXu94496
         sST3Oq3iVfh79a4Mg5ce2sELTASZucYEpS/ij5XQHE1U95VRAudfjxVHvUxK6Ae/iBC3
         ND8zR8PP5vclehYFqxY/2HKg+1CEdmKnTwE6YDu3zmvzu6JFp4Vmw0aZwwvH0J2G+Zxk
         WRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712128750; x=1712733550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s49hobKIVDPzW8tIlZcGSj9ukdWmgD47R+ziOoaqb7g=;
        b=udyu5JH9ADrubMFCgXJjUnMezV3PtvO7dFZTiPJFbWOa+Xl6fd9GZrPgyo6qzsFUQM
         nfLwvh2rI7aft07aSVmOkgf72+wAAzp9DMpTIunnULbJECJr2h8p1n68OvyQkYKVIQEI
         nQ+ZtEHnyVEzM2yzjfF/nhfXauWMnVJ5zc9s4uVZm9cpVJVVORRbcN51mVG6s1dXj6h3
         ATfdupJpXZXn/VwxbVWwCzQKgCo9y2+fpNVXMw7L/sgvbr8Hu9tXXBMkPLzunYCMfSZG
         9BO3JL7aTAFsTKqHpzj4tfRBf2JkRQHvmEpFjDpNOmPgJ4GwhUDbuU0ss/c3u+FwiaMS
         94+w==
X-Forwarded-Encrypted: i=1; AJvYcCXegg74n7lm1zMdpPDZApKxyEW69up5TQRbieeyJhedM0bUsJOqkoNbPDQ0rVAZ0UsDhcJdyKdvpWJVw0Mkf+YcP1HvCC1mjgZbV21XOGdQ43pJuR3prxZJ24iE4nXcTGyO
X-Gm-Message-State: AOJu0YxR7JIbyID2u0xnBkCWSr+kemZ6TCMNvieOk978nfT/KVbQbXWE
	+ycOlMC7KZceTJXnRZGYQTDpIy7SH/e1AZ49NFQKTRYg53OkAvdC
X-Google-Smtp-Source: AGHT+IFOOTlq1IngqRA0M95hMD8uxq5iSAvx1IvOr2GQEqZym+R28ZYiv8aSmkUnY0d6JnsCIHsh/g==
X-Received: by 2002:a50:c346:0:b0:56b:7e43:a3f6 with SMTP id q6-20020a50c346000000b0056b7e43a3f6mr1026460edb.40.1712128749359;
        Wed, 03 Apr 2024 00:19:09 -0700 (PDT)
Received: from gmail.com (84-236-113-97.pool.digikabel.hu. [84.236.113.97])
        by smtp.gmail.com with ESMTPSA id r17-20020a056402019100b0056c4a0ccaacsm7639454edv.83.2024.04.03.00.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 00:19:08 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 3 Apr 2024 09:19:06 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: x86@kernel.org, peterz@infradead.org, mingo@redhat.com,
	tglx@linutronix.de, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, song@kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v5 0/4] perf/x86/amd: add LBR capture support outside of
 hardware events
Message-ID: <Zg0C6j2HO19O0HMG@gmail.com>
References: <20240402022118.1046049-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402022118.1046049-1-andrii@kernel.org>


* Andrii Nakryiko <andrii@kernel.org> wrote:

> Add AMD-specific implementation of perf_snapshot_branch_stack static call that
> allows LBR capture from arbitrary points in the kernel. This is utilized by
> BPF programs. See patch #3 for all the details.
> 
> Patches #1 and #2 are preparatory steps to ensure LBR freezing is completely
> inlined and have no branches, to minimize LBR snapshot contamination.
> 
> Patch #4 removes an artificial restriction on perf events with LBR enabled.
> 
> v4->v5:
>   - rebased on top of perf/urgent branch to resolve conflicts with
>     598c2fafc06f ("perf/x86/amd/lbr: Use freeze based on availability").
> 
> Andrii Nakryiko (4):
>   perf/x86/amd: ensure amd_pmu_core_disable_all() is always inlined
>   perf/x86/amd: avoid taking branches before disabling LBR
>   perf/x86/amd: support capturing LBR from software events
>   perf/x86/amd: don't reject non-sampling events with configured LBR
> 
>  arch/x86/events/amd/core.c   | 37 +++++++++++++++++++++++++++++++++++-
>  arch/x86/events/amd/lbr.c    | 13 +------------
>  arch/x86/events/perf_event.h | 13 +++++++++++++
>  3 files changed, 50 insertions(+), 13 deletions(-)

Applied to tip:perf/core for a v6.10 merge, thanks a lot Andrii!

	Ingo

