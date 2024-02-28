Return-Path: <linux-kernel+bounces-84937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 543D086ADEE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F7E1F2358A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F5573510;
	Wed, 28 Feb 2024 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHWvbFN0"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C39E73503;
	Wed, 28 Feb 2024 11:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709120512; cv=none; b=DdX1oHMz8SX60YSlPQsxXSbWe1HkJOTsWMlrbvt55pfaIO3ukbuiHkxsNQMclG/Q4/PxEbxXZjXLEblIYCDXP1EN1lFbnKAnrjBoOfIvTbbGNwwE6A2WLFcnuCmWJ4NAdvygupGTIHr4ej1xqIKyu4urwGmRspUZrfr+U6BGqII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709120512; c=relaxed/simple;
	bh=dsE7T7ejNZclEhWu3veU2fF5ccoj2EE2IlDwDI/vwM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T1LhesUSNfB+vDK0pQgLZbGWoba3aEno/w1wwffCwjNlbjxsvt7HVjL9HAUyz9wzCsOZlf1iJgeCwRMyz6QH+OXgULIj58a9I8ByCknE7IsZY1YMpqWOZVdwR2QJnPWr5nC0D20JYdD74PGGRKuqq17SXCyoWdlr+Mdnp8SQLvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHWvbFN0; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-365be6563cbso585545ab.0;
        Wed, 28 Feb 2024 03:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709120509; x=1709725309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WCRPDq43vyBVqTjbpT8Jvj/oHj2cwLRKueKi4UzZsFA=;
        b=lHWvbFN0MEsmb+e/VQR7f3qD+yHbQ2q0BrLo0QGW056mTxdhhi4mOh0sRXFmBw3II2
         U7AoFFmiYCHj46AC/17n5nnsSNGupo4w0BhQfluDdjyUl0XXwzrSOZxDTX+CGXc/Ga1/
         N+cfgTM4pJjr2ws0IAkJyehNnCcoqBAbVFluFXJE7PjB/MTDfp8w1PwDaAGyz93cho1b
         xL423/9pcrXAiCB8BZuAr6J2ZV3fS4SpFhHS9/1u0zcXDGtf6tfYnYPQCrsH8165wQnc
         df7An5A+TQ0deRQyTkUdZlT/q/MNRI8fuCPKk7gKL1AulZ5YwQ3RsVBmjwWqIZ2a9RS+
         iGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709120509; x=1709725309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WCRPDq43vyBVqTjbpT8Jvj/oHj2cwLRKueKi4UzZsFA=;
        b=jyVfMFn2xvMq1QJQNfqxYs5rraiOvg8AWfPZ5o0kaHYmhXVO9OXzCyisAKyQB6vazB
         4LiN0cgKjboOBJe2Novz88XRI4UB34z/0B01wiH/1XbhmAJ9G7XKC+bzoIap6rHuUGXn
         5hwfUfYz0/wj8KdXvjcdKKO2x2cRsE8lkRvktFgEc1drRhk96Q12gupdp4ma5KK+F3+g
         eBKGbbYW0Xpqwpli42uYsF3VO4gniJHc3CeO/HzdDU87Te3mWuFBmP6kBhPlNKJvKGKi
         oAGFamvcUtY8w94AL622DZhivBNJBMPKUftutu2P9hB7rck44B9dHWTKoPw+0PtZ6X2m
         B39g==
X-Forwarded-Encrypted: i=1; AJvYcCWXk4N14n+8weSuYpiBl6Awe7fWzSZL6kLYbXYfC/Dqa/l4bQ7I5A4EH10pUduZcwyOs/D0GKh8hrAP0LtLbg3pVzGwQL18+YsK9pr2
X-Gm-Message-State: AOJu0YyE8xEFg/72ClmL8Hcw/qArwpShA+G0ptHhymPfT8v0lalGJAet
	x4GLARQ/u8hwIH0tQEwuvT9U4s0Ht27/Xy1T7zjOqg4z7EOEmtfPjrJeBm42bSLXzQow
X-Google-Smtp-Source: AGHT+IFN1dBUkmGMTpj7ucVaqBDd8wbgDdggJZdOnfFLRJ2KvP2psSeQ7cUsqhenzq8xKT5aWMj6PQ==
X-Received: by 2002:a92:d28b:0:b0:365:2429:f60b with SMTP id p11-20020a92d28b000000b003652429f60bmr12830902ilp.18.1709120509426;
        Wed, 28 Feb 2024 03:41:49 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:abe6:89f4:1061:8343])
        by smtp.gmail.com with ESMTPSA id bu33-20020a056e02352100b00365bd7f608esm139533ilb.40.2024.02.28.03.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 03:41:49 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-input@vger.kernel.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: ili210x:  Allow IRQ to share GPIO
Date: Wed, 28 Feb 2024 05:41:42 -0600
Message-ID: <20240228114142.43803-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IRQ registration currently assumes that the GPIO is
dedicated to it, but that may not necessarily be the case.
If the board has another device sharing the IRQ, it won't be
registered and the touch detect fails.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
index 31ffdc2a93f3..ebad20f451bd 100644
--- a/drivers/input/touchscreen/ili210x.c
+++ b/drivers/input/touchscreen/ili210x.c
@@ -1003,7 +1003,7 @@ static int ili210x_i2c_probe(struct i2c_client *client)
 	}
 
 	error = devm_request_threaded_irq(dev, client->irq, NULL, ili210x_irq,
-					  IRQF_ONESHOT, client->name, priv);
+					  IRQF_ONESHOT | IRQF_SHARED, client->name, priv);
 	if (error) {
 		dev_err(dev, "Unable to request touchscreen IRQ, err: %d\n",
 			error);
-- 
2.43.0


