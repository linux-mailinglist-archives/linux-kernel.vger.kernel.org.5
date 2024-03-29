Return-Path: <linux-kernel+bounces-124320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D878915A3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58FAD1F22C31
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6B53B290;
	Fri, 29 Mar 2024 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/Nw9UWN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10DE3FB2A;
	Fri, 29 Mar 2024 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703969; cv=none; b=qfZpYhJB4hsQrTO3aYPY6sXM/bz1v2hv0D29g3SdTsT8lKfiobc15sMKtxafzpF/K4BDBfsXLR42rA5te2loEHsWxf6505/OxGpFLX5VKViNhVhgpsk88ZNuVZE5tZ9Z/QmwNpBTC+KTPPCF2f+mwxoYgiqIdpo3zHy/UzAocG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703969; c=relaxed/simple;
	bh=xnQ28nT/HPo9EjDB6uMDEc6rA+VfMKivA9z5SN5805Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k2SM/EbnOBwD0LgZccH+V1NXwBeZSxoUxTT8dJ4Pt4cPcUT5pqZWk9bjy/A/y/ue05RVfaOrc+3o5d2hlri9OyNvdeNIg9TGu/yIfSfmLBgetnsCwbW0Jmbt1qodjoXNF489A+8tRrU+cRMKbaba+5ET0OySjAFFCgIpO14VpAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/Nw9UWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62266C433C7;
	Fri, 29 Mar 2024 09:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711703969;
	bh=xnQ28nT/HPo9EjDB6uMDEc6rA+VfMKivA9z5SN5805Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=o/Nw9UWNY6Bt7GpBSTI6vY2B/lrN22ojZ9RgSWQsuIWceZcA9/gyPL9WTCfD9e2xM
	 dJrEgxUXQv7bW2R9r7H7I+iOshE4PtdDTimOCJH2jHz0IkNuTKI1C1cukivOf+FErA
	 1sZnclAoRHGkVC5L5fzg6uFUPZ5VIY+zswdUULuQR3XSsZGU0eQu+lnzYC3kTP9oim
	 22uLnUobGIYtbnaV9tqPyTHznk65LP0h9tpPk96YPleOca5qkbvbKafCIJRbR4R47s
	 b5UOKFmu6nHLJ1laBi8BsCDGrsUWZ3HbY9MOACXr3r29kn6xNzm0v4Zli2bb09wk3q
	 x1mZixGFb2Y/A==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-515d30f6ee8so133551e87.2;
        Fri, 29 Mar 2024 02:19:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkFIPelV5CDtuEL9GzSuU6pvviXxgGWWviDdjsA537+5v6Q1K6aK1CLcyeiJhcMxFscTSYYwRFiTg9p9u6AJ2i3ZdGjWae9+wemVrXwBij+LWkGuv4vU01sNW9lkNluh7+12Vv
X-Gm-Message-State: AOJu0Yy5P7wXlgbFuco4I1WYrJpIRTMwpklB5m/EN2yhNFrCHKeDyPo/
	gb8W5xbGGMgt9+t8XCPANtsHfOmJnH0Or7TrX0Ur+BFYZRbVkUFb4bmU1tkvAQ5qDb11F/pQlyZ
	s4FeuEIAHKrorUfngd1E3pzTocI8=
X-Google-Smtp-Source: AGHT+IEy7qrEN4qNx/lxd/wxw/PN561ajfXIK2EpJ2U8xF9soL2ICwxURoxnkj/H9ZhwdV67bnd8VW2yv6DnAQNP5gw=
X-Received: by 2002:a05:6512:2116:b0:513:de8d:203c with SMTP id
 q22-20020a056512211600b00513de8d203cmr1334181lfr.28.1711703967770; Fri, 29
 Mar 2024 02:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327120643.2824712-1-sashal@kernel.org> <CAMj1kXH8n4-8VHSVygUyEc4Zne-4gE0uijAkDe-Ufu6hUnFU+g@mail.gmail.com>
 <2024032902-moonlit-abridge-743e@gregkh>
In-Reply-To: <2024032902-moonlit-abridge-743e@gregkh>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 29 Mar 2024 11:19:16 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHxF-F75x-xC32O+Rtehoost_qfoHJrzkdj-GbqPSH-UQ@mail.gmail.com>
Message-ID: <CAMj1kXHxF-F75x-xC32O+Rtehoost_qfoHJrzkdj-GbqPSH-UQ@mail.gmail.com>
Subject: Re: FAILED: Patch "x86/efistub: Call mixed mode boot services on the
 firmware's stack" failed to apply to 6.8-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, stable@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Mar 2024 at 11:17, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Mar 27, 2024 at 03:46:53PM +0200, Ard Biesheuvel wrote:
> > On Wed, 27 Mar 2024 at 14:06, Sasha Levin <sashal@kernel.org> wrote:
> > >
> > > The patch below does not apply to the 6.8-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git commit
> > > id to <stable@vger.kernel.org>.
> > >
> >
> > This applies fine on top of 6.8.2, 6.7.11 and 6.6.23.
> >
> > On 6.1.83, it gave me a warning
> >
> >   Auto-merging arch/x86/boot/compressed/efi_mixed.S
> >
> > but the change still applied without problems.
> >
> > Not sure what is going on here .....
>
> Odd, it worked here forme, now queued up everywhere, sorry for the
> noise.
>

Thanks!

