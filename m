Return-Path: <linux-kernel+bounces-82691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E757586884C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5384DB2554E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8359754FBA;
	Tue, 27 Feb 2024 04:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="U0XII7cv"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772E854BC1
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709008933; cv=none; b=rzdP1IT55hhGqbvTsCuBKxEl19P2CgoIFdmqL2cZ3lnqiOssX90S8yutLLTzGJ/bNFrEsZsz9XQ6AA7BmFlMsNHhWLsJw4vp56fujRSQz8tshbTSXE2LuvIQRFZxkyVGzheavmwrtsTQxnWnZEXSjBywguyajmagFCUpwqBbwAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709008933; c=relaxed/simple;
	bh=I+aEcppQ4MzexRfR6gl9QtKT4yGqbNUgp/gFvY5km84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ABllGNUo4nsm19XotKmZjvRaRGQlx4dEEv54mSxSuYvyedpYlWgdOxMnkab9zsepPdc58pHse7XM+T3hUm6FxpqGlV2JRNGTBk0EmiLnvzP8rvmame/uyuaYAqtQdHZ8N9YaN/3geYxfLY8IHBmfjdygdtmf3y7JAwFjzfyoN3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=U0XII7cv; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3650ea7f7d3so7781175ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1709008931; x=1709613731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmDzivMUGF5BY5Dmmv3uETYHPmN1bUF8ybnEjd+639w=;
        b=U0XII7cvxWIbitV1V/AVGDJxQmrS1sLwLjSSPQwQbCAOjOiaRk71Zu4U+Rxvwdr8Cj
         fRM1prVR0smNaxDOPqyjU2UyW73r1ZneIqLsNqEfW1aWjnMkbwNfU7hfxive5KQRRG6z
         dw8kCtr3Vnbjt2ly40RU+lkzNIm5p/glhkpwwVDdsBBywNSmIEc7hQ6vMADTrvVFvcM9
         Jjfb9VsK1m4ZsfXitBS87A/82VUtgbTFCUH+0VQO2qA5YR4KH4YByOlpbvhY2q5lnJrq
         5EfdkctK7djSCFEHglRaoAIXt1F2kRqmTDe3a0B/AUWzqANpg8oh79j+MIOi0Uck8+OA
         rWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709008931; x=1709613731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AmDzivMUGF5BY5Dmmv3uETYHPmN1bUF8ybnEjd+639w=;
        b=aDwIu/OyFWvBLs2WyHwSK4oy2KUYzd2ocqU+wUdzAB5f+CKwY+LRvHFntx58iT62gp
         sWMDzOERZfBgqtT4wPum0PA22Zqi70rWUyIQ0t+UrWqElACSXR2Owo/26fBlB7eRXKOY
         DYa6xsEXt1HHMNJLOcLvEgjLwYzqrE6IH1hb89GV/1LxTjp6JP9SXFWMcjeiEIFEqJ48
         cq6PZTFWnH8MMhFP+2WmIAiwXZAcYMc1ReQ9kW+7UMJuf734i10HuIgaMD9+Y4sGPLbj
         8yylAAuio1V5yukIHMnlJOEk+uYlxRsClA/m2gBDEmHtpIOtCQvujWEhB+/KQRJxo+ZD
         sxdA==
X-Forwarded-Encrypted: i=1; AJvYcCUGbkx6YxcGvauEthH6FkHo2+ODqefQQ003n3oPvpYObANbwDfqoGB7WF3WnrMxJ2fyPoz9nnKbQWQGRHo+T8L5W5YVvi6v6dCqT6qV
X-Gm-Message-State: AOJu0YydIDjb81bSxuwP00ZoU8+3KlXtW2/b2PsVVw1G90UWSVlnetwE
	eyeV2CTWcdjx0A/8L4NsQyjrXfhkqdcE+4lTvhx9AGKpkEs7YfgFkCEIvqDhBGs=
X-Google-Smtp-Source: AGHT+IHYNOCnN33B6wYz4ZzVNkCh+AGdu4lPAErutB++OYPwnt5SOwTpGhjNFdgxQWxcLoy9oaonBg==
X-Received: by 2002:a05:6e02:216a:b0:365:259b:711e with SMTP id s10-20020a056e02216a00b00365259b711emr11005508ilv.5.1709008931691;
        Mon, 26 Feb 2024 20:42:11 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id e30-20020aa798de000000b006e4ecc3e394sm4899782pfm.79.2024.02.26.20.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 20:42:10 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 09/20] Staging: rtl8192e: Rename variable CcxRmCapBuf
Date: Mon, 26 Feb 2024 20:41:46 -0800
Message-Id: <20240227044157.407379-10-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227044157.407379-1-tdavies@darkphysics.net>
References: <20240227044157.407379-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable CcxRmCapBuf to ccx_rm_cap_buf to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: no changes
 drivers/staging/rtl8192e/rtllib_softmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index f5e0741af047..477d736fe22d 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -838,12 +838,12 @@ rtllib_association_req(struct rtllib_network *beacon,
 	}
 
 	if (beacon->ccx_rm_enable) {
-		static const u8 CcxRmCapBuf[] = {0x00, 0x40, 0x96, 0x01, 0x01,
+		static const u8 ccx_rm_cap_buf[] = {0x00, 0x40, 0x96, 0x01, 0x01,
 			0x00};
 		struct octet_string os_ccx_rm_cap;
 
-		os_ccx_rm_cap.octet = (u8 *)CcxRmCapBuf;
-		os_ccx_rm_cap.Length = sizeof(CcxRmCapBuf);
+		os_ccx_rm_cap.octet = (u8 *)ccx_rm_cap_buf;
+		os_ccx_rm_cap.Length = sizeof(ccx_rm_cap_buf);
 		tag = skb_put(skb, ccxrm_ie_len);
 		*tag++ = MFIE_TYPE_GENERIC;
 		*tag++ = os_ccx_rm_cap.Length;
-- 
2.39.2


