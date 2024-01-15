Return-Path: <linux-kernel+bounces-26466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EFB82E157
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82DF41F22D4C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3959B199B2;
	Mon, 15 Jan 2024 20:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t+IsQMQN"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3B418C05
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 20:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bd7c5b2439so578161b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 12:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705349544; x=1705954344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2korMs0kPHmOBV4VWypzARkCOEJYa1AxE8QmV2EhabY=;
        b=t+IsQMQNDzqWwZBRbaBnhluUVYVB6lhTDKu3EranKvuhrMhe9PnykP5Bvq5wENJWKg
         mncz6ugKQaso6/+OikSux36OZpaHluUKTv9yuYJ/SdfCdutTioOF4oVTlwZgeLOfD/yQ
         i2nYF+6BkILkXki6KgGmlOU+cSzRFZ19OX9VLfDWa18skhsJYB6z+R7n2PUaXL5ELAsg
         XRFi3NM0EXxpPRoThC3HSQSacvACuwIkm4ElOw1MM/qHRF26W+CGKiGg/f3hpZVV1Qbr
         7+cQbUNPHk6X9/6ePTggzD1jwL1A9WlYjtW/QJXNKSNDnvY0lbwlyh9+T3unhBH3RoR/
         Yj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705349544; x=1705954344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2korMs0kPHmOBV4VWypzARkCOEJYa1AxE8QmV2EhabY=;
        b=h0rGcy+nPpg9II80Yz3bhnRgQgV823+j9vZCpWCaSfetW7edQlluxnKHk0EGOwTLTJ
         B2nc8mOKKFSYh0oKTbgw4HdVSje4vdeHbbNyXi+wk3x7XFopDzbQCugejF/7MLu/7aZB
         rnMxau0nZFaagW+PT6RwBRNx8tYu5Q9jZO9ybQlQ8HGwH/VLBXQDuh+FpRjDGWeosOPW
         nlXR5hUw1IYlKvloh9LoXKmNJTQGM8KZHKJGK8+mmy5ao4WCTAlEJc+9BNPH6wh+NA6p
         ajIFHDMyJNflCsAyyMH5t4hQT4HD++/44Kx8OCZpEIFQYcIL11gDiAB8pVToPeJF4VMK
         DQ2A==
X-Gm-Message-State: AOJu0Yx6Z1urHnvR5PWD5ZvLzqLZ/LcdO87UXQfffLJQRKwdgL/qiCrw
	UhxrvFaTn7Mp0mzc0EnADWMLvCdlTzobsg==
X-Google-Smtp-Source: AGHT+IGEsAdzR/wJAMs7NwEP1OmKlSony3WQCvmvUfuaMkFAOPapjGXpcSxXN1K3h2Jf6DxqmwkIOQ==
X-Received: by 2002:a05:6808:3988:b0:3bb:c8ef:1c3d with SMTP id gq8-20020a056808398800b003bbc8ef1c3dmr9416571oib.5.1705349544525;
        Mon, 15 Jan 2024 12:12:24 -0800 (PST)
Received: from workbox.taildc8f3.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id y26-20020ac8525a000000b004298b33cdcasm4219170qtn.50.2024.01.15.12.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 12:12:24 -0800 (PST)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Subject: [PATCH 0/2] pwm: add axi-pwm-gen driver
Date: Mon, 15 Jan 2024 15:12:19 -0500
Message-ID: <20240115201222.1423626-1-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the AXI PWM GEN subsystem found on FPGA IP
cores. It can be used to generate up to four configurable PWM outputs,
and includes options for external synchronization and clock signals.
The work is being done on behalf of, and therefore lists maintainers
from Analog Devices, Inc.

The series has been tested on actual hardware using an EVAL-AD7985FMCZ
evaluation board. An oscilloscope was used to validate that the
generated PWM signal matched the requested one.

Drew Fustini (2):
  dt-bindings: pwm: Add bindings for AXI PWM generator
  pwm: Add driver for AXI PWM generator

 .../bindings/pwm/adi,axi-pwmgen.yaml          |  48 ++++
 MAINTAINERS                                   |   9 +
 drivers/pwm/Kconfig                           |  12 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-axi-pwmgen.c                  | 229 ++++++++++++++++++
 5 files changed, 299 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
 create mode 100644 drivers/pwm/pwm-axi-pwmgen.c

-- 
2.43.0


