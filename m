Return-Path: <linux-kernel+bounces-135801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7F489CB82
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607941C21BCC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1AF144D0A;
	Mon,  8 Apr 2024 18:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oa/maYBr"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3C41442F3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712599799; cv=none; b=UnZ2ovbo3I5m1JeAz2XSei6a5K+8A/pZ96gPpy3Vd4A7NmDxTnjny3ATvgB25zmcKds1L7/fWitoU0RnoAJYHyxp92aBxWhW1/uLtOBJ2LjOX2jNtFLiBBG4WF12FKWxb0bpJjrHvFcwKK63BFuY2eIYGf6e6FM1M8nN8E2PCLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712599799; c=relaxed/simple;
	bh=WP8hAFXeEVd5tHoNZiaf7s8D8tEPRQgQjUGi1E9MqKs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=q8EKqi5ZTLwrmcITnF3nnXpWDam3Eu76Yqqz8LI6Oa8/wCP/8H9NQwbSFrxfVA2qEil5LkR9Cw2JTTOurw20lGTcHXa/Vy455EqDA8STQXQ87NtxY2iFC/BskX9DLzNDlCmMlcMi9jJvCo1NRWeNLiGuuw9CGAN8S+dkzYMbFPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jfraker.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oa/maYBr; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jfraker.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e6bab4b84dso4668210b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 11:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712599798; x=1713204598; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dgbG1Kt8OxqM+KCQPgmquqh3ShladChtxEoh6/p4jxE=;
        b=Oa/maYBrXDZ8MWW7hDNFr9Qm4xuJxoHOgHIZmDo5S7LH4MO3peb0+4wDE7Buvql20V
         7K9q6fD9BXm7XpoQmi5cgJqGq5uMoBjPYjANen4IxaOaG2DCQRHKdIhih7cLbr2r2XkU
         JcfQwjXb6uYQhNhYeH5B+MkHaXOOYH7Gy8UPO+JCa/NknnWqilc75osLvX2MB8HZOBI9
         ZOQ+vGjkXQdNVaApaA0PxJeJjwgCaTUMvTVm0wtzueNvpeX/IaswS69/FwmbHK083U1i
         0fz9FvQEtUUIvBQwdvCyekd0tXiIJIMSIABpGjLR6OkeIiudxYipl5Yl/VVjyBngIkKi
         Answ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712599798; x=1713204598;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dgbG1Kt8OxqM+KCQPgmquqh3ShladChtxEoh6/p4jxE=;
        b=TONIEpGWj7YZn+iBgOsBkJnc6HmdsJxFMXf9cqqiF+HwcC8LmEVysFPfgUHn2JGeJF
         owrHcex8njN/mzdVX08n1641bk2KSIor82BN8RW29FGWbrZrz3gleUr4urEip0t6e3Z6
         3cLVhk8gHIznRzl+JoNSq4k27Uxfbwx7h/b3566aWnvXfYaHVAZ9FfKVdYM2v+w+7AR8
         bTKIGbD8hlrY3KxxO3lZ4j+ECkrzDOyWuOG8GCkYB7+vhJrDph9rRQK4zlY9BPcPaRYB
         aPEPynsZv5OYJSLzN/jMtNgPqxqOU18NKS2xOrBELMio0AM/xEHjxrIoe92LlXoxCmKf
         iuug==
X-Forwarded-Encrypted: i=1; AJvYcCXUDzgo5k/tug8cNnJUrwRfnhaa9kXmXLTqJcV6APOHi76M9Am6ulvBmJCK9tn/PU2nCnipVGYb62eKzvgRdlnSzKr+Z1o/YR9hDqV7
X-Gm-Message-State: AOJu0YxcnfWSdsaIy2LFyRVFJC+3Qv9ABVfxsH252NomV8TwE0ioe/yH
	jrkwB6Nam56+9dxb7Bxpesr5iF/J39SW2HERvYjgVEVkHi+lWuyBUGO2nI9UqkMV0J2JjpUMsmi
	fLyRJ5A==
X-Google-Smtp-Source: AGHT+IHEQdg+WFK20td73HXYL1HOcs2r0AnCOwnHy4r3acAolUl2JpksDFSa12UIh86gW5W6t8zQ6Ud+xxdx
X-Received: from jfraker202.plv.corp.google.com ([2620:15c:11c:202:81fa:e559:a246:3147])
 (user=jfraker job=sendgmr) by 2002:a05:6a00:2d8f:b0:6ea:c7a2:b4c5 with SMTP
 id fb15-20020a056a002d8f00b006eac7a2b4c5mr866601pfb.3.1712599797626; Mon, 08
 Apr 2024 11:09:57 -0700 (PDT)
Date: Mon,  8 Apr 2024 11:09:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408180918.2773238-1-jfraker@google.com>
Subject: [PATCH net-next] gve: Correctly report software timestamping capabilities
From: John Fraker <jfraker@google.com>
To: netdev@vger.kernel.org
Cc: John Fraker <jfraker@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shailend Chand <shailend@google.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Junfeng Guo <junfeng.guo@intel.com>, 
	Ziwei Xiao <ziweixiao@google.com>, Jeroen de Borst <jeroendb@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

gve has supported software timestamp generation since its inception,
but has not advertised that support via ethtool. This patch correctly
advertises that support.

Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: John Fraker <jfraker@google.com>

---
 drivers/net/ethernet/google/gve/gve_ethtool.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 815dead..99f5aeb 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -4,6 +4,8 @@
  * Copyright (C) 2015-2021 Google, Inc.
  */
 
+#include <linux/ethtool.h>
+#include <linux/net_tstamp.h>
 #include <linux/rtnetlink.h>
 #include "gve.h"
 #include "gve_adminq.h"
@@ -763,6 +765,15 @@ static int gve_set_coalesce(struct net_device *netdev,
 	return 0;
 }
 
+static int gve_get_ts_info(struct net_device *netdev, struct ethtool_ts_info *info)
+{
+	info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
+				SOF_TIMESTAMPING_TX_SOFTWARE |
+				SOF_TIMESTAMPING_SOFTWARE;
+
+	return 0;
+}
+
 const struct ethtool_ops gve_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS,
 	.supported_ring_params = ETHTOOL_RING_USE_TCP_DATA_SPLIT,
@@ -784,5 +795,6 @@ const struct ethtool_ops gve_ethtool_ops = {
 	.set_tunable = gve_set_tunable,
 	.get_priv_flags = gve_get_priv_flags,
 	.set_priv_flags = gve_set_priv_flags,
-	.get_link_ksettings = gve_get_link_ksettings
+	.get_link_ksettings = gve_get_link_ksettings,
+	.get_ts_info = gve_get_ts_info
 };
-- 
2.44.0.478.gd926399ef9-goog


