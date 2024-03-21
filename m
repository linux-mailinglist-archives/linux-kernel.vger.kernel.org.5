Return-Path: <linux-kernel+bounces-110568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 209128860B5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACEF81F22D86
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A05B134CD2;
	Thu, 21 Mar 2024 18:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBmRbaNC"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93F2134428;
	Thu, 21 Mar 2024 18:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711046642; cv=none; b=R3EYTxwjVOXImbcFcHFgoKnxtIDHbor0onPZY4D6kZ0lNzAyS0eyFVUPDHDbbIeLGiSbFQKq7eilt/xBHnoBohtIVfIIlQ4xoHks6vn/Li1SrOMYbGRmivF6bBh5BMmgiuaSgtSUlS8RBzoPLypOOSMUQWkX8h6DpxWFMCDIRVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711046642; c=relaxed/simple;
	bh=WtXVHWYckALrs2tiGdx+CdxFz78VsyEPGAXNNvu5zss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bAZy6dQFoimPBVNGbHpS0qK7Nf9UCEFmNTWAKeaL7Db79jp4diUhbMPtQnusA2Tv1Ob4iazjpIghWzvhKBJw2A9phKv1DVZdRz978Dvv3v1npvgg0brpV1M8SS5lrS4a1BGgcBoAwormKM1XVsFOLW05elWOlqL0AIq0vgMlbMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBmRbaNC; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56ba6c83805so1635768a12.0;
        Thu, 21 Mar 2024 11:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711046639; x=1711651439; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hjH3xWAVxcLksXCnS4n7afqAXMFnAXHbQLt/fzJwwaQ=;
        b=VBmRbaNCFTYVkIk+dp5ufI2h8x2nlFr7RkZdQyzar7nE5Z0t8MsPvTW1E2f59eGI+I
         eGFd/PLzDRLKKM7LoJrLzW91PJMHAzO+OmvO8T9rxx7+1pJYKoM8YftGRZ7Ijb6M1IUY
         qqJTMhhler6qRZRTahY72WhcJExwfZc1VUgXkFPMGA9C3wFvmobfACidq9+BIck1GHq1
         PKtv7lIhTy0VlKhzOUDFUx8rluD+DyHn3wM0qegXUZFtIRT4Qh9KkyU4S2PEbWER+gyc
         57tQuCYVhX3e8xK43wUaAbRbk3kpB2uJQaJ8hWmeiyqhIVo+EPFCiri1zRwcuUGjYJCT
         IUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711046639; x=1711651439;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjH3xWAVxcLksXCnS4n7afqAXMFnAXHbQLt/fzJwwaQ=;
        b=b79abzZB2oTlOuLQSqa1rXpqqWNCmsc5zZB1am0Im570z7eQ0/2dxJI7z4m6u74EjT
         0lgcV2eTu4Xu1nGCWciD0EKkth8z9pva6cmcshKOU8dcFuni4xemotTbXVzkd51USn4n
         65sgqBmWTsrNqlFTOCkpyJpOH27OXSlT7pArr1JC6w9yXYng7Lx8xcyVZhqU6rxM+IoD
         5k48Y5yxEFUtoOCxNWVNYN/quOsvTcKrQaZjsCOjECNqNclCLIuUfbkYbSnh+g61sgAF
         T1SK5B56eLMIkB4lSwwdSX8HF48aU+QmNmb/RhwrUXv4NJgcc6vEUHE9LZKG8JUpbD/W
         I5lQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0tp3tdsrOoA92p7kNP+XoMbpbyK4Y7v0yFFB4gz/RZQpXpgjgHCISxv+8fY+K8yjxFL19aP7+mMnTWJNXwS3VucUgqQo08KiLi2QZLBMn56c/+SEVCmJ9d7JaoT+TwxYHpll+5x9O7A==
X-Gm-Message-State: AOJu0YxG6WLNr68bK8ZvP1USVfFQ9E6S9zs7Y20s0UFTu5LX2TX7yn1p
	l0eODLsluRfBUnu+aFG39b/URv1Q48W0F9eeY5zKYK4tlpREYnh8
X-Google-Smtp-Source: AGHT+IEyc+V2rYgEcWFTuNuI3kDNAkEe3lfiXa14/sba7m/sCsfv0r/xLVN623itYwLZeUtC/K826w==
X-Received: by 2002:a17:906:1387:b0:a46:c8e2:40f6 with SMTP id f7-20020a170906138700b00a46c8e240f6mr197265ejc.1.1711046639107;
        Thu, 21 Mar 2024 11:43:59 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-7db2-5855-2c59-b89b.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:7db2:5855:2c59:b89b])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090616c600b00a4576dd5a8csm188627ejd.201.2024.03.21.11.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 11:43:58 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 21 Mar 2024 19:43:44 +0100
Subject: [PATCH 3/5] dt-bindings: hwmon: pwm-fan: drop text file
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-hwmon_dtschema-v1-3-96c3810c3930@gmail.com>
References: <20240321-hwmon_dtschema-v1-0-96c3810c3930@gmail.com>
In-Reply-To: <20240321-hwmon_dtschema-v1-0-96c3810c3930@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711046632; l=541;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=WtXVHWYckALrs2tiGdx+CdxFz78VsyEPGAXNNvu5zss=;
 b=bQuEUQ397vzy8Jfx9LXE1DLb9HcUz0E9hVk1DYfWLzvdIqRa7kwMM7XS2iVsuxw1M9Jk1I4A/
 cv3JecbM8T4CRJR4jtV7jJtpUQW1Gt2GFqpZ8rXg2nQ+VqWzFO01uJK
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This binding was converted to dtschema a year ago.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/devicetree/bindings/hwmon/pwm-fan.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
deleted file mode 100644
index 48886f0ce415..000000000000
--- a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
+++ /dev/null
@@ -1 +0,0 @@
-This file has moved to pwm-fan.yaml.

-- 
2.40.1


