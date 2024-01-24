Return-Path: <linux-kernel+bounces-36501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C1183A1CB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E215D1C232CA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB74F514;
	Wed, 24 Jan 2024 06:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHsXgqhD"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC63C8D2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 06:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706076510; cv=none; b=d+yocI0AeQvGKfhmXWiFyXky+3jMoGhqP82peeFESZIPSykRzo575NWQ3YUQciLucsALUECwTdG1eC6KShvJRpuXF8rlgjahlS9Of/WwtZBHvQvC5I7KkB9Ze5Uy3VKoaN19oYN/n7TzvW3C+VMcdLUBkJX7PkA+0WCICbgQrM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706076510; c=relaxed/simple;
	bh=TGlAgmwHRl/iW+d3270Mbocu0m1PP/EM0jtUyXaUn3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRPubs5izubPLVqe1ixBQt84hc7MMgwt0paGs2q8ZvtYZxaUPcoAyQakQ1bu04m6hfjPEpqs8xXiGfPRpuatXO//O4u4rNjG4edICBxpoQE/Rydx1QntyCZjJ8x4CFPGhMfZDOAhN3K9pptshoMmo3QxPrQ1su+vJf4P6eJAeVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHsXgqhD; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bbbc6bcc78so4127210b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 22:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706076508; x=1706681308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XFGIMxX3KH4mPnJxpq+0pjEUKuZocKr5n4+8ml1MYB4=;
        b=KHsXgqhDzeUdzUBzfGuCqYBVtK/yHPbVdwBwUTIOduw0SCZPeRLOovGVHBpHXFDfVD
         b1Zthp73YX+Zh255L3LZh5JU4hI7Cx64EQvfeS6JeKi4iHqSMyKf3u+HKOQKJtKPpXs1
         tBlOQNfs7S4UVsdtV3SzDwli4Iu8RZYPTHHNMY+qlxhIn/zurjmHsZNp6y2sxK0gd4UX
         Zkv66QCooaZLaIJnXFoNHuqFMm5L5sFkKwgW/qaA6Q6k0DMPYT5hlin3uve91Qhscgng
         pjmzw8tCqd7f4gkGdpsxyeohSgDJCEu16lFQBHXpgWzVI2LU5wsMzN2lytGxcgGYd0za
         ZBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706076508; x=1706681308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFGIMxX3KH4mPnJxpq+0pjEUKuZocKr5n4+8ml1MYB4=;
        b=MjuRV/hy9hblfk3S2rFVl/i/u27lw39QXMKXEOOnjI3mGHfthlrlOjaBoT5QRwDSsl
         0M1i//G0c6XZfU0LVMgwiu0O1sEj9xwOIS4mao6SVxwlqFBRdP+tPgc1WK+M8zNyK+Ev
         EBpMsgw1q7qjtE1tQaSEbcnxW6tLECc+KlLrFzuA1AjPVJuaI9S/S1qO020Tixd9V6CM
         fAGBJmse+5HkPSgBt5rg1rCoXB/OzjnwMZkkGK59T0nddZtmY8jEeAFxWERxMJyax5Y5
         HEybgC8EpQNxQBiL+TqcPepwxxu9lAc6Z928ft6lwTibVtehIqknF+ISTALNC27zPLe2
         /nEg==
X-Gm-Message-State: AOJu0YxtLxHHnb3TjLGtOwdgQDqXpWkZKlOg6p/55Wx8CbI44sb9gwZ8
	DNP/rKwtRFCSIPjfg73GY5uNsrBXZIxjwjlrJD8+tQBH88wXjSfX
X-Google-Smtp-Source: AGHT+IG0QBJ4N0Wk7va6sd3BBqyHzXedYSIYoT4dGrL28bQ9Fiv196RA1Wh0bEZSKgCTOWHzQupRwg==
X-Received: by 2002:aca:1c0f:0:b0:3bd:b5a9:d824 with SMTP id c15-20020aca1c0f000000b003bdb5a9d824mr1046533oic.62.1706076508118;
        Tue, 23 Jan 2024 22:08:28 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:cddd:d715:19de:f1d8])
        by smtp.gmail.com with ESMTPSA id jw21-20020a056a00929500b006dd887e37f0sm770300pfb.210.2024.01.23.22.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 22:08:27 -0800 (PST)
Date: Tue, 23 Jan 2024 22:08:24 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Dipendra Khadka <kdipendra88@gmail.com>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, mjguzik@gmail.com,
	ira.weiny@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Fixes warning: cast removes address space '__user'
 of expression in uaccess_64.h
Message-ID: <ZbCpWDQuymTbdgz5@google.com>
References: <20231116173849.210205-1-kdipendra88@gmail.com>
 <3ff3e05a-8377-4b38-84ae-be24b6cae6a4@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ff3e05a-8377-4b38-84ae-be24b6cae6a4@intel.com>

On Fri, Nov 17, 2023 at 07:19:12AM -0800, Dave Hansen wrote:
> On 11/16/23 09:38, Dipendra Khadka wrote:
> > Sparse has identified a warning as follows:
> > 
> > ./arch/x86/include/asm/uaccess_64.h:88:24: warning: cast removes address space '__user' of expression.
> > 
> > Since the valid_user_address(x) macro implicitly casts the argument
> > to long and compares the converted value of x to zero, casting ptr
> > to unsigned long has no functional impact and does not trigger a 
> > Sparse warning either.
> 
> Why does sparse complain about a cast to 'long' but not 'unsigned long'?
>  Both remove the '__user' address space from the expression.  Were there
> just so many __user pointers being cast to 'unsigned long' that there's
> an exception in sparse for 'void __user *' => 'unsigned long'?

Yes, unsigned long is special:

commit 7816e4c4a2dba6fef24c9a52c6b17a8cde0c8138
Author: Linus Torvalds <torvalds@ppc970.osdl.org>
Date:   Mon May 31 13:18:57 2004 -0700

    Allow casting of user pointers to "unsigned long".

    It's reasonably common to do special pointer arithmetic
    in unsigned long, and making people force the cast just
    adds noise.


I wonder if we should have:

#define valid_user_address(x) ((__force long)(x) >= 0)

or  

#define valid_user_address(x) ((long)(unsigned long)(x) >= 0)

Thanks.

-- 
Dmitry

