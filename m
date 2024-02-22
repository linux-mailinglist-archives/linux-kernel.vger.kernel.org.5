Return-Path: <linux-kernel+bounces-77380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52387860492
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF00281CA7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5DA73F3B;
	Thu, 22 Feb 2024 21:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRb8hjAy"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E284B73F0C;
	Thu, 22 Feb 2024 21:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708636420; cv=none; b=iMqVjRxu3sAk4VZpAItMugIauz48TnfC909Eiz9frdVKuidw27RAEj2ZECrNCDULbWVOoDa9zBqQU9mlBjRxrMcJO9FsP9JU0xxpcXnuibTDvqB16e8t18Gi7sMWNomQX53b+8qx500G7G+Z1V/gRzEwCXesErsewdzar5LRb+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708636420; c=relaxed/simple;
	bh=Li5hH27ilVbcU3qbz8ZCBO4YJFaeFf6V6/fGppbkPrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ScqtsL61s8OczKnONTqj5VArUOq2ZrcrOcVT+tov/6q8Th+ZQHTyA+vIP6FITpCGgsBZQ6mtC3pjrzOHSOHz6sjHETU+FcLW1hJLZ0WHC7pWfGl5xkIVyublCTN2xKiJsRHWwb9gEmf/VYQ/+fINZXHbjd5CCtaQ4svhWVCorxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRb8hjAy; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5655c7dd3b1so581402a12.0;
        Thu, 22 Feb 2024 13:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708636417; x=1709241217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/5e9mSee9zp+N/Xd7G2seNRIz/9lLuVdPxZW9PfymvM=;
        b=cRb8hjAygHsH6O0qa1PBErzKEFAfipjZmeLvZUTTDUntIk8QEfWxcwpwDIHmGH881D
         9OlfAYnNAGn7JnS2mRVZzAcX5UOQpqMMdf62ofZiEpCa+kzpCqIP8UY23AunvIkIHNYV
         StnG1+JVqUm11rKMVReULMWT7MEaMLDOLQGZwrDTWkmbCP5wW9ch2vgygpjWwmvWH86U
         Q+BQdcQ/XNeFsQWCDnBh9O+E4tqqVcZQXy/ImsrNy/j8t4XZAWXp6Mo2Vhe59U8QOJb2
         s3XSiZTGTiOK6yN9qlIwPDw+72w0YG+W10EBkbiUfUntimhh6xhdvNL3LpBnn1FvRkDR
         zMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708636417; x=1709241217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/5e9mSee9zp+N/Xd7G2seNRIz/9lLuVdPxZW9PfymvM=;
        b=agLm+w1iln+Lo+ONwq/vTjgiUJ6eFMFUVW8d0/1sIs0n53BT7Z8ANWdypQ6xwOoUWa
         HDWxSXexBvJVpx4iraR6Ao9ihJp6rloYtnkQc9e6TmoGu3Euub4mAuc5pwT977qvXR+1
         tx7obOzQiBzu7DkQx/zf4XsD/oAEWft86f22AD0sKSAtkOJgXPfwsiaHLNnKOzYqLyzm
         Fdb3vXtRkbuJFu2ly6ZQNCrOSjt8Rg/2rRTcgw/pnl5ZiJ/+TkDlyHwmg0+QkhL4HmCz
         beP+Moezd7JMHwRToYj7POyXlngnpXsSXSyuyDCa2ZHFtSit3+t2YDRP0Z05Ji6+mAo+
         KZfA==
X-Forwarded-Encrypted: i=1; AJvYcCULjD1aP1zWzMckRURDpROWWZF/05ssYS5h/DXBl+IPwcbh6VvOwzFS2V4lUyN0Rq3uPSClboSybkM3n2OfNZdcrW8wG8qE4o8c9y4Q
X-Gm-Message-State: AOJu0Yyn7RWBGtOHXeg+r7Tw0VlwproBql2I10eJvgdbdy8Y4EajYS9J
	IX2wkd+3pSTYiZcKtH6ZCFv0M76NtcAGKSbgKUWy/w0begsBeZUg
X-Google-Smtp-Source: AGHT+IG0jh84FYHk+aZL0x57TxmRZpwDqGQQiksxzRLN1vbtmHOFCvwJbrTfxHU99FJpkCDCLDaaDQ==
X-Received: by 2002:a17:906:3b0b:b0:a3e:7f80:ecac with SMTP id g11-20020a1709063b0b00b00a3e7f80ecacmr3213548ejf.12.1708636416937;
        Thu, 22 Feb 2024 13:13:36 -0800 (PST)
Received: from localhost.localdomain (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id xh8-20020a170906da8800b00a3d8a76a92esm6341468ejb.175.2024.02.22.13.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 13:13:36 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	wens@csie.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	andre.przywara@arm.com
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: allwinner: h616: Add Orange Pi Zero 2W to Makefile
Date: Thu, 22 Feb 2024 22:13:26 +0100
Message-ID: <20240222211326.114955-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Orange Pi Zero 2W dts file is not included in Makefile. Fix this.

Fixes: c505ee1eae18 ("arm64: dts: allwinner: h616: add Orange Pi Zero 2W support")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm64/boot/dts/allwinner/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 91d505b385de..1f1f8d865d0e 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -42,5 +42,6 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-cb1-manta.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-pi.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h618-orangepi-zero2w.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h618-orangepi-zero3.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h618-transpeed-8k618-t.dtb
-- 
2.43.2


