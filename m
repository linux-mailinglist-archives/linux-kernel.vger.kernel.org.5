Return-Path: <linux-kernel+bounces-157042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B908B0BF7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308BC28875A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C92A15EFC6;
	Wed, 24 Apr 2024 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hzED4HNd"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AEC15ECD5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967563; cv=none; b=bBszgRQOUhMIFLe1TKnSa1UP2cB4xTttlyDsX1yJnM4L/LHpif0Yl/hfXi8fYm4o6Q1FEktFJ3PT3iBVElVt0oi0Cy4OMYrnmRy5tAFeDtJ5m3d3oJLMZ+JGMa+Ukexl/eRXPUYE1MA1AWtlY3/xm8ILtWK0lnebHCc6+G1py2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967563; c=relaxed/simple;
	bh=DD7I2+/OSFAuYPjbxmMle8pdnVsY53Td8fq7KEPM4QQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nm9BIhvWu0YcIwOMmK6lyCWtgxOdHwyPjhvsMTLBCpmFkSuhZr8Bf4ZtTqKWJmS/OcA556f5OJ6STczCPApjSMt/TsHV0VninJnxTlYgl8Uu22NkmBcI1QtKZ+2voifRYDp7Y8/Y3SqQgsFQDlpd+IeeOyKhLeIOnU1HtKWZg8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hzED4HNd; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34a7e47d164so4369323f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713967556; x=1714572356; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LdQ0ElNNjcpbQIpJ1xf2rchBloiiwlw1canEoGrpfWE=;
        b=hzED4HNdRtQ43j1TOJn/SCUtGzmbQ2wcRpxFKKEZJL3fdluHrbE7s2St1n0mZYBprT
         NlBpq4Y8qreXUR9nvWqay2WXP+1h419lQG3MzyM2PWkX8tGayFD8bItl6y9zqYPaPsyq
         pb5Nmihjv7k92XZ5ClmzTbnoMfbeyryHK8MZw0c3vK0ro6IK6Mc0rZg6MZN0pS7+x/8p
         uPZpRVup4RL3S3ksYEsyGXqpNB2RRK9dfvAuFyadnKOK6L+aL2AF94PQngTISu770mHd
         gGAMiFNNOrevksHScuifuquvv2jiZnjKM6raC8axudgJFVZpXrh9yRcNo9vbidZykzSi
         r5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713967557; x=1714572357;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdQ0ElNNjcpbQIpJ1xf2rchBloiiwlw1canEoGrpfWE=;
        b=IyoTYI5jttWLJ/kwYE7WSbQ+KtkRNwYZkO1L8YtsXNmtULXAffZtlyXMlNKn0b6WvV
         kQRfR8aqZ3AC0mIemiTCuKnEW8Wbw4f5LNWnZM23a0Ks9KzEgzipIs2dGjtCFTKYAEI9
         8epv4+mOp8wqNYHVHy6h07gSPFDxrbRIPr8MRqZvFPcViVSYRdzVLvij4nnZptlS2J0o
         fmLwINq0ZR8qS4QLd2eoIeEKAaCIt6ZyXMdwCOBb9+trw/gQzm7LADlAhxsaZQmnov2e
         ukMSRsv/TWXlfGTT68gwZvuoUQ2Vmk4Q7tbyy9zzqzJNmjCAef5uNMCvjQjLMIPw0sKb
         2vEw==
X-Forwarded-Encrypted: i=1; AJvYcCU4eJaBx3M0Mt3eeoFLkFdI8hWPXM2BuE/zqRQXyd4inny4vqWIZ3N1dLa2ccYPQyXAOfD8FBJB4wFeC5G7NCdZ9y6ShOx0Q4emW069
X-Gm-Message-State: AOJu0YyODHiYAkD5FR2376CVFiN75Uybj9q7rFFq4lSs1WZ9iRQoUN4T
	ZW1vVc+F4w2SwaXt7Y9uBtMkof3Jl9BbpDyIHYjtj3jTKKq6RLkpLjFxwkOJUf2Y/Q9iZQ348Tb
	yNyc=
X-Google-Smtp-Source: AGHT+IEbhdGUtN0Z8RrMf55UUZ1158vNt0de2JPc+rWO8Iun7mc3/roCSNL98rGwj3hJonYnIMLxqA==
X-Received: by 2002:adf:a3c1:0:b0:348:c2c7:efd3 with SMTP id m1-20020adfa3c1000000b00348c2c7efd3mr1635594wrb.17.1713967556721;
        Wed, 24 Apr 2024 07:05:56 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d48c8000000b0034af40b2efdsm9105325wrs.108.2024.04.24.07.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:05:55 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Wed, 24 Apr 2024 15:03:38 +0100
Subject: [PATCH v3 5/7] kdb: Use format-specifiers rather than memset() for
 padding in kdb_read()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-kgdb_read_refactor-v3-5-f236dbe9828d@linaro.org>
References: <20240424-kgdb_read_refactor-v3-0-f236dbe9828d@linaro.org>
In-Reply-To: <20240424-kgdb_read_refactor-v3-0-f236dbe9828d@linaro.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 Daniel Thompson <daniel.thompson@linaro.org>, stable@vger.kernel.org, 
 Justin Stitt <justinstitt@google.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1454;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=DD7I2+/OSFAuYPjbxmMle8pdnVsY53Td8fq7KEPM4QQ=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmKRGUcB8O+iLmigr8T2IVW4HGG/L6tk+6pvEd0
 go9Kb3yjbyJAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZikRlAAKCRB84yVdOfeI
 offTD/9pWj5IWkhuuYbxzyB5xUws8ru2eJBhGkCaw1r+yP62FDECOfAGQUSp7rvl7RoSS5pNTl3
 95INKRg1m8mJP0tcU8Frwd+dGeIac+MbX/u0TlAlMyJNJ5P35RXFaXu1WjKEivlHJxH2AY/aL+o
 mQRdZAq7pr+wHaV1WipO3GlwGO2dcT/iql2hn5AOK4BG521yoFvVQ/xYkAVr/7QHTGRJt1ou8Pf
 PK6TxpAyXzjf4/315QqSCbtWDxb2TGnY9EKG/CerYTij7brpikOAl6VcZZY6PeC8rRTEdb4d6Pt
 ugny7/UdY3HjKVmXiG7QmEIh5m7b/yJXiJUHClRgNkvDXn8rS9xEFqvNmpBlNsNIOllT77q8/Ss
 PIF23Q90NV5bM9dMZf9aC4oMQyQI3Euv3N0Jeic4RQgF0uZ+v6MtckOK2P/LwRMmJwndgvXGOax
 VMfsX8ZNU6tUv9gLQPyBkRq7FZFjQs3jS2Mp1K3X04O5uOZXG5oxwDXfk1/demVrWz50RrLyNIC
 IinhwYB0zXjzoBEU+vFO2nHNev7MfK+hKsGWCZFGRNrhtCgpol3yNCA5QxE01fpHn/QmQ72U3Ki
 ZSpdyepm4L52ZAdmwgg0ju4ByKluyTh6PKBt1GIiS/nI0RoCwtDXgL7LIdoO6P2+rHdojpqCvk9
 prgzSR8mfHkK+2w==
X-Developer-Key: i=daniel.thompson@linaro.org; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

Currently when the current line should be removed from the display
kdb_read() uses memset() to fill a temporary buffer with spaces.
The problem is not that this could be trivially implemented using a
format string rather than open coding it. The real problem is that
it is possible, on systems with a long kdb_prompt_str, to write past
the end of the tmpbuffer.

Happily, as mentioned above, this can be trivially implemented using a
format string. Make it so!

Cc: stable@vger.kernel.org
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index a73779529803f..2aeaf9765b248 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -318,11 +318,9 @@ static char *kdb_read(char *buffer, size_t bufsize)
 		break;
 	case 14: /* Down */
 	case 16: /* Up */
-		memset(tmpbuffer, ' ',
-		       strlen(kdb_prompt_str) + (lastchar-buffer));
-		*(tmpbuffer+strlen(kdb_prompt_str) +
-		  (lastchar-buffer)) = '\0';
-		kdb_printf("\r%s\r", tmpbuffer);
+		kdb_printf("\r%*c\r",
+			   (int)(strlen(kdb_prompt_str) + (lastchar - buffer)),
+			   ' ');
 		*lastchar = (char)key;
 		*(lastchar+1) = '\0';
 		return lastchar;

-- 
2.43.0


