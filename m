Return-Path: <linux-kernel+bounces-67258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4358568B9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00DF4283507
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF136134CF8;
	Thu, 15 Feb 2024 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gh8y4J4W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ED3134CF3
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708012980; cv=none; b=h7JIZ29CEsTTgxXiCGmJV2gS97ddZytNuhegZoeBM+28HMjowWZM+7wv7V7D/d/XLvmITT/ajDsyjnQa85+SX24xJrXGgf4ep5TT07GTGZ8hI34Md0tiTCyvCyjWoYlvUWHJo0ectBG+oXXLJbjCE+/YDlWQ5Phx7rS79y2jpBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708012980; c=relaxed/simple;
	bh=LIu2ftgfgDnm4yLR9EGjnqhVdVgGtxweSCzm0qeHe+8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aa373TmQKs/uXMUvLDL1HMP0P8p119/131e50400W2+wrAynBzXVj+zAa5hB+/tyEY8lc67eNZiV5cnBmygagl6kMcIJM1BFqoVzTHzy1an0KQGvG+SWWQyYjlJXTrmVqiVOlR/diN+d8I0cz+n/6nev0P82sVZjSdW6ab1PXj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gh8y4J4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D5FC433C7;
	Thu, 15 Feb 2024 16:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708012979;
	bh=LIu2ftgfgDnm4yLR9EGjnqhVdVgGtxweSCzm0qeHe+8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Gh8y4J4WSklsO9cCgrK7dWDV09e/sLTQd5dWl869DfXporGPp2ZtWm4t1U1xc8TxT
	 ifZz7Sa7OHXjhNTrdoF6N4mtv2OCYpxZbHLgK/keOe3lcOHuj9sxxXfm3LWEdgLkzU
	 M3LVi/OC0WN4AgwSEtsWSxTObQO73/6U/h+jxzrxyW3qUdSrlyyrkqx9mG/3eDZ4zP
	 H03dFAcIAq/KM8l3U/4zDKnUjnrCGh9arMAr6w3dLn1s60ToB6d7orDwcEFVpWIw9r
	 FyYEUaShbs2VD2Qv0Y5QQLizKDFRAMwg4Prd9NaI/Oi6es9kY3txP9stS8r33EeJb2
	 5EV+HNc2WQOOQ==
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <94c9b76ee906d1b790dfcc435f4221b1197df586.1708003402.git.geert+renesas@glider.be>
References: <94c9b76ee906d1b790dfcc435f4221b1197df586.1708003402.git.geert+renesas@glider.be>
Subject: Re: (subset) [PATCH v2] drm: Spelling s/hardward/hardware/g
Message-Id: <170801297623.1530193.16390570241474104331.b4-ty@kernel.org>
Date: Thu, 15 Feb 2024 17:02:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Thu, 15 Feb 2024 14:24:15 +0100, Geert Uytterhoeven wrote:
> Fix misspellings of "hardware".
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime


