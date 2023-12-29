Return-Path: <linux-kernel+bounces-13110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B09181FFD7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 14:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543FD1C218D7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 13:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040E212B8B;
	Fri, 29 Dec 2023 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Z9cnbRpB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0277F125C8
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-555936e7018so1455677a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 05:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1703857945; x=1704462745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FZShzhdUUXvOv6YwhzCq6E+ow3Z9zOiz8SIKSQQ5aQ=;
        b=Z9cnbRpBO32BumtepaiFLajF4Fchlv+N0EOM5FO54fcTQtkt1eQeCf5IFX2puMniJK
         WOojC5yzngvvmZxdSXu0YWVAhv3i/u6amb4T9132jDnQ5PFpj+pOzN1/EJx5pCHDqsgp
         Mx5C9boVklLf/F4ZnuHX/vVdQ2t//oUy8FnuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703857945; x=1704462745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FZShzhdUUXvOv6YwhzCq6E+ow3Z9zOiz8SIKSQQ5aQ=;
        b=VHK8snkJ+BrvmubT06TrbqJthqSDftbGW0Z9eAf4GLW5kFMxl8X4LrYwLAWgGjXEK/
         Aibo7OzF/CPB04TswV7pdRLcKXPHzrr+JRsSLkWsgQJ9gil+nAJ8uX1Szv596UWh2YYF
         DcDs4n5ucgNPo6HS+YCKhfGKtvU4yrK0tiHC3l2CeOKoz3QiRzp2nqsIDnQ1uiTxLfll
         qsbyTHS1vHYY0Tdnpt1Ehs8jpJ0tAIwK0R5U7bAiq21776Q/ZPjwJTIZUSs6PaibXuK7
         jv9Kk7FHUYQJ5mJA9HDsYgh0ww9uNar19z3wHISJ8/lS/9vdbX/jvRis2wI2z/pleRBg
         FEGQ==
X-Gm-Message-State: AOJu0YwKlgtsh9lBOq1soJ2buCS+p30TjurUlT0jHO7yotSK9CwHanA6
	Rf5jLGy1zPNkBNuItJfVFeQDrzw9OpVXW1+JJH9C8wkjB8k=
X-Google-Smtp-Source: AGHT+IHZSk38r2bBvbe6blWI8vopM/JiejTHBmAEvO7rQpG1RlucRoCTiKPornXbD+3/E88gSjrPHA==
X-Received: by 2002:a05:6402:1616:b0:554:e4f8:9818 with SMTP id f22-20020a056402161600b00554e4f89818mr4348054edv.50.1703857945188;
        Fri, 29 Dec 2023 05:52:25 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-49-57-70.retail.telecomitalia.it. [79.49.57.70])
        by smtp.gmail.com with ESMTPSA id i16-20020aa7c710000000b00553b243b1a8sm11019160edq.92.2023.12.29.05.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 05:52:24 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 5/8] dt-bindings: nt35510: add compatible for FRIDA FRD400B25025-A-CTK
Date: Fri, 29 Dec 2023 14:51:20 +0100
Message-ID: <20231229135154.675946-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229135154.675946-1-dario.binacchi@amarulasolutions.com>
References: <20231229135154.675946-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch adds the FRIDA FRD400B25025-A-CTK panel, which belongs to the
Novatek NT35510-based panel family.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 .../display/panel/novatek,nt35510.yaml        | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml
index bc92928c805b..511b93a376b7 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml
@@ -14,14 +14,18 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - const: hydis,hva40wv1
-      - const: novatek,nt35510
-    description: This indicates the panel manufacturer of the panel
-      that is in turn using the NT35510 panel driver. The compatible
-      string determines how the NT35510 panel driver shall be configured
-      to work with the indicated panel. The novatek,nt35510 compatible shall
-      always be provided as a fallback.
+    oneOf:
+      items:
+        - const: hydis,hva40wv1
+        - const: novatek,nt35510
+      items:
+        - const: frida,frd400b25025
+        - const: novatek,nt35510
+      description: This indicates the panel manufacturer of the panel
+        that is in turn using the NT35510 panel driver. The compatible
+        string determines how the NT35510 panel driver shall be configured
+        to work with the indicated panel. The novatek,nt35510 compatible shall
+        always be provided as a fallback.
   reg: true
   reset-gpios: true
   vdd-supply:
-- 
2.43.0


