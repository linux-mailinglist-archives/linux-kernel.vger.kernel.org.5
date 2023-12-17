Return-Path: <linux-kernel+bounces-2570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46391815EED
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01BA2282C37
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEC332C80;
	Sun, 17 Dec 2023 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4CFEQ3k"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F14EADB;
	Sun, 17 Dec 2023 12:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-551c03ae050so2162096a12.2;
        Sun, 17 Dec 2023 04:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702815642; x=1703420442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6xMyvQ0D0+nEZ9Gai87Uhvht57Iu3iXC8pPekH44If4=;
        b=M4CFEQ3kVnOPO0sqWQWu+rNURTI2SFCcyN4fKjpIGstSQemT0lZJQi0BBA5GLP8ti7
         t9qVrWBhkAkjUzi6+pN16FzGqoJjM4i66rFPp54IxzP1uKWvl0z0WLxKKULdnceUCU4W
         K2+cmqx8ZnC5mqSOD1FtuMQaopgzgUh6FRBZ4TOsy4XbdqW19oeVCp6p38H+UekmfNia
         VmKF9uaBOAeJCRmdfm9lq5K7TZcd5pFbR8JbodO3/e7eE7pbQFmsktav/vWAGG+G/59R
         cZO+wQfdxgCCTxs4bBPb6b/JV3xozvO1+y4vN3T2QHmZIs+lNXFlRh/xNY+lHlJdrz5w
         zLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702815642; x=1703420442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6xMyvQ0D0+nEZ9Gai87Uhvht57Iu3iXC8pPekH44If4=;
        b=I6HroWnXOYqZHNsq9KiwlseTd6j3tmNRiiZGBRTEcXktF+C3n8pTN7cmKV6K6X9R0s
         aU31Oe98FYZrgGjn3HBaPkwb3GZ8OQgnJATVkROmeK9U1gWfSZ0JD1yykMk3JniYzbqg
         aZjERxBsMuLg0hOMX8edvCCsopFsitwY9QhcvBnVeTL2U/U02rSjBe+jtZwQAQbh2n5B
         i1DvSNAfUKEvqk62+6gWSHSTRPl2ARu0+Egxa+vs6WBHxEE2C3Szu1qOYWcRvmDtUixK
         i+iuPbrBxEkYh4IZBzvxgWjUBUiY1KB9C8XZLA3ZHcGjKi6ImPwvIsalS/W6s184aevW
         4YCA==
X-Gm-Message-State: AOJu0YxC6dGm8Tknn0cfcv6iDLLRlDitiuBokKMfwBCxwC0AfYbW+3YH
	cx0ISaKLqKAq6MtwCZ+nKA2EKmxGm8EqYQ==
X-Google-Smtp-Source: AGHT+IF8tBF81mVrLJRXLBc0CJHYJ8+mpwFKXqaSPEhBWtum8EU0q3MnMciWOn80wXXHftsNScwoUg==
X-Received: by 2002:a50:ccd0:0:b0:54b:f6f7:9c4d with SMTP id b16-20020a50ccd0000000b0054bf6f79c4dmr7435314edj.38.1702815642009;
        Sun, 17 Dec 2023 04:20:42 -0800 (PST)
Received: from localhost.localdomain (2a02-8388-0502-f480-6c32-186a-368b-d6a9.cable.dynamic.v6.surfer.at. [2a02:8388:502:f480:6c32:186a:368b:d6a9])
        by smtp.gmail.com with ESMTPSA id es21-20020a056402381500b0055267663784sm3495621edb.11.2023.12.17.04.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 04:20:41 -0800 (PST)
From: Christoph Winklhofer <cj.winklhofer@gmail.com>
To: krzysztof.kozlowski@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christoph Winklhofer <cj.winklhofer@gmail.com>
Subject: [PATCH 0/2] w1: add UART w1 bus driver
Date: Sun, 17 Dec 2023 13:20:02 +0100
Message-ID: <20231217122004.42795-1-cj.winklhofer@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello!

This patch set contains a driver for a 1-Wire bus over UART. The driver
utilizes the UART interface via the Serial Device Bus to create the
1-Wire timing patterns.

It was tested on a "Raspberry Pi 3 Model B+" with a DS18B20 and on a
"Variscite DART-6UL" with a DS18S20 temperature sensor.

Content:
- Patch 1: device tree binding
- Patch 2: driver and documentation

The patch was created against the w1 subsytem tree (branch w1-next):
  Link: https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1.git/

The checkpatch.pl script reported the following error - which I am not
sure how to fix:
  WARNING: added, moved or deleted file(s), does MAINTAINERS need
  updating?

The technical details for 1-Wire over UART are in the document:
  Link: https://www.analog.com/en/technical-articles/using-a-uart-to-implement-a-1wire-bus-master.html

  In short, the UART peripheral must support full-duplex and operate in
open-drain mode. The timing patterns are generated by a specific
combination of baud-rate and transmitted byte, which corresponds to a
1-Wire read bit, write bit or reset pulse.

For instance the timing pattern for a 1-Wire reset and presence detect
uses the baud-rate 9600, i.e. 104.2 us per bit. The transmitted byte
0xf0 over UART (least significant bit first, start-bit low) sets the
reset low time for 1-Wire to 521 us. A present 1-Wire device changes the
received byte by pulling the line low, which is used by the driver to
evaluate the result of the 1-Wire operation.

Similar for a 1-Wire read bit or write bit, which uses the baud-rate
115200, i.e. 8.7 us per bit. The transmitted byte 0x00 is used for a
Write-0 operation and the byte 0xff for Read-0, Read-1 and Write-1.

Hope the driver is helpful.

Thanks,
Christoph

Christoph Winklhofer (2):
  dt-bindings: w1: UART 1-wire bus
  w1: add UART w1 bus driver

 .../devicetree/bindings/w1/w1-uart.yaml       |  27 +++
 Documentation/w1/masters/index.rst            |   1 +
 Documentation/w1/masters/w1-uart.rst          |  48 +++++
 drivers/w1/masters/Kconfig                    |  10 +
 drivers/w1/masters/Makefile                   |   1 +
 drivers/w1/masters/w1-uart.c                  | 189 ++++++++++++++++++
 6 files changed, 276 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/w1/w1-uart.yaml
 create mode 100644 Documentation/w1/masters/w1-uart.rst
 create mode 100644 drivers/w1/masters/w1-uart.c


base-commit: efc19c44aa442197ddcbb157c6ca54a56eba8c4e
-- 
2.43.0


