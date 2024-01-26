Return-Path: <linux-kernel+bounces-40146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEB083DB30
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E9501F26285
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DA01BDC0;
	Fri, 26 Jan 2024 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFshnpDA"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61601BC2B;
	Fri, 26 Jan 2024 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706277154; cv=none; b=oRXDI3i0HwPT+Z0U2thkFeGxQ3pQR+WJKuQPuSIgB2RLCAD03YRTIWYEsE9LRKGkck8k7bx3SX8DvdPwQ0RrQaoLrYEraLDlJohyJ1CcbBl+ICZ9d1HDzbU7Z9RD0t5xtwjFPdpc0iTwdUlkVOxJCLBrNa9mw+2wLXbXKBRd2sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706277154; c=relaxed/simple;
	bh=NJ2zvDpRugpkOrPns2BIpOKFHbVlIVZkrcOBbNNo1hk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ld53+jEbBLFtwvI4nxiAwWGtVrhowukeNpWMOR9XlH5sHx8l6jeIUyaxeTebOYxn9Tq+K1Kz320afCYsmmGsZWoWLthQwjNF6KMe94DBsS3F4akjRP6f5bB+S7CBAxGqVKPd4rKEijm+zFhdMQcMtf4enZA/NaGrDdgyWr2GiUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFshnpDA; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so197703a12.1;
        Fri, 26 Jan 2024 05:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706277151; x=1706881951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rM8zCIVBjxeUHvmSaQvqLI0p0Y8zROjJ9BiceQqTpqA=;
        b=jFshnpDAkJH8bYk70sxbwrhumx70xWcLQlCPMUzqurtovPxPDtkET9w7xZ3eqbv5q+
         XctgyuvBdY8zYe5WAOPDhzGxMsVVdwjSmbQdMbahcU/NRPmRbcQd/i2nKLPovDerY0+k
         MfaZpdyFkfIEDQh1DwFvmqV4iMxGO4t3bLASQyFf9Z7jPhzy2VoKkHaNVOHdwJT7NivI
         tXHgf2krnp2kovTZcPddW7WiOObfZONEal1jYNxOP8uaShtJJfebtgymNQy6eOfLsRYv
         0+Znzf4m8oPtj+AEjv0niCmhc04TwZ1FUlSuFSKNnlkvpSREFhDR6FGC9zyfEoQ10oAr
         n7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706277151; x=1706881951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rM8zCIVBjxeUHvmSaQvqLI0p0Y8zROjJ9BiceQqTpqA=;
        b=pC0OYu8+5WAHtgL5a+QPTwMEj1+otdYN/XnkIz4FHgrq04wAcboak/Z9ctG43FouGK
         BXe1WhWifduGU7mIQFh8wmEP/ceaw+UqATNV8SjfVNQOqAWZ7eAXYZQTtmKbV/uwT5x+
         So4nRZXpNQlbKQ/ofHk86ohLFwVgnbQULSk053Zbbv8WRHGv1YUukWnCQQbsCeDb6LvU
         SohD2VaqBzUvxkdsCJP5W2qKd7csdcGCNnLZWAVNDTpdKv3aS23i4rLOdBBFhbRJFVa0
         DruZ1/hPTQeOlH/MrJbDEJVdtMKdNp1qkOSjPkPJxjRlU69wUSdMYkdrg8251LwHL2Ne
         QeOg==
X-Gm-Message-State: AOJu0YwJTSatsZc9jQ6p1MqMvziJQ71TXLzXaKG4ydUD04N7lIznmvXL
	E6qropPejQMI1DnuxzoM/hRRhfrnl+saxFDHVCVG1JqU5UMCwJv9
X-Google-Smtp-Source: AGHT+IFPw83GR4tLxRryzpGA+/cOpSMPSFWnHVENe+DragFoiq0k4DgaivyQMTnXCNIwMn7cZH8o0A==
X-Received: by 2002:a17:906:3b90:b0:a2f:db4e:c4c2 with SMTP id u16-20020a1709063b9000b00a2fdb4ec4c2mr509182ejf.67.1706277150688;
        Fri, 26 Jan 2024 05:52:30 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id gx28-20020a1709068a5c00b00a349463a4e9sm650685ejc.187.2024.01.26.05.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 05:52:30 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Li peiyu <579lpy@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: humidity: hdc3020: fix temperature offset
Date: Fri, 26 Jan 2024 14:52:26 +0100
Message-Id: <20240126135226.3977904-1-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The temperature offset should be negative according to the datasheet.
Adding a minus to the existing offset results in correct temperature
calculations.

Fixes: <c9180b8e39be> ("iio: humidity: Add driver for ti HDC302x humidity sensors")
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
Changes in V2:
- Added Fixes: tag

 drivers/iio/humidity/hdc3020.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
index 4e3311170725..ed70415512f6 100644
--- a/drivers/iio/humidity/hdc3020.c
+++ b/drivers/iio/humidity/hdc3020.c
@@ -322,7 +322,7 @@ static int hdc3020_read_raw(struct iio_dev *indio_dev,
 		if (chan->type != IIO_TEMP)
 			return -EINVAL;
 
-		*val = 16852;
+		*val = -16852;
 		return IIO_VAL_INT;
 
 	default:
-- 
2.39.2


