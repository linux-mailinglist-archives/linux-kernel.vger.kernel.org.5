Return-Path: <linux-kernel+bounces-56436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D34E784CA21
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B421C250E9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A2759B6D;
	Wed,  7 Feb 2024 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HENe6pA0"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2153859B54;
	Wed,  7 Feb 2024 12:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307404; cv=none; b=YzPkFSSjqcS4HF8Hb0eJddhE30qiOWobszqzagoGjufNLOyE4jPiPXEDi1fs1kdsQlBNNIPBX/JcNTRtSvVBm2HQW+04mBCtJOWFJ33QnpmRp1SA2DTUxChS1xiKKm9KTLWjuyqxlYXv32FC2AQq1qHMzrYt4UnjNDKS3Ob/sVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307404; c=relaxed/simple;
	bh=uReOIAUr3yxIpe3V/+0Z1QbKOOO0Li8w6pbjd5rWadM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=F8dKr3eSGxFLYAdLS6KFsY+8YvK97n7qupD3bvP1Cug1ChwuRRB2V+2vqq5HCn4O83n5gs/IVIt36w5k9wpRm4qaE61sgXtdIo6FVhR+vwEWQC9fryg5pg5NGVdh0i4zrsCf7M9IbeetYxbLH6fdc9iCnTJ/xpC8gimOcQhx8Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HENe6pA0; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33b28aadb28so415131f8f.3;
        Wed, 07 Feb 2024 04:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707307401; x=1707912201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mQGin1dTgZWE68jPKB5i3Z1XPabW/tMTQJ4NouFdDP8=;
        b=HENe6pA0NBpO+l+JNgQW37HbDDOvyyqe0UcVWwEeRDHVlUrGQ4WD4iTr4pMmWM0x9b
         S9SA53S9Y7SzWucntCpRKczkN/APJNkLFA2DKvs5DpSjDQmHbRjYyuoa87vE5CfN7a8M
         E4yLNrrhcOXfBN+BUr1nwYUEGk8dYen43KBDY8d1xBoBwVUrcEDkQwmhYZoyjzlX7Vfk
         qGONRGIOOyM1Ca1PPcVvHkvajXPaOg2qyaVeTINS0yDjim+cu8lAlfSRaAGLepxeLTYu
         JHMRWyw59MYikX+ptP70oVGR/qYsvAqZUSofHBXQHxUjHdwvH9llKJBJW4TP7D7AttrY
         rBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707307401; x=1707912201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQGin1dTgZWE68jPKB5i3Z1XPabW/tMTQJ4NouFdDP8=;
        b=r7QiBkTKL8PwahOSvGBa7jpZuVmzmgqsctutrhh6AShQYEdhlFSq+QrTzl3Wwujpf3
         gYzoRWtfzy3QpHszlfyQyerXUNRd8sMTpeo2c3tfTrEWOlEjZsTFRAYqVW8c8uDv4IPy
         ZJkWfRT5hBe0oUaUZYUOpZhJgA7FddiJ3S+GjDgUHAuwu+08rV8KAm4DKQzV5HxMPDq2
         nLfT8C/nGe4njReFfO53eTwufO0u3B2trxCE7AuTT7coTQs3kdIAcUvTylVmQil6ExkO
         CMwOTxxo4l5nGGnUmYGA0G3kh6Lx76E7B9DUcbxoMNtOzUEUo/PMinkLXRPaOhZnJYpQ
         ik1A==
X-Gm-Message-State: AOJu0YyLS1Jt6nRTzx6A2tnFvxHwIltmJwqJEDJbiH7zHG5WMKa9bX1H
	YdjVPSWMlXAjJhTwL7v7CZm6PHjf5bR1BDZzSkJ5++MWoIMwQEH/
X-Google-Smtp-Source: AGHT+IGQtfZ92Xdh3R8wY/pBqwf8Y1LmilebBMiQCFtTVWT8gKQNkK8GSJng9MSP9/MbliBN+Zg+sQ==
X-Received: by 2002:adf:f3ca:0:b0:33b:26c4:ca3 with SMTP id g10-20020adff3ca000000b0033b26c40ca3mr3185263wrp.22.1707307400899;
        Wed, 07 Feb 2024 04:03:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXez9PNj+4Sh47lOny7j7IfJx7AlwS8BY1LUaLBPsFCyF3uFlyFO9Zm1f/x6a0eYcGtgEBaERydvsubvgcJIwrznw/4gH5ZG03ip60+Ke+aF97kwx31myaxjwy3RHQXvemBZDVjs8Ba+EDdiWIvSpZjoYLuiUf09ZJvo5aRkfT5SiYFf9JelRwjrloxqDtx9tWqAXBC0WkSEeQQFw==
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id g16-20020adfa490000000b0033b50ed5f98sm626338wrb.72.2024.02.07.04.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 04:03:20 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] usb: dwc3: gadget: Remove redundant assignment to pointer trb
Date: Wed,  7 Feb 2024 12:03:19 +0000
Message-Id: <20240207120319.2445123-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The pointer trb is being assigned a value that is not being
read afterwards, it is being re-assigned later inside a for_each_sg
loop. The assignment is redundant and can be removed.

Cleans up clang scan warning:
drivers/usb/dwc3/gadget.c:3432:19: warning: Value stored to 'trb'
during its initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/usb/dwc3/gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 564976b3e2b9..6e47259f2c4f 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3429,7 +3429,7 @@ static int dwc3_gadget_ep_reclaim_trb_sg(struct dwc3_ep *dep,
 		struct dwc3_request *req, const struct dwc3_event_depevt *event,
 		int status)
 {
-	struct dwc3_trb *trb = &dep->trb_pool[dep->trb_dequeue];
+	struct dwc3_trb *trb;
 	struct scatterlist *sg = req->sg;
 	struct scatterlist *s;
 	unsigned int num_queued = req->num_queued_sgs;
-- 
2.39.2


