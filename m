Return-Path: <linux-kernel+bounces-44807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 680438427A8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20877281453
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E10811E0;
	Tue, 30 Jan 2024 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRm4fMm6"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44037E571;
	Tue, 30 Jan 2024 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706627334; cv=none; b=kAddFpAVaOJvEAZeCgp+kIlMUcJRcrU4dC5qlpLo4cwIRJXTlWJIPUyDuVl54Oo5DhNJdffY89XvKasShh67V473ClvRT24f6i9bHL4telteWzTbKWzwBWtNXmm2JlxaSm/lSnoC/9DKaxigqD8DVhVoWgkaeRsKyMU6/yOXir4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706627334; c=relaxed/simple;
	bh=gt6ZBFTnKL/5sBV+c5oeWXN02iUnRArxPefZndY3Pnk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d/nqKerMBQm4+wSSTK5Q4ycAYp9fO9qnh0/SVA2Vkcbgm1R0QWwPqhFt3vRGYHzm/3R3cWlTAOStCeX+nBob5tuROnpPNZH0E6GSnXEDO6HgBudL85TuhbCmF3LOhDGh91VG4qopmlz6Die0T5007eZaB1MwqdBYRDZPl0dAvIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRm4fMm6; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33af4a0beb3so1142022f8f.2;
        Tue, 30 Jan 2024 07:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706627331; x=1707232131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KtGjQl1d9FfHCqjjrdy9wKAjB2t+XgpMCiYod9Q5V/Q=;
        b=NRm4fMm6/UB3dZZxrW/vLL75nZGAmVYLlHDj7yanWQQXHiwX4VSwslRB2V0HSuTzmj
         t53lhi8+Kt+u+Zp18w2SNsL7Dc3j/DQTnH9MFEk+aYJJNtcJTDwjghd4nmae+7F/h0og
         0Wh/rWXuK7Yzcr3jRvNxuSBNDPtuq5fwuqLL0O2WGFLQoUPFUclycGjsHzcEQdyZZBwy
         HXaP3OsaEZEcLYxSZbAr8RHC1ErLr3GD2F/PRCbrBUsz+ZgYZsnD99Vec5hhuKV2VFv2
         qZ7iP72qF7Rc0tFlxeaiyV1cnDCtkUVXA4yu/JzyvWi+0sd2lgiYI8y5fNkZH0a5wGZo
         s8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706627331; x=1707232131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KtGjQl1d9FfHCqjjrdy9wKAjB2t+XgpMCiYod9Q5V/Q=;
        b=jYVcMRfD/jiTGQ0rJETysr4bh54L4GOJMeQDwZ72rNY45hNbQUWd0x78Iho0VyIa/U
         lvdSKhE0OZ3tsgXVN0ukKorCdXYyzZMs9v3D0eTU/Y80K6+u27CTJ8jUg+AsPwc2RLpq
         VVLMvyn8LHn/yuG505xhfi5K+EoSvYWoIatG8FPi3S0TrPaTBmzwM9IMnOdLTfdoFi7x
         cCzFlMuPmy3iLrAgee47MyAHe1aWuZ/X3Ngu0K8EWKQK5HcMFSKBGyZ38BR94v44hIHh
         cwPAMQeyI1cZqzG/1LbPIR3Lkij3YrPa6t6eDPYrofbpSETAB0mM+oR0AlC7rk7W8jU7
         3VSw==
X-Gm-Message-State: AOJu0YynCVGKPIB8Mr8A3Z0NHOh+otE3XL3q30eruuFlHvxf4B6SQoR3
	vj87+U3FdVuAqOAq6PMmson70K3+3vtHFYfpeSAst3SjaksuQ7hYav0JyeEf
X-Google-Smtp-Source: AGHT+IH0TasqRgTVunzA7WkX9JfHL9rnihj1JwXqPzmOH1JcDmRE5c9xJSHuLlRAPT3DAvbPCfCRAg==
X-Received: by 2002:adf:f9c4:0:b0:33a:fd2b:bcc0 with SMTP id w4-20020adff9c4000000b0033afd2bbcc0mr920850wrr.5.1706627330713;
        Tue, 30 Jan 2024 07:08:50 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:1b62:fd0:29f3:5f7b])
        by smtp.gmail.com with ESMTPSA id u11-20020a056000038b00b0033aed5feea4sm5821983wrf.54.2024.01.30.07.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 07:08:50 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] ASoC: sh: rz-ssi: Fix error message print
Date: Tue, 30 Jan 2024 15:08:22 +0000
Message-Id: <20240130150822.327434-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The devm_request_irq() call is done for "dma_rt" interrupt but the error
message printed "dma_tx" interrupt on failure, fix this by updating
dma_tx -> dma_rt in dev_err_probe() message. While at it aligned the code.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 14cf1a41fb0d..9d103646973a 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1015,7 +1015,7 @@ static int rz_ssi_probe(struct platform_device *pdev)
 					       dev_name(&pdev->dev), ssi);
 			if (ret < 0)
 				return dev_err_probe(&pdev->dev, ret,
-						"irq request error (dma_tx)\n");
+						     "irq request error (dma_rt)\n");
 		} else {
 			if (ssi->irq_tx < 0)
 				return ssi->irq_tx;
-- 
2.34.1


