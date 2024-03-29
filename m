Return-Path: <linux-kernel+bounces-125282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D692D892361
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1422A1C21603
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8C239FEB;
	Fri, 29 Mar 2024 18:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDAn6yTd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C73D2C197;
	Fri, 29 Mar 2024 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711737147; cv=none; b=J7jpvjXZ5QeCwkwjE2OOmBrIhQgaFIwhZbVY8/2/SiOiDUkOMhu9q0l3Og78nCTEpYlG2sn+Evh0/shdtfmcXQMeCXmXXSlsfLw5+3K1ZO+f3zqhSp32QmbL1JTCkP4MK9ofrr04HFrfGtwsuijjevz0FaUQOM4sF0FcJivGPTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711737147; c=relaxed/simple;
	bh=XiCSiQc4axHagATwzFvkJKiM9R/1a6wOPfd4GEqTYys=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=g1OLPnBIvHpmXgz7ZOd+UEd3wwoFxO9QFZRNxzuPn6l8j3ZVSQ+ZUOUF1/R08oxpW4stGQZkuw328KH5yD+cHjfoeHrVD9NHhfX6fopHcQnlZt1ohVyTVFQAt0c8LA6Avh8eKbutazuBi4AMyW/XVoygffkDUdFuxXeyDCCanNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDAn6yTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05861C433F1;
	Fri, 29 Mar 2024 18:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711737147;
	bh=XiCSiQc4axHagATwzFvkJKiM9R/1a6wOPfd4GEqTYys=;
	h=From:Date:Subject:To:Cc:From;
	b=pDAn6yTdVnc8GzZ+EackDsBtM2S96ZZ1TnmlXmhivKXVcRHCWZUOXUV5UZA0JC1yw
	 rBHX3PHyqwEGDU88IIw59lDia7b1QJSU+W8h66icr8GrItq3s9lE45cGSpOLUjRxhs
	 aGAledhfp4FcEa8Myi4q2bN1M/w8ork6TPcUzfF4KUV4kgyIAd3zKSnELM9r07Fr7F
	 UxsbrCEpYuNYxYzwxbmn9SZptJ2lQtomxPK6hR6+OhOOafzfVevjAMVkRuH+P+51oO
	 RRQ2ZrUvhDp4hoLFLjacKWZYo3e35yGtCCMEXsW24FYKpN5U2cDBqMhLvnningOFcw
	 52CaBJkNi140g==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a536642635so377632eaf.0;
        Fri, 29 Mar 2024 11:32:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWvn+pfvwy1NaYw3QK5qNg7a/Wv1HA4tpvKIa8v+eAHYOpyX5klzJdKOLxw6EnnvsSpCAdkqbNiGXgVjr1FiHpYEaL5nprOkWaZuP3S
X-Gm-Message-State: AOJu0YxudT0qSH69bubVo29QuvDiX5Naiey43Hbxj1AJfkyTfG6Z1uAU
	flLCn5OhMsWSBJGNYNqYs86RkRVabCA1ygBV/3ikFogM7zttnd5L3eXbhZfErf8oP/gXmfjw3uO
	Q55QO7Ive61Um6+HbxTg0069Q/Xo=
X-Google-Smtp-Source: AGHT+IGUYMQBIXvIZxvjRX/Uy87LFYKzE/0lu2lV+Vhw/TK2opODhjLDTTKjrZTx0SoWqNVu1JnhU0o2oMWOrIpuYTI=
X-Received: by 2002:a05:6870:4592:b0:222:81cc:ac9c with SMTP id
 y18-20020a056870459200b0022281ccac9cmr2902706oao.5.1711737146341; Fri, 29 Mar
 2024 11:32:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 29 Mar 2024 19:32:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j1X_0bsF86xWxd=SCBNa1-tFxOErw3uKOVmBZLtUEv4A@mail.gmail.com>
Message-ID: <CAJZ5v0j1X_0bsF86xWxd=SCBNa1-tFxOErw3uKOVmBZLtUEv4A@mail.gmail.com>
Subject: [GIT PULL] Thermal control fixes for v6.9-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.9-rc2

with top-most commit a26de34b3c77ae3a969654d94be49e433c947e3b

 thermal: devfreq_cooling: Fix perf state when calculate dfc res_util

on top of commit 4cece764965020c22cff7665b18a012006359095

 Linux 6.9-rc1

to receive thermal control fixes for 6.9-rc2.

These revert a problematic optimization commit and address a devfreq
cooling device issue.

Specifics:

 - Revert thermal core optimization that introduced a functional issue
   causing a critical trip point to be crossed in some cases (Daniel
   Lezcano).

 - Add missing conversion between different state ranges to the
   devfreq cooling device driver (Ye Zhang).

Thanks!


---------------

Daniel Lezcano (1):
      Revert "thermal: core: Don't update trip points inside the
hysteresis range"

Ye Zhang (1):
      thermal: devfreq_cooling: Fix perf state when calculate dfc res_util

---------------

 drivers/thermal/devfreq_cooling.c |  2 +-
 drivers/thermal/thermal_trip.c    | 19 ++-----------------
 2 files changed, 3 insertions(+), 18 deletions(-)

