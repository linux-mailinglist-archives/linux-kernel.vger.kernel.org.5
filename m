Return-Path: <linux-kernel+bounces-111022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA9388670A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3BA1F24AC0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110FA19475;
	Fri, 22 Mar 2024 06:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjkHHFTT"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C982171C1;
	Fri, 22 Mar 2024 06:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089949; cv=none; b=fFIavbxMEbq1h3TjzjQbAQxgKBDlRmHdZklCoSqkZKGW6Rf5IBXhPYb4EVMnJq3gQMS1TyTqqyPBs6+2/MLk055C4wrAogvnWBfEuPLJ9pvmgtgsif648hYMzOu3wvVQmpfPp2GUshQ1fEtMBbfkBYFrL98UVQSdPhcp5w8YQnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089949; c=relaxed/simple;
	bh=4rUBSyPV6ao55dHemnHVuLdadgQFFoAi54Gb6HBKVTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WTsbVJXKar/wHmmopI4cT0G7p2NdHgmatIomEL0WQYSYzulKh5LrnrawtsoFf4g9Nu2Tgv42lrIVLc0KHbowHlFfTeN1QerX+WyHbQv3weoFyHWx6AjAR4uY+wlBzMOKHPcD70UDxkpjKiotx9bQQegYIi7xwjPbTTH6TABJdIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjkHHFTT; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a44ad785a44so209611566b.3;
        Thu, 21 Mar 2024 23:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711089946; x=1711694746; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k0ZX0mSNtR84zaDW6QrVcacYADFhCeQmdayKmvm0d6c=;
        b=kjkHHFTTdjABgPaMb3QPIMWLfVZGR1031sE8cGw1Nlzk/Ffr/vMEYRb95mq3QPr7+k
         wbcv6ZxfyLR41mv+hxJ4Jt/xSzB3aQVl6ioa3d0XdIJz53I0m2w+QX1MeRTh/cHfwx8s
         n7sRlcAyA/9rnjkYXznIwCv/5zhkaq5nPJ07EBcwQP7AjzNG7o4ko4nhvL/BeMBK5xfy
         iKn40tjWnEeMu7AzXcSGTK0XbrVwf3MkavEUbNs3VtmHYk0rdBxY3mbZxRBjfrZ2AdcZ
         q9vzJEFVuGE8/ykHKlw3M3eMn4k5wjS+kP7RRC73Xzq/gOK6cCYzZLCnulA5CFBJK/+e
         QIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711089946; x=1711694746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0ZX0mSNtR84zaDW6QrVcacYADFhCeQmdayKmvm0d6c=;
        b=egI5H9cWcRBjDUiPklxLL8D5hmj4m2hpe3WCeJ+rLINS2qsxmfcVwRn8s41ieDok2r
         btqEPfyEInmB+8TUzNy0YKet97dvkoSjV40vYeeOLQiPlWWJ1ODFVBBiZq8AcLnQd2K5
         IhHwUhu3V2aavc4CeKJWvHXXdLef6swoxdIcM7BQeBncLgZtdzOWxFbhHGibZsyiSTk7
         93WNo7ACr0NRq1CWqn9mDf1QGpoN0rHr8Jewzze+OsjtnYxKDH8c6DWzLFy49C5r6vZO
         6tnclcrtJjiZpZD4mvvOxWIDJssW98e5zk2LlWPIPWmgmMjC6/lgMYciolJTF4VEDiG/
         MEnA==
X-Forwarded-Encrypted: i=1; AJvYcCVd1P7S5u3c42MgtsSdYjyB29UNL9XdD3dgm5tI46DCtP82OSHLAfBEbVFKEvv8GM/BD+MSlgfNC27XRE7UJluB3L66tZny8A4EHF3vUfjfcQ/G5Svb6Dz44zk3R8c6HuPUT6kzQVJHPw==
X-Gm-Message-State: AOJu0Yw8wfQ0tuCA5sXw0GcatSDCe9DpclbeX5Z8dhf+upUhZGHpWkI7
	8ZhRVVzpbvGNzHtoqWTIlRRtjwMHfSJjD2ZWt3T1CI1sB6DOWEKx
X-Google-Smtp-Source: AGHT+IHWTwuW8UIUUoXFTdiYrzTtIrzPGEkZkGQ8lAESE+yEAIlcPzGhuzwEM7g3eVOt5C0rx4FIKQ==
X-Received: by 2002:a17:906:38d7:b0:a46:1d4b:d81 with SMTP id r23-20020a17090638d700b00a461d4b0d81mr1014632ejd.62.1711089945564;
        Thu, 21 Mar 2024 23:45:45 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id e19-20020a170906375300b00a46bb8a44cdsm679694ejc.198.2024.03.21.23.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 23:45:45 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 22 Mar 2024 07:45:30 +0100
Subject: [PATCH v2 5/5] dt-bindings: hwmon: ibm,p8-occ-hwmon: move to
 trivial devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240322-hwmon_dtschema-v2-5-570bee1acecb@gmail.com>
References: <20240322-hwmon_dtschema-v2-0-570bee1acecb@gmail.com>
In-Reply-To: <20240322-hwmon_dtschema-v2-0-570bee1acecb@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711089934; l=2051;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=4rUBSyPV6ao55dHemnHVuLdadgQFFoAi54Gb6HBKVTY=;
 b=q70/gdmXCi4RvGIZ+Icn9EMX+Srdt6GnUw1wapHGSfBb5rKgsJsBrfeEQjXEbzRQpC0yBmLNL
 yBJQ7F88FHLBJrbYbGpP85x5g38ot1Fi6LVn2jSQHMJlPTSEvepiCto
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This binding meets the requirements to be converted to dtschema
via trivial-devices.yaml.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/hwmon/ibm,p8-occ-hwmon.txt | 25 ----------------------
 .../devicetree/bindings/trivial-devices.yaml       |  2 ++
 2 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ibm,p8-occ-hwmon.txt b/Documentation/devicetree/bindings/hwmon/ibm,p8-occ-hwmon.txt
deleted file mode 100644
index 5dc5d2e2573d..000000000000
--- a/Documentation/devicetree/bindings/hwmon/ibm,p8-occ-hwmon.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Device-tree bindings for I2C-based On-Chip Controller hwmon device
-------------------------------------------------------------------
-
-Required properties:
- - compatible = "ibm,p8-occ-hwmon";
- - reg = <I2C address>;			: I2C bus address
-
-Examples:
-
-    i2c-bus@100 {
-        #address-cells = <1>;
-        #size-cells = <0>;
-        clock-frequency = <100000>;
-        < more properties >
-
-        occ-hwmon@1 {
-            compatible = "ibm,p8-occ-hwmon";
-            reg = <0x50>;
-        };
-
-        occ-hwmon@2 {
-            compatible = "ibm,p8-occ-hwmon";
-            reg = <0x51>;
-        };
-    };
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index e07be7bf8395..87b0dd9b0734 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -126,6 +126,8 @@ properties:
           - ibm,cffps1
             # IBM Common Form Factor Power Supply Versions 2
           - ibm,cffps2
+            # IBM On-Chip Controller hwmon device
+          - ibm,p8-occ-hwmon
             # Infineon barometric pressure and temperature sensor
           - infineon,dps310
             # Infineon IR36021 digital POL buck controller

-- 
2.40.1


