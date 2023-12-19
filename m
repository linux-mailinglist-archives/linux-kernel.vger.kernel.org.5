Return-Path: <linux-kernel+bounces-5926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C7D81919D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5FB1C22025
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A593A1AF;
	Tue, 19 Dec 2023 20:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPeJrMK5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0892D39AE9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 20:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703018090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NiVYl512QhGYSepDsrAuE1nuD6kWmIVdAFOPcanDwvc=;
	b=VPeJrMK5cZpfvIkreg8KGKK1BrgTyalOQRHLpy9yFCsY+f8zfOZ6hWy4kzkIO5Qctkjbv8
	iaEFsCbOn33qHCva5nV6fblApO8pA55cFRUle/BMBDl00Z5ypcs74XdRAx8RvxUinKu/fi
	roa/MXrlZLCvGjYaC8OLy+Z7QB3fcro=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-Su_4lqvtPNq5vtrcgyJnYg-1; Tue, 19 Dec 2023 15:34:46 -0500
X-MC-Unique: Su_4lqvtPNq5vtrcgyJnYg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40d2f6f2787so4263135e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:34:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703018084; x=1703622884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NiVYl512QhGYSepDsrAuE1nuD6kWmIVdAFOPcanDwvc=;
        b=b6uaIElkYgq8yGMo3gtGzSbFOKfDmoh3R17KG/glT01U5J2bUhwEU3x0cQMaGcccVZ
         LIBQUEbeeTvfnY0seIPhWAQBLO56KRPN8CVUjFLjN4GvTmLSTDK2k3R/XuM5NgZmSxMh
         4E93bSsLlMWqLuRBA0HmSNz5XN3bYTG19RYuNH2Ul6MRpqPynb25TVstzbzUCZagbCRh
         5/M7jz0sJm7Wf9jNQzw/x4/cC1PP3rbIrpzQe7ab2ywNXOJTQy0HkXlF/9rX7ndr76Xc
         3uLIkbbAuKoDOOlMk4Q+4+LkuEqXBYcBaFz+4M7mTpszOTqftNIjWf0L1H3pakEgz2sM
         mB9g==
X-Gm-Message-State: AOJu0YzjOVC9b6yY+xYnQlfxgcMQOvQioZHhhbQsk0nxBD5D1R/2U3uS
	CiHZE+Ql5WjyrifTquWvcXBehJmXA+IuVFrCT1egjKeTvFOpEY3r41NcFrX+SDg7ivZXrOljnbB
	XouT63umLC3e4omP9iz8ajZ62Qr7kxwMP1nwd7U2v7HIKwnysmg1renJBqAwLiD6CMdWXwHCqH0
	SgqM5Jz1Y=
X-Received: by 2002:a05:600c:44c7:b0:40c:2bb8:70c9 with SMTP id f7-20020a05600c44c700b0040c2bb870c9mr9608774wmo.150.1703018084422;
        Tue, 19 Dec 2023 12:34:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6aQ1XQXOizk6reDjlxoJMiPmuIWJ0QcHegbS1RgeL9ztmoE3yAj4OKXbYEsvTfcyds5jWDQ==
X-Received: by 2002:a05:600c:44c7:b0:40c:2bb8:70c9 with SMTP id f7-20020a05600c44c700b0040c2bb870c9mr9608753wmo.150.1703018084172;
        Tue, 19 Dec 2023 12:34:44 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c5-20020a05600c0ac500b0040a3f9862e3sm43508wmr.1.2023.12.19.12.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 12:34:43 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Maxime Ripard <mripard@kernel.org>,
	Peter Robinson <pbrobinson@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
Subject: [PATCH v3 2/4] dt-bindings: display: ssd132x: Add vendor prefix to width and height
Date: Tue, 19 Dec 2023 21:34:07 +0100
Message-ID: <20231219203416.2299702-3-javierm@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219203416.2299702-1-javierm@redhat.com>
References: <20231219203416.2299702-1-javierm@redhat.com>
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


