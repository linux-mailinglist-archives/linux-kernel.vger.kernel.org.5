Return-Path: <linux-kernel+bounces-129236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63701896775
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7DA28DB0E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40ACA6BFB1;
	Wed,  3 Apr 2024 08:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fx1B7Tgz"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D535D8F8;
	Wed,  3 Apr 2024 08:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131267; cv=none; b=GzmFwck2Akl9GRRerUIvleYOcM6Gl0hnWAWK7hmT3dU6ETn7IsoQGnHHaiaLu3inj3Sl1zUfOe7pEiRTF9OwZoKMl3vXI1FEYQc3VgbG5cvafGGCBk1wle+UigV2eO3SH5tTYZvBLDE/0e9y3hrfUwRNUriGgWg5srYSqAZB0Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131267; c=relaxed/simple;
	bh=cJcAJpx6/U4fGe6UrW8Oij8v4YtoM0KrbKYK6hRlneU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+SPcvKW0vBPyDOom7hpGa02dsK3/yeJc5P77IFNb05kIKoP5fUUJ7TuF8bWiRWxCuzVc62tYXsutDS50nnbn/gZhDdJ/UMKVCECWKfh5yD9zz+K8/AuHq3AgRPqrRer140NiWMcye9sJLABO1aAB2glt/DCDBr4yAV7/ELx5PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fx1B7Tgz; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a50f170b7e3so14159166b.2;
        Wed, 03 Apr 2024 01:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712131264; x=1712736064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8MYYggcS6KUwk5n5KG/N/LDbmJ5sO+bxi3rZhB8acTA=;
        b=Fx1B7TgzyM2aOvHY7EBKVmS6gFw3T/4U/MBRZMiwNpiBkplWOPzGjAOpKgsHiIr3o0
         N9dIv4re9DWR9TmU1UA0roPyLuXjoWsLADlZayiKkWEXlJPepBjcXHU6+82OZIiY+b1/
         rFtAkYu2Fx211HXFAnWgxTbQkCCOSc0OYya+Jtid5iHRUZFctprx7qQejM2CPdTMckzn
         hZ7XD26u5prSyIck0MI+g03iWai2KlF4WremrcivEWzZPRDMha5oVzGggBqL6Y0VhgWB
         9XpYM4dI9X6sv94XCSNxSqJGB/LrdQxGVff4jThJFPjOeTCvQ/B2xCOqzV2x0ZXrMUBA
         9eKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131264; x=1712736064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8MYYggcS6KUwk5n5KG/N/LDbmJ5sO+bxi3rZhB8acTA=;
        b=ReSDaD5N8B+TLTwW+0+vuySJ8d28SrLf3yR5v1GH4bEvH+9LRdaWvs3zHimuPnJcg8
         z0De7zAKA+tnFHtYF/X2GvcsowKMVlQW5ptf4E2R8QUiy+HoaV/q3x9UUKZaB/oPZA4o
         KX/cPOZ5GTrb0RrHN6jNd9NaVzKWlKN727LHtucLr5jsVVfvODXL3HDq9ykplYhfWSX4
         rgZyr40rTt3jZstb/BQ0aog0hU7lfDltfa7+Ta2PkVVmmAmNT11rvltTl4/li2/RZN7e
         8bjGXNTUvYueS0ZJ0p/6F0HixbtyKSdJELZhqyfVF7FiX+I4veAzxtHBX7o/SpGY5r9i
         hUfw==
X-Forwarded-Encrypted: i=1; AJvYcCVoIm3IaRgi/eRFfCltTsiYF4KCHVy+eEdSsFQDyEJkXLRQUAHskWkJuta1fuRCI7jkN7jyrEeaMt2Y5HrLaJm2D1GV6rNnqlhwZnS1VKu865Ourp1rMFJhtiHFngcOXO9Z+bZSOgKDf+hvq4V+7F/XW/4yFG3+8jUH
X-Gm-Message-State: AOJu0Yx0qotQEAxMtNOTRzSwgH6DrRkTf0McLzNOr2gDnxdY37nbuasX
	Q5ctLTrt5/RRqSyjsWbq0XgPGaSLvF08Iax+juyqfOsmnJk5OouDAEg7B/1Fdx4=
X-Google-Smtp-Source: AGHT+IFewrjCiKoQotcUUtUSLupnCkXt+4TTJNFHHlHxf83HmxaSkK409T0p9G657xFQ8y75v/pkXQ==
X-Received: by 2002:a17:906:a209:b0:a47:31db:d8ff with SMTP id r9-20020a170906a20900b00a4731dbd8ffmr8925994ejy.40.1712131264015;
        Wed, 03 Apr 2024 01:01:04 -0700 (PDT)
Received: from gmail.com (84-236-113-97.pool.digikabel.hu. [84.236.113.97])
        by smtp.gmail.com with ESMTPSA id i24-20020a1709063c5800b00a4a3600d2absm7534136ejg.172.2024.04.03.01.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:01:03 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 3 Apr 2024 10:01:01 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: patchwork-bot+netdevbpf@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, x86@kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND bpf v2 0/2] x86/bpf: Fixes for the BPF JIT with
 retbleed=stuff
Message-ID: <Zg0Mvb6kkHceEENb@gmail.com>
References: <20240401185821.224068-1-ubizjak@gmail.com>
 <171203102833.24910.7566029980709800852.git-patchwork-notify@kernel.org>
 <Zg0EtEkIIA45cuPT@gmail.com>
 <CAFULd4Z0RmiWu4Kf0YFBMqA7YFMd65f3J760Do8-h83zWCx9oA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFULd4Z0RmiWu4Kf0YFBMqA7YFMd65f3J760Do8-h83zWCx9oA@mail.gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> > > Here is the summary with links:
> > >   - [RESEND,bpf,v2,1/2] x86/bpf: Fix IP after emitting call depth accounting
> > >     https://git.kernel.org/bpf/bpf/c/9d98aa088386
> > >   - [RESEND,bpf,v2,2/2] x86/bpf: Fix IP for relocating call depth accounting
> > >     https://git.kernel.org/bpf/bpf/c/6a537453000a
> >
> > Just wondering, which kernel version is this targeted for?
> 
> The whole series is intended for the current mainline (v6.9), this is 
> why it is developed against the bpf (*not* bpf-next) branch.

I see - so bpf.git:master are current-mainline BPF fixes - that's perfect.

BTW., bpf-next is not a branch, but a separate Git tree. (Which is what 
confused me.)

Thanks,

	Ingo

