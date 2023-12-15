Return-Path: <linux-kernel+bounces-1289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BB0814CF6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D831C2103B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDEE3C496;
	Fri, 15 Dec 2023 16:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9yGUt10"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4783B3C062;
	Fri, 15 Dec 2023 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d367e7092eso6697335ad.0;
        Fri, 15 Dec 2023 08:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702657527; x=1703262327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zDqL6HCL3y7lDRDTbr/lo7FN7BFLZEzd5vvB4zRQhig=;
        b=G9yGUt10KGCg8rj6K/ZU0ApiP+osgxeOhN4TvFD4Eh5biTxkyW+DkaiDBeCtCjY7BH
         XGrfEwl6jzMXhh+31q7KlP44GTQ+7XPpkFJQCXSk+X3zNAV52/LGOwfwWN1V3Y+cBqnE
         5soloRPqKhsf8uPLy2hJx35Bf255cDeugWXYInGqsRaU547vAyx+i5XcrJWvwGSSt8G+
         iUQYP35JXAR4FBLdf11Oz3ueb/c9jHla6kD0c8kn5uEvhXP57Yd3taM1vaNkPhVEMp7i
         zPKLFWwQUXqJK/wuRTFkFk/Q5Fh35fFrcc1IB1OM4//Lx408NHzEGz6MstN1uL9gmpbl
         bVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702657527; x=1703262327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zDqL6HCL3y7lDRDTbr/lo7FN7BFLZEzd5vvB4zRQhig=;
        b=iQAhE9jOLRA5U5HBvUKs9eZ0FF/DA2gyf0w+sduRxFzwaue2OchLvIunjjVUNEbrrQ
         +83w4V78XNFFp/fCGbx9kxx4vpzXDdPshy4haUn+/rOFRqsfTvRvp8ElKkZ5cvSqIwVT
         tn0eHckInxhd5B0jyWy6aUfDvtsxNEST6J7nleTiFX6Zo7Kw/VRy8MwVga1cvmZrxzXj
         rGJJLCEnuWEHiuIIh/21IG4VD2TgoUd02iZuL+BD7VSm92XMP4Xo5tkdr+3qD/KTJbwe
         0EQRXuZ3Rx4fcFdAJc18P4u8ZQhGjkwOvZxL3AafvtjNUW6NdSIoWUveIA+Ubm4CkiG2
         vDyQ==
X-Gm-Message-State: AOJu0YxfGpBC+pR/U6YqcNp9ZVA870MuihT187GgwDPF/V/7rXd3KRkI
	a3k7lK6vfVzGovz7n+PLutbKJKOGhwzyag==
X-Google-Smtp-Source: AGHT+IFUiy1uTHVX+IrL5elmcxSqJ1xdj2AGz7K/ki+zmPEMSFag93XQQOi50O+2ajZwgDl0R2N9zg==
X-Received: by 2002:a17:902:b948:b0:1d0:6ffd:e2eb with SMTP id h8-20020a170902b94800b001d06ffde2ebmr10020334pls.133.1702657527290;
        Fri, 15 Dec 2023 08:25:27 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:581e:798e:871c:98db:5638:a4])
        by smtp.gmail.com with ESMTPSA id s16-20020a170902989000b001bb750189desm14468665plp.255.2023.12.15.08.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 08:25:26 -0800 (PST)
From: Anshul Dalal <anshulusr@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Anshul Dalal <anshulusr@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/3] dt-bindings: vendor-prefixes: add aosong
Date: Fri, 15 Dec 2023 21:53:09 +0530
Message-ID: <20231215162312.143568-1-anshulusr@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Aosong Electronic Co., LTD. is a supplier for MEMS sensors such as AHT20
temperature and humidity sensor under the brand name Asair

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
---

Changes for v5,4,3:
- no updates

Changes for v2:
- Changed vendor prefix from asair to aosong

Previous versions:
v4: https://lore.kernel.org/lkml/20231125100139.193584-2-anshulusr@gmail.com/
v3: https://lore.kernel.org/lkml/20231121095800.2180870-1-anshulusr@gmail.com/
v2: https://lore.kernel.org/lkml/20231115125810.1394854-1-anshulusr@gmail.com/
v1: https://lore.kernel.org/lkml/20231107173100.62715-1-anshulusr@gmail.com/
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 573578db9509..48d4ff635562 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -117,6 +117,8 @@ patternProperties:
     description: Andes Technology Corporation
   "^anvo,.*":
     description: Anvo-Systems Dresden GmbH
+  "^aosong,.*":
+    description: Guangzhou Aosong Electronic Co., Ltd.
   "^apm,.*":
     description: Applied Micro Circuits Corporation (APM)
   "^apple,.*":
-- 
2.43.0


