Return-Path: <linux-kernel+bounces-51249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D61D184884B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 20:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6398AB23BBA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862715FDA1;
	Sat,  3 Feb 2024 19:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="HHyiN9Ph"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327831CAAB;
	Sat,  3 Feb 2024 19:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706986902; cv=none; b=nAB+TVv4xcgtmlEgSaYvL48pOv6rWkD3vTP2wyrfiFPmunHW25RSiBkiZZgrXaTFJKhy7ika9/TQRa4MzO/4QBXShiti6vA82f7EE2X5FrU+0tkJgqSsBcpixcBfue/O3gXHNfpxEEJ8LmqBHzLkpZwZ9VGjJJYARR1hCJWLQuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706986902; c=relaxed/simple;
	bh=sq+ZL9RIGh+IbgMjvYUH7r5GPvPemFbYOcFJj+cwtGA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Gyj5KQ8UU5DNK5txQG02YTVxK2W0QNYhRmnl01lfI023RKb4Bay/sesjaHQ71CIZscQwCLDortwFVyNr2HlQXBXlWYVougyILEWpSztoEpciF2MvGleXiqANaYx0KXskiXyVxbjBL0DTCATSOP8oLCu8Eu1j89R7cyqiz6hgppE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=HHyiN9Ph reason="key not found in DNS"; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2907a17fa34so2643225a91.1;
        Sat, 03 Feb 2024 11:01:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706986900; x=1707591700;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yp6fcOVoR5itimDKz/A1G3eeTDdVr/bPXo8LW4dfxhY=;
        b=w09+URq3O87D8OrStS4uB/M5HpAzqolnVvEh3ctZRZeDFu6zLT8czDB3wIvOUF4ubE
         STfsTB2VBPDCTAzJ+HUNF2s6z0Buzxl2zC3bgPm/b3a3sWTmA8624C8ZyQLK5Q6gra0E
         UcotUq/d8LbXz6FWHyBp0Z7AvwtL9Q5Rg1A3S2V5Msl6GQTfNrRIIBzS8CFLR/voO1y7
         bjvf0S3m+ppijrrACp3783f+xtPSrIkASqfPoynB5R9YufvLK8iE6tLq3C7ow3Quc+j2
         4DPNDckh4QXMrp4IB+0l/JojqvqCZ6+MF8FuolbrgZp0dzYL508lsGXgaRvQj61EsgRu
         nQCg==
X-Gm-Message-State: AOJu0YyICXAxSidqtcaE1wcaK2luXxMSNszejiWXB9v5kiRp/xJTgo6g
	5w//P1aI26VzpFsMER+mNIdLpAYCzOAuBS716kLsjrPaLJanzOg4eZezzwgugd+nJQ==
X-Google-Smtp-Source: AGHT+IG+ieRrN3RUCRwf5f/FnOQXyC1Lecvh4O7EyqQArxl7n7y5qzTqL8nv5tlUkx6KrdPrxwGnpQ==
X-Received: by 2002:a17:90b:390b:b0:296:4f52:2698 with SMTP id ob11-20020a17090b390b00b002964f522698mr4184865pjb.20.1706986900477;
        Sat, 03 Feb 2024 11:01:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUpsSmlJ3eYfFT5ML3HVK4RhXGNhjdemGlvL4LWgetkliAY2iB1hmHbdigd4xuSodZ7zwQ4dPuKEyPp/4O03OEQix6th7O2sCYDVU9/9bqZj1+BwvNKki8Gak1E5lIx2FL9jW5s05Fihg==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id qd14-20020a17090b3cce00b00296715e391dsm892365pjb.24.2024.02.03.11.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 11:01:39 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706986897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yp6fcOVoR5itimDKz/A1G3eeTDdVr/bPXo8LW4dfxhY=;
	b=HHyiN9PhRKkSPdTqu6Ob/rXTmebJ8abSaInhmabMy78wju+SvQNQrsX4941OZYXUYkHS1b
	Eci/m1F/PgA4fEsNv3t4YbxPPNu/RoNACDLYYLDo1pQHootfW12J1/E1443FLxJk3cjWaa
	9rKFavvL3or9gzM3yGr0UTZtNZioZGmEcTD7hUgSslL3nQr4SvIEE2j4ut7EjAo6SkUY0d
	iBKXoKHugy2577Q/d+lNpTjGQBJgw2NlDyszTVf7v641JQUQp4eyPLjkLggs5wPlu/Ett1
	xiE2i1LsaaB6vi6xVhL150rATU8vCLAeBFSLbbbhwuWFzy3rXutt6UzLbdg1Aw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH 0/3] drivers: mmc: struct bus_type cleanup
Date: Sat, 03 Feb 2024 16:01:59 -0300
Message-Id: <20240203-bus_cleanup-mmc-v1-0-ad054dce8dc3@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKeNvmUC/x3MTQqAIBBA4avErBMmbRFdJSL8mWqgTBQjCO+et
 PwW772QKDIlGJsXIt2c+PIVXduA3bXfSLCrBomyR4lKmJwWe5D2OYjztAJx0MYMaHvloFYh0sr
 Pf5zmUj4MirxAYQAAAA==
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1117; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=sq+ZL9RIGh+IbgMjvYUH7r5GPvPemFbYOcFJj+cwtGA=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlvo2t8RRZLgsrr8eyok+c2PhiTwKWwpLnrp4iC
 mDlP7OCO1WJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb6NrQAKCRDJC4p8Y4ZY
 pm+4D/9Rbzk8OR2KxeaDCFr+RLq6G/YyO6M1QqDeRrvLyvLrBoCbq2ix4XxLY+TJQU61KgqYXBb
 w3yqKQkaP0Vfv1OJjY5/mrCWbzLGY4Ihs0LuBUU2ZP6FoSiGCuxQmbgXgvCw8njRpFPjlrMkFYg
 iovckU/oKcWBtdAqihlOh4bKHoIo8SsZRuvwbMwuzE4OzJ8yn8UcuH9HypVx+MH9HjaON3wAVdk
 1GIG8Hnrjpp4Aqla37czp5DOSH8haV5/gpplCGbNELM/RNMJoTvXjjpuKbSBhucFuPXgSSsHUpr
 EXeM8dAYQBohMQyWzjKlvfb4c+JESOQdAibBJeOXpST/wqnIiI6MjMS/Qje5zSdYebwh5vfaebq
 R+jXUGvLT2Rffav0OrtbXaiz5dWxSCccfA2vxBIB/jVEKtP7lfjtZbVMojElBczgIhpSIppNCDs
 nBYb93FQC0FUxG+o0UKxH4LoZXPlsXk4CGR7x8/Ui3nakT/60QVC6CW4WjpHXZHdSdGSN57LETy
 ArQOdqCrJIvsOsn5i9+UOye0SdK1YPWqUi1YwD27qNxFTx3uT4GCpnP4huZiam5KgCYjekTi/Jb
 hloJAUs7pRQQGB9ywzCjBe3seK95rkuyJsG5mdE1WfmPd1MSba1Uo8W8kjy8FSmHDA/fVQqSj5L
 DCPuIB6tKPDkmvg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

This series is part of an effort to cleanup the users of the driver
core, as can be seen in many recent patches authored by Greg across the
tree (e.g. [1]). Specifically, this series is part of the task of
splitting one of his TODOs [2].

---
[1]: https://lore.kernel.org/lkml/?q=f%3Agregkh%40linuxfoundation.org+s%3A%22make%22+and+s%3A%22const%22
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=bus_cleanup&id=26105f537f0c60eacfeb430abd2e05d7ddcdd8aa

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

---
Ricardo B. Marliere (3):
      mmc: core: make mmc_rpmb_bus_type const
      mmc: core: make mmc_bus_type const
      mmc: core: make sdio_bus_type const

 drivers/mmc/core/block.c    | 2 +-
 drivers/mmc/core/bus.c      | 2 +-
 drivers/mmc/core/sdio_bus.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 4e99ffb173faaf38f010acb369bff57a20e9e531
change-id: 20240203-bus_cleanup-mmc-008abb80c43d

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


