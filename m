Return-Path: <linux-kernel+bounces-64621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6878540F5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D71B5B21328
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24BF8F59;
	Wed, 14 Feb 2024 00:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPwsNyUW"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70A579E4;
	Wed, 14 Feb 2024 00:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707872074; cv=none; b=GxFrnsZzXjFk+5E615QhjY5kmYrsTIss8wxT/L/hzBGJBnFgh/Q2ITuuRCZiThjT4rK92K27OwegowRSnYBbmcsXU8uiHPImhDFw3SGw5yEPr0Uxyzxge+NXA+aQxxgPcampVA3Sy7JCQ4QD+CDvNKOu7gtYRV+UciRnokFGkCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707872074; c=relaxed/simple;
	bh=H+V3H/pUojjUDeW+Drln+Q8pnAl3NAhUesryrOUfrE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G+nvIU/wnGvsszkK0Dj1ipiW91wzmuNWkiSg/lS+biYr2Sxz2Iiwa0VJ9tTmpvAZuuIRZHG8ELKdVdWkKxi5/cgNPQ+yDpyDZlIuDiiqOlwGTiarOYX2dU9P5ypWyD1gROtr3tEfyMGKOUUF0rrCla17YIg6ze1vk4fUVGm9KSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPwsNyUW; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so3301850a12.0;
        Tue, 13 Feb 2024 16:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707872072; x=1708476872; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LueoYuZoj0tdtI/F/x4411lJmW0/7TmefZQEZfrpPmg=;
        b=dPwsNyUWR2Rus1zqntGck5QsBHrReqNEIoi9B2FVi0az7nAYEdJDN9/wD6hijMWG8b
         3LZnxOok5OMhCHBfDYp+njV23J0JmtZl1nKva3rpOgsGOkRiqGz+uu9GjJOffzDg73L7
         gw6yGAXqHijTx1shRq5QRNNMQd04nYdvdGNOpIKcMAT15GTGuKsGfQIhV9LuD2dViJyY
         zTgKCKDNewId1iGy4L5odhgJnY75hDB4NyJODTy1QlaGFImUvp4LSp5KPu2B50m7kM9A
         2OBcr3v8ctliz5ZSpmNS9yCNKs/T4mZWkHZLwbSMGvZdql/dA6AgrkxLg9LZ9zUbbWne
         /zqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707872072; x=1708476872;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LueoYuZoj0tdtI/F/x4411lJmW0/7TmefZQEZfrpPmg=;
        b=OYtGS/77fDp4IKgYuNF67OEyP/Q0lHlxXYueyE7LEfOptc0BVruGARouyNrJNm8Y53
         vGZzYmMTUYJjhiEe6tcgEC4ieW1sEJ7aYDyHhBta5PToKorn9BB8jUeKbD915b8pQ/Df
         rXuGIOP8WNdvOsq7XvKqDsUrFwFfb2tihqNyL1w7Df6e/YnI4TpaMhGZ0m9cYKRes0jl
         8pr4yYqjFEN+dvVrAENksxj1QW7WXdSMWnbPHJoPy9OnXpg2NxLQCFpyjyGZC9wr84V/
         7xUUD4MsdLUsfce7xlLGlmQS1jAaNkVtvM86ds8sk9bCVKQYoI7Fv3kah2b2WEweEr+M
         uJdA==
X-Forwarded-Encrypted: i=1; AJvYcCW+P4pS+seXBuhjtdro539omeXpp6wvkJEnBTgXj4h0WmBFjG2LGcHBVzZbGNH2EUhTv2YJi/kSBFkm0q9n523N7NLXoLxibiTVEMKLuxIjIL/O/cLBGVz28eVnUM83JYAWRqvHRJsLMA==
X-Gm-Message-State: AOJu0YzumLQCaOMz1d8lkQTxB5p2md0hkqTfmRI9gHKd4G6slLF0EloX
	uTLEnDijMaf1LNbMQiRPFn15jpAoAzAWevyvBG6Hlspmrr/QXl4e
X-Google-Smtp-Source: AGHT+IGRKwM5VgclU7DYD5F3eTHEzMXSzHHdrPnUCPg7As1kOCrsB7/0iMm8yLZho2DQy+fBzDIdUw==
X-Received: by 2002:a05:6a20:43ab:b0:19c:6a9c:2c76 with SMTP id i43-20020a056a2043ab00b0019c6a9c2c76mr1565963pzl.10.1707872071933;
        Tue, 13 Feb 2024 16:54:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV71m1vw6BMjX8z5onBCo7okiJvy33cyAb6RJotJfj51XKB4dQodLyii4kJzrvz9aqPfjrPZxRx0LmpcnXkgM5JGW1DLxizBkS+9ZTAdoNKYBySTiXePgOpIiUiuYycx9rfBsIIotOpQ0Xnhj/wYOhgYRUNHZIGo0wuMOGL1DP+Z0X8Ov5t1x0m9ItP5QMgpWS+MaBMMYll+gv3b38N1EAMarTaS6Vxg8fO1JKLhbrjTE1/1utJS6eVbUr7N2b8wSHsX308vpC2rB+ZueonKL5aWttC2nWSc9L0co1RIKzSFwXzADRgTxL8DRcJW0ENZK86prt8l0SUR3qg52q0s7mtf7FfsLqKG7k8eRuDD4lyxA+qElBHLAOiTsQzJYUIAf/0dSURhcqgOnSojFjybQyo7x9pNgYw5EI7v6h7BSXZDED39hKcZ5JHroGRnVkXPotjjTEXeMvQ1mzdN+O6ViNyJ1TFx7nz62HDe0v7I4UXwjeZo/pyZ28GNE5MXtzArOe+sSWSPc9u2LCdLNgYK1hPr1vsoEMz9dctrc1IPciQqRTmuanr
Received: from tresc054937.tre-sc.gov.br ([2804:c:204:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id q10-20020aa7982a000000b006e094bf05f4sm8005694pfl.213.2024.02.13.16.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 16:54:31 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 13 Feb 2024 21:54:15 -0300
Subject: [PATCH net-next v3 1/3] dt-bindings: net: dsa: realtek:
 reset-gpios is not required
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240213-realtek-reset-v3-1-37837e574713@gmail.com>
References: <20240213-realtek-reset-v3-0-37837e574713@gmail.com>
In-Reply-To: <20240213-realtek-reset-v3-0-37837e574713@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1010; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=H+V3H/pUojjUDeW+Drln+Q8pnAl3NAhUesryrOUfrE8=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBlzA89CzCn2LhoEdVuY8Dx2HQjw6UsZEIg1Rpk+
 1OapDXN78yJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZcwPPQAKCRC7Edu60Qc7
 VvCFB/0Q3Gzprs8PlbF2QJvKVhs4I/uSh3llF/mUsc6lCLFaYSpSjBckdEvNQwTZZk4ksuo/Kcd
 eJJ0a1NfzeUM95NEOjopCL2CH6Q7l+RSNUKTYubdVPhla0exbjN4PeKKtNwJ7HpkoEoczYWdhOJ
 h92+HucGDsqIHtI8c123zck1/Vh41OVvpusw45IP18CtiNCvURrpk6jgug7s09X4Lr6kYAGNVkR
 Qai96D3/tWnIErecl5A/ULcJfe25558Dt95LSZUuLbWYXxSvZxDuvSzg25VqCswlif+h/kw8kud
 fSrQP77PMXWHg2L3GXYT653FWApFoI69AoFPdnTVpy763gUD
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

The 'reset-gpios' should not be mandatory. although they might be
required for some devices if the switch reset was left asserted by a
previous driver, such as the bootloader.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: devicetree@vger.kernel.org
Acked-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 Documentation/devicetree/bindings/net/dsa/realtek.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/realtek.yaml b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
index cce692f57b08..46e113df77c8 100644
--- a/Documentation/devicetree/bindings/net/dsa/realtek.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
@@ -127,7 +127,6 @@ else:
     - mdc-gpios
     - mdio-gpios
     - mdio
-    - reset-gpios
 
 required:
   - compatible

-- 
2.43.0


