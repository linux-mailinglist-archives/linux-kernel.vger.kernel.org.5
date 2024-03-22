Return-Path: <linux-kernel+bounces-111020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5133E886704
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D834D2833FE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F3B1642C;
	Fri, 22 Mar 2024 06:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxVegGwG"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D782912E73;
	Fri, 22 Mar 2024 06:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089945; cv=none; b=ucbXF4KUcF8lmNT+yQsfU3S/T7MHefBHYhzFnz5TJCRF7ftXrrjopJyLTxc9AA5T2awEYLS0sfWXTui2SRrba6QUxqBKxcaf1/KjDj2ZznsPDjlcHl0RcfnSXHJE+5q4SAnyM/OHegkdf7mteFxLRIeBf0Wf5tLSGwELrhJU8bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089945; c=relaxed/simple;
	bh=ZcfJW77o+avPTeg2tdUvNFQMCBaJDocyWKaLWxFMj3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K3arhcvjXRw6K4+1GS7CQNXIBRIsxRN2Fb5LA8oGqI2Cz2iPpeeXQmaQjl1/gTJlX5+up9jBoGDI5hBuUYxBPmhtKYIcGuDSZgim1wvmJa7Ef0lUtsYVjrWzR/DYfPDBkKUqlIg/ILJxP+0Vp0JGVbijur45VzcFFEaW0MNUxpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxVegGwG; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a44665605f3so206138166b.2;
        Thu, 21 Mar 2024 23:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711089942; x=1711694742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D0ZcSySu+KpK49bvvLZjoVLSgT/8Vz6AsAvPYvNMC5c=;
        b=GxVegGwGoIJQFgvnI0+hjYUwwqP6V70yEKV0zb850r9JUi7ARkoJtO9Yk6g05P0QWF
         SW+aquLQUALrAFyiJfw59t0aHS0jaTYH7h3oUH2FYGekoSnJNimU/mBBLdoQ9eIxwkqL
         OzWGUuHbXfHY7m69Wl8MkidNIgitWhDTpc2BK7Q/KNI9TaYOUF8jrzCRNvtDw5T4Dr+h
         4nAynYwKVr/GWaqhYDP82HOP/emH9Yc/1TROa3op7WAqq426I8+bcN43gsIpRt1c6Y4V
         Bx1Xs3fgJcdr3a0vz1XrpxkPK02veX8gFY36CFARbDzsY3r15wdvVWO5/f4X3WB2uaS8
         djqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711089942; x=1711694742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0ZcSySu+KpK49bvvLZjoVLSgT/8Vz6AsAvPYvNMC5c=;
        b=bomOTsgrYSFsSFQo49KcIVwbhrbioqT/K8y00PvxhSV+LbZHVA6iliIO3ZdEQKkJVG
         WWx4gJDVPFZzvoMmS6WhGQ+xbqsKxKclLtlKfKwSQpqPTdNnoGI3YQxSQAgrWHyGX2VS
         Yc/7a0qXXuPNOnd4UlUYfmNxRm+66TGWwweOfLLsyuBfdBOZ+8l8swHqIzk1zxwVaXx9
         E6ukAm3rNoKXSZzLQt9u4O5oK1IC/mxshC4WPyP9me4Chg8CPbB0lw4YtHflzI9QQLct
         1ABuBc51MXqOZ/d2nLpt7Iv/oyB7UaobHweaVKoCIeU3Sor2F1r1sWIF/YCDGyhAi7MB
         urVw==
X-Forwarded-Encrypted: i=1; AJvYcCU9oKLHV8lxipHgLtHwUYBdsI2qDQRkIbuLTOtm0TJ/qLMsSD7+0cLOFFl2vKcvWQqaINgG0JuLjNQ1uqRSkkHO/eIjM5c10u4j//I/MGDGSP7R69yex88/ZOJB1Drgyot3k27qZc6hNQ==
X-Gm-Message-State: AOJu0YxlwwAND3VOzE6go43vApNsDgra0hnUEu5AXRllNdJDCYwLJJPg
	xtdcMa8qAcBMezN6w7RyrzxAD6FoP1UZekiac9+nelcm2QwChTED
X-Google-Smtp-Source: AGHT+IFIXvems84M0PI0K8RQsadDz+FM4cpWGTpn+kIb/rANJTIm6DuJ39YJNFIbiRXd8h1N/nuJBg==
X-Received: by 2002:a17:906:1cc5:b0:a47:1f9d:594f with SMTP id i5-20020a1709061cc500b00a471f9d594fmr933241ejh.45.1711089942175;
        Thu, 21 Mar 2024 23:45:42 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id e19-20020a170906375300b00a46bb8a44cdsm679694ejc.198.2024.03.21.23.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 23:45:41 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 22 Mar 2024 07:45:28 +0100
Subject: [PATCH v2 3/5] dt-bindings: hwmon: pwm-fan: drop text file
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240322-hwmon_dtschema-v2-3-570bee1acecb@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711089934; l=582;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=ZcfJW77o+avPTeg2tdUvNFQMCBaJDocyWKaLWxFMj3M=;
 b=ooBwVciHMfKQ/gDnvt+gH3CzlaNb70fu8uWXmrc1NGsUHz5TUZv1NQ7muE2ALJoAXiAQA1ae6
 4Yz8w/pnt9eDDe/lDdcxJY2NPR5r2JM+9Z1+eaSoV24pIlyh/CbjN0O
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This binding was converted to dtschema a year ago.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/devicetree/bindings/hwmon/pwm-fan.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
deleted file mode 100644
index 48886f0ce415..000000000000
--- a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
+++ /dev/null
@@ -1 +0,0 @@
-This file has moved to pwm-fan.yaml.

-- 
2.40.1


