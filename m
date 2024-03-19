Return-Path: <linux-kernel+bounces-107121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF1687F7B3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715601C21928
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209EB50249;
	Tue, 19 Mar 2024 06:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2DdFTsB"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D412628C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 06:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710830681; cv=none; b=FXe6XEAp0tFDiov0Yb6xzfOgecKKjlyoLcbA79dpptBA3WdebFD6abbGtuVYe10mJLmmmI7q/7hYhaoTJFayCvWBGL/Wl3eeF/Jhkd/Upl69Wk+9m+5teB6YZIuVxEeuoeqsyuEUFaqtJ8+oe8hBd+gTa+LRWWAO7hRCABuJcTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710830681; c=relaxed/simple;
	bh=G5NXt+isqIKV5SadklumM8eTj8Eic3FZJmFPj3vaZlI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AS8CA3vx+VZVPYu61K/XQjcETiwql6JSXjBaRhQkaafkUReqcNOBHBrUEi3w3ornFY89uFNw0nOEW3NDc1yKuDwRCUrkn7QPPPBNvF3grJpmngRIwItnWZy93/RII4f3IBFdQIAurTzdl1j02+VJYbvz0GVWD2hj86L3JAaKfjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2DdFTsB; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso4316124276.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710830679; x=1711435479; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tD48G5pyPRHERbwtZMvRnORykfrZperd6+wvK2jM03E=;
        b=I2DdFTsBC4Ml58d3z+v+dDNf6Qkni8Qxx+XGi9Tk2/22YjzBIWby8+wz2xQNmXL8wf
         KDR/29vakM4qVJxdG7Nn7qsnHKzzGzAI/cKyI/gVRFLfaupHnxqESyFthx6tpm8kEqrY
         SwJF+CP2Ww99KlpvcwxKCt/lDTTHZEmnT3iHyByZ/4cz/DoBlYzatm2QuuprcxZ0WfKT
         vbJmWYNbMrJzwRhW1ddWXyvAmj5OsoSHFYv3iSivaaN0S3ewCDpbcoMN5BC6WKCFMpLs
         vMSjccYdgfRY/dGshRgxPfkFFmLNxeMBskdaxsrAFaGQAJB6ywsqpWQ8jqN0OUG2028b
         Qrvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710830679; x=1711435479;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tD48G5pyPRHERbwtZMvRnORykfrZperd6+wvK2jM03E=;
        b=k+i7pa9ltgx2QcQGOXem6MlqL6wD7DkGNd4q2dwGvnNbKq+DnREh5xk1HtLA53xSxP
         xX3n3ROurtnWbiZAkzNgDxKSpR7ZNWIm7o6G74/UO0R1vPvWlFQ1Y87aCCAHYEkdFl9P
         CPUqLp2+Za7KPP2rNFx84n3L2bZCNNfcWDpmRMUNRyCTEyNlHo/qXJRKap4DtPo0pfvO
         R4xIi9s+yIjhE2zTF7WdIgMe9pE+WyVStv3eU3QxpGIeGen9IeQ34G9fF/iS8PfTsw8c
         YJTMdj1SluRK36nUY524/2KDxdCORyuR+i1utl8jn533sywVZ+G9rNBTQn2EALFp2FyO
         eylQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRCIix0LRzQl6c0vE/vdu6hSK1zOWhSZLlp7KsMDb020Um/AD67fyvbUSo97U7+S5Ye3TP4LGfsdySt/fsvOckpT4NtkcU/tBC247u
X-Gm-Message-State: AOJu0YzoLqf2294wEIqX1/Qwbf2LBJRnNuZ07H8z3CqtslO6nNkAsdCZ
	WuOe3CHiopY7Ryq5jb4s+8oJfmFjI820HU9hzYuDS4/fpLISnjtBaN0UxgB/mRw=
X-Google-Smtp-Source: AGHT+IEjtFw6MADKGJ5daCrR6LVa+5tNozEx2auo/2thb69w8E4TPzHkXW0YnW8lv4NVwDwW7HfTVg==
X-Received: by 2002:a25:868a:0:b0:dc2:1f53:3a4f with SMTP id z10-20020a25868a000000b00dc21f533a4fmr1169119ybk.5.1710830678851;
        Mon, 18 Mar 2024 23:44:38 -0700 (PDT)
Received: from MOLeToid ([102.244.37.246])
        by smtp.gmail.com with ESMTPSA id hf21-20020a05622a609500b00430b74c1661sm3994884qtb.97.2024.03.18.23.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 23:44:38 -0700 (PDT)
Date: Tue, 19 Mar 2024 07:44:33 +0100
From: "Felix N. Kimbu" <felixkimbu1@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: outreachy@lists.linux.dev
Subject: [PATCH] staging: pi433: Correct comment typos in pi433_if.c
Message-ID: <Zfk0UfLh3rRf6qDv@MOLeToid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Correct typos in pi433_if.c comments to address the following checkpatch checks;

CHECK: 'interace' may be misspelled - perhaps 'interface'?
#13: FILE: drivers/staging/pi433/pi433_if.c:13:
+ * HopeRf with a similar interace - e. g. RFM69HCW, RFM12, RFM95, ...
                          ^^^^^^^^

CHECK: 'ebedded' may be misspelled - perhaps 'embedded'?
#71: FILE: drivers/staging/pi433/pi433_if.c:71:
+ * so we have just one rx config, ebedded in device struct
                                   ^^^^^^^

CHECK: 'reenabled' may be misspelled - perhaps 're-enabled'?
#650: FILE: drivers/staging/pi433/pi433_if.c:650:
+                * irq will be reenabled after tx config is set
                               ^^^^^^^^^

CHECK: 'pendig' may be misspelled - perhaps 'pending'?
#926: FILE: drivers/staging/pi433/pi433_if.c:926:
+               /* during pendig read request, change of config not allowed */
                          ^^^^^^

Signed-off-by: Felix N. Kimbu <felixkimbu1@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index b6c4917d515e..81de98c0245a 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -10,7 +10,7 @@
  * devices, basing on HopeRfs rf69.
  *
  * The driver can also be extended, to support other modules of
- * HopeRf with a similar interace - e. g. RFM69HCW, RFM12, RFM95, ...
+ * HopeRf with a similar interface - e. g. RFM69HCW, RFM12, RFM95, ...
  *
  * Copyright (C) 2016 Wolf-Entwicklungen
  *	Marcus Wolf <linux@wolf-entwicklungen.de>
@@ -68,7 +68,7 @@ static const struct class pi433_class = {
  */
 /*
  * rx config is device specific
- * so we have just one rx config, ebedded in device struct
+ * so we have just one rx config, embedded in device struct
  */
 struct pi433_device {
 	/* device handling related values */
@@ -647,7 +647,7 @@ static int pi433_tx_thread(void *data)
 
 		/*
 		 * prevent race conditions
-		 * irq will be reenabled after tx config is set
+		 * irq will be re-enabled after tx config is set
 		 */
 		disable_irq(device->irq_num[DIO0]);
 		device->tx_active = true;
@@ -923,7 +923,7 @@ static long pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case PI433_IOC_WR_RX_CFG:
 		mutex_lock(&device->rx_lock);
 
-		/* during pendig read request, change of config not allowed */
+		/* during pending read request, change of config not allowed */
 		if (device->rx_active) {
 			mutex_unlock(&device->rx_lock);
 			return -EAGAIN;
-- 
2.34.1


