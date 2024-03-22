Return-Path: <linux-kernel+bounces-112048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2E6887494
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B73301F223DD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 21:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8FD81750;
	Fri, 22 Mar 2024 21:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PA8n1xsC"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCF160B91
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 21:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711144102; cv=none; b=Hff6p0OMZ/4s4T+liIWcRC3d6wEEj8fDzpFutHD+TtCG+OLDV6uQl9kfl4zxhDB1FJJJqECO8sM1zv79HBqoxWt7k2MYjcgYsrE6SOa7rraCkAcTpHfMD302XHL6VGXU7bcfd4U+f05iBsDn+deMwsGT9BEkymNzXxPUhaUyzUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711144102; c=relaxed/simple;
	bh=l3OY0t5HrjFFYgbxfL2wYmHwCTOY3qj2409bRuGg/PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTAJdx+o+qK16RNox0dVcznHqzU7wa0OtM9lmbQJoKn1VS/gd722RXf+sA+35BTAhD+85UeOYtwGDfU+xXkPOxfBgsq/G1sY4sfDkfqZzw8BNfxxLoWNYyMDsE8bf/j+Aakwu2p9s5TMmapA/aNpet/yu1npIqau9f77TNogbvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PA8n1xsC; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-221ce6cac3aso1360653fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 14:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711144100; x=1711748900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=On9llTVYskkD2vg9HqNwrK4CiExajRFrB31BlGuPc2w=;
        b=PA8n1xsC8G0tjTKzA7EOkDUbWTJ2WnzBYP3zDN5SWE6p4/AoJDt5TUapL1OriDiMgX
         UW8UU2JWn87Mx5syO+xqID/BcgXg5DKeAZV6TjksPvxceDSzu+ZU/H5fVxqK9O40KjyZ
         H+Sj0qqAruDMxipfbtOY7sKvM8Iz3dK8IAGELQ3A2AG347aJegvGJ1syL7W+JZoQsZ8k
         DrEN/pAW6u3TzE7L5xAdY03/KZkH57vvMO+I4ZdJLbhzs4fP7Whp7k35JKNhK1iIrCyg
         U/Fys3UPt9X8Yxgfoij2X/GamzFzpqdmChWRg+NB5iA+hnAa7/VmdXX0Sy6Fgq+ZRChm
         TUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711144100; x=1711748900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=On9llTVYskkD2vg9HqNwrK4CiExajRFrB31BlGuPc2w=;
        b=R7E65rQZ9tgOwgfcvpyrbwPsYzDe+gxHhtpmUaz5/Xlmk73LPeti6ckj5iALBb2m66
         rteiN9NE27ZtOuoFvLCrvQp65ejzQkHNgTMC+xBt9pE/gnC84jN33Z5fjd1KnFAboX3p
         tqp7lUvMUHoTWaHs4KqyUgdCCKrW4mygtgmB7Ivp1iyWk14OGJVCFuF1sDdurW4AGRui
         b+P2BuVF2VQfIl6VKw9HlYy2EQFeTtR5rHLhzanELDY6O/bImLhJ3CLFDr3FVv6bU/e1
         w4GYr1GizghZhTgSH/M8oNJf9DekXXuCskZhYIe1GY6Hw1/EMVooCDBSvnzmc3VGqqfs
         a1dQ==
X-Gm-Message-State: AOJu0YxVm3l5WCyYQzXIKrKlNzAc9pnCJChUbCO4XZ0x3q+KRljwGLMH
	2vc/dqgfIGjuxEJxLNC4H1AT4SMzGEhbjtZJPNF65DKi2O77j1rnRxbehwFW
X-Google-Smtp-Source: AGHT+IEmft39BYboziHPWalrb+Y10VsY/AedtggVadeU+vIflwxrTk5G0hW+MF+yXUcGj46f+dJx/w==
X-Received: by 2002:a05:6358:2618:b0:17f:1d34:6253 with SMTP id l24-20020a056358261800b0017f1d346253mr802842rwc.15.1711143706147;
        Fri, 22 Mar 2024 14:41:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r16-20020a63d910000000b005dc5129ba9dsm2050333pgg.72.2024.03.22.14.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 14:41:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 22 Mar 2024 14:41:44 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 4/4] x86/mpparse: Register APIC address only once
Message-ID: <349fbc82-162f-4905-bbd0-4101e1e7a6a2@roeck-us.net>
References: <20240322184944.141421692@linutronix.de>
 <20240322185305.297774848@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322185305.297774848@linutronix.de>

On Fri, Mar 22, 2024 at 07:56:39PM +0100, Thomas Gleixner wrote:
> The APIC address is registered twice. First during the early detection and
> afterwards when actually scanning the table for APIC IDs. The APIC and
> topology core warn about the second attempt.
> 
> Restrict it to the early detection call.
> 
> Fixes: 81287ad65da5 ("x86/apic: Sanitize APIC address setup")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

