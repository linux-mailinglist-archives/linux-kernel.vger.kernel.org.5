Return-Path: <linux-kernel+bounces-125865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D67C892D3C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB011C214FA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B4F47F5B;
	Sat, 30 Mar 2024 20:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UowgVcCf"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ECE1D526
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711831413; cv=none; b=feU7+mQ7a/DbFf8kjvJMmYdGYPx6QXc43jG7psi2zWrMklwRZyTklQvYiOz2LBoqjSVu1Pzats4W1DDf0r1p+90p+/vF5IavUqTYRhLKztzVbGgsouDIec8Hm8soJ6L2qoYlRgElkjkPrmBjUU//NIQIXUeWoOB/FvrRSqUpkDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711831413; c=relaxed/simple;
	bh=w3IeKAjnHBm8kl2xZSK2QFuYLup7/F/VoSrvI0alzKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mOHLU+TqiIHf9DubzL6J5ZkB+pEIlsSmZWqY58nu1aNtpRWkuzDl98NeoV2E8F4X9+N6+mDfDWduXHzRGVmEF5gfE9YVZoF7nVjcxZc8lNIFr850MOzWWXTiQBqkcv0883fe23ppIDlGh3Hg5LC7bwtu6S0kvtJU5DMxmUR8bYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UowgVcCf; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-341c7c8adf3so1993590f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711831409; x=1712436209; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQ6iRfApTBoRDrY2t1Fr9Ku/JGHxYaIezlkqm2YUAqc=;
        b=UowgVcCfKz6NMjDc7owxD6KmfcGioDwOgdQVGxaw0+QTT4vY95McK0MPmoRZJHwgmz
         +FJUf6z677ZVQ8cJSGt/0sDHYeJ3Eu+vs8xZ6GjbN8DQH3Xcrr5hX2yEQ+WDp7Ljy+xf
         g43zrKV4La70L4JRc5W4DVxNVq1j6uNGMBrZkzx0ExQkFayK3GsGDdaXmelRyTVleZSQ
         Wnb81tOMRM1YCKoUKbpuX6lAuyUj3nRmTGgdyBoIspi6aDe0FiJy3Ubf4CGGiVBl4pdG
         MgY84SIRn5C04ClbDHnozMQrLeskTz9JkIw2DQRuCedjVm7aMu8ceMHSAYNM4q18Jc9b
         bbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711831409; x=1712436209;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQ6iRfApTBoRDrY2t1Fr9Ku/JGHxYaIezlkqm2YUAqc=;
        b=ZWPyaLHWl/zOQoxrE4YQCa0L7VZfV2kJMDeEfAXCnmlj5BSugJr79h9iGLJ+WJv/x3
         MviTkD+C6Dv6mMLxAarTRQvE3bJXYG8ppU102/u4Dpiokn9XXEGUzSjc4KEtaP+l9Cwm
         tOH6TeMw/nnbwfhTKRKa7AQjQkikom9o1ttwWQ5z06NQMV3HcCMMrhRQRgT/RGXHG1nC
         bEonH9scqWIAlIt8qiY4i1vmvK2aiqSzstXNEg4P1OGo7U+1nwHE42OElOK+0ZRnj+mN
         MP4lE3gR8NhMmewFscsWI6+S0J4vUrQsMK//PMswXMOKeQ3lT+sjBgFaUxW+VM9Aj8fr
         oT1w==
X-Forwarded-Encrypted: i=1; AJvYcCW2KhWYHkoVVKB74bgrXvvoTM3H1OZMe4EckJdSkpQturcdCpYBKt8MS3Hvrfv0npZ8bG4tlWmcKvGO8RSFR5QZznRmQAsCUdYNV37j
X-Gm-Message-State: AOJu0YzN3j9fNDb9dfRbwZ5Wqd+mxESTtIHhXC/15dPScJR6tkKNQPbQ
	Jdvna7DHnfpNv5yGVO/AmXmBZyZHKYyrAxoZq2nXGdN/ERher5lOYLhEHvxhCGbtymRUqSW5CuC
	v
X-Google-Smtp-Source: AGHT+IFof+wGW9GxDz08XDMp6C+JQTVetnRPBObjFVAE613n9FHrpR+tNujyuR5lpdLBVcyRgTGtXw==
X-Received: by 2002:a05:6000:250:b0:33e:67c7:e2c0 with SMTP id m16-20020a056000025000b0033e67c7e2c0mr3096634wrz.38.1711831409452;
        Sat, 30 Mar 2024 13:43:29 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d4a8c000000b0033e7b05edf3sm7231299wrq.44.2024.03.30.13.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 13:43:29 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Mar 2024 21:43:12 +0100
Subject: [PATCH 01/11] drm/mediatek: aal: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240330-b4-module-owner-drm-mediatek-v1-1-fd5c4b8d633e@linaro.org>
References: <20240330-b4-module-owner-drm-mediatek-v1-0-fd5c4b8d633e@linaro.org>
In-Reply-To: <20240330-b4-module-owner-drm-mediatek-v1-0-fd5c4b8d633e@linaro.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=839;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=w3IeKAjnHBm8kl2xZSK2QFuYLup7/F/VoSrvI0alzKY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCHllE0eKbHKME3Pw1H4CbKUpy9mgJwywTALwm
 8LLCuYguqyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgh5ZQAKCRDBN2bmhouD
 1002D/9XrWcY2yuyJCyP/EFAaoXJOdXI2ZjZNPj1enhHgt215/5Hq4umqeqJfzLIrjTzKZqMNeT
 274U1WzmqF3vl7oc8fOG6lArneQdJffyeJTU6IBFx3hUvfStz5a2hERTop6d4/EZ0A27CEsNO/v
 vTQsssxxwN1V7TmiiFqDjwKSGXLZj5KbjJVqJg29vF+cKz9ylWp9D7GO7lTSCnDVy8RT1v7w6Dv
 p/KQS+LcUZNsOhgjeDAaJkiFigku4o3Un/I/T+l0an9KRakHP4ALOas2g52wN7LYeXtj9LGTM7d
 QR4hV1ZwI9rf0NTKpvXjIA6D5ynsS2o9/4/uv5pgA8CUmljDzw+Ar3TkFG7GYBaimmtHJHVQ34z
 rHdRVbBhvPlJf8vLfCpoWvEmSJvONlbndk5UZJrlfJ15yGI1Bh+x/w1fa7NogDKvxheUeUXh7II
 JdKgfZVf02epyusd5EJzrFcL4spSZmlI11kXmSx8dZ1wC5xaYIkAWPtc9mMUcNa238VVUXeQW94
 dA3f7q/uDRXlVDxtMnJK9OE788U1KpgWacBeW4SUiSyB0/DW3Rr8JMVHLK/Esk1JFBC7U7oBCn+
 94Ao2epihnCjjdLcCTEwIdAZX77dwdCS3TaYSChWa0kTPymFJA6zmDndVtEOlna1yKbho70pInK
 OBYxA/SkR5ieDkg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in platform_driver_register() already sets the .owner, so driver
does not need to.  Whatever is set here will be anyway overwritten by
main driver calling platform_driver_register().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/mediatek/mtk_disp_aal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_aal.c b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
index 40fe403086c3..f6f2c24abc93 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_aal.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
@@ -223,7 +223,6 @@ struct platform_driver mtk_disp_aal_driver = {
 	.remove_new	= mtk_disp_aal_remove,
 	.driver		= {
 		.name	= "mediatek-disp-aal",
-		.owner	= THIS_MODULE,
 		.of_match_table = mtk_disp_aal_driver_dt_match,
 	},
 };

-- 
2.34.1


