Return-Path: <linux-kernel+bounces-168237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 757A28BB585
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF6151F23812
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF6A537E9;
	Fri,  3 May 2024 21:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDDhOSk8"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD8F1E4B2;
	Fri,  3 May 2024 21:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714771368; cv=none; b=C0ZCEtTfVnmbCYFC33AnXodutPqYmaoV45LD1dIzhB/Ju0e+it4ACELgWThaDXA4YG+7yoUBKhktnxTiCHPGDvW8oIHXpNZ4psgw81KyrPk1ZdtAfW4L06yfLA1aVbxzNdMfgIgcg7BqWWEhtjj0pVJ/PHmqEJ9vXnJdpPZImQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714771368; c=relaxed/simple;
	bh=cr9DQeqBtzT4TPir/4vvyekzi9fAbf2qdIhn9FjlAng=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S/36jKXwuehtN3jaKPgZOKYbN2tPpvK8K7az7UN47kaYZ5CkqE2dF5lSzF56LigmSbsB4Nd2vVxITmL2Mvw5gZo8MN5INDbKxFu3dB7OV8kSE2ym/mdAuDX41kFP5YwmpAdarEDxJjQgCSQoWsfePqIH7iz+qe8W2trZuv2RKGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDDhOSk8; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-347e635b1fcso89116f8f.1;
        Fri, 03 May 2024 14:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714771365; x=1715376165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=W4l8CQe9oejxI5JdTjIuaJLl4CrUfKfLhE5Q/q4k4MI=;
        b=SDDhOSk8ejrAf6lZYv8tsK3u3rHy7nm9dE0rseg4Jy5+hsM0bpTF8GR/NdTkI+BVjy
         ZHgntiS0raJxqvPhUkoB0+oS0YMUEqWx1CFu11SLSODjXrIMwLNvCQVrWU0VHp5I4XKb
         BpqCa8jGHiNWvIZhQFLVKfuoGwSL28NUr9t9c/o4EZXKuBaYloMGwh/2W+sABNtOZeR9
         dqsG9fI8qtjtpKzW02aSpqUxuxX+LpTKyMfxikRcTRXY5lTRi8meuKdVrE+kxZzSNY1K
         ggEpqApdN01PLRn9P+tckwoppJRo7IHGrCmEo6wZdYKVQtmcxbJfn4w2Q0qIQ74eOOtG
         xyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714771365; x=1715376165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4l8CQe9oejxI5JdTjIuaJLl4CrUfKfLhE5Q/q4k4MI=;
        b=B/a6IH9zCBkDhZPddRNwpFz5heonLFvEDjRG+zktagRil7lrHyIHghUAamQ30Fzygo
         JcBNTqTEOGeiL+ebaVbXEtvp9+pTZacXmYgKNtgWHo/kD7nY8p2CSL+IfPbHGMixUJoj
         4kWNHbcYSFoDw0UTEv2omA9EdnRf19RNPvam0SIo3nTGRzwOL1DlbB2gVX/4FW04Sa6q
         4qHGuMUkc1pk1UvUMMJeuMtBMBH3dyLTqiFJw97jXv4JC0W1ZYunBK+mNE9WJ1wYLY8E
         6yptbAoaDHjt3CTY0xYcg/q8e6fuEL68FGM/SEdCy/kZSfCD9FwoTf7d/dcYVKkF+WfE
         U44A==
X-Forwarded-Encrypted: i=1; AJvYcCUlatkWpOD3Nzc9CDfi+6PnGwEUcMe1gjZe2L1yDSp6D+nJqUCq+hbjxUj4Rwl2Zp4eYPXCWQER1ZUWNzpcDyrPkv2J0UZuvfIFFliog6GwKlEWAl9hbdVMjge8+Ahhz7C1th5uBphKkbbt67ROoDQgMJnNpkUVoX1Yeh9oisuBWDdpmks=
X-Gm-Message-State: AOJu0YxospUvLHjkLQ3disg4xeLtG1Pa0pXShtCakdLKjTxqQEuzz24o
	ajGVvQn4DOPyDXYLwSMnq1okntCxiUbBnyIYmRCrQQgQ9oYfYhyh
X-Google-Smtp-Source: AGHT+IG5ebhhvzwjL8CAwQUxC//VIjqfAuNBXcFan4FhzYGiW1WjCfdReMNgZ2Mi9YyXSV/voPOr2g==
X-Received: by 2002:adf:f88a:0:b0:34b:e2a:499d with SMTP id u10-20020adff88a000000b0034b0e2a499dmr2920956wrp.19.1714771365159;
        Fri, 03 May 2024 14:22:45 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id g7-20020a05600c4ec700b0041902ebc87esm6918729wmq.35.2024.05.03.14.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:22:44 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Hauke Mehrtens <hauke@hauke-m.de>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
	linux-mips@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Daniel=20Gonz=C3=A1lez=20Cabanelas?= <dgcbueu@gmail.com>
Subject: [PATCH v2 0/5] mips: bmips: improve handling of RAC and CBR addr
Date: Fri,  3 May 2024 23:20:56 +0200
Message-ID: <20240503212139.5811-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

this simple series improve handling of RAC and CBR address and try to
upstream these simple patch we have in OpenWrt for a while.

The first patch fix a straight kernel panic where some Bootloader might
enable RAC but misconfigure the CBR address. The current logic only
check if RAC is enabled but doesn't verify if the CBR address is usable.

The DMA sync function cause a kernel panic for invalid write. (as CBR is
0 or something like 0xa)

The second is preparation for making the CBR address configurable in DT.
Since this address doesn't change, we can cache it and reference it with
a local variable instead of calling the register to access the value.

The 4th patch make it configurable with 2 DT property, one to actually
set the reg and the other to force set it.

The first property is used when CBR is set to 0. The second property is
to force it if the Bootloader sets it to something wrong.

If the CBR value is not 0 and is not forced with the second property a
WARN is printed and the DT value is ignored.

The 5th patch enable RAC on BMIPS4350 and the 5th patch is a micro
optimization to skip more call on DMA sync to save as resource as
possible on low spec devices. (since DMA sync is called many times for
the Ethernet Switch and we can reference the bool instead of checking
the CPU type everytime)

These has been tested on BCM6358 (HG556a) and BCM6368 (VH4032N) and
reported correct functionality.

Changes v2:
- Prefix brcm vendor in the added property
- Drop last patch (cpu switch from DMA sync)
- Validate CBR addr from DT to be outside DRAM
- Reduce indentation in DT CBR check
- Reduce delta and use local variable for CBR where possible
- Fix and improve typo and spelling mistake
- Use 0xf instead of 0xa for BCM6358 RAC enable

Christian Marangi (4):
  mips: bmips: BCM6358: make sure CBR is correctly set
  mips: bmips: rework and cache CBR addr handling
  dt-bindings: mips: brcm: Document brcm,bmips-cbr-reg property
  mips: bmips: setup: make CBR address configurable

Daniel González Cabanelas (1):
  mips: bmips: enable RAC on BMIPS4350

 .../devicetree/bindings/mips/brcm/soc.yaml    | 32 ++++++++++++++
 arch/mips/bmips/dma.c                         |  2 +-
 arch/mips/bmips/setup.c                       | 42 ++++++++++++++++++-
 arch/mips/include/asm/bmips.h                 |  1 +
 arch/mips/kernel/smp-bmips.c                  | 21 +++++++++-
 5 files changed, 93 insertions(+), 5 deletions(-)

-- 
2.43.0


