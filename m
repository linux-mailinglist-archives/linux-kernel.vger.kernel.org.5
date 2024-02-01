Return-Path: <linux-kernel+bounces-48625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CA8845EFE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5DC1F2E981
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E10A7C6FA;
	Thu,  1 Feb 2024 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="By3zVbF6"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74FE7C6E1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810141; cv=none; b=ett8U6I+bUgpAt62OjyKfUMg7OAoxhDlBLHni33Hd7LvOzN+nX6fQFNHWNNSfj9GZttUE11MTYX3fPVIJKhTHmg5XNS1dSf8URLtjbY/5KyBfOZOtkeThtLnfeMe9lqvWEjzvfJUpaEHL0ThmhfuL8t7T7b8ZDhutRDDk9bhYHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810141; c=relaxed/simple;
	bh=dV6oNXd+2e/H092Y22BMqRwBAWqrLexmRYZyKWIvM2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjUz8nURniRUOBrzIGEvzqnCyaaH2cwuwKKMuVAMRNmmG/2A3nqvGPcT0FgUaBihC2oZCBqQuEbVrdR2TFngPsja0rukiDdfSXhS/+LwhI+Xb0BreFGgKn9rt/7ysco5+6bnF6g/mSpolywKSmeBXuzymE3keBiPxbiF/xlz/Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=By3zVbF6; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78407987510so61889885a.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 09:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706810138; x=1707414938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyoNn/8wgmrq9VdNQwCp53K+tV+bnZPzOQWmrda9Xp0=;
        b=By3zVbF6ZweWVMbfiSLeOirR9fniqX4rmX4loCLyqbGK2I9/OqxUUtn+YIa0gfitoy
         NzkY/xfV4QImD0lwB6OmRC8X25O0Qdsij8jecHpmfYL2mh0KqwVLD3RXOqPq/6gBHCDk
         hc6cnhPC5cqRt9SZOSr0I6lyC+ytnemvIZl+7tDZw2QZW+B80uwEK0pCcVoj+E4xEKuf
         Qrj3u33VZ6IvP8xu2AqEzpWzF/3qXGibqzxDtAJMfJ/CgihLTmplxkHflUM72Qd+JtVu
         yn60GoPIoZMPxa/xTwuOEm5+KW9BPMAuspTfYSKXHScP9OGuvrAmVkzJvGXCRfaFhoxn
         Hlmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706810138; x=1707414938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyoNn/8wgmrq9VdNQwCp53K+tV+bnZPzOQWmrda9Xp0=;
        b=i8je1wgEVIbRJCO5PaxQ/EHXRTchHfdV0SxqiUMXsI6htDuhF+W9dkJxKPpBD2Amom
         YIOHdE3J7M/3NXDxuuIrcqDawx0aFt6IHkExpB0Dg37g28nYSoLgYu65jEpNNYCmTgZz
         ex1MzHZIgE6xiYjAuyBz+Gk124zGuQM5PW5jvcxd7FeFhh6HJJ0MjrnnumD/M5ltNlTp
         w9dUvIHt8WkGF5JsdbzG6NPMaSj42JlLfNZMikcmTpR6Nu7kGQ/hNypGytUhDt536FKF
         mdjvY40h69+glJbi8e05ZvyxFILEAm+TuVtj00g60NsvlUs82Bt8q0rY/4yYYO1IcXBj
         aQjg==
X-Gm-Message-State: AOJu0YygUtWI0oc+LDETrpM0VkUc9FpCU5GMr1J+/OAsxnreaab/9RQl
	oxwo5RVGDufKM/HpzBMzabELsD9dgg4SFLyNjpH+nnaSq0C0blRgFZx+mmgknd7xfsM96OLV51y
	h
X-Google-Smtp-Source: AGHT+IHa1oTOeowTtnIcFVTjqFZCGOe4UsyYFHSiC/PC4YkGfoRzmQY74ALcSY0rrJSEPHtOtigM8w==
X-Received: by 2002:a05:620a:851:b0:785:4fff:1265 with SMTP id u17-20020a05620a085100b007854fff1265mr1083706qku.18.1706810138466;
        Thu, 01 Feb 2024 09:55:38 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU/A2rYcoz+I+ZynYb27DtPNS60jOEA3ZHELv1W+lsJtgtQqruqW2H1/K2kxF0j591W9a5fPVxo0nVa2J5D/qEvmnLvRr62FygHVw7s1lar+G+x3vND0YSktXfPwWZozAi35cy5Ho2L5b3vrHrMVfGOGaVhuegTOCVMnKIUXyHLRLYbUOKm2VmQD3ossBPn7Oqcfw==
Received: from localhost (2603-7000-0c01-2716-97cf-7b55-44af-acd6.res6.spectrum.com. [2603:7000:c01:2716:97cf:7b55:44af:acd6])
        by smtp.gmail.com with ESMTPSA id k4-20020a05620a07e400b00783dc450d84sm16978qkk.12.2024.02.01.09.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 09:55:37 -0800 (PST)
Date: Thu, 1 Feb 2024 12:55:36 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 4/6] mm/zswap: remove duplicate_entry debug value
Message-ID: <20240201175536.GD321148@cmpxchg.org>
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
 <20240201-b4-zswap-invalidate-entry-v1-4-56ed496b6e55@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201-b4-zswap-invalidate-entry-v1-4-56ed496b6e55@bytedance.com>

On Thu, Feb 01, 2024 at 03:49:04PM +0000, Chengming Zhou wrote:
> cat /sys/kernel/debug/zswap/duplicate_entry
> 2086447
> 
> When testing, the duplicate_entry value is very high, but no warning
> message in the kernel log. From the comment of duplicate_entry
> "Duplicate store was encountered (rare)", it seems something goes wrong.
> 
> Actually it's incremented in the beginning of zswap_store(), which found
> its zswap entry has already on the tree. And this is a normal case,
> since the folio could leave zswap entry on the tree after swapin,
> later it's dirtied and swapout/zswap_store again, found its original
> zswap entry. (Maybe we can reuse it instead of invalidating it?)

Probably not worth it, especially after the next patch.

> So duplicate_entry should be only incremented in the real bug case,
> which already have "WARN_ON(1)", it looks redundant to count bug case,
> so this patch just remove it.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Either way, I agree that the WARN_ON() is more useful to point out a
bug than a counter.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

