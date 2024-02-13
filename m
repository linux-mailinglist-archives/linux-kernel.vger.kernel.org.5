Return-Path: <linux-kernel+bounces-64001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B7B8538D0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A389D1C265CF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEDA5FF04;
	Tue, 13 Feb 2024 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sSzNwVKY"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA67111A6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846220; cv=none; b=lBPPS3ImZ7nA5E5ucsVX0J8myzDb7VkCPj7EsOKkBXsNyHnYM0kU3CHsfUCN7p2/6s2pbvN0yqKbWRh46RKiCwm+ma+JsiAAsMX1ZmTuDz8kTsy9ZL1zPpbG+y1ljMr63onQuy281y+ahHRuGrQtT5ECPk2O0Ronv7Yx4edH+Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846220; c=relaxed/simple;
	bh=jeL3jmuNA+2cZ8gk+1JE/g89YrEigyGIek9rxeXkew0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dunDTxZKy8dfHFrbmmROQNFK5Rm1q8zRFOMfoh6cb3MFYGyRkvlHQ5Ozdbxz04Gfw9v6fSslLSri2nqqdRKRaqc3qypoYDzBRASWOdjkZfsulm4GhE/zdyMFtn7DL/NMC/VLTY3HMqsBq82QoCbtZqZmiZGHnPKT/c4CVuf00r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sSzNwVKY; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc58cddb50so2050981276.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707846217; x=1708451017; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2KwJMEy4sS/qM3Y5N93JFeZraBwlubTDdqUKKmj/hdQ=;
        b=sSzNwVKY2PX+6cMy4LLJ+bvj3AmNQdLQYAS5zl699PuOTcefxn6fbHX9iclVaz73cF
         sYSy5tnVaHV3iF39voT/y2EvwBJgEyFoT3sUWWJgMMZFG/B0FlnERnkAs/fUfvJnDEI9
         nfkybi4DFnwcrwLDAe2j6AUzlr3Isx92udggpDdKTJJVeLxR7iN/Ax2D2gM7+0d3dnnF
         Qcdg1RHQ9rH3xoJDgsgpcsuN35yU+tMgIJbZfwuyu+H7R++Eo82RNl+HNQIbQMRmwsm6
         th+k+aVNphC8WRwyoNid77Ai7zC2M53/pf0Q5g3+ZgmKKGvkclZ1R9CqBx8Ndf8jcz0O
         vAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707846217; x=1708451017;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2KwJMEy4sS/qM3Y5N93JFeZraBwlubTDdqUKKmj/hdQ=;
        b=QUhp84urJveHD1nseWB8gumucPDo4IokQ44bF7ai2rQSQYoWBxUG2exocqGWGGbu6F
         Wa/oD9IzNZuV9PbB6UZU32fl9zkxPA0OSdwtmaGXct0lYSGTyf2SUeepFps3Iha8bWzS
         6mqpyrv+9d8BAdHIr7uY9P/Ebl0Mc2IdaLEmZZIVach1LcQtXkB33tKtxEtddaJsMR6X
         AfbhFN9ZHg8cJGlahupWXsdW8iObcGZjKcvHAzy05mZzvAtP8+69dBV7vG80US0N6viI
         H9lCvyIGYH2nkQFa5+VUHdBdXWeDGIMfqIudbRHooAm3zT9IpofAIFTArVZvXlL+5FBy
         jA6g==
X-Forwarded-Encrypted: i=1; AJvYcCVKC40+wzDb3wynz+5VVU8h9ZlIU2YxnafLr/Vkr1gxP7wLGY8GecmurJDw/WlysVRmJ4eew/nxhKdTKQ5TZIp6fl1bkTQdUEx1uvFv
X-Gm-Message-State: AOJu0YwAo5w8t8pvYPLmaO7wNlEsijUHYqJRaVzr1mbGTLZ/Y036MTYH
	WRqtWZP1wKKag10vWwATMuNe4jHizv+pethWOs+UyYinRzEPh+TTbxORtFBD73Nj7CB83wHlFth
	Fm4PBoH4qcu8PPiXD9g==
X-Google-Smtp-Source: AGHT+IGlLBH/abZsC+jCB97eWiFSL+EQnp3tg/1z71JKyCYUkKCSbCluqfyE6etiG3YuwSx9HMgMW2+Rf/dUggc+
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:1109:b0:dc6:5396:c0d4 with
 SMTP id o9-20020a056902110900b00dc65396c0d4mr2952081ybu.1.1707846217557; Tue,
 13 Feb 2024 09:43:37 -0800 (PST)
Date: Tue, 13 Feb 2024 17:43:35 +0000
In-Reply-To: <e094857d-41c8-4064-8475-a5a43e315f6d@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240210-zswap-global-lru-v1-0-853473d7b0da@bytedance.com>
 <20240210-zswap-global-lru-v1-1-853473d7b0da@bytedance.com>
 <ZctnRnNMOwQNn_3j@google.com> <e094857d-41c8-4064-8475-a5a43e315f6d@bytedance.com>
Message-ID: <ZcuqR7KeBPuarevU@google.com>
Subject: Re: [PATCH 1/2] mm/zswap: global lru and shrinker shared by all zswap_pools
From: Yosry Ahmed <yosryahmed@google.com>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

> >> @@ -353,30 +353,16 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
> >>  	if (ret)
> >>  		goto error;
> >>  
> >> -	zswap_alloc_shrinker(pool);
> >> -	if (!pool->shrinker)
> >> -		goto error;
> >> -
> >> -	pr_debug("using %s compressor\n", pool->tfm_name);
> >> -
> > 
> > Why are we removing this debug print?

This pr_debug() was introduced when dynamic zswap pools were introduced,
and it was supposed to be printed right after the compressor is
initialized. IOW, it is supposed to be after the call to
cpuhp_state_add_instance() succeeds. The call to zswap_alloc_shrinker()
was mistakenly added above that pr_debug() call.

Anyway, I just realized you are now removing all failure cases between
than pr_debug() and the zswap_pool_debug() below, so there is no need to
keep both. You are right.

I am wondering if these debug prints are useful at all now, but that's a
question for another day :)

