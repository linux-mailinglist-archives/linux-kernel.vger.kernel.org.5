Return-Path: <linux-kernel+bounces-9532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A63D81C722
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D94B928577C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EB4D512;
	Fri, 22 Dec 2023 09:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pklz+b3P"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAF3CA75
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 09:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-58dd3528497so988154eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 01:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703236088; x=1703840888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mE2SYif30LFmdgvsbzVDf8f7IwGtZ+Q/lz3hbEDUymU=;
        b=Pklz+b3PzWcKaumhbx+NU3eQGh+VlIELmd/el4enBnW9WUbI1TkDXzQkoPpeatycgz
         BdCk7IjUYZDf2UTHs3IlE7ES6xoMafiLGLZ4LaIqQWKF9PiCBnpJIbRek66kJ9hPDSJv
         PD+kbvwOHYw/I5zZ4gFnG+cgVgmNEJ6GLXytc9/lAA3rKTCdhHP7IL/sgpgml3v77E9z
         agJ5DzElyztPikKSZvdnKifYzQ3OKPpQv4gJSOA/QvXfrGcNtTHaGYEklNzCjIUEoShc
         OmI1gNSatesrXC+oTPAqEhJUrNjoWi+WvPct8J8l7j/9cQWeaDTNbQDxQIsC8uNTsztr
         Owow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703236088; x=1703840888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mE2SYif30LFmdgvsbzVDf8f7IwGtZ+Q/lz3hbEDUymU=;
        b=USHrs9AjfDG4OvEZM377yHp85JmMBH/hwDYrJBdAra6p5q5NLIdIztybmIvg8+HapG
         jsxmMPoCehwnMnQEKJSAXvBjvMCeTglU0CIHHy8tkJc7Klwc89nIKpLU2saRdzweoRJK
         bq5FbgoCwL+RvYxNIpZn1SeXVFoNmqNAnJKuxiZP5nIC8sLf33HnSZyYPQA6yvuuVhqE
         MqjLjHUVPWqBsheRzX/W3jZBG9e4QhaLAQXEq5JhAuXlGxCKwCZAjw12O70vPJRItjFl
         gDszmMg+cRCnUlazUcprKRy0kp7qcJ9KEV9t5kAXUUQnjkS9Bc3VkpzWDpMutmHY+QEB
         s6YA==
X-Gm-Message-State: AOJu0YzJmC4SBNM1zOMq9Fc+cw2RNMqSMZOdFY0NzQiRR7I14E1/8lG+
	n0hgoQU10oB0tfeOPokHJpo=
X-Google-Smtp-Source: AGHT+IGW0REEN8f67zIsPgWgwgY9ggavrnkudIJ9BK5qFBdV8VF7g7brzh8BNaM6hThjZ7+vIL4k8g==
X-Received: by 2002:a05:6359:411b:b0:173:8da:a19a with SMTP id kh27-20020a056359411b00b0017308daa19amr1205754rwc.9.1703236088419;
        Fri, 22 Dec 2023 01:08:08 -0800 (PST)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id ks3-20020a056a004b8300b006ce7bd009c0sm3022585pfb.149.2023.12.22.01.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 01:08:07 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 22 Dec 2023 18:08:05 +0900
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com,
	kernel-team@meta.com
Subject: Re: [PATCHSET wq/for-6.8] workqueue: Implement system-wide
 max_active for unbound workqueues
Message-ID: <ZYVR9U47MkpecqQu@mac>
References: <20231220072529.1036099-1-tj@kernel.org>
 <CAJhGHyACBBW5wnYTTz7S+AgLMhLYOsfxTnN6VHodCgECqEFeEg@mail.gmail.com>
 <ZYTDz10ohj0kokum@mtj.duckdns.org>
 <CAJhGHyDyWBCSH_41cU7TokbDTE=vknLjLKYMQUtN8LyUsvg9dw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyDyWBCSH_41cU7TokbDTE=vknLjLKYMQUtN8LyUsvg9dw@mail.gmail.com>

Hello,

On Fri, Dec 22, 2023 at 04:04:27PM +0800, Lai Jiangshan wrote:
> The current "max_active enforcement domain" is just a historical accident.

I mean, the part that it's bound to NUMA is accidental but the fact that we
need an enforcement domain which is closer to the whole machine isn't. Most
users don't depend on max_active limit but there are a number of users that
do and what they usually want to express is "I want to be able to saturate
the whole machine but avoid creating pointless over-saturation", which
usually comes down to some multiples of the number of CPUs.

Note that there may be a single issuer or multiple issuers and we want to be
able to saturate the machine while avoding over-saturation in both cases. If
we segment max_limit enforcement to smaller units like CPUs or L3 caches,
there's no good way to express these constraints. A number which is too
smaller for single issuer case is already too big for multiple issuer case.

I tried to explain the conundrum in the cover letter but if that's not
sufficient, we can keep discussing. It'd be also useful to read what Naohiro
reported as that shows the problem pretty well.

> IMO, it is better to change the semantics of max_active and the related
> alloc_workqueue() callers rather than add a large bulk of complicated
> code. Most of alloc_workqueue() are called with max_active=0, so it is
> feasible.

Yeah, I mean, if we can, that'd be simpler. I don't think we can. It's a
rather fundamental problem. If you have concrete suggestions, please feel
free to share.

Thanks.

-- 
tejun

