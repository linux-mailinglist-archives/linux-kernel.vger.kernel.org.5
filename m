Return-Path: <linux-kernel+bounces-49864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 764A68470A7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84B31C2402C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7365145BF6;
	Fri,  2 Feb 2024 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIgXy3Nn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5385187A;
	Fri,  2 Feb 2024 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706878235; cv=none; b=XVKBNYXhtX3O1Yf+sZXVBWEvrei+nVtUU5DgCgRXcxPTnMwo1/vlyg7HlOqb18pTo6diRcBpAuGtrnf84PhfKdyX+thyrgOmlF0KAYx7SDXj/3IZhNUUDN3fb922ZILFrEkFs1zxg+8Sqpf8IDf9+jIeXqJLssJZK3o7/sSVnK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706878235; c=relaxed/simple;
	bh=MUt23Gm5Um0r+18DNeEyeX8W05sw6uZOpoRJqsW7R90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8d7RyoktKdU5GYvit5tHT7CHpxwiOrEc76CxrC3pe7Cx0EIMIltU9n/wYuNe09JuDXcS7Wo5O1KPVqaw8yRVGFCjV60bdZ6bz4x+8HuOvOIYZp/nS28WhqK5A7+We/Pl9AXm0YNrTq3tzjY4nAG/ma+JoECptiCEcl8Ia+ri4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIgXy3Nn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6A6C433C7;
	Fri,  2 Feb 2024 12:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706878235;
	bh=MUt23Gm5Um0r+18DNeEyeX8W05sw6uZOpoRJqsW7R90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QIgXy3NnxiAX+gnaRoY9+y0udhw50VMCHCTHPdgN6J2Cvb54cc7g/v69t8XGeaC2d
	 y7jdZdk11r5bhsoaMgIB7TEv0PxaCZ+ddj16Vchx74WQ2KkLrv/FqhQmoYqX6et0xS
	 tzkNBu3x2/iH2gj+iL1HADLArAZ8rajTVeX59L+2TGjepa5ExyCtG/7y1ge+xUwbJ2
	 jG86xeaBZ5xlud5MTEsGk5Pwpg4RpHcGDv1sEJSVtkiH7VnEIvwReZfR64zeBZ832s
	 q3pbVEqV3NbxHjVYZiPzfitqGLRAUPm7cTVEpJdpvzf/HxLSxSxBZV0nFzXQo4qzv5
	 L7rwE1ODkONeQ==
Date: Fri, 2 Feb 2024 12:50:30 +0000
From: Lee Jones <lee@kernel.org>
To: =?utf-8?Q?=C5=81ukasz?= Majczak <lma@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Radoslaw Biernacki <biernacki@google.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: Re: [GIT PULL] Immutable branch between MFD, CROS and Watchdog due
 for the v6.9 merge window
Message-ID: <20240202125030.GF1379817@google.com>
References: <20240126095721.782782-1-lma@chromium.org>
 <20240201130605.GA1379817@google.com>
 <CAE5UKNqNR7869EqjNRdn_osnxLLtJma=eMmsYBE1fvzA0g_ybg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE5UKNqNR7869EqjNRdn_osnxLLtJma=eMmsYBE1fvzA0g_ybg@mail.gmail.com>

On Fri, 02 Feb 2024, Łukasz Majczak wrote:

> On Thu, Feb 1, 2024 at 2:06 PM Lee Jones <lee@kernel.org> wrote:
> >
> > Good afternoon,
> >
> > The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:
> >
> >   Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-cros-watchdog-v6.9
> >
> > for you to fetch changes up to 843dac4d3687f7628ba4f76e1481ee3838b27a35:
> >
> >   watchdog: Add ChromeOS EC-based watchdog driver (2024-02-01 11:49:30 +0000)
> >
> > ----------------------------------------------------------------
> > Immutable branch between MFD, CROS and Watchdog due for the v6.9 merge window
> >
> > ----------------------------------------------------------------
> > Lukasz Majczak (2):
> >       platform/chrome: Update binary interface for EC-based watchdog
> >       watchdog: Add ChromeOS EC-based watchdog driver
> >
> >  MAINTAINERS                                    |   6 +
> >  drivers/watchdog/Kconfig                       |  11 ++
> >  drivers/watchdog/Makefile                      |   1 +
> >  drivers/watchdog/cros_ec_wdt.c                 | 204 +++++++++++++++++++++++++
> >  include/linux/platform_data/cros_ec_commands.h |  78 +++++-----
> >  5 files changed, 257 insertions(+), 43 deletions(-)
> >  create mode 100644 drivers/watchdog/cros_ec_wdt.c
> >
> > --
> > Lee Jones [李琼斯]
> 
> Hi Lee,
> 
> I'm about to sent V5 of patches:
> * watchdog: Add ChromeOS EC-based watchdog driver
> * platform/chrome: Update binary interface for EC-based watchdog

These patches are applied, you cannot resend them.

If you need to make adjustments, please submit incremental changes.

> but I'm not sure how I should proceed - can I base those on the master
> branch or shall I rebase on top of  ib-mfd-cros-watchdog-v6.9?

Unless it causes issues, I tend to work on Linux next.

-- 
Lee Jones [李琼斯]

