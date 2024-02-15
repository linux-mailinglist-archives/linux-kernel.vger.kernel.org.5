Return-Path: <linux-kernel+bounces-67367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54457856A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795511C23696
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B448136999;
	Thu, 15 Feb 2024 17:05:22 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C125113666D;
	Thu, 15 Feb 2024 17:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016721; cv=none; b=EyFJ3tWEROxG8S2TpGdew5Dv8UFb65dgo3Rmh4ftbQ7ct62Te0E18YLG9pOs69HZUdGJmFuPREgFUOx2KhRpDRKov64WQfUOgAs9ZAC/hdG/B+TgVYgkFy72sribWfe2MwwyIlxnAGEG418QmRjxc/I1+yf4U0uP6Mr+e/6EkwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016721; c=relaxed/simple;
	bh=ZJKxsH5Cr0XFznZUyCBX+l/QkRNCKGBmvnZMLkrtVF8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p4ZIU4R3cVGlNb0Lam/OhdZnTDYX3yQj9oHwmWMy7MvtgRk5OLxDdwyc034vdp4XaklFWvMZ0tDmRoSjA22SRW5GRTsbo8T5GaeJHxkio7srj2eMQmKbDlF0V9hkemEDM7D9mJmmdMzopuFGqMchdVc36iYpx5jyLArp6H5jkmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-563b49a0f44so1321759a12.0;
        Thu, 15 Feb 2024 09:05:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708016718; x=1708621518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itdKMY5sCR696Z1aNNcyo052D3kyhlXW5LOJNDNYPz0=;
        b=eaFCVjyXyVjuRV+9yCnDAeLECW6Bs9+N+Sy4Tj7fD0dzLE3/qOFFUHqQntX7ypoY/F
         hNIoFWcBpbUrx+G/LcyuK1w4LgtLg2LPg+0aDXm4E1UAdRupz59uJBoRcvJcfS6Mc3VB
         lDK1NUgPk9DxcNBmt0Ay7qrPIoPnObTmVkLO0fQp3l12BmZILrOoUjwHuqd9SpjRRvmL
         PAcJn4dtQGm0BAqcAnF0+uWIfpX7dICtwoGX5Qa4xvHyetgRM4bB4guRMUpOTlK50g6c
         JrDBOs7GvQBw2NUSj2vd76jXZEZo2oWAZ1w2ZVrDJibUHf1nTN/RNFmgkADD+HkUT+a0
         8elw==
X-Forwarded-Encrypted: i=1; AJvYcCWe8XyghTFle+J1R437Z7SDkVx12NOA/y8Tn+j79ojqoG2VHMPIJjTRNITc2TheHHVGo0j5jEPMWMoULMPGM54BQGNH33lUaGbt3Htq
X-Gm-Message-State: AOJu0YxeiegKAkMrolmoX9B5mKZ6w5oB7Z6HWdb9Jxz8feXfTQgQPqgM
	LzhI/95S0r51HtRTloihapNyxXhWpEiX2P+vN8hot0Anv5zsZGOV54hNLhBE
X-Google-Smtp-Source: AGHT+IFZwrCLI4tXOZ8gzbCMuJ6284GfZo3cSuo2KqSdEFXiTzie0GNurZ6PPkZYhv++L9XJ5T+MLg==
X-Received: by 2002:a17:907:20e9:b0:a3d:6cb1:1889 with SMTP id rh9-20020a17090720e900b00a3d6cb11889mr3031736ejb.23.1708016717662;
        Thu, 15 Feb 2024 09:05:17 -0800 (PST)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id dk24-20020a170906f0d800b00a3d81b90ffcsm731472ejb.218.2024.02.15.09.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 09:05:17 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	therbert@google.com
Subject: [PATCH net-next] net: bql: allow the config to be disabled
Date: Thu, 15 Feb 2024 09:05:07 -0800
Message-Id: <20240215170508.3402883-1-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is impossible to disable BQL individually today, since there is no
prompt for the Kconfig entry, so, the BQL is always enabled if SYSFS is
enabled.

Create a prompt entry for BQL, so, it could be enabled or disabled at
build time independently of SYSFS.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/Kconfig b/net/Kconfig
index 4adc47d0c9c2..3e57ccf0da27 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -331,6 +331,7 @@ config NET_RX_BUSY_POLL
 
 config BQL
 	bool
+	prompt "Enable Byte Queue Limits"
 	depends on SYSFS
 	select DQL
 	default y
-- 
2.39.3


