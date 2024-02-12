Return-Path: <linux-kernel+bounces-61239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F341E850F94
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324131C2163B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD89310976;
	Mon, 12 Feb 2024 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meURJ3wW"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6643BFC16;
	Mon, 12 Feb 2024 09:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707729405; cv=none; b=iQoqD5/TQtNAWOS01C/CsY4WORp/O8DWVcBTH2OP0Nn05fKa6gbDdoTb5/oXmQM+BItPD02nK3kdKvP/MS+h6ncPuBlp4zh65i0ecGk+1VSVN0KkdzgbVAIydBxlYBlE8V4HMHrQ+Z7cyN5SKuvocGFNgf2N1+BKCLvDJYYDd0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707729405; c=relaxed/simple;
	bh=jem5k4bGc+h2XDWT+BquRI3MFaXWbMcWFqhA0J/tGN0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DAjFxq7/chjAhU5N+6BkSbBtWmNerOjcvMfuD0si9i7bfFtEx6aJk11y4grKVK4pZdo41koIc3DsoccfQNldeUPetotBdkQUuM7wC9u6xqU2t5xNRSKwpKEV+kwv6Vtjp+PTLf/HWh0zbZDz04NCtpg3MgKTWwSlHPNwnDWCUdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meURJ3wW; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d0e2c90f84so27097731fa.2;
        Mon, 12 Feb 2024 01:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707729401; x=1708334201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AxW0bWP9rC9TBnm8nLzYxQGxIyi/0W+4SfDA3jONu9w=;
        b=meURJ3wW2TWyl2Jb15qlMm5V0e3Gs7+Wmb0xjVlPdq38jcuyDG3nd+tZ+DY+qAyc9O
         Tw/pjDR/zDIMDu3ORd2D0cFVOt2aAXRJ46qlFB0VtoFrBpL22UnY81N7iuk5ohKrPOEA
         dzv40LWXQRAQ1l9uDGqIgijJhL7sOta6IiGIvCylThw5JJnPRrrec8kCFgtuKC1z4iUw
         o2yd4TQGe6MLBbm52dW14b/Y2s3WsZD+8nwJfzjJMyXbK2moAQJC6zAaPCERw0ug5ThY
         BDSAXhV1qaK1Mf3LSrh3k6ds9KSuXYJD6uSSbhKAaY0iJAzWbiQelRZFWFJygl+Lx9y7
         lXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707729401; x=1708334201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AxW0bWP9rC9TBnm8nLzYxQGxIyi/0W+4SfDA3jONu9w=;
        b=N9zodh8eLTRcdF1zGruuEhsPW/dYKB+4ZMcL51Ilha/owhn+xiF2+SsrRZ0Pzclnfj
         zmGpRqsERGwnQbl/Y92QzGy0gZ11nSXZyAMlJKt+dnd3ssEjB1DVyyjlu/8B3eFEbnlE
         YZEppPoWL63zNDtSfPKgt55lxqDoqYg9Y4XaQdyBV+doN2pQsB+TRF5NScNJ+1uas797
         QxRqJQQfdYTFOAjyK3pUj6Fb52BxzmkqiNc+AlfKDM/BPakMtLgKtQiP/fo9TcJnnElY
         WkTkRsV9AmbyLSsHXS6yu8bSREYGtXL7Aw4TvZglSa7EfwRYjDPhec43RZmSaLA3qKPw
         EBSw==
X-Gm-Message-State: AOJu0Ywr3SZFNAI1q8K94+dEadN+mcXyjGV9wh01zrUY4agqpOJyNgXr
	4AR/dCpw3huEU9E6TrJ58J1favl2lKJi+vMtUegiG707fIzMGGxC
X-Google-Smtp-Source: AGHT+IGMxAeXQ73tEFCKuRljVUNbVHyrutNzbh8cK2XcTkZS6b8oVk1/1ZkV2eKuK/O/B1GzmYXnPg==
X-Received: by 2002:a2e:984f:0:b0:2d0:ef5a:345 with SMTP id e15-20020a2e984f000000b002d0ef5a0345mr2416399ljj.49.1707729401109;
        Mon, 12 Feb 2024 01:16:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVVryjAGIlEjHJv74r/GrMu9mtF/di1P8Kq7huZsrTf966i9h2a8GAHPY0aVzLf+sD76wJMBAWgQPCS98J2eBAJLqhU9xJfD6ex7BizcqXJaNxCV/va751zFHjBkrv4zWi7yMSXtzJzHpwM3skZlxqFzs8fd/I4OSO5qqmFIAh0jTON0Hhn+Pt80h39wjOBFIkR7NabrytaTN9JmHg1Sq7YVh1UB4d0dDQl3DYYjxl0hNdlLSKPxetK4qfvQy1IDhQog546CHYwuo/iI4kTjPpbswVoH9NA8sTFe3tP9x47UG2WKi+gTrVLlbU8r1WU0+CCdCJADgeIaEmMkuFNcqg2us82mJ6bBSpCPJBJauyAX7wjp9PRvOA/6wNpKQJdu/eYPVU+dRWa8aA8blQyu3f0NEvfpsq9k2DZ1kDXobjcjftOL3uun/h2Xp+Kdya0t4PeOX2G75D86Pwe1VWpOndJB6IVuMLEAbB5mQ==
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id cc5-20020a5d5c05000000b0033b75a1e8cfsm4811375wrb.24.2024.02.12.01.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 01:16:40 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/msm/dp: Fix spelling mistake "enale" -> "enable"
Date: Mon, 12 Feb 2024 09:16:39 +0000
Message-Id: <20240212091639.2397424-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a drm_dbg_dp message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 03bbdf865d26..320f17fce9a6 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1409,7 +1409,7 @@ static int dp_ctrl_link_clk_enable(struct dp_ctrl *dp_ctrl)
 
 	ctrl->link_clks_on = true;
 
-	drm_dbg_dp(ctrl->drm_dev, "enale link clocks\n");
+	drm_dbg_dp(ctrl->drm_dev, "enable link clocks\n");
 	drm_dbg_dp(ctrl->drm_dev, "stream_clks:%s link_clks:%s core_clks:%s\n",
 		   ctrl->stream_clks_on ? "on" : "off",
 		   ctrl->link_clks_on ? "on" : "off",
-- 
2.39.2


