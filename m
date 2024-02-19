Return-Path: <linux-kernel+bounces-72137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610AF85AFDA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 00:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926191C2370C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13DF56773;
	Mon, 19 Feb 2024 23:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQDU1EO2"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8623F57307;
	Mon, 19 Feb 2024 23:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708386298; cv=none; b=qrobbavae21UORS026/bLPdGDEkRzJP6HbqmGX8icW5ttAAVrF61fLzyuEozBKDvg7uNR1INwUX3rwHgxlOSEcEz0vAinasNB8E5BStHhOlRdDaPTNemGx0B7ALtsuK7Tdo1vuN3EC/thylFL9Q6imoQiJxgGZQOQg6rymn9n+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708386298; c=relaxed/simple;
	bh=H+V3H/pUojjUDeW+Drln+Q8pnAl3NAhUesryrOUfrE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ObhvE2tr+B1UQ0n3mlwqRiUbY/+IFgEhYDPmUnpql8WqNaHBs97xi633qxfETCNlfZ9Y4X0FnT0s4Mp1jUjVIegQy+hbBemOh4650nFzfeW6fc9gP+bzTzRugR2OsYVXSHoUg50LiAWbIyt41kKcVhJOhdthBY+jKLIwnwEnlOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQDU1EO2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d932f6ccfaso39708565ad.1;
        Mon, 19 Feb 2024 15:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708386296; x=1708991096; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LueoYuZoj0tdtI/F/x4411lJmW0/7TmefZQEZfrpPmg=;
        b=NQDU1EO2cYD2pLu0BdeLvUBQsnmIKYzM6wSfCLhq81DVlOgKPYr8USnThVO+z0w855
         PmYvCK5X9VKRdu09+1GBG3lxPzHU1JdZ2ZJV4FHzyZizncY/LHZQsAorpR1udEQ3UaNJ
         vV8Lq2Dg++yB6W2Hr2Dqt6SzWOI6lbx5RllGcs1NIjs/JlcLPaueAvHHfCz9j+2B+jVl
         hIXsChh/73upY3d1e9UF3gx1zZgjEzIQs0a4+83bV1DVYlUIVrAlePaNzgJJDSQTWbzk
         fdm3etg0G4QdDImUnasWdnMP1bWXz0VzDXmY3tyOfYhqyuiFs6NPzRYY1L5uZve4qv3K
         3g0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708386296; x=1708991096;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LueoYuZoj0tdtI/F/x4411lJmW0/7TmefZQEZfrpPmg=;
        b=fO65zlqHI9/Ec0Ypv0JYteni6ZvmssiCRDe1/HNWqipuAbJeUzzOnYNsFq/oj9XbQN
         gaYeS8ckRyo/8RsF4WJMKkd3DdvQNqW1LRvJkBnk0nAxWU0z+kNM9jmrcpAET8IAsWWx
         9wJ1A1B6ls7voPwX4AqqAMEmwRKJM6m07x/CSl3QBPCgPQPXFHuGzi3WaL76aQe0UJX0
         9H432ZaTTChHWDuywT5xzuWFdqKn5GKBplcwoxzzo4RKy7HQo75fUiBgsvWfVmeer/Ek
         Q/lfhex85+Q8mDsQEeYX0w/ago6LD0w8ePlMsOyQYq4rKpNvytKkD1BjMV2lQQZtIi3i
         aEiA==
X-Forwarded-Encrypted: i=1; AJvYcCURNmqJrQFWsem19/SXF1ZFBrVm0FAvujlB1S4x2ekqV2dwKeF0IrSzz4RosQQjCQDgA5d2S7bKU2AonnLcKrMuZQ3JP5Cq2N6KGzc8QxbHc14raFsRq0mYEvRJd1LZdCOI+BYYzWtkvA==
X-Gm-Message-State: AOJu0YxsRJys4okainPYvmN1edh2ijFhATRMpge2zuYDBHyj5OeOBJuy
	qEbvALQB8kP6VwYgL4eXow22xmlwqMYI+pCwCYzll1Jf18kZdlaH
X-Google-Smtp-Source: AGHT+IF4lSUWw78zeKTcoUCUVkEL/5ACwhRIKgtKqWOdQ3saNXSreYNT+/FoR1Q5/x737j0nzbG9Uw==
X-Received: by 2002:a17:902:ea04:b0:1db:cb13:6792 with SMTP id s4-20020a170902ea0400b001dbcb136792mr7385956plg.5.1708386295573;
        Mon, 19 Feb 2024 15:44:55 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([2804:c:204:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902eec400b001db7ed7ac34sm4903477plb.297.2024.02.19.15.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 15:44:54 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 19 Feb 2024 20:44:40 -0300
Subject: [PATCH net-next v4 1/3] dt-bindings: net: dsa: realtek:
 reset-gpios is not required
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240219-realtek-reset-v4-1-858b82a29503@gmail.com>
References: <20240219-realtek-reset-v4-0-858b82a29503@gmail.com>
In-Reply-To: <20240219-realtek-reset-v4-0-858b82a29503@gmail.com>
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
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBl0+ftFGwQ3f7Vc5ZoKQlIMQIGYdJ/7AUnuvqCz
 p1fm+RfWg6JATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZdPn7QAKCRC7Edu60Qc7
 VkD8B/4pgClUom4bSS2DHLwU9JxSuQ3XLoyfKhTCoDJiW58dyarql/+fdrzFqnCa1LN/FWnMM0+
 xgk8xSN53jNume5oIcKals2/sgEBr1YJARU44SJ4nrSf+mEvINPmrD1TJ+MFjAyWtb/xIyfxoOM
 pH8UTTXFkmVizWk5lk2GWc55sRDAZH+deLhT4AnCBgjoEbtZLiJiVOXdqDlZGlM1chUfe01pFWu
 /fJ1wjjxHPF88zbtEZHWTj5YHo8cnIRIt1u6ZZZ6EvWowA7rMT5B5yoPpYaZZ4XnXXb2C5dFWvp
 G7roQxbLz6cyLYEkRSN6p6J8LW2tk1Dzu9hy69PfEtP33wan
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


