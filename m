Return-Path: <linux-kernel+bounces-612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24252814387
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A81CFB21AA4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB78012E54;
	Fri, 15 Dec 2023 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5EIbYB7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ADD1548D;
	Fri, 15 Dec 2023 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a1e35c2807fso44471166b.3;
        Fri, 15 Dec 2023 00:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702628695; x=1703233495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NsXOuP1yxztbXsnzImFkfgn1DAayjDuR2ejrUR2SoFU=;
        b=m5EIbYB7S8r0j5EttCrS4JrHkIzjr1N4ztJgL4xkFojtlnCDKLY1z7WmK1WDSk5+7j
         itzRQxsWhJNP9zPH0B0GQace3l+TBFFXWVfrwxxktdvaWjEO8s+a8Ui1GeydCdo+oUG2
         xToA806szBkVfTt0DUrquLm+GRhGJtz40604Mt6AJmXQ1D72CNWCbj9ceXSklQwx6vUZ
         HspdNUXVKuInYMY/vY10FiFEPdHu2RfS39Cnno0KJzFUTgk2ikMu+w6oWrpgq1PQg3Vc
         rgi24yRtk3QyBunJGGl5xeBCZC/J1a5TiYVDT9pXcGL+Rytciv2vyjMYAAU9l8WCQSDW
         dzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702628695; x=1703233495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NsXOuP1yxztbXsnzImFkfgn1DAayjDuR2ejrUR2SoFU=;
        b=BOxNX6cbfBkGTueJRgOVBpVgpkhLgZ4KHz8OCd2FKT/4qvDxFVkSTVnxLkMCbXSRyU
         onISMMRzb2ojGbFDfU1HJfWl47XTGDouaALN/wclXjHzMpbqkTrc0MftB71Q+XwzG4pG
         6KFeB25J/YCjPqUctpBVeBXHHHhJZpFmpcHzISOVr8SnT7ZYyKlx8OubaByD6JHeNf+X
         ESMBl4nwAGmVh0SN6bHqEVMCUPRywtjvmC6AeUCkOJZStBlhltStJMRVyJywBaiGlTX8
         zGh3oYDu5tXcMvhx2vg/gaeyHD6HnOUFBI4V4jRpb0BQXRm5xmzlSPoZSu9i7/5VUE5C
         XsRg==
X-Gm-Message-State: AOJu0Yy+OcPyJpeep/Qr/ZmYqY0C5h6a4WRLguTbhGIA0NWoOXoRvwq6
	pnMIuS4IxgQ11T1GWY+WFoY=
X-Google-Smtp-Source: AGHT+IGxRR5Vij1w/sTHAI9ogMgBB7JhUZ2bFSXZ72mizI5IP4mf7HzD8bmT5HpCln/BVodfP9ynCQ==
X-Received: by 2002:a17:906:474c:b0:a19:a1ba:da60 with SMTP id j12-20020a170906474c00b00a19a1bada60mr4859682ejs.135.1702628694901;
        Fri, 15 Dec 2023 00:24:54 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-59-229.cust.vodafonedsl.it. [188.217.59.229])
        by smtp.gmail.com with ESMTPSA id un7-20020a170907cb8700b00a1b65249053sm10395951ejc.128.2023.12.15.00.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 00:24:54 -0800 (PST)
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: 
Cc: linuxfancy@googlegroups.com,
	sakari.ailus@linux.intel.com,
	laurent.pinchart@ideasonboard.com,
	tomm.merciai@gmail.com,
	Martin Hecht <martin.hecht@avnet.eu>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] media: i2c: alvium: store frame interval in subdev state
Date: Fri, 15 Dec 2023 09:24:49 +0100
Message-Id: <20231215082452.1720481-1-tomm.merciai@gmail.com>
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
This series is made on top of the following series:

 - media: v4l2-subdev: Improve frame interval handling
 - base-commit: 76cb0b74268f1347e4b7fdefc343b064410e0e10

Tommaso Merciai (3):
  media: i2c: alvium: removal of dft_fr, min_fr and max_fr
  media: i2c: alvium: inline set_frame_interval into s_frame_interval
  media: i2c: alvium: store frame interval in subdev state

 drivers/media/i2c/alvium-csi2.c | 91 ++++++++++-----------------------
 drivers/media/i2c/alvium-csi2.h |  5 --
 2 files changed, 28 insertions(+), 68 deletions(-)

-- 
2.34.1


