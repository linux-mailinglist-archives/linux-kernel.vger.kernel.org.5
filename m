Return-Path: <linux-kernel+bounces-6906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8617B819F33
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B47C1F280E0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CC525777;
	Wed, 20 Dec 2023 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUGt3Roa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752D224A00;
	Wed, 20 Dec 2023 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a23566e91d5so461544466b.0;
        Wed, 20 Dec 2023 04:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703076025; x=1703680825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tansLYwKFrwLf+FTBCmiECyWjLm6vQt3tnch7uslfG0=;
        b=gUGt3RoaipSL0PMhRDOozYfUmlv1jUnIcwym+mTd2AqFONvhUuKwvFvDOgs5ryrOTL
         DPbJ1oNSvBqmZKPAUqRvn4JtM+zC3wajw2XXXd2U/ur7Kj/gdFg6WhqkB++GLcaTnaq6
         lS7UV518LHX8Uo4eReAHgK7FFxQaS5YcZ9ROql88vWNhJXuwCHlLzmvzloANvcYikgQa
         B6vXNoksGA27Jc7LBDve0cC9yCer44fjMK7KBn2PqsvvA9+gHA5EGddPnjLzhAioPprG
         jb2pdOOIRbF5/9JAaATUAu1kGvL5Z7zWeokHvF5zZZD06lyRA8jdSdCZLqXY2NACGs/9
         gWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703076025; x=1703680825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tansLYwKFrwLf+FTBCmiECyWjLm6vQt3tnch7uslfG0=;
        b=LJZv4KAPRYXdd2lBrNhYrXH4ntSt7/NIdmC0eQx9OEkUaQr9Mv79o69k3k6jlJiSG0
         uyJRaALcJLI1BYUvl1Thn5L17icOmCnSFXCLwxfYviX/J/Uil/D4tup9WLjc5r2R42eF
         ySKbvDkbNKbanqTlJi4x96JXZgQtah322o5V9XeQBoQXe3bbruyhRDvb9ACHQV5Y4/nf
         1gUy0Va3ofhSDP1KxRBxGUy2nNRchY3KWekpiMSYteANHih4voUKZfat+e4KnH6I6y52
         JZifSEzotvPjzAr4UsLO6pcCo6GwhMF7XatzC5IXav2HYjGIc3bT+l1TzmInCWq595Cd
         ukHw==
X-Gm-Message-State: AOJu0Yzny79NxZt4bK2HP1Awf5M9qlYyVxIWbQfU6TRp6DMjVLP4Hc04
	RUlFMpmOmqSpzqa3mjhAAQU=
X-Google-Smtp-Source: AGHT+IGAzHYJmCoHWI+ZVA6KiXxUehGqZeDx4TkgyZsiHKe81VkKBiMyPzaLTxwxuD2OXjZ4r7blgA==
X-Received: by 2002:a17:906:20d4:b0:a23:3571:6c8b with SMTP id c20-20020a17090620d400b00a2335716c8bmr2180336ejc.123.1703076025439;
        Wed, 20 Dec 2023 04:40:25 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-59-229.cust.vodafonedsl.it. [188.217.59.229])
        by smtp.gmail.com with ESMTPSA id d22-20020a170906345600b00a269597d173sm604258ejb.135.2023.12.20.04.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 04:40:25 -0800 (PST)
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: 
Cc: linuxfancy@googlegroups.com,
	sakari.ailus@linux.intel.com,
	laurent.pinchart@ideasonboard.com,
	martin.hecht@avnet.eu,
	tomm.merciai@gmail.com,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] media: i2c: alvium: store frame interval in subdev
Date: Wed, 20 Dec 2023 13:40:18 +0100
Message-Id: <20231220124023.2801417-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,
The goal of this series as suggested by LPinchart is to remove the following
data from alvium_dev struct:

 - struct v4l2_fract frame_interval;
 - u64 dft_fr;
 - u64 min_fr;
 - u64 max_fr;
 - u64 fr;

And use instead the the newly added storage for frame interval in the subdev state.
Last patch fix req_fr check into alvium_s_frame_interval().

This series is made on top of the media_stage tree[1]:
 - media: i2c: mt9m114: use fsleep() in place of udelay() (02d4e62ae245)
 - [1] https://git.linuxtv.org/media_stage.git/log/

Tommaso Merciai (5):
  media: i2c: alvium: removal of dft_fr, min_fr and max_fr
  media: i2c: alvium: remove the fr field of the alvium_dev structure
  media: i2c: alvium: inline set_frame_interval into s_frame_interval
  media: i2c: alvium: store frame interval in subdev state
  media: i2c: alvium: fix req_fr check into alvium_s_frame_interval()

 drivers/media/i2c/alvium-csi2.c | 99 +++++++++------------------------
 drivers/media/i2c/alvium-csi2.h |  5 --
 2 files changed, 27 insertions(+), 77 deletions(-)

-- 
2.34.1


