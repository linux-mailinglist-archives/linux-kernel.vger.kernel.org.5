Return-Path: <linux-kernel+bounces-85489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C392686B694
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653AB1F24642
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0876940860;
	Wed, 28 Feb 2024 17:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRBJ0nYM"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33324085F;
	Wed, 28 Feb 2024 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143120; cv=none; b=Am8p29rKF3l8XZsOgwZzjxLwcPfA1aB3BMJf3tSWKRKJNg7qMffMuYyS9sL4o6bpMlpXf7tTFxdIStKKDDGjsfd48xZ6EKcL4PrCGtmvw3d5FW3TV5BREgTQympFjFPoLr11YU/hwmdb1xjOhvmowGxY2oWM7HH5oxiE2s0crZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143120; c=relaxed/simple;
	bh=xE+bf5+hKby7lhQQVgM0WkM7CD9AAijXpIxSLBRi39w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7wiso2HXDqLmE6g5sLEeFfkJgE36NsQGTX8bZQpcJZKyAXZKF+2apVrtJjMzVVEHFgYP2O5DvNDxB1kvQJJBDHEKqdByEmLnX6Trl0j6IlrLFRwTS1o7DzB+Qi37+MqL+sV2yVdfHoI3nYkEK3mm0rS8MvwIxpVsHmAR884FC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRBJ0nYM; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e2e5824687so2284230a34.0;
        Wed, 28 Feb 2024 09:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709143118; x=1709747918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r6+od4M7plalOCC+V2PcfYZk/imvHAERrD1XjnFHhGw=;
        b=gRBJ0nYMcoxRTI2PEgh3F2wN5ZkRjQ7ECu85brewH4lwFFmA2JsU1X6FLwxceKjjXS
         Vb7TuXTp6AEOna4QWkiqb8T+oFyzYyLHkmLeIWg7+UC7IIutx4dihRI7QHl3vcW43wMt
         RhbrZ9Iw7g502BHMjAZm35yYTQ9RaCoIavAgW6zu7HE8ckF+vSuDw2khoUE5YoU6Atog
         DjEMBS42DZ1O3M6qS9vcwljOrOj9+WxG/gRQqe9Xr9KDPdmQp/3l6N6JOhBfWJRhG6kJ
         HzgnRw95VRd9OE4UloVek4HrPnOu3jv/8gwnsdTNXAJzrL8XTJH/1FLu4qizKQY+VfCK
         etVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143118; x=1709747918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6+od4M7plalOCC+V2PcfYZk/imvHAERrD1XjnFHhGw=;
        b=vMcdO3EcMkomNNR1tCBVVCjJ5ODz9r6uZLRL8NlYilhzfNE5q/IN37lok57GPbIHYE
         mWI4zX0Syqd8HtQPGYR5eWXMmY7nr6ReSWXH3+w21sJWx3ywpOuY/NGbjNHKm+V0LGxc
         kLkmv65qWCpk4Bsx3LtyuqNCc1lqC0nmdX220A180Wz9uPp1g6fzuec2alyi1Jbv55tx
         D4MW9aOufQ3dXWkosB0LvTUC9zhfDGyFXgcwn1yNFzN0zHUh3OjH8YxsdRPvxwzi6Tet
         UTqv5UW3Jx+nDDWEHzC0qcrOKaxp6WayDDPJMDQxuVu2NTxZjVBTfCe1D1l72afQ9Jou
         8pYA==
X-Forwarded-Encrypted: i=1; AJvYcCW+++YoPFLD2oWgIxRKklQ8tb67Gl4iEOGDauVQyVAxzGoj9+vLgeem5v1/hUdJhBG0aNVMyiQetrgv+LZVRnW32V0gb93Pt8v4WsKGaL9d8huhVRwuwbW3wEqyFUsDxmUmWxAXGzsVLwNN3RuXL9Ix
X-Gm-Message-State: AOJu0YyHNtec5yZYU7xxn4mw1srulyXyyhnruN07Qsvbfk88Zy+T5sT6
	Dpw+KJ5WNGkzx+raARJZLAy4uZBpWUbbOhWLjIHUQOzwCZpvQt1a
X-Google-Smtp-Source: AGHT+IH0zxVRYEXNk7dmlukPyuH258qRjzs1CtkYDOnVWA18uwWm9qtiPoMrJbhukJCNKjp0U126Jw==
X-Received: by 2002:a05:6830:22da:b0:6e4:3228:4730 with SMTP id q26-20020a05683022da00b006e432284730mr314236otc.28.1709143117902;
        Wed, 28 Feb 2024 09:58:37 -0800 (PST)
Received: from google.com ([2620:0:1000:8411:eb4f:78c8:59f0:3de0])
        by smtp.gmail.com with ESMTPSA id w189-20020a6262c6000000b006e58120c241sm202976pfb.191.2024.02.28.09.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:58:37 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Wed, 28 Feb 2024 09:58:35 -0800
From: Minchan Kim <minchan@kernel.org>
To: Richard Chang <richardycc@google.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
	liumartin@google.com, surenb@google.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: add alloc_contig_migrate_range allocation
 statistics
Message-ID: <Zd90S7RVgCfwtpxZ@google.com>
References: <20240226120728.3f495fa7@gandalf.local.home>
 <20240228051127.2859472-1-richardycc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228051127.2859472-1-richardycc@google.com>

On Wed, Feb 28, 2024 at 05:11:17AM +0000, Richard Chang wrote:
> alloc_contig_migrate_range has every information to be able to
> understand big contiguous allocation latency. For example, how many
> pages are migrated, how many times they were needed to unmap from
> page tables.
> 
> This patch adds the trace event to collect the allocation statistics.
> In the field, it was quite useful to understand CMA allocation
> latency.
> 
> Signed-off-by: Richard Chang <richardycc@google.com>

Acked-by: Minchan Kim <minchan@kernel.org>

