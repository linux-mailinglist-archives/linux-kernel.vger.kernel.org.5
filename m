Return-Path: <linux-kernel+bounces-112552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEAF887B71
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 03:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC422823F4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 02:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCE44439;
	Sun, 24 Mar 2024 02:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG9rclhs"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BED028F1
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 02:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711247144; cv=none; b=lVFLljIBPD5cjrjC88JJK6oCmA0g7DEcrhJn6pr3Cm+B1LeLzMkLCBIKN4/VsVznw3MlYQXHdr/fM6CmqDNv3cKWe7UQXFi9xt3TibLEXEL5Uv/Hznbknu9Xkz08oalaGNmScE007JH1hmNHkqlu3m6U31iqMSfrcXCOBvHfP6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711247144; c=relaxed/simple;
	bh=Lf8yoDkOzrlo1LsMbwoX0ZqzqnhmbHCAwtRTnmQiewA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dj2+keEMxETT6E/YZkjm+o9wrcY1IOmvjRNlcLqw145TB+NiW6RM1xmBdrjEGbcXT6lJ8nxOEQwb/ju8Wt8UZ3HDedC+qjyDcym3+gLSw7V+4i/fU5sVimJZE3+F/Bs2DeQC6v+enuE53aYtfqFlmxY348R6JHBC7E19FADRF8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bG9rclhs; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a470d7f77eeso410644666b.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 19:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711247141; x=1711851941; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hjNxjQJRQ/l7WCeyRyW/5FcOffEjbz9J38JL7rInVM8=;
        b=bG9rclhsXCVT2cso3Doc++TBF+TzflA9hr/HB+ChzOLQUKI74LSAAajqsw2D6Xqc2N
         JBodNs41T7+/Jy1t/F2V8zxef81onfDSwc8YxEQdRbgcjZNLw2z6a+V80mNzhGeHDZxK
         0cSZkrx+3+4jkiukRQ2zHB2OtkPB68XjCzzuHs5Ithl0MgpAncMFDmeAqEoAxhdjrdV+
         JCIsejrcLEIsk8i2MjmfUkJ7JujAbIyhfWvq3dgAu66TbhrTs2xzmflygOPiOeCkjIGB
         KE2JBRRrgsDt/eULbZ9b1P95NbjWzK4Vz5JbvouMHlBpi3oUDfzTzIXgcxghA83wtRDu
         q04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711247141; x=1711851941;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hjNxjQJRQ/l7WCeyRyW/5FcOffEjbz9J38JL7rInVM8=;
        b=xS/DRFsHJNPVY/Qh/EDEzYASfP5OtKr+lk8zFJWPRplX4ffx/jglbY8pBSN/IlHqAg
         VKGO3SxHLWVod7qEHMMS573BOVCPVltDqI1fHS3mZAX08J04PrtSqMCIVRYd2h27pxay
         9GSUDDPJFS34icmRyOvscoMZ1s76VeEvBVDdFIRUcbZHzRUPQrW3FgrpPuknTdNqAhFr
         skaInH3ivQLHOAxyZFQ9px6S2q6up0rruFvU3ef1EF8qOMHSvfU7ICfLkY/ZoloFJmH2
         O0J/pbFRQItFHBk/YFtNK6RnpO6FU91xR6sm9OvTiAOCsS+DwsN5oYNXZTIhSOqkmz6r
         /vlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPyKWTf02xGMqmAyThvBzuQ4nRN9LeAo7g8BAitVW1As3Ozl+flnObdQUytP6NYZ0xsTVyc/KVtGAxeZVW3wDXJG5wCOEwOD639PfB
X-Gm-Message-State: AOJu0YwD9mpOG080zMdk49IHx0pqZRLVe8i784HAni77Aca/0e40q9X2
	B9eXCNUS07GLJln7HJdDDR5AncQSYTGzcBNyrjXSb/cp3GjdOuwbM5/Xu3OvgpY=
X-Google-Smtp-Source: AGHT+IECuNIWdaxTRasUz7/0wdaVGWw7V2dyP/WSCsevXmk/2AuD4jHTfkoaoknrctQf9XrqHtzxYg==
X-Received: by 2002:a17:906:f194:b0:a46:a662:e56f with SMTP id gs20-20020a170906f19400b00a46a662e56fmr2470442ejb.38.1711247140185;
        Sat, 23 Mar 2024 19:25:40 -0700 (PDT)
Received: from gmail.com (195-38-112-2.pool.digikabel.hu. [195.38.112.2])
        by smtp.gmail.com with ESMTPSA id e18-20020a170906c01200b00a472eb53793sm1498478ejz.161.2024.03.23.19.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 19:25:39 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 24 Mar 2024 03:25:37 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	David.Laight@aculab.com,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 00/16] x86-64: Stack protector and percpu improvements
Message-ID: <Zf+PIYP4TyF6ZRVy@gmail.com>
References: <20240322165233.71698-1-brgerst@gmail.com>
 <CAFULd4bCufzKjaUyOcJ5MfsPBcVTj1zQiP3+FFCGo6SbxTpK2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4bCufzKjaUyOcJ5MfsPBcVTj1zQiP3+FFCGo6SbxTpK2A@mail.gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> On Fri, Mar 22, 2024 at 5:52 PM Brian Gerst <brgerst@gmail.com> wrote:
> >
> > Currently, x86-64 uses an unusual percpu layout, where the percpu section
> > is linked at absolute address 0.  The reason behind this is that older GCC
> > versions placed the stack protector (if enabled) at a fixed offset from the
> > GS segment base.  Since the GS segement is also used for percpu variables,
> > this forced the current layout.
> >
> > GCC since version 8.1 supports a configurable location for the stack
> > protector value, which allows removal of the restriction on how the percpu
> > section is linked.  This allows the percpu section to be linked normally,
> > like other architectures.  In turn, this allows removal of code that was
> > needed to support the zero-based percpu section.
> 
> The number of simplifications throughout the code, enabled by this
> patch set, is really impressive, and it reflects the number of
> workarounds to enable the feature that was originally not designed for
> the kernel usage. As noted above, this issue was recognized in the GCC
> compiler and the stack protector support was generalized by adding
> configurable location for the stack protector value [1,2].
> 
> The improved stack protector support was implemented in gcc-8.1,
> released on May 2, 2018, when linux 4.17 was in development. In light
> of this fact, and 5 (soon 6) GCC major releases later, I'd like to ask
> if the objtool support to fixup earlier compilers is really necessary.
> Please note that years ago x86_32 simply dropped stack protector
> support with earlier compilers and IMO, we should follow this example
> also with x86_64, because:

Ack on raising the minimum version requirement for x86-64 
stackprotector to 8.1 or so - this causes no real pain on the distro 
side: when *this* new kernel of ours is picked by a distro, it almost 
always goes hand in hand with a compiler version upgrade.

We should be careful with fixes marked for -stable backport, but other 
than that, new improvements like Brian's series are a fair game to 
tweak compiler version requirements.

But please emit a (single) prominent build-time warning if a feature is 
disabled though, even if there are no functional side-effects, such as 
for hardening features.

In general distro kernel developers & maintainers like seeing the 
performance (and other) effects of their compiler version choices, but 
we are not very transparent about this: our fallbacks are way too 
opaque right now.

Thanks,

	Ingo

