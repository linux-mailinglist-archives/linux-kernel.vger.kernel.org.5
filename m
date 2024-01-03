Return-Path: <linux-kernel+bounces-15616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F608822EE1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B792D285825
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A9B1A58B;
	Wed,  3 Jan 2024 13:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YjxHSvjG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F841A582
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4b756f2aebeso869735e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 05:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704289599; x=1704894399; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iXiRlPNEbOMVVR0getTtwBYLPyTAkQ6ZYT+RkbvnME4=;
        b=YjxHSvjGY1WmGpBgHWL3O4uUe34GFdQ6d/PgeYtb0RmSVthtTVBlDl60iGqNJaxYXQ
         RDrnmAlvQFgTvVmHFRYcd4aL6RYk55gKKMd07wukYKU64+ASE0aUbEXj9/Se7zPDlovQ
         Rr/9jZMHjXyiaMUrtrcmMeGcUIWvB9oZYTt/d4gfvSVNuZh+FyLkTInRHCC1MHjfcTD1
         BS9XAyLZPP72ISsRzz4PrGqGW2WmqrXMUnJ4h16vZ35H1qvtRXdt+Q855LoIWqXxuSVC
         MJOcQOCJIZ15C/ab9vAV9peAHlYdBRHXtPJno/PlWKzeDtigs1Thso2rf32GqIfqcMNv
         /qaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704289599; x=1704894399;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iXiRlPNEbOMVVR0getTtwBYLPyTAkQ6ZYT+RkbvnME4=;
        b=T9CG8YJORQiYOXj2+9CM1YuEjbA+wY56LyyG2tKh0jRwMGcMu5pHKp/Iqox6I48ua3
         kf3MeYN8maE4RBH2H8VdwyOwUoI4v/yqL37LHlzZGs/YaiJh9aaEPQ9vT2NH8GW9KLpd
         icwDdQe1KrA+9msub5+k7Ad+76oKsJNUHfNpYbdbirml9oD6zg2EDuUPvdl73j6IY7CB
         g56A36RK8QPhGVWIZHRwZ5FHjYcLKj5y3fhIzZoWTvGEJcTcpvqyH4ZvhJztXC6ZpAag
         l3DLb43ylaaW+j1z1I/gmu4N2FH5zvkAi8MrNsWPEue6OTHvjl/BL0ZN36mQthyuqIBl
         E9tQ==
X-Gm-Message-State: AOJu0YyVvHlUK7MJNUUivK82JC4cMQyAO4KWSEQmJ6zZJyj7vZ1Tb+dm
	GMtU4z51PUctTWThAb1UMU1nGi8HO20v5WLBJRQ5AT4MwHYY
X-Google-Smtp-Source: AGHT+IEgfnCVZj94JzjLQStkiX9wHgHG/mXwwNgAsvE/FBRnThvT8RXXTntDQSJSN4Ws1kpDvtn6/ettoo/JiS+3/ZY=
X-Received: by 2002:a05:6122:584:b0:4b6:dd06:f707 with SMTP id
 i4-20020a056122058400b004b6dd06f707mr6623145vko.17.1704289599275; Wed, 03 Jan
 2024 05:46:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103090241.164817-1-pierre.gondois@arm.com>
 <CANpmjNPsBUJy6tkOdRSJyWrS9CMUOQhQyb7_hwmw68pjjiEDWQ@mail.gmail.com> <2f4a5ea1-daa2-4ede-bdc0-6692d7d52e8c@arm.com>
In-Reply-To: <2f4a5ea1-daa2-4ede-bdc0-6692d7d52e8c@arm.com>
From: Marco Elver <elver@google.com>
Date: Wed, 3 Jan 2024 14:46:00 +0100
Message-ID: <CANpmjNMqzYsSh-DSsdFz4D_Ad0sAgf9J1A6CBz4fEOXAS4ejjw@mail.gmail.com>
Subject: Re: [PATCH] list: Add hlist_count_nodes()
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Lucas De Marchi <lucas.demarchi@intel.com>, Jani Nikula <jani.nikula@intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 13:04, Pierre Gondois <pierre.gondois@arm.com> wrote:
>
> Hello Marco,
>
> On 1/3/24 12:25, Marco Elver wrote:
> > On Wed, 3 Jan 2024 at 10:02, Pierre Gondois <pierre.gondois@arm.com> wrote:
> >>
> >> Add a function to count nodes in a hlist. hlist_count_nodes()
> >> is similar to list_count_nodes().
> >>
> >> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> >
> > Is this patch part of another patch series? As-is, this will be dead
> > code, and there's no guarantee someone will just go and delete it in
> > future. Although this function looks useful, we also should avoid
> > adding new dead code.
>
> The function is indeed not used in the project right now. I needed
> it for a private module. If it helps integrating the function and
> not make it dead code, maybe I could add usages at the following
> places:
> - drivers/gpu/drm/drm_hashtab.c::print_binder_node_nilocked()
> - drivers/md/bcache/sysfs.c::bch_cache_max_chain()

If this function allows to simplify these other places, by all means
go ahead. That would look a lot better than having an unused function.

Thanks,
-- Marco

