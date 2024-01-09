Return-Path: <linux-kernel+bounces-20860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2FA828674
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F11DB242BD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98EA3987D;
	Tue,  9 Jan 2024 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r1Zuhkmu"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A5938F9C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 12:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3368ae75082so2213349f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 04:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704805113; x=1705409913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJrLSScx+Kg0xKGZsxHeMIlo3t4+N2J/9tXIuV54jXY=;
        b=r1Zuhkmu1pmgD6giY5NOzBkgd7BxQFqv+sTb/EczDD9fLsPtoM+HgPFCC7vR8F2f+n
         FYZ4n2HgBXbDkDPpWAEsW5J5hgGX6pmwYOBoegFrRRtTaE/Cesr+BCPd2y+NHl7Xq8rS
         DALtoAXpjgtM/eW6BAaDbMD14hbIWssJ1MliHJ4dP6kPAQgnaX5UgWIQcfHgCnqw89c9
         x6yQz4f+1woEu72y6gO/Aq3sQOO77m0xyBLPKgXPV3LFplr/C7PBtczTZOVifLAL0qN0
         +bRqi10bTjihyT0g4AaDjDM3HUDjYQVqzcBjLho7UCx0VQswaESbTf6WLygWlEChLIz8
         t7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704805113; x=1705409913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJrLSScx+Kg0xKGZsxHeMIlo3t4+N2J/9tXIuV54jXY=;
        b=Uo1h9DQ2DwQgoW3XqaNoncEnZjgWaEsjlQdgiexu1CgFNcUPpDvPs3wHlZ60448sQC
         9MMBsblb2B0fK7V/s86ru3zzFVq6rPGQzC7QJAyz85aIAGkZttEJPzmXi0e54jV3UWaZ
         JyL1ayvvDxYpOUSMd8u+YwVAjvBDmZ+xuKO1iHaRXb9khAI4+TpVjnLq1qmdL9sJop9R
         X3Baq3hcCM+0zsTCZwopKlvuqItiGgxxIp7VJ3NnyolpNKkS7dx4V5fg562vFOkXdU5D
         dO7tfw0/fKJfXoMMwwVn1ShDqXBih8xomEzJ1zaQXU7YiLggq62+4DUTS6ZQT3/gwHIP
         idyg==
X-Gm-Message-State: AOJu0YyaSP12YTrLpXRB19JPjpVv4yGqu7N/VdZf5Gq7i1Ai7uxnpuoI
	2G+eOiVp+3i2ZMbD+Gv85IFXqHBb/JdYkw==
X-Google-Smtp-Source: AGHT+IG99CWD951Q5V2toPvO6G1nhCnt1vNx3YMD3bUpgj+DUjA0ncxLc94mFArBzl45B4ITaRAVCg==
X-Received: by 2002:a05:600c:1695:b0:40e:43d3:209d with SMTP id k21-20020a05600c169500b0040e43d3209dmr355287wmn.168.1704805112974;
        Tue, 09 Jan 2024 04:58:32 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id cw16-20020a056000091000b0033753a61e96sm2351302wrb.108.2024.01.09.04.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 04:58:32 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: peter.griffin@linaro.org,
	krzysztof.kozlowski+dt@linaro.org,
	gregkh@linuxfoundation.org
Cc: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	andi.shyti@kernel.org,
	alim.akhtar@samsung.com,
	jirislaby@kernel.org,
	s.nawrocki@samsung.com,
	tomasz.figa@gmail.com,
	cw00.choi@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-serial@vger.kernel.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 03/12] dt-bindings: serial: samsung: do not allow reg-io-width for gs101
Date: Tue,  9 Jan 2024 12:58:05 +0000
Message-ID: <20240109125814.3691033-4-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20240109125814.3691033-1-tudor.ambarus@linaro.org>
References: <20240109125814.3691033-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All gs101 serial ports are restricted to 32-bit register accesses.
This requirement will be inferred from the compatible. Do not allow
the reg-io-width property for the google,gs101-uart compatible.

Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
v3: collect Peter's R-b tag
v2: new patch

 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 133259ed3a34..0f0131026911 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -143,6 +143,8 @@ allOf:
     then:
       required:
         - samsung,uart-fifosize
+      properties:
+        reg-io-width: false
 
 unevaluatedProperties: false
 
-- 
2.43.0.472.g3155946c3a-goog


