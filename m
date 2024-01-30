Return-Path: <linux-kernel+bounces-43672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B76484177A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2C128439F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5C912E55;
	Tue, 30 Jan 2024 00:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RLSJQ4MY"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A7F1DDCE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706574890; cv=none; b=uYNTybJmGioq2UEpNs+lKjMHt7voeMqrt5kzM/XgrZDQOAPfPgb1r2iVGeG49ivzYfBtbtT7HJFRgDjZzIVAwM9BoziBosNkS71y1fPWS/fREzl6JYX+lqj0AaJEADVmtNNVQTOnLgrWi0pSQ+od2R4kCzBbuolXSTGNPE6QbtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706574890; c=relaxed/simple;
	bh=6a88zGeHfI/raN93JaHH9+Y3rRNkrHlC4DcH+sLtzew=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C8eh/sHZdrXoLdBbZfEQbT2I+HKJ8Aqbj2Pmz3Pnt7qZy5N7JZuZpvHX7Gd2hPZKyRbJkeJaiIlH5BFcDh05tFwIciXJXMdjJGyBWEB1WZv/3ooVYTvrJpQOgrhmbnVkJSbFGxSHl4WjUxV/sR0lC6+6PrlG9CA5mUMK85rsF6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RLSJQ4MY; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc251408f56so4954922276.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706574888; x=1707179688; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qrEqqsKO32wWhh10RHbR74aEN7YQpI1FoosJGh946BM=;
        b=RLSJQ4MYCpSCcZxDQVOKkZVAVNNv2s6gZCEOMsa4TaK9uJay76BCr3VbiF6R6uZlUi
         GEq9/J8hiHBk19mpB8/acF4OXFT16CgN6ejRVi/8WjboyyTxGLEkHx24zejqaOcWaKb+
         9/4SYfTa8jga8EtV9y1VyqqbTp9QTjVTLVMJCJz7vsfaaO0gi4Lhh0T/oyj83Zi8qULm
         +OfglmiG5qHjjt+4KuPXoy69XeL0e1Mx/ZFR3MVoNPL9e965l67oA1tEAE+2+u6myFE5
         FzanPL3W605wwXilJzhjmg4adohqAtUt3ein8CwuSsbqSFd3EYAHBhJ+fHjkghrG4qgu
         wRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706574888; x=1707179688;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qrEqqsKO32wWhh10RHbR74aEN7YQpI1FoosJGh946BM=;
        b=qjef6YUOE8c+5q6KJoOBtGlDcWHR+XWXz1vh17FWkqBLNao1eB05R/AfJxIGqXiU7y
         UY0Ql1Ew24B1x4tBXJQWN8RDLK3HDDIPFa1Go0FG0h0Js0Qqh29Jo9MyXh5d78M0FZXI
         JCfxXSV08ZuCaJRpl4AYInvvhM7J0QkSvNeuHGmApnhmAy3ZUl/JUTgeaipi82fjAFk2
         YrX0ZPQxn+NqBI3b6yP6bvv4lzJo7d1wcwUsnfUEOqXZgDEjB5JVE26zz1/cNj0xk7U9
         5mT49cSl040hdaCCOj+L4d27jvPEBrvHeeGQz5R5N/hpE93vT7FgHX+zMxgmclPA8CbK
         q1kw==
X-Gm-Message-State: AOJu0YwaobLf/cWZhYwECrFBJ73c9WIZbFrrscLUXvhdQyMb4ahAB1ea
	8GV05o/sm4Uw6e20NjWPi9HAKcxpxIN3A7G5aY5bTuN4Pbm7Xv/vMg5/aQw4Dwwp95ceykiLHIH
	5svTY+tKuedJ5VYVp5A==
X-Google-Smtp-Source: AGHT+IFDWbA0HhZV7ctsFWZ3pdmhLC8xRilZdt64nU+64DjB94a4G6QKQYBTzSxvq+S017wcMbZ8IB5gEkmP33Pu
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:e10:b0:dc2:57c9:b44d with SMTP
 id df16-20020a0569020e1000b00dc257c9b44dmr469745ybb.8.1706574888351; Mon, 29
 Jan 2024 16:34:48 -0800 (PST)
Date: Tue, 30 Jan 2024 00:34:46 +0000
In-Reply-To: <20240126-zswap-writeback-race-v2-3-b10479847099@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126-zswap-writeback-race-v2-0-b10479847099@bytedance.com> <20240126-zswap-writeback-race-v2-3-b10479847099@bytedance.com>
Message-ID: <ZbhEJh1ArplXpAwb@google.com>
Subject: Re: [PATCH v2 3/3] mm/list_lru: remove list_lru_putback()
From: Yosry Ahmed <yosryahmed@google.com>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chriscli@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"

On Sun, Jan 28, 2024 at 01:28:51PM +0000, Chengming Zhou wrote:
> Since the only user zswap_lru_putback() has gone, remove
> list_lru_putback() too.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Yosry Ahmed <yosryahmed@google.com> 

