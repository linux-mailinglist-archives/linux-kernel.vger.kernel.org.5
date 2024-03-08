Return-Path: <linux-kernel+bounces-96552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08741875DF3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0373B1C20D55
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 06:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A1D36134;
	Fri,  8 Mar 2024 06:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYVoaxUm"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89EC1E4A4
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 06:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709879167; cv=none; b=tvQyqPXSePOynGo6HUJz2FouggCchnrOSO8l/horbtvKjJYLz2dogFJ6KbqVJgPV+NBLzIs260a0nkQr3UBVF5aYYFRMTEIZAkROAYn+pBA5+svfCWihU4AcAd6cekRCQCwffHDilT5libaR8N6jmYsZ+TGl1fEEJbUGtpd+TKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709879167; c=relaxed/simple;
	bh=CpN8REV9h/e4ud3t/fc9HvFQvksga7ZrtfAy1T9iNNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tU2QivMPdRy2rrS7Z7DjP09RWeAMmRVpZds3R2+OgYi6hhqsQmHeyWZWSw5jeraYIKlzLpukjQnrExWjdJerVum5f2r69rBD6fCWFIkOIyPjoYRPiJM5Xah4led2WzJBqUc9rwKnWo2IqpqqE8GWspXLTOMYumHveZUE/LQwVd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYVoaxUm; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56657bcd555so2017268a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 22:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709879164; x=1710483964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6+5fkC9vjuQxxxVJPri3s0yny1sOq3HWfO3ZYVT/bhw=;
        b=nYVoaxUmjg5iBv6NGvkc8X9ei/7d6aDfjg1OeBg3M0vMFfLANV5vEqYuDE0LjAPaU6
         nDHW4/C+VIMEQOS7VYN/kNy4/dkQfddKcGxSC+oxxQJiCbYkyijYngcIK8oKhF1mNE+8
         +XqKXeuEX6l7IpZG7qnybbTRcO8VUAwZy6WEydbPkWHP2swfgTouS2rO+KQTg1ltj5UY
         MFt/nFtpq7gqCvkoF5co7pbpuaFndzhSEcYw+YFulm2F6PrOxOB3U1Ofc4uF+nA0LpIb
         MF8wczHrMvi2tcdtBpRPeDL2ucRPg0ukYLNnOhGC5RymWeD6mmp2qnYIb7F1hqxbvbqk
         Yhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709879164; x=1710483964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+5fkC9vjuQxxxVJPri3s0yny1sOq3HWfO3ZYVT/bhw=;
        b=hjFFWm3OIMlzLFFrQxiYSpyfAv6QHWCZ7SgRq+6R5LQeg3X8wpFJZuYY9NF8BI8+OT
         EuESyLMLmdqczmGo4Rh7B7tU8yXJUk9GH/39aMbcR5kyvYcrZHTZCFlaTSt4NmWfhBAh
         2cjkll89EPOsJmi/rO10GC9eDyT1smzRHvHelM0oMMrwTOp3CRjXZ3R0fxlsdEYkBuMV
         G+Q3BGAt1vpGBvoJ8emJBWyuNQHn2ZVhZ/rVwaa5RU2eYGIG2s/DYayi2UBLk9i6Zdip
         Sr0RopD8lkBRTNPSlDm5Sl16xV9VAIRf0lED/NvVQdyqygWSUmtt9KBbtgASgYHvdyzU
         qh6w==
X-Forwarded-Encrypted: i=1; AJvYcCVanbMp09L8n+ohbSM1Sa/gwVFCTxIToCh1O1LVGzBsEyuPuSt+7ros+vU8C7m53sq2+jYyD6fTyZJn3OyNcfwka9ppytPBx5TZ/4x6
X-Gm-Message-State: AOJu0Yx+vJvo6sjsXX89NrP4pquLIs1ebuN9O+1zGOZGw5/NvWzYeG+5
	Bf+Xi7MdDW7p3hhJc1zrpIF7z+Tdvz33Z7GkCdJIt0U3IJyVC+EGyZ31MX0=
X-Google-Smtp-Source: AGHT+IHg0OugSfAr0wIJ1ljIfS4ce/sOFb932HW7I0OBdyF/ppSEcY+viC9FnPwdwsPPMDEOMTMaUg==
X-Received: by 2002:a50:d554:0:b0:568:1bd8:a617 with SMTP id f20-20020a50d554000000b005681bd8a617mr957846edj.30.1709879164044;
        Thu, 07 Mar 2024 22:26:04 -0800 (PST)
Received: from p183 ([46.53.254.187])
        by smtp.gmail.com with ESMTPSA id d8-20020a05640208c800b005682f8b62a6sm134785edz.97.2024.03.07.22.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 22:26:03 -0800 (PST)
Date: Fri, 8 Mar 2024 09:26:01 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysfs: make sysfs_emit() return ssize_t
Message-ID: <f57ab790-d0a5-4454-977b-9bdc146e6e93@p183>
References: <33cd8f96-4b4f-4741-ac05-ef1bd267ce6b@p183>
 <2024030713-favorably-liking-2135@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024030713-favorably-liking-2135@gregkh>

On Thu, Mar 07, 2024 at 10:04:41PM +0000, Greg Kroah-Hartman wrote:
> On Mon, Feb 05, 2024 at 01:11:36PM +0300, Alexey Dobriyan wrote:
> > sysfs_emit() is most often found in functions returning ssize_t
> > not int:
> > 
> > 	static ssize_t oops_count_show(...)
> > 	{
> > 		return sysfs_emit(page, ...);
> > 	}
> > 
> > This pattern results in sign-extension instruction between
> > sysfs_emit() return value (int) and caller return value (which is
> > ssize_t).
> 
> Is that a problem?

Small problem, but, yes.

If sysfs_emit() returns "int", then every user compiles to

	call	sysfs_emit
	movsx	rax, eax
	ret

Given than sysfs_emit() is the official way to print in sysfs,
there are lots of users and there will be more users in the future
as it grows.

This trailing "movsx" instruction is duplicated every time.

If sysfs_emit() returns ssize_t then it is folded into sysfs_emit() and
appears in the code _once_ saving bytes.

Ultimately, all this confusion and mismatches come from snprintf()
accepting "size_t" but returning "int" (despite working on very large
strings!) which sysfs_emit() copied.

> > But it is better to do sign-extension once inside sysfs_emit()
> > then duplicate it at nearly every call site on 64-bit.
> 
> Why is that better?  Does this affect code generation?  If so, how much?
> And to what affect?
> 
> And the function itself really is dealing with an int, it's up to the
> caller to want to do something with that, not the sysfs_emit() call
> itself.

