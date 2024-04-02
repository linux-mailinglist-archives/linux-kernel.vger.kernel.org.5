Return-Path: <linux-kernel+bounces-128588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F00895CC4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D7C1C2246D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB71D15D5BD;
	Tue,  2 Apr 2024 19:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcGaW36B"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C284A15D5AA;
	Tue,  2 Apr 2024 19:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086563; cv=none; b=lQ7AD8y4N3yWLAwAfSAMaeeRLNI8WrqMJqZOYajOhb+rnjIsQYSYMDs0aXL4I4Xr5GwY16w7FYzJnn2fqbdhh3D5fLEZ8SQf3WSKgsMTZHflkPUhbD0+ecEoRQynJaBrRKDv0TnO3XFw24h7gMf/VYrDEo601QOWbjQ2zZhS0aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086563; c=relaxed/simple;
	bh=jc7cebTA89vu3ctiegjexYTIxBYLjo1OtZ8qSUvC2Sg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=czOhR0Vor2snU1ToZAtYxKK/+BA2fGsS8IdUxCeM9RRcmZtVudNMRsmfSIYoUok8B4IxFIgpyFJeONpTO41fL0tV4rpCjT0Me39qaMGsfkJsWJm+PLnXVwPqwH4IR8Y14oqP07Apr8dCKLNI9JkIIoEsCwvFQlfItgg/i+ooYCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcGaW36B; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e244c7cbf8so24168015ad.0;
        Tue, 02 Apr 2024 12:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712086561; x=1712691361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wi6o+FdEdaIXxVNO48cVV2DPK9TKjcoqynKwgHQO7GM=;
        b=PcGaW36BCmUSfDXda3FdJuvkaRzpu3RiV26GwtiyMgSmBcYiECU/zNBXWVkKIZbMKC
         m3tAmjIM90JuLajyeeZRu4BTckYI+SLm1GxzJtCp6cK/iXVFINX1JoTTPlWML6pWqokw
         5dvCe7/z1KpUfWEPwEGPWp5FnlJSlxhsU8jT6ljIkWIXmSObawW0r5DOSRSz+IBUqpuW
         oWvTH69PyL9EiL9hSYV1xJ0VYnzrJxf0UcIS7FIb+sQaC/pwAPEgjsyG8vQ4fUusXjf/
         GgzvU7+2dFJOTZNy3kiBufcJTxmzz+1zP/waTuC6CgOlVlerbRMR4s/qHGdOSRJzCt5Z
         Fq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712086561; x=1712691361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wi6o+FdEdaIXxVNO48cVV2DPK9TKjcoqynKwgHQO7GM=;
        b=p9W2z3GKfMpPZdRGfyHMSm8kPlGTqShcYHDeDi67KprU0VXObmE/P/bh9p1crvJqGw
         K+2ygYhd3gC5/+HQ8WvVQMrSB7hFqOilXooYILhe3KpIakGEwhG52nm2HUB53r2hyuxT
         f3NADAFpX6NNMuwRCA370YVF5o+OF401vPpjCe2CMs6O+JCbZMzzaLKb76I0tFCqVTAV
         uB8k72ZbuUnbWoWURYTe+lbQwLzg9+6VAN92CiDIxzg9HteZrz0wWebZJ21xEfpp5gUr
         VPmCeZsXWuuX3Jmhp97FkkZRpvmjUr65znvDH/eekM4lCl/YpmehcimgGXHcXcQAtoZj
         kmwA==
X-Forwarded-Encrypted: i=1; AJvYcCVVF78Gb8k8bjerVJ4HWd4XAjSw2dux9xU9eunEl5gfIDlYMTRnQfGouQaDaQDc9TAWxS43i/n1bFKncjoqkrrh5iE5683zl9vwEBwT1InqzN6XZ1j8xaUvIbB1LlI78kJLmaUMq7PwtQ==
X-Gm-Message-State: AOJu0YzLeqXlTUP2o46dS9x/eQ08/J3eVnPEfu0kWEIFedAyUTFNxkJ+
	kpQHiQe6ADB7pmgBEzS2twRD8u+jIgXhiX+D7EMiXyn6fKM9oSqt
X-Google-Smtp-Source: AGHT+IE9b9o1NE9CkTOar0PYXIBWXkbziM1GUuV4KDxWrSFl2kVLUyILKpmyGmu4ieeUNnr3lDCuFA==
X-Received: by 2002:a17:903:11cc:b0:1e2:45cb:eb3d with SMTP id q12-20020a17090311cc00b001e245cbeb3dmr745523plh.3.1712086561123;
        Tue, 02 Apr 2024 12:36:01 -0700 (PDT)
Received: from frhdebian.. ([2804:14d:8084:b86e:ac17:f518:b547:13a8])
        by smtp.gmail.com with ESMTPSA id g6-20020a1709026b4600b001dd59b54f9fsm7775841plt.136.2024.04.02.12.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 12:35:58 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] dt-bindings: arm: fsl: remove reduntant toradex,colibri-imx8x
Date: Tue,  2 Apr 2024 16:35:10 -0300
Message-Id: <20240402193512.240417-3-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240402193512.240417-1-hiagofranco@gmail.com>
References: <20240402193512.240417-1-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

'toradex,colibri-imx8x' is already present as a constant value for
'i.MX8QP Board with Toradex Colibri iMX8X Modules', so there is no need
to keep it twice as a enum value for 'i.MX8QXP based Boards'.

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 0027201e19f8..6fdfa10af43c 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1218,7 +1218,6 @@ properties:
           - enum:
               - einfochips,imx8qxp-ai_ml  # i.MX8QXP AI_ML Board
               - fsl,imx8qxp-mek           # i.MX8QXP MEK Board
-              - toradex,colibri-imx8x     # Colibri iMX8X Modules
           - const: fsl,imx8qxp
 
       - description: i.MX8DXL based Boards
-- 
2.39.2


