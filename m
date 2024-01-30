Return-Path: <linux-kernel+bounces-44779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D340842749
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA871F2A373
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138067F7F8;
	Tue, 30 Jan 2024 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rwh4kn53"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3B17CF2D;
	Tue, 30 Jan 2024 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626549; cv=none; b=VaE/3L2z7GJ5fO2PsF95+mK4ClDhwMwQ5o1wpqst9/h1EHWWf5L/oQ2lyb5d/dCyeVvv3TZyN6Vrbizr7afdERSe+2TQjnM6IUZJ+D4TwFWRrgQSbKZGLdlVDXPHcY2eJCOLouetGWRtyHnOlfmjWFhdue4o4t12BCnOQH1Uh2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626549; c=relaxed/simple;
	bh=OGxm2l6+IjMuBaGBky+KQIZee+ckkPhgs3G0dlDBMRw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=jWhCrt1cJMwrQcXjiD+jYE/Jh9npYhHPiM2cT5UNzzOwILURSr0UV5l2NBJ/8BFA6AuK1l6tRTdoiTWM4/T6IrjAWow1pkcqxzn1iyZJBJcFfM2gV/mQY8ch0mc/h4vJW37ODMJC9wkcco7G9IW6OM7+IdLrvouUOpeD/oTBkk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rwh4kn53; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55c2cf644f3so4090126a12.1;
        Tue, 30 Jan 2024 06:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706626546; x=1707231346; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gO8ZOe0pnwzVp9ud1Vv3npsbTRCsdAJJfeT82uG86Y=;
        b=Rwh4kn53WRz56pPwhVaTGsUFNhm0D5gNG4I4m+obAAT+rmknoqRV5gmUUsO4jLPjFZ
         lZpiI33MJVbN3J48Ss9AILKC0/wGVqIiaNVzwzGCNcV4jEFyZR134SCXkh+rf1OTm2aV
         /4Bn5C55rsvW2FTgVAf403dVn7LdE49Nfjd9n6dlhxIvizaEfPcT4VaOT88NPMTDrbJ1
         zbQ5NkDTN5zUO6s4nmpNeD3tP1RycaXlkcumpxEaehIJpcVdSFDc2rmSt7hC+2Y/yxRp
         O6nwU0M02dCd2kd7zCoh69ECOBLRgTfac2/z8nH5ja/1IsQEE0RBemrbUygykNh+OwRR
         bOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706626546; x=1707231346;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+gO8ZOe0pnwzVp9ud1Vv3npsbTRCsdAJJfeT82uG86Y=;
        b=F89q9iwG8asOhjdMX7QU1AE33sivvvfr0sJl9mcdFgygCVDex394EsxSlVdv/kRSA8
         8uIn0+AKekUc4O5ATzFf+gvnSj9iYiO994vzys+6p5NsvB5KtdXv+GouN8EaT/RvXyCo
         ZI8/ANEaxubbaF9H4AWb8BKMPpHHysGgOcqDn3GpHcUSeL8lWlF23XYQz4th5cNUtm5g
         D7VTbjmoS/E+XiMWVowSoPDsw05xCMjtVErzNbu0cHpHF7J/5stjpVzYC4Q8HtcoVNFA
         2VSARpB5u/UcIN7SPFeca4ejg9r8qwV+biHTkzn6CES7h4z3b0H9HfSnpuxBzk0tpaS0
         Ov0w==
X-Gm-Message-State: AOJu0YzmgTKYuwQQYgUbDwyR0mAv69q3R/o69NRXQ7ji4wbP6QE6Wpz4
	cQKGNTuPg8U6pBoZ/0DqmhYcvz48gDrIwDSRMHG9ukOSnAoWTxat
X-Google-Smtp-Source: AGHT+IFRi9GyQXJSDsExLjRideZaSaED5yGKhx4CIr1ncWL2nfC+HtMvB4YtSvuuO6qpUWW+snUifQ==
X-Received: by 2002:a05:6402:b4c:b0:55f:327c:d18a with SMTP id bx12-20020a0564020b4c00b0055f327cd18amr1583915edb.36.1706626545234;
        Tue, 30 Jan 2024 06:55:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXqWmkvvZvd/lwxAk5iOs/VBqiWjnua4Cq/9D+o3F2xLZwmzEJMPNiiOjtfh9LrBXqnGvYMSd88PILzT8o3xzK9P+3yp3sqWYnh9NLKrY0hvwe7NU7JZQ0IbQ8uR0NFWWsIngFyK6hMspO4slIDwkejfYFCHuDhg5YWuYQ/j3lMjtmfRzxgplPg2gvPKKop3D3KOYnfFzFnkqtGcNM3AaUafagYD8RZAwUsC0Q8WDsXGVMdxReIZkzlhXqdhnP4oYMKjAA9x8mQyMmNeBh7DPxdCSUGhKGkGheL0vvxU9eK5QwO+oIbNs+WT7znL8d4caxfiZycFAURrmrN+sJlfk0kVLLBXN8vvHv91bOoDXxlmnRQYv2chZzfs/3g0GmQI8VCmU6orQxG8n23lnDYRaqkTeCBK5lhr+MLgbWh8vkgr2rCD1NC5KvR+vVRMmbo5YZOe0dqCTHw4D4W6ZdVi5xMUZptn1m/ttlJjjyk0AApmbHio84E8u7Rf+v2dribs36sZUh7b6hdhSrvM/TMQcpHXiLPf7nDUI8=
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w7-20020aa7da47000000b0055f0c027a3esm1879542eds.30.2024.01.30.06.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 06:55:44 -0800 (PST)
Message-ID: <6626d288-ecf1-436b-b0a3-3417308a8633@gmail.com>
Date: Tue, 30 Jan 2024 15:55:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 1/6] dt-bindings: display: rockchip: rockchip,dw-hdmi:
 deprecate port property
To: robh+dt@kernel.org
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, airlied@gmail.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 mripard@kernel.org, markyao0591@gmail.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The hdmi-connector nodes are now functional and the new way to model
hdmi nodes with, so deprecate the port property and make port@0 and
port@1 a requirement. Also update example.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../display/rockchip/rockchip,dw-hdmi.yaml    | 27 ++++++++++++++++---
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
index 7e59dee15a5f..cd0a42f35f24 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
@@ -97,8 +97,11 @@ properties:
   ports:
     $ref: /schemas/graph.yaml#/properties/ports

-    patternProperties:
-      "^port(@0)?$":
+    properties:
+      port:
+        $ref: /schemas/graph.yaml#/properties/port
+        deprecated: true
+      port@0:
         $ref: /schemas/graph.yaml#/properties/port
         description: Input of the DWC HDMI TX
         properties:
@@ -108,11 +111,14 @@ properties:
             description: Connection to the VOPB
           endpoint@1:
             description: Connection to the VOPL
-    properties:
       port@1:
         $ref: /schemas/graph.yaml#/properties/port
         description: Output of the DWC HDMI TX

+    required:
+      - port@0
+      - port@1
+
   rockchip,grf:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -147,7 +153,11 @@ examples:
         clock-names = "iahb", "isfr";

         ports {
-            port {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
                 #address-cells = <1>;
                 #size-cells = <0>;

@@ -155,11 +165,20 @@ examples:
                     reg = <0>;
                     remote-endpoint = <&vopb_out_hdmi>;
                 };
+
                 hdmi_in_vopl: endpoint@1 {
                     reg = <1>;
                     remote-endpoint = <&vopl_out_hdmi>;
                 };
             };
+
+            port@1 {
+                reg = <1>;
+
+                hdmi_out_con: endpoint {
+                    remote-endpoint = <&hdmi_con_in>;
+                };
+            };
         };
     };

--
2.39.2


