Return-Path: <linux-kernel+bounces-44050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F72841CAE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7BA1F22F93
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FE953805;
	Tue, 30 Jan 2024 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcmEs+dH"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A096450A70;
	Tue, 30 Jan 2024 07:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706600141; cv=none; b=W7TK4fEHDnB/pCZaH2aI/3ScpHF8iHHktOwkV9I+zLfBYtfKwxcYqvqcrV34xmxWUzGcgEn3zmFA2nJR3fjAJNnSqNIDTsI2sCs8FaEIf8aiN0sSiNUeJMinT+7foqhhM2O4Uy4E9Zi/9rcVTtP0gV3qVozVpkXZR2D2184FC5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706600141; c=relaxed/simple;
	bh=2/Aw873mS/QOuUxr2ZroaN2HZUVyp/VGd9nT01Q/P+8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pHEidbhumU/5nkDXOWWz4Fpm/Aq3+IYWPmYsDLjf0MRqq3DmYhVmXwofTPM8gTEdhZSQENbpNJFz8R9r9CZ0T5eWkhgwOL+WSkjZ6EeoQxgH1FMcJT+BVR8sJ67JjOZ2ImuZ65Yt9/WVDObDEM6SwfV9BspmdQvuG8IQljaZpjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcmEs+dH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40ed3101ce3so50033395e9.2;
        Mon, 29 Jan 2024 23:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706600138; x=1707204938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TTqUzOyKBgD15tUKZFCKN9Jxdu54AkjHcxdnWoZg554=;
        b=KcmEs+dH0lIL2WAVmO/h8EOzjstJpROHvKAg01rf0BALFVICeQk422yz27Rv1ccd7g
         zxCXMEkqQS2/l2wen52zJFvLY0mgH6d2lXCdOxWoAvxXDOKArQ+cFg9HoUu1Xs6SsfKg
         lDzIrlIRMoSHw0SOuxxRIuHCIK4EOqcL39dEyVrpUhro9RJYECZ+OdIOjtP2hNLko0V4
         TmOzKO5iyv2DGD6SpbIxJ/Ie5Hr4Im6/Xrbuwpuh4IfEVSjDBxNAAHmvq7jd5ttE15HH
         XZh3GxR06TSoo/UEiwzo9GuVVAkj0RvlWkVecgu6Vlaly+ZX5+Nrli6nfeh4ZDqJmy+3
         jSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706600138; x=1707204938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TTqUzOyKBgD15tUKZFCKN9Jxdu54AkjHcxdnWoZg554=;
        b=PReAuvt4OBIfoKtSUhMt7edP8djzdsdhog5xqN/SJ0tC0pRgkFX3b0FFFOviLWNneI
         cyNujj82IINf1czpABYOlhdq0cE8yGI4fRZQwgN7qylKgm5kPJUoi6qQGhS1/u/uk9VH
         yijHaAPw45fWSRRCJ2ehglF/gS7DWqMg9cFb5+5ENCWff99D98JBr6/mMewucgePoBro
         frpyBtxHdbZHISrNee5aQOzez9uPUuKXIfmoxA1HROAIjxXm7t79/RTQ643vc9c1/gEW
         F8QCPvJYZPNN/4o1WFu94DBEQBIcRX2DitvK9FFtYyPGjNMP3MvanTaIzd1CccDOD3/h
         6CoA==
X-Gm-Message-State: AOJu0YzLD3c9oVczHd+zE3IXzxVljLkdblX08MjJe+11LFfhXbmi/YgU
	/uVUJkED+sT+dBndj5/JVFpl4EcbC+vJAQrTjVN/FCJ9XRZf31hY
X-Google-Smtp-Source: AGHT+IFhUQGSy7+OWJvqQ8x5euHaIzeajkd5zop8vgndzZO8XpM+Pu1PaDxuEJATLwktV26PUMZ/1A==
X-Received: by 2002:a05:600c:314a:b0:40d:8bc2:6059 with SMTP id h10-20020a05600c314a00b0040d8bc26059mr7392928wmo.36.1706600137533;
        Mon, 29 Jan 2024 23:35:37 -0800 (PST)
Received: from eichest-laptop.lan ([2a02:168:af72:0:ff96:97a4:5bcc:1958])
        by smtp.gmail.com with ESMTPSA id i5-20020a05600c354500b0040efb8f7158sm2964828wmq.15.2024.01.29.23.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 23:35:37 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	piyush.mehta@amd.com,
	michal.simek@amd.com
Cc: francesco.dolcini@toradex.com,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH] dt-bindings: usb: microchip,usb5744: Remove peer-hub as requirement
Date: Tue, 30 Jan 2024 08:35:05 +0100
Message-Id: <20240130073505.8916-1-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

The peer-hub is used to model the relationship between the USB 2 and USB
3 hub. However, it is possible to only connect USB 2 without having
USB 3. Therefore, the peer-hub property should not be marked as required.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 Documentation/devicetree/bindings/usb/microchip,usb5744.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
index 6d4cfd943f58..14dbb70b08fa 100644
--- a/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
+++ b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
@@ -71,8 +71,6 @@ allOf:
         i2c-bus: false
     else:
       $ref: /schemas/usb/usb-device.yaml
-      required:
-        - peer-hub
 
 additionalProperties: false
 
-- 
2.40.1


