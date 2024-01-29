Return-Path: <linux-kernel+bounces-43053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC8E840ACD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15381C218A9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E4E155316;
	Mon, 29 Jan 2024 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4bHpZJU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BF1155311
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544389; cv=none; b=lJ4DncFYoQryoR4l5u2ycV32+41Fben55ZE2LHx6TXeDosJQmehgRvGn9YrmxB32Kl6s3apE9HFUO2ybYUb4yXxSaYOtkmpTvOYplf0KLzBLzwzBx533YCPdJPw3ksPBj/PH+NYK8LXcuxeYa7t42gMIxhgp0/0JoIPk7ZO2Wp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544389; c=relaxed/simple;
	bh=gsE0VC+Mvbx3+PkIl0OpvvJzIerilw+wc6PT2Cojk7M=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fCfDm1rgz1dqb89STxqVhcW6amINMtm6uyjI1ajSL+lbdlBZlzxzv7NR+ss2Mns5WPg9fsCF6OHnfOvt1N3sVcrEW75FmBmq1gIHIxnCqSXLMvMOVzxkMX4Q/G+RiwFDcqEhnGUKgCqoqPoG6uRyijzLe9+WZ4T5wJ6m/yjD80k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4bHpZJU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778D2C433F1;
	Mon, 29 Jan 2024 16:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706544389;
	bh=gsE0VC+Mvbx3+PkIl0OpvvJzIerilw+wc6PT2Cojk7M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W4bHpZJUG5NkBQWJp3rWUIB/6TdU+kl66Nf4/ZU78lxHVixTYe9AeKvbbDRmSksr0
	 m+Vh7H3/nkNF2q/r/V0l71sx/bwdyNgjdX1I/kvUF8mnhEw5+7aD0K96ORl9Gcs+eE
	 6a2qZ8cTBCxgFiCXSUeDsuinsOVArv2nrnaxEfaDiZIkSMdDnzrtTN6ApIvaVyL10U
	 5KhH2X1L1fgcjY47JAU74bG/thy9vAnRDt7MAltHpWBokVnvFMQexc3aoZO6yZ5ZHt
	 BUaltN98E3w+RPHXUZttVy6LeHQVZcnNGlzOTSeyajChSGZKbePBpaF3ZXyl/aFgho
	 CKt39XlaD041w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 29 Jan 2024 17:06:22 +0100
From: Michael Walle <mwalle@kernel.org>
To: Dave Airlie <airlied@gmail.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>
Cc: Inki Dae <daeinki@gmail.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Robert Foss <rfoss@kernel.org>, Frieder
 Schrempf <frieder.schrempf@kontron.de>, Jagan Teki
 <jagan@amarulasolutions.com>, Andrzej Hajda <andrzej.hajda@intel.com>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Tim Harvey
 <tharvey@gateworks.com>, Alexander Stein <alexander.stein@ew.tq-group.com>,
 linux-kernel@vger.kernel.org, DRI mailing list
 <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>, Michael
 Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH] drm: bridge: samsung-dsim: Don't use FORCE_STOP_STATE
In-Reply-To: <b18d88302acfca001a6693d78909bc2a@kernel.org>
References: <20231113164344.1612602-1-mwalle@kernel.org>
 <631fe35a2a3b00781231e4f3f5094fae@kernel.org>
 <1ef3dad2-5f55-40e5-bba7-3c71d71c12e4@kontron.de>
 <CAAQKjZMccDwa63_PNJCP0rNOaHjTwcOz8AbKa=JXLQi-b0QVVw@mail.gmail.com>
 <2400535875c353ff7208be2d86d4556f@kernel.org>
 <ZZ1BBO2nNSp3g-gT@phenom.ffwll.local>
 <CAAQKjZNnJQDn_r1+WNmsxM-2O48O0+yWAUAqpjZRjMYMT3xGwg@mail.gmail.com>
 <CAPM=9tytMB9frxNeD08hu1qsusY=wEE3bJOFmUgA1rSpabwDpg@mail.gmail.com>
 <b18d88302acfca001a6693d78909bc2a@kernel.org>
Message-ID: <31e1a38a1d012a32d6f7bc8372b6360e@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

>> Just FYI this conflictted pretty heavily with drm-misc-next changes in
>> the same area, someone should check drm-tip has the correct
>> resolution, I'm not really sure what is definitely should be.
> 
> FWIW, this looks rather messy now. The drm-tip doesn't build.
> 
> There was a new call to samsung_dsim_set_stop_state() introduced
> in commit b2fe2292624ac (drm: bridge: samsung-dsim: enter display
> mode in the enable() callback).

I had a closer look at the latest linux-next (where somehow my patch
made it into) and tried to apply commit b2fe2292624ac (drm: bridge:
samsung-dsim: enter display mode in the enable() callback). It looks
like only the following hunk is still needed from that patch. Everything
else is covered by this fixes patch.

Dario, could you rebase your commit onto this patch? I had a quick test
with this change and it seems to work fine for our case.

--snip--
diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c 
b/drivers/gpu/drm/bridge/samsung-dsim.c
index 63a1a0c88be4..92755c90e7d2 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1498,6 +1498,8 @@ static void samsung_dsim_atomic_disable(struct 
drm_bridge *bridge,
         if (!(dsi->state & DSIM_STATE_ENABLED))
                 return;

+       samsung_dsim_set_display_enable(dsi, false);
+
         dsi->state &= ~DSIM_STATE_VIDOUT_AVAILABLE;
  }

@@ -1506,8 +1508,6 @@ static void 
samsung_dsim_atomic_post_disable(struct drm_bridge *bridge,
  {
         struct samsung_dsim *dsi = bridge_to_dsi(bridge);

-       samsung_dsim_set_display_enable(dsi, false);
-
         dsi->state &= ~DSIM_STATE_ENABLED;
         pm_runtime_put_sync(dsi->dev);
  }
--snip--

-michael

