Return-Path: <linux-kernel+bounces-105491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDDA87DF2A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E52281AE1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 18:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1981CF8B;
	Sun, 17 Mar 2024 18:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ayn0HhU1"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EE11CF8A
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 18:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710698783; cv=none; b=Q8z+WXr0kA+buiQksIfF+w0GTJkLdm22WXHWvZ02KM0BDjnosffRVRctdZkzy17Cn685+otxV0r8lCpdfLhba6+wvDBRE6qHBX/GOptPhFIEqRGrynSjLTf4UlCYvK6yagXy/i7I9vgaVOWiYS9fcQT3j6NTMeCN+5BLLQKOsOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710698783; c=relaxed/simple;
	bh=xMwMkKngWMgejOhxDouCnhEyArbQUSNsTw3WxpvWneY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KWtQ5F8qTkL5zNA8nYU5KDX5iMOCzOatqd/8vOx1KXAgAk+Lcyb3yPVd2Y91VVo7jDJfTjJN22+cdEn/7X5UCF4ZhUZwfjt9uf9T1M11kVCMwvR519hVnH28hzXTm7l4XBIKGvPxwGjZhgXO07aFAcyLkJ0xHnfEvBF8razplts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ayn0HhU1; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3667770b8e8so21405635ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 11:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710698781; x=1711303581; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ccHkhmsb5PGqPme4pfAQtFz0/1A/f06u4lt3vBFDYpM=;
        b=Ayn0HhU1rb0J0M4GorEhk6i0cmKHiYjqVIyqbt5b+wSUw5J+uQAXOj5zCaotjBE5uv
         xoYTKLfFT+8BO9CjbwFoSL8gVqTnLEMFiRw7N4m3lsCUeYUrMe3J8S+VmvyqpucHY/7B
         twbOqUbksnIBlm2zIIzGc/pBf9i2O0xL3ekXIuARkjgAzErrYCTrqlsanqOgGavIWW7D
         MLnunKtXQO+DAjyqR9Opi4vQgoC8w7bDKdpn1lffV+5TYvt0pUvbyb3i4QttrzcbcwI7
         nnFFphqvQRUcLdxe16Yob0Huqf+svBfT9NkfLCZx2jQKt2ICM/qqFf7SUYS8WK7ccw2N
         1SNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710698781; x=1711303581;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ccHkhmsb5PGqPme4pfAQtFz0/1A/f06u4lt3vBFDYpM=;
        b=vV/KJJoLGYCG+fq5dRqQGqOtEHNGZW/IcLgJBaNR0ejLIGaNnoCg4ceHi3MkpOWo/8
         A/sN3tfS89MlkqOKT63UlXslmNORaqIoj5URe8pO8IHcWJ+cfYBql/mmI9ybRmFIH785
         D/HL43AksQsX0qmUv0FbaZc+wY7OpSLrsmo3GLEe2tqjVmn/qtSE4r91C5uvxIp0JSXV
         ZCJ7x3aXLGYsVbLdJs3hAxA+crlSbKRDl7ZrZf5w7YP+4SKQJhIrm0VggvpoWKvAy0jp
         eIeKg1HwQ/eBAXJiL/NvDTqzeHRVEgidEBW4iScGF+zr92NE5raCuW+BJTvbg3jQk5mj
         8gXw==
X-Forwarded-Encrypted: i=1; AJvYcCXVqyfqoDZOt5LkqV+4a+3BNisigCNQgdowv6uPq7bFZ/ZB1xnWwpM5K+yqeGuL17zs5IhA+DU9c9xL9tT4lC26nrR+JjFWuOGMfn/j
X-Gm-Message-State: AOJu0YyC86g7uIWKYsgrdhq/I+1toVZiJT7uYY+s9mW11FqCysc5n7+F
	1Rh68IT4gUIej+8T0s2rHwr7PqsxNh52OSbS0w7I9v3OmLX2jPaL
X-Google-Smtp-Source: AGHT+IGXY3eki+RRJPtGy2lHfjQHnvEEuiKjlEJf18Bs05orQk+GSE/fK8qybJ75CZKh7aCsuOHQQw==
X-Received: by 2002:a92:c70b:0:b0:366:3766:6c4b with SMTP id a11-20020a92c70b000000b0036637666c4bmr8740240ilp.16.1710698781203;
        Sun, 17 Mar 2024 11:06:21 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.65])
        by smtp.gmail.com with ESMTPSA id k188-20020a636fc5000000b005e438fe702dsm5624183pgc.65.2024.03.17.11.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 11:06:20 -0700 (PDT)
Date: Sun, 17 Mar 2024 23:36:17 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH] staging: rtl8712: aggregate conditional statements
Message-ID: <ZfcxGebTKxVUJONY@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Aggregate the two conditional statements into one conditional
statement to reduce code length and simplify the code structure.

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
---
 drivers/staging/rtl8712/ieee80211.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8712/ieee80211.c b/drivers/staging/rtl8712/ieee80211.c
index 7d8f1a29d18a..3b7a72bb6fc7 100644
--- a/drivers/staging/rtl8712/ieee80211.c
+++ b/drivers/staging/rtl8712/ieee80211.c
@@ -147,9 +147,7 @@ static uint r8712_get_rateset_len(u8 *rateset)
 	uint i = 0;
 
 	while (1) {
-		if ((rateset[i]) == 0)
-			break;
-		if (i > 12)
+		if ((rateset[i] == 0) || (i > 12))
 			break;
 		i++;
 	}
-- 
2.40.1


