Return-Path: <linux-kernel+bounces-140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7DF813CC1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749971F22436
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC8B6D1DE;
	Thu, 14 Dec 2023 21:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="C8nM4FWM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5746A35A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d08a924fcfso81913855ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 13:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1702589961; x=1703194761; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8bHZ5SA9qHU5iW2IiMJTN98KqOEtCR8q0Lin8U7ofHo=;
        b=C8nM4FWM7p4u9gjNcpxgQJjV14rJCrikNFCOKgXbcpFv1Mo9W5BRqUSb9E0yOS7u0i
         jMmTDciav+bYcZ+YD5Sydi8MKGCwCYJZHuv/WLjLYLxQJiSdhQtE1sPj+Z+6scr/cb4J
         WjbXghZd4oXAb9+Q7qpQziK+Kd6gFtug3h3WLC3upOr+gdDZiMl3yTIvrO49GQu4nwEN
         eA1rIByLIgVKPPaXGQPcAswk61nc8BzuztIAMnOf4SFQ/8dEucSDWcic0pOOO9T7x4Qa
         is6JAzwB7hprArE8dPntyprJwLPqOhk+w8INcLGatcamuyfbE8DnuRAOZKwkgw+yuQPt
         PC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702589961; x=1703194761;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8bHZ5SA9qHU5iW2IiMJTN98KqOEtCR8q0Lin8U7ofHo=;
        b=r+N+2/JXgAUkCQEylb5MlbtARVQczela6pwjCbxE4TH9DQOA3nOUrXZnDLlOyUijgI
         QkrJYEobNJo7JRYFVScWcbg3uonGD9DTXjuecPyEfS4UsNS2K1j9ZS2nPmSRrVmjbBqy
         M1Yjnm9BtM34RqkdZNE1aHt3M8GsHdMUw9un75OhdW5jj1JgS1pC6Y7b6fD/Kdn64b+h
         H6n5m4DFT5rtluHeHMLp9KqXAZcSPZgyROJ1csd+UQjtqkjYYsCzbnebGtDGqfnIjGuj
         7D80xgfN8w9aBRt/X6DrBR0DFijIkJvOtvIrbKZB/yL8UrtzIBPgHoKsOJS30n6Zca/s
         NtTQ==
X-Gm-Message-State: AOJu0Yw4gMwP5yjRLwmJrcgjnmxciNT0VyJ3v4xnFjpVrg55LYnezte7
	sSMbcxvU6/SlGjlUrKxHSLX7HRvdzDIXQ65DTzE=
X-Google-Smtp-Source: AGHT+IHDEMJ7nt1ExkPfj/pCDlsOnYTgc7QbKoGSYrQjqoZ/kKiNusLS3mdgocUbZzt4jcCErbnAzA==
X-Received: by 2002:a17:902:bd88:b0:1d0:4706:60fc with SMTP id q8-20020a170902bd8800b001d0470660fcmr9513414pls.17.1702589961391;
        Thu, 14 Dec 2023 13:39:21 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id g16-20020a1709029f9000b001d3561680aasm3191684plq.82.2023.12.14.13.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 13:39:20 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rDtQM-008Mua-16;
	Fri, 15 Dec 2023 08:39:18 +1100
Date: Fri, 15 Dec 2023 08:39:18 +1100
From: Dave Chinner <david@fromorbit.com>
To: Alexander Potapenko <glider@google.com>
Cc: Dave Chinner <dchinner@redhat.com>,
	syzbot+a6d6b8fffa294705dbd8@syzkaller.appspotmail.com, hch@lst.de,
	davem@davemloft.net, herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, linux-xfs@vger.kernel.org
Subject: Re: [syzbot] [crypto?] KMSAN: uninit-value in __crc32c_le_base (3)
Message-ID: <ZXt2BklghFSmDbhg@dread.disaster.area>
References: <000000000000f66a3005fa578223@google.com>
 <20231213104950.1587730-1-glider@google.com>
 <ZXofF2lXuIUvKi/c@rh>
 <ZXopGGh/YqNIdtMJ@dread.disaster.area>
 <CAG_fn=UukAf5sPrwqQtmL7-_dyUs3neBpa75JAaeACUzXsHwOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG_fn=UukAf5sPrwqQtmL7-_dyUs3neBpa75JAaeACUzXsHwOA@mail.gmail.com>

On Thu, Dec 14, 2023 at 03:55:00PM +0100, Alexander Potapenko wrote:
> On Wed, Dec 13, 2023 at 10:58 PM 'Dave Chinner' via syzkaller-bugs
> <syzkaller-bugs@googlegroups.com> wrote:
> >
> > On Thu, Dec 14, 2023 at 08:16:07AM +1100, Dave Chinner wrote:
> > > [cc linux-xfs@vger.kernel.org because that's where all questions
> > > about XFS stuff should be directed, not to random individual
> > > developers. ]
> > >
> > > On Wed, Dec 13, 2023 at 11:49:50AM +0100, Alexander Potapenko wrote:
> > > > Hi Christoph, Dave,
> > > >
> > > > The repro provided by Xingwei indeed works.
> >
> > Can you please test the patch below?
> 
> It fixed the problem for me, feel free to add:
> 
> Tested-by: Alexander Potapenko <glider@google.com>

Thanks.

> As for the time needed to detect the bug, note that kmemcheck was
> never used together with syzkaller, so it couldn't have the chance to
> find it.
>
> KMSAN found this bug in April
> (https://syzkaller.appspot.com/bug?extid=a6d6b8fffa294705dbd8),

KMSAN has been used for quite a long time with syzbot, however,
and it's supposed to find these problems, too. Yet it's only been
finding this for 6 months?

> only
> half a year after we started mounting XFS images on syzbot.

Really? Where did you get that from?  syzbot has been exercising XFS
filesystems since 2017 - the bug reports to the XFS list go back at
least that far.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

