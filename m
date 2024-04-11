Return-Path: <linux-kernel+bounces-140076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 247018A0B25
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8A511F23130
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24D213FD8C;
	Thu, 11 Apr 2024 08:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIwmkpeK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320BC1DDE9;
	Thu, 11 Apr 2024 08:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824036; cv=none; b=fwQ7wbR1QS3Q9SJiagwWYf4B+wz8PGs3Pi9sOo8mdHMrrz/v5vxjtSvHMoOkmpzOQvCsejDIQY8gFypSQ5rEvMTad9DjHwSv831hH5SVdy/HBAMdpM4ts9DBe25F9plmY3NP0tNUX6tF6QaThOBYlx3PUbh+NwAzQSlGr74KMmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824036; c=relaxed/simple;
	bh=VMUO6AMXMVsqgIqjVZgZBXBiEDcMtP9Oe9mg/oobPXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RT3Aas+MjFdQOXjCtuYgxf0V4NIHrU1hmMhjBVyK1Idy0rUyUUl/gmaM5ifA7yjKIr2XXg4KS6W+tDcXEd6hMcpHnB+PvO0jGMjlhewFfO8Z+ttAkEUWolxcKNude5DyYPTRR5fVl5QY6czU9/2S3sK8IYYQ3MZhoXu3pYsYNQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIwmkpeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86B5C433F1;
	Thu, 11 Apr 2024 08:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712824035;
	bh=VMUO6AMXMVsqgIqjVZgZBXBiEDcMtP9Oe9mg/oobPXQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dIwmkpeKIe0q3pu/9q9xha9+2F3jhvYAe6frodg+nYsYZR9w3dcCsivNFDwRdfcfP
	 rFXtnXXjGORHgV0IkkbqQhujoGdfST2cskNIzur4QJRNUvb3N0znbHS5WwH9mu1eUo
	 nTlBjsBnb1CXWn0TzVG/PsHmnNWpx4bZ6p8xe2xtlRC1mRmy6B1lx5Ad6DuKJI8rP4
	 uz0/QE//dOGFAM44jYtcC5pp9z9CXcgvfgKoviD35qme4MYpH3mPU1PDtOLMPtTwcm
	 A+t2jxWi9C4U1DSChlNPpAc7R+qqsRatBlPS0+oMMq2mtCGJXVcYCwyIiTa3yDgKdK
	 bSpNHi3Zkq4yQ==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d48d75ab70so103088301fa.0;
        Thu, 11 Apr 2024 01:27:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVU0+of1qNpG+a37hgQhtcb+sSDa+4o1btpmPDOKiDWj1UY58Yjc4xZxBZP07RlZGFFLawRdptNhvOX/vvVC9d2VoCWMRvcD+E7tXyQ53r5iIrMXpluS44RwqyvnSKLl2jqoDjh
X-Gm-Message-State: AOJu0YyVnrg1WosAg4M1MBhEYa9dxE0Wy5C61l6CV/yGOpk3tp4zNAPb
	ouFjWJhzLd6C/QZAQJ7dLC7q73cX6iijQVfdNqMFV7VlFf5UBDOm/lMWcvYYhGH9gVs6RQizkFa
	irmGI1xZkKrFsskmZDTeG2IGlnNs=
X-Google-Smtp-Source: AGHT+IE6Jig5oeL04Ih0wDkMGruvLCBbhVbwekOG/N1Wn4x19B/cJ/cmRCJzfm1GiXipeKhO2KtEAU/LKwGLMVfOZ4g=
X-Received: by 2002:a2e:9516:0:b0:2d8:59cb:89ef with SMTP id
 f22-20020a2e9516000000b002d859cb89efmr3147956ljh.24.1712824033916; Thu, 11
 Apr 2024 01:27:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3c6e6172-cf64-4230-bcc5-7682b4d64a8a@gmx.de> <4e2ff80c-9e3f-433e-8783-cb9729c30bb2@leemhuis.info>
In-Reply-To: <4e2ff80c-9e3f-433e-8783-cb9729c30bb2@leemhuis.info>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 11 Apr 2024 10:27:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHgvv0FYZXsFm8KisXuR6t47-nXtgOs0Gyva4MJEJ_4Ow@mail.gmail.com>
Message-ID: <CAMj1kXHgvv0FYZXsFm8KisXuR6t47-nXtgOs0Gyva4MJEJ_4Ow@mail.gmail.com>
Subject: Re: 6.8.5 does not boot (regression)
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>, 
	Linux Kernel <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Apr 2024 at 10:19, Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 11.04.24 09:20, Toralf F=C3=B6rster wrote:
> > It is a remote system, nothing in the logs, system is a hardened Gentoo
> > Linux, 6.8.4 was fine.
> >
> > Linux mr-fox 6.8.4 #4 SMP Thu Apr  4 22:10:47 UTC 2024 x86_64 AMD Ryzen
> > 9 5950X 16-Core Processor AuthenticAMD GNU/Linux
> >
> > Another Gentoo dev reported problems too.
> >
> > config is below.
>
> Thx for the report, but the harsh reality is: nearly no developer will
> see your initial report, as you just sent it to LKML, which nearly
> nobody ready. I CCed a few lists, which might help. But that is
> unlikely, as this could be cause by all sorts of changes. Which is why
> we likely need a bisection (
> https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.ht=
ml
> ) from somebody affected to make some progress here.
>
> That being said: there are a few EFI changes in there that in a case
> like this are a suspect. I CCed the developer, maybe something rings a be=
ll.
>

This is a known issue, and will be fixed in the next 6.8.y release.

In the mean time, you can apply

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3De7d24c0aa8e678f41457d1304e2091cac6fd1a2e

