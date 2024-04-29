Return-Path: <linux-kernel+bounces-163114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E01BC8B65E9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06AABB212B7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD5043AA1;
	Mon, 29 Apr 2024 22:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TU0otH5G"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893232561F;
	Mon, 29 Apr 2024 22:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714431094; cv=none; b=cPniosq8peyQKEV9DwEuf7f1luUO2uYhYwtHDVh5qfuGWSCZSUYvc6OXnFaTeyqhahKeAxWzPLkBJOWgqd8cdvXCJqFKUyCG0UiJ/9OC5p43bXswll3snrfFC4Li+I9f2iPlSfIshWw1tGGbvRD3d9uhtXWDQ98kELh7LqsgqLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714431094; c=relaxed/simple;
	bh=0VKKG+/MRHxZ5zvfz7WQUGj8U1xV2HSSeJPTsaTJWTs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=udqY9iGkDTuHgbFBX8hyVNLVbh4bjdMtW6Zy8wMSz1jzOLGXPSfs31J6HXAZPJKtLfP3i4IA+LRTE2fdVtmFYrxhFS6dnYaJBbyP7G5jnueJM2EyAp5DdKa0aPl3PcA7SqPnBIFkhZE1yEQLixIFzCeimmUUDsAMLOA7GkZz6PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TU0otH5G; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso4519613b3a.2;
        Mon, 29 Apr 2024 15:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714431093; x=1715035893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0GQybxBCQIzUHs6cWJR+BEq7BKv8ohBRppC+jb7zUHo=;
        b=TU0otH5GS//J4wsH1K6J9GROLs1y0lz9PHaXocc7j41QZiPWY4tU5j0KWLXc7eu22I
         aS6je1PyYjkvvICssg869HOEuGlIEt7s45kJnjI0INh7xE3UzGmq2KURUOXK9mG+DP+o
         YEbrHWvtApWZKzkWVT6SUIkj8rdpNqv0H3xaROj9yOWKWxexVZSmzwR+aLirTvl3hk02
         7zH3wVNUfZsKH2MPOtq3EwN5rWGDnw7bAknpwqxYTgBcRlA2URUpds6JQIFpABzUUlyU
         cas7MiLzL6R3WQJeJJIgc0nIlYA7sYYcacgmaMRL7xDpUVfHKehAugvkXd37VO6zFrw9
         I/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714431093; x=1715035893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GQybxBCQIzUHs6cWJR+BEq7BKv8ohBRppC+jb7zUHo=;
        b=enaOSL6Hs3AGfm4xZk5+hkyxKutWZmUMmhormlH/WJCgJoSgLhoXhP+YEWSCEdnC6K
         FomGZDL1lNqN5Njk4LwUMq69JrPNDMJ9bnsWTVIh1rBTvTTrx0t3xOpBhxDQhE6N0J2d
         kt7eeze95YbWkBKfMPzw12fCc7VZhMKt/6nuupR0Gx1Hd+evHErUb7hxM/RMBEm13QGq
         iz6aEm4NPJpdnu7cy0RXeOml66RNJqAoocVMkS6+f7Hq3WU3pKsicQUI9QYK/JNc+xf8
         LQNGotdT4BDggD1TYhjtCFIZ3GBedj7ja/yKSW3OKz6ovU/qFX8GTZWUa1MzEQIv1Xxc
         VkZg==
X-Forwarded-Encrypted: i=1; AJvYcCWSKe9vg4YyehLuvV8QIkDTJ/ptw3ZRBF46EYyptUwRkPexHxgawxlHzj/9g70iI47luFz6Dsu3JHPstl3ywEmIPPA90z0OEeua3+KDleJZr2qvr7R3ePZxerjqwsgVsW+8JGU1
X-Gm-Message-State: AOJu0YxsTpOeO1PXSLbTGkxhDPK+vjANLV3YtTBzp+AtcxMG/xDwAstJ
	sktDdXmLvyhSr7whqlIzt0xa0mY6xH4JpOrNAcRdwerImasPW3WQzrO593z0
X-Google-Smtp-Source: AGHT+IEuVcuq6ujat2QJAa27PDqEgKnECV5cPO7TC0iv2mewdglY0NN93dnMKUP8D2/hbQ8g4hZ96Q==
X-Received: by 2002:a05:6a00:7114:b0:6ed:d8d2:5040 with SMTP id lh20-20020a056a00711400b006edd8d25040mr10823106pfb.21.1714431092773;
        Mon, 29 Apr 2024 15:51:32 -0700 (PDT)
Received: from fourcolor-Home.. ([203.121.254.74])
        by smtp.gmail.com with ESMTPSA id fm8-20020a056a002f8800b006ed059cdf02sm19841235pfb.116.2024.04.29.15.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 15:51:32 -0700 (PDT)
From: Shi-Sheng Yang <fourcolor4c@gmail.com>
X-Google-Original-From: Shi-Sheng Yang <james1qaz2wsx12qw@gmail.com>
To: matttbe@kernel.org,
	martineau@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: geliang@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shi-Sheng Yang <james1qaz2wsx12qw@gmail.com>
Subject: [PATCH] mptcp: subflow.c: fix typo
Date: Tue, 30 Apr 2024 06:50:33 +0800
Message-Id: <20240429225033.3920874-1-james1qaz2wsx12qw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace 'greceful' with 'graceful'.

Signed-off-by: Shi-Sheng Yang <james1qaz2wsx12qw@gmail.com>
---
 net/mptcp/subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6042a47da61b..c794288f6224 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1234,7 +1234,7 @@ static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	unsigned long fail_tout;
 
-	/* greceful failure can happen only on the MPC subflow */
+	/* graceful failure can happen only on the MPC subflow */
 	if (WARN_ON_ONCE(ssk != READ_ONCE(msk->first)))
 		return;
 
-- 
2.34.1


