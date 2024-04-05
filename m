Return-Path: <linux-kernel+bounces-133415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E5A89A368
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45471C225A9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8539C171645;
	Fri,  5 Apr 2024 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqwI3Dz3"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDF3171651;
	Fri,  5 Apr 2024 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712337445; cv=none; b=MbLJ5TNyPC+508f4olkOfoaO/g5crOXZ1Vruvc0xsP23Lsvlrg12LQsIJsdZmx/iA9OiwiSttdVdKfvdZw6ehDZhRHlKZf5R3OskiZqeSaibJ6ZkrjBXdBK7qBVvNbtW2bW+W8N8Oq/lRK44dVrH8mSa9+hM0coO+SMwl/WOOBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712337445; c=relaxed/simple;
	bh=amxGFfc8+ZOrhJviv2Fs2WijG2T/KaEioGbiNVQ7TXU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9IjWCShj//gCOcQIgRZpkFw9Mf+WHFUWKDblNQL/DjEldzpZ/XEIWmddx5BpVTDXWBHOiBR0kNBf8A/rweNwuTaF9ezqrvzZbcmty5JOxvXSTPxyD7NTTnf4iT/rPZV+BRwyC0dB+n4ZWDgH6RozjGDopsrbCMhMt1wOZs9Z/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqwI3Dz3; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516d1c8dc79so2044715e87.1;
        Fri, 05 Apr 2024 10:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712337442; x=1712942242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Pa45weZ9cXq2JEaWktSYETvsdwprSSGUKt900PcsRg=;
        b=jqwI3Dz3baeslMoyfIqgfJyxYaD0p66jKD4NqZobmtpo43+SuxECYGUWNsdBEHwpft
         oKeJHPHGULl9y6xGbtH892vID6rN6/2LIC9DMs5JmLS3c71psfc6IXcOOdJKGh+IA7IC
         BWSNpExUfYZ9N09wIvZrpIEV8PAdmdfhlyQpY/iRDU+b1BWNF2B3wcb2VXJDPWY9JWF5
         OUKFCmeo4BNpBqxwXT7172aX+1CKvpmvu+wHslY1+OdEtLTVJpVJs7anY+CJNqDFEudC
         X+EOpA5Aj6/AVimerEe5PHR/oWTXMR3q3yrqSnA+wODI+EmZVX2mUHdcCIYSas85NApU
         Hqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712337442; x=1712942242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Pa45weZ9cXq2JEaWktSYETvsdwprSSGUKt900PcsRg=;
        b=JiyUJYdGKr65mvaCBq1R2Raugm1+0kQBpaKPt2IHQPbu/bfS+GTui71bSYRhD5v45P
         ey0VBXS11X/N8SU6Amqo0DHYi1aMkJKU6qDPwoNIsULqOB+LUQi4LCVf14j+S8X6iciF
         dO7Wby44ZFC7AozG/beQHXOHuUpcQ+SYhRFwOPkUrsLApynyBtR40y6I6p2j7CP9Ed1N
         ioMdqeGT7DO0IOAz+kzqtfKQqsqpZZfUMO6ri1/h9kJysON2rUvmVTvRV6sH5sANqvwg
         TwEIckjQJX13tkHs1bX0KybZP5zPooNv9ksJgiK2EhbAcHW0ClPku5RwFELf2VTtHpvR
         O9mg==
X-Forwarded-Encrypted: i=1; AJvYcCXydAZv903HY5PJ38mBAiLMYxargcpwyeIT+U1FxKq1RAjz58HqJGXFGjAg22VHz1ryzmm6dCZTJ0q/QjKjpZU3ZnPdZLOkOklnBb8sOW8E4P2zGPU4WwPeRPxRFAgaqTf9euuSKZkePQ==
X-Gm-Message-State: AOJu0YzWPsGz/4rCEtGU7g5oXmc0d2qj2bKOvQBPbGOJ8CNP5X670CEl
	nJiRrwaVlLKKu0r86qyefzC+UfeCvGfYVV2cwmsaz42dylCc+47gyLj3VWtS
X-Google-Smtp-Source: AGHT+IGkR7WkSvWrgRCWgtzZ4OEI7sYoi8ZTd5cGSa/sWHGkAqL03SvSOutvZtgF70N2AnolLOTjFw==
X-Received: by 2002:a19:ca1e:0:b0:516:d15b:f123 with SMTP id a30-20020a19ca1e000000b00516d15bf123mr1453551lfg.6.1712337442007;
        Fri, 05 Apr 2024 10:17:22 -0700 (PDT)
Received: from pc636 (host-90-235-13-217.mobileonline.telia.com. [90.235.13.217])
        by smtp.gmail.com with ESMTPSA id r23-20020ac24d17000000b00516bddc80e3sm241036lfi.84.2024.04.05.10.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 10:17:21 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 5 Apr 2024 19:17:18 +0200
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the rcu tree
Message-ID: <ZhAyHqKwvLHaHDJv@pc636>
References: <20240404083923.358c23da@canb.auug.org.au>
 <Zg6Zs76UDYQsJTWM@pc636>
 <73bf08df-3edd-4948-bea1-3962063d673e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73bf08df-3edd-4948-bea1-3962063d673e@paulmck-laptop>

On Thu, Apr 04, 2024 at 07:35:31AM -0700, Paul E. McKenney wrote:
> On Thu, Apr 04, 2024 at 02:14:43PM +0200, Uladzislau Rezki wrote:
> > Hello!
> > 
> > > Hi all,
> > > 
> > > In commit
> > > 
> > >   a55be9aacc45 ("rcu: Do not release a wait-head from a GP kthread")
> > > 
> > > Fixes tag
> > > 
> > >   Fixes: 05a10b921000 ("rcu: Support direct wake-up of synchronize_rcu() users")
> > > 
> > > has these problem(s):
> > > 
> > >   - Target SHA1 does not exist
> > > 
> > > Maybe you meant
> > > 
> > > Fixes: 654f59c6bc95 ("rcu: Support direct wake-up of synchronize_rcu() users")
> > > 
> > I have a question. Could you please clarify why those commits are in the linux-next?
> > Those commits have to go over RCU tree. It looks like i am missing something but
> > please elaborate.
> 
> Stephen pulls the -rcu "rcu/next" tag into -next, and does similarly for
> a large number of other trees.  This serves to pre-test the commits that
> are likely to show up in the upcoming merge window.  The pre-testing
> includes the build testing that Stephen does directly and additional
> testing that others do on the -next tree (for example, I occasionally
> run rcutorture on it).
> 
> So these commits are in -next because I told Stephen to include them.
> 
> But if you would like, I would be happy to pull your series out of the
> portion covered by rcu/next for the time being.
> 
Thanks for such information!

--
Uladzislau Rezki

