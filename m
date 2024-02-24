Return-Path: <linux-kernel+bounces-79600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B748F8624A1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88621C2199C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A2329431;
	Sat, 24 Feb 2024 11:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hQwcKeu2"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839332575E
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 11:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708775050; cv=none; b=WOhxfKMPiGG0iF9Qr+LdslibxhYAACcf5ESz4Zbjnk6lCuiCb9ogMJwwlyL7g83d9pCHVGSEa8aOPeH3B4DMxEqLuQMsvVD81yJT+L4Rml0TwQJavxf85t027SHqY3dHicWXP05LYiHkrEArPshAU4iq+jiTOuwVy460ITeebIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708775050; c=relaxed/simple;
	bh=t3ACokIKTtFaTzunPNxu62YMtHm1IfT62kjY7EfURM0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OBIxiOXGyQAacBeSIDbTAh4Gc2GnVGnNG/jJFRIkVCn7yGlhXtS0vQExy2/YpNwPUvA3bLnqtUq1C6QG9jiytx1QppwjwVU2lBhJjhQHDfj33CwYfyufwM7Y3Adpf3uYF9Wo1LF8q8nBNwHH/ceP/aNteWYJtktkQfuthFU2oi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hQwcKeu2; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3f5808b0dfso228104666b.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 03:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708775047; x=1709379847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LZCvM3GWKg+RUPBOVf6H7FD4oRp31oVvkvoA9vNY9R4=;
        b=hQwcKeu2JF3nmmmEJsYGMPcyFJyHPOE75CPp/NzRJKo2bBw78czcJpNjddARKn709t
         qfTlnaB//N5q/3jE26o5pd8XnQQttXmdeDNFxinNv671BHMRAwUkC4meymQPxfcvjHnG
         2skPuWfNXitHnozVDeEhQvhhTnWN32E0kzOtcvBr19zMZkP18OBHRtPOmikqgI3+1+EU
         B2H9lOFuylK3fRF0yHNLVqIyD4BTlYwc36VIuxhXPxJMjI4hup+R4IMDqf6IvlUIAGlE
         AMrCL81I5f5vdQy3HcwOXskPxhJq7PNy9IkNPki+hcpKvTAi1j3x/8kPm6OxZcCd0/tk
         S1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708775047; x=1709379847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZCvM3GWKg+RUPBOVf6H7FD4oRp31oVvkvoA9vNY9R4=;
        b=l9xgwUlN1e6dWM1pXpkq7h7yZCEWZeuRo7yQAVLrOJULiT0vl9fU8RvwiDb6QvjLnm
         0vNk7lK4HPAw1xP8Ny5YA2ylucC1kXM4r2Jse5ayEbM3vuDzYPDktvXiJsd8pPG7YX2T
         CeUvqQguDWbKI1Cx5l1/ovvfKJi8jiDclqTbNRRyob08lzQtMaBhlM3trVb7CMenoRm7
         bkzaCNwc97FJqpwfssgT7dpCLUfMBWDLvzXfmO71VXjh3APJVauX2i2ADHoFSEeIKmqS
         l11Mq9TxQei84vrhaSyXFk9BHyI0VO3YJQbgSi+wU/sJFdMfat91OzvoEsTTeZJX/M1y
         //lQ==
X-Gm-Message-State: AOJu0Yys86MFQRk08BVPzxT5plDsdmmX2AsT3NlTlHj3i+NBf3Ut1qWv
	GYZAM0E2PxUCH+YmqJ1LHNhxb40iI0Z2XbSeKkkwag/q77VXgzNi2+t8GYj4BOE=
X-Google-Smtp-Source: AGHT+IGrMegWrWWwVjlRGsWuL9Xt0Xy7fWXqN4xZvKpEcZCggq+qyLHycmw9JgLjQnLi28hN9ZTf9g==
X-Received: by 2002:a17:906:408b:b0:a3f:c38c:afa2 with SMTP id u11-20020a170906408b00b00a3fc38cafa2mr1506720ejj.21.1708775046787;
        Sat, 24 Feb 2024 03:44:06 -0800 (PST)
Received: from localhost.localdomain (82-132-212-111.dab.02.net. [82.132.212.111])
        by smtp.gmail.com with ESMTPSA id y16-20020a1709060a9000b00a3fc12516aasm510734ejf.217.2024.02.24.03.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 03:44:06 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] slimbus: patches for v6.9
Date: Sat, 24 Feb 2024 11:44:01 +0000
Message-Id: <20240224114403.86230-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=516; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=0VrqqxA9oYFZrNZMKpgoydKqpU0VkdV0riAmzXyIKhk=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBl2daDm/8Fp0Lc9e0LIcNtb5WZQ3BsnC2HXDVf7 ftGD40WOBCJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZdnWgwAKCRB6of1ZxzRV N4RqCACSJimZOITbHyqAw73haBYI3uTF/VZt6aZyDKKU1aB0GiN3doEVwWnqCUz6YjKJLekXrRH cJgZTJZfU6gBs9XvrSEFGOCOej+FiOwUB+BkrNsZ1sIR3kjCEfYNn55Q+nvRN3I2XJEJjIANa/2 w2uJT8MaVJIieq5TzmGpkPhHH4iv4B8a1AkuLoMreptczYvV1T3G51pyCxXJxcET1E2Dt1tDmU6 UeqNB49nmwehOAvrpBKl204EmCiEUIA0D4/YV7czzFo0kYQvF3VrQLPNr521MZXUdE87IZ02GQb xuMrFVVTAw6hpFot+nvv5K3TQ8UspPl75rt7H76A3u0khkLW
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Here are two patches in fastrpc for 6.9 that includes
- making the slimbus and qmi structs const.

Can you please queue them up for 6.9.

Thanks,
Srini


Jeff Johnson (1):
  slimbus: qcom-ngd-ctrl: Make QMI message rules const

Ricardo B. Marliere (1):
  slimbus: core: make slimbus_bus const

 drivers/slimbus/core.c          | 2 +-
 drivers/slimbus/qcom-ngd-ctrl.c | 8 ++++----
 include/linux/slimbus.h         | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.25.1


