Return-Path: <linux-kernel+bounces-36620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CBF83A3D2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891AD1F2CBFF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D0E1754B;
	Wed, 24 Jan 2024 08:13:17 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C62C17543;
	Wed, 24 Jan 2024 08:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706083996; cv=none; b=QnRcR2ux0HbqH0yT01fgmg7LU9gfInqWxHG2EeY2vJws6xx3zSSUY+xyFdOGGaljKUkNn+XPDUjAh6g6OYSsAXvNAjvFqdPbmYlEEF+LCyHt7Y4wiKT3GOcW5J6rLkdglSEnIK3md+sd8obpbwMlEtz5/oWDeL3IyoebvR6HgAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706083996; c=relaxed/simple;
	bh=RfjYW6e1IYhvrEGXxzFytIMTdGZXx5WayXRK/3yFuoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwEeVHh+Vny80+5YOneNIh0veah0yZOFaCzzA+z8QMeQ0qDHgvAUqK5zylOnIW0B6nbhvBMsLYOrAjZEheUN1LGs7nhTI6utKy/fMSngg6X3IvYErrDQUiLbXMUKwqwcfU3vTX2AaBGjqtrxfbRnzMauM/FApJ3qA8F1H+DdYog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6daa89a6452so3558593b3a.2;
        Wed, 24 Jan 2024 00:13:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706083995; x=1706688795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9qF18RzvDXzodIwOLOD1mj5uV5sasqvoSwmEt0eiQ8=;
        b=F2DOFkUIl2kTknTwBfUrELoWoyNVNjWC4hxw+9nSrOC5jJ6HN3lNzY6o3q5MDS9r1m
         GP5n9NOYd+VSmGLHEbrqjwPuRu51ZyCbQWsRNB3TuZpd93zlStnRJ+Be3AFQNj/86kz9
         bnxJyuF2FJ6dVfdBXvWIjcrjzTQ4DiZkF0iZE/uzpj2181AYukrq4HFcf0K1jS3A1UwV
         FVzvgOb03clKpNWA9NHA8by078p1n7hkQtmAPG/C9mTMfKTPDizUm1hwpqEDls7x2x7R
         vmitZ6kdtxKlMIK5Y+tkyKofJFyTHmMrvEOgykxO0ju98vJDlaP9ov1Ocio9VlDCU4Hw
         M+JA==
X-Gm-Message-State: AOJu0YzUsInSqwk0XFr7pFgKe1vMSLPlVAUxryrGahqSzHOWMSoHgVZe
	ZEMqEkk9BlWUVOkDeiO1nhBjksgUo7drD12pa9vMBFzYV4TJNgFK
X-Google-Smtp-Source: AGHT+IHbq4iG8bKu4Eji3JiKtMcP1j98BSAv4jldXfilN+5jE/9EtPklfe0VP/SbKdgtCHsW+VeWEw==
X-Received: by 2002:a05:6a00:2443:b0:6db:afd4:f54c with SMTP id d3-20020a056a00244300b006dbafd4f54cmr4792529pfj.0.1706083994816;
        Wed, 24 Jan 2024 00:13:14 -0800 (PST)
Received: from snowbird ([136.25.84.107])
        by smtp.gmail.com with ESMTPSA id e14-20020a056a001a8e00b006dd8985e7c6sm974076pfv.1.2024.01.24.00.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 00:13:14 -0800 (PST)
Date: Wed, 24 Jan 2024 00:13:11 -0800
From: Dennis Zhou <dennis@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	George Guo <dongtai.guo@linux.dev>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	George Guo <guodongtai@kylinos.cn>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] percpu: improve percpu_alloc_percpu_fail event trace
Message-ID: <ZbDGlyHYetscNcut@snowbird>
References: <20240122073629.2594271-1-dongtai.guo@linux.dev>
 <20240122105700.05e5ee46@gandalf.local.home>
 <20240123094443.00007b20@linux.dev>
 <20240122205539.705f5701@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122205539.705f5701@gandalf.local.home>

Hello,

On Mon, Jan 22, 2024 at 08:55:39PM -0500, Steven Rostedt wrote:
> On Tue, 23 Jan 2024 09:44:43 +0800
> George Guo <dongtai.guo@linux.dev> wrote:
> 
> > There are two reasons of percpu_alloc failed without warnings: 
> > 
> > 1. do_warn is false
> > 2. do_warn is true and warn_limit is reached the limit.
> 
> Yes I know the reasons.
> 
> > 
> > Showing do_warn and warn_limit makes things simple, maybe dont need
> > kprobe again.
> 
> It's up to the maintainers of that code to decide if it's worth it or not,
> but honestly, my opinion it is not.
> 

I agree, I don't think this is a worthwhile change. If we do change
this, I'd like it to be more actionable in some way and as a result
something we can fix or tune accordingly.

George is this a common problem you're seeing?

> The trace event in question is to trace that percpu_alloc failed and why.
> It's not there to determine why it did not produce a printk message.
> 
> -- Steve

Thanks,
Dennis

