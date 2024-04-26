Return-Path: <linux-kernel+bounces-160399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 546AF8B3D12
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9C8287012
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A92158A22;
	Fri, 26 Apr 2024 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCtVqu1t"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39EE24B21;
	Fri, 26 Apr 2024 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150035; cv=none; b=Bu0fB8eFliKhbkUeySGkQ248JaHOO32D8uWXumpDd1/5VSv2umu2e/29bwWS8AiJDsLRL+HdMSOJsW6bknkB/GHe8s2E1065X2l2fH61CTHkstfhC/7nrpqZ8W/LQ4kWfvQZqvjTBvm/gN8Pm4EA1KKfnz81ccnViAS6ut2znYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150035; c=relaxed/simple;
	bh=jfWjPGIScqlbTDAnTTHGrdwchCO7+CZVPkoOw2v3wV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Go+HMbsplFFQcsMwLhQvmIS47YHbgkkG5TWh5M0e7FoWJ8qB0dx+bxCNNj7bGRbnU4DU6pyjqfbEq1vqS811JWAYg4ELoikv3ZkYubVrQpMLltVU9+KcLTXWLAmWMXu6unD5FZCghMHst8KP70hgC77sqQ8MQJorTGqjQ90Lho0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCtVqu1t; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e5715a9ebdso20175625ad.2;
        Fri, 26 Apr 2024 09:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714150033; x=1714754833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sQn2ppMWd1uOjL7uqzuPwPjat8fxQZ3r4Xgq8M/reJc=;
        b=RCtVqu1tpAT/QYUfHRyM28M6Tx64es1qhCMcF/lP67ARhgh1/fsqXIqI23eZqjejQV
         UC6Ad0wrCzIxdcqS4X0sW47Qqi0GoLdqbQaiHlOVzDH2VU3IavN22CFhP7NM5BlQlCSK
         TdW8A+L4Z5ln0pRpwnbHXk58wc35T+NZBKz3WNb2tnjBcErhcCRjpt8X+Ykpsle+KiVr
         1K5++DYPNJOjVz9Jv6KvQ+r7GASc4irLIPjmhiehneyNQpM16ZyqtcQ88Zl+GMPMesxj
         H6z2vNA+8l5HeC/FbKEGUPpLzu92vgvK3Dkt9kKpgxUUg8+ZHuNLt8Hp9914kYSYMGD9
         zuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714150033; x=1714754833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQn2ppMWd1uOjL7uqzuPwPjat8fxQZ3r4Xgq8M/reJc=;
        b=lx5V+IVQJZbtK0MTRkJgYN9lVVeghvoI4fZVpVzXcoyRZkmOIgLFoJRW74tfhTOLkO
         Vbw+hGF/kkZ/kbcnTPp+0XdMdRRbMvdsTdxg0Kyqeu3JHTXA6brcsqr9Ym2S2zKie+MB
         I3PMnhD8hYNBdj1TkXmJ0zOQBfQrs6u+WYzEX+VCYgAwubPzRZP8fYgnSzhSirvB2i1x
         yBDTDFGNY8+Afs54LL6PNVWCxGJyDrDZ/qowq6vSOavEk4Ez1Hbp5OfpyE2IN76yPJ97
         E+80reDCQK4VZ9751wmaIWVLw/+mpqCH2I56874Dj9WQcudlVv/IDm3iKqwQAajSgCE3
         XOdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxi3JFwHyEs/snaeTBlh7fkNTMz9y9FdnyqfGZPp+TNOZTH+XVnBZ8XnK1BUFwakbgouWUUAKI2uBMJyaLIPAPd12suE/5cw2JXZcH
X-Gm-Message-State: AOJu0YwG3dXWadrpZf9h+0BpOeO0LCBsWimP9/dQuPhBB0JChGHGhMPw
	lLxVNp0BXgdvOJkrX5WghpKWkvnrxhp0dsm06GeJbxJTFFCq/la0
X-Google-Smtp-Source: AGHT+IFHwuV5UcmP2zAhp9tIF5BJVXGc6sYdl7MFsQgMTTVUUw38ID/F1HlogJCOkDP6ZhPiVFL7gA==
X-Received: by 2002:a17:902:d492:b0:1dd:2eed:52a5 with SMTP id c18-20020a170902d49200b001dd2eed52a5mr225645plg.37.1714150033037;
        Fri, 26 Apr 2024 09:47:13 -0700 (PDT)
Received: from kernel.. ([2402:e280:214c:86:dcce:3490:50a1:90df])
        by smtp.gmail.com with ESMTPSA id q5-20020a17090311c500b001d8f81ecea1sm15766839plh.172.2024.04.26.09.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 09:47:12 -0700 (PDT)
From: R Sundar <prosunofficial@gmail.com>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	neil.armstrong@linaro.org,
	dmitry.baryshkov@linaro.org,
	u.kleine-koenig@pengutronix.de,
	christophe.jaillet@wanadoo.fr
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	R Sundar <prosunofficial@gmail.com>
Subject: [PATCH v5 linux-next] usb:typec:mux: remove indentation for common path
Date: Fri, 26 Apr 2024 22:17:05 +0530
Message-Id: <20240426164705.2717-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nitpick, Mostly common path will not be indented.  so rewritten this
function to check device_node pointer is null and removed common path
indentation.

Signed-off-by: R Sundar <prosunofficial@gmail.com>
---

Fixed nitpicks in code according to comments received on other patch as
below:

[ Nit, this function should be rewritten to not work like this, the
"common" path should not be indented, but only the exception (i.e. bail
if ep is not allocated properly.) ]
https://lore.kernel.org/all/2024041103-doornail-professor-7c1e@gregkh/

Goal is to get rid of of_node_put,but sending this patch first to do one
thing at a time.

Changes since v1 - fixed the typo error for spell from identation to
indentation

Changes since v2 - Shifted the indentation to one level left for the
switch cases as per coding style.

Changes since v3 - Added descriptive subject for the patch and checked
from and sign-off having same name.

Changes since v4 - Fixed name in signed-off-by as in documents.

Patches link:
------------
v1  - https://lore.kernel.org/all/20240420145522.15018-1-prosunofficial@gmail.com/
v2  - https://lore.kernel.org/linux-usb/20240420164927.15290-1-prosunofficial@gmail.com/
v3  - https://lore.kernel.org/all/20240421011647.3027-1-prosunofficial@gmail.com/
v4  - https://lore.kernel.org/all/20240424150718.5006-1-prosunofficial@gmail.com/

 drivers/usb/typec/mux/nb7vpq904m.c | 68 +++++++++++++++---------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/usb/typec/mux/nb7vpq904m.c b/drivers/usb/typec/mux/nb7vpq904m.c
index b17826713753..f7a00b388876 100644
--- a/drivers/usb/typec/mux/nb7vpq904m.c
+++ b/drivers/usb/typec/mux/nb7vpq904m.c
@@ -320,47 +320,47 @@ static int nb7vpq904m_parse_data_lanes_mapping(struct nb7vpq904m *nb7)
 	int ret, i, j;
 
 	ep = of_graph_get_endpoint_by_regs(nb7->client->dev.of_node, 1, 0);
+	if (!ep)
+		return 0;
 
-	if (ep) {
-		ret = of_property_count_u32_elems(ep, "data-lanes");
-		if (ret == -EINVAL)
-			/* Property isn't here, consider default mapping */
-			goto out_done;
-		if (ret < 0)
-			goto out_error;
-
-		if (ret != DATA_LANES_COUNT) {
-			dev_err(&nb7->client->dev, "expected 4 data lanes\n");
-			ret = -EINVAL;
-			goto out_error;
-		}
-
-		ret = of_property_read_u32_array(ep, "data-lanes", data_lanes, DATA_LANES_COUNT);
-		if (ret)
-			goto out_error;
+	ret = of_property_count_u32_elems(ep, "data-lanes");
+	if (ret == -EINVAL)
+		/* Property isn't here, consider default mapping */
+		goto out_done;
+	if (ret < 0)
+		goto out_error;
+
+	if (ret != DATA_LANES_COUNT) {
+		dev_err(&nb7->client->dev, "expected 4 data lanes\n");
+		ret = -EINVAL;
+		goto out_error;
+	}
 
-		for (i = 0; i < ARRAY_SIZE(supported_data_lane_mapping); i++) {
-			for (j = 0; j < DATA_LANES_COUNT; j++) {
-				if (data_lanes[j] != supported_data_lane_mapping[i][j])
-					break;
-			}
+	ret = of_property_read_u32_array(ep, "data-lanes", data_lanes, DATA_LANES_COUNT);
+	if (ret)
+		goto out_error;
 
-			if (j == DATA_LANES_COUNT)
+	for (i = 0; i < ARRAY_SIZE(supported_data_lane_mapping); i++) {
+		for (j = 0; j < DATA_LANES_COUNT; j++) {
+			if (data_lanes[j] != supported_data_lane_mapping[i][j])
 				break;
 		}
 
-		switch (i) {
-		case NORMAL_LANE_MAPPING:
-			break;
-		case INVERT_LANE_MAPPING:
-			nb7->swap_data_lanes = true;
-			dev_info(&nb7->client->dev, "using inverted data lanes mapping\n");
+		if (j == DATA_LANES_COUNT)
 			break;
-		default:
-			dev_err(&nb7->client->dev, "invalid data lanes mapping\n");
-			ret = -EINVAL;
-			goto out_error;
-		}
+	}
+
+	switch (i) {
+	case NORMAL_LANE_MAPPING:
+		break;
+	case INVERT_LANE_MAPPING:
+		nb7->swap_data_lanes = true;
+		dev_info(&nb7->client->dev, "using inverted data lanes mapping\n");
+		break;
+	default:
+		dev_err(&nb7->client->dev, "invalid data lanes mapping\n");
+		ret = -EINVAL;
+		goto out_error;
 	}
 
 out_done:
-- 
2.34.1


