Return-Path: <linux-kernel+bounces-9571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5C481C7BD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96FC1F24FCB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E77014F9C;
	Fri, 22 Dec 2023 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EqWiktHb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503C41119D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 10:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703239319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LGLVCef4QzbvTALYo2ea2BIkPY+CGFifWhpyQpWq1Uc=;
	b=EqWiktHbitdYKzzKQUnoML8fCcvLl07L2++ZQNsdoUiwbTYXB5Y8w97+lxKWPMDeXQwB2j
	ENMb9k2rgHTDUaD8+v63RvCow0dBZyYXU/wFjLJBlz/NJzvVOlE/PMaqGa5dNEzA4kOULs
	wrbgdeOR0m1qPktYchcHio7Vw1etJt4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-62uzTwtdNNyP6ONC7aNbkw-1; Fri, 22 Dec 2023 05:01:58 -0500
X-MC-Unique: 62uzTwtdNNyP6ONC7aNbkw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40d3b0783beso12108065e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 02:01:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703239316; x=1703844116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGLVCef4QzbvTALYo2ea2BIkPY+CGFifWhpyQpWq1Uc=;
        b=BWmk0hnIWldeCDqEcT2APAXAbGq4poj+2LrNYsp/zm+f2LHjAVVViRrlGQtk0W4WE2
         65LnghSdz9UPVrHGB37nF/VIaix0ylLI3pbliaF0dYv5mGm+4rOdy6rARvenubcBnI70
         S8Rv0+chKDLVoX2PdtdmaKV4ex0/6fkMzgohZw2M9qE6NSAmkCjnzfjWgAa7PI73SBcR
         nCMDwc/ma7bc+C8AytAZxCRnCYhPe82dUjZa3rLluwID8Tkuk8WUqFzJy/farEqLOht4
         +igdwJRrqtavo4+CEmyh92hiktPKy63PmWU6TP8oq5FMyklpOv6q77bbJ+D3q8CPtabB
         zFpg==
X-Gm-Message-State: AOJu0YzHajy64Jy4HsGQy5j136TQo92UvjOEoHrwFs1VUpPv6cM+cFZY
	nFus5ZKeWzA/OIfpePvTqwMKG57Ezl0lTJ+GM3OQduZsHOsahFCcYQI5y6JVcpg0g1SFGKDKck/
	4FLxvlJcTmlfBlM4I87JizSUDWblUEtbXhoLCaPPTKP/Lb33hNk0dSg3LhaMO+zVvxPpO3PSllW
	mU5zsTaaGjsDV/pk0=
X-Received: by 2002:a05:600c:4707:b0:40d:30c9:2c0a with SMTP id v7-20020a05600c470700b0040d30c92c0amr579439wmo.115.1703239316376;
        Fri, 22 Dec 2023 02:01:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3RPkPItpbxaMZzXzGJcG1N9FtcaSFzT+abGEsinJLJmdympQDNt+Rajm9hzaq7pPTWoOcOg==
X-Received: by 2002:a05:600c:4707:b0:40d:30c9:2c0a with SMTP id v7-20020a05600c470700b0040d30c92c0amr579416wmo.115.1703239316021;
        Fri, 22 Dec 2023 02:01:56 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p20-20020a05600c359400b0040d3ae032b3sm6811470wmq.9.2023.12.22.02.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 02:01:54 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Peter Robinson <pbrobinson@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Conor Dooley <conor@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v4 2/4] dt-bindings: display: ssd132x: Add vendor prefix to width and height
Date: Fri, 22 Dec 2023 11:01:39 +0100
Message-ID: <20231222100149.2641687-3-javierm@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222100149.2641687-1-javierm@redhat.com>
References: <20231222100149.2641687-1-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 2d23e7d6bacb ("dt-bindings: display: Add SSD132x OLED controllers")
used the wrong properties for width and height, instead of the correct
"solomon,width" and "solomon,height" properties.

Fix this by adding the vendor prefix to the width and height properties.

Fixes: 2d23e7d6bacb ("dt-bindings: display: Add SSD132x OLED controllers")
Reported-by: Conor Dooley <conor@kernel.org>
Closes: https://lore.kernel.org/dri-devel/20231218-example-envision-b41ca8efa251@spud/
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Rob Herring <robh@kernel.org>
---

(no changes since v1)

 .../devicetree/bindings/display/solomon,ssd132x.yaml | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd132x.yaml b/Documentation/devicetree/bindings/display/solomon,ssd132x.yaml
index 37975ee61c5a..dd7939989cf4 100644
--- a/Documentation/devicetree/bindings/display/solomon,ssd132x.yaml
+++ b/Documentation/devicetree/bindings/display/solomon,ssd132x.yaml
@@ -30,9 +30,9 @@ allOf:
             const: solomon,ssd1322
     then:
       properties:
-        width:
+        solomon,width:
           default: 480
-        height:
+        solomon,height:
           default: 128
 
   - if:
@@ -42,9 +42,9 @@ allOf:
             const: solomon,ssd1325
     then:
       properties:
-        width:
+        solomon,width:
           default: 128
-        height:
+        solomon,height:
           default: 80
 
   - if:
@@ -54,9 +54,9 @@ allOf:
             const: solomon,ssd1327
     then:
       properties:
-        width:
+        solomon,width:
           default: 128
-        height:
+        solomon,height:
           default: 128
 
 unevaluatedProperties: false
-- 
2.43.0


