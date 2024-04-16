Return-Path: <linux-kernel+bounces-146665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173568A68F1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7D41C20AB4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BB312B151;
	Tue, 16 Apr 2024 10:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fe6wLfBh"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1220112AAC4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 10:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264335; cv=none; b=jwq7r4C8tV0G3ljaTkKoQaQSeSwd98y7YuILGDeHKjI4meLESFWkWWfr6y+GVI9RIY5aLVWj/s91ed7uPyVwIYUSX0TC6k1476UqDuYNXi4qStg1RzqVIN+Btzs/uGjx+13ZKMw1aLOaQjPg9oUo4Z+5dxGly7qOiynz106Hcmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264335; c=relaxed/simple;
	bh=d2qYpbUEJ3bo57WTysC1k9+78U0fLX5bGNTDzJBq7DU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AVCIlUle8c6ZguUQVspAZb0V7yDaIW9gpQNOWLZ1yhIZ/m7xQA/nFS2phjTN9o6/vT9sfNK4eJGoH9sd949wbVijB3F3T0GBxHwNawkD+yrRfkEX4jDl2ZIE11wFBjJ1Hc9CrK7wraUnUK45uVKZhmfaXoaxMJVha7do6fMhRTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fe6wLfBh; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-343f1957ffcso2474300f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 03:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713264332; x=1713869132; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qax0/HGbPdCX4M7gDaYwDwDlZ1cE1xlWdr0Di9/Hmb0=;
        b=Fe6wLfBh2yuqAjnFQoeBaITeoH1uyvSpahF3xspclxzdlMTiTvzcs7+qFL/mM8ydUY
         n+8ZoYY+JoYc9WsFjTTSnyHrnWUUWAEirpeBUYhRyHg7BTzrtAfc1sywp9SOHwA3VP4n
         GO0CqMccdlVqUfThGj9UnrwCi24xzVqnf1kKpk9XlVoXa5ANGG9HmeO112Uxw65T5iVm
         3luweyKBg2GVuwgprU74yXrBqShqnzjwLicVfG1gebeN/aMY8KHTBOaUOQDp7ivlDxXC
         4dShLs1rfLR0WGVEtwyNY17qlt9b+ID66gMv5sjyAVzGPsvRdSUmNGiTVUwnhb6etK/L
         zbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713264332; x=1713869132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qax0/HGbPdCX4M7gDaYwDwDlZ1cE1xlWdr0Di9/Hmb0=;
        b=gFoYPf0ZdnndBqVqoNlwfp0eWD3hcV28mfc0sMIbNW95l5pW/yUreAmFnAtBgU65N6
         JoSq7dEthiXJDffHB/1feJzi/0yWTG/4nECn2YhYd0ehhM1lSfrxoCoPNQtQOrAbcSeC
         rNttY7ZQWX3RI6G+XSPIJmNpiylo3z9s43proQZcCEmPHdjclGTniOAQIrhh9Jn8J0bx
         4ltVlPjF8W/FvqaGzNbm2qSLTdcCNW+Ls8MASXB0ByfJGPDnS0erKUg6mIvzyLU3NLAk
         gsk/EIbRur7HqyHLw6n5Sv27BQ4qefX7QbQgoa15rorMtguJzwqpyIMFDsk070mzR81L
         MFrw==
X-Forwarded-Encrypted: i=1; AJvYcCW4AFMEKZWpdqTRu2fdax/cA7ebtRAZBhKG4MYDrz3OCNpW9hec0iBVg6xbjeELBG8jXSQdUiX0Z5oojXr+DTv0IYmHIUMhaVMeyKu1
X-Gm-Message-State: AOJu0YwXpHhgHsFd6Ju5Xw1zJkK9tR5va30xY/ovJG1+qev3ht9xe9jT
	gRg9UVZClDQQ6GCG/YxAEBmfjQyzxbJC9n3Mi4KGJQmfP6qAcuDX8rxG8d7Ccxr3Xvh11OcT3eI
	LXIM=
X-Google-Smtp-Source: AGHT+IE6Vo/tbKSEfCm2gz79le7FExVDtRtCuxkP1pWrZlx5DmQCQVvhm0MvVCYaPpwW+OmM5iOP3w==
X-Received: by 2002:a5d:6791:0:b0:346:aac5:add8 with SMTP id v17-20020a5d6791000000b00346aac5add8mr2282957wru.6.1713264332537;
        Tue, 16 Apr 2024 03:45:32 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d6709000000b00343956e8852sm14470141wru.42.2024.04.16.03.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 03:45:31 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 16 Apr 2024 11:43:24 +0100
Subject: [PATCH 7/7] kdb: Simplify management of tmpbuffer in kdb_read()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-kgdb_read_refactor-v1-7-b18c2d01076d@linaro.org>
References: <20240416-kgdb_read_refactor-v1-0-b18c2d01076d@linaro.org>
In-Reply-To: <20240416-kgdb_read_refactor-v1-0-b18c2d01076d@linaro.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3364;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=d2qYpbUEJ3bo57WTysC1k9+78U0fLX5bGNTDzJBq7DU=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmHlay6q04sxazUzKyygazLoHSnpWmcuHg4udwO
 xXfJvb8gt2JAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZh5WsgAKCRB84yVdOfeI
 oSyTD/9r+1V/UTe9ST/Zl2Db/l6Ln98PrTz7OiluHWNsXyfaYlgHmjNI7O64hSS+7rFMZDn5dnZ
 TRwrfbtR3nFvp/Xnb+o0oVUe+K83Zh1hSKkOjVFgX8KoRJ0e2kLRogrHokcCsKByowRwWNXqmEc
 Ac6RHvWWJPimqlww+6L1WrQdauaOoHY9siRHtwma7dkoPkquERl05mbtp+DKjJ7TXoqqyqShwxm
 2HeOIV2U3ZSME9btaKm0UGLVTIG7qbsEVtGShbcTKMaxjzkIK87hMwvAIqyaztOIAaWPCCiL5qo
 nn4EVAkxRRVz8dQwZsZ5HEiVdhFDquBDjw2D3EdspgOsn7VepOLbLbP9i0ROkmJjyLm4k6QEBBH
 K8XIHU6HL4zCUDMGqwHQIDv5AJzaV7SvM6nBLClF6TxdMSfxax/gLvw+nI5AS+yGYBvlWo3yNSd
 aYAceh7ZdtZ9tBbsiuZ6p89XTgFIlgP5Iv2ok5Ga4biX6xlg+urxEykyft456ro5TJKiKDfJhgo
 W0oG0jNON8RIkjPW66QNgbv2xCwt6VOSVmmEQDRMn5hZcmPkyGRvZQPyHksgGESr5Gvp44eFDee
 T2l92jNwr56mCfxQ9+OBTn2pEWTS70hD8zQoMTfkd2BzjwuMVLBHMRugNLCM6KQD+eb6McwgwtG
 D0SmOWQvPxMM4ng==
X-Developer-Key: i=daniel.thompson@linaro.org; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

The current approach to filling tmpbuffer with completion candidates is
confusing, with the buffer management being especially hard to reason
about. That's because it doesn't copy the completion canidate into
tmpbuffer, instead of copies a whole bunch of other nonsense and then
runs the completion stearch from the middle of tmpbuffer!

Change this to copy nothing but the completion candidate into tmpbuffer.

Pretty much everything else in this patch is renaming to reflect the
above change:

    s/p_tmp/tmpbuffer/
    s/buf_size/sizeof(tmpbuffer)/

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 94a638a9d52fa..640208675c9a8 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -227,8 +227,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
 	int count;
 	int i;
 	int diag, dtab_count;
-	int key, buf_size, ret;
-
+	int key, ret;
 
 	diag = kdbgetintenv("DTABCOUNT", &dtab_count);
 	if (diag)
@@ -310,21 +309,16 @@ static char *kdb_read(char *buffer, size_t bufsize)
 	case 9: /* Tab */
 		if (tab < 2)
 			++tab;
-		p_tmp = buffer;
-		while (*p_tmp == ' ')
-			p_tmp++;
-		if (p_tmp > cp)
-			break;
-		memcpy(tmpbuffer, p_tmp, cp-p_tmp);
-		*(tmpbuffer + (cp-p_tmp)) = '\0';
-		p_tmp = strrchr(tmpbuffer, ' ');
-		if (p_tmp)
-			++p_tmp;
-		else
-			p_tmp = tmpbuffer;
-		len = strlen(p_tmp);
-		buf_size = sizeof(tmpbuffer) - (p_tmp - tmpbuffer);
-		count = kallsyms_symbol_complete(p_tmp, buf_size);
+
+		tmp = *cp;
+		*cp = '\0';
+		p_tmp = strrchr(buffer, ' ');
+		p_tmp = (p_tmp ? p_tmp + 1 : buffer);
+		strscpy(tmpbuffer, p_tmp, sizeof(tmpbuffer));
+		*cp = tmp;
+
+		len = strlen(tmpbuffer);
+		count = kallsyms_symbol_complete(tmpbuffer, sizeof(tmpbuffer));
 		if (tab == 2 && count > 0) {
 			kdb_printf("\n%d symbols are found.", count);
 			if (count > dtab_count) {
@@ -336,14 +330,14 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			}
 			kdb_printf("\n");
 			for (i = 0; i < count; i++) {
-				ret = kallsyms_symbol_next(p_tmp, i, buf_size);
+				ret = kallsyms_symbol_next(tmpbuffer, i, sizeof(tmpbuffer));
 				if (WARN_ON(!ret))
 					break;
 				if (ret != -E2BIG)
-					kdb_printf("%s ", p_tmp);
+					kdb_printf("%s ", tmpbuffer);
 				else
-					kdb_printf("%s... ", p_tmp);
-				*(p_tmp + len) = '\0';
+					kdb_printf("%s... ", tmpbuffer);
+				tmpbuffer[len] = '\0';
 			}
 			if (i >= dtab_count)
 				kdb_printf("...");
@@ -354,14 +348,14 @@ static char *kdb_read(char *buffer, size_t bufsize)
 				kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		} else if (tab != 2 && count > 0) {
 			/* How many new characters do we want from tmpbuffer? */
-			len_tmp = strlen(p_tmp) - len;
+			len_tmp = strlen(tmpbuffer) - len;
 			if (lastchar + len_tmp >= bufend)
 				len_tmp = bufend - lastchar;
 
 			if (len_tmp) {
 				/* + 1 ensures the '\0' is memmove'd */
 				memmove(cp+len_tmp, cp, (lastchar-cp) + 1);
-				memcpy(cp, p_tmp+len, len_tmp);
+				memcpy(cp, tmpbuffer+len, len_tmp);
 				kdb_printf("%s", cp);
 				cp += len_tmp;
 				lastchar += len_tmp;

-- 
2.43.0


