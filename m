Return-Path: <linux-kernel+bounces-164374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755338B7CE1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91BBF1C232FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD8117B51C;
	Tue, 30 Apr 2024 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJlZ6dXp"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A53B17B4F5;
	Tue, 30 Apr 2024 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494600; cv=none; b=R9dEsjLRoFDeJ/w6LhmSQc4OQ701NR3JK+NcrcCKyAbp/eBYBAyeqvZaRTYqOupExfHSjP/EYkUJ7GErlfOnp3NP1BIxoXyJlCZAJUfQPhNbEcKuG3NIwroZaIGXpgzlwiXZb2nY00zQnb2cUtIqZH1/gFr3cofFu3ZvXzobzLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494600; c=relaxed/simple;
	bh=uFNfjZwNfsMbmzivDYpvkjkobl1t9QD8f//b+VnosG4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d2diEpo3XgJVQ2/U0jhVYjoqiWaOC2Sj89DmL4LBoOptBi58C4Xh/NdHcfNXQyeNvQ/ppYLkm42jaxyJbVk47QPfPhpmN3MyiO/b5LnxqViolf6bBfxm4I1hSNYlsChdTI4S/YBRmQ3u11iBZkoh4Ye5vaDpYJ71T0agBCtFv9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJlZ6dXp; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41ba1ba55ffso25411375e9.1;
        Tue, 30 Apr 2024 09:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714494597; x=1715099397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qe410Y7Pw3RLVaHlgFyU3e1PRJtNfNOnZTPvy+S7FYM=;
        b=VJlZ6dXpz8v7RFPUey1UPAbECo+Cvb8n0sT3bKOq90OqP8CSxoGfF0PdQXLvLd4Md8
         8B6AX1U75jPfY+UeW60+Ry0fQ5Jblt986yehh5r72KRl2YN3tpFCgwgtsQ8LOplNLZyi
         qoVAIa2o/5MWJ6fQ4s6/6hsWbQvuMe0nfFdDRV2I8GRnRLZuCh49M5eMQafCmBkrx/E4
         wQ2SP54Le73ofeU7vF2onqTnQJO1dEBmzd7UtJODT5oPn9OrfDHDi/uRFNEHRFLXZS/a
         jTrLxb9uMW/a2CUHpf4010aDXiSaxGmF1H4zEwHW2Jg64xx4+xeM0ittTK1+1P6Z9cLn
         PmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714494597; x=1715099397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qe410Y7Pw3RLVaHlgFyU3e1PRJtNfNOnZTPvy+S7FYM=;
        b=XfD+phgmAegHcbHHXaB+xHM6SzbDNyhlrbZ20KGulwwe+JYZVcgp2HVh72RvmINrQK
         3PKULS6PcCKnTAasUegFvy6POIC2FY0TH4Xk3FDjETBuJBPLWrMsiKwl6wH9+lLP4IkW
         cUd6BkwzjUAB+yRYB1kQWIwIaMAqJrmL4ylCinZGBlAYJpAQOm9NxgVsHHJG4NAWanNa
         CG/Lsk0hPKPA7Auf5llGttCYtMdHp9iQSz4sxle+dUOQOIvgGSt/gkm6AbP8wn9s6l+M
         PXBvqjZbvxhdPCq/HKDI07f9VJfazyBIG4igFzgpPmc1zQesQywP1Ao7N9wdL9M34Qqo
         6ftw==
X-Forwarded-Encrypted: i=1; AJvYcCWUXDvVjz619aNYaYqD2kECC9LF2J2L1fUKmnRlUB4XjRISuisKo3r1orbm2pV/dFC0dBW7AuqIvP0fW3v4L0X6b0XHLQT6lJWaHSMLCivcjB5fb9u/Btyqe6I0/gPPLb21QJWj2+tfKs+tYAc5B3m5JDCrZXiS6eYiUZInT0y4k8Hvpg==
X-Gm-Message-State: AOJu0Yx0t03nFS7vPWhUP0FJhXf3tLYJEOWcXvhIh8EZN/osymg3b7wv
	72fdMpuPexdiUHIpWw0zBCgxmQTsXCid1z887+HJvedoocHIFiUb
X-Google-Smtp-Source: AGHT+IF+1JSopzVdrR085zsb7AjrHP/1qo8VJhUCEuReCpMNFh9Co95SKbsN4Yd9Wxpe8oRj3cy5mg==
X-Received: by 2002:a05:600c:4f91:b0:418:5ef3:4a04 with SMTP id n17-20020a05600c4f9100b004185ef34a04mr335696wmq.18.1714494596312;
        Tue, 30 Apr 2024 09:29:56 -0700 (PDT)
Received: from spiri.. ([2a02:2f08:a105:8300:da4d:6b2c:f166:22e6])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c350f00b00418d68df226sm46505396wmq.0.2024.04.30.09.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 09:29:56 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: michael.hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alexandru.tachici@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	marcelo.schmitt@analog.com,
	bigunclemax@gmail.com,
	dlechner@baylibre.com,
	okan.sahin@analog.com,
	fr0st61te@gmail.com,
	alisa.roman@analog.com,
	marcus.folkesson@gmail.com,
	schnelle@linux.ibm.com,
	liambeguin@gmail.com
Subject: [PATCH v7 0/6] iio: adc: ad7192: Add AD7194 support
Date: Tue, 30 Apr 2024 19:29:40 +0300
Message-Id: <20240430162946.589423-1-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear maintainers,

Thank you all for the feedback!

I am submitting the upgraded series of patches for the ad7192 driver.

Please consider applying in order.

Thank you!

v6 -> v7
  - patch1: move mutex lock and unlock to protect whole switch statement
  - patch3: use NANO from units.h
  - patch3: add comment
  - patch3: use dev_err_probe
  - patch4: new patch to add single-channel property
  - patch5: modify maximum number of channels to include single-ended channels
  - patch5: add single-channel property to bindings for single-ended channels
  - patch5: modify example to include single-channel property
  - patch5: modify channel pattern to "^channel@[0-9a-f]+$"
  - patch5: modify required properties for channel node
  - patch6: add function to validate ain channel
  - patch6: remove function to parse one channel
  - patch6: single-ended channels are now also configured in the devicetree
  - patch6: modified some names to reflect the changes

v5 -> v6
  - protect ad7192_update_filter_freq_avail with lock
  - better bindings description for AINCOM
  - the pseudo-differential channels are no longer configured as differential
    when aincom supply is not present in devicetree, in this case the offset for
    the channels is set to 0
  - because of the above change, there is no longer a need for multiple channel
    options
  - correct channels regex in bindings
  - no need to move chip_info anymore
  - change names to ad7194_parse_channel/s
  - add else statement to highlight parse_channels effect

v4 -> v5
  - add aincom supply as discussed previously
    https://lore.kernel.org/all/CAMknhBF5mAsN1c-194Qwa5oKmqKzef2khXnqA1cSdKpWHKWp0w@mail.gmail.com/#t
  - ad7194 differential channels are now dynamically configured in the
    devicetree

v3 -> v4
  - drop device properties patch, changes already applied to tree
  - change bindings and driver such that for AD7194 there are 16
    differential channels, by default set to AINx - AINCOM, which can be
    configured in devicetree however the user likes
  - corrected mistake regarding positive and negative channel macros:
    subtract 1 from the number corresponding to AIN input

v2 -> v3
  - add precursor patch to simply functions to only pass
    ad7192_state
  - add patch to replace custom attribute
  - bindings patch: correct use of allOf and some minor changes to
    the ad7194 example
  - add ad7194 patch:
    - use "ad7192 and similar"
    - ad7194 no longer needs attribute group
    - use callback function in chip_info to parse channels
    - move struct ad7192_chip_info
    - change position of parse functions
  - drop clock bindings patch

v1 -> v2
  - new commit with missing documentation for properties
  - add constraint for channels in binding
  - correct pattern for channels
  - correct commit message by adding "()" to functions
  - use in_range
  - use preferred structure in Kconfig

Kind regards,

Alisa-Dariana Roman (6):
  iio: adc: ad7192: Use standard attribute
  dt-bindings: iio: adc: ad7192: Add aincom supply
  iio: adc: ad7192: Add aincom supply
  dt-bindings: iio: adc: Add single-channel property
  dt-bindings: iio: adc: ad7192: Add AD7194 support
  iio: adc: ad7192: Add AD7194 support

 .../devicetree/bindings/iio/adc/adc.yaml      |   8 +
 .../bindings/iio/adc/adi,ad7192.yaml          |  95 +++++++
 drivers/iio/adc/Kconfig                       |  11 +-
 drivers/iio/adc/ad7192.c                      | 245 ++++++++++++++----
 4 files changed, 309 insertions(+), 50 deletions(-)

-- 
2.34.1


