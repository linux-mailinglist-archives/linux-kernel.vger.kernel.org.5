Return-Path: <linux-kernel+bounces-46158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1294C843B5E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9493C28C7C7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007F269944;
	Wed, 31 Jan 2024 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeAW0j84"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E40A67E66;
	Wed, 31 Jan 2024 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706694300; cv=none; b=lPCoRSSWvmom3iKASIFVZ0h1rYNxsjxGa98kL8ARs9n8vm6p2WTk11VDmtIlh9mpYfHOOPdi+cHn4THfwlgbyFVz+mrRvRYIaISQQYr0zqoIUfZ+tFVelcnskPSmduAL761nPfaIywa5FvTqK3CjvMHjHBc71LvlZliNK+5kun4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706694300; c=relaxed/simple;
	bh=gmOL2pz/tHj50TXo9GkXn8Ym3seZNtPoH6pLa4QiTpE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gspPt8vZpa3xUGjvJLndKBozje1dKHrkXXOx6Lv0Yka//LFBtBqbWaLWIt91ly0qyDSjLAZ1zu4XaIDj0fkxWWMgzIYKT5f7/I1fQFHFUUWqDf9FQb2Bg+uBzCBWST4IqKGE86YtEdFnrNG3Uo6iVWPyI2RZl6IrbJReao+NmlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JeAW0j84; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d043160cd1so39817161fa.1;
        Wed, 31 Jan 2024 01:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706694296; x=1707299096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xqfllA/2YuYyJzutnMb4Kn7O4ZljTY6NQ9hi49SVfuU=;
        b=JeAW0j84bKR61eA3jH/akSK68Ow6ggRI1pSeKAhYsalqkIagdYMMgTfDYU/0B+JDsl
         uJxGesuFexFeEfpCxLJcLMrNX6nq9BWURRen7+35b1oEyOLJbDwW32l7k/dcB1q0N6VK
         bfXHQKo/8sgY/Qh5dESZkf/SYn2kvTiQrkIgBQowpL80hxvTRCMUTA3YuQHdH4POjura
         UCp2cltDxYsZ/DElhYe9scQoHzVYXjHBgKMy/DhJNPrBQrzOImQU6li/cFQ9ubh+miEs
         OphLqqWLZR7fMMuLMsGqkw7hhUwoITwaW7xtzdi22dWN7Jflbnf2YUzM/bemXZMLz+Va
         h04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706694296; x=1707299096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqfllA/2YuYyJzutnMb4Kn7O4ZljTY6NQ9hi49SVfuU=;
        b=qM0te7igdB8cTLW9AAnHYi7xaZtDZDWuvxdLrgG1B1eRiIZi07aXn94djb3NJVZNqa
         A6Fbxpu1BpXAUo6lbJlPTo2c5BfMebv+CI8ruYJbTOur/lWScaMkrvYe6NBXcHxkV2KY
         +PyLVzwEr23fZBh0lD+Eqx4QHM8FiEYA+FylEtLgd/lbf8pdPG61hkJHNxcBrnOBEXNe
         Q33cGcmsx0wAtMKl8z5ZxyuqZp0uhpZcUvRovP3XIHqclf9hB01tNviGwjuNYZXqMJcJ
         ZsYeeHNHsrGp48AgW60LurdArcNYO3qb+Y1yJ29dXlPNbTDhJDDO6qoNQPuawHhtzo20
         iajQ==
X-Gm-Message-State: AOJu0YxPCdU6CvP2vxyteJh/EezRYQaNqUOGORWAdKgwczbCGg6JTALH
	T2FQ8qiYmPmG2F539a20S4MPjY/q+dfMrsLLGQKTUtFpcR4KXhSK2cfJ69ni
X-Google-Smtp-Source: AGHT+IGqY3n86AQFMF9vP/idAYTWFZOWTzha8EHc3DX+Yo8i2h5ItRyBdF1G5YVvXvouBbe78z1EJw==
X-Received: by 2002:a05:651c:204d:b0:2cd:a297:34 with SMTP id t13-20020a05651c204d00b002cda2970034mr676405ljo.3.1706694296009;
        Wed, 31 Jan 2024 01:44:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXoe/C03lna4UHzlqle05g3e9qcmfQzYe9hWXeM/UYZO6fHuJJgSgV08W26TQS3HFOaTuALeyhryxNTmV5L9l/k0JtQWc7qP0zjoXnfyIosSZPowi+dEelDgFGc9l4XE8j9AEy0TXCg/k+KNfeKx0PTX3W2z/ofwC+bj0OGHzHPA79PGB5vinz2r8ds0Sbb1iz7W2TAhlAtUC9Uu0C7WoKFeWjoUJ5X19CYMqtrxaNEN66v8CRgFvNTyDQdO/4nxWzITpJ757EzO5+Tx3eWX/3UuqL0iBV1duAzemFb7SZwDVY3U8T1RH5TJl7yNg2fX987GAMV5knnTANE6zYCxfGv7Qpm1w==
Received: from pc636 (host-90-233-198-33.mobileonline.telia.com. [90.233.198.33])
        by smtp.gmail.com with ESMTPSA id t15-20020a2e9c4f000000b002d0495fa30fsm1141594ljj.47.2024.01.31.01.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 01:44:55 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 31 Jan 2024 10:44:53 +0100
To: Kees Cook <keescook@chromium.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 33/82] mm/vmalloc: Refactor intentional wrap-around
 calculation
Message-ID: <ZboWlVrD0TgeBo3J@pc636>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-33-keescook@chromium.org>
 <24526e13-2df6-47ea-865f-b5a5594bc024@lucifer.local>
 <ZblT2OjkPcZQEw7A@pc636>
 <202401301356.4F87B727@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202401301356.4F87B727@keescook>

On Tue, Jan 30, 2024 at 01:57:12PM -0800, Kees Cook wrote:
> On Tue, Jan 30, 2024 at 08:54:00PM +0100, Uladzislau Rezki wrote:
> > On Tue, Jan 30, 2024 at 06:55:57PM +0000, Lorenzo Stoakes wrote:
> > > On Mon, Jan 22, 2024 at 04:27:08PM -0800, Kees Cook wrote:
> > > > In an effort to separate intentional arithmetic wrap-around from
> > > > unexpected wrap-around, we need to refactor places that depend on this
> > > > kind of math. One of the most common code patterns of this is:
> > > >
> > > > 	VAR + value < VAR
> > > >
> > > > Notably, this is considered "undefined behavior" for signed and pointer
> > > > types, which the kernel works around by using the -fno-strict-overflow
> > > > option in the build[1] (which used to just be -fwrapv). Regardless, we
> > > > want to get the kernel source to the position where we can meaningfully
> > > > instrument arithmetic wrap-around conditions and catch them when they
> > > > are unexpected, regardless of whether they are signed[2], unsigned[3],
> > > > or pointer[4] types.
> > > >
> > > > Refactor open-coded unsigned wrap-around addition test to use
> > > > check_add_overflow(), retaining the result for later usage (which removes
> > > > the redundant open-coded addition). This paves the way to enabling the
> > > > unsigned wrap-around sanitizer[2] in the future.
> > > >
> > > > Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> > > > Link: https://github.com/KSPP/linux/issues/26 [2]
> > > > Link: https://github.com/KSPP/linux/issues/27 [3]
> > > > Link: https://github.com/KSPP/linux/issues/344 [4]
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: Uladzislau Rezki <urezki@gmail.com>
> > > > Cc: Christoph Hellwig <hch@infradead.org>
> > > > Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> > > > Cc: linux-mm@kvack.org
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > ---
> > > >  mm/vmalloc.c | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index d12a17fc0c17..7932ac99e9d3 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -1223,6 +1223,7 @@ is_within_this_va(struct vmap_area *va, unsigned long size,
> > > >  	unsigned long align, unsigned long vstart)
> > > >  {
> > > >  	unsigned long nva_start_addr;
> > > > +	unsigned long sum;
> > > >
> > > >  	if (va->va_start > vstart)
> > > >  		nva_start_addr = ALIGN(va->va_start, align);
> > > > @@ -1230,11 +1231,11 @@ is_within_this_va(struct vmap_area *va, unsigned long size,
> > > >  		nva_start_addr = ALIGN(vstart, align);
> > > >
> > > >  	/* Can be overflowed due to big size or alignment. */
> > > > -	if (nva_start_addr + size < nva_start_addr ||
> > > > +	if (check_add_overflow(nva_start_addr, size, &sum) ||
> > > >  			nva_start_addr < vstart)
> > > >  		return false;
> > > >
> > > > -	return (nva_start_addr + size <= va->va_end);
> > > > +	return (sum <= va->va_end);
> > > >  }
> > > >
> > > >  /*
> > > > --
> > > > 2.34.1
> > > >
> > > 
> > > Looks good to me,
> > > 
> > > Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > >
> > Same here. One small nit though. The "sum" variable is not something
> > that it suits for. IMO, we should use a better name and replace it:
> > 
> > "nva_offset"?
> 
> Sure, I can use that. Other folks in other patches have suggested "end",
> so maybe nva_end or nva_end_addr ?
> 
nva_end_addr is probably the best fit.

--
Uladzislau Rezki

