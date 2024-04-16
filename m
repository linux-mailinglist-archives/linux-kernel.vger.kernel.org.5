Return-Path: <linux-kernel+bounces-146566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA7F8A6755
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1B62846EF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6D78613E;
	Tue, 16 Apr 2024 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0jxs+WR"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650AA85264;
	Tue, 16 Apr 2024 09:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713260631; cv=none; b=OpoCRn9HfqTJplJ+rpAj2SuDj6GHBcqL0M1Ez+6xyBv9wsz3t02fHvh2R7Ym7XzDrcjeIm6yTNGQTzSYaMIDLmpuADeij8opyA63HcGjjA4c7B/z1LOS2s+P9xtJC8eaHS+0bYXo0r/upDYOZSm9vHOgaQtwbZlFCfBY4swO2OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713260631; c=relaxed/simple;
	bh=zw/gh6JtsY9ahuDnizAgH7coJD73tCZ7P1tEqZpUDGI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LHtvyq/H48vbbAZ1WpqveuXDFeQblyH7gaopP84CCpUslKEzXRM5JuglVWE+RVZ4BPhH5wR+9LmuJklyUQwysy1o+YdGBVkLkeQx0Xjj+daPYK4bBFv7lFoYk76tVWZrtHpJ1MTluZpiPsGlBMvFXBiGIJOF7VFpjjQSgBmatcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0jxs+WR; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-22f01274622so2734792fac.1;
        Tue, 16 Apr 2024 02:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713260629; x=1713865429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9DllWJ76FBZEhv3u9UAxesBln/pORMSfmMEofhmOq5U=;
        b=m0jxs+WRCitfxvbrcM47wSW7P3ZwaEw/TN36u39bh+jRECvxfcq+6K58UGuMWH6jG8
         2jD0KsspMKd0/W+6qoklk6nxAEHc4OyXTWf5nFKMlLiOCT66Y/ZONVaHEdbkjHEisN5P
         gqpwyQKQpXqkyMAg0KZLINoMPdSqnE96yV62SZnO2nzK2fu5o21ZEOYPhV7RmvBplBRg
         SRkCLpTZh38lXNDlpVHfRodqrEfEGjUg02JjUqPwao922AQ0GNxm5wshOAO7oGgqdfHi
         /yLn2pgiSJIezdTmzqP8mHnr6QIeMGg/sCqjKNwHBfFPLFMG7e8XKvTaqiYhtTf5pD/B
         k/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713260629; x=1713865429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9DllWJ76FBZEhv3u9UAxesBln/pORMSfmMEofhmOq5U=;
        b=WjAc81Kdq8ZpJV8mYF9oeArb6k9eBZXwD9W1PjKSqz+0YotkM7eRhkgS3G6m6XS+oh
         bajlOSYljQbTGIQTv4qLTFom+7ts8+CCXzF4Ebi0zIGOtl+KvRjk5926T/Ag1tYUHuzS
         QXcpETJg2K+JS/VA+1DTIYNjCqS7A6BmA4lTyk0OPzlFOOLM0N2dO/MXo9SoumhcDrqn
         QgVOx+u1fjI1ZVbqnS4uM/nzNNrQomdUnfnJU9XSj7OW8edsyVjgwb45OLbcsTXhtYPZ
         OtjeRhUdavSYOEfZoA/gDeg3xwl37aK75kjGbtcSCWHdFvuzk6aZx7O48BZwDZwOOiYW
         ClOA==
X-Forwarded-Encrypted: i=1; AJvYcCVBt77ryJuNccIi1dw7Zori1gew2qM1dAjCo9wG0fRDUm2ehKWQxJnpWYM5MxCxVnF5e0QW4yzmGEmvvjASenyEnK263mCawzue+V9q4UyYcECL4+ISJKUih0H28EOLYo/L9ngtmHTp
X-Gm-Message-State: AOJu0Ywd5yRPmxYwJQ+rRljl/2nGupkzxJ9rwbFjbPXtUbd8rAGLxXjz
	9148ES0WWrexqgFiISpVG8bMX2RdavD0vaYOia6sKuKdRNJDGKvU
X-Google-Smtp-Source: AGHT+IHN8shxPc/hD4V4Meq+wRm1k0hfg6Ub2UORC0Zt3Bx86kzNkZhwE7N0TClBgjL8JoyK0+s3Aw==
X-Received: by 2002:a05:6870:9113:b0:22f:7513:f20a with SMTP id o19-20020a056870911300b0022f7513f20amr15119981oae.55.1713260629412;
        Tue, 16 Apr 2024 02:43:49 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id wz2-20020a0568707ec200b0022e9ffdb5a5sm2684701oab.24.2024.04.16.02.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 02:43:48 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jszhang@kernel.org,
	dfustini@baylibre.com,
	yifeng.zhao@rock-chips.com,
	shawn.lin@rock-chips.com,
	chao.wei@sophgo.com,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	tingzhu.wang@sophgo.com,
	guoren@kernel.org,
	inochiama@outlook.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH 0/1] mmc: sdhci-of-dwcmshc: enhance framework
Date: Tue, 16 Apr 2024 17:43:35 +0800
Message-Id: <cover.1713257181.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

When I tried to add a new soc to sdhci-of-dwcmshc, I found that the
existing driver code could be optimized to facilitate expansion for
the new soc.

Thanks,
Chen

---

Chen Wang (1):
  mmc: sdhci-of-dwcmshc: add callback framework for expansion

 drivers/mmc/host/sdhci-of-dwcmshc.c | 185 ++++++++++++++++------------
 1 file changed, 107 insertions(+), 78 deletions(-)


base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.25.1


