Return-Path: <linux-kernel+bounces-127006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096638945AA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 694C4B213E8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79BC53819;
	Mon,  1 Apr 2024 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+EFkdRf"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B92351C2C;
	Mon,  1 Apr 2024 19:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712000957; cv=none; b=ZMjt8yBeFLLY7VQDNBA2ulIR5BmTNHFReVDlr0Tje//n9ODwAD30JuvNzLDLeQt0DJf4kjDkD5rbblnbPNGrGioXpBf9w4HfeSa84xy35dKeiC+2X0Alu0jiEJEYdIm5kuwK9yyTXP5xx2iJukFInTQd+7BM/pIPoOPB8LThlbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712000957; c=relaxed/simple;
	bh=WU5u5tSJ02AYMZESgvc/FrHnORzoFJrhI68C/KZILbk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=igr3f+VF9Rc6y3PjwCBWWcWahXgO/uNJ4liV4B7bt4nJP6ZiIRjuffBDmwpxLi1sItrqIBsM/Tf1prqRzWPdKVWXgZmF5VRTUJFSAOs/v9QLKszcVZadxtxUsd/PFNEI4Ko/CPo/bdyKBKNgmPW8/lA8ScIUzuheO0ABj/PsHLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+EFkdRf; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a4a3a5e47baso507445666b.2;
        Mon, 01 Apr 2024 12:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712000954; x=1712605754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vn9GcJIKaMq//B5+hEHlJ9U/1PmsSieGlv6ZmEvK/n4=;
        b=h+EFkdRfIzdU9hWfA7SMB7QS91qy3fK7FHgIg78RpE6DRq5tIfGZxU6y+eNMNc3Es7
         cAuEPmveehPzYdjR4J6NwiQsLFZ+Ntlg4iQGVhc4dkLAowmtD6vwn88VRpzv70Zp2Yw+
         zIgG1fXQyiFq3GTvram9FUbKHguCwTwIFrU/sV1emHyMNlHPpvnhMnQeRL1PDwPNla9E
         SOJ8tE2kulVMI44KIU7XbM3IaFt5i2ODX+b/oeFtVChywaaaIWNnR6FQ1S6zFo6SK6+m
         SOP8i13lXBCJzks4jLRz98h69Qda2dsBVQhjxwCfjnKkB25PW8xTN0z9FrYMROhldW36
         vPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712000954; x=1712605754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vn9GcJIKaMq//B5+hEHlJ9U/1PmsSieGlv6ZmEvK/n4=;
        b=sBhSxF8AlswsBOb8NrIjjMqaS8JxLIHsnmdL3rmpZgql/gmWFG5rJDuetj2EdIhYrT
         RLmIjaAqqV48SFDdnQfFuh/jbwp/6FQU39UzMiKYrYmR6uV3r242g34FmJT5CWt1r3TS
         gjNjNL86vU27Mc5WfhwyjD0OhAqt+1k6eJG+4XcHCS5aBAli1F19c63XAhncq9JuHxJH
         5E4FkJr/aHgaQJ8UT6D8tTOdUMfJxpVg41IkB4gNpjZpUYc9CdUltbQLTxiJ020pKAAo
         MYlcL4JYDDvVEEy4U3Kz9yRaMZop821e4BXPuzIdaL58OMbOePxW1she2GFHfKaskH+u
         8/lg==
X-Forwarded-Encrypted: i=1; AJvYcCUkKVEhoAO9ewTjKjCDfGW+TttAcrW0GXBqEWcjOCAfJjAOe2bhPr4/4MEBJti7Viyv7xLuKU5zWhRxVsPPqm7NPz89CQ9MdMyYX3j/s7rKwB5hI75BSC0NuW+sJ0221OfANu16NT+PmA==
X-Gm-Message-State: AOJu0YxZI6A5bUQVrkU6+I3BIN9Z7uFxk+D2S7hiIZHVmnQ1/qXKM3Bt
	gODT+JMwmPv0I91Dsww34QgZMW6tXxOQRqSlIu4VsyDlJtUmD2rC
X-Google-Smtp-Source: AGHT+IFAf7XIsMYACkXDPtdiCnTGBVpTFxlkqFS+DqQTVODE/AfcKxa92M230y1aU6+AgOKLJbeUFA==
X-Received: by 2002:a17:906:3e19:b0:a46:dd30:7cb5 with SMTP id k25-20020a1709063e1900b00a46dd307cb5mr7972371eji.76.1712000953689;
        Mon, 01 Apr 2024 12:49:13 -0700 (PDT)
Received: from 13a4f82a8f12.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id dn21-20020a17090794d500b00a4588098c5esm5540575ejc.132.2024.04.01.12.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 12:49:13 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v7 0/8]  iio: accel: adxl345: Add spi-3wire feature
Date: Mon,  1 Apr 2024 19:48:58 +0000
Message-Id: <20240401194906.56810-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass a function setup() as pointer from SPI/I2C specific modules to the
core module. Implement setup() to pass the spi-3wire bus option, if
declared in the device-tree.

In the core module then update data_format register configuration bits
instead of overwriting it. The changes allow to remove a data_range field.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
V1 -> V2: Split into spi-3wire and refactoring
V2 -> V3: Split further, focus on needed changesets
V3 -> V4: Drop "Remove single info instances";
          split "Group bus configuration" into separat
          comment patch; reorder patch set
V4 -> V5: Refrase comments; Align comments to 75; rebuild FORMAT_MASK by
          available flags; fix indention
V5 -> V6: Remove FORMAT_MASK by a local variable on call site;
          Refrase comments;
          Remove unneeded include
V6 -> V7: Restructure optional passing the setup() to core's probe()
          Guarantee that initially a regmap_write() was called to init
          all bits to a defined state
          - When a setup() e.g. for 3wire is passed, then call
            regmap_write() inside the setup(). In the following
            core's probe() has to call regmap_update()
          - When NULL is passed, then call regmap_write() in core's
            probe()
          - Refactoring: remove obvious comments and simplify code

Lothar Rubusch (8):
  iio: accel: adxl345: Make data_range obsolete
  iio: accel: adxl345: Group bus configuration
  iio: accel: adxl345: Move defines to header
  dt-bindings: iio: accel: adxl345: Add spi-3wire
  iio: accel: adxl345: Pass function pointer to core
  iio: accel: adxl345: Reorder probe initialization
  iio: accel: adxl345: Add comment to probe
  iio: accel: adxl345: Add spi-3wire option

 .../bindings/iio/accel/adi,adxl345.yaml       |  2 +
 drivers/iio/accel/adxl345.h                   | 36 +++++++-
 drivers/iio/accel/adxl345_core.c              | 92 ++++++++++---------
 drivers/iio/accel/adxl345_i2c.c               |  2 +-
 drivers/iio/accel/adxl345_spi.c               | 10 +-
 5 files changed, 94 insertions(+), 48 deletions(-)

-- 
2.25.1


