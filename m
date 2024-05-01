Return-Path: <linux-kernel+bounces-164890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B69D98B848F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72643283448
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0765C3716D;
	Wed,  1 May 2024 04:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5xEUSZp"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE93208B6;
	Wed,  1 May 2024 04:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714536099; cv=none; b=L9bkPg2xudYyR+b6dvxitTXnaVLGO5Ov4embGRmbg4llwqVXB18C5+gm7Wb27aFbmuL5MBMSsTJ+6k6tnWrmCaBaTeL2vXY3UraxZ3CXTiuyiQ6KM550kwhFSLhXnFyjhXLhdEJ776sRrFLvkvhyd90RJVKiroyKqHQDT+8ze2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714536099; c=relaxed/simple;
	bh=ih19o42vH7cxU/8ZEzXQHexwm9+qaQG7rP27ILLWQ3g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sWHMV0uQ2DF4LDqkw5ofOJG/7BTlKm+N8Slh7HgJ0ultCpvtyFmjX7PD3kmd2G4hlKmflWkAWWf+3Pwc330c0SS9CyqhM1xR+YATqmGhrtBRQuRcYfz/m+BdixJLRmhc/5pXkqwXjzHfbXQ9QDDKcqORErBTyEPev/HfyA7CxZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5xEUSZp; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6123726725eso2435422a12.3;
        Tue, 30 Apr 2024 21:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714536097; x=1715140897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e6GL3tY8SHgju6pwmu6MxL8rTRYhd+zWuYx1Qcr7YGs=;
        b=l5xEUSZpUFGpfvXig9xxKneDfytPZKMcxXcECM97SR2DWBiAG8e+5bJVej+wPnKZbq
         XNlwJ11DauuWCGmrQAYIjV9UMamCPvEpKis6rY0COTmxrGrA/UOb491BdUhxxL2w1gFI
         wWVjSe+SYp2M6Chh2RrsQsOoVn4rRWqjQi2OK+s2WPaxjfRFeAR0Yl6usYZdtjeU4n3U
         ZQOqR0SVz8WSuO+5tMe+3TxRs7gmlBOOUfXeKeNitS4k1GWfVBEO7ncjydK/x7JHGXsJ
         Gb7bMWJ2kSzcpAed6ldHMNC58HgPvXFH0/Gwq6s+aMamTmo0d0Ye7MYIikzGdHQEVlOY
         ME1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714536097; x=1715140897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e6GL3tY8SHgju6pwmu6MxL8rTRYhd+zWuYx1Qcr7YGs=;
        b=RfTJ9dqDRPknsJ9anun7iXux4XyL1iIAYfh0MnNi3JXVCO/a0fIp+fUmmcYaqWiPWh
         an3cCHS/TPfqGGjad9w1xy3kr9DvfDMrVUHDK8GTBo/FukFba5erZnBa6Arguoo8qz/s
         L6yW/pUPL9Z9eg/gMmUjnI2R6XQIvhLK6sAiQwQq84nFyq3wjxc357Qkh6Ox7Fc+qtWZ
         ghppgOnH8D3v/D9GI6hX2NMGrfSoNj4VZd3tcN4dqsSaPndlMqKBL4oAimRdPtyMszx4
         IIS4whBsXVccxAw2NMd1iYsIr11S2GOvEaP8F1QOq6t1b+OA3rhTpn5CnEeypEbuVhje
         7vFA==
X-Forwarded-Encrypted: i=1; AJvYcCXPKioAgqnJ7FYWRGUIa9wMHV14jQudsnh3o8Bm3O2yvZBfL7J5nYXIrkzGgkH7AnxN4YyjE979gVn9okWaQamqJt/Jd6iLuMJ9SQaZpeawYwNKv0+bAGjbDTR77+WB/D9je9BRmxvU4A4=
X-Gm-Message-State: AOJu0Yy5ZDvFcMn0DJyK8loJ2bcjUtyjFwnRCab7DIFLz2MVzi7H3vAs
	chr9UrTF57yJZ+ljdc4cL3FZ3iNN2GlgojB3kfROMhQL0kfghP0b
X-Google-Smtp-Source: AGHT+IGMnsyNmhIzjz+iU1ST8gumMxKnQrQVJPBn49tTZtWm5bf+twfz/XESdxplA/w0o0LJ4j1cdA==
X-Received: by 2002:a05:6a20:c21d:b0:1ac:5040:2a69 with SMTP id bt29-20020a056a20c21d00b001ac50402a69mr1699750pzb.45.1714536097127;
        Tue, 30 Apr 2024 21:01:37 -0700 (PDT)
Received: from dev.. ([2402:e280:214c:86:c5df:1eec:52b9:dcb8])
        by smtp.gmail.com with ESMTPSA id a8-20020a170902ecc800b001e944fc9248sm19032287plh.194.2024.04.30.21.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 21:01:36 -0700 (PDT)
From: R Sundar <prosunofficial@gmail.com>
To: mripard@kernel.org,
	mchehab@kernel.org
Cc: christophe.jaillet@wanadoo.fr,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	R Sundar <prosunofficial@gmail.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH v2 linux-next] media:cdns-csi2tx: replace of_node_put() with __free
Date: Wed,  1 May 2024 09:31:23 +0530
Message-Id: <20240501040123.7327-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new cleanup magic to replace of_node_put() with
__free(device_node) marking to auto release when they get out of scope.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: R Sundar <prosunofficial@gmail.com>
---

Changes since v1 - Nitpick,  If function is successful,  then it will always
return 0 at the end of function.  so changed to return value as zero as it
reached  end of function.

Link to v1 - https://lore.kernel.org/all/20240429171543.13032-1-prosunofficial@gmail.com/

 drivers/media/platform/cadence/cdns-csi2tx.c | 21 ++++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2tx.c b/drivers/media/platform/cadence/cdns-csi2tx.c
index 3d98f91f1bee..1a56bbaeaecb 100644
--- a/drivers/media/platform/cadence/cdns-csi2tx.c
+++ b/drivers/media/platform/cadence/cdns-csi2tx.c
@@ -496,49 +496,44 @@ static int csi2tx_get_resources(struct csi2tx_priv *csi2tx,
 static int csi2tx_check_lanes(struct csi2tx_priv *csi2tx)
 {
 	struct v4l2_fwnode_endpoint v4l2_ep = { .bus_type = 0 };
-	struct device_node *ep;
 	int ret, i;
-
-	ep = of_graph_get_endpoint_by_regs(csi2tx->dev->of_node, 0, 0);
+	struct device_node *ep __free(device_node) =
+		of_graph_get_endpoint_by_regs(csi2tx->dev->of_node, 0, 0);
+
 	if (!ep)
 		return -EINVAL;
 
 	ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(ep), &v4l2_ep);
 	if (ret) {
 		dev_err(csi2tx->dev, "Could not parse v4l2 endpoint\n");
-		goto out;
+		return ret;
 	}
 
 	if (v4l2_ep.bus_type != V4L2_MBUS_CSI2_DPHY) {
 		dev_err(csi2tx->dev, "Unsupported media bus type: 0x%x\n",
 			v4l2_ep.bus_type);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	csi2tx->num_lanes = v4l2_ep.bus.mipi_csi2.num_data_lanes;
 	if (csi2tx->num_lanes > csi2tx->max_lanes) {
 		dev_err(csi2tx->dev,
 			"Current configuration uses more lanes than supported\n");
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	for (i = 0; i < csi2tx->num_lanes; i++) {
 		if (v4l2_ep.bus.mipi_csi2.data_lanes[i] < 1) {
 			dev_err(csi2tx->dev, "Invalid lane[%d] number: %u\n",
 				i, v4l2_ep.bus.mipi_csi2.data_lanes[i]);
-			ret = -EINVAL;
-			goto out;
+			return -EINVAL;
 		}
 	}
 
 	memcpy(csi2tx->lanes, v4l2_ep.bus.mipi_csi2.data_lanes,
 	       sizeof(csi2tx->lanes));
 
-out:
-	of_node_put(ep);
-	return ret;
+	return 0;
 }
 
 static const struct csi2tx_vops csi2tx_vops = {
-- 
2.34.1


