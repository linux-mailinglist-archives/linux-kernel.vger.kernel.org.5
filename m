Return-Path: <linux-kernel+bounces-76325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A969F85F5A4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF4328911A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4373A1B4;
	Thu, 22 Feb 2024 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YppexR21"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E483A1AE
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597610; cv=none; b=LjlqGM+DABEN8TTMU8SuAQBffNUC893aXqkEXkMGTI/X+ShyYlj5RQ7yJlxT0FWZFXMlSMIY23zDUyAX1/edmc9l9u+4eqXZk14RaRWwdLBxeLJMNIHkJhyjkfARqtB6deUn6EK2FS2f2BLd9OEZxp4TGubTlSzuNoE6J3ILfHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597610; c=relaxed/simple;
	bh=kBKRbqZXYhSlKvkQSymQhmEGB/AZjE2LaPl+EB1lRNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Baz1OY8fgr0qTvPQDXX7WimL6z1UM6lQh9xXP5nVTA64hFRMxbEroCqK3kCxmqjwUFtj8Ol6Z/3zlvefvaIodBF0gp0SLnilREbbe7SUuRkqkESuSaKVP4t2K7fkQxW9ynm59pTtgkcfMXktWpoEXcu+EMPPrFJLRjFopa2wC3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YppexR21; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3f1bf03722so301384266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 02:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708597607; x=1709202407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K5bKsjBI6e56AOkMHLITMgOBC2WpfbN0X+9CXtkORLI=;
        b=YppexR21gLECaFU5u61qflKW0DtqdSmZSU2U/YSkTLOGLyy2DPLVKNqwNWKL6F6Wil
         FGGWDUVO9gfaSSaQuitygtJrOcgyhI9Z9vewHShve53sAuQNM2VIIEqWZQXFdeI3pz6C
         EDpD0RkIHESQaO4ItpoQxDZT8KLmz3rJmRNbOkOLJ1iesTn2uyCMaBODfc3nmKVbUah8
         SCWdk+XOi8I4QGve9jSfDkIVSE9pWnRjr902Sf4QCf/+nwGhBV+5iADdiHFss7uqxZOE
         O/Oon/uXM4s+BsgR37I85/HocktktRgz4CwQAPvzic6bI4fBgiQ/IvttRNGiMT4SOUoE
         q/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708597607; x=1709202407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5bKsjBI6e56AOkMHLITMgOBC2WpfbN0X+9CXtkORLI=;
        b=B5jP4GJ70k2yjVNdvMnFGDIp+y265LrnCqqxVRWB1l8yxUsHaV3ViGSfG2BV2giy5K
         fXiwO7Nv/JqxsofIRGQPiyiaT5G8h4fnC50Sh1eSoVycQYH6lvEE1RJIjDWqm2mcTocH
         f/riVW2t4U369qaam2Tm5AhEaE/QzdfmLYtaCYv0qxCz+KHXh5IohLeINPXFoA5z14SY
         nJRoVm3QRoSI5ZhVRZWh/kZc8RPOjcFusMVelytBxsDYMl4nyIMRVmb7vBDsmspVgsKg
         Li8x2PTZnlcd30FbeKIc16lP7F+EWBXQg9i9yPGZvsiQ9GJD1/mkzHeyk1VKXHTompA2
         eQ5A==
X-Forwarded-Encrypted: i=1; AJvYcCVOVp4v1WdgxPahokLhK5RGwUakP6KoVYMfAcnehb58yUVfrfMZQhxykTOcEzEwpAOAxmSqp3hJ+rx/YN9Q2E0u/cHgYJlDQGoX99Pw
X-Gm-Message-State: AOJu0YzNs0/CutxM6z0aHT9WtM+sGlx30az+nkzSfJW/wqq9oSnckQBT
	Gn6Ds3VQyhSifswe0i7CPtT0oUxlbFAHynPa0cIBpOPyJf16SoDkgC/Tn7s=
X-Google-Smtp-Source: AGHT+IHZA7Oiz7D0VZbxpEzg1a5/HywbzwYIhX2MKK3cx3AFhZwePDauTSlaekIvoavN0aSw7dIpYQ==
X-Received: by 2002:a17:906:1cc5:b0:a3e:98ee:765d with SMTP id i5-20020a1709061cc500b00a3e98ee765dmr6981422ejh.60.1708597606715;
        Thu, 22 Feb 2024 02:26:46 -0800 (PST)
Received: from p183 ([46.53.251.190])
        by smtp.gmail.com with ESMTPSA id fj21-20020a1709069c9500b00a3e5adf11c7sm4709223ejc.157.2024.02.22.02.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 02:26:46 -0800 (PST)
Date: Thu, 22 Feb 2024 13:26:44 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu: mark cpu_possible_mask as __ro_after_init
Message-ID: <f076212f-9b2a-4eb5-980b-3043e6dd57aa@p183>
References: <41cd78af-92a3-4f23-8c7a-4316a04a66d8@p183>
 <a1fafb71-cbd9-4d0b-8c3c-2b69be97db3e@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a1fafb71-cbd9-4d0b-8c3c-2b69be97db3e@roeck-us.net>

On Wed, Feb 21, 2024 at 10:00:26PM -0800, Guenter Roeck wrote:
> On Mon, Feb 05, 2024 at 01:01:19PM +0300, Alexey Dobriyan wrote:
> > cpu_possible_mask is by definition "cpus which could be hotplugged
> > without reboot" -- property which is fixed after kernel enumerates
> > motheboard capabilities and hardware configuration.
> > 
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > ---
> > 
> >  kernel/cpu.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -3107,10 +3107,10 @@ const DECLARE_BITMAP(cpu_all_bits, NR_CPUS) = CPU_BITS_ALL;
> >  EXPORT_SYMBOL(cpu_all_bits);
> >  
> >  #ifdef CONFIG_INIT_ALL_POSSIBLE
> > -struct cpumask __cpu_possible_mask __read_mostly
> > +struct cpumask __cpu_possible_mask __ro_after_init;
> >  	= {CPU_BITS_ALL};
> 
> I guess you didn't compile test this code.

On parisc, no. Oh well.

> >  #else
> > -struct cpumask __cpu_possible_mask __read_mostly;
> > +struct cpumask __cpu_possible_mask __ro_after_init;

