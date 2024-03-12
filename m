Return-Path: <linux-kernel+bounces-100798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8297879D68
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36EA3B21E71
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA3014374D;
	Tue, 12 Mar 2024 21:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJ4OEhbC"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04E314372B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 21:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710278686; cv=none; b=pXE+APmaK5Xu/bSw4cW7A0veWa8XExEPGCaVWrKdU/cAlRWu+e/uAE13OmbzRpC8CzOlr7yhxY9lz2iy+eZP7Flq9+Y5SOo48fd9FgSqrHdEWJ6BWEBtNzC0unCeYcsXPpKg8xwzMIWZgmjPJgypcnXDb014YCbZ5Rdc6MmWYj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710278686; c=relaxed/simple;
	bh=zn+NCXHkplgUV+dXIwohdLE+F3/a8X6VbE67wHJakVs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uzokEjKzF/hrT3ti5GPScPxMSAnsIdqh/W1BbXTu66cnqFFFfhgLnQfhpamvt5ObxejZloTta9xGHjZht3WBX+iQq7H+N3SUB7IivVoCFinjvH+4NtLYI1egFIBad7R4hPewUkYZR1uNium6gTgJm3oiArQLUXORQTuwka5FvvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJ4OEhbC; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e6b75211ceso36733b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710278684; x=1710883484; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yyVVkBcjoN3+kr62FySlopYdKOwyFmOO0p91aujbCWk=;
        b=OJ4OEhbCEvZV1VtObrZPylTYiwgnxTCu/xGWvXUGuK/xhCxAXqFa1X9FtavvU8ggZF
         nPdkFSPMw6ItbKn0LbcoNKIQM1Rw9xf4u2Zs1SStWIXlD5XxnzwuuaJSkuJ7hBdXST8j
         VADG7a9vXMMFPXH3+T8+kxKt/gPYEHfFIRKa/py7lKBT7KO0/JX7iKF859VfmS3A7ejO
         iFnLUm3Jy8p2wHT+dVdY9HHDX08f/TLiLDB/uifMbanrouX8DaibtU9ZYjwx4tJPTMm+
         SW5xsXnsy0a7hYBN5akWCdri8/xwuhdqJrwSLjCkOVZAANjOovqWdzvX8B62vDE9zBs3
         KRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710278684; x=1710883484;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yyVVkBcjoN3+kr62FySlopYdKOwyFmOO0p91aujbCWk=;
        b=eJX3rK4Wxy/B/aliuyzpx4i1bYCTooiDuXE32a7ojY29rfQzMUI0h5t6sLuxx7HqHm
         78s+fqBJfTKrcOBWQg/Uz2pplsTpMJLud4fo3ChD7uvLGyE08ZdVhrHgKD+WOlNgnekU
         rHJMbQtMJfP4I4vh5NpUmRdIltqmOfbHPzPjgBUM60vXslfsCw05fwc4p0q25Sp4XT0H
         KfU7+CQ+a1NermVEZ5xHegG/creou5qPrxHM+iV8nseS+Pav8C9Pf6K9qXgUQPsSrfv9
         yey1XG0GHIAcY6uVzSSfSoWV416qTWAvFZ6nElffRMdlZsWmP2UBHQ+U+yTzBO4V4SKD
         oDTA==
X-Forwarded-Encrypted: i=1; AJvYcCWEdrqTRvJP92ig2DIajmONTmp8+s+qrS7sRYOiCLYrCdsWZWle6Uyr00W2RN72Sk08ZZCH3qivkvrVDivzNZBnjLzaM+QpjbAeOgJx
X-Gm-Message-State: AOJu0YwHrxcZrdDlmWXceYINJ3W7oy2w1yQo3F3y7ffVsNspd6NoL6cI
	De4dj4EIl06pMx5uqwdaN8ZmeoXsravsJURl8OVY/tKP6BpiT/ck7wBZoc9uJW0=
X-Google-Smtp-Source: AGHT+IEcPiVY1OjLAeekn6g0s+Gbrp+3mGgtAJv9ETaGR3blWskKI0IHXdhBc+Qx2zE+ySIm38grIw==
X-Received: by 2002:aa7:8885:0:b0:6e5:adb9:b955 with SMTP id z5-20020aa78885000000b006e5adb9b955mr777749pfe.23.1710278683901;
        Tue, 12 Mar 2024 14:24:43 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.67])
        by smtp.gmail.com with ESMTPSA id x19-20020a056a00189300b006e6b0c7c453sm775010pfh.216.2024.03.12.14.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 14:24:43 -0700 (PDT)
Date: Wed, 13 Mar 2024 02:54:39 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	florian.c.schilhabel@googlemail.com, Larry.Finger@lwfinger.net
Cc: outreachy@lists.linux.dev
Subject: [PATCH] staging: rtl8712: removing redundant paranthesis chk_fwhdr
Message-ID: <ZfDIF+6MrdrX79nd@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Removing redundant parentheses in 'if ((pfwhdr->signature != 0x8712) && (pfwhdr->signature != 0x8192))' in static u8 chk_fwhdr(struct fw_hdr *pfwhdr, u32 ulfilelength). This will ensure adherence to coding style guidelines

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
---
 drivers/staging/rtl8712/hal_init.c |  2 +-
 key.pem                            | 28 ++++++++++++++++++++++++++++
 staging                            |  1 +
 3 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100644 key.pem
 create mode 120000 staging

diff --git a/drivers/staging/rtl8712/hal_init.c b/drivers/staging/rtl8712/hal_init.c
index 1148075f0cd6..9f41b2c086ca 100644
--- a/drivers/staging/rtl8712/hal_init.c
+++ b/drivers/staging/rtl8712/hal_init.c
@@ -138,7 +138,7 @@ static u8 chk_fwhdr(struct fw_hdr *pfwhdr, u32 ulfilelength)
 	u32	fwhdrsz, fw_sz;
 
 	/* check signature */
-	if ((pfwhdr->signature != 0x8712) && (pfwhdr->signature != 0x8192))
+	if (pfwhdr->signature != 0x8712 && pfwhdr->signature != 0x8192)
 		return _FAIL;
 	/* check fw_priv_sze & sizeof(struct fw_priv) */
 	if (pfwhdr->fw_priv_sz != sizeof(struct fw_priv))
diff --git a/key.pem b/key.pem
new file mode 100644
index 000000000000..ef912436e976
--- /dev/null
+++ b/key.pem
@@ -0,0 +1,28 @@
+-----BEGIN PRIVATE KEY-----
+MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC8i/6L5h4wSbaP
+tn9whe9BfKa0jpiiy+F9L0fJEWGKqUqxMUL3D48LJsqTgt8vP6ORMcSQmtQ1ijyv
+f9s0N5/sNci9dYeiVhzArlcZi4IOEkfkn/lgRoz4WOsZ6NQzgsk6ctctavrlHUwB
+e6RQHFyEC9BOmCq6PTPMtPTeTrQvjzm68gMiQfoNT86/uho+eKxABYBOZEN1DObt
+Q2wEbJOhiZ+UfknJd5BuxLXFLLeutYNHT+jzymVETfH6Zqr5U+NS/68H8tVRSy5w
+zwMZ38yQc5RI0fhI/u+6Lsikf0sJYV4sNaUkElclfzKFRE9RNc8McQcjbY8RUVvG
+81qbKvDxAgMBAAECggEAB62YcpWu7LQmbpN10h0U1rEJpY2vB+Yklcal9jldJFqW
+M5a4IuaBIpOe/ph+7Tt6tjrKxewVheP4v67bEYp4WpQAIOhXMH8Fkbp9H98Er1JY
+QiZaRJeVkwwlRXtWn423vcfCcn409GftL0bxNIqgdod39qi6CLaIVFGZgoS9pWLD
+lrrEnK8nlq8/4bs/bPyZqoiEIUXTC9IAHhlmmwL1diLYmTOTIFn0XN3kqxMwz50D
+81Bh/pPZXXsL4f3an9v/68prsM4NgJMXvHh/qWGY8L75QyoPn69/6d4mETBDCSeL
+BAA1Ac2z2UlC6uqlM5A4/F1IEilrtDIFMD6r3UMZDwKBgQD1Zbx3A3VV/HDlH2CN
+Tzf/Er2xUPYbPHJCALbZVwEM8zNTeIysMM3LeqWXfbJ4JpfkU575QLCaAC1PdQJT
+AjNLqo9eYzsir6pj18HqBN/MxIujhbLGA78oD5fYRTL+5sXl0m1xkJq+ngkWbx6Y
+ByfZFZ/UIUMST8kU8nVlNuFN1wKBgQDEsXO0PH5f0RkdbRVBQvVIdj5kfR94bheW
+s7apwU07uYvlLiLrikRgC3Q60a7K3H7tfxkP5rjKUr+CyH+rlsL+WL4gJjBi4D13
+XQeFlNbZieNNrnOctFCnGPlUSmte4Ubd1QEplUkbYkfvh5XKIklAfLsQPf17FQr/
+ZAE/2YIOdwKBgGfXCQ0DdZ9RFySdRmoFX5icAZEKxVl5FpA/ZSBK5LLqJonntP8Y
+F71GxNN56Q9WpWeEyvyGFzTTZlj9FmKxx6r5HXm/W8KtuthM8E1qiplHgh9L7/5C
+j50QHBz0C0Q5uvwpMw6fNhv7G7VWiAek34PI1r0Y5hzVji1C+9I8itI5AoGAYGsU
+at/UmyenBhO4/ZrTHkhIYX4sdR6SlZ9XBXPqZkKYXyn0mD3ZMrOqsEKlSnA4EDfj
+kzXok9VoZ7XdT8HBqGjcGmpeAbomp2KFE2hYwZ6kPCouJj0F5EOLxVQNuh74XDnU
+LgwuICxXUwXF2aZg/immkVmx7inskDD3o9L9vBUCgYBhCpayQcy9hswdDVICOEst
+U9VXwVAbwfdmPTLiKacRQdw44zhBcsBB0wi1dszvGvSlAlB+ChFM6MxALEdbvTln
+Jxwsyxx9KXuoryhcTlHQikBOYxmrqPAhdrPh8H2tdiv2yX35x9g7E/XkRZZxMfkL
+H7x8vakFgGNcX2NITZBM4Q==
+-----END PRIVATE KEY-----
diff --git a/staging b/staging
new file mode 120000
index 000000000000..ecd48e46fcb1
--- /dev/null
+++ b/staging
@@ -0,0 +1 @@
+/home/ayush/git/kernels/staging
\ No newline at end of file
-- 
2.40.1


