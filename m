Return-Path: <linux-kernel+bounces-142372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 353968A2AD1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E31A72817EB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CFA52F9E;
	Fri, 12 Apr 2024 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8hPW5Fh"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0EC51C36;
	Fri, 12 Apr 2024 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913492; cv=none; b=TIq+P/zAANVBoY7ImnI0oe54bxCKEjjho4d5xqDKNm51eGMjUnfC1rpog5X7DMf/SQn4fGV3Y1YNvfAmUk6qwFZGwHB/EjNViXS+OlaPCFedb/s7ltiZbNzutRS9JAbCQBXHU4x6g5CHSoPbOE10gi+cJ0RyUlnbtmiftvMrrmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913492; c=relaxed/simple;
	bh=7sp5OIimh+NGxS8fpc5RW5A865+3zGI6jwHVqgoNhRM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sbGeVHFm+n8dA50F5Csj6MuSHvqG6FAzf2vz/F5sUNjxd29sy4mgp4tN5bX+YOVMOOZi/Ietks1J2NiER36afb08JfXgPMapc54PzapjJUhTr+rWUbUexYuZWUXrO9OmJ79heIN0ZxybhWI17JYRmWty2m+g0zzBLGyZpW1k0VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8hPW5Fh; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6eb5511088aso505352a34.2;
        Fri, 12 Apr 2024 02:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712913490; x=1713518290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pegTGAgIl7701EaFNdsQSg89lpjeCGj36MeNrr3t5wk=;
        b=R8hPW5Fhb11xWyfekmkLbN21v5oFMYaaKVZt4Prao3RwfJ1kXiPlUxRVBTNTlyNvwZ
         iSM5Zk+iDCfQGmltcIqxZFFBtdWAqkDIVwwqnmUkrdlLqVSyKZSjzlwC5fx9dCnZhz/r
         6ax0WUN9bLmJpFChDTKuNFSIwJ+xJ7FDEV/YpTH5o1Yn6XZAepJ8KKSDDWRqDkl+oZ3u
         eHk4BPLyoI9Hj/xUQc6psnsQKhE3cfLf6D/6CmFFUdx8ib2oMVMoWaLhupcyP5qksAXe
         IHtNuWyi2u3oMHJ9GkAr79kxZwnE+UaUyp4tchItBqVceKL0+XBynBZQssU1Ch3Enz8W
         pTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712913490; x=1713518290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pegTGAgIl7701EaFNdsQSg89lpjeCGj36MeNrr3t5wk=;
        b=ER3ggp4JffVxtWB3cGhtiLXzpkzQ4vrPuYgUP90Cab3Wgm4yhQXU+qX2yqCif+vYEi
         AhkidhxeMhTXyLaH2xE/Twe594waK61IgDbBOT3meav4/o/poOM85p5Xe/w58f88yA9T
         0pRJzotbGyP0xTTVCs2anAHDv37ojJHVvonNk7yZ89FZo4ZYbU952GJMINrwUDKoAC/G
         jBZqonxHxHDtFk+jNBlCyJPurd4kJ3mUfIqoUv2KBICbLWQHIJoUMDdObPqPLs/8yud5
         8ZdyLvRSrLGJqIekD2B94GYfrh7lD0sC6CdpuufdBsFQlpX1eiay2uHRS8nX3QXKCOUg
         68kA==
X-Forwarded-Encrypted: i=1; AJvYcCVMyZOLjha8POcplxDHMo9sRJrqhTZRhW7fuc+0SPu66RJlCoxXSmQHt+d9nhgv5unT3JHqyH/GDJRQ6KrOux1+dTRtFvGjPPJvcsermjVcwu1CZSFPu4SD5WWfNV/tLuP/hn5tCJUn1Q==
X-Gm-Message-State: AOJu0YyAzWRhRwowFn1XixmjcI3bCeCqjrBw0oko+OSb/Uu1k4GjrWwu
	rHRwUtdiTK5nsusXrpbHvQGKgGprpVVzDMMvy753Z8B/epgNxeo8w39zew==
X-Google-Smtp-Source: AGHT+IER7RY3UI1nL3RyrLJqYDGuT/AjZxE7I8qA+iB98G7L1KTZGLKBBosuNef4zJ3jEkCXu/qDsw==
X-Received: by 2002:a9d:768e:0:b0:6ea:1d30:71fb with SMTP id j14-20020a9d768e000000b006ea1d3071fbmr2030496otl.38.1712913490129;
        Fri, 12 Apr 2024 02:18:10 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id b25-20020a63a119000000b005e840ad9aaesm2332711pgf.30.2024.04.12.02.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 02:18:09 -0700 (PDT)
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
Subject: [PATCH v5 02/12] ARM: dts: aspeed: Harma: mapping ttyS2 to UART4.
Date: Fri, 12 Apr 2024 17:15:50 +0800
Message-Id: <20240412091600.2534693-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240412091600.2534693-1-peteryin.openbmc@gmail.com>
References: <20240412091600.2534693-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change routing to match SOL(Serial Over LAN) settings.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 8a173863ef24..a0056d633eb1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -12,8 +12,8 @@ / {
 
 	aliases {
 		serial0 = &uart1;
-		serial1 = &uart6;
-		serial2 = &uart2;
+		serial1 = &uart2;
+		serial2 = &uart4;
 		serial4 = &uart5;
 
 		i2c20 = &imux20;
-- 
2.25.1


