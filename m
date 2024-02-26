Return-Path: <linux-kernel+bounces-81450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A33086761D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BCE81C286B0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBAF80C0E;
	Mon, 26 Feb 2024 13:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIcyzcOT"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF7180053;
	Mon, 26 Feb 2024 13:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953072; cv=none; b=W+XoMEPuyNkhiNr4JK1IhF5kBSWl2ejzdRaX9P3j1afYhfTDd/GUj060LkNDq10ieA8GDC/AJreiHruKOCd6KfNtAxnr9asft0JX8Zw2N30uvjLZqYpcNIXY6exNwkVo0mG3QuI+Zg38n+rzDxw8fyw2r1nfK3BrP6A4Fdp+tl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953072; c=relaxed/simple;
	bh=ekQWHY7BVNZCY2DXnfaIUKh9V+Xfdva+gLdxhCjW1Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4aKmaHR+saIytR76prKgxDgJ2BHi88s0x1k9DQxgtxUR7k7en3DGq9chEdkiQL3FfoLsI7JRg/xv/dviGAdxyP9K9VycI0jTV/GigIMH6Rc75uPj+YKNQtNlDzXQJFCMAgBCEUibJly4zU0SJuTH6YFPIsa0/lSlbWnhZ5p27w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIcyzcOT; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-512bb2ed1f7so3306576e87.3;
        Mon, 26 Feb 2024 05:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708953068; x=1709557868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bKoFuhEp/bCcXvMo7xHJz8V0ER2vk9BnRQ/8URVm5m8=;
        b=CIcyzcOTDf2uxsJz4B3bLBquI3qlfGWSydUWSBqUs5TwzkLUiCQ3SgNQBLJ1+Wyghi
         4jt/nt2TWVaEflu0UgAPktUtNqDEH7WZe36zSkDSzpWjqhUBfDludiaycRBZOxRtM74c
         HHRFOFwNkg7hR3cMVWDDzjrKClgFmQYkvUjFwwONeFTcl/omdbC6kh3kfOPcUPFgxmaC
         4s8K4bXmMAPx8Dhgm/6EK0dnJgJfL/2SzeV94EWPvADEdYwGd5vxDJhgDxwhDkiEVykg
         YUyh7N7KpYwWXld6N6WUc8cQGygBmCCx4bLcBLUTR4ontGmNv+xfAKxUyEVjcxodCTPb
         Ggxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708953068; x=1709557868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKoFuhEp/bCcXvMo7xHJz8V0ER2vk9BnRQ/8URVm5m8=;
        b=QzVj6dbw9FbFeJ+gvtqDUPg6tP1Yhyf8/4+F9V82+g12JN8MqgPfG9TOYa+mcRstdB
         t4C8oEKv6F+hjAso8BtxWtkUfPjZDP48nbJF1HjFPM59uRLVukRZ7NQG8vhc5tXqKn9E
         G38Obmv9Wrvpbk/N2lVSf3lz8v7hBX44BrAUQnhNmvLpgczHZ1ifz2GSVdTZlkbD9N9Z
         zNOCtd7uuePAdqnDoN1TJbAjR1XKF5BORqemZgOCDQdoCxi3qIJef6NBjx4AnvhdZnFb
         HDjmbeVR+l6NnvdUd009TRKEdaCSOXVfNw5V3s54Kg6waMvR0uj3UMvrOEaQTcXmZkJr
         OVSw==
X-Forwarded-Encrypted: i=1; AJvYcCX0jhjQupceU6U3m1AKWhiBlnqjMvmYS7CK+y2YyyWlbmi6aHCvYl6WYe10kl01XLJC2rHIVODPHAgKx4RgUve6Jo/8mxFdHi7Dvy61eL9xgyat8KBatv6nztFuGDBo4KjbDmlTQpaKxA==
X-Gm-Message-State: AOJu0YySk4cNdTBvsJfBeHP8Tovuj5r4DhsNiAdB4M9DqGWIrs4+8JcU
	KIYo27ReHoWj62ztIcOKAVoRu2Haleiu4rCcOOubYaD/06+J+K4t2K0pug0g
X-Google-Smtp-Source: AGHT+IHyawTC1NS42B3HytmpdUXGmB4aUh42SaWyF6OlD1nNfApUD2V0xbyMM4gma8LH9PcWNNlk0A==
X-Received: by 2002:ac2:4a8a:0:b0:512:fd84:66ce with SMTP id l10-20020ac24a8a000000b00512fd8466cemr1736264lfp.65.1708953067968;
        Mon, 26 Feb 2024 05:11:07 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id d11-20020a056512368b00b00513022c0d3esm50738lfs.91.2024.02.26.05.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 05:11:07 -0800 (PST)
Date: Mon, 26 Feb 2024 16:11:05 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mips: cm: Convert __mips_cm_l2sync_phys_base() to
 weak function
Message-ID: <6n2synlvazjh2gptxtioju7dciwshwqyei4xnfzorns66b3hqx@c7blt5kwnpbl>
References: <20240226105427.7191-1-fancer.lancer@gmail.com>
 <20240226105427.7191-2-fancer.lancer@gmail.com>
 <34af21b5-a878-418e-a70b-299cab61b37e@app.fastmail.com>
 <y2lxeu5uvj7ezlv7kf6lox5e5xprmvrhqmf3gvzjsatlrrlub7@mvqzoyq5mnvd>
 <cc9e02b3-57df-4a7d-bd21-2d574bf4b878@app.fastmail.com>
 <simbnmm644ouv3kc3agsxiub6fzg6advihkqsbjzgmb44nmuxv@ktgkhn3kr43z>
 <60e60313-3cc4-452f-a222-aadd7728183d@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60e60313-3cc4-452f-a222-aadd7728183d@app.fastmail.com>

On Mon, Feb 26, 2024 at 01:29:54PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 26, 2024, at 13:20, Serge Semin wrote:
> > On Mon, Feb 26, 2024 at 01:04:33PM +0100, Arnd Bergmann wrote:
> >> On Mon, Feb 26, 2024, at 12:27, Serge Semin wrote:
> 
> > I see your point now. Thanks for clarification. IMO it would be less
> > readable due to the ifdef-ery and the new config, and less
> > maintainable due to the conditional compilation, but would provide a
> > more performant solution since the compiler will be able to inline the
> > singly used static method. Basically you suggest to emulate the weak
> > implementation by an additional kernel config.
> 
> I mean the kernel config that you already need here, since
> the strong version of the function is already optional.

Why would I need it if after this patch is applied the
mips_cm_l2sync_phys_base() method will be converted to a global weak
implementation?

> 
> > Not sure whether it would be better than a well-known
> > weak-attribute-based pattern. Anyway let's wait for the
> > Thomas' opinion about your suggestion. If he thinks
> > it would be better I'll update the patches.
> 
> Weak functions are not used all that much outside of a
> couple of parts of the kernel. There is a lot of them
> in drivers/pci/, a little bit in acpi and efi, and
> then a bit in arch/*/, though most of that is in mips.

+ a lot of them in kernel/*, some in mm/* .)

> 
> Ifdef checks in .c files are not great, but at least they
> are much more common than __weak functions and self-documenting.

Ok. I don't have concretely strong opinion about what is better. Let's
wait for what Thomas thinks about this.

-Serge(y)

> 
>      Arnd

