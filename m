Return-Path: <linux-kernel+bounces-48722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8480846041
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D45E1F29651
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3343F85273;
	Thu,  1 Feb 2024 18:46:23 +0000 (UTC)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED4D84FAC;
	Thu,  1 Feb 2024 18:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706813182; cv=none; b=WA74Pklm5xfkA7YPlVzHjLxc0Y83nut66XjZNJcKBD4M6p1bTx5hHkR3JoncyhMJrfd0h+scpuvXjJMR4aPfvXX0GaV8MVbv4vqK8QPZS8sesGfHqwJCF5NUx36Pe4ZHUJuO9L9WEvr5v7ZtwoszTwRamDgSNIPV5m0L1yzPwIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706813182; c=relaxed/simple;
	bh=XATJrDcd7SpBXLC2gpMmBcoK6M9MdOGe3Y5C4kZ4AE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhBJmI/JvnNT48y/T1BlzgLzEjtg6+20GlCWeU9VMZXvVVybO4SI+ZdNpfp+hrF3YCkEZTdeiiXb9flC1UDWpigiB5IWL256i77kilAcn4qbyG5BK5M0hOoVR7lOu9bkcKgFdQd5uL/h7gmio+z0VdBleVkMI0uUh7UnLA9hRXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d07d74be60so8776141fa.3;
        Thu, 01 Feb 2024 10:46:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706813171; x=1707417971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnKEQYAwVjHhwhMt8RVl48Tq+oG5X4rGefH36qj4+30=;
        b=VKUrMvDjinYOEH+NN+boo+jzcvxIR6qT0743Y8pgwyTSuSJw8LVIXLuurWTncNVPfc
         H9cbPJXW33YXO+MEGDHFyVVF1vFVMXm/qoC2tmrWjJZ1s4hMkqlubJ8SC/Mm2L34tn/o
         17whtU7ZDhby0YcsQqdKu9fjk27uOgTql16TiOzVCCxz2836OymO0eCD9V+dUYECzn6m
         z2kQ7ARsNgHd9O7TqoZdeKZh4Mu0kzOlGpBj9XqC0/hsEXkDDuovWiZqZEz3SeaD3Dw0
         f5gipen+y5U5DD4JrCCMrv0xTu1r1q3xWM7E7DrpNPgXYLRjFr36QP+j3xCyHEDZiOra
         KDOQ==
X-Gm-Message-State: AOJu0Yyf4dfMUQdHArgu1jWmyjy7K3qNIp1sEzNJIlSOhCUffRwXbM0n
	8hJWnJYSJOauTGanWO+V8ZoaXTyT9L7zs2ydlmImXr/pWuBf9TvC
X-Google-Smtp-Source: AGHT+IGUOb8v+Ig7Od9IxkCpbqxjj5TbOoRub/tClngKSHVHzwe6n7iiM6jsvdbbhnmHeLM8NDnvUg==
X-Received: by 2002:a2e:9883:0:b0:2d0:5f57:7442 with SMTP id b3-20020a2e9883000000b002d05f577442mr4107110ljj.20.1706813171297;
        Thu, 01 Feb 2024 10:46:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUQXeG9ignhIa/6rMaWpngmwJquYP/kdn9UKb7OB8DENTjGIfJrjk2mYMFMmD7W4A/2GDd7+jvbsL/YbS1KRGEQL8aYvOqbTYBRHcMy1L/GTpmfGB1sdjXHFTy1X53WMJ8B6jO233uS90pNCYtqCEfdAoyA6aIelhLHDDNqPRaRyy22Syd3moGTYh+1l7ruVHNxXPcB3YnmaPwNmtba0Y958Mntr2titT1bWMIw6PLEhZ39s+g8pPA9zeG0R15xh0YmeRQq0m2Kt40HdtbXcLbYxks7K0yg5wflUbuHWvbvkIEKt+pzhl0rB4ex+3Jm9gbEHxmbG9t8VV3uwab3
Received: from gmail.com (fwdproxy-cln-119.fbsv.net. [2a03:2880:31ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id cb23-20020a0564020b7700b00558a3268bbcsm77247edb.53.2024.02.01.10.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 10:46:10 -0800 (PST)
Date: Thu, 1 Feb 2024 10:46:08 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Mahesh Bandewar <maheshb@google.com>, weiwan@google.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	horms@kernel.org, andrew@lunn.ch, leit@fb.com
Subject: Re: [PATCH] blackhole_dev: Fix buil warning
Message-ID: <Zbvm8HhzdHGXzlus@gmail.com>
References: <20240201133238.3089363-1-leitao@debian.org>
 <20240201085509.40a0bb76@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201085509.40a0bb76@kernel.org>

On Thu, Feb 01, 2024 at 08:55:09AM -0800, Jakub Kicinski wrote:
> On Thu,  1 Feb 2024 05:32:37 -0800 Breno Leitao wrote:
> > Subject: [PATCH] blackhole_dev: Fix buil warning
> 
> Since Jiri suggested a title fix I reckon we should be a bit more
> specific, still. Imagine this title ending up in a quote or a Fixes
> tag, could be many things.. How about:
> 
>   net: blackhole_dev: fix build warning for ethh set but not used

Sure, let me resend it.

I suppose I should recent to `net` given it is a building warning,
right?

