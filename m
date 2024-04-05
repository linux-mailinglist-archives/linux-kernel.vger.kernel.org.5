Return-Path: <linux-kernel+bounces-133060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF173899E34
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D78283C79
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447F516D9AC;
	Fri,  5 Apr 2024 13:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4uUX/WiM"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFC716D4CA;
	Fri,  5 Apr 2024 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712323413; cv=none; b=git+O95NbHz1T90HVqxU2aYlxnQdx40Yb+GQ17UbI64aLy/s8kg/pzBMFz9TpJ1p2vOjuxwVqyDRGCbolJxDDLU0ewml4NtT3zxdLd8UHQj4cg05jQe2qo8K+QX0e57cJJicbf5mPUmprXJTmd1a+OLlwseykct80L2DIn25g24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712323413; c=relaxed/simple;
	bh=/Q23M0xGDCKWgKQFCm9vYo0xphLavpB6Diurno/eQv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbWWXdgCtbsoscIfwVaCud6ZyD7/O3uLceLXtE4os85AyuKiKpUD3ogGtowi7QYaoeDICFdCaNum6gbJhfbE25cE9hhsk0l9T7lHXJJXFkxecrFbBIopRasCiqbtfH31WdPn1rs6x31fhZ2zANtmfUL8+imQIhmqOJPb68cIJzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4uUX/WiM; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712323409;
	bh=/Q23M0xGDCKWgKQFCm9vYo0xphLavpB6Diurno/eQv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=4uUX/WiMVXouAtweVC+Pc6XxmGGXm1DQAOuapVP2Y5UJzRWsQZEGl8hWflfhXIXVE
	 XFM3A0n9uBDd5aAOGZtCaNZqrEuSKziR0leaT9u0hWAKD/UHEPispG9n+8ws6o4uYy
	 kOxFo/j9T7GOaXCOjOCRcC5kQS9ax/m0DtsYrAvMLvrujsvYLNognb3ZX7QA1FN5er
	 urdiY7VjTSs7RHVXTt5I/L3Ob/S8zQSvLrcmFwvzmOdHluqZQx1PIqe1tyBJ4w+TYg
	 CtbYeWOxeT7zSgVe3ItZyZ2m8wU9ykVIOpkkdlvNP/jBca2ZhCGf+fP8tgFXHoBuLQ
	 8i3Rp8Zkt/vXw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CFA253782128;
	Fri,  5 Apr 2024 13:23:28 +0000 (UTC)
Date: Fri, 5 Apr 2024 15:23:27 +0200
From: Sebastian Fricke <sebastian.fricke@collabora.com>
To: Ivan Bornyakov <brnkv.i1@gmail.com>
Cc: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] media: chips-media: wave5: support reset lines
Message-ID: <20240405132327.z6uyicg7kosqvi6w@basti-XPS-13-9310>
References: <20240325064102.9278-1-brnkv.i1@gmail.com>
 <20240325064102.9278-3-brnkv.i1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20240325064102.9278-3-brnkv.i1@gmail.com>

Hey Ivan,

On 25.03.2024 09:40, Ivan Bornyakov wrote:
>Add initial support for optional reset lines. For now, simply deassert
>resets on driver probe and assert them back on driver remove.

LGTM.

Greetings,
Sebastian
>
>Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
>---
> .../media/platform/chips-media/wave5/wave5-vpu.c | 16 +++++++++++++++-
> .../platform/chips-media/wave5/wave5-vpuapi.h    |  1 +
> 2 files changed, 16 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>index 1b3df5b04249..1e631da58e15 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>@@ -10,6 +10,7 @@
> #include <linux/clk.h>
> #include <linux/firmware.h>
> #include <linux/interrupt.h>
>+#include <linux/reset.h>
> #include "wave5-vpu.h"
> #include "wave5-regdefine.h"
> #include "wave5-vpuconfig.h"
>@@ -151,6 +152,16 @@ static int wave5_vpu_probe(struct platform_device *pdev)
> 	dev_set_drvdata(&pdev->dev, dev);
> 	dev->dev = &pdev->dev;
>
>+	dev->resets = devm_reset_control_array_get_optional_exclusive(&pdev->dev);
>+	if (IS_ERR(dev->resets)) {
>+		return dev_err_probe(&pdev->dev, PTR_ERR(dev->resets),
>+				     "Failed to get reset control\n");
>+	}
>+
>+	ret = reset_control_deassert(dev->resets);
>+	if (ret)
>+		return dev_err_probe(&pdev->dev, ret, "Failed to deassert resets\n");
>+
> 	ret = devm_clk_bulk_get_all(&pdev->dev, &dev->clks);
>
> 	/* continue without clock, assume externally managed */
>@@ -163,7 +174,7 @@ static int wave5_vpu_probe(struct platform_device *pdev)
> 	ret = clk_bulk_prepare_enable(dev->num_clks, dev->clks);
> 	if (ret) {
> 		dev_err(&pdev->dev, "Enabling clocks, fail: %d\n", ret);
>-		return ret;
>+		goto err_reset_assert;
> 	}
>
> 	ret = of_property_read_u32(pdev->dev.of_node, "sram-size",
>@@ -246,6 +257,8 @@ static int wave5_vpu_probe(struct platform_device *pdev)
> 	wave5_vdi_release(&pdev->dev);
> err_clk_dis:
> 	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
>+err_reset_assert:
>+	reset_control_assert(dev->resets);
>
> 	return ret;
> }
>@@ -256,6 +269,7 @@ static void wave5_vpu_remove(struct platform_device *pdev)
>
> 	mutex_destroy(&dev->dev_lock);
> 	mutex_destroy(&dev->hw_lock);
>+	reset_control_assert(dev->resets);
> 	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
> 	wave5_vpu_enc_unregister_device(dev);
> 	wave5_vpu_dec_unregister_device(dev);
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>index 465ff9dfe8b1..da530fd98964 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>@@ -758,6 +758,7 @@ struct vpu_device {
> 	struct ida inst_ida;
> 	struct clk_bulk_data *clks;
> 	int num_clks;
>+	struct reset_control *resets;
> };
>
> struct vpu_instance;
>-- 
>2.44.0
>
>

