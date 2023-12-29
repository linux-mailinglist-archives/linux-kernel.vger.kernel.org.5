Return-Path: <linux-kernel+bounces-13060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC67781FF1F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 12:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78FF9283293
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 11:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0152311185;
	Fri, 29 Dec 2023 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/kC5OLc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0337911C80
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 11:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703848843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LGLVCef4QzbvTALYo2ea2BIkPY+CGFifWhpyQpWq1Uc=;
	b=V/kC5OLcoE8v01sE3bS8rdMBOFqWt4BA+OmmE7Q9qTBYp8HZ4HN8dWQhTuBUEchIqddIpN
	29AuZDKjiC5ulJRk5Zaiiv/vcte/Qw/b4kMHdC1dymK+8+8oA4gePaAY4AHgXXR06c9P+m
	0IrOy0L3mf1yMLUUZ1Kw4XOtIOziNJI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-6oFwvhK6PPi7HLiFOMeUmw-1; Fri, 29 Dec 2023 06:20:36 -0500
X-MC-Unique: 6oFwvhK6PPi7HLiFOMeUmw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40d76064581so2764825e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 03:20:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703848834; x=1704453634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGLVCef4QzbvTALYo2ea2BIkPY+CGFifWhpyQpWq1Uc=;
        b=t7sXaj30HyoQAhSmwjKWNNSeir8ZjC20fQU9ozBMjq6S+ewS0JfGQasadDLnOOb5/W
         Qm9GbcRL3EdGyaI1kY6C46CgAK/HCPpORUiB2iXwF4EicSkGHN/3Aoe14ZzNpO2Ydpav
         JnGs2MO6cvW/TvrjOKw2sGiRFHNMSQiqsTdh0SsNrbL9FhG31lgNg1Ek+c9T/HlWT+NQ
         JuZMgjFe1DQR/i3wIyZIDfiCMv0iJ0oeWWnU+HLwsxsxG4QoUFMx1ajiAjAsg5Dm9ZMc
         wLGahsDAB5Ouzx9m7i/p7woYBcY589FA1jC3UmudtQ2sUuM0MsbyPGJzQYn6sLQQsPtL
         sQ0A==
X-Gm-Message-State: AOJu0YycKd4+EkILwM953+1HUEktHRoAIHi3Ej8pv135u939FkfGnSnE
	IyhYOFSWngIwGDDEL8XgR8SxE7OJ5xl3/ekN0qg0ndEYF8E6vCfHUnYELvvoRTJcrvbfyYEleh3
	E/fzxMsT41Wxl1SLnK8QZcHfd5PEmlthuLs+VlSuac1LTxpG+6bVp6EiTSHhd7wht4WWlpPaSnE
	L4mTsxj8Lw/EwAPPY=
X-Received: by 2002:a05:600c:4510:b0:40d:5722:2a0f with SMTP id t16-20020a05600c451000b0040d57222a0fmr4261010wmo.48.1703848834507;
        Fri, 29 Dec 2023 03:20:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5fMHEN5dB+koli23UjcZjZeepGNiOT2nHkTioE3ZWE19z7sXz94XioXuGlb4SaA2yPuAFaA==
X-Received: by 2002:a05:600c:4510:b0:40d:5722:2a0f with SMTP id t16-20020a05600c451000b0040d57222a0fmr4260983wmo.48.1703848834168;
        Fri, 29 Dec 2023 03:20:34 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c4f5300b0040d5b849f38sm11297188wmq.0.2023.12.29.03.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 03:20:33 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Conor Dooley <conor@kernel.org>,
	Peter Robinson <pbrobinson@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v5 2/4] dt-bindings: display: ssd132x: Add vendor prefix to width and height
Date: Fri, 29 Dec 2023 12:20:19 +0100
Message-ID: <20231229112026.2797483-3-javierm@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229112026.2797483-1-javierm@redhat.com>
References: <20231229112026.2797483-1-javierm@redhat.com>
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


