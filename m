Return-Path: <linux-kernel+bounces-82253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E4B868139
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0790F1C2848F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E759512FF98;
	Mon, 26 Feb 2024 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAWxdnN3"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B8112FB3A;
	Mon, 26 Feb 2024 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976480; cv=none; b=DZ5ube7Z6sPVLY28tyrmNp6sfsC9jGmlCok7ylec3DnD9mFlC2FeMHItZ+R9oYumOPgO+aMH4wEYazkdF6Jt4BdlmGquh5xmTBWVnVno7gApEuRv6Ryo42XwMp7mZ0/qPmQ3hoPZVMcs0eSMB2zhqEjqH31pczaTJWM/V/2cpmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976480; c=relaxed/simple;
	bh=zMwyLGxftEg0zbEk3IpLDvzCnWJjH1ppm5rGkw0rT9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dV88m85Whene/jgpHeLEWPUM7aLQ3FA8WGYwzyP0C5wGfdrDOZ7swaVNRt7DrCVjjMFFAidFwZlCg3EahnnucgAUEbXmhBoTd5ecWxeZHERFnQ8z/OMXevajka5m1kHTS1m1+RRwy/8RZytFnW88cHMgPkQGyL4kRM0h46O9Q98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAWxdnN3; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5101cd91017so5140733e87.2;
        Mon, 26 Feb 2024 11:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708976475; x=1709581275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFlpEGYCrz+PVIm+1MzHIEYrRDDL2zl3YZa0XiZSGXI=;
        b=lAWxdnN3oqyLqF2ms7DbhnGqkdzT7hGnRwvjH9wpJ3he72UoY2AayaAVfSFIo2A2Ih
         vjs5aRjt0C8oLYbCKmMHnjM4sePG7G2Z1+9C+TzirHeYsoywHv7uudyeJAhcPLJXVINx
         ia2WWDSdID2RKK4HhYNzclDqc7C8z5Fid3HKDS1ynB5pBQqBGxx96kVp8Taj2d9u82IJ
         ipZhEd6XZ+9R/QYigcg6VJtFzOfwJZUfuGWzSnowO6H2Fu6H9Ml6JXPSYh6+ZXg1R4Zr
         gLhwuxtD/Muc0ZyzqlMMqKALITO0lzUUgP/o6cUR6DqPrXiFus43jILWNS0yITTxO5Ef
         nS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708976475; x=1709581275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFlpEGYCrz+PVIm+1MzHIEYrRDDL2zl3YZa0XiZSGXI=;
        b=Nh4R8lnBaFyAdq7AjBR9nUbO2H9wMfH8KrBH6Itlvu7YHLK9d0afr4gwjiFWE2uLly
         E1DX0GehDGYCnRwFgkdSl10/A/gTGx+00Rrx90aKTbPYEMnVvrDZb0DbAMaoL9NE5dDU
         GhzA8TKmuHLivEyJuQ8ZFkaz46YWhV8uGcz9DbzSHYQTTQDmWou5vfHftWfBvfpnYDAo
         rVVXmgz4ry2HFD8GkW/5aqaud5/ix8HzUpkYX0rLCBKp672SpZbd2XcZRXdIYFs5VDIe
         Bjs9BtxphvZTSl/bJtuK0OHOVoU22ss5EbCNWVYTJo4B8tMCZl3VyMX+v5zESgEJ1lQy
         BEMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbmI4JwfOCMfGTYHV7WpGnhWMEaihqUmxOPIMpSLIyNjRp/wIEaJT+b4ildCg270eC4urfJTuiZ6gTOv5k1hXtvlyZgMcDoC/ZBC2Nj10usW1BW3OYr765xNf3URiclQB4fj4zjEFXnSg=
X-Gm-Message-State: AOJu0YzJo+MJWrwW6NnZHTrbtqih/6XghSqlrv1ZqE1W0d0Zncb5hN2P
	5Wetg1weWrHx7Jk9E9vOFzTeAiFqXxLpr4rOOJxnGZhawRsEWDNv
X-Google-Smtp-Source: AGHT+IH3sgxa0WsudbC0X2+etV1uDpwjPg96gRMZGZi4nbP1+o/04Tfeg6wl64B0N7Xh+/79V4oVCA==
X-Received: by 2002:a05:6512:69:b0:512:b517:982 with SMTP id i9-20020a056512006900b00512b5170982mr4279240lfo.20.1708976475107;
        Mon, 26 Feb 2024 11:41:15 -0800 (PST)
Received: from localhost.localdomain (c83-255-24-248.bredband.tele2.se. [83.255.24.248])
        by smtp.googlemail.com with ESMTPSA id e21-20020a196915000000b00512ffb9bae9sm332328lfc.143.2024.02.26.11.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 11:41:14 -0800 (PST)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: hdegoede@redhat.com
Cc: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 1/6] staging: media: atomisp: Remove unnecessary braces from single line conditional statements
Date: Mon, 26 Feb 2024 20:40:18 +0100
Message-Id: <20240226194023.69070-2-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240226194023.69070-1-bergh.jonathan@gmail.com>
References: <20240226194023.69070-1-bergh.jonathan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch does the following things:
 * Tidies up code in several places where braces were used in conjunction
   with single line conditional statements

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/media/atomisp/pci/sh_css_sp.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css_sp.c b/drivers/staging/media/atomisp/pci/sh_css_sp.c
index cd7f5a3fecaa..23893189ba82 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_sp.c
+++ b/drivers/staging/media/atomisp/pci/sh_css_sp.c
@@ -420,9 +420,8 @@ sh_css_copy_buffer_attr_to_spbuffer(struct ia_css_buffer_sp *dest_buf,
 		   lines below. In order to satisfy KW an additional if
 		   has been added. This one will always yield true.
 		 */
-		if ((queue_id < SH_CSS_MAX_NUM_QUEUES)) {
+		if ((queue_id < SH_CSS_MAX_NUM_QUEUES))
 			dest_buf->buf_src.queue_id = queue_id;
-		}
 	} else {
 		assert(xmem_addr != mmgr_EXCEPTION);
 		dest_buf->buf_src.xmem_addr = xmem_addr;
@@ -860,9 +859,8 @@ initialize_isp_states(const struct ia_css_binary *binary)
 
 	if (!binary->info->mem_offsets.offsets.state)
 		return;
-	for (i = 0; i < IA_CSS_NUM_STATE_IDS; i++) {
+	for (i = 0; i < IA_CSS_NUM_STATE_IDS; i++)
 		ia_css_kernel_init_state[i](binary);
-	}
 }
 
 static void
@@ -878,9 +876,8 @@ initialize_stage_frames(struct ia_css_frames_sp *frames)
 	unsigned int i;
 
 	initialize_frame_buffer_attribute(&frames->in.buf_attr);
-	for (i = 0; i < IA_CSS_BINARY_MAX_OUTPUT_PORTS; i++) {
+	for (i = 0; i < IA_CSS_BINARY_MAX_OUTPUT_PORTS; i++)
 		initialize_frame_buffer_attribute(&frames->out[i].buf_attr);
-	}
 	initialize_frame_buffer_attribute(&frames->out_vf.buf_attr);
 	initialize_frame_buffer_attribute(&frames->s3a_buf);
 	initialize_frame_buffer_attribute(&frames->dvs_buf);
@@ -1269,9 +1266,8 @@ sh_css_sp_init_pipeline(struct ia_css_pipeline *me,
 
 	pipe = find_pipe_by_num(pipe_num);
 	assert(pipe);
-	if (!pipe) {
+	if (!pipe) 
 		return;
-	}
 	sh_css_sp_group.pipe[thread_id].scaler_pp_lut = sh_css_pipe_get_pp_gdc_lut(pipe);
 
 	if (md_info && md_info->size > 0) {
-- 
2.40.1


