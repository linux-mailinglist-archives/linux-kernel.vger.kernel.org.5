Return-Path: <linux-kernel+bounces-48726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DD384604F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9AA1F2368C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFFA84052;
	Thu,  1 Feb 2024 18:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlW1DUX5"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2E812FB26;
	Thu,  1 Feb 2024 18:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706813357; cv=none; b=nZM8pMq1Q9FpAgadKezXZKuGP7RvxlePK8ANBe9UOARPbxn6AVn6eFSzeFN3OoQgfMGVhtCo/wQ6C89iUDip8G/cnY3pxi/zVb0qovWbKoYde7KodkUn6pDGLNiiutpzW4fKemqNkoeFDd3heC2+GuvFItLmsYIxOqpjMr7gznk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706813357; c=relaxed/simple;
	bh=oSTzOFlxbkYeKTE1fBaJJNw0JiRbh4c461BYCNvcpLk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Vi+76ipBCgclYYtnlYVTfQx5jSARnHWHpKRnZ6BCDCO8ZiJM/KHZRwwJseIaHWXi/f1vJwYFi26yX77XTllnRe9jcAuzvPxdt3RwzwAlpiCxu8ub/uLMZOS36LzbL2ejeE2iOvEq+1+2uHiJgZ0UNXC3d7zryJD7XvMEhe2H9mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlW1DUX5; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a271a28aeb4so194010966b.2;
        Thu, 01 Feb 2024 10:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706813354; x=1707418154; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UZ2BNxl4CuX+CwL0Q0MM0vOQQgkTfsFjivCQCX+8Vok=;
        b=FlW1DUX5xEv7nV7Hv+8rVwSQXam7xHC/374gwnY2vk7zTnIGV5lSobcEL/oc4S+72J
         QYisv8FAREqYRjUr7KwY/OBw2yZxUfdgA0dAERGdAl4qV8iEF0gl6McBTOySWsjC3IOx
         xtL3rPj+Ibz9o/jd827xk1Gioru3lZ+DX/t78ZPkn05BuIMM4gmznkNb7Ms+ybbOMj3Q
         +XOrwnuxNEBswc8Tv4BcOLaoo0RipBD0dbOe/uGUm6ZEVB+oeBTkgWjmufHVejI3WbAX
         DTclcc53LQRYiO5Ft6oc+pVbWpNo8OWOXNOgm11R5J0CruzgOYmP90VepZfq+L56cUOU
         DQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706813354; x=1707418154;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZ2BNxl4CuX+CwL0Q0MM0vOQQgkTfsFjivCQCX+8Vok=;
        b=if94eD9euof9ByoJaOHvrD2Gdumt0nUMeDsfnk2L8rekKKfe1UhRPwN635xCWGKQ+f
         Jm8jN0d/0s9hudo/7lenAQRVxye8wQp6PdsG5Trlt4wi4vA6O1R2wZl4kOcGSranV+9+
         DHGzHa7JYKVt7HadyYm5Jy/zSRxv7gnf2hdoOfs9TY8UrpjvwDaY+v149Sai8/l9qceO
         e6k3Lu2cGQOiYu0o2i4zOcJeGMCaYDmtcnFmK78nZErcSrBJ1dqqP0IwQgBYLOZQQlnX
         d/7E6uZRewpp+rMJr2tKUGOhsu/ds/T1goEIzrRBcL1+Bb3Vlmg2+FudeklFmlbQIpj4
         ISxA==
X-Gm-Message-State: AOJu0YyoIoT7T2WPCQJZBcljn4mKRYfqHCXftmqVu+4waufxAf03Pupk
	wchPQsr6m734MukdGanP/N2Re8BVywpI/1Eykf+E/TE5xIpmt0oCAiUcroid
X-Google-Smtp-Source: AGHT+IGGA5qp6wn5ZIQiyD78CL7wjsdqPIfXb8OZBkRJqlut4YHxc8hMsIAnp6J7GpIY62bc0rilfQ==
X-Received: by 2002:a17:907:762d:b0:a36:c478:32c9 with SMTP id jy13-20020a170907762d00b00a36c47832c9mr7913ejc.1.1706813354086;
        Thu, 01 Feb 2024 10:49:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVU8v/SCLnQ7LZSb0w8mkEB9nouppO33QaZIRTkg63zkKfHvnUwR8byyA/ehU4WvIaOSLEfS1AnQtY6pDN12rc/YClKddtWhr0a2epLmZakvpUTr8th0VXyE8tQPJhTSLJwwHPcq9GfP6AvjsMFvrjtHSn6jHT3eL+Au5mtYYypiUEDHzsdwqNJG1hIkKcmDEZivoxQ9O9F3ghxR7jpcMFuXy2IW/+54zZJE3UcVwgFqqVbdYBg0hKZQL/CnheCZZ8ODDbsFBdPcJIJkC1+hjTDNsYFt/wtwblJYfHQXXm8O8K81vy2QX6TLgMcmEVmuKKIqlDDcGDqBn8LF9P8jRq8dCTvtfbY6EB5iX83RMThRTig2I94hY18VgJiepPAjsJCu+XCnHWDwOmxMEb9H9p3Ug==
Received: from localhost (p200300e41f147f00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f14:7f00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id cx3-20020a170907168300b00a2cd74b743csm66021ejd.3.2024.02.01.10.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 10:49:13 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH net-next 0/3] net: stmmac: Allow driver-specific AXI
 configuration
Date: Thu, 01 Feb 2024 19:49:04 +0100
Message-Id: <20240201-stmmac-axi-config-v1-0-822e97b2d26e@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKDnu2UC/x3MQQqDMBBG4avIrB2IoSLtVcTFEP/oLBxLEiQg3
 r2hy2/x3k0ZSZHp092UcGnW0xqGvqOwi21gXZvJO/9y3g2cy3FIYKnK4bSoG08TxI2QN2Kk1n0
 Totb/cyZDYUMttDzPD6w5IFptAAAA
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2274; i=treding@nvidia.com;
 h=from:subject:message-id; bh=oSTzOFlxbkYeKTE1fBaJJNw0JiRbh4c461BYCNvcpLk=;
 b=owEBbQKS/ZANAwAIAd0jrNd/PrOhAcsmYgBlu+eouMKBqCqjqHbOEFVUq9JEBc1aaNZ6eBX7v
 soopTeA7ouJAjMEAAEIAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCZbvnqAAKCRDdI6zXfz6z
 oSBMEACd6S+LvgVemvFHdK75JLJpTPtGcLDSQ/7Sk7hUBygC0TW7403tq5t6684qywgS1lXxtrW
 09j9R37CCZMvHlpp1RFdsRRu76P3Wu6B1EQPjupoitMRebpFjpD20jaAkCExwgzLyWEvwutf7y5
 pn6TvLXwgXUk5bhkgh7C7p0OaXdDMp9HMf/N8/2dKkbzZZ6T+5NMt3GE3fcduTnMgM6xDxnhXGS
 8bXvnYLCeeIvGeKcduRK7rcWxZrfqgymErDIM93ILeo2F+md46+NTjFFixPMABrrN/Z49GzvjCd
 3Vieksc4XFJDeXbkP6v39Cd4UHGGxiXXjYJsJ1rcjJIbnW0hp5A9BXp9vrQ3b/EhUcVLR+i9H//
 bXpj5hyCNGJHvMPVaqfo2Aiij8cw3t3AeEr+HTcmpy43I6FG9ROI+WGB6uSW2Rp/CFmveRHoYg6
 cffusiQC8Hft6ykZO6/s+4bJ8OHIiQ7kXXlUWGjFqLKQ1mRZdY++Xr7LTbioY2Itgljf8GOgdfj
 MzKTeKR5JKpxg8wQkdhNdn80oL97L/bfRzXP3Ta63b3Gl4VP/c3VUXK1p2KVIvudI1b3t2Ybend
 2jrqodVYP/HxW3DMfPb4/jNEOifckKicPANmsn6EsCXNHpTgAEm4XBCUJ9HY6OWTbCRJCW5rJK3
 Dj/WUeGdQSOFhCA==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

AXI bus configuration can, in most cases, be derived from the compatible
string, so instead of relying exclusively on device tree for the AXI bus
configuration, create a method for device drivers to pass along a known-
good configuration.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Thierry Reding (3):
      net: stmmac: Pass resources to DT parsing code
      net: stmmac: Allow drivers to provide a default AXI configuration
      net: stmmac: Configure AXI on Tegra234 MGBE

 .../net/ethernet/stmicro/stmmac/dwmac-anarion.c    |  2 +-
 .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-generic.c    |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c    |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-ingenic.c    |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-intel-plat.c |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-ipq806x.c    |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-loongson1.c  |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c    |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c  |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    |  2 +-
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-starfive.c   |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c    |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c  |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c  | 11 +++-
 .../net/ethernet/stmicro/stmmac/dwmac-visconti.c   |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  2 +
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 66 ++++++++++++++--------
 .../net/ethernet/stmicro/stmmac/stmmac_platform.h  |  3 +-
 25 files changed, 77 insertions(+), 47 deletions(-)
---
base-commit: 51b70ff55ed88edd19b080a524063446bcc34b62
change-id: 20240201-stmmac-axi-config-77ea05ea9eff

Best regards,
-- 
Thierry Reding <treding@nvidia.com>


