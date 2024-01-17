Return-Path: <linux-kernel+bounces-28646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1342783014D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE462885A0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E491170D;
	Wed, 17 Jan 2024 08:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Zk7290XY"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD12C11184;
	Wed, 17 Jan 2024 08:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705480336; cv=none; b=Ln2GoJHJ/WB/bcibE2wgkiqbZiYplDesjCyUBAPBvvJEf2LfpXVwSdixcgbWzwY6kzEkyVWDJvnWYyPus3SGYeKGN9z94k2qg4QmWt6E9SmwA5H333AxGhYFm2JpazkJt+7uGyk5VYP4w9KQI1d1VJg9YIe80PAj+DN6jO5eZY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705480336; c=relaxed/simple;
	bh=XlOdioolNpHZ22pGKvy5zetAA92JxS98QovQH+mfn3w=;
	h=DKIM-Signature:X-IronPort-AV:Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	b=EZOe1/3E+wmtIzAxtPZDNbGtSf8+Rn+OUA+Cmvi+z6N4eMHDRxS+fxuCBCl2BtCCEFMazYJO/LLXL06cFX4g6S4ZFORBnCI+zoia8IgmlHZJxsEoaTDxdaHmuXaDBK+QsMQbkRYO96JlDtPyn54FaS/yJ2NjQy7RPaJvP5+h6jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Zk7290XY; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1705480333; x=1737016333;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/BP+4dKkLlCq8jJBHaVZ/NNx1yUpZgjmOcoJ+fxKctc=;
  b=Zk7290XYlrFAWjMeH+aPSKckunErlx1XeIqcciwNwiJkvaBEwYJHUui9
   AO0fDDmcKd1rFHnoXSzcHSPqV8Vl3PrUO4IGnvDvJQe9Q6PUP7Ief5uOs
   7daWor66gzA2W50QnfokxlftdgIJJ3WGGj9f6wsCKpuSSMz68iSwtUu3B
   iy5tnnnZsdvSokXhy/Sx3+eGaqPOCoq4dDZFQ30bAuLf2iX05K1DbeUjk
   chG1YCys1zmWAhNgYy25WErni9PcbkVkMSNOFa6ICVhE0G6BfZoKNaId3
   8wyYIeeDoOHW8JbiugyD5ZLqK0BpCX60mY7FOC8pdibnhjCB5cABpDwie
   A==;
X-IronPort-AV: E=Sophos;i="6.05,200,1701126000"; 
   d="scan'208";a="34933155"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 17 Jan 2024 09:32:10 +0100
Received: from steina-w.tq-net.de (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id DB006280075;
	Wed, 17 Jan 2024 09:32:09 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] of: property: Make 'no port node found' output a debug message
Date: Wed, 17 Jan 2024 09:32:06 +0100
Message-Id: <20240117083206.2901534-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are cases where an unavailable port is not an error, making this
error message a false-positive. Since commit d56de8c9a17d8 ("usb: typec:
tcpm: try to get role switch from tcpc fwnode") the role switch is tried
on the port dev first and tcpc fwnode afterwards. If using the latter
bindings getting from port dev fails every time. The kernel log is flooded
with the messages like:
 OF: graph: no port node found in /soc@0/bus@42000000/i2c@42530000/usb-typec@50
Silence this message by making it a debug message.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/of/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 641a40cf5cf34..a02a985c13baa 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -665,7 +665,7 @@ struct device_node *of_graph_get_next_endpoint(const struct device_node *parent,
 		of_node_put(node);
 
 		if (!port) {
-			pr_err("graph: no port node found in %pOF\n", parent);
+			pr_debug("graph: no port node found in %pOF\n", parent);
 			return NULL;
 		}
 	} else {
-- 
2.34.1


