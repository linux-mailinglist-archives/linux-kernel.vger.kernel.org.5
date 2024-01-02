Return-Path: <linux-kernel+bounces-14320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F79821B4E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6DD282DE9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E42F9D6;
	Tue,  2 Jan 2024 12:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRdzGVbK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECB3F515
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 12:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A42DC433CB;
	Tue,  2 Jan 2024 12:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704196917;
	bh=QjQEzQkw6LmcRSDsk3eROUbpKXPD+NGppOQzbGKzZyI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iRdzGVbKXGnSaZ4M4GsVeOpooIk5rbgI3Njsa9WKDa0BypIyoJw/mlLnKaDuQMqtt
	 90eF8YJH9/k7zEOghnbwB8FVkRSVCrxSB1+NedGPKQ3TD3GM0W/1gKgNYxhLM0HF5L
	 TsDUOF+5zDnS04Ly8TsTYfp440cHQDGAbAYdkpDHhJcrolFVVWD9l/1JQg4nQKnsOu
	 wX2VYz03JBhjM22uW53zw4XFFkwQzr5L09kPM5Qq566daUUyxnl5wnPl3WUXq+bioB
	 6VC+q5KCdvXdP7f7Wn3axPnImJE+7GkAkM3jPxnHtQj0CsEp9XzBDGrni+CociTuBP
	 qrnrnxOpq6kRw==
From: Maxime Ripard <mripard@kernel.org>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Frank Binns <frank.binns@imgtec.com>, 
 Donald Robson <donald.robson@imgtec.com>, 
 Matt Coster <matt.coster@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
 Jonathan Corbet <corbet@lwn.net>, Vegard Nossum <vegard.nossum@oracle.com>
In-Reply-To: <20231231054910.31805-1-rdunlap@infradead.org>
References: <20231231054910.31805-1-rdunlap@infradead.org>
Subject: Re: (subset) [PATCH] drm/imagination: pvr_device.h: fix all
 kernel-doc warnings
Message-Id: <170419691484.40444.13264823314981119386.b4-ty@kernel.org>
Date: Tue, 02 Jan 2024 13:01:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Sat, 30 Dec 2023 21:49:10 -0800, Randy Dunlap wrote:
> Correct all kernel-doc notation on pvr_device.h so that there are no
> kernel-doc warnings remaining.
> 
> pvr_device.h:292: warning: Excess struct member 'active' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'idle' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'lock' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'work' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'old_kccb_cmds_executed' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'kccb_stall_count' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'ccb' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'rtn_q' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'rtn_obj' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'rtn' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'slot_count' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'reserved_count' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'waiters' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'fence_ctx' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'id' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'seqno' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'lock' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'active' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'idle' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'lock' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'work' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'old_kccb_cmds_executed' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'kccb_stall_count' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'ccb' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'rtn_q' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'rtn_obj' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'rtn' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'slot_count' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'reserved_count' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'waiters' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'fence_ctx' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'id' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'seqno' description in 'pvr_device'
> pvr_device.h:292: warning: Excess struct member 'lock' description in 'pvr_device'
> 
> [...]

Applied to drm/drm-misc (drm-misc-next-fixes).

Thanks!
Maxime


