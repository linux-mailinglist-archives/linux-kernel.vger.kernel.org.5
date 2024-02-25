Return-Path: <linux-kernel+bounces-80201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D31862BBF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03DDD1F21665
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D31317BB3;
	Sun, 25 Feb 2024 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4Qk8ird"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5D418E2A;
	Sun, 25 Feb 2024 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708878609; cv=none; b=cqwPvr7BvE2P3kYHWT/D17Ll8mBqsdxTnOvripFX8e3mFCMev5m+83l4HMHDCSj0o+25T92wWM2QAytDMMUAwPwF4BdR8jZXrwojlQxB+YQJtKFU/q1kQSkgTJGSefstcBvOV9PzryIzqJEs50rZOs1rrUpJ16Z4EooH6tYrabQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708878609; c=relaxed/simple;
	bh=H+V3H/pUojjUDeW+Drln+Q8pnAl3NAhUesryrOUfrE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jPfNYSs5Add2hrlJ6nxpLFZojRmhEPfltNoc0NQKAudkiISw4EB4eU90hE1BhER8HwrXEvH2QNqSQ1qYAm5Sxmgqet1pSH+XV401uo2M/tzd1S6Viw0c3Bl/ZrfQun4AmgUZxzWRgcI2zVMiKF3Qhu5uYLpUUl5gKNO/dqMRCjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4Qk8ird; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so1949298a12.0;
        Sun, 25 Feb 2024 08:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708878608; x=1709483408; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LueoYuZoj0tdtI/F/x4411lJmW0/7TmefZQEZfrpPmg=;
        b=P4Qk8irdjcNn74S2NNP5QBVuJtCuM1f19KrMTE7EcCG/y/HV4rG1diMl/IDjhcCR8n
         AVLNox/zLun9AD3HodmLpFZO6QpC101iDtIob4xzYHRuHnxAZE9XgSzsDqg2sq7kvoqN
         m2ZkpLkbLOVTr0eleVnnZGdH/4ZyOftoXefYrJeavPwCDi3nBUi4Ov2FeaOyXC9H80dG
         yFE5j0eFUzDd9jXXxQDoqOxpiXeN4al5IMw4AynByZOcTxB3jayZdAL7S2lZuMfrvPTq
         kWK3uhSw4CS6pRt+SAnHizd5+/qb0t25Ckie7Fv3kZdnWOXJCz2HFvzVngNEVmdKnBoC
         tXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708878608; x=1709483408;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LueoYuZoj0tdtI/F/x4411lJmW0/7TmefZQEZfrpPmg=;
        b=ps3Uq37SnfOQ+suXRBjy2zXJEddwH1qM4RDyS5b+DMEqnITQVkQZO194n4i9iaF0aP
         sv4DVFqXFbi0kU9HC8FaMWzXPowdMioCqVYMSJ9mrPx1T6FhKoif+qHeB/5438wSxeCV
         r2SuP5+Z7RCFKgk3z4vKyyJIFNC7lozo6aERnOglBvybSHqQHSx3iMfipOyWJBHirgEV
         gyVfX7cYZ3cjZig0X+DbcKAjUL+ZlNhN4pllVafbSzq8K8VFMRXevdmmrE8NyT6ETQPu
         i5EBhx3Bf9dZzlmm/wz8f3tNIxqfmHyIMiLjLtHzGzFwvJU5mym+GU1MBXrySibatt5m
         B/5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXeDZUDkmceoVYg3SL3gtr+WhTVlejY/Nnw9zDdIAG1UvCZ1tQ65yKmkQU7nDwvARJYUm+ZNJDz9CSdZFwgfg6M2t26jTaUbP76L9F6gKQeJvF1Ci/Bz2ttfvr1kOOsmWLjwg0z0gKeUw==
X-Gm-Message-State: AOJu0YzQOR5u4fs1f9XwoDgt4qP2FGfYKYP8KsKLuiC2tfwYxU9liQsK
	93bwwp2FlaqMtdCmJPwh8SdMq25SNwR8O/OUuSMZyyPZM+oaksnp
X-Google-Smtp-Source: AGHT+IExp+MBHria1an1Fsmu+96LzSZ8nMI4ZxS5Ag/wXJBQVTgkNXHqN3pORj9Ct/bw35199N3j6w==
X-Received: by 2002:a05:6a21:3988:b0:1a0:e9ad:7f29 with SMTP id ad8-20020a056a21398800b001a0e9ad7f29mr4129943pzc.6.1708878607737;
        Sun, 25 Feb 2024 08:30:07 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br (177-131-126-82.acessoline.net.br. [177.131.126.82])
        by smtp.gmail.com with ESMTPSA id a12-20020a17090acb8c00b0029a4089fbf0sm2838367pju.16.2024.02.25.08.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 08:30:07 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 25 Feb 2024 13:29:53 -0300
Subject: [PATCH net-next v5 1/3] dt-bindings: net: dsa: realtek:
 reset-gpios is not required
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240225-realtek-reset-v5-1-5a4dc0879dfb@gmail.com>
References: <20240225-realtek-reset-v5-0-5a4dc0879dfb@gmail.com>
In-Reply-To: <20240225-realtek-reset-v5-0-5a4dc0879dfb@gmail.com>
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
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBl22sEGQvYrPkoL751LFYsDfZ9gBJNCqd+RGELj
 qvgpAcnDz+JATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZdtrBAAKCRC7Edu60Qc7
 VtR1B/0bmfzeIZCXMxGxpitA50keV6HopEA/e08HFuLx1ZzDL9KSEWD2JEudxzjDxnS43C/XYlq
 IQBZ2ysKfgzL+06MNSJ64lHIics39NJboFviQXznwQ00glXRaBEWT/DTWSdvWDaqBRH6q6IWUyy
 G42/UPt1gbJdQ19t66Y39lNbC3wSnMpmdYijPABfMY+otVZ7Z9bAWzKt+nZ3CjATuAJL20Npx50
 x4j1xFCSS/2sLNtNqKTvkprR5FFLVc9rfeM/Yd3j1i854I80LO8SFr4iQWtOVK2koGXWGbc9yZs
 Omwmdmvgcso50044ze+cVAuf2scy+T2sFCyUdEOUQvG7EpWr
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


