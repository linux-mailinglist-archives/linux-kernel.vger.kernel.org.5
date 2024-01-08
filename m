Return-Path: <linux-kernel+bounces-19629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B433E827002
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D922C1C22920
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A7844C93;
	Mon,  8 Jan 2024 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUbD2bnm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFAF44C87
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3376d424a79so490806f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 05:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704721104; x=1705325904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZK2J7JQv1ZAdDNEh+92PGoAd4LmyCEettK2mxhPngK4=;
        b=QUbD2bnm5neSksk5lKQPFLhgZtCS1G+Xp6PsSGpyp0vactY+aH6j2oKNJ+7G3SMqY1
         prEifVRNAHoNdoS45xJ6Fqq1dbXqPEbBAB3WlIGVTimVet4lXpbDIhwv9HHXoSGFndyT
         CvRnT+yL0FOeRARM1pCZKWZGQJTIqtSALUG1wxTY5chdDTFzU6CpQNjs4p1B9OYdDfUy
         L2JlzyVRXwg9GFg1eOvBp1j5Xr+B6LLh7lJK2DddlkhAft04yDQZmeQ9XCJ6LhrHssn0
         xcR/LNfvvq2A566ZXuLNc8o4casEwR1uWTXMe9/nvzguTHxUc17GZX4tFeBK1xDwhyTw
         kegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704721104; x=1705325904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZK2J7JQv1ZAdDNEh+92PGoAd4LmyCEettK2mxhPngK4=;
        b=TsoVnZKWNaxyVEqepf1rlwcu6bSUwkeh/Co8IixfBgyJs7ArOnKG0/3cWEGh5joRzE
         KXPh42GHqzIT35kM4bZXaa/yijCEPENbJ2ly9y6AB++hIbXWcD7FRdqI+sU7TUGJudrC
         nCEpR276cZwwtBNttkD7d1xATBuRds0Y/unITxSMJGFNTQ4d+o/DfkQz5nrsrVpzJc5U
         noeJovwoyuuhckNNLJMGsjsWy9K5iV3PgZRA1Nrj1e25/0O3UUzkGU8+Vde30CVg+W7t
         QPHvfyEJUnH4yx8ZJI7itt6dGj/xxodE2ag8k3180O3u5yBRAD21Udyg3wWXs1rPsD5K
         NtRg==
X-Gm-Message-State: AOJu0Yxisj41zTgg1rRw+5jFHTeUxziv4PkbXP4vbe+Gs1NABBnHWfyb
	s8JMQZDnvgjk2qcIb2NuOAg=
X-Google-Smtp-Source: AGHT+IHKJi8PNbM7awjz8nccpNraSUGy9jGtjam7yUa+u7vu4K3tHYuUvXTtEmFKw6Gk1R65uXxUmw==
X-Received: by 2002:adf:e542:0:b0:336:68dd:c7e2 with SMTP id z2-20020adfe542000000b0033668ddc7e2mr1765269wrm.27.1704721104398;
        Mon, 08 Jan 2024 05:38:24 -0800 (PST)
Received: from andrea ([31.189.29.12])
        by smtp.gmail.com with ESMTPSA id b14-20020adff90e000000b003375c072fbcsm7131164wrr.100.2024.01.08.05.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 05:38:23 -0800 (PST)
Date: Mon, 8 Jan 2024 14:38:17 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Christoph =?iso-8859-1?Q?M=FCllner?= <christoph.muellner@vrull.eu>,
	Heiko Stuebner <heiko@sntech.de>, linux-riscv@lists.infradead.org,
	palmer@dabbelt.com, paul.walmsley@sifive.com,
	linux-kernel@vger.kernel.org, David.Laight@aculab.com,
	Conor Dooley <conor@kernel.org>
Subject: Re: Re: [PATCH v3 0/2] Add Zawrs support and use it for spinlocks
Message-ID: <ZZv6yR2sF3v78msA@andrea>
References: <20230521114715.955823-1-heiko.stuebner@vrull.eu>
 <ZTE7eUyrb8+J+ORB@andrea>
 <CAEg0e7jkTOn1pjO=+GaiCZJ9_Yd2NcB1GMG=Q6m3-r0+Q0OjGQ@mail.gmail.com>
 <ZTJUOji+B+dDbMKh@andrea>
 <20240108-a56ba0dfd1779e4ab6893d16@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108-a56ba0dfd1779e4ab6893d16@orel>

Hi Andrew,

> > > I can try to raise the priority on this here, but can't promise anything.
> > > For me it is also ok if you take over this patchset.
> > 
> > Thanks.  Either way works for me.  No urgency from my side.  I'd say - let us
> > leave this up to the community/other reviewers.  (IIUC, Palmer was recovering
> > from a certain flu and might need more time than usual to get back here.)
> >
> 
> Hi everyone,
> 
> I'm also interested in seeing this series resurrected and making progress
> again. I'd be happy to help out in any way. It's not clear to me if it has
> a current owner. If not, then I could start shepherding the patches with
> their authorships intact.

This sounds great to me - please do!

I don't have additional information to provide about this matter.

Thanks!
  Andrea

