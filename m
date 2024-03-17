Return-Path: <linux-kernel+bounces-105450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F00687DE01
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93A94B20E77
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B192C1C6B5;
	Sun, 17 Mar 2024 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="wfcqJOhz"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CCD1C6A4
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710689853; cv=none; b=sAE2jNY6+qAeU8K6MlyYv2RIHFk//+hjchY5aFsz4wgPLVJDDpLaHtNHgw2HXwoFKYsf1Ko02ptvX86zcKcz69+NZA3Ef98vyfe16x96kIccnD0zdJqlTeDyfCou+MW1gASJDDutIW4dqKLfnisfIVchUuzykYC0WFrkZEmwAQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710689853; c=relaxed/simple;
	bh=wzHFPfAyYIm56eipbp/ckevoI92cV1TIIuBMAdOOBEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+cDWwWhkdqKSeC0Drm6qg7BoXf4NIXxy7tQin0rX8ipRRna/CQ4kKdntYZ/WIZ0o+oG2WMdw8q3unPWZtc5wrJzFyuOdoityuug4nd6o752458zSDuPKJXlJhuscz//A9SEHLu9MeiY8OVWosi8oUoCdUWqnjjOh8eTpN0HaMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=wfcqJOhz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-413f1853bf3so23539515e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 08:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1710689849; x=1711294649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mh6mJZXAndRjR9bEU8O8LAe21t8oF3so4wv78/G3xZM=;
        b=wfcqJOhzw43I9q26sBk8UqiIy3NwTgErZkNQsswXDA2Elq75R+xhHP8vpShEcBGc5p
         o925uJ2jiA6cM0R8fVW3rS8MyKpOatLSbdmIIetCt6PprDw7P1xuDDDmdPUCLuMaVtNs
         qgai6i7jGYZgDciH2fRJmR8u371wE4H19fThpXGSn6lWDhMnIzwSdz/aEF5Gv6JI6pYT
         rcS28oGq4VYKZkY+rPQnHnKUVHnh/DpFfXOq/ZFLdbYZxAdj9Ym9igM6IQd0MQDFL/vG
         agR4TCoD3e67AddozohDFlyEUuIGSVyt5nCSAYEtKcP7YJWM14l4F5m2PCuw7zqEhlrw
         EzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710689849; x=1711294649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mh6mJZXAndRjR9bEU8O8LAe21t8oF3so4wv78/G3xZM=;
        b=uV9+Wzn5QJCSLBFV515JjmwsfGl3rwSgxUdjFQQGV8rykO+2QqMEQDwpcXrysMkv/5
         2ymqR1+ObVd7KzVoq6M2xOpNiVxBfo/ZLMnzm445iTY+PPdU97rK/oxh6O13Wvl/r1XF
         uQAPzS8IWx9vaxqrobqmKeLhX7P2qQyjUD/STycB/yd/57QQM6pibJ2hw7DmijEo67KH
         zqTvPRlMV5xa4x7Jcvx23q2JTc+9IUlw4l54nig7ka7RBeZFZXfTLIlcYXx+cEOFRpMG
         G+hgTQR3wHLnSRrR3xwjFfxbt4OmtTScwWHkt8TcESnlKSfaa34ejzmoS8vgS6KLli2j
         8A8A==
X-Forwarded-Encrypted: i=1; AJvYcCWMzAZ79TLjy+XLInFPhAa5jmVt86VME2I6sWwMshOgkMD6e6Etw3qIlQ+lg8r0nlt44NJ2Fc/LZUAz1spk7rlPNA/2bVbQbszsmdmE
X-Gm-Message-State: AOJu0Yydj17CLa59Hb5h6TpBW+xfIdYmAUQC2DmoQElOg0No/4OzovEr
	dHhS/fHTJR2IS5yLGGAvLIUcoI65hHolNFsBd2WhEBUDjmz7+/oS6p6gZBtl3vF9ydgIvUO9TNY
	c
X-Google-Smtp-Source: AGHT+IGtuRn18tXGMEylwW1EQ/gXzGfXayK2YMVEMOZjg00wy8f++b4khAqjOx7Hd8BFozmhJizQYg==
X-Received: by 2002:a05:600c:4f8a:b0:413:eb74:fe46 with SMTP id n10-20020a05600c4f8a00b00413eb74fe46mr7167867wmq.34.1710689848939;
        Sun, 17 Mar 2024 08:37:28 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id l24-20020a05600c1d1800b00413e6a1935dsm12100649wms.36.2024.03.17.08.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 08:37:28 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: ritesh.list@gmail.com
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thorsten.blum@toblux.com,
	tytso@mit.edu
Subject: [RESEND PATCH] ext4: Remove unneeded if checks before kfree
Date: Sun, 17 Mar 2024 16:36:39 +0100
Message-ID: <20240317153638.2136-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <878r2w4n0k.fsf@doe.com>
References: <878r2w4n0k.fsf@doe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kfree already checks if its argument is NULL. This fixes two
Coccinelle/coccicheck warnings reported by ifnullfree.cocci.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/super.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0f931d0c227d..9b7a0b4f2d3d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2079,8 +2079,7 @@ static int unnote_qf_name(struct fs_context *fc, int qtype)
 {
 	struct ext4_fs_context *ctx = fc->fs_private;
 
-	if (ctx->s_qf_names[qtype])
-		kfree(ctx->s_qf_names[qtype]);
+	kfree(ctx->s_qf_names[qtype]);
 
 	ctx->s_qf_names[qtype] = NULL;
 	ctx->qname_spec |= 1 << qtype;
@@ -2485,8 +2484,7 @@ static int parse_options(struct fs_context *fc, char *options)
 			param.size = v_len;
 
 			ret = ext4_parse_param(fc, &param);
-			if (param.string)
-				kfree(param.string);
+			kfree(param.string);
 			if (ret < 0)
 				return ret;
 		}
-- 
2.44.0


