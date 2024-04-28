Return-Path: <linux-kernel+bounces-161617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CE48B4EB3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77B991F2220B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AD747A64;
	Sun, 28 Apr 2024 23:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="eaqGwmB2"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1D13BBFC
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 23:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714345278; cv=none; b=aYj8d7iQNTPD89Z9dU67IgrDP48C0dVZeeqSV22wWyGhZA4shM38Qt+XNE+ZxRcS/i17f95+Y5T0r8iYpRHQ7jQ88bBXT2LqBHzft75q+9Vxqp86twppGk+jAKRn1Xho8uWsKRWwzeUHIEuzpQEeVyMfejzk91QtnAhaXJ5GDN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714345278; c=relaxed/simple;
	bh=RPSLZBQ1MeEJKoB2Xj/0zC+pBhTogLhHUxLxgc2kXJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IA1EhnIKy9Qq3707gKZ56UiBKjL9JViv5LE6sn20bfku6SFRfy0yBdlnZevAaV2FzRlXDAkK4WFSQKDmwQiKoKVE8oHwwrJeuULyxt0tXx0y8GfkzgaNL+38WeerYkVSSqKfJFzhnjhT0J24p6GAHARItQ2/LyxKWCIz07f3h/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=eaqGwmB2; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ab1ddfded1so3459723a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 16:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1714345276; x=1714950076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZkXwXrzxvU1FhwauQRCc2N6ZVAq4y5Wr93P+/dn7+w=;
        b=eaqGwmB29PDllM/WQ7k/kybjHTToQR1vxW2AZqlg73ONE4MJk8q87axYCBdbpviPX9
         bng8Wh99arm7nYFF2xGHzmz3kiGTGEcPzy8QZ0C5xckZ9vdJNB1gkUNEp22K/kJdWUp1
         vPSogJZ7HDW+qNmmKSJigcTQk0CMEsM2KM8RPoUcYjdfYs/NRAO2gY0hm0qI1HB+Klfo
         VCB5UgaRgOCGJG84SLx1Lmd9MfC4pPUa6aYuai3lcquvPlR/qpDGLV+PEzwkXSHXazSz
         FJKOtM7IlyvNUHAMkkFfaHmd9zAdPYbv7Hw/NytSGoyPrVRSxQmxkXFfhws7AcNUHcPl
         DgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714345276; x=1714950076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZkXwXrzxvU1FhwauQRCc2N6ZVAq4y5Wr93P+/dn7+w=;
        b=oLHP+tTpIxPRhS3JN2bZWk5k3SRDjcPJejZ3K2UGI4QWOcLnQOtXek7pvUDZjGkUW3
         lkUyI/LfVPaMlClHuJbxOIdJttmoCVgzvlcAqa85uAW3p4LVeksZ9lLyoMRbw55INXGC
         oRpvOtfMkieR5SKCl/khAntkMaYMDZi0fmeoRP3m7dW/fFxi9TI1aklxGJ9xPCWb0UOK
         RWELM06UcZNmyw6Eu5pF8YloBSTsH5fdUjE67dWvicvx/BcRLBOkvidR/XjzvJD9Gmh5
         J+T7BllJW0xSm2AQ2k6hpPQlL/JryqTcsPxTQfQJTy/R27AVaMl9M5JYTjEImT8rmAFo
         acVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgSyKNTZpcsPyXOHpXaub79SsJ2cZuJX7rXlywpHjQd7BNm+bphKNUzlsVSil1NardB1g1HgkN5C0VTHFqxOgq3m9jie6WN3JOT6NA
X-Gm-Message-State: AOJu0YwvbxMhmC4S47x0ASdtpDo84V76Kt7dSjy5DjVDn93f80nkVOSw
	dx2/NbFcXG1UIIrj1ipGh8yG2V80s34cmsoHulesTbT+KwPqV8lAUiT+XS5CDSE=
X-Google-Smtp-Source: AGHT+IHplNZD1AVkefkHTdwYtekFVtk57nirYWDiSEwl5Io6IDzWc3KipvwL+gu1Ga8lMqZdsUTO6Q==
X-Received: by 2002:a17:90a:628c:b0:2b1:d11c:ca21 with SMTP id d12-20020a17090a628c00b002b1d11cca21mr637186pjj.40.1714345276722;
        Sun, 28 Apr 2024 16:01:16 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id o16-20020a17090aac1000b002a27132ac02sm17860864pjq.2.2024.04.28.16.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 16:01:16 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 11/18] Staging: rtl8192e: Rename variable TxSTBC
Date: Sun, 28 Apr 2024 16:00:59 -0700
Message-Id: <20240428230106.6548-12-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240428230106.6548-1-tdavies@darkphysics.net>
References: <20240428230106.6548-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable TxSTBC to tx_stbc
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index b9f50d195b13..bd66df620793 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -30,7 +30,7 @@ struct ht_capab_ele {
 	u8	green_field:1;
 	u8	short_gi_20mhz:1;
 	u8	short_gi_40mhz:1;
-	u8	TxSTBC:1;
+	u8	tx_stbc:1;
 	u8	RxSTBC:2;
 	u8	DelayBA:1;
 	u8	MaxAMSDUSize:1;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index cf3536fdefbd..d51a0daa9196 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -262,7 +262,7 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 	cap_ele->short_gi_20mhz		= 1;
 	cap_ele->short_gi_40mhz		= 1;
 
-	cap_ele->TxSTBC			= 1;
+	cap_ele->tx_stbc			= 1;
 	cap_ele->RxSTBC			= 0;
 	cap_ele->DelayBA		= 0;
 	cap_ele->MaxAMSDUSize = (MAX_RECEIVE_BUFFER_SIZE >= 7935) ? 1 : 0;
-- 
2.30.2


