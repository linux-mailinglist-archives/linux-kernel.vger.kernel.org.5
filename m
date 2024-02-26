Return-Path: <linux-kernel+bounces-81262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B12867308
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F281C22552
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D7F1D546;
	Mon, 26 Feb 2024 11:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ytg0DlvR"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704311D535;
	Mon, 26 Feb 2024 11:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708946883; cv=none; b=mdS6MBkEcFvf8E3qxzIZiiwF4Rf1MC12JA++puUTQaleQXpPKarpr2kMIwjCxvHY+xM2A0uqrTPFvn1L0Tw1o3P3A5Ki8j9XYdIqGXEfQYb/8YJas+fGLOXlRIcBy9T/nl6KNsIlUaxKTUxs6E+/Rnm8LfBcQ2qfw2fVYTX/wbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708946883; c=relaxed/simple;
	bh=ATVGMAgFTSKaUu0QoQlaWSZn6gIX/h7/F0NSFkzSTEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkmAK80sjDsLbDOk0XKszOiDiL08aAS5JZn13nEm1SSBRiPJLACdhO5le6myENDE310WWnCkSFk9IMVqUuZpFGwDOq6aRDLEe984wCaJM6Z6E6jNlCjXqEZUreyRSrm9hzZRNNyC3C7RlJuN5YJW5ClVkpqjOp25ZhNYbhJYgSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ytg0DlvR; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d29111272eso2973011fa.0;
        Mon, 26 Feb 2024 03:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708946879; x=1709551679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eCG+0iTs0IX+hLHo/qYiNgX6GYLNuzkDgcE88IyfUfk=;
        b=Ytg0DlvRURNAX6rHN2NfCaMuhx8TM+kj/liGY3JA1nPtmde9d6MvqFx8edqpjfZ+5k
         9PiZfC2Kfuyolq1h7FsvnCFIh/C9kWDoBWQiT9jGYzUBSA2E88bC8NJpxHTfOyZc5ESn
         qqNB0Lia/GaIOGVAmDYeNPr5HpPx6i2Mtexyz0dPSYV3FKXYZqIPQOiO0MJy+m2AGHo9
         MYdEc6M5SOv+HoemJ6Dr1gkIWHCYKf5hwRUE9+xF/sJhIqOuPVuSuLZ5hoZuIsEq7CW4
         ulU9TK/kZ7BUEGVog5igh0/0csrtS0G8tGPpvtZNT95IVgSI/JaL2KzE33lffZu9WDSG
         f8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708946879; x=1709551679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCG+0iTs0IX+hLHo/qYiNgX6GYLNuzkDgcE88IyfUfk=;
        b=G5qTVz4czeUhEbrJY8EBR6nRNGtsANfBJxHh7SppVtDtugs2mrDkb9Nt8wzevrZ2sb
         aLol2mCS7HfK+NQWnG1qlIDeFjmCoox+9LbDkGiQIfwY/MOlqtCHbLAVllzem+yEZzN+
         Sv4vNJX89hVDfPGwqZ4qC2BQNcofqruf2bmmG1dRxhHq3FC7tdmM39LkFVtpr9JZfIe6
         rz+jcH9X8uw1guxCFwXVawfNEGdJJZXN4rSNohOrSTkFjiIL4P7zF8aA/mRkkIdkJH8J
         n1FUQqckmO7yu1+YqUEItfUYKybZyNLE9yhaSjYQf8Em2Zd1e3Noff0N96mgB04VQu/c
         mRAg==
X-Forwarded-Encrypted: i=1; AJvYcCUrizjqT/5MNzlRvve8+B4t8r646HM+ukfjL78wsg3+fV42HGmOEc285StzO/Hj/6rAFva3S1GVnlBb1Dqqos0wAgF0EwngqwkBb14IH/MpJAcwSdQdiDwn8413CA2/wNs1hOxwzPafww==
X-Gm-Message-State: AOJu0Yxlvlj2kThjs6m0HW7MCOfws/r9qyoc514YBZzOutmBOdbQ4KX3
	VFBMJDQNGBpfjGMA0ib303ImHxhkvy7YBi3UkHiotFzVZRnu/bwk
X-Google-Smtp-Source: AGHT+IHJYTRhgYUkb819o2XjixENgbUd97kO1tx88CZUCvfD4TcHppM+hKdWRADSFIpJhwgixUOpKA==
X-Received: by 2002:a2e:b889:0:b0:2d2:6676:3b0f with SMTP id r9-20020a2eb889000000b002d266763b0fmr5263785ljp.22.1708946879409;
        Mon, 26 Feb 2024 03:27:59 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id j14-20020a2eb3ce000000b002d29069239dsm106815lje.37.2024.02.26.03.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 03:27:59 -0800 (PST)
Date: Mon, 26 Feb 2024 14:27:56 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mips: cm: Convert __mips_cm_l2sync_phys_base() to
 weak function
Message-ID: <y2lxeu5uvj7ezlv7kf6lox5e5xprmvrhqmf3gvzjsatlrrlub7@mvqzoyq5mnvd>
References: <20240226105427.7191-1-fancer.lancer@gmail.com>
 <20240226105427.7191-2-fancer.lancer@gmail.com>
 <34af21b5-a878-418e-a70b-299cab61b37e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34af21b5-a878-418e-a70b-299cab61b37e@app.fastmail.com>

Hi Arnd

On Mon, Feb 26, 2024 at 12:04:06PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 26, 2024, at 11:54, Serge Semin wrote:
> > The __mips_cm_l2sync_phys_base() and mips_cm_l2sync_phys_base() couple was
> > introduced in commit 9f98f3dd0c51 ("MIPS: Add generic CM probe & access
> > code") where the former method was a weak implementation of the later
> > function. Such design pattern permitted to re-define the original method
> > and to use the weak implementation in the new function. A similar approach
> > was introduced in the framework of another arch-specific programmable
> > interface: mips_cm_phys_base() and __mips_cm_phys_base(). The only
> > difference is that the underscored method of the later couple was declared
> > in the "asm/mips-cm.h" header file, but it wasn't done for the CM L2-sync
> > methods in the subject. Due to the missing global function declaration
> > the "missing prototype" warning was spotted in the framework of the commit
> > 9a2036724cd6 ("mips: mark local function static if possible") and fixed
> > just be re-qualifying the weak method as static. Doing that broke what was
> > originally implied by having the weak implementation globally defined.
> >
> > Let's fix the broken CM2 L2-sync arch-interface by dropping the static
> > qualifier and, seeing the implemented pattern hasn't been used for over 10
> > years but will be required soon (see the link for the discussion around
> > it), converting it to a single weakly defined method:
> > mips_cm_l2sync_phys_base().
> >
> > Fixes: 9a2036724cd6 ("mips: mark local function static if possible")
> > Link: 
> > https://lore.kernel.org/linux-mips/20240215171740.14550-3-fancer.lancer@gmail.com
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> 
> I'm sorry I introduced the regression here, thanks for addressing it.

No worries. I've noticed it in my local tree only. Neither CM nor CM
L2-sync base address getters aren't currently re-defined in the
mainline code. So the generic kernel code hasn't been affected.

> 
> > -static phys_addr_t __mips_cm_l2sync_phys_base(void)
> > +phys_addr_t __weak mips_cm_l2sync_phys_base(void)
> >  {
> >  	u32 base_reg;
> > 
> > @@ -217,9 +217,6 @@ static phys_addr_t __mips_cm_l2sync_phys_base(void)
> >  	return mips_cm_phys_base() + MIPS_CM_GCR_SIZE;
> >  }
> > 
> > -phys_addr_t mips_cm_l2sync_phys_base(void)
> > -	__attribute__((weak, alias("__mips_cm_l2sync_phys_base")));
> > -
> 
> I generally have a bad feeling about weak functions, as they tend
> to cause more problems than they solve, specifically with how they
> hide what's going on, and how I still can't figure out what this
> one aliases to.
> 
> Since the resolution of the alias is all done at link time
> anyway, could you just convert these to an #ifdef check
> that documents exactly when each of the versions is used?

Not sure I've completely understood what you meant. Do you suggest to
add a mips_cm_l2sync_phys_base macro which would be defined if a
"strong" version of the method is defined (and surround the
underscored function by it)?

Please note after this patch is applied no aliases will
be left, but only a single weakly defined method:
mips_cm_l2sync_phys_base()
This is what we agreed to do with Thomas:
https://lore.kernel.org/linux-mips/pf6cvzper4g5364nqhd4wd2pmlkyygoymobeqduulpslcjhyy6@kf66z7chjbl3
Thus there will be no need in the macro you suggest since the
weak-version of the method will be discarded by the linker as it will
have been replaced with the "strong" one. 

-Serge(y)

> 
>       Arnd

