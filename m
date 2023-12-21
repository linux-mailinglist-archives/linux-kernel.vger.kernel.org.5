Return-Path: <linux-kernel+bounces-8575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DE381B99F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30DD11C25CFF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFA33608F;
	Thu, 21 Dec 2023 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tTb44zhc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E251EB46
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <29c8523b-6554-4716-91dd-b4e7c0697b33@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703169217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ER5Li4YUkTrQ5sLdp19RWCOPTn5sa6zUgZcNZaJrI98=;
	b=tTb44zhc57HP8nj4wGnPm9XDpK6WEm1NDG0J3VJnI9oYIVy4ikdNSYtIFJDz8MIu70dstZ
	bScMCNxyEMQTs/88WUrnZpJSEtGXRZqM4S/xaGV2jjujJH+KUltz3Yr+TLFnmtg4idmoIL
	QETW309M/cEm7fq9jZ/qFcY2x8G4YHs=
Date: Thu, 21 Dec 2023 22:33:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v5,40/44] drm/sun4i: hdmi: Convert encoder to atomic
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
 Jonathan Corbet <corbet@lwn.net>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil@xs4all.nl>,
 linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
References: <20231207-kms-hdmi-connector-state-v5-40-6538e19d634d@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20231207-kms-hdmi-connector-state-v5-40-6538e19d634d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


LGTM,


On 2023/12/7 23:50, Maxime Ripard wrote:
> The sun4i_hdmi driver still uses the non-atomic variants of the encoder
> hooks, so let's convert to their atomic equivalents.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Acked-by: Sui Jingfeng <sui.jingfeng@linux.dev>


