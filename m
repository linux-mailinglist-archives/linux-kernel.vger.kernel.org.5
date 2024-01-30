Return-Path: <linux-kernel+bounces-44098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 315CE841D45
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6C41F23EAE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA5155C02;
	Tue, 30 Jan 2024 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kPblFjks"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D87A54BF7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706602344; cv=none; b=IEdlHRcauXwO28rNkO34ZS+BVIMfwO0dTZIwtO7IFj0fCo2btgZeM7vOQGjZ/f+33g6wD3xOPAoq4WGhTTYXi7VYDoThfyFbKsb6zQ27Of77E6Ie9d3jwHFhuG2q4wIosVRMz9JbaxTGSlun6L0rK28x6X/x0bH2EYcMgGotDQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706602344; c=relaxed/simple;
	bh=eoDHCGULiZaiVAIT8Qbigxp9/OCrCQz2Ml2F03WV+GI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CMNVN8vSXzT4/mVnKAYx3bgLnRftvSYJDCrIcvKmTQFiKd6k8GpvTSUcu10Kk2zqKfjgwnC7ySHRH2A1Fw9ckYsdzwNMkBaFmVVpNry0k1Ku7AbB6pw0gIhCmp87ViOdmC6ko/5ouhEoEcKG+yqC3VlL+kumkWT/oFwixxpV/MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kPblFjks; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-603cbb8ebd4so26835837b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706602342; x=1707207142; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KxgbaC8ibp/Nn5JOJr/iczAyfc5yUQS/YUOOzTWbh7Y=;
        b=kPblFjksl4FRek4KidWqCItqqrvJnsCQTGi9qTe9n4rkQuF1GQ7OajL45EoEi1vORh
         h6BviDvQpTLHdZQ4NCYy/OZzWIFLHUQnJqFknH2AZB4Mx6uwHQ/oJ6RoiWvhSEn751lK
         vZMZANhhktujCgYvlvnC7Vuolg/nIU+opc/ScpKqAwDKyKUv76ecftGUzIBINTlMe2I1
         DhAS6fI2lFhY08fassGg0Ufij0FV8bTqbz6FuBwbZVk5LApFXQ1JOmafB3AafcLkOcAL
         V6EMUk86tAZ6px/Y112Q3MxHTfOlfEJsWGBPIy+GtfcriznzaFm0btvohqgAbYxbwGuC
         wDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706602342; x=1707207142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KxgbaC8ibp/Nn5JOJr/iczAyfc5yUQS/YUOOzTWbh7Y=;
        b=tpyOg1Cu7MtJQzoUa85+o68ZeZQcFPVSFHm/WXPhRNT0XOOzA4fX6MJkcH+501ZhMA
         MrBny9MOocc/KVn2Wy4rjDNYhSE/0tJhCt1/V1XfzgIlQpnLmNCp7Xqr3wII+9wV0fSR
         w16iwmuIiC8Cb2HfY97RxZzkwteNsWJqBBz3Nd71Rp5gQ01y+gSvWa4rSPSinG1CAZOk
         F79rN++5iUOAm9O9M1Dr4yXAnScd14B1GOCSMgGvxOrq3h1fVJhGOlSUsry2Wt0wEyzb
         Aa4GnmkwQPBUTIPR6lF0cAIJGccNM1tBK/HMKtKIFIT5MYnmmSV6xYqfBjrHTRJDpYfB
         ag2w==
X-Gm-Message-State: AOJu0YwnPbd19O3fKHPxqxtcMbfsA3ZCqFvvL75Mwr1tFoq86pWdN+v3
	NMi+N4DzwRUA4EjfnuB0aQXVuV0UqzeeONNt+1OZK9u742QnAE/mq7pznobLaDlsDIF08JG/JPa
	PXvYZhW2++uZpJ1xL4A==
X-Google-Smtp-Source: AGHT+IGQskCjKzTgfcP/J3yX1uE0o4Vjlq4IixL9Z4YMfLtYqKL5X4HPxe2LoWfTAzvoXxfgnTEXHOneLwKJV29F
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:10c4:b0:dbd:f7e4:c7f5 with
 SMTP id w4-20020a05690210c400b00dbdf7e4c7f5mr486918ybu.10.1706602341970; Tue,
 30 Jan 2024 00:12:21 -0800 (PST)
Date: Tue, 30 Jan 2024 08:12:20 +0000
In-Reply-To: <20240130014208.565554-9-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <20240130014208.565554-9-hannes@cmpxchg.org>
Message-ID: <ZbivZG_3AlY9-ZhF@google.com>
Subject: Re: [PATCH 08/20] mm: zswap: further cleanup zswap_store()
From: Yosry Ahmed <yosryahmed@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jan 29, 2024 at 08:36:44PM -0500, Johannes Weiner wrote:
> - Remove dupentry, reusing entry works just fine.
> - Rename pool to shrink_pool, as this one actually is confusing.
> - Remove page, use folio_nid() and kmap_local_folio() directly.
> - Set entry->swpentry in a common path.
> - Move value and src to local scope of use.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Yosry Ahmed <yosryahmed@google.com>

