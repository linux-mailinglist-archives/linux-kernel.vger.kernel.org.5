Return-Path: <linux-kernel+bounces-82141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20751867FD9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39DC1F24F15
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8011E89C;
	Mon, 26 Feb 2024 18:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAC8X9fu"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C281DFEB
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708972244; cv=none; b=unwcpCFlc6F2e2PtXX240cOkFXPqbVVHNR1+u7V5smimP7Vq4NFH/eyu68sV3Jh+BFeETmWiX2oBPFdOHDinuGULmQhD81ownfV6vc0otE1aNnANA4WxlttJrnTsJRwZwRSFNhmjq5I9eY9iUuXOdmdEbdIV8NUMsfxSBVk7BEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708972244; c=relaxed/simple;
	bh=u5r4EPEW131LKOuFz/KhnwfCBq8Qj8aidBxXeeL0Gg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rU9ZYGMtTqV1OJ2+2Oqvy61+r6Y0UWhMAV39LX4MkDRpNHEDUsU0Svc2gAZImILb1DhW2bOzTwdObng7zTbGjtWwV90KS0YcvPjlMEin6WKauNUVtGMaPcc7wsROYM/1IhYcrba9oeD2oTBg0aVcZJKMtm82J2J0xDyx4L8M0iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAC8X9fu; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso2626182a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708972243; x=1709577043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNCd9BS64LLS1pvORnzV4NsUWWCwYzGNA42LF7Bpzwk=;
        b=IAC8X9fu7MN4P/IOgx2BUfhZeRgGxa29sHnwYoSZy3lT9wPHHeYe61x5OzacshKKuo
         gWUosTBJFl69N78b2rjp3bYjJp78uldWm7W79oNVmcHHt6lRKaJ3O9NCk7CxDlfpu40w
         d9ZaJma3VS55//1Kvc3aJwzzG6QDKeKsKdkH3DsSvwYmCJt3m3mI5BPhKUEBkHFDFXRI
         wBYR3leFwYn+G0d3DO3Zwc0VNkljQZc6Ny7cWgt5hizfPZlVo7KS1HdM0g1CJy4T1vO0
         O8Ky18JpgxkFJL+a/pu3rmmJ310F+S9rCvLZh2KW4ebuU35TCc6qpF40H2dPvt0Ex6K/
         +Ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708972243; x=1709577043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aNCd9BS64LLS1pvORnzV4NsUWWCwYzGNA42LF7Bpzwk=;
        b=qngifjmacmdNkQbWkuDqirKfs6Hou+bGhf4RNQxB5Fc30vCMkS8qaxBzncy1j75IJZ
         3y5gF3xNHhH0DThNUuJUgSEaxdAZT75xIvAWRGzdhXotZaTCy3kpXt5C2vteSUsiSXz7
         khEP5Mpsa8F4+v0frCQT9Iy9F2pSXEW7ZEGixeSpqinj0hewG7PwLIea1i+DI+Lw5wYn
         XcLKprmiVUvMST5cXy2iheHXh8cXWXsfN6NPf6uAM62/wU7WO4qK7wXxYj2as/5l+d1U
         NILE+zURJhyTMrCrytz6CtMleLlzBcV4A5/hDYFv63g/8g8/LBXleNPO1GG7Mbsv9QQH
         DF8g==
X-Forwarded-Encrypted: i=1; AJvYcCX53WDKRAd0Nk3LwgafrrJT1GYF6IjFDQcJzzhSPrdNN5IE/HDM4M1jbJ9STZSnJ4xNipu6oXQRanUUjd4tY9PSOD8o/ANpTjw39aB8
X-Gm-Message-State: AOJu0YxjgvwiaSEkAPuvwryOioRakD8xFkYZlNlYMR6SBOlNqrjViOAS
	+oJdPDXJhvyDJu7LcoUjbrFrqKJAzNljT4amyHRRR8DvoBMwajVCXMzj7m1SRQI=
X-Google-Smtp-Source: AGHT+IHmfg1/GIJHKXB5yx+njFh9tG68LtsjmKu0ugP69TJTu1VaTogqciMYkI5iiyByibGt10ITow==
X-Received: by 2002:a17:903:11cd:b0:1db:f7f6:a73a with SMTP id q13-20020a17090311cd00b001dbf7f6a73amr9581145plh.25.1708972242680;
        Mon, 26 Feb 2024 10:30:42 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:31e4])
        by smtp.gmail.com with ESMTPSA id w19-20020a1709029a9300b001db608b54a9sm9090plp.23.2024.02.26.10.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 10:30:42 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 26 Feb 2024 08:30:40 -1000
From: Tejun Heo <tj@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: jiangshanlai@gmail.com, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, allen.lkml@gmail.com,
	kernel-team@meta.com
Subject: Re: [PATCH 12/17] workqueue: Implement disable/enable for (delayed)
 work items
Message-ID: <ZdzY0OZIsRqmi41A@slm.duckdns.org>
References: <20240216180559.208276-1-tj@kernel.org>
 <20240216180559.208276-13-tj@kernel.org>
 <ZdwIoyRllkjnSTAH@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdwIoyRllkjnSTAH@boqun-archlinux>

Hello,

On Sun, Feb 25, 2024 at 07:42:27PM -0800, Boqun Feng wrote:
> > +bool enable_work(struct work_struct *work)
> > +{
> > +	struct work_offq_data offqd;
> > +	unsigned long irq_flags;
> > +
> > +	work_grab_pending(work, 0, &irq_flags);
> > +
> > +	work_offqd_unpack(&offqd, *work_data_bits(work));
> > +	work_offqd_enable(&offqd);
> > +	set_work_pool_and_clear_pending(work, offqd.pool_id,
> > +					work_offqd_pack_flags(&offqd));
> > +	local_irq_enable();
> 
> Maybe
> 	local_irq_restore(irq_flags);
> 
> ?
> 
> Because in a later patch, you make this funciton callable in any
> context, so it may be called with irq disabled.

Yeah, Lai already pointed that out. Will send out an updated patchset later.

Thanks.

-- 
tejun

