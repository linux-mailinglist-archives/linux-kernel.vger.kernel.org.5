Return-Path: <linux-kernel+bounces-127394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF602894ABA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A5F2B23AB1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 05:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14623199B8;
	Tue,  2 Apr 2024 05:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GKQ2fQqV"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D6A18AE0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 05:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712034085; cv=none; b=UnLYW/8IR+SF+0G32RC7SYgXmSiQ1oJkZYfJ4ZpsBOHY56Ve7tBaYxyV8JK0WEiUO6/pyVkpcUtjkML6JTdl8myoOC2Iamj5tz+qYAG/UQgTVsx78vvgmmEofyAd7n6jNyWoHESyeZwt0fwkjj340Z/smjZCApjDgD5mtWETRL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712034085; c=relaxed/simple;
	bh=NlyBxPHAyNv7/T8iQ/z8RSMGympsoOOW1QAfZRFQQYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mbrVBMljrd9By557O0YFNWSnZhwK5wwiUSKd2xYqW1l8LUymmPPs1gNM5WwIbbKDQQ1MBQ+9b+ChuY2sWeIDAWZCRjtzZ8u95MJH95yjHm3b18Z54yKUAggJlR/ybB/VTAznOYseY7x4RxsMxW19O+d0GT5sDnzog1VfFmJMlTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GKQ2fQqV; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4d8881c4668so1450538e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 22:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712034083; x=1712638883; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1gSlS8fLmBzxegVrsxC5VK6VZWbcNLQNxJqECmZ5UM=;
        b=GKQ2fQqV2eSfPoBaW8hY1Sqrk08lLy85JT6OGGNhs7KxkFJ20EtcBM0FAYx/q7XNmm
         V8pAcO0kdGSE5yk1Kpw1gjJIELD7LO/5Cqc17zZgbKrhMAlM4PPhEasSyRPJJwrqIemi
         Ar5sF0Ux/1vXUUnsvWGWYVNpsrnUuuaqa7EWljbWCgRKCMGlejzZsMb4d5iRG9XPHmPE
         EHtKRyQi62w1xWlt1Ge4jPJfhsaubao+LYCCOftNgF7ENPiLZrXwqibmOkg71uzqjHaV
         XrcCO3hhxWRwux+eHF0CAZCQM9eZS8ZJB44yCmbSLSycYo9sGjawuOffFhgO4SEFMwE4
         XRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712034083; x=1712638883;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q1gSlS8fLmBzxegVrsxC5VK6VZWbcNLQNxJqECmZ5UM=;
        b=p4NLeEhsltC989I4IbzXBII/3n/Bj6U8hiTbOLPLfT04QiTDbrCuuFcvCWYH+pk+3e
         BcsNqsngJyzNmx6miYFqj/0CT8yKy9RkmbphrQbdvttRwi98GzokfxBH0oeHsOAbAWiV
         pMYKNa1uvWOffJKlSiJp0ZoxVwOJXr37NmHyjkNf4ahmMgeC3fBr92gBmWeA4WzWhkzi
         5M5F6Ny6QSmxxx6dI/eZ0BFc2GagddVyuFuk8ABy2HNdzTBSmeP7O3eygwWdj5e0KKx6
         YefhJLnmsvQUCTtumCEB40gArfNqYeU3jdku5wg6Z8s58lXLvl+1CPfhbaaNZjmdHU66
         P7Wg==
X-Forwarded-Encrypted: i=1; AJvYcCV3oc6AfyT6G6fuTQX2NUnpbvjgra8t6EU/8AOBo3ndhI4A+PP8fSNzLDmk+ZXsOi/KgUZAY2Xk2dS/JblWnzTUFf80ywbJy72Dz4QA
X-Gm-Message-State: AOJu0Yy3S06+S9fhFrwwqzEWUrYHrTZ8d8Hfyv9NBa05Qh4wj30zx5J7
	wO3Bq8WAEWak7w1Ai2uuDF30ECZuZBQGt+Rxnac9yXdSZoQeqil+73/i0Lo543sEzzJ3YTnePxz
	lQ/w2L9C2tRSdBwFuiyxdJcFQ0cdFqM5+Oh1DSQ==
X-Google-Smtp-Source: AGHT+IFbWd87Vw4lUKJrcGZtFq6L8tz7Pk5A3fnIVM0X6MCy+GrJJQRDnUgtXO3nhQHsmMS7Qn2OwbW+bWyfrDvPcd0=
X-Received: by 2002:a05:6122:a05:b0:4d8:787c:4a6c with SMTP id
 5-20020a0561220a0500b004d8787c4a6cmr9108749vkn.5.1712034082741; Mon, 01 Apr
 2024 22:01:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401152549.131030308@linuxfoundation.org> <CA+G9fYuHZ9TCsGYMuxisqSFVoJ3brQx4C5Xk7=FJ+23PHbhKWw@mail.gmail.com>
 <20240401205103.606cba95@kernel.org>
In-Reply-To: <20240401205103.606cba95@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 2 Apr 2024 10:31:11 +0530
Message-ID: <CA+G9fYu+U1kkxt+OGyg=qSr3PfZipuazaANNTdfKvdY_zQBxyg@mail.gmail.com>
Subject: Re: [PATCH 6.8 000/399] 6.8.3-rc1 review
To: Jakub Kicinski <kuba@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org, 
	Netdev <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Arnd Bergmann <arnd@arndb.de>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 09:21, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue, 2 Apr 2024 01:10:11 +0530 Naresh Kamboju wrote:
> > The following kernel BUG: unable to handle page fault for address and followed
> > by Kernel panic - not syncing: Fatal exception in interrupt noticed
> > on the qemu-i386 running  selftests: net: pmtu.sh test case and the kernel
> > built with kselftest merge net configs with clang.
> >
> > We are investigating this problem on qemu-i386.
>
> One-off or does it repro?

one-off.
I have tried reproducing this problem and no luck yet.

- Naresh

