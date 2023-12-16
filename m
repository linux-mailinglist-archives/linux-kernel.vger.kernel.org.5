Return-Path: <linux-kernel+bounces-2074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6001A81578A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F214C1F25BDF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844B410A1F;
	Sat, 16 Dec 2023 04:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="sNmMiW8k"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF7911CA1;
	Sat, 16 Dec 2023 04:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1702701720;
	bh=wdNndgGeLlcNwK9hbEpoW5H6j3meU+l8uskTtib8Uhs=;
	h=From:To:Cc:Subject:Date;
	b=sNmMiW8kuBVigciMYuNFvyf1VoYyZ/+fgaGxok8hYA5gCbl1NWd532p5jLYLrzaAf
	 qIxHfeFs27leyWsYtr4ZadvXvkgnxuZKJ8lUpp5JoY++QrNmkilby++zVG0Zk47nbW
	 RmCGN3Wwdx9TcxK3XSQ7JOMRPjZ0qYt/ah2ykiTs=
Received: from localhost.localdomain ([118.112.114.229])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 4A409021; Sat, 16 Dec 2023 12:18:36 +0800
X-QQ-mid: xmsmtpt1702700316tp6eo8v02
Message-ID: <tencent_4AE0AD70494AB08166266B6493F4C507CE08@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjyoRLlB1WdJJ7RuUl5TjiHz/6ppILou0ypj6soqQ2oZ5NyubAhc
	 DN24kzTe67KAiTHnoBVxvZvHlA42BS40WYljtQDeSEbTIFZo+Lac5P1MzPAkUrayDmiGGed4IPWI
	 pCzclg7f6F50xLoPl+EFNUjNlJxSOD+7jjmW4589o+VYwvvAgOjxbj3PzwxLSsCj4M21MogIKcVg
	 tbx/rSLdhnknTRmW+RT9/wvJyN1IIg6JhqPUwYwjlNrEkWbXF0NlGSduz83ULwVM0/VIvIERNzZF
	 zcpUYw9LwtJFK2hktBmNBj4VWDRyNwCjiPZ0adw/WEm5F+aekXYkYhfyHF+19Bv+hB3MsU9B/BW+
	 ldmwMut55Qe3eT9+w7TXKG92Fzh3iCvZIbywl2VAIDtG0X0QEnlHJpDXAv9cJo8R5QZEE6mMEdCE
	 x5ODcDy/lH0Q3Ze78LRa+NpKyiy4Uti/RnoEFfL+YLNabr7bDbCqAJrjLLZNaxYqzW+2v6NW+cld
	 RwbIcJF8F3kqL4dTCKfsmFAB0X/eoHyqvVoArUPbLzC97GA0TWuxOl/dUXeHa2BQBurS1N5K+PnB
	 viok+f9dI+j/cDxxAf3QZZ66LNelTjUetQmmMX7ewRXZLXzXK5ICCdqzVY24/yIu75UE0oRI1YnZ
	 siRITp27/PuuFblHyLyFa8zkWd9RLUBNCrPGNh4hvuiXpatTNadLSGiBssIMD6YlBqF4OiKfVZ69
	 DiP5q2qXbputQQ7QfoPif+yBtNlUMBgQzP0ks2vmWcf3ArYxaWHI5h6CsIP9cf1C/hX9Ggqz0hxl
	 nwf4M6LdVEVcNM/mM4zRcxw3M2/AReVS6vY5UEnEcHLmDm/G1Acy/V6yYc9swWGZNo3KcMIZG413
	 K3gpWMlcF7U1c9voc9GHdE9mR6KXCrd8vBpY0iQClINVEINSwwEfOQfKVs2LO6+DymO60sMPLdCV
	 bdTrTM82dPD+lkcrC9FODEPaYU9AsxDk98wYfTBV0OcZYn0oFOlouT0fGLshVNgZbVC36V/Ww=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: renjun wang <renjunw0@foxmail.com>
To: ezequiel@vanguardiasur.com.ar,
	p.zabel@pengutronix.de,
	mchehab@kernel.org,
	heiko@sntech.de
Cc: linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	renjun wang <renjunw0@foxmail.com>
Subject: [PATCH] media: verisilicon: Fix some typos
Date: Sat, 16 Dec 2023 12:18:05 +0800
X-OQ-MSGID: <20231216041805.12936-1-renjunw0@foxmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Function hantro_g1_h264_dec_prepare_table() does not exist,
should be replaced with hantro_h264_dec_init().

The register name av1_ulticore_tile_col confused sometimes,
although not be used corrently. The correct name should be
av1_multicore_tile_col.

Signed-off-by: renjun wang <renjunw0@foxmail.com>
---
 drivers/media/platform/verisilicon/hantro_g1_h264_dec.c        | 2 +-
 drivers/media/platform/verisilicon/rockchip_vpu2_hw_h264_dec.c | 2 +-
 drivers/media/platform/verisilicon/rockchip_vpu981_regs.h      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_g1_h264_dec.c b/drivers/media/platform/verisilicon/hantro_g1_h264_dec.c
index 9de7f05eff2a..ad5c1a6634f5 100644
--- a/drivers/media/platform/verisilicon/hantro_g1_h264_dec.c
+++ b/drivers/media/platform/verisilicon/hantro_g1_h264_dec.c
@@ -243,7 +243,7 @@ static void set_buffers(struct hantro_ctx *ctx, struct vb2_v4l2_buffer *src_buf)
 		vdpu_write_relaxed(vpu, dst_dma + offset, G1_REG_ADDR_DIR_MV);
 	}
 
-	/* Auxiliary buffer prepared in hantro_g1_h264_dec_prepare_table(). */
+	/* Auxiliary buffer prepared in hantro_h264_dec_init(). */
 	vdpu_write_relaxed(vpu, ctx->h264_dec.priv.dma, G1_REG_ADDR_QTABLE);
 }
 
diff --git a/drivers/media/platform/verisilicon/rockchip_vpu2_hw_h264_dec.c b/drivers/media/platform/verisilicon/rockchip_vpu2_hw_h264_dec.c
index 46c1a83bcc4e..6da87f5184bc 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu2_hw_h264_dec.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu2_hw_h264_dec.c
@@ -460,7 +460,7 @@ static void set_buffers(struct hantro_ctx *ctx, struct vb2_v4l2_buffer *src_buf)
 		vdpu_write_relaxed(vpu, dst_dma + offset, VDPU_REG_DIR_MV_BASE);
 	}
 
-	/* Auxiliary buffer prepared in hantro_g1_h264_dec_prepare_table(). */
+	/* Auxiliary buffer prepared in hantro_h264_dec_init(). */
 	vdpu_write_relaxed(vpu, ctx->h264_dec.priv.dma, VDPU_REG_QTABLE_BASE);
 }
 
diff --git a/drivers/media/platform/verisilicon/rockchip_vpu981_regs.h b/drivers/media/platform/verisilicon/rockchip_vpu981_regs.h
index 182e6c830ff6..850ff0f84424 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu981_regs.h
+++ b/drivers/media/platform/verisilicon/rockchip_vpu981_regs.h
@@ -118,7 +118,7 @@
 #define av1_mcomp_filt_type		AV1_DEC_REG(11, 8, 0x7)
 #define av1_multicore_expect_context_update	AV1_DEC_REG(11, 11, 0x1)
 #define av1_multicore_sbx_offset	AV1_DEC_REG(11, 12, 0x7f)
-#define av1_ulticore_tile_col		AV1_DEC_REG(11, 19, 0x7f)
+#define av1_multicore_tile_col		AV1_DEC_REG(11, 19, 0x7f)
 #define av1_transform_mode		AV1_DEC_REG(11, 27, 0x7)
 #define av1_dec_tile_size_mag		AV1_DEC_REG(11, 30, 0x3)
 
-- 
2.39.2


