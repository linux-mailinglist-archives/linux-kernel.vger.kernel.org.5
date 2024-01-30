Return-Path: <linux-kernel+bounces-44091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA80841D39
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4E528C4B5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2809757874;
	Tue, 30 Jan 2024 08:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D5hs1Re+"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1B457864
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706602196; cv=none; b=N/JcA+EkDa4HkdKR2e3cp2THCiRNoLCVpIe3FD///pHnjR1o/7KM706arKGZ5aFXBJ12BQa1Dt+QSb7p+B+YvoG7jT8kjANrSU18pCbIXZkukAok64dkeKmAEgg5g1unMHe31+3rwsKUzUnL711ybTkshgwLP3jn0tSXk+VYBX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706602196; c=relaxed/simple;
	bh=GZ1zBMtuXfkWL8BtLIPy5NgZc3G/0cKoG3zschPJYls=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DG8+YmPNKGd67okN4p7xGqzYdqkrn7ZDZvi/Qse4aBKUPZCMq9CRVk2TTVIRL4iTY5w5JkvMWtDkhC1Oz0e+5I/VboXhFO4H/P7Fuj5nJMmhOJgW469FsQLY1Qy3siX+wXxEfThBai/85y0jDL/TWBfhrNDljLN1Lttnl62J+qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D5hs1Re+; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ee22efe5eeso58920387b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706602194; x=1707206994; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9yrsTLlhAyWR5XamY20PGjqLq3Kvs6JOukRf/8vhRqc=;
        b=D5hs1Re+5AxRQw795aOmvBt4e/uhG62HB8vSJ0XotmrdVDhx8ijjlm3WtI5MKnl1rS
         SETEArHgaLWFTkDHGD3h6WkQXbMQmtqv4E2fvp35U5WjrzcrXZlja1HAy4/7Rn6kKFFo
         90TyvtTwdayMhDjghxY5XYpdWhrXVihXFgZ3qdbnYo32YmutYbLLTWPfl2jnlamhifmd
         V95TrwxZsYB7waRmJd802lxuXYvKCuzgIZxEkbzAp8GVE5tGM+QZEpQEjxAGnWpZw/0R
         Abv+NvbynO0X/PuHsoj79eb9ZTJEVOlcoPZUJ3gcqyG/nVSl8QqjzIU+FnBbExqyl16E
         Cbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706602194; x=1707206994;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9yrsTLlhAyWR5XamY20PGjqLq3Kvs6JOukRf/8vhRqc=;
        b=duG1urgQzz6xTFDNUdmQmHZG7oLNSzuueMxM3lGfME9cSCDBCm3wUfiqwPyxvmxxqT
         es2xgb5kL4HJ6RO00B6DW7Yz120JkSzzIhC4BuhPhPzU3AcpoOwpDsP6QWn+0VkxvbkF
         rVqKGH7ga8n1n7T9Fz59QH8urF9jQqt2RMg01K4M21GUnTbRoQo0NkgYrTV68/61hT3l
         YbgM8ttlUxX3jwBGR1GasGUVV+dOLb/m4C+thTTon+V1CGbZpS49mwLaTHDKs7BhrqZR
         0ckcQAApS7oj1W2tCOf8dvQPIrIUTG9ebgAiaAU8GwqlYc+rolXrfxucg70WixFnkDLT
         q67g==
X-Gm-Message-State: AOJu0YxaUZQP38Mc1ZUghuGgI+g31ihYAtpaA6cjSw9615yZtmAr50GD
	kfH+qZYuGkheO+qkCUPNAsmrKE9v9WQevFFAsQB4spigWrUcIm7DzrtNKnUHvTRIQDG3wkP5PPr
	LeRcyPTUX951RyNiACw==
X-Google-Smtp-Source: AGHT+IF0Wmhs7hw4HNJ/7j9vsnNmqU4IA+jjwW+yq7Ggm1nMDX4e3VXGmNz88WUmYYb9T8qYxcklrpqyuYXXa4i4
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a81:a707:0:b0:5ff:f6eb:8916 with SMTP
 id e7-20020a81a707000000b005fff6eb8916mr1533962ywh.9.1706602194115; Tue, 30
 Jan 2024 00:09:54 -0800 (PST)
Date: Tue, 30 Jan 2024 08:09:52 +0000
In-Reply-To: <20240130014208.565554-4-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <20240130014208.565554-4-hannes@cmpxchg.org>
Message-ID: <Zbiu0KeH2fHLA609@google.com>
Subject: Re: [PATCH 03/20] mm: zswap: move zswap_invalidate_entry() to related functions
From: Yosry Ahmed <yosryahmed@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jan 29, 2024 at 08:36:39PM -0500, Johannes Weiner wrote:
> Move it up to the other tree and refcounting functions.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Yosry Ahmed <yosryahmed@google.com>

