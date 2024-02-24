Return-Path: <linux-kernel+bounces-79853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A61D8627A0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784E8282434
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC3C495E0;
	Sat, 24 Feb 2024 21:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XgWlK35p"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B208114B820
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 21:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708808459; cv=none; b=IwgoTenDyPR7sTlHJFP4a/ge56qERKFirXOdZsm/Ba4ddx0cGn5/WRCF937SC/NjkRaRl2hwt8SIeTSmXzsDiK6BvUWW9T+XT53cBXi0VjiJ6eWYd1Ol+LpWC7DRp9UlT3d9KJhTQlD8MyG391ElRZKV1Jxpkt8letwuKqkAZwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708808459; c=relaxed/simple;
	bh=g7TeQCQGEEhoKY6gH7aJ6Lplh/L+wcAYROQ4jmZPUsg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rA5OJFzzHAALyw5zlSXjUTeOgOcjDAImLjEu+csENiWJfVjLspx/XTFOXZA91fp+gY24+Sr1LbDdiIMtSXYxo39h8DhL6RWFzOyh0QYZYv2NRJRyP7AdGFcS8mlZnXQXE76ZbSnjWaBcbxitK6wvvADJtOGY8CszyHSHtHYC1lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XgWlK35p; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc744f54d0so127295ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708808457; x=1709413257; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X3wcsrUGLumHpSftRKJTOmQHGqRsK0TVAD3bFgayXNU=;
        b=XgWlK35pBg2Qu918oWk50yO0TiidlFxGs1R1Q4uTJO3o+HQJsyclVuT+gdvJMG2emI
         5iIgD0LG6CPtOFKoe9l3quWXU2ECwI/iV4IdqN2K32C0M+fF6cq4m4q/rdedbGbuXkxb
         CTpEpq0XIVDQQdmgP6KyG88/fDpw++X0Zfu6Ojpu+wLM3aGGw53rPn1gNSPJ1LCNoNr1
         8mcnwh1uUdGdSy7d4qBnQWFvomFWtLWhonUNvf5FvgrVF+iHwLHcG0AghVqfoMTTOZO0
         /rD9sCdxDRukgr9mQHHA5tPAJ3pTqVlrus3ykB0MyCl5bbrrChwl9PBvGeK9RiP+D8nk
         ux3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708808457; x=1709413257;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X3wcsrUGLumHpSftRKJTOmQHGqRsK0TVAD3bFgayXNU=;
        b=K2bbznFlHo8qBJj69H73DQo9H2CH2pm9GZrPWNigtouwnRhQ5T8aWzyPK83X9eGBYl
         1EqRTOiOihQbBvora8p96PdVbIG7BsEZux1wwEK+Zjk9NYOfyPBw+tkWa8iw0fZU1abs
         e9yL3gJ/fpcNwcTxOWSX2aTU2UfUQXW/4v3lGGtusJe25skY2cjCNvkaimcxkA6KgPcc
         xL77Cm0rj5PXM6ACcdQn9tejciRLxeueaZBjsKZCycE4pc6/Q8M38Qg3v00WOo6qrM34
         Uz9J+2ZFe8deb0/C/S3sS6EpVQcGkKOFYSN837Q2lfznV7nXrWRPWNwndSybgOMEt4cR
         tVsQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0U734nQo7C6IV5dP67RyXb3kw3VzIzGywzlSTXsc8eGzsDW7y0sJBoFL6ML9DsxvoeN/9Le8oW1umJqjgQp2AVlXxTNzZWAQONjtY
X-Gm-Message-State: AOJu0Yw2TMBBePSkZ6w7bQ5Br4WILMLlqS9NQh9mMD61D4MXiCRuWF2u
	eRWuf+z4EsyxYVjCxnUaL6bZE17xNcadUfptrWE3+RE9inOcHmtexED5kXbPuw==
X-Google-Smtp-Source: AGHT+IHHjY6nDOg9bhJ9dnvkhwcKQxgZDtnK9Oc8W19R4Kq2nhzVvKBtt9UwlJ02WykCA+dTBfe6BA==
X-Received: by 2002:a17:903:84b:b0:1dc:f0e:51 with SMTP id ks11-20020a170903084b00b001dc0f0e0051mr189957plb.17.1708808456663;
        Sat, 24 Feb 2024 13:00:56 -0800 (PST)
Received: from [2620:0:1008:15:ce41:1384:fbb2:c9bc] ([2620:0:1008:15:ce41:1384:fbb2:c9bc])
        by smtp.gmail.com with ESMTPSA id bx33-20020a056a02052100b005dc507e8d13sm1252883pgb.91.2024.02.24.13.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 13:00:56 -0800 (PST)
Date: Sat, 24 Feb 2024 13:00:55 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Vlastimil Babka <vbabka@suse.cz>
cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
    Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
    Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
    Alexander Potapenko <glider@google.com>, 
    Andrey Konovalov <andreyknvl@gmail.com>, 
    Dmitry Vyukov <dvyukov@google.com>, 
    Vincenzo Frascino <vincenzo.frascino@arm.com>, 
    Zheng Yejian <zhengyejian1@huawei.com>, 
    Xiongwei Song <xiongwei.song@windriver.com>, 
    Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
    Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 1/3] mm, slab: deprecate SLAB_MEM_SPREAD flag
In-Reply-To: <20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz>
Message-ID: <a1d53915-7177-aa3b-6b2c-ae2dfcf7a83b@google.com>
References: <20240223-slab-cleanup-flags-v2-0-02f1753e8303@suse.cz> <20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 23 Feb 2024, Vlastimil Babka wrote:

> The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
> removed.  SLUB instead relies on the page allocator's NUMA policies.
> Change the flag's value to 0 to free up the value it had, and mark it
> for full removal once all users are gone.
> 
> Reported-by: Steven Rostedt <rostedt@goodmis.org>
> Closes: https://lore.kernel.org/all/20240131172027.10f64405@gandalf.local.home/
> Reviewed-and-tested-by: Xiongwei Song <xiongwei.song@windriver.com>
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: David Rientjes <rientjes@google.com>

