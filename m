Return-Path: <linux-kernel+bounces-13057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9591381FF1A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 12:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89A28B22795
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 11:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30008111A9;
	Fri, 29 Dec 2023 11:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ixNiOcSP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0923F10A36
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 11:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703848836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1KrXB2l1sK5WNrgL14b/nrn7vl1GLfrzGJcKXH5lPKk=;
	b=ixNiOcSPokN9cX+W/XxReLRZAbVKPkI8vm5P/MafrQEPBczpdrvIgb+TWS9QGvSaSbnTEZ
	MbZFvr6BKDlqWfUDVqkoi/wfR+jKIjHza446laC1kqCPpSPFkYFAG/rJi9LyDSVXftNZgp
	EJi06Fz7Ku2xo0mTp4ApGeWqOamLzJE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364--H0b8nPYN2OJdGivHZ9q2A-1; Fri, 29 Dec 2023 06:20:34 -0500
X-MC-Unique: -H0b8nPYN2OJdGivHZ9q2A-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40d27ea0165so63819785e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 03:20:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703848833; x=1704453633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KrXB2l1sK5WNrgL14b/nrn7vl1GLfrzGJcKXH5lPKk=;
        b=VpF+fuJDN+wuPzQGFYWLTNuc5aa2YjsY+ClL4aYBzkVX3ycz/GY1UbZ3+YSKJkl5fq
         10B+OSW6ZqHxDuFuXLHlivkjlqX7MbkbHxTbMIe8p+euCPEc8KOw5U7yOS3mO0EenCOF
         11K4ruG4U3a3yceDi6DkFi8vXr0hnrls81eunyOOLS82hYyLIiwkYG/MNbwUjUp0c1V4
         Hn+X7+A8bfWV0xg/PQp6lrKTbA6AsO1YWL0MaGGlXSETqkGgziqFdT11RgjXcYXn9Jca
         3FrvNDudwu2A3z0xc85+wmnpEf/UbdqskOrpalG2+e2UXyM2Rm0EQ4zW/f9W/5iNnTKU
         UxXQ==
X-Gm-Message-State: AOJu0YzrqpJ3tf1UYphHVnXw6vc9NN1oamWZyh9dvuOOUWsSKyDJX0Se
	gW7S2O6Y0xed+zrwHyiwrXoiVvl+OyqoCuiXzeHVyYQMPUdxcOgTWZKm0jYYi1fAJcxyC5zJzHc
	CAacevdd/gQk29OlqbFnZYGqFGY70aXdsfMbw6JVqw9MYwB0BDOIgUijU7mxZzroDglwecsvbg8
	FtFdF5zWzYlLIIq14=
X-Received: by 2002:a05:600c:5006:b0:40d:5f3e:f058 with SMTP id n6-20020a05600c500600b0040d5f3ef058mr1970534wmr.179.1703848832863;
        Fri, 29 Dec 2023 03:20:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhNkbC6wTKaV7ceYhGd3wJqwAROupHIXBLke7SzKs9QNM4PK1OxxXjBt/V5Sz1m4Hsc4u5NQ==
X-Received: by 2002:a05:600c:5006:b0:40d:5f3e:f058 with SMTP id n6-20020a05600c500600b0040d5f3ef058mr1970510wmr.179.1703848832437;
        Fri, 29 Dec 2023 03:20:32 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p35-20020a05600c1da300b0040b360cc65csm31388976wms.0.2023.12.29.03.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 03:20:31 -0800 (PST)
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
Subject: [PATCH v5 1/4] dt-bindings: display: ssd1307fb: Add vendor prefix to width and height
Date: Fri, 29 Dec 2023 12:20:18 +0100
Message-ID: <20231229112026.2797483-2-javierm@redhat.com>
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

The commit 591825fba8a2 ("dt-bindings: display: ssd1307fb: Remove default
width and height values") used the wrong properties for width and height,
instead of the correct "solomon,width" and "solomon,height" properties.

Fix this by adding the vendor prefix to the width and height properties.

Fixes: 591825fba8a2 ("dt-bindings: display: ssd1307fb: Remove default width and height values")
Reported-by: Conor Dooley <conor@kernel.org>
Closes: https://lore.kernel.org/dri-devel/20231218-example-envision-b41ca8efa251@spud/
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Rob Herring <robh@kernel.org>
---

(no changes since v1)

 .../bindings/display/solomon,ssd1307fb.yaml   | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
index 3afbb52d1b7f..153ff86fb405 100644
--- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
+++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
@@ -131,9 +131,9 @@ allOf:
             const: sinowealth,sh1106
     then:
       properties:
-        width:
+        solomon,width:
           default: 132
-        height:
+        solomon,height:
           default: 64
         solomon,dclk-div:
           default: 1
@@ -149,9 +149,9 @@ allOf:
               - solomon,ssd1305
     then:
       properties:
-        width:
+        solomon,width:
           default: 132
-        height:
+        solomon,height:
           default: 64
         solomon,dclk-div:
           default: 1
@@ -167,9 +167,9 @@ allOf:
               - solomon,ssd1306
     then:
       properties:
-        width:
+        solomon,width:
           default: 128
-        height:
+        solomon,height:
           default: 64
         solomon,dclk-div:
           default: 1
@@ -185,9 +185,9 @@ allOf:
               - solomon,ssd1307
     then:
       properties:
-        width:
+        solomon,width:
           default: 128
-        height:
+        solomon,height:
           default: 39
         solomon,dclk-div:
           default: 2
@@ -205,9 +205,9 @@ allOf:
               - solomon,ssd1309
     then:
       properties:
-        width:
+        solomon,width:
           default: 128
-        height:
+        solomon,height:
           default: 64
         solomon,dclk-div:
           default: 1
-- 
2.43.0


