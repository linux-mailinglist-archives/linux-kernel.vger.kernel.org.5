Return-Path: <linux-kernel+bounces-5925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6A2819199
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FDA91C2460E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4553A29F;
	Tue, 19 Dec 2023 20:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dLgAYduu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD17C3A1AF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 20:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703018082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s2gh7avZ+webTJh4GlB/OmJjsr2TX31NuZTJbonK+AA=;
	b=dLgAYduu8IzquaNG4shid8jzvjqJ4hzBuKcHhDH1hfxe4+ZTjk/hO1ZeGWhKyr5fqhCzwj
	r0sLdHDu3F1dGcuGQK+6JQd8uMPBLywNJ1dWSwhjs+YzqeENj9KZc7qad+ET/mO8g6jSEC
	ig49hTHxQ7KBZQ0K3zNfHMc3LadK2ro=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-dqkXM-91MM2flvkJBqpHuQ-1; Tue, 19 Dec 2023 15:34:41 -0500
X-MC-Unique: dqkXM-91MM2flvkJBqpHuQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33667fef12aso1353357f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:34:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703018079; x=1703622879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2gh7avZ+webTJh4GlB/OmJjsr2TX31NuZTJbonK+AA=;
        b=hZFg9JpLehi1G3tX/9Hn2mIDNpc387znkUO4J0J1IFI0KNkhRPHxWg65v2I75MglcE
         ewB+W2jqSX283JNTDPcWf0HSxLUKXAuvDyFPLF4MknnWJHmcUSI3fpoxl1LDUlbNaZ8h
         CoYJm3czMTv+Z+7URPtbBB3uNJzcOgebpYt2KfuJArEKnqY97qDbpWsmtX0s0mpqY4xu
         iXq1TJXajg62dzBN0nyKWqdgyCGSfP9T0VmGV4NO+b5cUu2uPDM94LZP3E3TGVdC34be
         KJVM1JeKcONt2bsq/eJQrxbIJvjugoR5aeMYIpY/N47og1nEBjEasRysccSfMthFtETy
         72eQ==
X-Gm-Message-State: AOJu0YzsQ3bqDA1jW2hnKI7yMA21j0u4vmh9e1HLtU5Vek1G6nw5BwpT
	f/A99JDoMtq5xvjg2jWqbdx/VvsmTWlHW71kqBQS9bphxl2TMNaf9/UqWFzfmMnNptNHhPZm8Of
	sj8ptmBbGdVP8NKzcEpiKWhXD2rJbp1QQlbHOU/wcCV2QuNlzyzaWEQpDm2y/wDTtoWlyswHCa9
	vEyvqnB7U=
X-Received: by 2002:adf:fbc5:0:b0:32f:7c6c:aa14 with SMTP id d5-20020adffbc5000000b0032f7c6caa14mr9345903wrs.37.1703018079157;
        Tue, 19 Dec 2023 12:34:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfz12dyj5qQB1RZu3obqwFvurn6HeBaxHioQSLuCusvAEiMmUqPMMF1GzfYjGC0YmrWBecYw==
X-Received: by 2002:adf:fbc5:0:b0:32f:7c6c:aa14 with SMTP id d5-20020adffbc5000000b0032f7c6caa14mr9345884wrs.37.1703018078853;
        Tue, 19 Dec 2023 12:34:38 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b0040c11fbe581sm4472994wmq.27.2023.12.19.12.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 12:34:38 -0800 (PST)
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
Subject: [PATCH v3 1/4] dt-bindings: display: ssd1307fb: Add vendor prefix to width and height
Date: Tue, 19 Dec 2023 21:34:06 +0100
Message-ID: <20231219203416.2299702-2-javierm@redhat.com>
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

The commit 591825fba8a2 ("dt-bindings: display: ssd1307fb: Remove default
width and height values") used the wrong properties for width and height,
instead of the correct "solomon,width" and "solomon,height" properties.

Fix this by adding the vendor prefix to the width and height properties.

Fixes: 591825fba8a2 ("dt-bindings: display: ssd1307fb: Remove default width and height values")
Reported-by: Conor Dooley <conor@kernel.org>
Closes: https://lore.kernel.org/dri-devel/20231218-example-envision-b41ca8efa251@spud/
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
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


