Return-Path: <linux-kernel+bounces-74427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6DC85D3EE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A3F285894
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E095D3E48F;
	Wed, 21 Feb 2024 09:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXpsx3I8"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFA73DB9B;
	Wed, 21 Feb 2024 09:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508498; cv=none; b=SB2ZbJ6EQgknmPd/1uOmpHN8EUa4SCupQDDk0Mm+q2bNtQyUO7+vQZgfBK0GQl45Qp3ky/gyVokeojo+5FbMYB1fawPUWDqVF5GiVeBY4G9/plQ9nRS8YLDU2UVFt/sQiAhp4pX5NHm4N3TjOZW9bbYjz/BgLVUU+/P0UbWTu0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508498; c=relaxed/simple;
	bh=CebN2e7M+eUIq88kq6SwDH4xYTCQZktEekF7C3lknbI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HS1Tf6iUVWv76iXgRhQTD/j2EaLfzrlTAu+hvfIjP0tIY58QyGWrbK4axnU1MBoxAEBHTUr9CKhVCmRmveAW7LdllXquRWFaqcP2LvbBHpdK6Sc5S9sp2h3Wnom5C/Acag7br+YIAW2v5c/nRye1Rw8vGx4tL3PlW00P7uTWqRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXpsx3I8; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-58e256505f7so4384917eaf.3;
        Wed, 21 Feb 2024 01:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708508496; x=1709113296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHfABZko5E3OyVpk0Pm7Tx9/GwQM3X5Y0l7yapoWLPM=;
        b=WXpsx3I8BDmu+V5yk+QP48j1joRXj6dVsyyjaR761oeyTzXIViTLIPA5ez+6Uv6qJM
         +ZSYNTZ08L/tDBHEfvdcV6qVAzxS3mm33Vu7tgjMHau6hYKD7xCnb5EfhqDOaYjOnj81
         N/M5Y4sN7kGUxFQ6gZRmJyrPiIimWvIfnzcq8Le1lXt669wOh9GiJO96UOJfPotfoNmP
         2HXQTjDYhHeccY20vT4ZPuZxNA1+Ynhi/s+Gs82ZLsO8beK0wLPKnErscOYvYamVzWEf
         dVve62vE9HwBOt/lhN4pp2EFsKpxWlYB13d3wIdQcRt1/ZUh45DbdZHbFl+RjKMe7GbC
         4gXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708508496; x=1709113296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHfABZko5E3OyVpk0Pm7Tx9/GwQM3X5Y0l7yapoWLPM=;
        b=RTnqj42ous7mzFhXc36XTdbbjW3VuowF6GeWZocScBAoN3roUlH0gTQTWSXlL8Vget
         6GbVIcVFI3YaZmgjrYj8bippgRZzKJ+/dfAOpHdgfsQd1TczzeC73sb/Qr23Y2vkdbjN
         Md2T2zuOS3YZTL7dbTcwqWdig5t28T2IoDDNJrVGtDO8T7fxI21KZh54wnLOYLsanTMw
         DzaTr4uLICylfL/wkj/ruzXkko5fI/OnncO55KRVdQXJTcI7ffFk8pfDwRHVl8wEvXf+
         auCvnDe3sIj/Cc4peKC0mj2v5UuQvTNaJL4+wg5epTUY7b7AEuYSOAxNISfmXkb97uQx
         xWCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM1lfULmcksxUiu7Xzy/phUBARbis6UrohukVcwgCi2aa24Vt8EZb9pkAqtCYpsMHFvKdHWBDq58Q364rz7P5m1+1YtbiCDQKAiJy8AsmBmT55osVMvY1/1y/jHWPhwkeOVN1a7ijgBw==
X-Gm-Message-State: AOJu0Yw8ijPgsVCZ8MhZFpFFJSMesEBYtPbyljqpEc+GlTMQa/hk1uBJ
	yxlUJX1/PbYPFtgOC/rimsbuG0mhbFiXZv2sVuMBm1AA+1I0j1Jc
X-Google-Smtp-Source: AGHT+IFCQpC7HA3uB9PkY85VfIE/i8aLJXqvVLcWyjyHXYTxBgCMVh8/XMWAAqAOity415LLFgCe+w==
X-Received: by 2002:a05:6358:d090:b0:179:272e:54e9 with SMTP id jc16-20020a056358d09000b00179272e54e9mr17337350rwb.30.1708508495826;
        Wed, 21 Feb 2024 01:41:35 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id lm4-20020a056a003c8400b006e488553f09sm1645026pfb.81.2024.02.21.01.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 01:41:35 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/9] ARM: dts: aspeed: Harma: Remove Vuart
Date: Wed, 21 Feb 2024 17:39:18 +0800
Message-Id: <20240221093925.2393604-4-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240221093925.2393604-1-peteryin.openbmc@gmail.com>
References: <20240221093925.2393604-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove vuart to avoid port conflict with uart2

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index a0056d633eb1..5d692e9f541e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -100,10 +100,6 @@ &uart_routing {
 	status = "okay";
 };
 
-&vuart1 {
-	status = "okay";
-};
-
 &wdt1 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.25.1


