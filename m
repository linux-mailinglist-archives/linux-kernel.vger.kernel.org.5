Return-Path: <linux-kernel+bounces-44020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C42E841C49
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EFB71C24D81
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7F05380F;
	Tue, 30 Jan 2024 07:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUcF3ZIo"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA0952F6F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 07:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706598193; cv=none; b=ANRRNjnswjq6KbS9zWs42AQCGeRHJ/2DYXWPDoWuVXeXITEh8y3QyURJZRROmiDFUtzCY4jJXCPxe+k4saRFYd3dZebxBTHEWH0s54pCgE5P7ax1LXDfJEwqSUmOczZzinLJikmVseCj2sBJoV1Pbb3OioceI0QaFraHOk2sLCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706598193; c=relaxed/simple;
	bh=Td4wMLwtaAM1BcTb9dHxlFHMFlK9bEegT/g6so9iTTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvWVpjkBfNnOHz872VZwQ4b1MyWAN7KsdvFOdMexptCYGbsb8bEV1ItWeGpeQ1S+347OeWNmOJNUcAnrf/Y5tU76f76+2IXOCSl7n9FoNIT2dh7UNEgSwOxo+ngRZ7TOq0BxJ1qflZ9190MQi+zYNmh9c3s+ZolMRAVTGVZVCSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUcF3ZIo; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e80046246so19227945e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 23:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706598190; x=1707202990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pTUETpTJenxWl+VtgzWBaNr9s4KsWn5wef5pbRbJgpM=;
        b=NUcF3ZIoFrGDdigwU6xbaALniYLAzFhBF757BadI2Kq2CCL3qfWAhZp3hPYs3JdvOp
         FnnSUkeefpeOJozE+dJ+KtsJJ78iXmvMeyNIf8qpNkc21zKw4QokPenweTU9t/mPDyx4
         mrB38Uq+Esgz+2N+M/zqkSG16NmaGgwVp1jLUPJ4AQB7FSbapNWPOQSk8uR/bxYD3udO
         de55tcep3aCQjlZF4C2VroIkUWus435Q4A6SnoEhW/QnDJLWDHFQqTcZNIrF4SMXPL8m
         xJOSSpglw6CQc20NMBBbjo65SQ6nqz4BYJmkejjEVWD82klcLtwk7PGoE0OvFTr5jRcS
         WTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706598190; x=1707202990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTUETpTJenxWl+VtgzWBaNr9s4KsWn5wef5pbRbJgpM=;
        b=BYmWpTfYaGkfs4CPIETT1a1Px3t6zWLZkM65sjUZYewVQnNWqOvk47u4VaKlobKZ88
         AyHW2kJsn0lB1jJCFVJn2fUdSKlfz4QoLgl5Rm9H6KDyMRpwTtC0a8weUvIfbIaj8MrR
         +ZmfM9eu/iBQDQCFdJtCIQri3wP2wT6jN3HwLCWS9NRryGnJ/a5BuMl/ZQDzeI7q0VGp
         NUayRKWiLtZVhk/MIISI5rSddYQRe93lRx+Tg8cGciv6sHt6f/CpFpCX3KVmY9kLKEY8
         Qw6T1DxC+dOb/rJmH9uFguAL2QmuH02p7XOdjf2vUNAg9Nr7xzAM8NlKs7ZfI+4b1WbX
         1tSA==
X-Gm-Message-State: AOJu0YxbGCiuyFLqzRfEk66QZU0VSHeN2sNhxjzxDfyVk1qF92alEPlW
	SpAh/kCvO0v0HlrLQE1SwhK5V5epzFPs30ztcECofYWQfGXZecdImpiroh/eOtk=
X-Google-Smtp-Source: AGHT+IHbCCX5DQ9Y2Dy7lH1GSPWxYoUn+4UQGO+6fgTIAYSzXOlfPa6yFbgtqHrSBqsTJXSwy4N8oQ==
X-Received: by 2002:a05:600c:4fd0:b0:40e:f972:9901 with SMTP id o16-20020a05600c4fd000b0040ef9729901mr643965wmq.4.1706598189546;
        Mon, 29 Jan 2024 23:03:09 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id n20-20020a05600c3b9400b0040eee852a3dsm8839236wms.10.2024.01.29.23.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 23:03:08 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 09541BE2DE0; Tue, 30 Jan 2024 08:03:08 +0100 (CET)
Date: Tue, 30 Jan 2024 08:03:07 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Patrice Duroux <patrice.duroux@gmail.com>,
	Lewis Huang <lewis.huang@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Phil Hsieh <phil.hsieh@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: Bug#1061449: linux-image-6.7-amd64: a boot message from amdgpu
Message-ID: <ZbifK8M99hTDIsD4@eldamar.lan>
References: <170612149675.7169.757906919183146487.reportbug@kos-moceratops.home>
 <ZbUB0YWxEET3Y0xA@eldamar.lan>
 <acf203a8-b612-437c-a464-228f45e1c694@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acf203a8-b612-437c-a464-228f45e1c694@leemhuis.info>

Hi,

[for this reply dropping the Debian bugreport to avoid later followups
sending the ack to the mailinglist and adding noise]

On Sun, Jan 28, 2024 at 11:44:59AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 27.01.24 14:14, Salvatore Bonaccorso wrote:
> >
> > In Debian (https://bugs.debian.org/1061449) we got the following
> > quotred report:
> > 
> > On Wed, Jan 24, 2024 at 07:38:16PM +0100, Patrice Duroux wrote:
> >>
> >> Giving a try to 6.7, here is a message extracted from dmesg:
> >> [    4.177226] ------------[ cut here ]------------
> >> [    4.177227] WARNING: CPU: 6 PID: 248 at
> >> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_factory.c:387
> >> construct_phy+0xb26/0xd60 [amdgpu]
> > [...]
> 
> Not my area of expertise, but looks a lot like a duplicate of
> https://gitlab.freedesktop.org/drm/amd/-/issues/3122#note_2252835
> 
> Mario (now CCed) already prepared a patch for that issue that seems to work.

#regzbot link: https://gitlab.freedesktop.org/drm/amd/-/issues/3122

Thanks. Indeed the reporter confirmed in
https://bugs.debian.org/1061449#55 that the patch fixes the issue.

So a duplicate of the above.

Regards,
Salvatore

