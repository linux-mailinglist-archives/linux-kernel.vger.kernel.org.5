Return-Path: <linux-kernel+bounces-128800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C48895FBC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78731F25476
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01323446B4;
	Tue,  2 Apr 2024 22:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="SwvVNHVe"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8373A1CB
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 22:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712097829; cv=none; b=XJXdpF4mxW6DrnxBKE4oIHlxXdLQSw2Xp/4pwaCD0+faEXzXBV5D6rGDWjR68wq4xbwGsB0sokEF5e5QmhmsJi6bpRlcIOF0tMh1IdyJJDMtxTSChMT1Uckjk7P/76tGiXHm2bRHcPzl6ofvWfkTmb9ay6Xl4y+20sZHOCW4VEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712097829; c=relaxed/simple;
	bh=hPdgagz7v4SzJXkwGntJzlht9V/tU7oiKRHkBkLDJu4=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=CQ/fzBIr5XfO4GKgo7e6u69GZLMth4kTUwca8D3SOzmZ/ondY8d+Q7FZSm+rZLrOFK6nGq2coUM7p6ZD51zD9/1IVBi6gIBqCtzNC5LrRilyDqQajNn7HIbcXfarbAvaYfCwid7J2mwUY4lbBuDgqBmPeRoEoy6NL3nI53Pns5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=SwvVNHVe; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1712097819; x=1712357019;
	bh=MR7zmTwADGewdo6zllRIZ/UTARO0kkmfGknWcirmVYw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=SwvVNHVeQJJLFM/VFfha1Ro2bdtkvE5DpYjEM//3CSt7emQnfjGMN3H8Jh9Th1BpZ
	 sOMXFe42Ta/5TWlWUm2Pm5Z3YpV+dv1CPiUEbtSHWM/VQ4gwcdG+45l7GQZw07geXP
	 5v33aTQ5VxoWG/NUBE0tzO7FAuVwsgnehs17WP8Z2WSSfm1AY1spHktsK0VFKDMmxU
	 rU4lRvX2DR+Vl55p7RNoB+75Z8cCpMxMVS6O8W2tSFnpZsnb1dziTx+uZ0U76iknzn
	 pKA4KLXlhGAsBr14vknhm26iFGg+oOZoB1Vq7IPZpuAX+1qW8zEF8QigG7rTl/nE/S
	 5J5UaalFVPJNg==
Date: Tue, 02 Apr 2024 22:43:30 +0000
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
From: Nicolas Devos <ndevos-dev@pm.me>
Cc: Nicolas Devos <ndevos-dev@pm.me>
Subject: [PATCH 0/4] gpu/drm: Fix checkpatch warnings in drm_connector.c
Message-ID: <20240402224320.12146-1-ndevos-dev@pm.me>
Feedback-ID: 76711691:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

First time contributor here, I am getting familiar with the flow by
fixing some checkpatch warnings. This patch series fixes the warnings of
drivers/gpu/drm/drm_connector.c.

The result is 4 patches that each address a separate issue raised by
the checkpatch.pl script.

My initial attempt [1] was not accepted, this patch series addresses the
given review comments.

Please, let me know if something is not as expected.

[1]: https://lore.kernel.org/all/20240222204450.7943-1-ndevos-dev@pm.me/

Nicolas Devos (4):
  gpu/drm: Add SPDX-license-Identifier tag
  gpu/drm: Remove unnecessary braces
  gpu/drm: Prefer `unsigned int` over `unsigned`
  gpu/drm: Replace tabs with spaces in comments

 drivers/gpu/drm/drm_connector.c | 722 ++++++++++++++++----------------
 1 file changed, 361 insertions(+), 361 deletions(-)

--=20
2.42.0



