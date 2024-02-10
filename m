Return-Path: <linux-kernel+bounces-60169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE30C8500FB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F305A1C25EF0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8DF442D;
	Sat, 10 Feb 2024 00:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="ZPpCzVbg"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6D53D64
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 00:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707523643; cv=none; b=l6b5/P1XdXl90Gm6yPQrnX2mNDImstiwTTIea0DGQo8lybXhok7IldQBV2cBsEqMmJdf3xr4f125Cg+TMA1aXBztdfRIDIBb+jwEDgPSPVqQ5npSaYnB9pd98Y3h5OzHIewWpL4z5EC4F7ymmfNB1llwJzxRDhv1PhgGDdhjo+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707523643; c=relaxed/simple;
	bh=C8aIrz+YvO9fxNUkdAMJJ6XdrDgygMKYTt1snLgv0Dc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=omq5Awum+wlbiRlbi2U5kbAX+yfm68yN/opIKZ/RYyS1nYwrdPRQToCbW38I7ISG43aVAaOcoXTNuhrL74ugXQiJizeuOK0X9wNAiahIFAeT04J6Qv9DL6CZVbjYLP2AVn9VHkFv72uVY0hodNZNAWw4gUXVqmRhyFtL8+k38Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=ZPpCzVbg; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e05d958b61so1311581b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 16:07:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707523641; x=1708128441;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gK8p55xLirSUiR9q0E6ZCWh0WNCH7QbqUfIi685HA9U=;
        b=TwFUYu4GXLLXI0JDqxN9aoswzP+CuHcoJREooA4lZ8o8YWlTO054M2ZTip+pPXSfvj
         fWQwtgxGKYhqcbXGdzUNAeklJCmZf8VTnvHlDSLDTus7ZKLKdrCjvU+zvTwo9s1VCldv
         4UYzNmyR8gYXkWPTUApeTC+ZaBVqFnUEht+GzWEUvXe3CbDvtxWhWItk8tY43LorMcqy
         N+Hw0gFcDQvl4HGnvSMpswVM+BDtSbOi3F+HZgG9HEB4d3DvH8kdRoNc8k6rbw2dB24c
         liCkVhyBmQvhGIBhP6cWYplB9es5aW78boeY3zXMYDZArv1xpfiJUEtOuqC7E3hANE4W
         iu8Q==
X-Gm-Message-State: AOJu0Yyz510Bs37tRP6RsaMZKQK1Xgg1d5e3KHDm3DFocnfpXQklkU58
	MeDVBQjUtDqV5CYTVcS7hHFJGDWjLyLvURdM7YwYav4OrtZZVrGsJB7zSUFDe7aRUg==
X-Google-Smtp-Source: AGHT+IHlqpZ453+HYvKc7vTrYs9euHZKY1I2GewR4Z0mRWnxSbHz6Fi0SyDivhnecXA2mqvFXzAVWw==
X-Received: by 2002:a05:6a21:150c:b0:19c:9418:c396 with SMTP id nq12-20020a056a21150c00b0019c9418c396mr961326pzb.31.1707523640772;
        Fri, 09 Feb 2024 16:07:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXT2cTs43LdujFWL6c11U73A539Zg6VkGsvBctFbXDLZzfwJdCYU3Hiv9HalRFxOOXcSoi94nmmGdZb2A1Wj8QvDM5Yvy0zB8Ah4ao0deJbAmtdu61d/PXq9918SqX9OcXrOBa9euAx0BqFrXbrI/v9pV1HN5HjB4N/LaAayBHu6ETnJBt8B+ncFWBiaoxlQNkL9Z4nKwDnA3sFiT8Bu764diZkRffyRjUZdNZ19hM3odfct+oNbAgWW06hM2O6/DLcyU3O7e2VbrcwEbbK
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id a21-20020a056a000c9500b006e04d2be954sm1122559pfv.187.2024.02.09.16.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 16:07:20 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707523639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gK8p55xLirSUiR9q0E6ZCWh0WNCH7QbqUfIi685HA9U=;
	b=ZPpCzVbgGPtTuUzaBJWtuREqazdtp3QIB9vxKhmlqz4zTeFjuVnWAA8MgdhxEIvPwkWA8M
	yxM1kSS3sQQRiH6ccmFGlJAbT4idxl9R37VbEP7QjwHLBdW16k9EJNpf4Lsds9+omnPUoE
	6ZQJdC5stkRuKIZIetmetYKVxMrUO1QzyCVdHaOoLWOfULIgCU4CLKYIoidRUu99XX92/A
	cthvOW83u6jNZ3hY6jiWvzoLV2IpDB0+5JCcA4yy/4G49QcOHDauRb6GJ+4EEIMUMp5mvL
	RL8qUK1qm6+1NxmNVyT3GxDwTQeZ0Fnsa5SUJZCCWdI10NX/ho67hQUELW/yOw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Fri, 09 Feb 2024 21:07:18 -0300
Subject: [PATCH 3/4] powerpc: mpic: make mpic_subsys const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-bus_cleanup-powerpc2-v1-3-79a56dcaebb1@marliere.net>
References: <20240209-bus_cleanup-powerpc2-v1-0-79a56dcaebb1@marliere.net>
In-Reply-To: <20240209-bus_cleanup-powerpc2-v1-0-79a56dcaebb1@marliere.net>
To: Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1274; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=C8aIrz+YvO9fxNUkdAMJJ6XdrDgygMKYTt1snLgv0Dc=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlxr5Qw58cZ0qxku2hEjuwHGuU1ag5fHQtMwTpT
 OS3oV8gY0KJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZca+UAAKCRDJC4p8Y4ZY
 pqw4D/4ygjnvtA1sA5sgpgxrx9xkcv8vPXJEwYvNRCRDsx+zbW/PVVLWFKDlzh3Ft3xVEC7AOvE
 xjLSCd4Osep+KglDuHCMP3yDmrJQV9Res5X//TvtRO6FRpjO7H51NWYya4MspHcwC9W0ikFJAKj
 J2e0co9QS+rjoX1KFzLjEGA6WiIX8agt9zLCinLvRAprxwlLloEbtEUQKQpOFCpTXT11iS2tT9Q
 bx5V2Av0QdnLRwZ78cR13QOS0UG/53T4qnoblYQdJS3Fqsv0Ksy2dpWVy6aq7QAgGEAkHX9N/uK
 dWcEf7NFL/PElZs99AMBJfPZpkovEbCfuWZ2Rh7tUXQ41Xhrz9Rir/lqF5/1hPFUYLkkas8B9fn
 WinMANMuPVf2/DwNCFh5WwHWtHsLQtkMT0UFTwcp8EMyFSxs0y3mNNUyUtWNWl3YFNCSbi3cHwu
 x98xuIk7Dm0GzjV0oW/4pFF24hpGlwzgUwapa4VG6BAVP7lr5ssy5tklIv5Zc/7CyzkPCqRykvT
 HIY6SaSe4wNr83HTcbnw83IKa+241seYhpgt63kCyDfxGGkYFb4AMHfH6TPE74rOS3IazoTW0Sp
 DE4f25LDyeAnddhowKzBUo/4o0eGczEpbsRU+9uV62s/PuOiHkL0W5QKNK0H3NfPUtVH3HSO2jp
 4GgA0aRoAv0QiVQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the mpic_subsys variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 arch/powerpc/include/asm/mpic.h | 2 +-
 arch/powerpc/sysdev/mpic.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
index 58353c5bd3fb..0c03a98986cd 100644
--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -336,7 +336,7 @@ struct mpic
 #endif
 };
 
-extern struct bus_type mpic_subsys;
+extern const struct bus_type mpic_subsys;
 
 /*
  * MPIC flags (passed to mpic_alloc)
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index dabbdd356664..d94cf36b0f65 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -49,7 +49,7 @@
 #define DBG(fmt...)
 #endif
 
-struct bus_type mpic_subsys = {
+const struct bus_type mpic_subsys = {
 	.name = "mpic",
 	.dev_name = "mpic",
 };

-- 
2.43.0


