Return-Path: <linux-kernel+bounces-52887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516D7849DDA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B159EB22440
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468272E40B;
	Mon,  5 Feb 2024 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2VWjqL0"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E282D043;
	Mon,  5 Feb 2024 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146439; cv=none; b=oAkKpDVMNjvPNtNxcw1vtH5sSoyeSfZ9VO3jad8PBL6MAnts8XDu/ARLkSngP503eGImsGOOpPKu2kKseZx4LcN8QMyQmFGckv9B34Oa8uYhz9WPcgFDaRXEjir+7iuQ4aNhygrJTb5gKiLhGOxq9bv2nn+sRyF4iUT4KD1c1VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146439; c=relaxed/simple;
	bh=GGePl5eiEEdPNRh0+sAveAROhsr1GXVAVnMj8eHt2vg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PpEgxheu7iEryG4U2sgAy1nEPYzlBIjgv9psKREYHfSOWwHBVakfVvEkHcVfbGNo+PR9Jbind61vNLlG8A7IWlymLfNMqi3kjg2eXVg4vo3IBRRj+5gJPqV0uzz2TsFjMWzrFdiJtjC3o6VrIJ571U0y8OJ3Bt6Mp2lZi+RK61U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2VWjqL0; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d953fa3286so31654045ad.2;
        Mon, 05 Feb 2024 07:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707146437; x=1707751237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=giwgZ4wcf6FmR6qMTFI58iXdRxoX8Uci/OXHw4NZoHQ=;
        b=W2VWjqL0JIzc04Fr41o0uVYOEoN8cWBFr5PGCo78LTJVRKoO2/TgBSu634jgbhU3BN
         w8sk3mFJJY7P4gdD9LWSMn0EopZDmqmNf0avb/4R9wHKGT6IR1eWJ4bvNvKgpdjXMohQ
         vLzH8v921YlQZx1pwIcIQy2VPGNZlPckvq2jnXSnSgn/nKrA3LNSbHp2dF5tZvUjbmcz
         nN9E5N29mUOAQyJJc8lnMMwr0rkOs4om1CkoWTUeb9TZc8ffP9GS94/LaKs1LyLM3d/l
         ckD/pi5czQ8BiKbaGsxksIqAcI7e9/czqDQr2ey2nuLkl4WDkshrt1uenRcUGXis10J7
         yw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707146437; x=1707751237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=giwgZ4wcf6FmR6qMTFI58iXdRxoX8Uci/OXHw4NZoHQ=;
        b=KUtWnzucjYbBx9aOxr81n3Gjn1tFUYOyr61JscUl/eYgbtrZ0U0aihwAnc6VbtmwdU
         2VLNLZRCVoqEUIn60IAg7N91soc1EFCpZXJHPY5sSGEhoihGC0MKt8E2Lb7oSDgFuLgT
         igBwjc6Eot0CbI+9ECbuSLRggmtvodvSuTVAb61Pu64R9omzQ9Wv4oXtrWZgKB2BvSQQ
         wcO3IAH2x+kXvA07sxzxJXt1PDPLytud5E9sFlGIxtfFD4colHas/7E8C8wBhF6/fk3M
         M860ndbfzqbA5ndaCz4VBj4GrPycRA/vvzYJa41EBLPR+udV46xY+9IqRKDuT0bm85/k
         r3BQ==
X-Gm-Message-State: AOJu0YwbwUWUXdzLd5xdFJkmj11hc+pmj6dyg1ljj8ZKOeZl6Ol5NtUo
	fYnCnaVFzR/YHZM0LFoL0E74NKbpczuksGj6qE4mkOVc/FfTVcbE
X-Google-Smtp-Source: AGHT+IEGDYq4EfYGE4WQ4F8P9Y0pgjjFCa9OC7ZnaM6cBq6r0ynZIrWRaWacoH1ZFzR7YC4l0OPhEg==
X-Received: by 2002:a17:903:2452:b0:1d9:af94:9f3d with SMTP id l18-20020a170903245200b001d9af949f3dmr4584960pls.28.1707146437351;
        Mon, 05 Feb 2024 07:20:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVVS1ti89jiT+X2JZbru4oYtoPXaIhsjbjD6tD25wyERqoX7j2hmQYsr9b7lRt4x7Z1wmVaSCiLCgfjHZxgzdVOjH1/JLISqxgz3VjBzg1mpsFQkLy1m/njZTEN7YkP+QFH+vt37Us0awOIhEtXXEgJtWZmYxrlAEMJrew2LHFdTd7VN0tNpi6XtPM5gdDgIjcLtOmtQojCdjCgKnxRQqQDYTBBF2NQeJ1QC+EKbaDudVtlGm96Ah7sOfzPveX46nyNzu2mz5Jpz8oTFGTi+4aTqdDdQi/1HASqctE1bV29qLl7OzxP5vmog1BlBRwy+tqQ+c9iNpvcFH38Cp1YUKxkLG+noQW1Gerg4es/i1RcyZGZuc7x8WVsiDrL4cMWcMri+1znqJ3tpag7K/RxbmIwAKAvfATwwfP0hHjCNoRAHxtESSZ49XEdpNXhgUmOpJrZFC+OiUS/jukXlOr+J2DiOnvtKCnSxLWfV56g2FBx8AOewnM9MDVuwWlPbxOGnXTM+e9I5jlUg0d7stWUFU+j6dZ7dVsmsl0+w9iCy1DvS2y5WTfGU7Tmt4annA7LtWpenBWggENppwj/vn+qJrz3wJWMvrP6r6rJngKtJTglgOub9zRyFcfu4JzkJ+f4k2P6CgnrvzWYesEv6MjMjYnfICpzZsYKRRWpi14hzWjcpfIWL9EOYPo0+r6GwhhJh2PAI4RxebuUmnPWnTD5UrTdgutacjZefthZ9JPRhzTjJcQx4xWtRaZSJmVXDhsDwF/J+EXETnROz/siE1Fq3Wh4PcGbiMag8sdt38vi5TuBoaS3cNTDNWtsubiOq8V3m091LbJcvw==
Received: from cosmo-ubuntu-2204.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id k21-20020a170902f29500b001d94a3f3987sm6444393plc.184.2024.02.05.07.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 07:20:36 -0800 (PST)
From: Cosmo Chou <chou.cosmo@gmail.com>
To: linux@roeck-us.net,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	corbet@lwn.net,
	broonie@kernel.org,
	naresh.solanki@9elements.com,
	vincent@vtremblay.dev,
	patrick.rudolph@9elements.com,
	luca.ceresoli@bootlin.com,
	bhelgaas@google.com,
	festevam@denx.de,
	alexander.stein@ew.tq-group.com,
	heiko@sntech.de,
	jernej.skrabec@gmail.com,
	macromorgan@hotmail.com,
	forbidden405@foxmail.com,
	sre@kernel.org,
	linus.walleij@linaro.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	chou.cosmo@gmail.com,
	cosmo.chou@quantatw.com
Subject: [PATCH v5 0/1] hwmon: Add driver for Astera Labs PT5161L retimer
Date: Mon,  5 Feb 2024 23:20:12 +0800
Message-Id: <20240205152013.3833940-1-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver implements support for temperature monitoring of Astera Labs
PT5161L series PCIe retimer chips.

LINK: [v1] https://lore.kernel.org/all/20231205074723.3546295-1-chou.cosmo@gmail.com/

v5:
  - Fix warning and check messages of 'checkpatch --strict'
  - Without resubmitting the applied patches

v4:
  - Rebased

v3:
  - Revise pt5161l.rst
  - Revise the style of comments
  - Remove unused pec_enable
  - Add back safe access wide registers
  - fix build warning

v2:
  - Add "asteralabs,pt5161l" to trivial-devices.yaml
  - Change naming PT516XX/pt516xx to PT5161L/pt5161l
  - Separated debugfs files for health status
  - Revise the style of comments
  - Remove unused defines
  - Remove including unused header files
  - Remove unnecessary debugging messages
  - Revise the data parsing for a big-endian system
  - Use read_block_data instead of accessing wide registers
  - Remove the debugfs files when the device is unloaded
  - Add acpi_match_table

Cosmo Chou (1):
  hwmon: Add driver for Astera Labs PT5161L retimer

 Documentation/hwmon/index.rst   |   1 +
 Documentation/hwmon/pt5161l.rst |  42 ++
 MAINTAINERS                     |   7 +
 drivers/hwmon/Kconfig           |  10 +
 drivers/hwmon/Makefile          |   1 +
 drivers/hwmon/pt5161l.c         | 673 ++++++++++++++++++++++++++++++++
 6 files changed, 734 insertions(+)
 create mode 100644 Documentation/hwmon/pt5161l.rst
 create mode 100644 drivers/hwmon/pt5161l.c

-- 
2.34.1


