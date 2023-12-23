Return-Path: <linux-kernel+bounces-10375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1101881D37E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 11:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43AD21C21F31
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 10:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9C8D261;
	Sat, 23 Dec 2023 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceZ9G0P0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712CA8F75;
	Sat, 23 Dec 2023 10:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a233bf14cafso316181666b.2;
        Sat, 23 Dec 2023 02:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703325855; x=1703930655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gc28l/2FLaF44Fu/nhHi9tteuTF/UT+cvB8sPi4oGPA=;
        b=ceZ9G0P0IAxqpwjR0SD9fPyDZiB3mOY7RiuG12NOkdsgUxdH6snaAHB694PSj2m7oh
         dfBbAC33HonLk8gYrtHEyzthD1Qd7Vw6JGq+MbYbU5qQauP6FiOGERVsnWoPHYUjcZpp
         rEpsIgQXo8eV+Tr03ajrID6TnXF9Xvf41uRVhldVOfq9cOMAjf6QiG6VT55C+ERbmP34
         xIqKJuq8mcLqGGwfmW81CgfG5vzNFxMfzillSZ1PS1qK5K6PKv9Xo83xtU3kPoZqfcCK
         2Hqw3F3y9fGymlmH47DuRKvE2G35gNPM6+FCxpz2wh0TwfgOL6QCAkq18H/NmGzGmCUX
         QFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703325855; x=1703930655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gc28l/2FLaF44Fu/nhHi9tteuTF/UT+cvB8sPi4oGPA=;
        b=cka+RFfKbpDu81LzI8c5JR3kK+0rBZrXI1GUzb8i5AA5VATF8q+ffUmYZe9YfalmM6
         tj68thWEcY2PI54nohyrESs9zoaWW9wNrYbQDKFlG3BqjVb5k4I4YvW+z7W5AKqUHx1r
         GWla5L7cwiKBMLsXZmOeb4yAnkMuKGG5oFITQReJAsApqKgm+DT9+XnVEM4k2VXUkwEp
         TnTT+uzh2nlenK6OukxZn9ccyUzn3Ju1jubqve2cqH+nMDCwf3USyQ4CF5ga4FvP0IVf
         GGtPn8xkEb+pStSCdYXG77xIoEI1pnYtovQ8wDWE9OoHaGB2p0N3aNH/aJr0EOFt2XMc
         7qTA==
X-Gm-Message-State: AOJu0Ywc1O46SfKSiguOy4KyDh48VNCqFuPs4B5gIqDgQwPqj+LrfXvD
	VnZ4DUMEaMoUtJ1LevXBpGo=
X-Google-Smtp-Source: AGHT+IEir6jUHFCW/HNVoQ0oJRTriWHtR8OpDd+yuf9CjTP9+1aNtgmV25Nerjngmat5QZ39rkPt9w==
X-Received: by 2002:a17:906:a849:b0:a23:329c:3433 with SMTP id dx9-20020a170906a84900b00a23329c3433mr1327651ejb.56.1703325855715;
        Sat, 23 Dec 2023 02:04:15 -0800 (PST)
Received: from cjw-notebook.. (188-23-116-43.adsl.highway.telekom.at. [188.23.116.43])
        by smtp.gmail.com with ESMTPSA id su24-20020a17090703d800b00a26ab41d0f7sm2357765ejb.26.2023.12.23.02.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 02:04:15 -0800 (PST)
From: Christoph Winklhofer <cj.winklhofer@gmail.com>
To: krzysztof.kozlowski@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christoph Winklhofer <cj.winklhofer@gmail.com>
Subject: [PATCH v2 2/3] dt-bindings: serial: allow onewire as child node
Date: Sat, 23 Dec 2023 11:04:07 +0100
Message-ID: <20231223100408.44056-3-cj.winklhofer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231223100408.44056-1-cj.winklhofer@gmail.com>
References: <20231223100408.44056-1-cj.winklhofer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The UART 1-Wire bus utilizes the Serial Device Bus to create the 1-wire
timing patterns.

Signed-off-by: Christoph Winklhofer <cj.winklhofer@gmail.com>
---
 Documentation/devicetree/bindings/serial/serial.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/serial.yaml b/Documentation/devicetree/bindings/serial/serial.yaml
index 65804ca274ae..ffc9198ae214 100644
--- a/Documentation/devicetree/bindings/serial/serial.yaml
+++ b/Documentation/devicetree/bindings/serial/serial.yaml
@@ -88,7 +88,7 @@ properties:
       TX FIFO threshold configuration (in bytes).
 
 patternProperties:
-  "^(bluetooth|bluetooth-gnss|gnss|gps|mcu)$":
+  "^(bluetooth|bluetooth-gnss|gnss|gps|mcu|onewire)$":
     if:
       type: object
     then:
-- 
2.43.0


