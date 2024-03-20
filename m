Return-Path: <linux-kernel+bounces-109290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B56B881737
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 063FF281E18
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7E96BB27;
	Wed, 20 Mar 2024 18:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0y0sftJ"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F9D1DFC6;
	Wed, 20 Mar 2024 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710958250; cv=none; b=rnGubfJiXQ/hIsH7qcuvUxIllVrhPRjGCxyeQupP0Guk8YFqKg2pWf7TsAOfdqHZkvSl3BEpGsG/4oCYBTy8JjnKkHgAhbA9SjA/MLzeaIn1AjK6Du4mwg9iYTthnpJx9ZZpLRyBgquZvDFzX3UB9goMCjAcPCxBDxfYte6e6Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710958250; c=relaxed/simple;
	bh=848BvPcWVF2HeOCahhaa+N1S4L9jNZkkt4RSFKyn3JE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XlnKrfb2pyS83Qdut5QV+vKAZ9QYIquPkj/bZKkDNLevtIg1fNAk8z7vKusfW/th89HwUDTSz5NFOogA+iAi3NAdTGaZ/MFK8SZphlMoF1W2BtJLB6xWHlr9fndjGwTvKrmrxpp62CLb9BdOs5ZiX03ziWKpiL0z/YpVQd4yy7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0y0sftJ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e0025ef1efso486985ad.1;
        Wed, 20 Mar 2024 11:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710958248; x=1711563048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wOSVnh8h74qXknR828f/YsEXGTUbMVRuCYez3A0XkI=;
        b=W0y0sftJroLPXTI7nBDugrpgncuIICXny3NMzKL3Mb/q/1RX8Bu9hEGKwl3XIExd2K
         QRlJ8NnGTwySUykkUjwrm9C08iXOJIhnMLUnPvVxgJVRsNhY3S2aeNuRK8vvsuFkpyBY
         u6vUinhNEM2CTE/i3tUt9+mdMnKZyhj7rxxEqKygdNtlL9xtcPDPZIc3W8a9jgmrlzdn
         +1IOtgILIONsMw7es6hx/xUbsvpBlkaZCkvYcEsAHvbKVDp+UapREBfh8him3X6JroCf
         rEAC8o+3iH0BLT7MGmyZGH+c8o+jTDCxOJ4p/P62Kqyda2h9m3xrPXGdbLHCXFyyPVEo
         GvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710958248; x=1711563048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wOSVnh8h74qXknR828f/YsEXGTUbMVRuCYez3A0XkI=;
        b=p8LKLsthUg/exjSv4oeU+toG4bOFJYVSDEeeLpMrvLUfBdDRtge3u5r4HQqVFA0WhH
         YFdvgqSSgY6UJunjQJWq2S2Nna5Q2vVuz9s48aKkA7xzALpXbWkb3i4WP19f1bLKqrGe
         fIU5SFDE99IBJkUaMmc3SQpIIdIk5a8/2SABbJTyBCXzZm0iZZntDxR/T2fyM7UnGsWm
         gVFzet2HiSiX9UPkNr+BHTkDVHYD/pSgSWD2RExuo32sScDfmMZQfNtM6RKOz3Z9Bu9a
         RBZtTt294WThI4XaoG+ox4t1C5Hgz9ezk9y4qQEA8ABYCQYt8Ozoge1+Tthns8QcolHW
         Bw5g==
X-Forwarded-Encrypted: i=1; AJvYcCWSM4CxHwZB2VZp+9dJJhlaFVjjnwYdKR7WyS+xaxxv3aA9PNWMteLGmjQ6zQxelur0qwWqMx6sdq9LkpMp8sqgC8/Y5OjJBM5iHtu6z36JP+wnEaPHCd18ZstlGWn4e+d3ziQbqxf2Ff4=
X-Gm-Message-State: AOJu0YybSox5fI+AG0bW0YbWbCpYevR3La426coLc20s0ioZsBBXS85/
	sIQn9sw+DqdMw4b/s2fDz4ugzTNnvli6Q1GLiIIxI/aVDZLQ+a5R
X-Google-Smtp-Source: AGHT+IH5KlQLZQNDTUaXrq3NSLSPo+atEeIskKFkKOrkBpYI4cNWqfz39ro+Xce65d9Nj1senb0PSg==
X-Received: by 2002:a17:902:e551:b0:1dd:c24d:4d1f with SMTP id n17-20020a170902e55100b001ddc24d4d1fmr20977195plf.67.1710958248113;
        Wed, 20 Mar 2024 11:10:48 -0700 (PDT)
Received: from Ubuntu2.. ([106.194.60.208])
        by smtp.googlemail.com with ESMTPSA id jc14-20020a17090325ce00b001dd707d5fe6sm13947043plb.158.2024.03.20.11.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 11:10:47 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: 
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [PATCH v2] staging: sm750fb: Replace comparisons with NULL and 0
Date: Wed, 20 Mar 2024 23:39:43 +0530
Message-Id: <20240320180943.3683-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <c4a5e9e8-214a-4ac0-b8ee-01a9e7a1e5f9@moroto.mountain>
References: <c4a5e9e8-214a-4ac0-b8ee-01a9e7a1e5f9@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace '(opt != NULL)' with '(opt)' and '(*opt != 0)'
with '(*opt != '\0')' to adhere to the coding standards.

Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
Changes in v2:
  - Update the commit message to reflect the changes better
  - replace (*opt) with (*opt != '\0')

 drivers/staging/sm750fb/sm750.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 04c1b32a22c5..0391235c5666 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -926,7 +926,7 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 		goto NO_PARAM;
 	}
 
-	while ((opt = strsep(&src, ":")) != NULL && *opt != 0) {
+	while ((opt = strsep(&src, ":"))  && *opt != '\0') {
 		dev_info(&sm750_dev->pdev->dev, "opt=%s\n", opt);
 		dev_info(&sm750_dev->pdev->dev, "src=%s\n", src);
 
@@ -1147,7 +1147,7 @@ static int __init lynxfb_setup(char *options)
 	 * strsep() updates @options to pointer after the first found token
 	 * it also returns the pointer ahead the token.
 	 */
-	while ((opt = strsep(&options, ":")) != NULL) {
+	while ((opt = strsep(&options, ":"))) {
 		/* options that mean for any lynx chips are configured here */
 		if (!strncmp(opt, "noaccel", strlen("noaccel"))) {
 			g_noaccel = 1;
-- 
2.34.1


