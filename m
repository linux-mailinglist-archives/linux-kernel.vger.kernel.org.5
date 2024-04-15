Return-Path: <linux-kernel+bounces-144710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24F18A498B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CDFB281CB2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E852C84F;
	Mon, 15 Apr 2024 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hvoI+VRg"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA31D2374E;
	Mon, 15 Apr 2024 07:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713167882; cv=none; b=L3ycHwcpUh8fOzW2nl5xsPLGCN6jMJ5rHprts55hOh4W7Biy1Ma0DcudOhRhsMbOxDqB2O78/H5XqREqMAlff1UbdRdSTgOj2PskJ5CD5XBS3bj600oMO53FMoCZbnzT9Pg3eQr2d2153Ht8/sqQWb4P2RJv7vG4/Ix9zmyiVh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713167882; c=relaxed/simple;
	bh=TEDgWbwQZqOQttEd0OWcFZctvDILGW9k/SYHyU9Cehc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mG85JKEk+/or/Wxyxy7baUq3hNSoMFxkM2s1XYxfUD4MlyQZcLGvfYS5jKvK8Rz5dnJPppbp51dtFx5D5EvJbsNt0tkj4GLv3Lty3ia86a7KQHIsYx38fu/J4vCt7aoiONCbIg6L49JZrccsCu6Vw5ROV5Le/EnboFgvGEhvCzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hvoI+VRg; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713167879;
	bh=TEDgWbwQZqOQttEd0OWcFZctvDILGW9k/SYHyU9Cehc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hvoI+VRgFbZuXc2T/ZhHDdc70sxIF7YtnlMy1rNr+wai9T8lCFPwYHBmkE7twNcwU
	 JushNLe7oa9GSwigNnxQOMs6OYGXU08j0ehxCHk09Ss2SRb9LyZ2iL0jSq+/4Oyc+8
	 B2fbhfJvzCwlxdvQNDYp3pR8ZBHTTPaY8wH1pZSqPoKji72M1nskg5xiWe6XheGHUC
	 QjvGDvpgbXc/cbKmnIR0D26C4TxUIkqRjaJr0m0ET12aCMjYvl7fKjBcMxN6sPVOdY
	 Knl7kPR6pxK0S9pNpeZK9ChBFHA9tIuv1YgZM0gtKjT2jyAuab90fYW7EOS5L6HVsp
	 rM+XFSn7iEglw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 35FC83780894;
	Mon, 15 Apr 2024 07:57:58 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Jason-ch Chen <jason-ch.chen@mediatek.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Jason-ch Chen <Jason-ch.Chen@mediatek.com>
Subject: Re: [PATCH] soc: mediatek: mtk-socinfo: Correct the marketing name for MT8188GV
Date: Mon, 15 Apr 2024 09:57:54 +0200
Message-ID: <171316786262.49812.9619771465130968963.b4-ty@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409035355.27659-1-jason-ch.chen@mediatek.com>
References: <20240409035355.27659-1-jason-ch.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 09 Apr 2024 11:53:55 +0800, Jason-ch Chen wrote:
> Change 'Kompanio 830' to 'Kompanio 838'.
> 
> 

Applied to v6.9-next/soc, thanks!

[1/1] soc: mediatek: mtk-socinfo: Correct the marketing name for MT8188GV
      commit: 8328a3d126f54ef5998ea3b0e444701a02d62274

Cheers,
Angelo


