Return-Path: <linux-kernel+bounces-129167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C93789665C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4871C2260D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D78F5B5A6;
	Wed,  3 Apr 2024 07:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zxih+029"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0095C54BF9;
	Wed,  3 Apr 2024 07:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129210; cv=none; b=kintW5nLGisJ3E4Se5SUmWE/KO29WO09E2FfAdR3IYMSKS4vyyqWDvZKDqIVlvzCGrxGSnhDhi6sKD/djzs2yag5zP/FVDiSmKStLvTYysdQZUVX6bUbu4va0r4+/YA1IE9piu3UyOolQRfpB/ijtG+9Q02qrcFOI3IID+ekbKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129210; c=relaxed/simple;
	bh=h73eG0u0YShaUH2j9win7hL7ENNiYpL6Iy/Qlt7wZHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=in7JMEd2Uvzk/9Za7oHwsnh8Emk3c0v1ZbTnVsJHJYG1bAmqjSI5xKlmBvSxjrKZx0wAtZeq1NgUZ6b+Y6ZiLAO+Gt4KmqjEd9JuW6UoUlPjCup777+vjx3ZVRy4Mlkx8SvtpvnM1/7btEbuWyseU+VB7Io37o0Kh7I3EkxFrBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zxih+029; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e030624d1so960471a12.2;
        Wed, 03 Apr 2024 00:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712129207; x=1712734007; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y8gbtEBqWb/AkwR61G4KI9Q1rpsfxIg0StBFMmMIVEI=;
        b=Zxih+029g7c7ZoJw78bRhRwSjA+wqklDZqYc+MwVNcq4lnEr8Wg6UjOeHwDugzB5TF
         c9AH9sSbdJ7sg8EuBe0hJGjLZhj4FZOBmK/ReY4Q+YQZnSmDCpo5BmK3nN8R6a0jYFhT
         MldKZYe3zK6IH7UK7bN7nRxljCWx3Y2q7fZ1YrSry2JpCy314XjvUNx+8Llmd2afmexE
         z7+KUIn3iIFXeVL4f2aZ7qyQ0boEtx7N+wdvcZ6jWs+mN/TKbigOKrqv6BMyRR6M3Adn
         TiW+Wy0hEW6vZ48fiu6yUpOiiutSMFW88a3FdDU49PQ+/3skWQWyex74XUsCKfPgsnt1
         G6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712129207; x=1712734007;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8gbtEBqWb/AkwR61G4KI9Q1rpsfxIg0StBFMmMIVEI=;
        b=EzUmEgAwBlbw/7d8iOSIFSsWSGdpYin3AxRrOMeDMk9hZjVVmEHzM1y1Z6RlSfDq2D
         rQbV1ime+GNfEQX7Dzs+NR8S6ZehvOggXbmvWGqCDsFeo3pNC5VIxk9woovj1gehQuOw
         8qCyGC2YdJ544BvPnnRcowOqE6rTv0HH80Q3yFKNPuF/XUuhZ6N/uJOSe5UNPVcCdfPX
         xKjyxJ2Ih2gn45L2RmbxchCFb+BUEr3/WR682U2bfBj7EKBXCamyu6OOkyioQqOVlI85
         dMK2b+3nq1cDKf5Y6Ze+dzKYMkcA++y87796Efh7mkqJvC4c/KXbbYaLNousgi7ADcHX
         dmfA==
X-Forwarded-Encrypted: i=1; AJvYcCV7KBYnysRfcPEatrtY81t/eCn6+IBgmk1P5S6h2N/61wyK7YHlSu+y7kpTPiQqqFavpULHuotZ58TztK58FQpKOmnUet9U92IgTjgprBQRJcqqDLH5DeNRPS617NqbzdisEkHryNJRJfjdKMKDc58vokvcQUTldDwC
X-Gm-Message-State: AOJu0YyWk0UsgehmIlTMK7cJAHl5jeGoFNnUzFaCB19ANKCjFWsXDn6P
	TI2cvbhusWhJO8d3B9srPMnSWKhU89Z0KbnN6OLLVmrGk629kpyeu+iCeXby88Q=
X-Google-Smtp-Source: AGHT+IFks+nIAsP739PPBv3VJz+PZVgG1YU/0oeyvSk5uzthzR4qBmu3iWi8OIBxQZkac7yJC3wANw==
X-Received: by 2002:a50:d48d:0:b0:567:824:e36c with SMTP id s13-20020a50d48d000000b005670824e36cmr9866650edi.14.1712129206838;
        Wed, 03 Apr 2024 00:26:46 -0700 (PDT)
Received: from gmail.com (84-236-113-97.pool.digikabel.hu. [84.236.113.97])
        by smtp.gmail.com with ESMTPSA id a17-20020a05640233d100b0056ded9bc62esm1515843edc.43.2024.04.03.00.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 00:26:46 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 3 Apr 2024 09:26:44 +0200
From: Ingo Molnar <mingo@kernel.org>
To: patchwork-bot+netdevbpf@kernel.org, ast@kernel.org,
	daniel@iogearbox.net
Cc: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH RESEND bpf v2 0/2] x86/bpf: Fixes for the BPF JIT with
 retbleed=stuff
Message-ID: <Zg0EtEkIIA45cuPT@gmail.com>
References: <20240401185821.224068-1-ubizjak@gmail.com>
 <171203102833.24910.7566029980709800852.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <171203102833.24910.7566029980709800852.git-patchwork-notify@kernel.org>


* patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org> wrote:

> Hello:
> 
> This series was applied to bpf/bpf.git (master)
> by Alexei Starovoitov <ast@kernel.org>:
> 
> On Mon,  1 Apr 2024 20:55:28 +0200 you wrote:
> > From: Joan Bruguera Micó <joanbrugueram@gmail.com>
> > 
> > Fixes two issues that cause kernels panic when using the BPF JIT with
> > the call depth tracking / stuffing mitigation for Skylake processors
> > (`retbleed=stuff`). Both issues can be triggered by running simple
> > BPF programs (e.g. running the test suite should trigger both).
> > 
> > [...]
> 
> Here is the summary with links:
>   - [RESEND,bpf,v2,1/2] x86/bpf: Fix IP after emitting call depth accounting
>     https://git.kernel.org/bpf/bpf/c/9d98aa088386
>   - [RESEND,bpf,v2,2/2] x86/bpf: Fix IP for relocating call depth accounting
>     https://git.kernel.org/bpf/bpf/c/6a537453000a

Just wondering, which kernel version is this targeted for?

The bug is upstream as well, so a fix needs to be sent to Linus.

I can pick all of this up into tip:x86/urgent, if that accelerates 
things.

Thanks,

	Ingo

