Return-Path: <linux-kernel+bounces-17520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D40824ECC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3524284F0D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 06:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3340979D1;
	Fri,  5 Jan 2024 06:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHwDU5yd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167D61D68C;
	Fri,  5 Jan 2024 06:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a27cd5850d6so132984966b.1;
        Thu, 04 Jan 2024 22:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704437594; x=1705042394; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BFOGLpcjoXzhR6JSGe3noB3vFxJi6+WAnSOC6t0PX4w=;
        b=eHwDU5ydKKSCreOe067V/Fw+AJGfyBStMcopS7b4LIiNqHmcJ0mQs05958cGSxcAlD
         guwFnbKVsRHD6xvbJ0BVIZbO+owZKtDXoB+GD1qQu+RrpbTQ6U5uxKxqgd1s9G8lIXEI
         10IiauIO5p3iM1qrZr4+7g4rW+VQLvvL6qA5Hp6TJjCAsOJubtDTwTFLIjarXK/zcSbX
         nMnZpGqzKFRwb+1hDhrI7DZGdaFUAZ+5AJGdslkPzCDg0h+JjkaKB92HOVDLUnS3+/+q
         db0d13P+NIg3paI6MTSGlX/s1MoTkUMsiBwwMxcoSOH8uF1QH081hmX9fAl/Gbr1UYvo
         tOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704437594; x=1705042394;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BFOGLpcjoXzhR6JSGe3noB3vFxJi6+WAnSOC6t0PX4w=;
        b=kpYy6/KPrrPzTDgjEHg58MOAmG3d0pn0KZRjHdcZCRqhIZsHo+p+vI+vqed7h2ey1M
         lXqddTxP2vaKi98ImShVYdg/YAMlI4yq2wJXRzCu9P1SZ9c8XsGLDcc77CfA9fYfA81x
         oaxdIycv8cZULvLs/C7cFJuAp24Fz+H14yvwVsk+p+620W+nDmFNPWGUb+qoRNnM/FJX
         5odQ0OGjcSdFug6iRze6ji/OvB1WGVShx3yR+LlD/pptiHMJgLuO/MJpvZL6m2/3JOF6
         bnJr6aOJudfUubqBqN2IiDtOQgL329or02Ct4nDZ2ebRGzbFxAMfo3dDTU0fJs/+mfst
         bk6Q==
X-Gm-Message-State: AOJu0YwS095od0ImVW5JjIlBqcHxsBlB25kxaSy7iCkJ6i/QvCijC58u
	y9iZuciJS8qsxlVXLC04I+I=
X-Google-Smtp-Source: AGHT+IH/RNoXjBd4MiyX0OLCTI5AmDJmvW3GwmGcu9xsZwFnO7vK/7pdJD2sx5+J69mSkoxXKkB3TQ==
X-Received: by 2002:a17:906:2ac7:b0:a27:b918:5eba with SMTP id m7-20020a1709062ac700b00a27b9185ebamr777907eje.72.1704437594258;
        Thu, 04 Jan 2024 22:53:14 -0800 (PST)
Received: from hex.my.domain (83.11.207.119.ipv4.supernova.orange.pl. [83.11.207.119])
        by smtp.gmail.com with ESMTPSA id g23-20020a17090669d700b00a28e2b72db2sm518809ejs.56.2024.01.04.22.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 22:53:13 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v2 0/2] Fix panel polarity mixup in S6D7AA0 panel driver
 and Galaxy Tab 3 8.0 DTSI
Date: Fri, 05 Jan 2024 07:53:00 +0100
Message-Id: <20240105-tab3-display-fixes-v2-0-904d1207bf6f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEynl2UC/32NQQqDMBBFryKz7pSMtal01XsUFxMTdUCNJBIq4
 t2beoAu3/+8/3eILoiL8Cx2CC5JFD9nKC8FtAPPvUOxmaFUZaVIEa5sbmglLiNv2MnHRdR30p0
 ymokJsrgEdxbZezeZB4mrD9v5keiX/p1LhArr+mG4ssaSNq9+YhmvrZ+gOY7jC6NvFfa0AAAA
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704437592; l=871;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=wxEs5SLA0q7BDvi+NHXyhorcl91KbDNYCzif/6ZAkt4=;
 b=Sc7I1CZY2lJP8MxzHRgpRaD31yeQNY6wZgwzLCYkbJfFTTLBbNIjbqBuuSI+0mGf+1P+f6ndf
 JUdiql2J12/AcfvnW9Sd5sjckGu/Vx11UeAoMAW2xkOnpKIFCqHhJIN
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Two small one-line patches to address a mixup in the Samsung S6D7AA0
panel driver and the Samsung Galaxy Tab 3 8.0 board it was initially
added for.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v2:
- Add "Fixes" tag to both commits.
- Link to v1: https://lore.kernel.org/r/20240101-tab3-display-fixes-v1-0-887ba4dbd16b@gmail.com

---
Artur Weber (2):
      ARM: dts: exynos4212-tab3: add samsung,invert-vclk flag to fimd
      drm/panel: samsung-s6d7aa0: drop DRM_BUS_FLAG_DE_HIGH for lsl080al02

 arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi | 1 +
 drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
---
base-commit: fa4131df22d181c0f721bfc6a68addb8fc62c03d
change-id: 20240101-tab3-display-fixes-6516f0b6a1a1

Best regards,
-- 
Artur Weber <aweber.kernel@gmail.com>


