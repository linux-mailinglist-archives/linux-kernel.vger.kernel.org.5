Return-Path: <linux-kernel+bounces-75001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BC385E141
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FAE21F24CFA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E223D80BEB;
	Wed, 21 Feb 2024 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBL9BzIO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EA37FBBD
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529577; cv=none; b=ud6nGHrAyTVIjJF4Wq2HxXcdg2MVMF6Op2ZgrjzRgw1vt8dtJd6C2m0qG5p+bnvwHjH42x10kUapgMyVXKLhSkR948SnG5GEk80NQ9Mi/7QPju2oV3IN4iZm7wrFMl6A24PJUY3a21wkuJ/VQ7UWzaTmmQjaDL3EB7QDdZpeEfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529577; c=relaxed/simple;
	bh=SZ5oXc5KsO4JyGV5JCH+VaWP1R79qJcpalEIfQ+AjNk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=utXcwBJmxhU1hDT3MDaEJUo8p813zgTO5kTjE+TFtL5KYvpM/f276jwJKcM921xVbnSJzjFlmMati8xAUQxXLJnt1D57574JG+BUHNOlItTpf2/V0Uwb+HGl8uecpemnOwzYgoWy85gVg9qjK+p7vJ+uOW/Z8p6Z7sGiSEwPY/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBL9BzIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6712EC43394;
	Wed, 21 Feb 2024 15:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708529576;
	bh=SZ5oXc5KsO4JyGV5JCH+VaWP1R79qJcpalEIfQ+AjNk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sBL9BzIOkKacSqSZcSHOox2ACQDM8p2/p1RdDEA/ZrgxJLV+aM0KMVfq/nnkbZXqI
	 CPpo1V/PzcD7/oq8KpvD9nM4sNN1BAButWpZiKiZcvPHqBz94C6/ulHUW7YMUJY1dY
	 n/SieglbeUsT7PQOYcOG+L84Ar0I+RbMO4lpjMDPfrwbCMqc5vzn/RrF9A6oyOZwBa
	 It9cNKgBUUAwc9sidhRyc+ebQXfiSGeiIaoaH9a+lKGcdQ5hRp4X3UTVmCxwG5Ldiu
	 dBrUVBGW/xoi8murfEvIwe+DJnXKHQT3whSuFpQbC4jPGQgi62nlPBgeggrCozt5ey
	 H/UbGnd2E0vJQ==
From: Robert Foss <rfoss@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>, Hans Verkuil <hans.verkuil@cisco.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Andrzej Hajda <andrzej.hajda@intel.com>, Maxime Ripard <mripard@kernel.org>,
 Archit Taneja <architt@codeaurora.org>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Alvin Šipraga <alvin@pqrs.dk>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alvin Šipraga <alsi@bang-olufsen.dk>, dri-devel@lists.freedesktop.org,
 Mads Bligaard Nielsen <bli@bang-olufsen.dk>
In-Reply-To: <20240219-adv7511-cec-irq-crash-fix-v2-1-245e53c4b96f@bang-olufsen.dk>
References: <20240219-adv7511-cec-irq-crash-fix-v2-1-245e53c4b96f@bang-olufsen.dk>
Subject: Re: [PATCH v2] drm/bridge: adv7511: fix crash on irq during probe
Message-Id: <170852957313.2711855.7326941848429368841.b4-ty@kernel.org>
Date: Wed, 21 Feb 2024 16:32:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1

On Mon, 19 Feb 2024 21:21:47 +0100, Alvin Šipraga wrote:
> From: Mads Bligaard Nielsen <bli@bang-olufsen.dk>
> 
> Moved IRQ registration down to end of adv7511_probe().
> 
> If an IRQ already is pending during adv7511_probe
> (before adv7511_cec_init) then cec_received_msg_ts
> could crash using uninitialized data:
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: adv7511: fix crash on irq during probe
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=aeedaee5ef54



Rob


