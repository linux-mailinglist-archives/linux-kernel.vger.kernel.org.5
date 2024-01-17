Return-Path: <linux-kernel+bounces-28987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0274F830608
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826531F25B6B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862971EA73;
	Wed, 17 Jan 2024 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="En3/+hhV"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA171EA84;
	Wed, 17 Jan 2024 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705495895; cv=none; b=GRYY1TGI2+ll0K6aVd6uxj7eTNn+jEi9ltc/itB4mc83eQSGiN4bzlRJKHt0IrjU2J+VBC9HojKtOZshkID25jU9QcAiO9UXUdc7pI23lD4dAw2OiJJ/R8ARtYSJD95LuHHAobdOw4zgO+IgP+QRKfO+AbqQiUz2CC2RdKbVty4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705495895; c=relaxed/simple;
	bh=yO3PcPcr3TdNoSrWsl3ZcspYVZ/UFMIpQ5ze0HLpjts=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=Zgu3LK9AKqm7pm/ZuoVMgdLGrVFSxtpMgByRpO1qBWMkNBbGLRfGE0czjlF4JMK37KadPu20YwV2jVLirGndlsOALJX7B7kmMq+gbFADcb91iUFrMP0tMrA0iViuxPaQxz2VuX2fqpDYv7BLdUZHIO77+jeGlkldI7/CjLS5UG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=En3/+hhV; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-559eefa9dddso137638a12.1;
        Wed, 17 Jan 2024 04:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705495892; x=1706100692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dEtTvFikr2vB2TRmutE89D+8r4XFqE11/VEjO0rkFkE=;
        b=En3/+hhVnjgfqqzPmsme7Pd+1b0oaMhGv/xIh6aZVc8WT6V23tR87K/oQyoz1cVkDP
         dkBZ04Ch0YL8WMnR5Zh+rcUFmfeie88lmtiAhJklGKjTMEr6SV7j5/MGL6AZqrPbeWjq
         za+kaqc1jyON6SUhWvwoSgLYj0sp/ZRVK/EnAqy+V9Kce0kgxQh5vdBwZkkLY2Ml3ClE
         5f2z819gfRkq9FhTnPgmXH9TpJF9HpjWRQBSHL5ydSk4oFQ8ZwSIkcId4KQII44rUWuC
         2xOAdeLnVFAJztxDJvJu+TFydj3/AhBuqpBQ9F71jFW73DZH4MaMNPrLFqgbmWp9429i
         N9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705495892; x=1706100692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dEtTvFikr2vB2TRmutE89D+8r4XFqE11/VEjO0rkFkE=;
        b=YA2PrKma0EfeUNE6wHZQ6P9nmiyOMjxrAsDbMJ6CLkeKbaTTBOqmswHiUhQdqFPaZZ
         3tO+LCl1t0UNigua20KE18XrxRBMuHl8AD4oleThAVkDmGGXx2rkuP8pxka01jtAYluH
         V3JFyrColf/HUxnLY0UpjhjzTh6FMTg7EacBvAW1A5VTh1tA4oWJfWYuge3VJ9ixmOsv
         1hcPogCtQpl991kbGaFBzXjr9OrMuuUdf7Jw0EyPCc1S5V5PO7FXn2MelK0/URIzdnlm
         cvwX0axMhl+6gCc7HL7hHytp5urmAJojcwWVsbGGN4xQE+VhDRd+rBzvcQByh4aKrB9W
         IGmw==
X-Gm-Message-State: AOJu0YxT1NnF1E/Du+lrxS0vn0UqCDkv5q1YIKLI8OkJaKg1JGOU/AdZ
	E7BNwRRxC4q0qb2ZZB6In9E=
X-Google-Smtp-Source: AGHT+IF5Fh76o8X2KLAFPOWd9wsg6hqUbiHuyN84/6DtCphNtKqt/sOebS66Fh819kgSB2rnwfq4Pg==
X-Received: by 2002:a17:906:2972:b0:a23:1163:24be with SMTP id x18-20020a170906297200b00a23116324bemr4253332ejd.95.1705495892316;
        Wed, 17 Jan 2024 04:51:32 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id t13-20020a17090616cd00b00a2ea45637desm1277247ejd.112.2024.01.17.04.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 04:51:31 -0800 (PST)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
To: 
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: [PATCH v4 0/5] Add support for LTC6373
Date: Wed, 17 Jan 2024 14:51:09 +0200
Message-ID: <20240117125124.8326-1-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for the LTC6373 Instrumentation Amplifier within
the existing HMC425A driver.

The LTC6373 is a silicon, 3-bit Fully-Differential digital instrumentation
amplifier that supports the following programmable gains (Vout/Vin):
 G = 0.25, 0.5, 1, 2, 4, 8, 16 + Shutdown.
The programmable interface consists of 3 digitally controled inputs.

V3->V4
 - Fix git commit message typo and remove newline between tags
V2->V3
 - Use return instead of break in *_gain_dB_to_code()
 - Add new line before return in *_code_to_gain_dB()
 - Match parameter alignment for added _powerdown functions
 - Add precursor patch for using pointers in the match table
 - Add chip_info attributes: has_powerdown and powerdown_val
 - Change probe logic to use has_powerdown for default powerdown state
 - Added 'Fixes' tag to commit message of 'add conditional GPIO array...' 
V1->V2
 Driver:
 - Fix chip info table indent
 - Remove enable attribute
 - Add ext_info powerdown attribute
 - Enable by default powerdown attribute
 - Set default gain after disabling powerdown to min value
 Binding:
 - Fix conditional checking of GPIO array size for LTC6373
 - Add precursor commit for correctly checking gpio size depending upon compatible

Dumitru Ceclan (5):
  dt-bindings: iio: hmc425a: add conditional GPIO array size constraints
  dt-bindings: iio: hmc425a: add entry for LTC6373
  iio: amplifiers: hmc425a: move conversion logic
  iio: amplifiers: hmc425a: use pointers in match table
  iio: amplifiers: hmc425a: add support for LTC6373 Instrumentation
    Amplifier

 .../bindings/iio/amplifiers/adi,hmc425a.yaml  |  47 +++-
 drivers/iio/amplifiers/hmc425a.c              | 253 +++++++++++++-----
 2 files changed, 236 insertions(+), 64 deletions(-)

-- 
2.42.0


