Return-Path: <linux-kernel+bounces-80493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D81D48668EB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862251F2305A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5F51CFA0;
	Mon, 26 Feb 2024 03:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="fNKTMAMf"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5834D1CAAF
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919799; cv=none; b=jtzx2sXyjnCiWMj3SSxjwfQ+JOS5OzmJN5dpsBEZtV+5HUnAJznWHhZCQsV0qnXILraf1qFFFTygp/8bXFIk79N731X+5RGCof5kUCkK3hi7ztgqATN8H/JlO6wlVEDu61eyU1YdY3bydARbm6L9GV4gpM8ko9rAoDlzX5/uYTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919799; c=relaxed/simple;
	bh=+qXOC7uyNCfO3onc/Ij4YTWsCuq+NgWkyhuI5FVLo1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sQeXbAiCeab4iARja/ZtBAsVnjQAkvmTXleC93kvQYDM8/POLU26dtVGonmLMVbmj9jvD528us4OETVbvEcln+TbNR/pkG8dabDtjDFQ6uV6UAAryF0QOSwy6PwAGULP2ZaW7V5LrMQJUvZU0M5Vu/IsL4px3+KGthJz8WERKuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=fNKTMAMf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dc3b4b9b62so22412585ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1708919798; x=1709524598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsGpwW/IQSH0g2lIKg+JsO77ipE/Ng9n2y5WNXmPBxY=;
        b=fNKTMAMfGyR95EGiJuaIqeIN+lWZ2r36DbjFbVgkoX2u5PZXMMn7OudMs437tjBLDK
         sVbOivxSlh50RhrAKTXsDZn3vyhZGMpKsIk5yvVtB0Yn+lxR92Xd/IxaFE6hqe6LHY+T
         +cL4jebdypxq91d6MJQxV+TKLvIYy1xkIvzbHVaDA1wkShX2QCaaRh9+/psrrG3Fvq3V
         0m4hVgwhpdsg3ZJt6N/MISa/FczdiDuhuqJEkUHIJTnufm4fqYa5ZkrSB6Ty/P7fKJTK
         jxlsp+OWwEjZ8E8fNoyNJBfNRtsuztbTVLqenQcoUYzqtytGlR9Tbjpmtsr46mna9mzY
         N2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708919798; x=1709524598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsGpwW/IQSH0g2lIKg+JsO77ipE/Ng9n2y5WNXmPBxY=;
        b=pLmTs+drzWDvyOUvG/Kf0GlftacGemkCbfRh5FtCOQfnHEMDnu6eIJYxxozqD6zB4T
         84wNnySF5c0ANxHyeTM/x3YCzDMNOt+iEZ5s/NpkDnincheo25+uUx5a0rr1TLHG3x/j
         s4jegdh7vHWS4JfyKfrIXLpty1vslIKpuSGNeGRpC4XvHSA+eECOH8QD5i5gw+enm6Ra
         bV6EieWTkwdg80HUdyHr9e3OkQLTxjCkDtninpg/zNLCzR8lIvWaDONTLiVZ4RzNuAvi
         k+hJYBZNi9AVq1p6TGgBDTLEea6hiNo+65nqRdzQpUdnb9gZ87vHIJ+UL+DfruQX+VCF
         35MA==
X-Forwarded-Encrypted: i=1; AJvYcCU4tHDuw2ernwF+yA57vHyVI1iLE3KVD6DJCIBIC+6E54b9GEUnMwSAC7NcwYybH5fVYUHTinGsRKHIt1MKt4PnEBujcCnr1DGj2RWU
X-Gm-Message-State: AOJu0Yypa+AKBnUFQKYjXLx53CHmtlq1X7Bbm7SLcfXjidU1xHo3pG6d
	SNcWMbfMi7BoIRs+Ab7BreI36leqbM5iR1NN7+tQG+CM42s421TTe32KPdy3o0w=
X-Google-Smtp-Source: AGHT+IFyvxaV9n2kU65l431zMDHkO3AYTRqpmWx6fT26Kv0HMX4KdPYahVnwtwSKmypoNUvjILeFFg==
X-Received: by 2002:a17:902:b698:b0:1dc:a605:53fd with SMTP id c24-20020a170902b69800b001dca60553fdmr1110093pls.10.1708919797778;
        Sun, 25 Feb 2024 19:56:37 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001d8a93fa5b1sm2897615plb.131.2024.02.25.19.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:56:37 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 11/20] Staging: rtl8192e: Rename variable CcxVerNumBuf
Date: Sun, 25 Feb 2024 19:56:15 -0800
Message-Id: <20240226035624.370443-12-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226035624.370443-1-tdavies@darkphysics.net>
References: <20240226035624.370443-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable CcxVerNumBuf to ccx_ver_num_buf to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 61d4518dcd7b..4ab4cf6e1197 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -852,12 +852,12 @@ rtllib_association_req(struct rtllib_network *beacon,
 	}
 
 	if (beacon->bss_ccx_ver_number >= 2) {
-		u8 CcxVerNumBuf[] = {0x00, 0x40, 0x96, 0x03, 0x00};
+		u8 ccx_ver_num_buf[] = {0x00, 0x40, 0x96, 0x03, 0x00};
 		struct octet_string osCcxVerNum;
 
-		CcxVerNumBuf[4] = beacon->bss_ccx_ver_number;
-		osCcxVerNum.octet = CcxVerNumBuf;
-		osCcxVerNum.Length = sizeof(CcxVerNumBuf);
+		ccx_ver_num_buf[4] = beacon->bss_ccx_ver_number;
+		osCcxVerNum.octet = ccx_ver_num_buf;
+		osCcxVerNum.Length = sizeof(ccx_ver_num_buf);
 		tag = skb_put(skb, cxvernum_ie_len);
 		*tag++ = MFIE_TYPE_GENERIC;
 		*tag++ = osCcxVerNum.Length;
-- 
2.39.2


