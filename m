Return-Path: <linux-kernel+bounces-12672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A0B81F8BC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74FEA284F84
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE46BC8EA;
	Thu, 28 Dec 2023 13:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvlVOF/l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9E58839;
	Thu, 28 Dec 2023 13:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d9cb95ddd1so835326b3a.1;
        Thu, 28 Dec 2023 05:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703769415; x=1704374215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryeoFuAvKhes97Kz9LboAlOnpJ0eP7zbuN7MA5+dcVU=;
        b=DvlVOF/lc78V5YLw2tqIK6mALwLwejRgIvQNXfO04Q1pK8cg5CwPeVqJTBJg4Vpn0g
         JewKMYxLowAgri3kHrZbj3+vMgtwF3+hxprUhz1sy7dmQBXgVDjZeihBQledGZk+0gXY
         beMlbwcd03jLj0MRqhtG93kenpIV63Nn1pshWv4XJzJdgeELv0xQHkZPjKEIDqkMyYaI
         TzrhSzyS7GuXC+BZrUc76/iKIxmDYRJGHDyMK/yTyRLZEOZR0XzzINjZUhki69PYbNRJ
         TsaIBUjqpyZGHGHDWgW6CzPce4unIq7nBN1G/DkzThJSj1dSA0JozjfvliRS7vVzpfYQ
         +goA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703769415; x=1704374215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryeoFuAvKhes97Kz9LboAlOnpJ0eP7zbuN7MA5+dcVU=;
        b=u16inqTn2Tb2sr4qUkxqZ/otkUjJG6Je+C4HgShs3133oN2IhPjKeKPXblZCrCZVZ3
         f1LKwS8WbA5tsEV2y1jeRNzANzUxFl1orvfwRfKbFZl7+5fCCosvFa/hT0+O7ncoHk36
         pXFWTo9VL3TYoLRhBISE0Fh1pEW24rvkLzKguimlTZp82QK33eH9IU5IYwQUy8i0EzNS
         JUL9EyeJBPr1wEAqZBqCdli5IaMyRSqnmP7fnXuUbIl65FUnWbpKcA5TnXbEh14inala
         E0BvA6kH+SeiuUUYmaFL7xnKMZIX+Sbrnox+Mvg1o8HU9AHG3pscu7+FO116zN/GrX2c
         3J1A==
X-Gm-Message-State: AOJu0YyjOqC2DTID0YIczCP37Cu2asEAN7EX/ON7iIB0zK7e77Z2TQJw
	POucOZF6iTa5zgWgDuq90QM=
X-Google-Smtp-Source: AGHT+IHcpt2DYZLoqCeTFaYbserpY4VrjDSfDMGQyRlnv7vg7FZ26ANwqK9BvLR5rMSHJCN22ZYV0w==
X-Received: by 2002:a17:903:22c7:b0:1d4:4fa3:2125 with SMTP id y7-20020a17090322c700b001d44fa32125mr3592329plg.126.1703769414990;
        Thu, 28 Dec 2023 05:16:54 -0800 (PST)
Received: from localhost.localdomain ([2408:8207:2540:8c00:3708:559:ea20:9883])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902db0a00b001d0b4693539sm13864221plx.189.2023.12.28.05.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 05:16:54 -0800 (PST)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: ezequiel@vanguardiasur.com.ar,
	p.zabel@pengutronix.de,
	mchehab@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	sfr@canb.auug.org.au
Cc: liujianfeng1994@gmail.com,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/3] media: verisilicon: Add support for Hantro G1 on RK3588
Date: Thu, 28 Dec 2023 21:16:15 +0800
Message-Id: <20231228131617.3411561-2-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231228131617.3411561-1-liujianfeng1994@gmail.com>
References: <20231228131617.3411561-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for existing Hantro G1 video
decoder on RK3588.

Tested with FFmpeg v4l2_request code taken from [1]
with MPEG2, H.264 and VP8 samples.

[1] https://github.com/LibreELEC/LibreELEC.tv/blob/master/packages/multimedia/ffmpeg/patches/v4l2-request/ffmpeg-001-v4l2-request.patch

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---
 drivers/media/platform/verisilicon/hantro_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index db3df6cc4..21334bb64 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -723,6 +723,7 @@ static const struct of_device_id of_hantro_match[] = {
 	{ .compatible = "rockchip,rk3568-vepu", .data = &rk3568_vepu_variant, },
 	{ .compatible = "rockchip,rk3568-vpu", .data = &rk3568_vpu_variant, },
 	{ .compatible = "rockchip,rk3588-av1-vpu", .data = &rk3588_vpu981_variant, },
+	{ .compatible = "rockchip,rk3588-vpu", .data = &rk3568_vpu_variant, },
 #endif
 #ifdef CONFIG_VIDEO_HANTRO_IMX8M
 	{ .compatible = "nxp,imx8mm-vpu-g1", .data = &imx8mm_vpu_g1_variant, },
-- 
2.34.1


