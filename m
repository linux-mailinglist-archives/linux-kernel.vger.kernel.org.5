Return-Path: <linux-kernel+bounces-117557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D443888AC94
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74AB81FA39CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F6813D602;
	Mon, 25 Mar 2024 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJhdmy0M"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FFF13D527
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386855; cv=none; b=Dw3DPkCvzk0Yyr1upAd2oFuSv8h99/drC4MsGFhR6JNnC84IzIHaRmzh01/46cxGtSXQlXBMM/4gae/vFzZmkvB8Q0kGiLxsxMB95q5GRAYa9jcqZYG1OMdYltJwiBmaWqlabuB6Rf/niTupJvG4G+fvM74lmOn9Dl0Our6/Ek8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386855; c=relaxed/simple;
	bh=bkeP5sDD48wsxQBkk56+ZqBCPj2agvXD72gbBDxPfKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E5KRDdgo2SBmMSFoiRrw+nEl3yrRrKON6YYyJInfujVWosUh62DpONpo9PfyTtJJ3Ek/elz9gy02CqNzF9i9hG3Guwzyk0ppCIisNDrvQed/R9pf2YO2KIg77pS2yJRST3H1PUNgRv0t4CUfssqgYpVIeAbo+fkLgpjQ7ldm3yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJhdmy0M; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-366ac8bdd2cso21512035ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711386853; x=1711991653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rSbkdxxh6gTQxH+/m3hblAGdhy4V4YDv1roCho2fnaw=;
        b=fJhdmy0MIHr/OclmSr7AePrjg347BBFoYzU01KFiQFzpTHTQE6WJB1J5zBjxt/dmM1
         KaSM23MjuQuJEFs5+mEU6mD1X5phcya84FNykeUrb9TgV15hTFDh3Im6So+xj3r9Jxa2
         I9f4XmNaT/FmJ1TDlxhXOUrtok5R6WfFV/ecgsT51D6MWBJqq7PcPGjzhn9kw+ellw+p
         7Afc32T7mB5Jd7GTXGRUmDXctGLTbhKrq8eGWCZ+h0ZeRlDklkrLeDQqh2d7k6NQ10JV
         cysQ1foF3Zcch917YLBS3XK1dHVTahRH/l+EZkNRpLgrTfLK2KbECIxqEUVeF+FMrqgL
         rGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711386853; x=1711991653;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rSbkdxxh6gTQxH+/m3hblAGdhy4V4YDv1roCho2fnaw=;
        b=XvBJ7huOD9MkTO9G5uN2pj8sBWhADCi62sgaA5GPEZmG7Dxyon8XAaC9+mTVmk7YWl
         jgiUq3gNC1q9Gt2Myb5+CGK3uZmPlkc50sO3QR9oE4DU7jsWHxl2nNkTvNqqhGF/iF+L
         Z+NEXlLCAsJWnzHn9Ydbtjy6EK3k0KY4paS3T3iQmAxE8IajGwbY4sIdUB/wnlI8EUV8
         afcC88NGiDWFH0YkCvG2C+8QwCtLOC82q7dcrLJBNvIH24vG74Ta/us25TUlnETYXbpd
         ehG4C9gXb4h4mz1aJxyOeawou68INcXip2+yoXX8wmB8B14fJkX1qQ48EYBrEN3OOpTV
         TEew==
X-Forwarded-Encrypted: i=1; AJvYcCWlFZwVXBI9TWwBRV2nRthl1lJXUE+BWpiisygjUAvZLrO+uZ8Z6wwBS++YKfuIP5X/cLq5NVGN1FPB8ER/sdNS4HxowzdY1jHM/HQl
X-Gm-Message-State: AOJu0Yz5oVhPEKRjSbVdEm0Ue2ys4zfrt7XO/Ot4m31c1vCO0q69+KDq
	LvKfvrxtnTOg5Rel+3vBME+26Hi+IUMrechoa1OgDE/mm84JJnhH
X-Google-Smtp-Source: AGHT+IHSMojcSRK5YMTPHTkFJtuXwtvofR+6Do+4UqVrwzKlW3e5+hTuNcI2HZhXYkvzvs6sSeSj4Q==
X-Received: by 2002:a92:c983:0:b0:368:9ba9:fcb5 with SMTP id y3-20020a92c983000000b003689ba9fcb5mr604940iln.4.1711386853393;
        Mon, 25 Mar 2024 10:14:13 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([115.171.40.106])
        by smtp.gmail.com with ESMTPSA id r16-20020a63d910000000b005dc5129ba9dsm6001812pgg.72.2024.03.25.10.14.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Mar 2024 10:14:12 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 1/4] mm/filemap: return early if failed to allocate memory for split
Date: Tue, 26 Mar 2024 01:14:02 +0800
Message-ID: <20240325171405.99971-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325171405.99971-1-ryncsn@gmail.com>
References: <20240325171405.99971-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

xas_split_alloc could fail with NOMEM, and in such case, it should abort
early instead of keep going and fail the xas_split below.

Signed-off-by: Kairui Song <kasong@tencent.com>
Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 7437b2bd75c1..f07ea0b97698 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -880,9 +880,12 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 		unsigned int order = xa_get_order(xas.xa, xas.xa_index);
 		void *entry, *old = NULL;
 
-		if (order > folio_order(folio))
+		if (order > folio_order(folio)) {
 			xas_split_alloc(&xas, xa_load(xas.xa, xas.xa_index),
 					order, gfp);
+			if (xas_error(&xas))
+				goto error;
+		}
 		xas_lock_irq(&xas);
 		xas_for_each_conflict(&xas, entry) {
 			old = entry;
-- 
2.43.0


