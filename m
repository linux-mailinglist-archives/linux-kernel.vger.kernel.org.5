Return-Path: <linux-kernel+bounces-160957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8DE8B451D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 10:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55B3C1C21B0C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 08:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABC144C6F;
	Sat, 27 Apr 2024 08:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yOxCDpYc"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CA73C087
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 08:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714206094; cv=none; b=I6fKb3MdPQtqNLAqHTXzYbCiThJlHAoQfm6wORgrkyqo27RGycX2nZToZKClR6XubDnW2IJ+K/swN6ENy1wvZOtWVl6BIAwlS9EE99AAr1uy2hZE0fp9NSK1cQUmXyloiZxGMAZ6ICaa30whqSiSRC2AGiX4wPf7Xb3UYkOZtzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714206094; c=relaxed/simple;
	bh=Ej9iEcTeQmONNGUTtMUCi2YDLUx9RZ7O8vx1TcL+y1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aL3KC/lJFwPLK9lUnb38HJT+gX289Pjf1bcDMkQ0rSnOviBHwdnZYMAOkb3Sdcsw70GQEejoHXfqW6vae/kPgSRlmvJB6JahsKUEm2DiEn78E1TzP6WQsgNeufkmScuCv7t8sgk/FZW4bhaVOre2pFDoZDB2pJ82UfzubqqSEYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yOxCDpYc; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-de54b28c3b7so3315418276.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 01:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714206091; x=1714810891; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Loyri7BNKemKJvKnQBmqOrR6kXCmKWbyQbDcLqDVreY=;
        b=yOxCDpYc0TBkEzzM37hw8owm4VPlfXl0FAFmvNfQ9hsZ5BD8eRxXAGWEraAxqskYW0
         l6TphUFf94xujet/w5o52s5yQJTQQjrjiSJ1+rwgzV4TYKTFPww28MiMk3X0D5ZdWx82
         Q1/OnDSwl76Y3cv1CkS9RpEJDTjMk7QMOcAmW9RttmAdSFNyZviGn6DWJUnOmh6Sm5VW
         bI3joo7s3Rfte7SzlP8a/m8R89er7o0aalvrtAOgYBgulcwpPwOjh61sb9kGn+tIsRAq
         LLCuJuPB2WFt6IWQoX/1I+yKWg+Lpx1OI1r8kBkiOCcm5URFjajstdJDty4LFoQYHXmV
         0DjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714206091; x=1714810891;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Loyri7BNKemKJvKnQBmqOrR6kXCmKWbyQbDcLqDVreY=;
        b=dnNGPATqubO9336Mub+Ae6hBt3GMLTL5B+feGhx2mZVVTo1UDroOnbx7MT5YIEumN+
         OnKcyufRHz6/2yTh9gxg+HFWW3TuJD+LtOd+krGPjlxwjsnWeVFQUXgyBgCiMxNkja/+
         6/jLg3zAoSMrn1Onc6sZooIn34wFD80LqBHcK1fdF0UhA4DvRPXEc5U9ByTrw2V/M7QF
         Bn6csxfe35RWDUtiIDoYBXGTMja24zF5ePKMzIRYlGUGwLDHsb1uI4S1+bxUdUeNJbPQ
         t1sPgiPVXSNm9E58ocC1DQFoKwPNTJi3fz1y50f66bccLULQlJ0v/4CuuAVGb7lVl3Jf
         R0jw==
X-Forwarded-Encrypted: i=1; AJvYcCXvqIjaPQD0IVZfhjP3QCtFxWKeLoNHhOJHH7Zezmw+Ns5ouO/v3qi0J2CuMdkTdIu6+FFflhnQyDHa7R9r5TSag+qf9sf6lMZxUlQG
X-Gm-Message-State: AOJu0YwQZW3roi/+VCWqU81w5S+xvxk43Yz5D1dGIJ5vPRiwkiC7JDt4
	d841yl6AT4IsFXZmjAEilXjHrAaa8S+Oyu9vcugy/F9HZlWx3dDxFz8XyUe4XCApBhnGP8tahrE
	SF2monOHtfMSW3MTg3XqAaJaqjloERMb0En8bahh3gUE3/3eS
X-Google-Smtp-Source: AGHT+IEn3Ad/ZJHcs2toHD7qGUMCVU/CiYInlTR5yJQDnIsDt7VZa07LmAzWNkSAfs0Qmk/q6FvzgnJYlcv5baycPvY=
X-Received: by 2002:a25:aa11:0:b0:de5:526d:c9c9 with SMTP id
 s17-20020a25aa11000000b00de5526dc9c9mr4792443ybi.61.1714206091431; Sat, 27
 Apr 2024 01:21:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404270534.8VgyE2XE-lkp@intel.com> <20240427004819.GA24436@rigel>
In-Reply-To: <20240427004819.GA24436@rigel>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Sat, 27 Apr 2024 10:21:20 +0200
Message-ID: <CACMJSetLpWn5H+Dk9kip5oVu5gG8fKB=PPHDRz901-JeUV1LcQ@mail.gmail.com>
Subject: Re: WARNING: modpost: vmlinux: section mismatch in reference:
 ip_md_tunnel_xmit+0x9e (section: .text) -> .LBB102 (section: .init.text)
To: Kent Gibson <warthog618@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 27 Apr 2024 at 02:48, Kent Gibson <warthog618@gmail.com> wrote:
>
> On Sat, Apr 27, 2024 at 05:29:42AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   3022bf37da50ce0ee3ba443ec5f86fa8c28aacd0
> > commit: 83092341e15d0dfee1caa8dc502f66c815ccd78a gpio: cdev: fix missed label sanitizing in debounce_setup()
> > date:   3 weeks ago
> > config: riscv-randconfig-r021-20230409 (https://download.01.org/0day-ci/archive/20240427/202404270534.8VgyE2XE-lkp@intel.com/config)
> > compiler: riscv32-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240427/202404270534.8VgyE2XE-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202404270534.8VgyE2XE-lkp@intel.com/
> >
> > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> >
>
> Bart,
>
> does this make any sense to you, cos I'm not seeing any connection
> between that commit and these warnings?
>
> Cheers,
> Kent.
>

I think this is a false positive.

Bart

