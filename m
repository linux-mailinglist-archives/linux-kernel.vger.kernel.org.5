Return-Path: <linux-kernel+bounces-6488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DCB819984
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E3941C2139F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430ED168A5;
	Wed, 20 Dec 2023 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxc0UfeT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FC216406
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-336746a545fso231625f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703057510; x=1703662310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yq6Bcsuc5MlXjEIx36z56GKOXlqotYEdXwHNI48DsT8=;
        b=gxc0UfeTWg8fBeimPb6abtSLeKwVuSnjIU4KYAtOwF/GtHsDTRs6jQPR2szneFuOls
         0YNOU+1jXlhTckTYQp+r3VQxpsbtkG/BZ9/nrzHlx2cxeCVso9rCpU/duozh+lAwRZPC
         UuNBRttW9OIXMytpFtN8xU8u+IyGHMwQFkTvht11q5OKXoLOyNj48vjXkJCYyvDnY+wI
         rWRhU3eDTe31Xb3Rq/fPH0ILas1Fsad4jJKIcYfVjFDeHuAlOP8QvWnF8B82IOCCmg0C
         Pd4JZDZM8xYOFvSVPbYjsrZoS+ydjqtbqUwuM6zyPPDGwRUnifCoDolJEEYHI6A5elUC
         wHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703057510; x=1703662310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yq6Bcsuc5MlXjEIx36z56GKOXlqotYEdXwHNI48DsT8=;
        b=CD/11GFhdQmJbdqLoj3oNsh2jFUcAmp8RE23XbwSmMz0KFmYU4WkO+NZPMw/rHh6FV
         yiFcxZ9bO6whYWS1Iw+SSqAprg4CtOTweVgUml7DnThIcjje+ambntIyAKW+McDnhkRH
         AfwAge2BbcOXqLYEkHqUGpdOhJy5iDWhKxCArOMVLu6vEh4mp3u91aDDzZB+dh7Z84AS
         UiyPWVOWBty0mQlMIZC5tvmhtMsyh+zGEav+6HtiVw4pRtyedkuwvcozTfz5Exm4S3tG
         fgXugP9X6TVCtWdCnB48l5NhPE/W2o2+D+y1l5Eu4qxDVaho/bxez05CUKMNz6BQh/Yh
         e2VQ==
X-Gm-Message-State: AOJu0YzG+RoumYSyV9tcjyO5VMcfxOOa2dAwZB7jNDgky9aLL7rIV9S+
	Trp/sjNd6GzwSYUxhtPixHFyhYTQA9Fp
X-Google-Smtp-Source: AGHT+IGK2yW04y1UEhwj12UpuF8e4O/v+8eUb8A4hRxe9m5GSJYutUI+SDxKJ0sHwCq6ZHdwMgfdGA==
X-Received: by 2002:adf:e58d:0:b0:336:7229:d152 with SMTP id l13-20020adfe58d000000b003367229d152mr1105187wrm.2.1703057510150;
        Tue, 19 Dec 2023 23:31:50 -0800 (PST)
Received: from alex-pc-ubuntu.lan (31-10-153-16.cgn.dynamic.upc.ch. [31.10.153.16])
        by smtp.gmail.com with ESMTPSA id q16-20020adff950000000b003366a9cb0d1sm6348461wrr.92.2023.12.19.23.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 23:31:49 -0800 (PST)
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
To: lee@kernel.org,
	linux-kernel@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	hdegoede@redhat.com
Subject: [PATCH v1 0/2] Fix LPSS clock divider for XPS 9530
Date: Wed, 20 Dec 2023 08:31:46 +0100
Message-Id: <20231220073148.19402-1-alex.vinarskis@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dell XPS 9530 (2023) uses spi-pxa2xx with clock-divider enabled from
intel-lpss with the ratio of 1:32767 (Dell's firmware bug). This caps SPI
controller's speed at very low value of 3051Hz, which makes the interface
practically unusable. Since either spi-pxa2xx or intel-lpss should have
clock divider enabled, not both, and SPI controller can have higher speed
than requested by the device, it is preffered to disable intel-lpss
clock-divider, and let SPI controller handle it.

Fixing this issue directly in Dell firmware by setting lpss divider to 1:1
would've been the ideal solution, but is unlikely to ever happen.

Particular driver already implements customized solution for handling buggy
ACPI tables for select Microsoft devices. This patch series converts it to
a more generic quirk table, and adds a new quirk QUIRK_CLOCK_DIVIDER_UNITY
which forces clock divider to be set to 1:1. In the future, devices with
similar bug (if any) can be easily added to the same pci id lookup table.

Aleksandrs Vinarskis (2):
  mfd: intel-lpss: Switch to generalized quirk table
  mfd: intel-lpss: Introduce QUIRK_CLOCK_DIVIDER_UNITY for XPS 9530

 drivers/mfd/intel-lpss-pci.c | 36 ++++++++++++++++++++++++++++--------
 drivers/mfd/intel-lpss.c     |  9 ++++++++-
 drivers/mfd/intel-lpss.h     |  5 ++++-
 3 files changed, 40 insertions(+), 10 deletions(-)

-- 
2.40.1


