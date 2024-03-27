Return-Path: <linux-kernel+bounces-122071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B51988F181
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2186B28708A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D4E15382D;
	Wed, 27 Mar 2024 22:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzNNJva2"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343BC4D9E0;
	Wed, 27 Mar 2024 22:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711577011; cv=none; b=BeWynPowygltL7vShmg63WqHWbMVXWXQ/S3EsC0LBjzdO6EHO7MFOgSjXC9G0beaVQKbBjL2E+lLSgWy8pca7cQMAoLux8DQ4tRZE10W/wOGOj91DzN9RyV5XmQdz+808boFXVejMdz6KFJkRWB+AbcNAOzbF/K2jFlpp9XMsnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711577011; c=relaxed/simple;
	bh=j53l+GvKAPdnIX1BckO4bg1drYoWft8IfMCuuSOoyDE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H2JOrZ6RO8U9SbNtKNDGbxvHjDxfwv27AvhS2GIWoSCC47xTpCBlMWjtGPWpUeydCTV8JrjFTnHB6Aa8YOZzIogIaAAn1ckF8wuHuaWpMXZZsoE5bSWPqK+9Tt91fdXgcPdAzEx/aYbzFdQnLE1yICEfUBXjeWN1poG88YHW3so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzNNJva2; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56c36f8f932so2509334a12.0;
        Wed, 27 Mar 2024 15:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711577008; x=1712181808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I1GBPmfs3bhJTC55lBOTKGh8dw8HVPSM/uJNzfrpKUE=;
        b=BzNNJva21pP6orQs+eua/cvRg2KSuMe3nnRqp3hVmXtXFjkmVvMWy7EQxwq4HGQs5Z
         ZMxWax+J8rrmto22fF4TOQcc/fJ7b9JfSIOLNu56NObobFyVTp1o7Z8bbWEJmibqpsD+
         KmZWKbjwo6WZQyBiPUsL5pCgkiv73ThQ5hVDyePqCHhTXxPJCDlpzZg0AOIOvEIdeqh2
         D7o4f9aToktCa0MFzTeq1mPoLlg8V2PUoV3LaWldPCo4sx3ZJ0334yF1KxEdZq2w9jQG
         FVfqJ8xrN+Y6+FsjjnGHLyMYkaw2K2xUe+qa6+NEj5CEYrQeXwk2UQmMNw9GSfK5M6wW
         gQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711577008; x=1712181808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I1GBPmfs3bhJTC55lBOTKGh8dw8HVPSM/uJNzfrpKUE=;
        b=tZ3kjaW7a6vNzwrA+bD5dAn+Ry1abPuNia569v90Xs7JQ/mV9U/xlcAlgfimopw7GL
         pSAQymrrYJwgyXYMSJzZGBT5ILbgu5KHc7+F/pt0mmEjSHIx9GSlqBxCv4fAkzH4OXk2
         mSPgXsduiAbwbg6V7sJQDHSqYHJKLyWR8h6FGzGHOkHNi3MHSzo38eVumf+E49q2eoLA
         LwHyQ51z261ujMiUW9Y7dxcRgzDQuTcfpmzN0OdWB7q3SbDIF+oK+0cKA0HtxesRS/eu
         nihs2kuZo1qmcdlXLPSMlaU1PO8Eu4yG400UTwSf/DddWYduQEwNlzvYD+sCO2sW6z4p
         G1FA==
X-Forwarded-Encrypted: i=1; AJvYcCX7lW6EO1yarZoayWlhyGxKy6gvEcRZm9XqEPYomPHlEzdVxsTYN5eFKUQKxLPsNZ0QMws+7W2DmDzBNUAdXpeC6HoIbBAWiW2gAq3wUVzqHrBv7oR3NUz4c2R32uWLNHi4bsFr6UDElA==
X-Gm-Message-State: AOJu0YyFOgca8qu+artQrjNAMMNI3E4IOdCS8Xe5iIJEaAB5WiFH8erE
	PScr3rEZpYUUBZHfpTTLJM62o9ZhewmCFiMvzzViWwVwNH/3JSlP
X-Google-Smtp-Source: AGHT+IFc8xXfweUHqWwI5lssC7UiSLQmIRSGrpkt1taVivSKzLwOB/+BN8A43gYIc/vRO9tFR3P+Ag==
X-Received: by 2002:a05:6402:2691:b0:566:59a2:7a10 with SMTP id w17-20020a056402269100b0056659a27a10mr631806edd.1.1711577008421;
        Wed, 27 Mar 2024 15:03:28 -0700 (PDT)
Received: from 51a0132e405f.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id f25-20020a056402161900b0056bc0c44f02sm59151edv.96.2024.03.27.15.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 15:03:27 -0700 (PDT)
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
Subject: [PATCH v5 0/7] iio: accel: adxl345: Add spi-3wire feature
Date: Wed, 27 Mar 2024 22:03:13 +0000
Message-Id: <20240327220320.15509-1-l.rubusch@gmail.com>
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

In the core module, then update data_format register configuration bits
instead of overwriting it. The changes allow to remove a data_range field.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
V1 -> V2: split into spi-3wire and refactoring
V2 -> V3: split further, focus on needed changesets
V3 -> V4: drop "Remove single info instances";
          split "Group bus configuration" into separat
          comment patch; reorder patch set
V4 -> V5: Refrase comments; Align comments to 75; rebuild FORMAT_MASK by
          available flags; fix indention

Lothar Rubusch (7):
  iio: accel: adxl345: Make data_range obsolete
  iio: accel: adxl345: Group bus configuration
  iio: accel: adxl345: Move defines to header
  dt-bindings: iio: accel: adxl345: Add spi-3wire
  iio: accel: adxl345: Pass function pointer to core
  iio: accel: adxl345: Add comment to probe
  iio: accel: adxl345: Add spi-3wire option

 .../bindings/iio/accel/adi,adxl345.yaml       |  2 +
 drivers/iio/accel/adxl345.h                   | 42 ++++++++++++-
 drivers/iio/accel/adxl345_core.c              | 62 ++++++++-----------
 drivers/iio/accel/adxl345_i2c.c               |  2 +-
 drivers/iio/accel/adxl345_spi.c               | 12 +++-
 5 files changed, 80 insertions(+), 40 deletions(-)

-- 
2.25.1


