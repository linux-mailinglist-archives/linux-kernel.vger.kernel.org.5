Return-Path: <linux-kernel+bounces-16382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1C4823DB2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84636B2139F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E93B20B14;
	Thu,  4 Jan 2024 08:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KAsc15QE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D42208A5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a279ce3aab9so27719666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 00:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1704357740; x=1704962540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXGsllobW7FM1Bh/GFVmgfSyiJn/KRbyHxvKaq5XBd4=;
        b=KAsc15QEBJmaXfzxnVwACiUaOt2FradDeNE4DzOGDaEQC4XlT08SRnpMQc3rL1lEKt
         ieJ9gc4KmYkb/DQTreO+Spjf8BPX3oU7sF/Ei1ZHO5nXMNHfz4EwCkCCelRNT6V/EzSx
         icr+WG/yZ3wRBp0pCLNCUlOwN6VQhFRb3L5FE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704357740; x=1704962540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXGsllobW7FM1Bh/GFVmgfSyiJn/KRbyHxvKaq5XBd4=;
        b=k8119ylQ9cgX3kXhYDNwbFlYzH6a69/CzoMUPwmS3hAwpDO8TdzRRVW2z2VR7zUaam
         f8gU3c/cXBlcfeNBDP0lKFWodf+WaIQHx4ZIaJPJqg7WzAVm2pJpvr8QbUtJT0L//dsD
         2ODwBYAJETctqFjdsaXS8De1i2ivHtRNBxI5kZIw5TZyaUoCfTs7umIpnpOIh6cI+O2O
         p41G72TmlcwbyaRDCgwVBj127pdkzq2zxh1VCvHOFEN1R+GUhKIhXrrSuwRz2eB/ZsUk
         nTetmgoIj0amNeawB8mlxmb8CJB4d7tvssNMol31pDVJcv6EMyaT/8U6OowdZ4R/Z6vF
         R0cQ==
X-Gm-Message-State: AOJu0YxWgYSL8kDuooB6rPSmTQLMAZ97nLk3DCOD/wCqsVvf8MFN9+3t
	uNM3qaeSQjXovaAGoWX28dMDInx4+j9zW24C4hLUGA+bF+8=
X-Google-Smtp-Source: AGHT+IHmEppr/O53EySgWZMtoqd5scwBe7uUi57gjWCkgd3DZxEW3k2aOYRvBqHMPyUXPJ0NsC2ihA==
X-Received: by 2002:a17:906:e083:b0:a28:27df:b38 with SMTP id gh3-20020a170906e08300b00a2827df0b38mr88170ejb.201.1704357740231;
        Thu, 04 Jan 2024 00:42:20 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (net-93-150-255-34.cust.vodafonedsl.it. [93.150.255.34])
        by smtp.gmail.com with ESMTPSA id wh14-20020a170906fd0e00b00a233efe6aa7sm13495704ejb.51.2024.01.04.00.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 00:42:19 -0800 (PST)
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
Subject: [PATCH v4 5/8] dt-bindings: nt35510: add compatible for FRIDA FRD400B25025-A-CTK
Date: Thu,  4 Jan 2024 09:41:45 +0100
Message-ID: <20240104084206.721824-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104084206.721824-1-dario.binacchi@amarulasolutions.com>
References: <20240104084206.721824-1-dario.binacchi@amarulasolutions.com>
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

Changes in v4:
- Put the "enum" list in alphabetical order

Changes in v3:
- Use "enum" to have less code changed

Changes in v2:
- Add a dash in front of each "items:"

 .../devicetree/bindings/display/panel/novatek,nt35510.yaml    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml
index bc92928c805b..a4afaff483b7 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml
@@ -15,7 +15,9 @@ allOf:
 properties:
   compatible:
     items:
-      - const: hydis,hva40wv1
+      - enum:
+          - frida,frd400b25025
+          - hydis,hva40wv1
       - const: novatek,nt35510
     description: This indicates the panel manufacturer of the panel
       that is in turn using the NT35510 panel driver. The compatible
-- 
2.43.0


