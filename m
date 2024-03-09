Return-Path: <linux-kernel+bounces-97968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F5387727F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 18:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22611F21A81
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 17:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FB723769;
	Sat,  9 Mar 2024 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOtyUy9j"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECA722325
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710006465; cv=none; b=LeaNEeCjuOKaMWOZNqt1BYlFVa+ZK0kaZTegzWM0Y9JKjfWXUhFUK+GYn6f264MYsyIVifnz6s5XL1MiAY+XSTGZ1hTcvK2dY+xB2dIbmJMVZm4SbE+TBg6HnalDRU91bww6jpCdTsYu2A74FNKbY55oQFp9lwBx/PXPEXyvbJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710006465; c=relaxed/simple;
	bh=/pfdieOOOArzQ/G+FxSqr7X6O+DxBVN8AQi5AqPqfxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dlEJCBVNqjcGwbzkjKx9SUrS31tdOb9V0txvYCmEUY0jH+PTRVOxn8HvXe9lmDdqa4iPuseVIm9IZSgNbMGMGRPM/dwAhTAZjwV1CriF1F2epdb60vuFIoPURl2gnG0gLWZe2PLQvc7yDUxhFaAZk4G45BM+l65TKrfgfpyVphY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOtyUy9j; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33e8abc8a84so162116f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 09:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710006462; x=1710611262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fpryfr5/lV8PUno+vpvTtNWwBYk3RmCy3kDaW2apis0=;
        b=TOtyUy9jjXhBwpzyqo+eEcshKGEUoogINFCEITeot9VWi6FBA4lKasICjjq/GW0WmJ
         Ey96IoOv0gWDvtylI6ZkAC/4I+09Ty0MDzRtdzwmVsQuGJ2Afcx5oKG6tO0pyVNCHeoX
         1TDTsgTPr8+5YPpAvJ/KUWrGhJ22R1tmXc63QCJuP4SJ2N8HVxXh/nqTOTuLBi0eR9bA
         PntuLw2NoOcy7B+a4aCUPJxgA/5aUCSgBWiCRrYQn8vo7vz1O1NXvgUsVNvPhdFc6DUz
         dwWVDsTx+XQgnXRr0kROqbwJuwyx6b5rCITxwfgpacURTbrMLV4i6T8Nm8taKICz3uFh
         vv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710006462; x=1710611262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fpryfr5/lV8PUno+vpvTtNWwBYk3RmCy3kDaW2apis0=;
        b=um45J4G4R89Nm+SmASp15MtI+EzK6yxN3WRanLx7w5np0EpKH6XtjVAzxuSBY6U1rP
         Nr/wM+GdMI5EZynYFTTAMZlZQHHuBOWUdVCFBpz2FBafbsrjr1YOJYDTTjHgUz5jAIuV
         0cS6klNmYvRtmkh/G05UucFIs6ySbv/rwz0PUcpbCZ+jxzh9GLe6wK/CAmuAv040wQ27
         L5b1QpjfyXi+ACvKBCT/t3BGWG5Dh7+3Z6PN+e/8ulr1AGcRnQExBChVgGFtEvLkFKbb
         xRhDj/VtTXWjJ4Gql87/049svAF/OWxwqlyck4uMuQShSRucL/bI7nkuoqY8QwXuVkZK
         sxwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxeCisQVstnpeTJsj9/OokxDQuYJMAcOlVDy3XTr8jmH6oz/Wz+EV+QD20CjRs3TcOYxuM5gmmBllHj3WpzYLskilNVDEEiyTmCVii
X-Gm-Message-State: AOJu0YynRXc5gjdUIJ7PwPJ/Y2rvmK4AszzEt8DwWgfQzHymAhyEk+jy
	SKuoQ0MIR92SIWnujYg9s2quQHUhADjrYks6NQHGgzM9v1GkDqp8
X-Google-Smtp-Source: AGHT+IHiEcGuvfJ2MCWLK7gjgZs3FQVeaR2Wj/XwdVbSVRTzJqWafwPTc+Z4Qb79NEiGubeXlLtjSg==
X-Received: by 2002:a5d:4a0d:0:b0:33e:20a:99d with SMTP id m13-20020a5d4a0d000000b0033e020a099dmr1778552wrq.30.1710006461591;
        Sat, 09 Mar 2024 09:47:41 -0800 (PST)
Received: from ubuntu2004.cynet.local (vpn1382.cynet.com. [84.110.53.106])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c358b00b00412ebd587ebsm9727434wmq.3.2024.03.09.09.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 09:47:41 -0800 (PST)
From: Ariel Silver <arielsilver77@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	yogi.kernel@gmail.com,
	straube.linux@gmail.com,
	dan.carpenter@linaro.org
Cc: linux-staging@lists.linux.de,
	linux-kernel@vger.kernel.org,
	Ariel Silver <arielsilver77@gmail.com>
Subject: [PATCH v3] Staging: rtl8192e: Declare variable with static
Date: Sat,  9 Mar 2024 19:47:22 +0200
Message-Id: <20240309174722.3463-1-arielsilver77@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed sparse warning:
"'dm_rx_path_sel_table' was not declared. Should it be static?"
As dm_rx_path_sel_table is used only in rtl_dm.c it should be static.

Signed-off-by: Ariel Silver <arielsilver77@gmail.com>
---
V2 -> V3: add patch version number and changelog
V1 -> V2: fix checkpatch.pl warnings
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 330dafd62656..5b52bc992a61 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -144,7 +144,7 @@ const u8 dm_cck_tx_bb_gain_ch14[CCK_TX_BB_GAIN_TABLE_LEN][8] = {
 /*------------------------Define global variable-----------------------------*/
 struct dig_t dm_digtable;
 
-struct drx_path_sel dm_rx_path_sel_table;
+static struct drx_path_sel dm_rx_path_sel_table;
 /*------------------------Define global variable-----------------------------*/
 
 
-- 
2.25.1


