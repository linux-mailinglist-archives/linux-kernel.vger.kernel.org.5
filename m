Return-Path: <linux-kernel+bounces-103457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDA087BF96
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FEDBB22A6B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D89C71759;
	Thu, 14 Mar 2024 15:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R4+AFf5j"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A9A7175F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710428865; cv=none; b=pU8kmqVk21IYYAqef7pQ8ktjWFNd6rKAjIfmi61QCS9nhfvwUfpoBjqLRzA6RIHvYQPz6dK+ggSShXO3lORz4FFBHWrpJ2GlgcICakcqB2N824CfxQBhpEjsR6LasGUw4GO5LCz5mvMCp+nfyD0y0C6wXlsL38b6RAGYQvhpg8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710428865; c=relaxed/simple;
	bh=WEbP5Ymsm7CA0K1XA6T79HjuqaRrt4H8r8f4yaqRpoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPdZ0KTk6vkc1cyQJ5fVOzcaX8l2YV58n0eVBynBAsTEC7LUnWeRhkI/aEldd7kqNWQKjhF1SoJWcnxBdnsIr0UodFFIHI/I3pmt8kHc9cnqxciPEab/PWJFNO+tgVivkQdWTsQsuJ1pwuySfq4W0VPLyRaeaIC7zL8cLrYT6eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R4+AFf5j; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso726729a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 08:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710428863; x=1711033663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjRCEDVOogXes/wPEF8GeSg53i9dySi15L5A1nUD1OU=;
        b=R4+AFf5jEkmFwdD8bhrVomZt2cQtvJl/r8QWm1ww5Hb2AdKu7ze2Rep4xTOXMe8Rjr
         wjBa5qnc0EKioSXgXI0gmR47TbaAPSOjChgTLgzDMFIyvUbRlXUybb3ivGWw4iiVBzL4
         nPB+Kr/NXMQr2Vj7vBk+p2CS73SVbtTp5dHcf1uqWWhJYMCMmG2xgtVf/bkfFBiSkeDE
         5iyV9YuMUgaBZv+dR28g7fxob3ZlW7cOXxdblRhtKL3sI2lGbQzVP+A8RPXYL+YeMO/8
         rMc8FP3TyV/VU4yif8YnZohhKXc8AAlhT4yf7MgTDd4TA9LpS6KrzUU+u2x9TXQz0N5F
         /e7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710428863; x=1711033663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZjRCEDVOogXes/wPEF8GeSg53i9dySi15L5A1nUD1OU=;
        b=nsfUzaXOEl65kmnp6PM/I4hnpzC0euHzeHtG+E6MR5+8tm8wclEnEcxrzkORIhoVM7
         rEAIpYg52gK8K2q33U+eRIegv5+HIzGFKQU+Jn5GZ7uMtFvWjqAGO12nGMnUFqfhXI92
         XWIHBjlT+kv3XartvpeUZYCMSo0A5uhvOhIm5KGn3vNR8F4AsiCi18XD/JWItXLTrtxv
         Hq36AYUim8ivPBr6H9Db0hn/rOpcWAITKM6u51aJdh19vh8TvbArq2FEk4zokJVsdMtk
         YQAixbwmHXGrY8pvt/zWXdGfsVQ7YL47PSC+rm1e707aST1xDZ0R1shEg8DOtrPWtO+8
         OGgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp/DB0KaUhYQpPRLADKIVOMug9VWUOKktRNNItyugwQ9ZWLul+Pvt9OZsunIbvEm0Xe1w0fonrxCluIrWrBGeP+S4JBkKk5LKfllKe
X-Gm-Message-State: AOJu0YwsHwLcTUfu+xYdue3AFqWPq2/coebpVQYuNVZQE/Vc3hKIudXf
	ri+pKVfIwYv4L+8vPp3Sbjz1Pn3mJMQEGo+EdA3kQOxoCZk3b6lvQdELp2Qt9JA/3r4bPLFoNTS
	RzVpgZyrnFQvvBq4fSiUwZ3FnUiCW0bPmpcNA3g==
X-Google-Smtp-Source: AGHT+IFfiCFmv5DO0fVAcW+XIGXqdd9BcRmLG42EBJ+JcxMqvWXG3eAjxhCOv86M02IS4N2NO9e5fGuQIW9FlHgnXTg=
X-Received: by 2002:a17:90a:6446:b0:29b:b28d:ac66 with SMTP id
 y6-20020a17090a644600b0029bb28dac66mr273173pjm.5.1710428863429; Thu, 14 Mar
 2024 08:07:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313164640.616049-1-sashal@kernel.org> <ZfKhPaFngJTrTJyt@codewreck.org>
In-Reply-To: <ZfKhPaFngJTrTJyt@codewreck.org>
From: =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date: Thu, 14 Mar 2024 09:07:32 -0600
Message-ID: <CAEUSe78qxBXpkKBv73w94g=ShBO8TteNvHds1NwMnfG98zZPUg@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/73] 5.10.213-rc1 review
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

On Thu, 14 Mar 2024 at 01:03, Dominique Martinet <asmadeus@codewreck.org> w=
rote:
> Sasha Levin wrote on Wed, Mar 13, 2024 at 12:45:27PM -0400:
> > This is the start of the stable review cycle for the 5.10.213 release.
> > There are 73 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
>
> Thanks Sasha for submitting a stable rc review!
>
> If it's not too much trouble, would it be possible to have a different
> header in the 00 patch from the other patches for my mailbox?
> The mails Greg sends have the X-KernelTest-* headers (patch, tree,
> branch etc) only in the cover letter, while all the patches themselves
> only have 'X-stable: review' and 'X-Patchwork-Hint: ignore'
>
> I don't really care much what actual tags are on which as long as
> there's a way to differentiate that cover letter from the rest so I can
> redirect it to a mailbox I actually read to notice there's a new rc to
> test, without having all the patches unless I explicitly look for them.

I subscribe to this request. We ran into unexpected issues because all
the emails in the series included the same headers as the cover.

> If it's difficult I'll add a regex on the subject for ' 00/' or
> something, I'd prefer matching only headers for robustness but just let
> me know.

That's what I ended up doing, and you know the saying: I had this
problem and solved it via regexes, now I have two problems. :) FWIW,
here's my "problem":
  '^Subject: \[PATCH\ [456]\.[0-9]+\ 0[0]*\/'

Greetings!


Daniel D=C3=ADaz
daniel.diaz@linaro.org

