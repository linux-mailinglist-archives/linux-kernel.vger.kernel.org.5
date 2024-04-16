Return-Path: <linux-kernel+bounces-146664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48C08A68F0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64701C210A5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F47912AAE0;
	Tue, 16 Apr 2024 10:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ub9uX3dZ"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB5712A159
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 10:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264334; cv=none; b=KCihS0rTs3uc1CyGL84FBt0Rr7cJejlcCCRT68nizIQ+xjD12WZAYM3JHl4Qm+7ObSLKxRxPDiOCQrnwq/7RZ6nX3YE3h8IIoi0M9KRkqQVygzdgOCVSQHML66lLtlBfgYGSRwCzHZnLgrIS7E6OVd2DYNm0IZepzo0G/TgzhVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264334; c=relaxed/simple;
	bh=No+HsEC4lvrte5CQLSZAJe5KYulPb9Qk3KwsfZcxvK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OB7l3CwbHDJ9actYhdKSeF49ZfR2u6wvhUSIzdYNqYs7otuCMfzP+LdmgFsE2V3yTXKMAslScBKyHAXHKuEwGxp0NUemEKcC4UV5ZXJV3br3gVItkq/4upGqTw8GpHw2ECHK9y8NP/OEMpHrnitG5aD8J/7v7uk9njR/hRdzD8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ub9uX3dZ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3497f4336d7so205950f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 03:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713264331; x=1713869131; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QDnp4eLfPkrNB753JlPHc4+1zTlQQgu6klcUboN71ak=;
        b=ub9uX3dZQ+8Mjg639nX2gRruPf+qfjRUVZsT/bCZurXjzd1fujiSIwYPBhTPSjGLjD
         aONh2pnjSYrZ8i5WuRS32lDf4xHsd2+70F/3WvybJCVzTB17vKQezQu0cLECnrsGCsHI
         wh4zOdIMcMvDBwXugjXafIe6Gr/Yza6u2CNIZC2/Gib5BLh7xnVYMtInYFZ3T6Kzbfdm
         SnMLZ+fcv3E+Vs/tzJ18M4JA/gqqHWIaspFYopJoTdJ1PqgZIxixuE3yaHETYZjTmb6g
         ioZ5ueWRg9pjNnEU//JjDuH/MDx7ndLXva7o0TxxTXTnQRDFf1sr7x8EQCQTYAuYrL1P
         AT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713264331; x=1713869131;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDnp4eLfPkrNB753JlPHc4+1zTlQQgu6klcUboN71ak=;
        b=n7W0VmdUZFqN1GYqOJ1Ma/rW9E0iPIzliV7Cg2SkSmezTwgFMNJH7fRvPN9js/B5EE
         hqyzxwx8bjDBy2wq6DjcqjKnjROP7R3LRgjLH0lEpKgxYdxn1xvbd4SMffAqIZIj+FSq
         gDY6W/w/BKleYiASkQkhVeprEqm7cDMT/GxAHlBpSVDpGO5UmyFkHGZ88gEz4tb1fnEi
         83clECNA0Onvgu7loMZm9ptrjPterTdd5z0NP31f/Z2/Yx9ty+FhB6tT1XZ37xg7zefU
         bTeHnBeTDi1nUCcwFOkGaJsBMNz2ati+UaelPJkRTtezWZBFYDywJIrBF9L6xZMsW9rS
         LjQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVynJC6YuBqPeKgAL4kGKkq92BJzU59xiC/OlHdmMyVRLH/pmjqnD3i6MzLaRODmCU2sRcn0ZdkAbCxN1x+ml/l8t8zNn0/+LI7DsLO
X-Gm-Message-State: AOJu0Yx3JRFFieO3oNOPULGQ+7VYMSQIRCIOd+V3mp+1Jew7ML3w9eNv
	8bNZO8LALQSlKLyU92sDe35mPkzLo2PJgS4bFmarokt5YrP9si3dfFUT5kTMBg4=
X-Google-Smtp-Source: AGHT+IH4V0nJ0IbIq7+Gy8ZKpjgJlFIuArenwe3np61zZYLEgAJqgIqvpK3dmZ31ad7F49jjBFBo7A==
X-Received: by 2002:a5d:4c88:0:b0:341:b5ca:9e9c with SMTP id z8-20020a5d4c88000000b00341b5ca9e9cmr1166182wrs.25.1713264330911;
        Tue, 16 Apr 2024 03:45:30 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d6709000000b00343956e8852sm14470141wru.42.2024.04.16.03.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 03:45:29 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 16 Apr 2024 11:43:23 +0100
Subject: [PATCH 6/7] kdb: Use format-specifiers rather than memset() for
 padding in kdb_read()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-kgdb_read_refactor-v1-6-b18c2d01076d@linaro.org>
References: <20240416-kgdb_read_refactor-v1-0-b18c2d01076d@linaro.org>
In-Reply-To: <20240416-kgdb_read_refactor-v1-0-b18c2d01076d@linaro.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1252;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=No+HsEC4lvrte5CQLSZAJe5KYulPb9Qk3KwsfZcxvK4=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmHlak3MpSVd7zzCBYLcWcUnSJ8K/53hRJu8yhr
 GMrGpv8lp2JAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZh5WpAAKCRB84yVdOfeI
 odblD/0TgD4iWnIA0n+xb+oa/t0dw6hBfpt99NOIsG3UDXseZ1OVUO+/YvMrOyml99r6JWRotji
 p11AIGLxH5UYWkPVQFhAqd49dxe2jFYd2i+kHBHa0KQ+w1bjP3lZgmckLhfJthEot79zQoC2tUn
 hR6FboiH7BUSCUfBwgPAK8fMb9Gu9K9Ok0zTUXEyoyS9hDOwMxLvwIPmZ4Tv0rgSgwqS22+jx90
 BiKK7OxhBNHlIVj7ZF+9fwMWlsDVsI882NNPD2jeDWrXrrBcnCaGSc90dgvzcPBibDIVqniHA86
 RC0AnpntSr0tzmo33pkhKvpj/mBArS4oXehvM2p6NUV/ucMJq9+cf5dBfmrCz+7tS6w4Tr17Kaf
 ejVsIENVZTQ7J/OugTHhw39W72wWnRHBZpNoxXDTsBQ74SOrsh6NbVxBcygktDmpuQr3XZNueYC
 oCIfSDmw1+IMWnuo5u/juNfVl6NnRKo1r6kvcXHhbQw/27qbFKQNYYc+/frasxs58r/KwazG/sU
 Ok3F2rXM6gzvItBB8WK+9a6mkl/6a1voV5a5Ql8cvYyA59AIUGYTF4qeyI9bNLI1z/0X3SveK7f
 ihciB57kdTcSE9pK6VGsjSUZPYYUYGWmvRUg+i94wEC8UDgXiL99EeFw6Qf/cErO0iyas6hKAlY
 R8sE4B9A600rhEA==
X-Developer-Key: i=daniel.thompson@linaro.org; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

Currently when the current line should be removed from the display
kdb_read() uses memset() to fill a temporary buffer with spaces.
This can be trivially implemented using a format string. Make it so!

Note that this also simplifies the code by making the tab-completion
code the only code that uses tmpbuffer (and therefore makes reviewing
to ensure tmpbuffer can never overflow much easier).

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 08a86a329eb64..94a638a9d52fa 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -295,11 +295,9 @@ static char *kdb_read(char *buffer, size_t bufsize)
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


