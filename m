Return-Path: <linux-kernel+bounces-136798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3682189D848
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636921C245F6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A6B127B7C;
	Tue,  9 Apr 2024 11:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AYmFZ+ll"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732041D699;
	Tue,  9 Apr 2024 11:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662948; cv=none; b=hkrchgFL+97wNDe67v226hWadaKKqBGTOosKDVxkFWgb8XERfSEZ8ZqBGqU//eUfL9QYZSuqOooUMyj3n6LEp0BeFg8gvnyMGCDexh+13zGlUc8eB+UU7oms4oV3OnRKpnanANe8SCSuNI2lMs5S8SvNiqG6bmcvOYlrh7+Wsu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662948; c=relaxed/simple;
	bh=UwWalpfea6BpAefdcOj18pnh4N5zMuVvU/mhh5HYwDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TGrFmV+EGaNHzM3G7Y9gOvKgMR6AB0O9c2v1Vmt+kHBOLmqaf1S68CuaehPVJauW55fLJumBNbv2pFfCPnA/W/4HzFiqHEN6w9iGsJmyFuaxEqQdzGznjb1WzkeOUroLRJyigM3im7S/PEyGCy8Ti1Er4DtiFltDIzXsqncr5ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AYmFZ+ll; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712662945;
	bh=UwWalpfea6BpAefdcOj18pnh4N5zMuVvU/mhh5HYwDM=;
	h=From:To:Cc:Subject:Date:From;
	b=AYmFZ+ll3W7MRJDDqSCbXOlIxvsbh/aTvWC5cIt8us13rMJxtz+JFErlT7x0m58hy
	 HMoMhX53YJvSt+KewuvR/JTI2zBaoDrzqXAQmeRiU+egDTWZMN/jaYqfWxTbyjoSt/
	 +RtEFinW54+jdQhJ5j3B24hRLEyfCexX0Kf8sLFZ9V0N3ohSgh3Md+LdtJfnZcLZTy
	 EHRoU+ZtrxC2WasUF+J6VJhzZql6nRsXgvuphYbmjlWWjs9jaC3qVJ3ziSn7Y+Cb0L
	 Yq9mGlYfyolEYO8z7YBfRiKe7VHAtyBN65yOE5r07k/qlzgxY2/+B6MRpUX3LkkFaC
	 ds5suqA9azKVA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F0EB337820F5;
	Tue,  9 Apr 2024 11:42:24 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 0/5] Radxa NIO-12L: Supplies for CPU/GPU and improvements
Date: Tue,  9 Apr 2024 13:42:06 +0200
Message-ID: <20240409114211.310462-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series performs various improvements and enables PHYs and USB Role
Switching for proper PM support and to stop relying on the bootloader's
pre-boot configuration.
USB Role Switching doesn't include Alternate Modes yet, as this needs
some more work.

As for the regulator nodes, those were not probing correctly, producing
unability to resume after PM suspend.

AngeloGioacchino Del Regno (5):
  arm64: dts: mediatek: mt8395-nio-12l: Fix MT6360 regulator nodes names
  arm64: dts: medaitek: mt8395-nio-12l: Set i2c6 pins to bias-disable
  arm64: dts: mediatek: mt8395-nio-12l: Define RSEL in microamperes
  arm64: dts: mediatek: mt8395-nio-12l: Enable PHYs and USB role switch
  arm64: dts: mediatek: mt8395-nio-12l: Add power supplies for CPU/GPU
    scaling

 .../dts/mediatek/mt8395-radxa-nio-12l.dts     | 106 ++++++++++++++++--
 1 file changed, 94 insertions(+), 12 deletions(-)

-- 
2.44.0


