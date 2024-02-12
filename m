Return-Path: <linux-kernel+bounces-62402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FD1851FB6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68004285466
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3744CE1F;
	Mon, 12 Feb 2024 21:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKSdDu0p"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115C64CDE5;
	Mon, 12 Feb 2024 21:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773699; cv=none; b=TeJ228RY/RB1l/IYfeRwz7Xr9xe4pxXFx/kXBiUUGyZsyhHrmCo+Q8b059u+8cUAsnY6n+5aHESNBZYWoZL/CWtbJi2Ese65fg6z/4qfdci91Bo0QLQbzlURLsS+GQmae6qNREM+5qSNBu/vs0pTQyPZt7SZ6UVZpzYoXfU8X5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773699; c=relaxed/simple;
	bh=MEChIYkvQHqxWqS/fjWdPqFHkAIj3ZLNWN4rsNfct7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nnjwAZthRZ3ipTyVom6fWNRvup98//CZ3gBS4krVvL2PM3GGL+rmESFaghc+sc7P6JvCZ0TnLDz2mppWzSwI2ysDn+6vlWXUh3JKM9aKOGkDnzpfrrIp9WBST42gEpPJCa9fr1nbgZtGo7rwPfT7asfF2ceF1yPzdLbtP2U9Q64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKSdDu0p; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d99c5f6bfeso28170765ad.1;
        Mon, 12 Feb 2024 13:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707773697; x=1708378497; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlNDhKCKO6Zl/pUC+lksP8PSO2guoSsHXwPfuNxeEAk=;
        b=EKSdDu0pvGj7E3Obwa/IjdVvtRvm1Airvo2CYPmBABfTQpPvrt2QB0IaAPRK796UDT
         cncQ9ES+AyhXZNMRbhS4rzZhWUBqw4r02FQ26QZBN9dUS4QPv4L6LREdSpNNcbYDZXxv
         shDtIbQxnqhZpx1QaoJAMmDWa3/Jp9iNUStiZMtSMAUY8NIzkDSk9pZkPSzBZh7DCFme
         hFBu2/I5MsLFr3qhVkI/7gEaCDJtRM2WJRQUvS60AKcy0rOoOvqrmAHIix8GL+J3xFPC
         Ku5G1wmTqFLOI19t2l/X4HCXmkioM7xKunLDQDMsMgqLw/hQdcpop1+7E6rAQcnlxgHc
         ZCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707773697; x=1708378497;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZlNDhKCKO6Zl/pUC+lksP8PSO2guoSsHXwPfuNxeEAk=;
        b=lCtzw9RexPp/fvBHYDaDYOR8z0+J4k7qHSYLFtLhW8m8c2trnpYstrwFr3sqACpmxq
         QupdzQyt+p/3rKEIIX1MYxjSrFzXqr2YE0HTs4GzUGyxbUyqCbViZaYuYxsEXL5SANf/
         Ed265Ew70EU1/ocK+F0KNLKZryp4gEgMiJdgtsybZ39+4HZOrxsmVNtce2bJJmls3p/d
         k/mdHURLmlA+hccDxQJSlaL7scOIJ9A3jdtQTwxBuaiilmDEr/CAh9SWR2zJbPXsJRCd
         X5nStJ5cGShHUwBPY6+niZ4mYAXzXGAH+ASlh5zbV9OHsY0mmgpCJFJwpGWjpZ+/gDBt
         1DlA==
X-Forwarded-Encrypted: i=1; AJvYcCVpFoVjGuKfeYxeJQQiEnDYOqIAbH+E/pUZ4Fj7PFbNv2UG5yfLRUmN1kYi3+Jk+PdJmnQQO5pOsJ/Sb26jDrAUFn0lwSxd5lpLTsJz
X-Gm-Message-State: AOJu0YzeCE4Rfuc7W77fwKLhCCz0MeVA5AYWA2Dqwm/j6OJQyPJu05vQ
	V+Elon/SsW9IlVNLSU3dWFXbVD+S9yPVjqH/ojzu1Z3DvVi+3gLNwU/P5fkRMrc=
X-Google-Smtp-Source: AGHT+IHwG8ZQ78DWxKJXaa4Y4H+scVFTspOdR2ITBiwAOR6QL2NZ98AKmOKV0dXKMEHndtdjhS4cog==
X-Received: by 2002:a17:902:e74a:b0:1d9:39b4:2039 with SMTP id p10-20020a170902e74a00b001d939b42039mr821746plf.30.1707773697234;
        Mon, 12 Feb 2024 13:34:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWqB0dGX0zbAujuGkYeJJU7kS/llOmthnOh3ugaq65OokgL85NZt+gqCzNrHjhq7Iq1ZQkPGd/+yeA0rVV0IGhBpL/wkHVEU9/7K+6pc/DCPMl7axF1h1rOgc6mR0rCDRev9JZ7rHQcfTKC3SVZeJQORjrUIOJ5f8GkklvR9KvaZWwJtWHykOr2AopfpNPUiVETKiOpVM8J4zhy4jVe9yarC4dDd50yda7vDX8PXei2gdKuNr5X+xpxSef3HVAxZxVfNA/oOF/0WyFQ2UNGvD7I1vfQkDq0yV0H4wAoLRYAwbcrJAylbaE+V1CLpKQDIDSs89aF16/ERjJP6hIU
Received: from tresc054937.tre-sc.gov.br ([2804:c:204:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902ce8e00b001d7252fef6bsm762956plg.299.2024.02.12.13.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 13:34:56 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 12 Feb 2024 18:34:33 -0300
Subject: [PATCH net-next] net: dsa: realtek: fix digital interface select
 macro for EXT0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-realtek-fix_ext0-v1-1-f3d2536d191a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOiOymUC/x2MUQqDQAwFryL5NrBGqaVXKSKhPtvQspbdpQiLd
 zf0c3jzplJGMmS6NZUSfpZtiw5d29DjpfEJtsWZJMgQpBNO0E/Bm1fbZ+wl8DUMqr2MouOF/PZ
 N8O2fvFNE4egaTcdxAi9GubJsAAAA
To: Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1468; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=MEChIYkvQHqxWqS/fjWdPqFHkAIj3ZLNWN4rsNfct7g=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBlyo7znpm3TMVYV+rMp8H5VWOfgNuidW22MQpAi
 ZRKysK4idqJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZcqO8wAKCRC7Edu60Qc7
 Vru+B/4gjK3xAOWMDgfjdQGY0I6pSnDf1ElWlwq2ppFwBs1+++JCKGj6gpyH4hXwWqU5+klLR/U
 rlUyz8sRFrcCbk2TZx+fMsZMlTpwZrTE/5rH1neV38lV+XuNs0SWYZBPLmvGw8IfhB51P48pHCG
 CMDBn7o2HLUAP5PUSah4BgVfQua9zvaCDrlec7RwG/Uy1+91/VwzBhxB1Ee8devv8HiD8iJNEHu
 XEn36Sr4KCo5nz/M166byb+wH9XiN52HrWibnN+jEoZ5kN4qyJL2DSAD1czp1RhE0lAwsvMp0xL
 KAhwlav3K8aQOI3AssJJaaoRHTCWZuluJ9PXlt+FsU0CBaTq
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

While no supported devices currently utilize EXT0, the register reserves
the bits for an EXT0. EXT0 is utilized by devices from the generation
prior to rtl8365mb, such as those supported by the driver library
rtl8367b.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index be56373e9473..12665a8a3412 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -209,10 +209,10 @@
 #define RTL8365MB_EXT_PORT_MODE_100FX		13
 
 /* External interface mode configuration registers 0~1 */
-#define RTL8365MB_DIGITAL_INTERFACE_SELECT_REG0		0x1305 /* EXT1 */
+#define RTL8365MB_DIGITAL_INTERFACE_SELECT_REG0		0x1305 /* EXT0,EXT1 */
 #define RTL8365MB_DIGITAL_INTERFACE_SELECT_REG1		0x13C3 /* EXT2 */
 #define RTL8365MB_DIGITAL_INTERFACE_SELECT_REG(_extint) \
-		((_extint) == 1 ? RTL8365MB_DIGITAL_INTERFACE_SELECT_REG0 : \
+		((_extint) <= 1 ? RTL8365MB_DIGITAL_INTERFACE_SELECT_REG0 : \
 		 (_extint) == 2 ? RTL8365MB_DIGITAL_INTERFACE_SELECT_REG1 : \
 		 0x0)
 #define   RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_MASK(_extint) \

---
base-commit: 0f37666d87d2dea42ec21776c3d562b7cbd71612
change-id: 20240212-realtek-fix_ext0-804aa3272a76

Best regards,
-- 
Luiz Angelo Daros de Luca <luizluca@gmail.com>


