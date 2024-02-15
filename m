Return-Path: <linux-kernel+bounces-67198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF2C8567EF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA641C2458E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44500133437;
	Thu, 15 Feb 2024 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9jEfLy2"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18DB132C07;
	Thu, 15 Feb 2024 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011338; cv=none; b=EY/bKZ+P5VZy+CZBs+HE3eOQqqKv96Gv3x/IGSPEOcFgyaw5RztSMAo0qH3rLYbeqwGpZCnVZxRQVnaMsO6UOD6LYedGSAbHfDPccpyEcifbLOUNndRQUKn70qGvF1Bi5SRv8SFNXK31FMNXRYh0JDZgGOJiAIe0LrhBoYDUNG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011338; c=relaxed/simple;
	bh=1De9ZZYQQqp65uk4VQYOai3rZRFy8ttSFJX+BIrFDts=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iufY6U+DBJlV4RGbSviO8xZJfDV3U9Hen04XvNWL+HqxTZ+dhljYsf8pGmgySDd3cjO6h80MRCZtx9d8uNQ11yZekTQ0gpz9b+1+GhOQ+m4u4Fqk+wF7GoMuvCHwvOjQ921L0m/N2LzCXuybcnVEvCn6BcFFJ9jUodm19cSXkfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9jEfLy2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41222a56492so3959535e9.1;
        Thu, 15 Feb 2024 07:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708011335; x=1708616135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zTS2ct0rthrH4XH9gfrmByuGgoQbalahxU7r6cZcCQ4=;
        b=S9jEfLy28fzGGxuEUIAFjErsc731lsc+VrsXmeSqlTUv7vynurxOksBe7+Xyu0tjYN
         IWPe9ur/pXjb19glpJ/9Y+GHkUfdxjbPpWc2ECZPl7jMCrqH/nIRkKIxXwS7y6y3WLSx
         dc+2HALAJBDibenLf78WMfSGk62/luXqLHblIsVeEzX3TRZI1cidGQFpoVsbYAgpNJgU
         tLr1VFY7JF291wo3RP5IhMXRcjXc2JvSoSVy9C2DW3jyEachdqGmXtWlkzoyQZbYirCr
         zzs3Q7VyoQcaoMIM330Q2kqhMTPX2uMxtAEMrfQGGdtaVxZ2CznW+quWR+gd+DUKmEEW
         StaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708011335; x=1708616135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zTS2ct0rthrH4XH9gfrmByuGgoQbalahxU7r6cZcCQ4=;
        b=E5+eiFWUmmiG5KLWgH5ChMuU1covaCokZRk6ftGY7G3aHgpKcqDM3+Lw6pEfyEdzJY
         eBtTpAaQFTW/OLUerNurKeLd8okoWJFovNXsRca5f5NudGooe9hQcIXyPFRljUocIWjd
         TglaD7p3qg/ewmNw4mH148DxrNcWxLT/dJt9U7ni4/ppyTWZjBUHVHRTIwV4iUQb9Y8k
         chk7MOkFng9HjCYY7ZnjiSPocZv7/zTkb37kJ1VEVs6gEKJtWAqJgWCSALTVrt2wxAzN
         GAQCJAkK34g+57DIQB8AE94BP7s3TJtmvt3Yv3FWmywlT7zz6+TqVfal79VlXfjb7wrK
         Eujg==
X-Forwarded-Encrypted: i=1; AJvYcCVlzE6fwTvpDA+F0MjIi1NETu1ckyfvK/VXooNpefAhQb80xzsLcodDTwolXWuohqHPvE9jTN4GS+rvhqBhmwhJ0MELJ6i3euun//q8Nhm/siN2p/UQmkikz8Of2Q/Zck/p0UrGy7JhkA==
X-Gm-Message-State: AOJu0YybvzS+IRDJL5p0giYQeVNbn/uVX7WHqljHRRVFDmbRuctemla4
	dme2lrXF5X5jB7WPfaIxJ0U1CV0JtKkKWo/xyCh7RXlNi8/22c4p
X-Google-Smtp-Source: AGHT+IGXTilxTdYyXBjjNEWqzltRJV7zx6ZZoySDT4VBp80INjZnfAt7aeD9mYbhZMnj5GhF2WyPvQ==
X-Received: by 2002:a05:600c:4fc4:b0:410:68e1:d9ca with SMTP id o4-20020a05600c4fc400b0041068e1d9camr1553790wmq.2.1708011335081;
        Thu, 15 Feb 2024 07:35:35 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c4f5300b00411e1782d33sm2360530wmq.23.2024.02.15.07.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 07:35:34 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Michael Reed <mdr@sgi.com>,
	"James E . J . Bottomley" <jejb@linux.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] scsi: qla1280: remove redundant assignment to variable mr
Date: Thu, 15 Feb 2024 15:35:33 +0000
Message-Id: <20240215153533.2067413-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable mr being assigned a value that is never read, the assignment
is redundant and can be removed.

Cleans up clang scan build warning:

drivers/scsi/qla1280.c:2481:2: warning: Value stored to 'mr' is never
read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/scsi/qla1280.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index 27bce80262c2..8958547ac111 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -2478,7 +2478,6 @@ qla1280_mailbox_command(struct scsi_qla_host *ha, uint8_t mr, uint16_t *mb)
 	/* Load return mailbox registers. */
 	optr = mb;
 	iptr = (uint16_t *) &ha->mailbox_out[0];
-	mr = MAILBOX_REGISTER_COUNT;
 	memcpy(optr, iptr, MAILBOX_REGISTER_COUNT * sizeof(uint16_t));
 
 	if (ha->flags.reset_marker)
-- 
2.39.2


