Return-Path: <linux-kernel+bounces-1088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1D5814A24
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 295AA1F25059
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1374430335;
	Fri, 15 Dec 2023 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ij3V6t82"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647263032A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 14:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70692C433C9;
	Fri, 15 Dec 2023 14:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702649550;
	bh=DsbgY/uwwGNpejz1AXvX+dQX7RxzvKOSSNS1eb1nUeE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ij3V6t82jONjn6xc1jPYRViW9C2ERfrm4U8o+m8nry/QuVQg6KN1qxLknQui5gwA8
	 Uz1xGdOmyXvC1nQGd9o01hTAfHBW0WyjWneSCVesEHl8fIvAlUGDKhn3cTWBH5KI3C
	 0ERXK4DEf+pBM9WhJZ54zA5VsRrBdT4eVJHO/Vg7BsCG0EsmOG41FA9UkNqQ+R26lY
	 MD+W5Q8b1xSY5SjYsuzfcWzW8pkgIPUQjaIjopdUetoMcrzlLKGeOvBXw/5ue8NEiA
	 XRgZl+RnTPABhJzF1qoy9s05WQjdP1Mel5QPzskp9ML0CJacJOK3cVt2ShFmR8U/Mc
	 8IjsHoJiQtsSg==
From: Robert Foss <rfoss@kernel.org>
To: linux-kernel@vger.kernel.org, Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Neil Armstrong <neil.armstrong@linaro.org>,
 Maxime Ripard <mripard@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, dri-devel@lists.freedesktop.org,
 Marek Szyprowski <m.szyprowski@samsung.com>, Inki Dae <inki.dae@samsung.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>
In-Reply-To: <20231207161056.183442-1-dario.binacchi@amarulasolutions.com>
References: <20231207161056.183442-1-dario.binacchi@amarulasolutions.com>
Subject: Re: [PATCH] drm/bridge: samsung-dsim: check the return value only if necessary
Message-Id: <170264954712.2122029.375265515783012819.b4-ty@kernel.org>
Date: Fri, 15 Dec 2023 15:12:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1

On Thu, 7 Dec 2023 17:10:43 +0100, Dario Binacchi wrote:
> It was useless to check again the "ret" variable if the function
> register_host() was not called.
> 
> 

Applied, thanks!

[1/1] drm/bridge: samsung-dsim: check the return value only if necessary
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=045159f5018e



Rob


