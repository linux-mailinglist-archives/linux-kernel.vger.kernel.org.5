Return-Path: <linux-kernel+bounces-23061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A637D82A6FA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 05:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F3031F24292
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC40D1FD2;
	Thu, 11 Jan 2024 04:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WcIRLklH"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F38184D;
	Thu, 11 Jan 2024 04:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=2hyWdpNDdJxMYqGPRg1E7P4g07ZmgOwvZM9Ag3R0b80=; b=WcIRLklHB9+9+pXBkvZiQ8Yang
	+5OR/mB216wiwE3N5K8rmVcZuRmw3zu/HAwL1xSzGskhct9XRv7bEji3me6qsrq5oy3IImiPFOq7F
	Vov403V727ijIhgHScrxA343MyrYKJ5yLhfeSPcwn4h8SEpeBRg0jgS0soD/2qYqu181VsuXqT1iT
	Ae9Two99SWI+8+UGFToQT1IuqWKk99aDzI5XvSCA2VQWqpl0+YmrWJZKOL9F/sXV9AovPOpW2GN19
	PK9GxpwUoVp8tZkvqGT+3bqVgP8Ki1EwLyxOD/Lp5l2CvgWvdHmWy/euALATvHTbxTztCnjpAy9+E
	gvKeB+yw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rNmnz-00Fp0S-3A;
	Thu, 11 Jan 2024 04:36:36 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH] media: verisilicon: fix hantro.h kernel-doc warning
Date: Wed, 10 Jan 2024 20:36:35 -0800
Message-ID: <20240111043635.17065-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove an extraneous kernel-doc description in hantro.h to
eliminate a kernel-doc warning:

hantro.h:277: warning: Excess struct member 'jpeg_enc' description in 'hantro_ctx'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-media@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/media/platform/verisilicon/hantro.h |    1 -
 1 file changed, 1 deletion(-)

diff -- a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
--- a/drivers/media/platform/verisilicon/hantro.h
+++ b/drivers/media/platform/verisilicon/hantro.h
@@ -237,7 +237,6 @@ struct hantro_dev {
  * @codec_ops:		Set of operations related to codec mode.
  * @postproc:		Post-processing context.
  * @h264_dec:		H.264-decoding context.
- * @jpeg_enc:		JPEG-encoding context.
  * @mpeg2_dec:		MPEG-2-decoding context.
  * @vp8_dec:		VP8-decoding context.
  * @hevc_dec:		HEVC-decoding context.

