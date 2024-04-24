Return-Path: <linux-kernel+bounces-157041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 873C98B0BF6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36FFD1F28C48
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A201C15ECFD;
	Wed, 24 Apr 2024 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HBhJP5OV"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2822215E7E3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967560; cv=none; b=cvFgqTA2svkfNn8eCReTKndoo4qdm/bI0WSoKlw+4TdZSioBwe2uJnOjA9jIJsSrfEBmcj7bny44NUM5v8HNKLzUxijjPeNeprcSDqGj1tUFai+3UDvZwOUQoNa4V6NEARA5QSG8sGVJQ6TJBLSoFNGg3DvZjBxe0xi8H8Si7XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967560; c=relaxed/simple;
	bh=rg+wVmfYkRGv9/2I6H3Tms0eU7TpUVK8/Yo0BHNg5Cg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PJmamJ0NzQLPPuMr6CrC+Y5p7mg4jr9sq8vojdVZfdSqv1Z/7aCmhBuLgqJbLIH4ik57+TlKOX5sVnpi8V4XqreLVjB5QgwPl6mYvL5c+w7OlCE/v48kQ3fMa8CjlW5Tn9Myn1ch4FqYLNBJtodPPrlag50Sn3Sd/mEt1rji5rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HBhJP5OV; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-345b857d7adso5510238f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713967555; x=1714572355; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wTP9sloie88dSAOWvNZGscW0v0fJi60UyTt3HwL6Nts=;
        b=HBhJP5OVzkHV6Z7uLrmCiQSRHuSuwwQUFMBbgjr4CMm0Z5gLxlDN68xmgH+pP7kjEx
         55+qsxC8ad2HYjEF8gBga0NgWFHH2JhF/9qC+NpOC1tsb5NGkDohu/7amhZ8t/5KqCcX
         apF7qBQrfQ2co3kNWWo+bcYiaDrLLNP45DjPWRszmaGQo29PXyA9yBsjXnj57OryCNot
         Cp+iCDTTAzVTTyhm26WOZddMdb42k6VTQ7rvGwrdcvJtqVX80xHFaJRG3TrYonYtuDXV
         M0wseJULGQmhMtPw6ZwQdXUPtv3xHAX6+OfRmaPgYwVUNP4qkgGl/DgP2n/iXwJa/dcQ
         y0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713967555; x=1714572355;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTP9sloie88dSAOWvNZGscW0v0fJi60UyTt3HwL6Nts=;
        b=mFi9KSns56wcknFg7kszAmxKC71JEWxdNez1G6Munh9NDZWxPv+giKpfuA04kSjDck
         9cnm64tJaqvu3rvrrI0wjRDkk5AqJFOYC6w0nTXin8EZV2zCfbiVCNo8T83TtbE7Fakk
         hHqMK6B723bYf6zLTqoNWVOacH6NP/mBDVc+GaGiB7MyGpHzjHb3aVpJD8RUvbDBetNc
         LpCwGKmYJ+NPJ3+eShTUG8/6xYtTigCiBFAwPc/vgL6K32u97UjCcRhfpEsLrHays6Sx
         9IjuWv3P4ZyfHNCk0LO3yJtmHCEnUGCB+74u8i/HWIv5r2R/86z/PZJNRMPryl7TwQZ4
         Dekg==
X-Forwarded-Encrypted: i=1; AJvYcCWHsOfpg4DcJtzdE9nEjJRKOEH7AtE0MbDCDubALzOGrKTQZANG9yhZtNfxUikYWbhQjGwNddUrS5iP0zA81llP3qe8tuAwi3Ruljps
X-Gm-Message-State: AOJu0Yzn0lWo7HkND0FFhJvB07V3QXCsV72F553CWnQs/MvOb8BVO8le
	QX0+EC1bkgqbVo+2uV5+Nr9avwdJYFZmbsDAoc89nztWly9sdNH16XR5K8FbTGTCAmMNnbv77Dk
	bIKA=
X-Google-Smtp-Source: AGHT+IEPX+Xxot+imSpOcgmGXIlR2aQ/wmTSkNDbehn8kMSExZwzE+2IRDZ83atLmZU3x+oYV22avw==
X-Received: by 2002:adf:fd05:0:b0:347:70ce:acbe with SMTP id e5-20020adffd05000000b0034770ceacbemr1867171wrr.67.1713967555393;
        Wed, 24 Apr 2024 07:05:55 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d48c8000000b0034af40b2efdsm9105325wrs.108.2024.04.24.07.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:05:54 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Wed, 24 Apr 2024 15:03:37 +0100
Subject: [PATCH v3 4/7] kdb: Merge identical case statements in kdb_read()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-kgdb_read_refactor-v3-4-f236dbe9828d@linaro.org>
References: <20240424-kgdb_read_refactor-v3-0-f236dbe9828d@linaro.org>
In-Reply-To: <20240424-kgdb_read_refactor-v3-0-f236dbe9828d@linaro.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 Daniel Thompson <daniel.thompson@linaro.org>, stable@vger.kernel.org, 
 Justin Stitt <justinstitt@google.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1374;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=rg+wVmfYkRGv9/2I6H3Tms0eU7TpUVK8/Yo0BHNg5Cg=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmKRGGUIqVKrOdXwYeS3cqs6ybpiHvyFYQnDNDX
 wKlZXU4yfOJAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZikRhgAKCRB84yVdOfeI
 obU+EACP6jy9g//wnAmPJ7pvsIGCksOaTaiCmuiV6HeoRkqrYb/8LXKinX2ulqQtBlzx/m3gj/1
 r903vaASLGgIfcByimnXKvcBwOWOKSCtf7hg+Pdz3H6UPCSHLi09U4EjXe4Z0Q7KmX+rpHHt4Rm
 cXCJDQw6Oi6GThI2/YK4ZU2AXlxUwH7EscpSbEJSDljvRzqTkCFIGUo/NhMhpAyB2MEK+GuftBT
 CcrpGKerGJGD9X/I/YPLD1r8PMxTXMPSiWJpJWttiy45HQiX2ziL42syJibH2kb84KjzQbgXOt6
 0puhYjeHPcK1L14d051++9Cp+bdKdhPuDLY6X5wjKHTY2rFW06Ms0wwIzE/QIrXwT+t3J6KKW+w
 66Zxi6Bm6O15lrO5AlEXAQL7eCNIMWmIuUHWXP3iihytoXvwViLOWQ6A5BVeG5cu+F/r95czqdj
 QYiOJ8A06T6q2kI/f7WVIh+NU0AUJSQu0Pna52M+mJHAmymxRQUDrs/aDXncVh/pRgS6hiBIqpq
 36eHXGO6Ykh7SoLQRVzmkpbbKQ+aXLMcL0PAy0GdvDJGYqcvWtRxEXmSrfF0rwYJnBKhuXA0Ah5
 gAqwsPthBijNpxOESrNb7XMHsUvEaDHlcuzeKwkpcTO7wTFuiOB7GfjdTniKGz9JXyoDCmVisXR
 sF37CLSCUj/j3YA==
X-Developer-Key: i=daniel.thompson@linaro.org; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

The code that handles case 14 (down) and case 16 (up) has been copy and
pasted despite being byte-for-byte identical. Combine them.

Cc: stable@vger.kernel.org # Not a bug fix but it is needed for later bug fixes
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 5fccb46f399e5..a73779529803f 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -317,6 +317,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
 		}
 		break;
 	case 14: /* Down */
+	case 16: /* Up */
 		memset(tmpbuffer, ' ',
 		       strlen(kdb_prompt_str) + (lastchar-buffer));
 		*(tmpbuffer+strlen(kdb_prompt_str) +
@@ -331,15 +332,6 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			++cp;
 		}
 		break;
-	case 16: /* Up */
-		memset(tmpbuffer, ' ',
-		       strlen(kdb_prompt_str) + (lastchar-buffer));
-		*(tmpbuffer+strlen(kdb_prompt_str) +
-		  (lastchar-buffer)) = '\0';
-		kdb_printf("\r%s\r", tmpbuffer);
-		*lastchar = (char)key;
-		*(lastchar+1) = '\0';
-		return lastchar;
 	case 9: /* Tab */
 		if (tab < 2)
 			++tab;

-- 
2.43.0


