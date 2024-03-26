Return-Path: <linux-kernel+bounces-118811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EB088BF9E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447B72E5A30
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B1429A0;
	Tue, 26 Mar 2024 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgFGEDUI"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F954689;
	Tue, 26 Mar 2024 10:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711449361; cv=none; b=AVYXTw9T6FWI0EwXBNPH6LNv7imi4iQa7pqjVfexkkFfAU7KWPxzaYJOX5S+PzJ+tVFHqIADT+gC3Bdbo7RX4lfp1jck4eMnLRyKGXn6R0WBa2pXjkxxVhSb56j9Tzc4RbSjEnv+eE1JieDshyRPVIO4JVXMlcNXvfpjYhxUnzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711449361; c=relaxed/simple;
	bh=1SwHJQZ5aSVj5ZoQuGLDpQfrCYhnferKKbFhXT0gWYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=knRPHelQe2gp9n2UdZtpCo9sMR/lpDllxIoDu6CW+k1mmpPAhqBs5rhVIgmgEo2KZ5+vFx7qRHslEHb14i8SesDg1/Ec7wPHhlSsq5UJI1PWO1FEqN+Ikj1df4nyOD8XJ7r+tADwZbS5qwKn84fWUUIq+ZRo6zKaX6uAxkEcVDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgFGEDUI; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-221e6bf537dso3294946fac.1;
        Tue, 26 Mar 2024 03:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711449359; x=1712054159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KUoPhAxP6OeKuxAApMMPObFZdH2Lwn2Oh9PCqeapu+Q=;
        b=MgFGEDUIS93POoqzEuh5Ui/LXuY83QHA2Fwoy1APbuFOvJhkhfIsgjZIUEu2XdlgXr
         H5AWBsOLMkLuSSTWZGoCistWyCE9MEsdr/kszHfkdMoQsQTwiJVKONeoR6iMhioYrBIz
         koPzKxsDzHUHDoR+kd+kwqklSSTnomz8MquVfeJuDDbXY2o57xLZde6BVKD8DXVfTsWl
         md+b+cGq35cZirhisBEQqX911Hqzi9JSdhO3hbJRhfRlysqACaFh/yOiSg0ppbvUPQux
         wv6lZ7mEoNHCtTM2upX/H8X7JJB8zsmITk0RcOVI7UQXXWiIyQ/cM5vwvtUbGLxj4O6F
         7NSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711449359; x=1712054159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUoPhAxP6OeKuxAApMMPObFZdH2Lwn2Oh9PCqeapu+Q=;
        b=MlO8AXMi2rdKyEIuiTVaj8lDxNzquGFxx1ASnCKJd1WeTr+1ztTjeK2IpA0CzTk4cp
         z+kUbyuj/f0OG+vZk6I5aUsmnuKHidIFBP3yQG+1j7pXdA7voPtVVk4yJfMVPw9Sm3QT
         r0WqJ7i6jB+YhDK4veFP+IuXABRQaGx/lPm1M2Q7gVUjwSkN5UeMK/1IN9WtW6uzA9ow
         WpIWSxGTkaFgYD1T+GbB3DSAKwOa9HYkA4TaArxKbLjXorYAU0R251b0sT+KlkEl3SJW
         5IhO5BminsInaSbMUSRNygfnwf+LulObz1eVTdngHE8mfeJP8a1bKsCxe6pVOuUTaqoi
         a07A==
X-Forwarded-Encrypted: i=1; AJvYcCUc/1qP3LL34UoTP9e4SR+6bZ/kmmJtzkTRAc7XpMU4oGgS1zE2pTWU3o3EkCEPC3ptEn4QvBg5izxStjhM6db+F8RHwKLjUYzutfHyRP85J3hhJGil0Sbo15qpR/4J2Vu2fniGNzq+Sw==
X-Gm-Message-State: AOJu0YwEr6wI1Pf1R4oEKXSe2MEHrdu2vznvAFCwpHCHfD/ikUaNPWRx
	ubnEeI6H0VB2nHocq2CSpHNvbzkHW/NETQpCcMTpXDdONIfG4gXp
X-Google-Smtp-Source: AGHT+IF+/TyU7QvcPL8z/7aJOBNyEi3udPsi6Rr+EqdIy/sG3yo5Md4hoQBCnmPbzBoKuu7bDmTNUQ==
X-Received: by 2002:a05:6870:2252:b0:222:4bde:fede with SMTP id j18-20020a056870225200b002224bdefedemr976511oaf.13.1711449359138;
        Tue, 26 Mar 2024 03:35:59 -0700 (PDT)
Received: from localhost.localdomain (125-229-150-10.hinet-ip.hinet.net. [125.229.150.10])
        by smtp.gmail.com with ESMTPSA id g14-20020a62f94e000000b006ea90941b22sm5554215pfm.40.2024.03.26.03.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 03:35:58 -0700 (PDT)
From: Kelly Hung <ppighouse@gmail.com>
X-Google-Original-From: Kelly Hung <Kelly_Hung@asus.com>
To: robh+dt@kernel.org
Cc: krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	kelly_hung@asus.com,
	Allenyy_Hsu@asus.com,
	Kelly Hung <Kelly_Hung@asus.com>
Subject: [PATCH v6 0/2] Add Reviewed-by and Acked-by tags
Date: Tue, 26 Mar 2024 18:35:47 +0800
Message-Id: <20240326103549.2413515-1-Kelly_Hung@asus.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are no changes to the Patch file, just the reviewed and acked tags are added.
PATCH v5 has been merged into the next branch.

Kelly Hung (2):
  dt-bindings: arm: aspeed: add ASUS X4TF board
  ARM: dts: aspeed: x4tf: Add dts for asus x4tf project

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts  | 581 ++++++++++++++++++
 3 files changed, 583 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts

-- 
2.25.1


