Return-Path: <linux-kernel+bounces-47000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F16408447BC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD6E286CB5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9C03717C;
	Wed, 31 Jan 2024 19:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaB8JCQk"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDE63613E;
	Wed, 31 Jan 2024 19:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706727827; cv=none; b=H6GJISbsnI/QybB0R8jze0QrlEqJXyum78dVPgEFHZGOVORuqNPjVive3PEYCt8j8jfC6PA6TRZiIVuBUAj5zryipReLDjXnTxjoymfFffjkGVtpLhFTKUKbbLJmoO1rov46nfDaFjvSPuzUqpQkUqzaZNELX0yS8JYfU+98vqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706727827; c=relaxed/simple;
	bh=UXmrc4wHW1CYloxZDq3S33BFNdKy0XymGy38w6L2Lpk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gDVqclDyVtaowCWBEUewQz+cw0z1PaKgE3SR+lmME9etpG/TtaBZS4uCI6jk97J+Ua2IasxD9F0Hc44jvTqfyl5ftEcuATit3LqXIJAgSlE2MkE3RT07Wq48sPDPt51icccu6lqqEDJ1XrHVlY8rk/u3OWJGKQv6KNP3Jg7vl2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaB8JCQk; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d057b6df2aso2321061fa.3;
        Wed, 31 Jan 2024 11:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706727824; x=1707332624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uCHcg1JGhJ1uDn0/KCMDkISefHyEiFXm2OiWCo3MPgk=;
        b=YaB8JCQkbrytj6fAYLEnEcgzz7LT/WlZF5qrgL288Ef3iRNlh1F44h1x1WGQdGZBuc
         sCQ4fCjlN1KCaYZppcYIQ2LD6YrC60OYAcUC2/rn9oJTAVJAxbOys/ab9/mAYSPE0phl
         Ew3+IpP/YTfhyuIfFjJLcRcxeLpkCKMXiH/F8rae2VtdrJ45HKlpIhbDIohxoVfGibNr
         S4kcyLzulFYZlxMiiStMq6m/z5TQHar4xH+WNOu3nGJmnH1kTt0Z0S7qi0SlBi/uQeiw
         nPiU6ok9Ks1sxXShH/S9XKWhZ05ncGWkAtPNnMCfVaLbl/qUsPZHBWQCVb7EM9s9ziaK
         FOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706727824; x=1707332624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uCHcg1JGhJ1uDn0/KCMDkISefHyEiFXm2OiWCo3MPgk=;
        b=nGO7RAmw6/WVgZGd3+YgweBMFCdPhEOMtymcx6VGsnhL8BqWtiFarcBozl168QSt2i
         iJcEC1sBfZNgsOjYw67Tf2u5fIOZWV0eC5QjYXkFYmHfKDYXyXrOwJD6XfDHxlq5mLZV
         HwN/YP83CKWcDx6zh4B05bODQux4EFyPnH61UO1HeygYWf9zDuGUrSaEIKtZ2wyfUt7r
         oVwiM+dvOAlVM2Pv1XfVfXeW/WSNbgIhfkL9YmfwMvQvlcxDD1lBKbKF9Cqxtj9VgBNA
         YOTUKnaH4RLSK1DkNisFT7EnVrwSBOJZYMNCGRb5oQ4lncoVlkvL66OqyFhGvCvL7/bv
         rAlg==
X-Gm-Message-State: AOJu0YwxwnEckRe9Xuuz1nEBKcINveMMrlg5gzO5sGvVffRqEvnnj2ap
	8cjSbfMolKIVGN6Np17UgW+5dHOSN8PK7XezXYa84CNoB18O8yde
X-Google-Smtp-Source: AGHT+IFxO0UJx1CWcR7R0seQ2GoGKXK2HU6HjdCH7+nqBD0RdIAd7Gm8gdPifuWXAJwepiEiI/HaSA==
X-Received: by 2002:a2e:6817:0:b0:2cf:159e:d401 with SMTP id c23-20020a2e6817000000b002cf159ed401mr1766472lja.36.1706727823354;
        Wed, 31 Jan 2024 11:03:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWkQyUqdEVyHuJ139U8yx76A/GLneo5P9W85xtd5CCIfd3DqSQ4Ikxmunm44Hp49LxHm3OsbPTFNoJgxVNoDByQyAyVDphTVCfjV49UQSAwks61TGDzBZDE4pTcFZScDLFoZas2EMzzx0D3b2NLVJpd8XZW4DvQaGHXL74N1TvBFqKV18ef
Received: from localhost.localdomain ([77.222.24.25])
        by smtp.gmail.com with ESMTPSA id n2-20020a2e86c2000000b002d06a953a37sm323870ljj.138.2024.01.31.11.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 11:03:42 -0800 (PST)
From: Andrew Kanner <andrew.kanner@gmail.com>
To: mcgrof@kernel.org
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	mchehab@kernel.org,
	Andrew Kanner <andrew.kanner@gmail.com>
Subject: [PATCH v1] module.h: define __symbol_get_gpl() as a regular __symbol_get()
Date: Wed, 31 Jan 2024 22:02:52 +0300
Message-Id: <20240131190251.4668-1-andrew.kanner@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prototype for __symbol_get_gpl() was introduced in the initial git
commit 1da177e4c3f4 ("Linux-2.6.12-rc2"), but was not used after that.

In commit 9011e49d54dc ("modules: only allow symbol_get of
EXPORT_SYMBOL_GPL modules") Christoph Hellwig switched __symbol_get()
to process GPL symbols only, most likely this is what
__symbol_get_gpl() was designed to do.

We might either define __symbol_get_gpl() as __symbol_get() or remove
it completely as suggested by Mauro Carvalho Chehab.

Link: https://lore.kernel.org/lkml/5f001015990a76c0da35a4c3cf08e457ec353ab2.1652113087.git.mchehab@kernel.org/
Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
---
 include/linux/module.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 96bc462872c0..8a660c81ac3d 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -299,7 +299,7 @@ struct notifier_block;
 extern int modules_disabled; /* for sysctl */
 /* Get/put a kernel symbol (calls must be symmetric) */
 void *__symbol_get(const char *symbol);
-void *__symbol_get_gpl(const char *symbol);
+#define __symbol_get_gpl(x) (__symbol_get(x))
 #define symbol_get(x) ((typeof(&x))(__symbol_get(__stringify(x))))
 
 /* modules using other modules: kdb wants to see this. */
-- 
2.39.3


