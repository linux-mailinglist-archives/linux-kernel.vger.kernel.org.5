Return-Path: <linux-kernel+bounces-70031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A2B859207
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B192845DC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC13C7E57B;
	Sat, 17 Feb 2024 19:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="kfD29qcX"
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB0F1E501;
	Sat, 17 Feb 2024 19:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708197658; cv=pass; b=O4dd63XKyAael0lRQ+EQ4d5791gtiCLGAd9Mr3xaWgP41mv1CrSb1NEiu8Yph9Bv/XnhRiqk2h19e8DOcP1hksT/13LHujvtIQmlHOyGlqGRf4F0PEeNxW/fhF3qUIv3pP2wGer2Noh/ZWYaDo3V8LRaS5n6NXERGne3rZe/adc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708197658; c=relaxed/simple;
	bh=gSZiMw/JdccfEF888jNXjmGWzVZVbOk4rZZD6o7WT1U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ljdp1kWckOvjrZeIsnv6F55/Mu1SmSdcunrG5xyxSj2X6hZ+MX12orJXRfwtx0FUbBFGVYhpXXb8n5DG4a3azP9mIo5sN/lwUel0AI5+lGJ/SXyj5CzHyTk5YlEqJDXW7M8cQ3cOBqa5faNNcuU/vHpBpaV7WX1PwnIm6o89Ou4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=kfD29qcX; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from darkstar.musicnaut.iki.fi (85-76-160-177-nat.elisa-mobile.fi [85.76.160.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Tcdth3zD3z49PwQ;
	Sat, 17 Feb 2024 21:20:44 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1708197645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=q3yGZu/JG+xsk0nTtCSjCIfmV3w7H/r4e5NbPCar4jM=;
	b=kfD29qcXha2RiOhKDfUTmfzwRR5aHSvESALcwnDWZojdzSpCeETceAmVmzVDjBhE9rI4Ok
	Nip2rnOiOn7tw5UuhciLhtKIZCl1rUvaM9vclyf4rJjs98dKfMLHZESgcKIazwSOFH0AkD
	JMH8bFP/pKIhpKDDkgcXE9J15Ygg8fTb5moCGoAWZESIpSb4gMFLfwXcTMvj3fbe6KyQXW
	B+p75GELGxjXCer0U6zT2+rCcJveCt/0XM8T1fwZamSzO3Zb7nflpCt/cl1FNidfj4xf51
	oWgJ8NMnyT7F6KnjtWFz70idEzdyWc7hE4tLUdJwgWV9QPTUQqG5PbYjQ9cP+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1708197645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=q3yGZu/JG+xsk0nTtCSjCIfmV3w7H/r4e5NbPCar4jM=;
	b=rvAXoYaC1Ka9SUo4TQ8VkprPmVER0X/+/7CFdQXOWv19JwALpUU8nQwmFPgvlu8FUtB5dX
	nv/9aLVM5nMMmLLWKGVHUmYLFg2fyg8mwf46W3FQvyJvaPWSgkrb5dCnHaCJgLWAKRsL3s
	Tso+o4BVBFTp/y+iOt94EMeis9+KfbzAo4HRY1zu67bh3pPoehEbvHxOeXIRrp7o7kZY3R
	3WRSL2zNuhXyKWsHEptQadkarN2jkioUFf+LzPGUjO3kfWQSj3eBeU9LoF2k/bkdkjspAZ
	HO7pg5x4+1XQLohoWBbWc+SmvBoMKCJl4ojOSzdliqz8k2zlb1G1BFjsYNFOXw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1708197645; a=rsa-sha256;
	cv=none;
	b=bgB639vCp3ZFRvhLSvai8wvnLGmHLtPeinE/Fr4oOoYgMwkjKajgSQLSffLO0ArSl2pnSs
	62an//MkPL4G7y/VXNm5w1M2gBr6H9W6V6hcsG5Ws6IKq2L5pfgypz+Jj2VsuyeTGAAFdR
	PSOBjf5xUyWkx6QNGs0x8ml5lQP7NSDgaW16AfKKQeGO+QZqleCf+t6OvcIQcYmzn80HzC
	sKzpMXs4JHImLwdh+SPlubud7WDRcBr5v7Kr9GgYsEgIwyDUHQvU86CYW7M/6SO0T8fcSZ
	Gb3U8e7zAZ5jIBMNvaOQfLeFsLLpre3oxk0H3u83nT89gvqXP2asEQIXZuAtiA==
Date: Sat, 17 Feb 2024 21:20:42 +0200
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-usb@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: [PATCH] usb: gadget: omap_udc: fix USB gadget regression on Palm TE
Message-ID: <20240217192042.GA372205@darkstar.musicnaut.iki.fi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When upgrading from 6.1 LTS to 6.6 LTS, I noticed the ethernet gadget
stopped working on Palm TE.

Commit 8825acd7cc8a ("ARM: omap1: remove dead code") deleted Palm TE from
machine_without_vbus_sense(), although the board is still used. Fix that.

Fixes: 8825acd7cc8a ("ARM: omap1: remove dead code")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/usb/gadget/udc/omap_udc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index 10c5d7f726a1..f90eeecf27de 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -2036,7 +2036,8 @@ static irqreturn_t omap_udc_iso_irq(int irq, void *_dev)
 
 static inline int machine_without_vbus_sense(void)
 {
-	return  machine_is_omap_osk() || machine_is_sx1();
+	return  machine_is_omap_osk() || machine_is_omap_palmte() ||
+		machine_is_sx1();
 }
 
 static int omap_udc_start(struct usb_gadget *g,
-- 
2.39.2

