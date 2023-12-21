Return-Path: <linux-kernel+bounces-7902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400F381AEED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03532286CAC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC68DBE5D;
	Thu, 21 Dec 2023 06:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLPLcguH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926561429F;
	Thu, 21 Dec 2023 06:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a233bf14cafso46266366b.2;
        Wed, 20 Dec 2023 22:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703141465; x=1703746265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2zpvJDmn7loL4qHXtyNqifDl4zUIQ88U/auuqyGz3Wc=;
        b=fLPLcguHFIJWZOxYttEZ2GPT0nZISMPz2ZS9WGh6lLFU/6WdqTnFR21JJZOvNdk/y0
         +Hw9t793tkS6ErKg+hCn/l4WBwMi3VhS3ZjU0T6B6cGhPHwUhC88U7/7ZLMOvsCrUnhn
         ZsyEbzIRHVNqJSmCK8RCZexlh2cmNIrb32wLzEvImZBjxmSp5Tgz6bsRZyCGWaDkovqG
         clMapxnyBCHOut5RJsOtL3XohAVr6sjMaX6i/TYJmdU0F49+RYwGGjHXG1R+921zGHx/
         3TEWzEBlPO9HnmTBPND91rH65kq0x+8dzW6DcNGe10m3pCWtAe3BpPc2ugTHUNyMNA4U
         huHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703141465; x=1703746265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2zpvJDmn7loL4qHXtyNqifDl4zUIQ88U/auuqyGz3Wc=;
        b=ThkBgKwvt6BEmzneNUF9uWCWTss6eMK7KAtuQFBqmg9PrJdJZvcwEgZe8NfcKNwhQb
         KYhJiPQOo5hDmbJHITmrLkkgw0NxQFxIxlho0ddgFTXvyNdDv3yI6qxsW8+zTH/G2XYY
         qOk006CVUXK2pz9HFOFvemkLXQlJFqvu5mvWR4+1l/2JjrX7eCrLe7i2mIOaeNE7T8j7
         YLcpmybLAokEWKPN6EgmydpqFdMQ/83d6KTn4pcBcfr9FQY6KknLxVjgusvB1MGLROYx
         wyM9fzFKiD3BUOvtC3DMW52ZygpZPTRugcLem6Y8xQ1EtafL8f5W0nJvXuaaJ7EhBKFC
         JBLg==
X-Gm-Message-State: AOJu0YwnpbyVcLpyOY+78wUlxcvPao+YUJ1LQzotgM7EmZCkapfHyQcY
	kEB7vmuLA/8Uu1Rt/Lx0ri8=
X-Google-Smtp-Source: AGHT+IG66NNeHP3ac7NJ2kcWWFvoObeLxTmm2y7RofhjhYOm5Y0KPWlDTQf7Dw1vLKBLbr7vLt2UnA==
X-Received: by 2002:a17:906:2207:b0:a1f:b467:9b93 with SMTP id s7-20020a170906220700b00a1fb4679b93mr8278046ejs.78.1703141464662;
        Wed, 20 Dec 2023 22:51:04 -0800 (PST)
Received: from localhost.localdomain (2a02-8388-0502-f480-6c32-186a-368b-d6a9.cable.dynamic.v6.surfer.at. [2a02:8388:502:f480:6c32:186a:368b:d6a9])
        by smtp.gmail.com with ESMTPSA id jo23-20020a170906f6d700b00a268e4757b2sm617082ejb.143.2023.12.20.22.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 22:51:04 -0800 (PST)
From: Christoph Winklhofer <cj.winklhofer@gmail.com>
To: krzysztof.kozlowski@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christoph Winklhofer <cj.winklhofer@gmail.com>
Subject: [PATCH v1 0/2] w1: add UART w1 bus driver
Date: Thu, 21 Dec 2023 07:50:46 +0100
Message-ID: <20231221065049.30703-1-cj.winklhofer@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello!

Krzysztof, thank your very much for your feedback!

This patch contains a driver for a 1-Wire bus over UART. The driver
utilizes the UART interface via the Serial Device Bus to create the
1-Wire timing patterns.

Version 1

- In v1, the driver requests a baud-rate (9600 for reset and 115200 for
write/read) and tries to adapt the transmitted byte according to the
actual baud-rate returned from serdev. Is this the correct direction or
should the baud-rate be specified in the device-tree? Alternatively,
it could make sense to specify the minimum and maximum times for the
1-Wire operations in the device-tree, instead of using hard-coded ones
similar as in "Figure 11. Configuration tab" of the linked document
"Using UART to Implement a 1-Wire Bus Master".

- In addition, the received byte is now protected with a mutex - instead
of the atomic, which I used before due to the concurrent store and load.

- Receiving more than one byte results in an error, since the w1-uart
driver is the only writer, it writes a single-byte and should receive
a single byte.

Changes:
- support different baud-rates
- fix variable names, errno-returns, wrong define CONFIG_OF
- fix log flooding
- fix locking problem for serdev-receive and w1-master reset/touch
- fix driver remove (error-path for rxtx-function)
- add documentation for dt-binding


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

 .../devicetree/bindings/w1/w1-uart.yaml       |  44 +++
 Documentation/w1/masters/index.rst            |   1 +
 Documentation/w1/masters/w1-uart.rst          |  53 +++
 drivers/w1/masters/Kconfig                    |  10 +
 drivers/w1/masters/Makefile                   |   1 +
 drivers/w1/masters/w1-uart.c                  | 307 ++++++++++++++++++
 6 files changed, 416 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/w1/w1-uart.yaml
 create mode 100644 Documentation/w1/masters/w1-uart.rst
 create mode 100644 drivers/w1/masters/w1-uart.c


base-commit: efc19c44aa442197ddcbb157c6ca54a56eba8c4e
-- 
2.43.0


