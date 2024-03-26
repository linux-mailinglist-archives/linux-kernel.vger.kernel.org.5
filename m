Return-Path: <linux-kernel+bounces-118491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 068C488BBBA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C3A1C2BE0B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECDB133400;
	Tue, 26 Mar 2024 07:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZsPZ7K6N"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3EB129E6F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 07:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711439626; cv=none; b=Qdv8QlBuMm7MIUsrRy7tCgQkQqDuIkU8o3bF1d+rZc5/sEUD9jhC2stWc5P3HcDz4E+9SzExkHnI3AL0hjVCokBNB8aGQw0JY2yonYxziAuiK2wCF3q+UZ/gtaQi9TisGXImxguP2fQP1ts5IqsGjR3oILcPU0ZCrMG0f9ZK8IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711439626; c=relaxed/simple;
	bh=PG+YoBzPj5jfZIegUA9uti2/BxJ/n75EgFGMHvLJVZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GuEsokstq/br3jhs/gBIz+TBjhzpjDXfmxC/T1t8MeNTVqE+KWDpP+tR6mxyo+N3x5iK/LXDk4/xKHU3CZ1BNVAl6LDu+nEvJdEJ3ds86EBT6bsGu7lW6Ka8ZhIukqckGXOu0Ew+0IzkhNlYQhq2iq2CTNxvO6va3ZZu6fRJY7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZsPZ7K6N; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d4a901e284so101117341fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 00:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711439623; x=1712044423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gjxwVBnuQ/K20A64Qc+EoBsJsbyKZh+2nwPwG7SD+KY=;
        b=ZsPZ7K6NHbuZO5B/Ym+ns8Gmci1sSdTR/ZC4Fn0cCAWPTZ+HpcBrPRvgpTsySw1fo+
         uDL1ky7TO8ZhYLppBhWDA6eerNtWh7cDV4HWOTI+PC6UM0n4SPedRqbhxzSCKqEWf7ho
         J2AH3eOv1sVA7nK3srekvOe23JeAbtU7R18/lb9dPlaMfYqLV/0ELiLlRjyWrjjy5EUk
         hPunBnaNfQ4hT3tWWCZU+iZxMfXJe668Nx4ThYr/tj4hguWv3pY16xDQjpOAltdmBVbi
         lffINbHoFsii9TsavzbAobW2japg9PKgevSSrudqTQ32md142mexzba5sF42d3Di5tCk
         9bBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711439623; x=1712044423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gjxwVBnuQ/K20A64Qc+EoBsJsbyKZh+2nwPwG7SD+KY=;
        b=lmcZzI2sg1Yr32GmY1muIU2E54SeSeCnus5CskOiJp4NEeniTnFOdgEl+FggVqySBM
         a0128yKoeVRIjEIrv6XsJjEsd2fmZ0vbXTkI/obF3MrMOXPTRf4FFbbuvoCwas8WWjgY
         Pfw+eqOvHcfhzaut7eSeWQAZcFf4W3SPSpqqHOAoGEJl1Epeoj+bMH4gt6aM1mgi+YQB
         SEL0yEvebv924EMH0qj0vCDHdmU1zREJzIwCq571CjHOEnCHC3iG88MrYOO4LZsLnA95
         e79wasaTJQ4fZWB3/TdhyY3iSIf6FOHY4mnznniAEGsPKD+HGj9Z502fgmCWPWyBDqi2
         4xyw==
X-Forwarded-Encrypted: i=1; AJvYcCUAe7ynFhZKQQYhpvwrKYoQekaA661su9Tv9NXVMpgXmLQoCYn+Edyv2FgqMrB5dNk93A7VRDbzZROLZyMhwzSTmGgyBAUOtZHUSONn
X-Gm-Message-State: AOJu0YwZpI2r2Gy63VcZ61DI4uszlTEaai8SyYKwIwjFf2bNBFomwFUT
	JgsfFSzaCVZmWAVTG+7YXULPXol67x3wPQcolndOzXNReeAUUqpIveJjal5XXyRv+B+x80vIT5H
	y
X-Google-Smtp-Source: AGHT+IG9y5ndJ6oRkEe7UN5reyJscNBQXXw3eD7MyAaFc6udt4nkQT5PJ+koYh/yowbN8nKlKNoutA==
X-Received: by 2002:a2e:b74e:0:b0:2d4:6a34:97bf with SMTP id k14-20020a2eb74e000000b002d46a3497bfmr6608596ljo.49.1711439623083;
        Tue, 26 Mar 2024 00:53:43 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id g17-20020a170906539100b00a4b27cd1c8esm1349034ejo.120.2024.03.26.00.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 00:53:42 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: "Theodore Ts'o" <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] virt: vmgenid: drop redundant .owner
Date: Tue, 26 Mar 2024 08:53:37 +0100
Message-Id: <20240326075337.55377-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core already sets .owner in acpi_bus_register_driver().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/virt/vmgenid.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index b67a28da4702..8f6880c3a87f 100644
--- a/drivers/virt/vmgenid.c
+++ b/drivers/virt/vmgenid.c
@@ -88,7 +88,6 @@ static const struct acpi_device_id vmgenid_ids[] = {
 static struct acpi_driver vmgenid_driver = {
 	.name = "vmgenid",
 	.ids = vmgenid_ids,
-	.owner = THIS_MODULE,
 	.ops = {
 		.add = vmgenid_add,
 		.notify = vmgenid_notify
-- 
2.34.1


