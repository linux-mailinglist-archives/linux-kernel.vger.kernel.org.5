Return-Path: <linux-kernel+bounces-12948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E81281FD25
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 06:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B425BB223D0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 05:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDBC2904;
	Fri, 29 Dec 2023 05:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpF5Y2Yv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3F523A1;
	Fri, 29 Dec 2023 05:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a26fa294e56so327146566b.0;
        Thu, 28 Dec 2023 21:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703828883; x=1704433683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ClpHT/yJDzsGfgCrD6c+GMtCBr/uPP1onuzKC8VSZQ4=;
        b=CpF5Y2YvIkzoEK+lve9nIwn+8tiQ2HYyy5S1YEQjwyoc9bCo79Lm24stYhkrcH7tzW
         WgYMIYqhHIOqV5X59Bp9Q8Uy/JKd3WIaShK6d8o8fB3z27RLJ+bjA+I6zRm5Z/sf8u/N
         t2bxSxA8hYw+c6KNtAsjJm6Ln7MbN+PMfGnkF13WISoOvNQ68hwTAGJRI2IBQj0OQAZi
         NkGNNwNVwtP8sxlxIxn/vYuZ0U4RAWjMaZNvTGovfkxy+XWkq5V5mqvqBeBzT0g20CC/
         nKPcP1vY2P6XpXiJectefdR1Ue8n/2xuvi+ll2V5GjEllFV638hKITeaa96Has9jf+vF
         /nyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703828883; x=1704433683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ClpHT/yJDzsGfgCrD6c+GMtCBr/uPP1onuzKC8VSZQ4=;
        b=Fq/duKHs/43RTB4wkb4YDXdwipvzZXMYIzCT/Y2xYi+Kb4tjHIKQ5TkYy0PZ7Nndi9
         lpSbkwj/pRbQNAaD2TCMEu1Vs9aodDZzLDwLrYOk8kunlsHheQ8fAHggxG4U2AoHf859
         vIvO0f3q5Hh9QRDjnrxa4uiBLYRu7drbmmH79P41X5TaQjLHBchdELapknW/tBL4YrRb
         Q5DVaD8ZSqFT5ibby7Jnl4+/7PVbEHz4VlZR2i4ax3YAGQWxoZ9JeQBegFmZVcZ3uYvM
         TFJ+LKeCuAVMBksMk/e50RD4uIitn33CshEmCABhEDg0TL7QA1lrKAUkNOO0eWzevmtK
         d8ag==
X-Gm-Message-State: AOJu0YwWWZMqFBpVMPjzC5WJ43i6jSs+N5U0oKbMJUUL9LqkFuAq+SEo
	sUh4Py2XnfSUXb9eiJ0b/r4=
X-Google-Smtp-Source: AGHT+IFL8DFI8p3gnQwdfmcbvGKDdV8wbnHjMlisdB9dvoqPQBIZ7Ahgsoiclvysyoj+fShdas3h6A==
X-Received: by 2002:a17:906:b114:b0:a27:59a2:93fc with SMTP id u20-20020a170906b11400b00a2759a293fcmr1726278ejy.107.1703828882565;
        Thu, 28 Dec 2023 21:48:02 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id e17-20020a170906505100b00a26ade46618sm7230880ejk.99.2023.12.28.21.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 21:48:02 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Konrad Dybcio <konradybcio@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Andrew Davis <afd@ti.com>,
	Andrew Lunn <andrew@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Nishanth Menon <nm@ti.com>,
	Olof Johansson <olof@lixom.net>
Subject: [PATCH] docs: dt-bindings: suggest "reg-names" position in DTS Coding Style
Date: Fri, 29 Dec 2023 06:47:11 +0100
Message-Id: <20231229054711.17317-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Property "reg-names" is strictly related to "reg" so it should follow it
directly instead of falling into "Standard/common properties". This
helps reading DTS files.

Cc: Andrew Davis <afd@ti.com>
cc: Andrew Lunn <andrew@lunn.ch>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Olof Johansson <olof@lixom.net>
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../devicetree/bindings/dts-coding-style.rst          | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/dts-coding-style.rst b/Documentation/devicetree/bindings/dts-coding-style.rst
index a9bdd2b59dca..1a48e2ca80e9 100644
--- a/Documentation/devicetree/bindings/dts-coding-style.rst
+++ b/Documentation/devicetree/bindings/dts-coding-style.rst
@@ -116,12 +116,13 @@ The following order of properties in device nodes is preferred:
 
 1. "compatible"
 2. "reg"
-3. "ranges"
-4. Standard/common properties (defined by common bindings, e.g. without
+3. "reg-names"
+4. "ranges"
+5. Standard/common properties (defined by common bindings, e.g. without
    vendor-prefixes)
-5. Vendor-specific properties
-6. "status" (if applicable)
-7. Child nodes, where each node is preceded with a blank line
+6. Vendor-specific properties
+7. "status" (if applicable)
+8. Child nodes, where each node is preceded with a blank line
 
 The "status" property is by default "okay", thus it can be omitted.
 
-- 
2.35.3


