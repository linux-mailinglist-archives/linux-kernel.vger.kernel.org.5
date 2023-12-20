Return-Path: <linux-kernel+bounces-6666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E402A819BD9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0310287CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D459D1F95D;
	Wed, 20 Dec 2023 09:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAyxdYLI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEECF1F92D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 09:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33621d443a7so5641429f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 01:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703066349; x=1703671149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ny+Yl4+P4MgSob1PbxFHFoIjGgaB4XvxQLBNYx0xg/g=;
        b=QAyxdYLIDWEDCUHvu8UHIsRVkfR7oB+pG0USITadP8Kyev+PfaK1A6LHFnJST0aSQo
         +UdSyqO9TZfzCrWs84qEjw9A9uAtObUipbKYY2F0od8fgU2knz8iSLixs0mYDFwbR+Q3
         Yg/CDZyCfOgLHglhqwfLfB2BYpUTJWSdDfS2m2pr0/8ybeDOLL05R7nwM28LIuxWgyxB
         75n0hCvl2I7LCpog0an1kkIk6Afw/bj5GGcKe6EIn/dVYplOkr0Ck/IQoyVUJ/G0JnRu
         uGdATNuumAMITVCXWCiQfq/QHi1NHTaK6g4d6XXl4/tFwy860KmC2ZK8uCgrTTRyxtbC
         J2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703066349; x=1703671149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ny+Yl4+P4MgSob1PbxFHFoIjGgaB4XvxQLBNYx0xg/g=;
        b=pthc1UoCKuSs/Ix4YlNhck/MMSWvzQSuCVMuGg/1jPToWFsPBJMf8KCP949L7/2mTt
         va+dCsisz3bTzUvHwuKHZ3TgxpGENjfmyeMk1e9ELp9kVX/O49HrviEQRnokJ6uEHmlG
         y6acYdGegp8klfQfpTdaugqQAVQJecJJi/oJiIcZSZUwjleMQkIMdmuzesDl1xlD1l1g
         7DRZBnD4hXw0fZkrCiiC8IYbOhyNhDPevXG5gV0cEzLQdoCIjyJvB/GYp+dHxczyYc3d
         u//Yl6R9kyt7YEcSc3iTzjBevT9s6JBoirtc5gQrTDRaxx8jMVwfYXNM7KRjrlBDRNMv
         7k5Q==
X-Gm-Message-State: AOJu0YwAjfJt40qk9ipMVUEgKnuWsyvkYbstMnrFP1q2HkuUb4ILxu2v
	R2x4l5T3+IoPnw9UYxi9rsY=
X-Google-Smtp-Source: AGHT+IHHH0pdVhA1iKk3AMCNcKVRTwRHrpXcHLvAfHfpJ2VPDYElaa9tSEZMe8G/WwkdOMa00bFN4Q==
X-Received: by 2002:a05:600c:21c9:b0:40c:3308:3af7 with SMTP id x9-20020a05600c21c900b0040c33083af7mr9500964wmj.176.1703066348774;
        Wed, 20 Dec 2023 01:59:08 -0800 (PST)
Received: from gmail.com (84-236-112-232.pool.digikabel.hu. [84.236.112.232])
        by smtp.gmail.com with ESMTPSA id c3-20020adffb43000000b00336673a4153sm8317365wrs.80.2023.12.20.01.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 01:59:07 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 20 Dec 2023 10:59:05 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Vegard Nossum <vegard.nossum@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Brian Gerst <brgerst@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/5] replace magic numbers in GDT descriptors
Message-ID: <ZYK66eEcRgdPOeWa@gmail.com>
References: <20231219151200.2878271-1-vegard.nossum@oracle.com>
 <CAHk-=wgSjQvgXbYkqJuOhL337cESfb-z65889D+-Rc6o5euYwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgSjQvgXbYkqJuOhL337cESfb-z65889D+-Rc6o5euYwQ@mail.gmail.com>


* Linus Torvalds <torvalds@linuxfoundation.org> wrote:

> On Tue, 19 Dec 2023 at 07:12, Vegard Nossum <vegard.nossum@oracle.com> wrote:
> >
> > Vegard Nossum (5):
> >   x86: provide new infrastructure for GDT descriptors
> >   x86: replace magic numbers in GDT descriptors, part 1
> >   x86: replace magic numbers in GDT descriptors, part 2
> >   x86: always set A (accessed) flag in GDT descriptors
> >   x86: add DB flag to 32-bit percpu GDT entry
> 
> All these patches look fine to me, but I will again leave it to the
> x86 maintainers whether they want to apply them. But feel free to add
> my Ack if y ou do.

Thanks - I've applied your acks. These are obviously useful cleanups,
so no objections whatsoever.

> The end result does look a *lot* more legible, with something like
> 
>    DESC_DATA64 | DESC_USER
> 
> instead of just a raw number like 0xc0f3.
>
> So while this is unlikely to be a maintenance burden (since we look at
> these things so seldom, and they never really change), I think it's a
> nice readability improvement.

Yeah, absolutely.

> The fact that Vegard found two oddities while doing this series just
> reinforces that readability issue. Neither of them were bugs, but they
> were odd inconsistencies.

Indeed ...

Thanks,

	Ingo

