Return-Path: <linux-kernel+bounces-168159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5F38BB476
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6839E28173E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7B1158D78;
	Fri,  3 May 2024 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnqBxSL+"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D62158A11;
	Fri,  3 May 2024 20:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714766488; cv=none; b=bHnPttwz4RRVK5vIX2o/U0XoAWCZOSGDefMqp3ztqlbUL5XK0OSSvy/TE29e1o+4DyK2ppK1K2S2uZlwt4pH/MuE7CssFqhHvjFeX6tj14GKlgvqAOA/uie0E0E2XKl76GZ+Ht6Rl+iArNmhobKazNuPCRGKEgYeZ/l0rHFppoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714766488; c=relaxed/simple;
	bh=hPEqob8cQJS3NsWU5XrkHHRjPy8+sKpmtawBRZMffhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AldxR5ytgbN1bnXqVXDViA9wVoSC3APZyW3YadirQ8Evr+gkYX5HtNufjsHYxJUUc/gqg0n33GvLvq/4CQwV3azkWdGLYYQr7VnXLsMS7mUMyyJWsPTA1CRNIQqE+2bxG0pJ0hcoQ2y2htQvo+sRBtERcuo+lwa2CeQfFLgXItA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnqBxSL+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ecddf96313so305225ad.2;
        Fri, 03 May 2024 13:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714766486; x=1715371286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YfhSmmcDj/a2edtCK/DxZRFrA53blVaphRlpcsRhEhE=;
        b=AnqBxSL+BLK16BMSaHSKj8qWclghvs0r2FyDIaLu+6AqNKlSGdtq25qT7ySlPjefNj
         G/oPM8UkQ4CH6FQii/RITGXnBjPC8xffH8D+V0fLP+OrQKBavfZBZMbdod5d2VfvcXV+
         x+m8k8yYms6f4esyGb4kGqOe5TS9WAPax2Yv9ap9v/qY9HOEwdCsZyFIV7P1AmjMmHOo
         0TOmLUSgirbr7fRZgKwfW2iO/IOfcn1TUQl5yeugnhoWwAe14Wvtt2M2g+rKU7oq+xG/
         c52B0W+iq4Q8c7BZ5i+dSfUU0YoeAGR1qD1RCh3fYpdt4RBQ3b9saX9eBn/bK3Dm5Tc+
         QG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714766486; x=1715371286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YfhSmmcDj/a2edtCK/DxZRFrA53blVaphRlpcsRhEhE=;
        b=FQWn+9ENWLzmrf8wp6j1V4wyKlpKNqHqpzW95EQTaykZEnJlE3YpmBHf1f3Kc4dvy7
         fne2dhRI8ceYZKSVfr30SxKfOPGVhTku1DmFJgOL81HXkZ6T4G5oE4zqspv4lrTJPYqF
         Ar+x9o1aQGFMNzuIOCCoWQm33IHhCXUgnGHJNR2pMHxjeyUuo8JWFDJFRP3iQjia3zoq
         TMVW5RmY8ZlAPNC4G6dU6AxDaHOPqUuhtpdbE/oB8wBqs16TADukqg9StQGY7weiJHeR
         ZDZ1WyaU30KM8UMj5/i5ZrEQcGaulLzGIoNSGmJ0xbkrHAFFEP9NOu0dzhN9Gi2g1ado
         QuqA==
X-Forwarded-Encrypted: i=1; AJvYcCWjXUYI/yQdInxyluHjS7RK0ViRl88nlvVWt98NYLsyYl7AzOQw6rUbc1UGoXyxRFmp1SAxSge9D0On9HVbRR1jLWnHMdvH/m1sq2wfxf0ZSsm035fpch2uoc2NGPndjHa/5XPe
X-Gm-Message-State: AOJu0Yw0aKeMzHEUFGAm7cnKKruCFY5MeLtA+1Ji7livMs3pU1brIt5I
	drsrawZ0r7Copz10R6eDSctccfMZuD7lJqWcYkyo9kO94AhCwuzf
X-Google-Smtp-Source: AGHT+IGKbgsuBPLYBmLsJqbPT/EtMURV5XOK+N4g06YiOkmBh4jZi0qc3MZ408O+YCIxq/IZiy539g==
X-Received: by 2002:a17:902:b186:b0:1e2:9066:4a8b with SMTP id s6-20020a170902b18600b001e290664a8bmr4052338plr.26.1714766485707;
        Fri, 03 May 2024 13:01:25 -0700 (PDT)
Received: from frhdebian.corp.toradex.com ([201.82.41.210])
        by smtp.gmail.com with ESMTPSA id x21-20020a170902ea9500b001e510b3e807sm3595205plb.263.2024.05.03.13.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 13:01:25 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Sean Anderson <sean.anderson@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: [PATCH] net: ethernet: ti: am65-cpsw-nuss: create platform device for port nodes
Date: Fri,  3 May 2024 17:00:38 -0300
Message-ID: <20240503200038.573669-1-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

After this change, an 'of_node' link from '/sys/devices/platform' to
'/sys/firmware/devicetree' will be created. The 'ethernet-ports' device
allows multiple netdevs to have the exact same parent device, e.g. port@x
netdevs are child nodes of ethernet-ports.

When ethernet aliases are used (e.g. 'ethernet0 = &cpsw_port1' and
'ethernet1 = &cpsw_port2') in the device tree, without an of_node
device exposed to the userspace, it is not possible to determine where
exactly the alias is pointing to.

As an example, this is essential for applications like systemd, which rely
on the of_node information to identify and manage Ethernet devices
using device tree aliases introduced in the v251 naming scheme.

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 1d00e21808c1..f74915f56fa2 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2091,6 +2091,13 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
 		if (strcmp(port_np->name, "port"))
 			continue;
 
+		if (!of_platform_device_create(port_np, NULL, NULL)) {
+			dev_err(dev, "%pOF error creating port platform device\n",
+				port_np);
+			ret = -ENODEV;
+			goto of_node_put;
+		}
+
 		ret = of_property_read_u32(port_np, "reg", &port_id);
 		if (ret < 0) {
 			dev_err(dev, "%pOF error reading port_id %d\n",
-- 
2.43.0


