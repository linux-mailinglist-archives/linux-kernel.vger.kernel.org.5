Return-Path: <linux-kernel+bounces-33435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 149238369A6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480981C22955
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57CD1292E9;
	Mon, 22 Jan 2024 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYNJUWRi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0967A1292D5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936277; cv=none; b=uCwq3Sh7qfp9QYrfztQ5iguIE+0pFCA/fFK7bji9axiC/wMKPiawk8ssGWc35ZYujE9WzKZkU3kAPVhpjjSanStEtRq+T1hTgkGpFvXY6lX8DqKM0U89FE4X7oeIcDYbQAXbDFfzqgOrgIJLr/2+Fxwx0bO3VxdiP5og1mEQ+28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936277; c=relaxed/simple;
	bh=EpD3Hr2IfNJU3ntd7txCiVWwAPZLOWeSenY1lv5uZyk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NngZ6NBvnA9HPTFwmHgzBXVuRQSktSFhIFTDo9d3DXhfYvpsQdJcWXlRliMXssINHco1xhpXT0RgC4d2SpKBm/R0sweSqnZ0HBIdT4PO+kVFzde8yFVNJH/YVIOwCov0SFTz2kjgydlHNLMo2qA50FBSPALuYDBzUguW+yeEgpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYNJUWRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D790C433B1;
	Mon, 22 Jan 2024 15:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936276;
	bh=EpD3Hr2IfNJU3ntd7txCiVWwAPZLOWeSenY1lv5uZyk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TYNJUWRi/wwuOWzb359CmvuJy0/3Vovd7lDGYeMVs9/Yz7w5bX1bfbNnvCTDrPdUN
	 J7CHCB39hHdUeeTfVtZw6I7oahcmV/xs0lpbCEa53SJI+WWIKNFe+YlcKydN7kRNUc
	 xWe/ep/uePaBWTrRQNZZBKiS7NV7jNRhIlLdELhjaVqK6bcNIYLnCoF4KfPbWWdO+O
	 mLEck4ohmA1sPjgZtxDJXlgjA35uGRLbJD02m6q3UeuG09dbttcMPmQd+2vw29cEo2
	 BzTtkGDa0NER1X74GemxlWolAkNTmIRMpzWvDZo5y1t5w7UvEGQ6p21wGBAH1pSyKw
	 voZRikFouUGwQ==
From: Robert Foss <rfoss@kernel.org>
To: linux-kernel@vger.kernel.org, Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Inki Dae <inki.dae@samsung.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 michael@amarulasolutions.com, Jonas Karlman <jonas@kwiboo.se>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Amarula patchwork <linux-amarula@amarulasolutions.com>, Maxime Ripard <mripard@kernel.org>,
 dri-devel@lists.freedesktop.org, Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20231218084354.508942-1-dario.binacchi@amarulasolutions.com>
References: <20231218084354.508942-1-dario.binacchi@amarulasolutions.com>
Subject: Re: [PATCH v9 0/2] Add displays support for bsh-smm-s2/pro boards
Message-Id: <170593627232.3096177.528282215481259710.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 16:11:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1

On Mon, 18 Dec 2023 09:43:36 +0100, Dario Binacchi wrote:
> The series adds drivers for the displays used by bsh-smm-s2/pro boards.
> This required applying some patches to the samsung-dsim driver and the
> drm_bridge.c module.
> 
> Changes in v9:
> - Updated commit message
> - Drop [3/3] arm64: dts: imx8mn-bsh-smm-s2/pro: add display setup
>   because applied.
> 
> [...]

Applied, thanks!

[1/2] drm: bridge: samsung-dsim: enter display mode in the enable() callback
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=b2fe2292624a
[2/2] drm: bridge: samsung-dsim: complete the CLKLANE_STOP setting
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=72a0cfdc3ad7



Rob


