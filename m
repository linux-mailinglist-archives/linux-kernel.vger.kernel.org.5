Return-Path: <linux-kernel+bounces-10373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1CB81D37A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 11:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2F01C21F1A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 10:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF94F9472;
	Sat, 23 Dec 2023 10:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ij9WQag0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F6A944F;
	Sat, 23 Dec 2023 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a265d4f78bfso216817966b.0;
        Sat, 23 Dec 2023 02:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703325854; x=1703930654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qJ7wRIQI7ItvTYodhbhZ15ihDO7L8jgJa2GzRPNWw64=;
        b=Ij9WQag06cR/0XLnhJ4fXlYNDMI++0lNBOVXoepYkYZiZFtq4vdvOluXWMZcm9r46O
         HC1oxCPE4HRct1EMf1KL5DxB3d6LE/h79o2W9arUxMn0AF4k1RAKOYr6wi5UdlPi6ROD
         3ipV/EVP2CTGPQ/oZVmq2wF3UKGI4/x/xGDxspTxaJ4OJ4DF1XWjNcmRGYI8Zhd9pmaH
         t8+AkD9+ibEpOufkrbQf9k1iDQu/13FaoHXbwkwjKgUKtUeusfdjHVr42K/UZhPVOOPn
         8itPE8ug+eZvnMwPZlWkmuW5zQjOn48crtaR4qm2Kmg+/1dqq/8YQwRpROZekoDjQHG0
         H4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703325854; x=1703930654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJ7wRIQI7ItvTYodhbhZ15ihDO7L8jgJa2GzRPNWw64=;
        b=m9SMiMYAPWIshZE+FmdzIlcmitjMQC929LMH2NTvat5vG5nAPtLUKuGi8uGtmSTJz9
         7mWcgIeCof+D5yLWAD6isFVQHUceO9l3vRVvVTKnZGaDnGklyGGB+jg8AUoEAM182u6i
         ztMOl/+2/AV09kwjIp8Zy+Cd6/yGZwMa9JuU8/Wwp4Bzn9JJaSBQp2PQktnN9AMuo1wW
         02/6dzXHKm0d17gHW8eVNb3Z43eDtuDi58dZSXnDgY04ekw6Zf/etazQL/iroiseA4CQ
         jNkRFEYtNVK1sg5XFPPZ/RjhOjOxPpcKvBAn1YM60vEC6ZXttgAGdKjtfL3MpUdDMTPK
         qZXw==
X-Gm-Message-State: AOJu0YyHvczIS8WEPfUmfiWqqvQC+JjTzDukZ4MZlBGXC79RoVNVgbvl
	IrJ2MVKDtGuKZ1ofNnBva7w=
X-Google-Smtp-Source: AGHT+IE9IQkMWxDRrhlj2nZ2p4RiYx5Dh2m19bkv2ulmfxJbFiUgd/vrUbkqZhu56+SkQxU1Na8i6w==
X-Received: by 2002:a17:906:195b:b0:a26:8f34:871d with SMTP id b27-20020a170906195b00b00a268f34871dmr1510194eje.66.1703325853740;
        Sat, 23 Dec 2023 02:04:13 -0800 (PST)
Received: from cjw-notebook.. (188-23-116-43.adsl.highway.telekom.at. [188.23.116.43])
        by smtp.gmail.com with ESMTPSA id su24-20020a17090703d800b00a26ab41d0f7sm2357765ejb.26.2023.12.23.02.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 02:04:13 -0800 (PST)
From: Christoph Winklhofer <cj.winklhofer@gmail.com>
To: krzysztof.kozlowski@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christoph Winklhofer <cj.winklhofer@gmail.com>
Subject: [PATCH v2 0/3] w1: add UART w1 bus driver
Date: Sat, 23 Dec 2023 11:04:05 +0100
Message-ID: <20231223100408.44056-1-cj.winklhofer@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello!

This patch contains a driver for a 1-Wire bus over UART. The driver
utilizes the UART interface via the Serial Device Bus to create the
1-Wire timing patterns.

Changes in v2:

- add documentation for dt-binding
- allow onewire as serial child node
- support different baud-rates: The driver requests a baud-rate (9600
  for reset and 115200 for write/read) and tries to adapt the
  transmitted byte according to the actual baud-rate returned from
  serdev.
- fix locking problem for serdev-receive and w1-master reset/touch: The
  received byte is now protected with a mutex - instead of the atomic,
  which was used before due to the concurrent store and load.
- explicit error in serdev-receive: Receiving more than one byte results
  in an error, since the w1-uart driver is the only writer, it writes a
  single-byte and should receive a single byte.
- fix variable names, errno-returns, wrong define CONFIG_OF
- fix log flooding
- fix driver remove (error-path for rxtx-function)

Krzysztof, thank your very much for your feedback!


It was tested on a "Raspberry Pi 3 Model B+" with a DS18B20 and on a
"Variscite DART-6UL" with a DS18S20 temperature sensor.

Content:
- Patch 1: device tree binding 1-Wire
- Patch 2: allow onewire as serial child node
- Patch 3: driver and documentation

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

Christoph Winklhofer (3):
  dt-bindings: w1: UART 1-Wire bus
  dt-bindings: serial: allow onewire as child node
  w1: add UART w1 bus driver

 .../devicetree/bindings/serial/serial.yaml    |   2 +-
 .../devicetree/bindings/w1/w1-uart.yaml       |  44 +++
 Documentation/w1/masters/index.rst            |   1 +
 Documentation/w1/masters/w1-uart.rst          |  53 +++
 drivers/w1/masters/Kconfig                    |  10 +
 drivers/w1/masters/Makefile                   |   1 +
 drivers/w1/masters/w1-uart.c                  | 307 ++++++++++++++++++
 7 files changed, 417 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/w1/w1-uart.yaml
 create mode 100644 Documentation/w1/masters/w1-uart.rst
 create mode 100644 drivers/w1/masters/w1-uart.c


base-commit: efc19c44aa442197ddcbb157c6ca54a56eba8c4e
-- 
2.43.0


