Return-Path: <linux-kernel+bounces-51251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5C784884F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 20:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B81528358F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33D560260;
	Sat,  3 Feb 2024 19:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="B3kb/poq"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9C85FF0C;
	Sat,  3 Feb 2024 19:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706986908; cv=none; b=jUxHWxbZXn09iTEHdNro0p4p6RKaOWHTj8fldcONBn4q9dWtKb838UOc2JP/mtV95G2BlukHC5wSX6HKIE8e43Xp5isATKzlhJzSeV6/sQXnb3IH4WE6stzMfV6bsMqo0wFXtZ7l6FuLvZRHdlXM0SXlHffpB8kpVLzLeOBCRd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706986908; c=relaxed/simple;
	bh=dOwfgYrXlo3IrjMLgIsGne9qeQQBcyEQjRcsdVLCyrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ireEnqRyk5osuwHha8rLIjUVplEbBSq6jLLinuRh90IGihyEbcWyGVcb1Duzxmf5mEEAfCHq5iH2KOfgEz1kGaDuHI/9L0t7mfKB+ptbXwfmu7r81Fv7CLXMdFZ0b6fDmKMGMsHhkKUop3fk1C7MtBizMARDqvZb769mDv0aqIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=B3kb/poq reason="key not found in DNS"; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso2810889a12.2;
        Sat, 03 Feb 2024 11:01:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706986906; x=1707591706;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c2AKOQevl1N41k8ApLr55V7zjjXXyZJ48XGNeR/AbJI=;
        b=IHREbeEiFg3iGxbYnSnWIZKRtksHduuXTEs0EtEW/bsBG3+3jqPavwmqpqO3ZEw11G
         3T8nqeMgmmDonKowD+LO6XIdNP3x87/dJ2rNCN5DMiQv5op/xJWeKaFqfL4DDFyJkPp8
         E3pZit6NE7K5sFNuHAKfIPtXa28WwvxGzOAmYTPffQxQKUTuBIPjqPZpAJsD7KvIakvO
         qvsE8kW2/LJrVVCblpt6X3kGUlbe92m5h8IYMHXYEPk1N28BMs4AbGc8CrgUNCB9tg8Y
         SZfeHO4NiGd3ZobxwFmK1ocxHRoFCdPcsib9Re2Z493+DggfH7uQ9LqDGTkGsoSutmz2
         fYXQ==
X-Gm-Message-State: AOJu0Yw1EfO2q0z6gp4JOqbKgGaeL2XCpukmbQGkXAegrLBX7D+guvyY
	pZmg6yCocBRd9DvfiMVUf2rnyLeKVbWDwFrKh9AiVqrF8DG9Bax6Y84iBdJ8P4Zraw==
X-Google-Smtp-Source: AGHT+IGRsFizWhrfa6tYCUiZYap4bWzd5PtwBZxo1w7XxlU1rSX9NnpUiGa1I01ASdV+JS6a1oZS1g==
X-Received: by 2002:a05:6a20:da85:b0:19e:4f07:16c3 with SMTP id iy5-20020a056a20da8500b0019e4f0716c3mr5577424pzb.55.1706986905706;
        Sat, 03 Feb 2024 11:01:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXiOwMms3e9V79IHHasbUvJ06jh4gyGSRMmaLdHFFKj28w8oYDUG5vVJP2tm3561n+/ESejTyCqvKRwpdrXhNq3rfPkx6cPK7Eh3NHSD+MwarZ68sRaunr32/6Zk+ur/oOFN20oUAA1FQ==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id m13-20020a63ed4d000000b005cf9e59477esm4019381pgk.26.2024.02.03.11.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 11:01:45 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706986904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c2AKOQevl1N41k8ApLr55V7zjjXXyZJ48XGNeR/AbJI=;
	b=B3kb/poqQ70RbLlKrHlakpVMzjB9a4PWoQGNJnw/4d9WsW+jkRr//Hy6KpXkykt7DH9Fu3
	zr9BSs3qn19FeATyTV7is81LUBhCSd2d6HQ4uKRSOBQ8BEsL/H3y8Rf639+gCmllMSQiPD
	pWYQJyDJZv/KirDyxIu43gUqiQDBVuWZfC1OD6eav75pwAhWxyaZjVm2lzuaJcFrXjolZ8
	vKKwPpzPPhbboeRX0pW8FaZ5sfC5WgDutnp/tESc2AyjNR/SkuoA0J+VX6WSFaWHt6dcJ8
	liEPZHXAmmaXy6PSqCkETQ62NAtayUaaymQ3VUWG8uoUGTE/895fJ5pquMbRTw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 03 Feb 2024 16:02:01 -0300
Subject: [PATCH 2/3] mmc: core: make mmc_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-bus_cleanup-mmc-v1-2-ad054dce8dc3@marliere.net>
References: <20240203-bus_cleanup-mmc-v1-0-ad054dce8dc3@marliere.net>
In-Reply-To: <20240203-bus_cleanup-mmc-v1-0-ad054dce8dc3@marliere.net>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=965; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=dOwfgYrXlo3IrjMLgIsGne9qeQQBcyEQjRcsdVLCyrI=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlvo2tHfHV+1WceALNXrC7ivuDQe0IBg0maM2NO
 HsHG9wdjrWJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb6NrQAKCRDJC4p8Y4ZY
 pm9dEACx4/TS04/hpykZN2HZS3gYXGvHARBv6e0kiTs9w2jw70Lmg+CIG8oCkJ54cbV8fmc2TzV
 6F+TKsUqwvqODmi9a/Mq/60MmWEa6ZoxrUFckbASvSdPUzWjq6+itaYmq5+GRvJ/4bhgCaSZDGi
 viTw1RHNBb6g6/j/OB0N73uxxosjL/9ewr9Ms25W/JezL0AeVwcFo1Y/zvSd1zkwXvdmHUrBav6
 aYirR8Aw0LQwT3xxHh9FEl0HCJ+EXVG0WJ8kyYat+HWc1D06VlbDctEl0ejkffKdjnToUac99/0
 9dPRgMxn/yPhcmE09PSxpZ5fX5YLT9fpqzvsz9UjcBh/OzuejrO2ove9hBrtFS6KPJyA0604yd3
 NqCT427hcZrRAzXwm5KejopnWqICs6HZCzJHr4kiSrGGhFD1pH6qfL+Tds52o9qzmcWpbhatDPf
 BA152rsjTY5it36HEKk5xD1ZEXxUtsGeqJyfHHLqyFW3GztNpv6kFKMJHZbBNL4XguS+ogDfYkv
 YDQGpaRHfed7cRp+IndAFR/NCBprFUH162fIXDIfxHuGhYDSwptXVUpmMjU0gPhlpENbNMqpnyJ
 F7N/BWAmhAVZ2xnJWcjSOgxTfexf0i1zGcVtzBAq0YoquvcEpN7CSAyPeWkREC2Y6fu/0aXNgF4
 XPnROoa3+82GVMQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the mmc_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/mmc/core/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 0af96548e7da..48daeafdff7a 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -214,7 +214,7 @@ static const struct dev_pm_ops mmc_bus_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(mmc_bus_suspend, mmc_bus_resume)
 };
 
-static struct bus_type mmc_bus_type = {
+static const struct bus_type mmc_bus_type = {
 	.name		= "mmc",
 	.dev_groups	= mmc_dev_groups,
 	.uevent		= mmc_bus_uevent,

-- 
2.43.0


