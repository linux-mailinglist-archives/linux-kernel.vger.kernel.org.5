Return-Path: <linux-kernel+bounces-81355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5867E8674A5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0631B230DE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F302604C9;
	Mon, 26 Feb 2024 12:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qi4Icdis"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97B5604AD;
	Mon, 26 Feb 2024 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950050; cv=none; b=pCO5Gz+2uhLshAWdktgV8sCii40m3EvAq0S27hK5cp1bFxhUibJttthnQyhneTbpEjZl3O9JXr5DCWYDmuH7vAJoL5tiz+G0UVwcBeICzbEHRvNmEQL69/ftlpxECIxgUFTkncGlfXYw6C36hRoi2S/QLRiIwOd2KCQqt3tj6Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950050; c=relaxed/simple;
	bh=MklLrIDTS7FBhRMF3t1OlfezefpnGDB616/6YDTb+M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bb5P988ZhGowxvvH57vkFHWO5lbgEFOzBTzvw1V1fos/jWjPeJVLTtBTdFjYhwbHish4Uy5mxibFe5FyVWJCu042Vt09IMh1UyrKFmkHZlD/Zj2KyqOV5Tyx6jEo5xZ1L0J54xuup7aekk/EZ4kst6/k5Fd0JdAwG+UsgUqsGq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qi4Icdis; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-512fce83ab5so1043228e87.1;
        Mon, 26 Feb 2024 04:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708950047; x=1709554847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xS2Q6CbvED2rXlKIWb0ms2HmMRr1/aS0n8oEYtj1IGo=;
        b=Qi4Icdisp4Jdac6gsZDgawrTMd5FEJn5xfOOcqyksOmruHlaNavFDigp6JQfL8ES1M
         iRNXwkHMR5MsLIPJ9o6+qA3anmYqLxuiSvis6FH/m0wFIj1SFV4tWopVnjaIO6XC2Hnn
         NBJ7bF1SQAU1o0fadSk6fkFL1vaQz6+e0Rq9RH5iPCVp+udSTslIttiONyc/Pd3l2dEU
         dtSA2TxWib6phoqKtabMs3wkB0MOiB2hgSS0hdZELQyyBwvJ+FXMydbTfGQpnbmOr2ca
         KWhMbV41vbjd9u33Imug2GTJCWNep72BHMbD8uoObQsGsL6fJnVbJsAkCyUEhm8pjq/A
         nTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708950047; x=1709554847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xS2Q6CbvED2rXlKIWb0ms2HmMRr1/aS0n8oEYtj1IGo=;
        b=nNvpsX2cZxZxpx66KDZzWKStq846dtj3nrBGRO+yXRTrG1J9D+8fwpzmix5EjK3+tU
         2N5pwSF0YU34f6Gsns5O8qQQd0SLW+o5Zk8SHhnuz1t8ZqxZTJRwUayNDhgvU4W4VEqc
         E1jax/Xu5M/6DKhnqWLcJZ47oiMRfDTNS0BDesMJdmdeEJfjy7LrbB6e7QLJbL4oLCJe
         QozVy2hVQQDyQ/eUi3KiK792f683WquUX6GlFw3lSgJuShmqV7EJJBPONa/837Pq8NbT
         Gtpo+nzjWTvWzKRrnBS3LIXaG8//slOq6dAlDBCyT+xMGubJ1bKVcf6JhEsSJ+cFPVUi
         OgSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3FL0K8VnbOSVDXzBz1TxPJbHvueEVqjCyDvMnl+/gLES81U+ZEKF1ZiRfjqKhIn3unIo34yk+g4voGYNSzEFx+OrBFEjwjAZ/aq48YWknG3tzDzVrUtg4NDuuvvSKBE7dLC7df4bh8A==
X-Gm-Message-State: AOJu0YzHVGmFJ84pkco86vDykxz3Mq2ppCLSVCzPpRBXkWyGS5UVvZrV
	7rGzBfCIZybMTbfxt0EKstoCp3xiH7DIlJ52MnSPV6ENrh80aCNF
X-Google-Smtp-Source: AGHT+IGtfTtM6cOA5wBmQUSrMJUxcmr1SIU7E83Uy6sQpHBM4tP/IwZ5EUFkh2tIMSDouznX0qyDVw==
X-Received: by 2002:a19:ee16:0:b0:512:bea2:f002 with SMTP id g22-20020a19ee16000000b00512bea2f002mr3856294lfb.6.1708950046770;
        Mon, 26 Feb 2024 04:20:46 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id t16-20020ac25490000000b005130282c899sm7596lfk.0.2024.02.26.04.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 04:20:46 -0800 (PST)
Date: Mon, 26 Feb 2024 15:20:43 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mips: cm: Convert __mips_cm_l2sync_phys_base() to
 weak function
Message-ID: <simbnmm644ouv3kc3agsxiub6fzg6advihkqsbjzgmb44nmuxv@ktgkhn3kr43z>
References: <20240226105427.7191-1-fancer.lancer@gmail.com>
 <20240226105427.7191-2-fancer.lancer@gmail.com>
 <34af21b5-a878-418e-a70b-299cab61b37e@app.fastmail.com>
 <y2lxeu5uvj7ezlv7kf6lox5e5xprmvrhqmf3gvzjsatlrrlub7@mvqzoyq5mnvd>
 <cc9e02b3-57df-4a7d-bd21-2d574bf4b878@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc9e02b3-57df-4a7d-bd21-2d574bf4b878@app.fastmail.com>

On Mon, Feb 26, 2024 at 01:04:33PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 26, 2024, at 12:27, Serge Semin wrote:
> > On Mon, Feb 26, 2024 at 12:04:06PM +0100, Arnd Bergmann wrote:
> >> On Mon, Feb 26, 2024, at 11:54, Serge Semin wrote:
> s to.
> >> 
> >> Since the resolution of the alias is all done at link time
> >> anyway, could you just convert these to an #ifdef check
> >> that documents exactly when each of the versions is used?
> >
> > Not sure I've completely understood what you meant. Do you suggest to
> > add a mips_cm_l2sync_phys_base macro which would be defined if a
> > "strong" version of the method is defined (and surround the
> > underscored function by it)?
> >
> > Please note after this patch is applied no aliases will
> > be left, but only a single weakly defined method:
> > mips_cm_l2sync_phys_base()
> > This is what we agreed to do with Thomas:
> > https://lore.kernel.org/linux-mips/pf6cvzper4g5364nqhd4wd2pmlkyygoymobeqduulpslcjhyy6@kf66z7chjbl3
> > Thus there will be no need in the macro you suggest since the
> > weak-version of the method will be discarded by the linker as it will
> > have been replaced with the "strong" one. 
> 
> I meant that instead of having both a weak and an optional strong
> version that get linked together, always define exactly one of the
> two, such as:
> 
> #ifndef CONFIG_MIPS_CM_xxx
> static phys_addr_t mips_cm_l2sync_phys_base(void)
> {
>        /* current implementation ... */
> }
> #endif
> 
> where CONFIG_MIPS_CM_xxx is the Kconfig symbol that decides
> whether the file with the strong version is built or not.
> 
> This way you always get exactly one of the two versions
> of the function built, the local version can be inlined
> if the compiler thinks that is better, and the #ifdef
> documents exactly whether the function is used or not
> for a given configuration, rather than a reader having
> to track down how many other definitions exist and whether
> a config includes them.

I see your point now. Thanks for clarification. IMO it would be less
readable due to the ifdef-ery and the new config, and less
maintainable due to the conditional compilation, but would provide a
more performant solution since the compiler will be able to inline the
singly used static method. Basically you suggest to emulate the weak
implementation by an additional kernel config. Not sure whether it
would be better than a well-known weak-attribute-based pattern. Anyway
let's wait for the Thomas' opinion about your suggestion. If he thinks
it would be better I'll update the patches.

-Serge(y)

> 
>        Arnd

