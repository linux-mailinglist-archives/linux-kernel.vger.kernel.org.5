Return-Path: <linux-kernel+bounces-65880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5180855333
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A86E1F25522
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1007A13DBA3;
	Wed, 14 Feb 2024 19:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="ExxGDG4H"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C682613DB88;
	Wed, 14 Feb 2024 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707938884; cv=none; b=J5fPF6p/e6rtkiTKxTi95wlHqZ98Tw2v4JqD56qdDLfT2qBQ0KdiTVjbcqqgVgGzYgjGjTsXSe+AeHGU8fqP5MkVqtG8ojpdokX5BjprCe9JpX+5XoZ2IDff7ssjqKpxKRq8dlN2jTTRENNkdtQv6Gk0MUVFAtkmqposZ5c4lzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707938884; c=relaxed/simple;
	bh=krKW6FufyrqnEsJjvhkOclRGG5wwZHLlEbv96z5uKcQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z6dulQ9bdFwaNHFKK0xpM20/ysheqKp5ga5RBYluvOP4JxCcwkEp7jzbh9inB3I+CGhYqfzAw+3dThpxf0BAKHf3FQIupZYb1DPldrkogCu7fMwoH2bBx21Sg473SoJnixpVUVaCb3d6h2B36fioM+MbfLbsJ4voAHkggT+0dqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=ExxGDG4H; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d9b2400910so1152285ad.0;
        Wed, 14 Feb 2024 11:28:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707938882; x=1708543682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SW2EVXlkBr3rgXstlJZO0zqxkNTOtfGuPtYbWFp/giM=;
        b=jzId0Czz46pt0AtXWzTekXEQG+3sbmn1DWYr/k3hZalTC4W9iOHJ+A+sMLZlw/jGfZ
         xzKGnKvj4qF6EpPs+HakMfUMjMS8H+lfLBoREiXnuxp1mdBUBbB/1FgjXzS5924L3gpT
         F+jIRQPgvxz0o8NjaLyjGHPfPupix+Ab7nxluJ3z8kaNJkX6P9NmGacIqONGcnpNMkD4
         pHRnlMGSdLhLEY7pr0ob00FSeyoSi5lcs6SwPOT3lfOG+lTIwvcEfs8ze9sLKUlN0O7C
         nyrHhhJSDB1XrjOg9adIdpjAL97DYJXAlY3nCVMGMZ3lCuS0TpqGZ3XGhN4VL0JAPxiz
         tUzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRwrzJVkQRk6bpzcBbg4JqbEQ4QBMMMOHXRlujnd/DnSRh+dp7BfMBU+d4kJIhql1/HwiQiB7dFGjFFnMJu6npOul3bJGZbq993ZtgUs56C7Tm/XQ8DPyopjpVbwfY+3+KTpAXhmmh67A=
X-Gm-Message-State: AOJu0Yxtfs09o5E11DgWoBG4ZH4iSctzgbO5nf3raTArc6x2CatCUeDn
	HhBjQ15PXYbBT7xlzgvxa+BmT9k9l3hOvcwMVyBpZB3auTaLfM5h
X-Google-Smtp-Source: AGHT+IFfGbZuAKSoIipQ/AuSt4XRcAoPLUj2tmOBYt6LOxRikAJhgLvwB5Ih9ElCDzXfq8dY46oA7g==
X-Received: by 2002:a17:903:32c6:b0:1d9:adc9:2962 with SMTP id i6-20020a17090332c600b001d9adc92962mr4216641plr.20.1707938882014;
        Wed, 14 Feb 2024 11:28:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVNr2uJ9kjnrGCOQC9BNLwWgg0FTNhR81r3mhUOmcxEJOT46yMDQ2YE9PySMXH9JejYyLfBYad23Xt/qtP4pPO7VaCiW5o6cRBaLbImdxN8Ea1NBJL/n/vkMXS+JbXWFt4TGJQbxO8QSVNbOlI0qMyY8fs9rdBzMpEusKyCRENQa2meTvVnw65ziaJRTjSACAWZOqJbCLVARgAiekH+t3uAQ08tn0XAp8sd9nu7H5VACcHMwU9UDTqQnBR4BeAtg5VErA==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id kk11-20020a170903070b00b001d8a93fa5b1sm2269628plb.131.2024.02.14.11.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 11:28:01 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707938880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SW2EVXlkBr3rgXstlJZO0zqxkNTOtfGuPtYbWFp/giM=;
	b=ExxGDG4HkIj1oisfc/xBYlb83uf+EJVkHyY++SDgkc95zRxC5dMn62sB0ubUZ9MmGZ//Ve
	lIF/ReQzCklcu8k5GEkXFg8Et4Oyf8JMeuqB3qJDimH9K+Zjzb6y6TWjvbbln2aQLXkSjo
	9a82NqA3wef3FOOC/DioCZN13IuEG+DQcl1aHqC1Dmh7BSbeVJz39Nk8PBDTUEXX0elzk2
	BLpIxKjaxPDeaMxBSmX++g6iWbO5mf0bDTZYMrw76JUkqShALd/iWaiRQpGN2KqbN3moMP
	Z+jYdDVMOGEbXWEo/bmczCW9woQefjvDnjsUueUdWw9Z0HF0Br0IUu23wasUig==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Wed, 14 Feb 2024 16:28:29 -0300
Subject: [PATCH 2/2] ALSA: seq: make snd_seq_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-bus_cleanup-alsa-v1-2-8fedbb4afa94@marliere.net>
References: <20240214-bus_cleanup-alsa-v1-0-8fedbb4afa94@marliere.net>
In-Reply-To: <20240214-bus_cleanup-alsa-v1-0-8fedbb4afa94@marliere.net>
To: Johannes Berg <johannes@sipsolutions.net>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1035; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=krKW6FufyrqnEsJjvhkOclRGG5wwZHLlEbv96z5uKcQ=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlzRRhl5Veu7uhBrVI+1uU+rR4q9IbJhifdb9TU
 N+d17t0QdmJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZc0UYQAKCRDJC4p8Y4ZY
 pua5EACuVYFKzDW/TNKVRiEKvBIwgkmSnbmvzLYBd//6zcN/EAmhfhvISk2n9yBPuubxPSZaaxn
 RqRssHLBSRa1iXhKOvZXLcO6w4JAvMSpsQItJWa1JjBhBbiCyGvFqjzT1nMR7UIJ9ygrJxm5sin
 BpR/KI9reM1gxTPJwDCt3TubQKaaH8CkcX9uMDP2bchSDnQ5209TEhdocOZ3NReMxnm2ry5Szce
 0x63cr2s6aAKiETtlrjTDMYIIcjFmH7ZSArvFGGcjxijIDBfb2sj3yxF9e2xKBL9RyDBY5xS3rW
 B7JHq6CngM/y0FV8xzlF7Dt7SoW5eEZKVFQBdMwRwQFfjA+5hc1eVSHXCyKVYM02dKvYUtKw1Z9
 xf2JfFQicxO2BJlDyGq0XUj3yNxEo0TXIeWjCKsDLOWD/cLS6LsSlZuUkwPFbyZrxQmfuTrwAWu
 44agkqrnN0TkX8NggIw2mYTOULjDWAFuRups2m4TfBhd+G/Rf3KqRoJzKfqb8XETovkNlHCt/GP
 nouPP+s1xHBga6enpHkwe1geOAkFmtvCPkLM7ZEnGSLRiE/neQExxHJJ9+ZRK4fclXGpADPv2b/
 +LFqX9LvwU2qa5tcINF5yMW6AEOFCheXlE/15rHjKff8s5MkkAz4ZI8mMsDDFoRTTNPuz18gIn9
 IyMwkxY0ce06jZQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit d492cc2573a0 ("driver core: device.h: make struct
bus_type a const *"), the driver core can properly handle constant
struct bus_type, move the snd_seq_bus_type variable to be a constant
structure as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 sound/core/seq_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/seq_device.c b/sound/core/seq_device.c
index 7f3fd8eb016f..654d620d0199 100644
--- a/sound/core/seq_device.c
+++ b/sound/core/seq_device.c
@@ -49,7 +49,7 @@ static int snd_seq_bus_match(struct device *dev, struct device_driver *drv)
 		sdrv->argsize == sdev->argsize;
 }
 
-static struct bus_type snd_seq_bus_type = {
+static const struct bus_type snd_seq_bus_type = {
 	.name = "snd_seq",
 	.match = snd_seq_bus_match,
 };

-- 
2.43.0


