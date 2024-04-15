Return-Path: <linux-kernel+bounces-144888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0388A4C31
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F14C282E90
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC754D9FF;
	Mon, 15 Apr 2024 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ge9UQWw7"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24BE495CC;
	Mon, 15 Apr 2024 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713175667; cv=none; b=jZ55lQQzp4Drli/km9iuUygfsCuuzyHr0FWnTO/wg6Uj1IMGnlhQUOOGhdLhYBCVS84zNk5p90rx5EWRf8dkcuppQf0n9O7lAObi/f6HfYghq8MUBMOgH0vhxj2EOyhN4js0Hq6RSo4XFo6j64yn8S2Kto28jXRnc5wwmLCdAP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713175667; c=relaxed/simple;
	bh=yllkDJZJUU+AUpPNbPHXfIAJT+NJlxodyHmquqcBZI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NZQvhkXKb4wgg78R0F/EeX75+ttbZghxP4cTLhJPfgF9iKhVlKouECO5mzWRLiZA4j8hKXGpimA3ITT2oP8/4D8eSGxx2B6AeNJiTzgB34R/qwjBSLvtp66goSbCieturS/KlzcxIiORTOR9eXSvQE/OX8vHIbaMEZzC5h3V9ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ge9UQWw7; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-518a56cdc03so1770534e87.1;
        Mon, 15 Apr 2024 03:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713175664; x=1713780464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L1j8Qbe9Vpyk1yafZopzJFKSxt0pg/R/HoS+xgZsDSo=;
        b=ge9UQWw7AHLI8zKgF9iFX9fzUQrEnfaobiL9ycudL4C56KAGSH7fwIkoNcA1FArW1+
         Nv1LoLnOshjTc9qCP9ivXt7/zy8F8ePKQ6Eh36tef9iJ9uDSI2+W8mIt1K0Cv/jRcCJy
         1NqCwpPGoDTUGZe4cxoMatATpRiKaRL+HOUsg/hT/aBvexQ4l0tai77nd6YKm7RQlWY0
         O3F2BsZS93O082td1RNH+gnT9DisHdE1ut49/37SrlAlAHczeCtVk9+2Xq55Z2gM4PP7
         VejUdnDCEogq3RDa1WkSlhD0bvIEIPF87602hfDNdY8meo5Lec2Pwp4iXFUaj7L4Tc/S
         YW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713175664; x=1713780464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L1j8Qbe9Vpyk1yafZopzJFKSxt0pg/R/HoS+xgZsDSo=;
        b=WF3+egZkuczyhK5trG4jcdFRz8XnMTsTelL5a9rZuAkVScr8wJdLSmMHnnphqfAMcY
         WE9/SMF/9ByJ3lho0SwxxhMA9NgXTMw4/TZ09f1iEgMAPW6NRzttfNTMUuq2JzqeqHJ2
         V4cMLp4hbdFECPyUDKJ8SzVHvGiuxl+QN7QvednKEgmAsnknp7cQPglg9JL3UIsq+Fxh
         jgd6lwiQmUKBaz1azM4qZDuBH5emZB46k3aLMco8Rw1uX5/t4y2poPXU8mJbx95PdVQ1
         OyIxJoaZ/Avi8l+9/XqjvMGAke5zwIsgdSOwp++tlmrUYXA3AqAyabX7wnbtVmGwYhPB
         REow==
X-Forwarded-Encrypted: i=1; AJvYcCXOzr7SBLQTX6KRw10mEEmAWWZfQ4dtADrrD0gdax7VnQt4EKdWF0Lwqn719sBDo8hzWs/9fJ8AzyH85QwExJUuisaGQ44YoFUo/In/UvxULjZ3Tu6PWg1LmFXMDsoJrGPWieNe+4s4tOc=
X-Gm-Message-State: AOJu0Yyg1RnumC3rj1MKs1Zat9O9nbBoI9RytXhZhz8vviGKLHOyPjbB
	KrhHrlR0WkK6RcwLX1ITPSu6zKJw9lUt4OpqzsKhx8KcMmokODFT
X-Google-Smtp-Source: AGHT+IFUIFKODb3+/YVRt/Rx3G/EDmwZ/mIffHHSNc2qBpLsm6TA0tiQlepTmJj822e0NUUmqtDgJg==
X-Received: by 2002:a05:6512:3b29:b0:518:c792:47de with SMTP id f41-20020a0565123b2900b00518c79247demr2988374lfv.16.1713175663538;
        Mon, 15 Apr 2024 03:07:43 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id g11-20020a0565123b8b00b00518f53da2dfsm149571lfv.291.2024.04.15.03.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 03:07:43 -0700 (PDT)
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sebastian Fricke <sebastian.fricke@collabora.com>
Cc: Ivan Bornyakov <brnkv.i1@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] Wave515 decoder IP support
Date: Mon, 15 Apr 2024 13:07:18 +0300
Message-ID: <20240415100726.19911-1-brnkv.i1@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initial support for Wave515 multi-decoder IP among other refinements.
This was tested on FPGA prototype, so wave5_dt_ids[] was not expanded.

fluster score for JCT-VC-HEVC_V1 testsuite with
GStreamer-H.265-V4L2-Gst1.0 decoder is 132/147

The issue with Main10 tests is that fluster expects decoded file to be
in yuv420p10le format while this driver decodes HEVC Main10 into 8-bit
yuv420p. Though result is looks alright to the naked eye, proper
decoding into yuv420p10le is to be added.

The rest failed fluster tests are common with Wave521.

ChangeLog:
  v1:
https://lore.kernel.org/linux-media/20240318144225.30835-1-brnkv.i1@gmail.com/
  v2:
https://lore.kernel.org/linux-media/20240325064102.9278-1-brnkv.i1@gmail.com/
    * drop patch "dt-bindings: media: cnm,wave521c: drop resets restriction"
      The only user of Wave5 in mainline is TI K3 boards, thus there is
      no real need to alter dt-bindings
    * in patch "media: chips-media: wave5: support decoding HEVC Main10 profile"
      add check for flag "support_hevc10bit_dec"
    * in patch "media: chips-media: wave5: support reset lines" move
      reset_control_deassert() out of else branch, add
      reset_control_assert() to probe error path.
    * rework patch "media: chips-media: wave5: drop "sram-size" DT prop"
       - don't move alloc/free form device open/close
       - intead of exact configuration of reserved SRAM memory in DT and
	 allocating all of it, allocate all available SRAM memory up to
	 WAVE5_MAX_SRAM_SIZE from whatever pool provided.
    * adjust patch "media: chips-media: wave5: support Wave515 decoder"
      according to changes in patches
      "media: chips-media: wave5: support decoding HEVC Main10 profile" and
      "media: chips-media: wave5: drop "sram-size" DT prop"
  v3:
https://lore.kernel.org/linux-media/20240405164112.24571-1-brnkv.i1@gmail.com/
    * reword patch "media: chips-media: wave5: separate irq setup routine"
      a bit.
    * in patch "media: chips-media: wave5: drop "sram-size" DT prop"
       - move MAX_SRAM_SIZE define into match_data->sram_size
       - add placeholders for validation that allocated SRAM memory is
	 enough to encode/decode bitstream of given resolution before
	 setting W5_USE_SEC_AXI and W5_CMD_ENC_PIC_USE_SEC_AXI registers
       - reword accordingly
    * in patch "media: chips-media: wave5: support Wave515 decoder"
       - add comments around SRAM memory allocation/freeing about
	 Wave515 specifics
       - add comments about BSOPTION_RD_PTR_VALID_FLAG bit in
	 W5_BS_OPTION register
       - add W[AVE]521_ prefix to defines, for wich there are W[AVE]515_
	 alternatieves
       - add semi-magic Wave515 specific formulas to estimate SRAM usage
  v4:
    * rebase onto next-20240415, no functional changes

Ivan Bornyakov (5):
  media: chips-media: wave5: support decoding HEVC Main10 profile
  media: chips-media: wave5: support reset lines
  media: chips-media: wave5: separate irq setup routine
  media: chips-media: wave5: drop "sram-size" DT prop
  media: chips-media: wave5: support Wave515 decoder

 .../platform/chips-media/wave5/wave5-helper.c |   8 +-
 .../platform/chips-media/wave5/wave5-hw.c     | 395 +++++++++++++-----
 .../chips-media/wave5/wave5-regdefine.h       |   5 +
 .../platform/chips-media/wave5/wave5-vdi.c    |  27 +-
 .../chips-media/wave5/wave5-vpu-dec.c         |  51 ++-
 .../chips-media/wave5/wave5-vpu-enc.c         |   2 +-
 .../platform/chips-media/wave5/wave5-vpu.c    |  35 +-
 .../platform/chips-media/wave5/wave5-vpuapi.h |   3 +
 .../chips-media/wave5/wave5-vpuconfig.h       |  16 +-
 .../media/platform/chips-media/wave5/wave5.h  |   6 +
 10 files changed, 407 insertions(+), 141 deletions(-)

-- 
2.44.0


