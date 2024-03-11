Return-Path: <linux-kernel+bounces-98464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381BD877A7B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69B4D1C21442
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 04:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2287ABE6E;
	Mon, 11 Mar 2024 04:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpDMT+oP"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8532B65E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 04:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710132928; cv=none; b=u5iTBm6BKAiiwuxoe+8kkPhp/DopD6j8WSJ1psNTVI7o0sN+CETseWBKe9CveJc977Yp6LYyrDvNS0mwhO7eaBqW1xrD7vGmaW1xrTcxPyLY4FMsbY+ctinikhkW7HDDPYGQ8JrcsipzsDsdkIanpsm13lShJYRQtwpwuYqFDhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710132928; c=relaxed/simple;
	bh=phs7ycMt/QXEiwL13Bzwh04wWagSuXAL3u1VNBqF+5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaXXGGJk41F68RhYvfJAvIpp4b2WTwh+7bB9d25n0JJHsCttpePRSU6HfS1piIjqFc3u9J/IbVLBR9sQkuJJU3lFD5Db/wvld7aCEzv1TdFsBG0+oYi2CNyCaduWXgXoV7DtiSaOcrhqIl+Ry94Jm/zpW7sbopsFC3T7IdA4J+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpDMT+oP; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a45f257b81fso284199966b.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 21:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710132925; x=1710737725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OVGjr1FxTJpLhbWsl4uaBE6QAGGoaqej66C7u8wvp9s=;
        b=cpDMT+oP3WQe/JKbitcegtfg2XtOMD/3JcVfyXPVIqKqqVpHEhzLCI1XRpWLh9IfOa
         w0XN4Kvk6ZM2EkSshz/BpXdhle+K0+E9+Wu3D2GICnqbWJJfE6tt7JWhiKQPxbVu1tLa
         wgxFBkVVzAuMe6Ck5/16BPmfyTs7tUIm9z3s+Cxq83OyC5nXSeAL73vYnb3cDt8XRKkS
         ziW/H0IuR7myIl4Sy1Y6Dk17miaJn+p1zAMNnfxe1unzrTs9DPOw+2ad53lIa/Lhwem+
         /q1rJtE/uXQLynPFKk3iurHg0IFTe0ZfsTH+XrRisH/ESEWRgpicLcOOJ/UtaYskK+29
         rLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710132925; x=1710737725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVGjr1FxTJpLhbWsl4uaBE6QAGGoaqej66C7u8wvp9s=;
        b=SAeY7oi/3rM+Y450JgnPOSjDVILeTM2RFf0+M/85s12730xwWqVuRyKviKnIiDydUl
         kz6oGFcmb1FEwgsJgmBs2bzmQpbg3ydefFsO7PKwpWy6AM59m2Sz0elkgXqra75lAXeX
         j+Iz5qkvLq+dLkAOs7UY7l/Or1r4Bbv1rufq90Loyx3c/xPAQE6ABqNW4Yrfk5jA40wA
         WG3BG+r7EkjlVIHvSDPmPHEWnj/W6C3YOB2jMLTVHjlXfh6NJbLpPCISJVPVIxx92Ha6
         OOneZDw+8XpAsGf3HSGxPbqHMhVjm3vN7qqKKiZ67YNMkoZ5468bNd/0JxgGYtZ+2SAJ
         Jrug==
X-Forwarded-Encrypted: i=1; AJvYcCUR93oU2e5PA3NQpJ+WLwraUfC3O8p7gkmS2qGFekn1xtX+Q6xN1Ni7HMespFiKJvxYaXridwEfPo5RCmTsSILq0UYzVT5oWYNYdGiX
X-Gm-Message-State: AOJu0YwBQBxN+6CwaM9Ws2Ki0Hybk3tZuWdITB8M5pN/vvZPzvOor1R8
	UgjriMOYOla7DX6atACJF51YLQVVaU70bDPeDF0mo0/03KIUySE=
X-Google-Smtp-Source: AGHT+IHkq6+52kfyOSZ2ItLdxdBd/sFKoTMSBRfqJ7R8o1/Lv8tFx/7gZZgxPWP4J54Hiom+BxHVwA==
X-Received: by 2002:a17:906:c56:b0:a44:bf5a:2175 with SMTP id t22-20020a1709060c5600b00a44bf5a2175mr2923753ejf.71.1710132924755;
        Sun, 10 Mar 2024 21:55:24 -0700 (PDT)
Received: from p183 ([46.53.250.75])
        by smtp.gmail.com with ESMTPSA id ce18-20020a170906b25200b00a44f3fb4f07sm2492496ejb.191.2024.03.10.21.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 21:55:24 -0700 (PDT)
Date: Mon, 11 Mar 2024 07:55:22 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: David Laight <David.Laight@aculab.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sysfs: make sysfs_emit() return ssize_t
Message-ID: <394036c0-a716-4818-a35b-7da7043e3e20@p183>
References: <33cd8f96-4b4f-4741-ac05-ef1bd267ce6b@p183>
 <2024030713-favorably-liking-2135@gregkh>
 <f57ab790-d0a5-4454-977b-9bdc146e6e93@p183>
 <333d84d215c44589840e18cec9108fb0@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <333d84d215c44589840e18cec9108fb0@AcuMS.aculab.com>

On Sun, Mar 10, 2024 at 07:21:32PM +0000, David Laight wrote:
> From: Alexey Dobriyan
> > Sent: 08 March 2024 06:26
> > 
> > On Thu, Mar 07, 2024 at 10:04:41PM +0000, Greg Kroah-Hartman wrote:
> > > On Mon, Feb 05, 2024 at 01:11:36PM +0300, Alexey Dobriyan wrote:
> > > > sysfs_emit() is most often found in functions returning ssize_t
> > > > not int:
> > > >
> > > > 	static ssize_t oops_count_show(...)
> > > > 	{
> > > > 		return sysfs_emit(page, ...);
> > > > 	}
> > > >
> > > > This pattern results in sign-extension instruction between
> > > > sysfs_emit() return value (int) and caller return value (which is
> > > > ssize_t).
> > >
> > > Is that a problem?
> > 
> > Small problem, but, yes.
> > 
> > If sysfs_emit() returns "int", then every user compiles to
> > 
> > 	call	sysfs_emit
> > 	movsx	rax, eax
> > 	ret
> > 
> > Given than sysfs_emit() is the official way to print in sysfs,
> > there are lots of users and there will be more users in the future
> > as it grows.
> > 
> > This trailing "movsx" instruction is duplicated every time.
> 
> Actually you are missing a tail call...
> But no one will notice the extra execution time, it will
> be masked by the cost of the formatting.
> So it is a small amount of I-cache.
> 
> In reality the best fix is not to use ssize_t for something
> where the domain of the value is much smaller.
> In this case it is probably unsigned as well.

It is much harder to switch read hooks from returning ssize_t to int.
Kernel snprintf() too.

sysfs_emit() change will be mostly seamless, but function pointers
generate warnings.

