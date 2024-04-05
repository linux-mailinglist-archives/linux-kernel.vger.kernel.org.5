Return-Path: <linux-kernel+bounces-133351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6315589A2B4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06A01F24D9A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77887171091;
	Fri,  5 Apr 2024 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGU+hHFJ"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1C116EC0B;
	Fri,  5 Apr 2024 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335290; cv=none; b=diqO3saWeZDqmp12pxi4WfwdS/HfrHgZG6TKAsFcFWP+7639fsfl88vEFJj9PJkj2fdP4u82ESrFvwi4ETKZBp3noPEzO2v0W/q+j30ajmlqD7QnWvA31faEVaMJF4xB5xpZkZP1RrKVbze181mXLRYCg5Melxv1oEYMAkx0vxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335290; c=relaxed/simple;
	bh=BsbDTRXO5rbQuNOOWWDuZ228ZxNjfhgUzzAGBm8miTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tgjERCoCmVQ/2SgQbhV1Nirhri4Ot5entf8Ph/19KA6iIiGPeZBdVnX5bf21xYpvO3gAKJxQMzDF5XnMkpeqH8ZQxPsYmTx9iMxVuH5JK+gk0cxPU35+nXw0B+iQw0cn1OXCVb494gT2xUFe6OPKvPtKjk75NkzRnPJ1Kiz/xzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGU+hHFJ; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d68c6a4630so28173561fa.3;
        Fri, 05 Apr 2024 09:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712335287; x=1712940087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NLH/m+uT1QUdmDjnPqveVob8tvdRYsduJkgPdtTo/TA=;
        b=jGU+hHFJouuZ2Xt4G0SUChoQb7QvZvdRrBB+Rq/0dayqTvfY/kFsVP97R0bTN/id7V
         HzUknK17jX4A/mx0SzvZE9BqlizOmU9WQiq9miUIA7XbcPkeUaSfiPxzdVej4Nf+onK4
         gYooFWvPGH0aBlLN6Z534JbigfYq1fDg0TrtnYiR0UU3LZF2tnmVC5dnSQ4Tf9i/OALt
         2qkRlwCrSKcHSHaBQ1vnDY1Dz1eb3TvbeFF5NiHNXlLXDp4eMPpZ2e30hYefULDfj7Ib
         GY0/3mKm84bhieg66oo3lYjycf0wtFSgeWvYIHy8m3ZYrx/mvbJ3iZGUQLo4BhA/s252
         mJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712335287; x=1712940087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NLH/m+uT1QUdmDjnPqveVob8tvdRYsduJkgPdtTo/TA=;
        b=DaByVdO9h5aONEiew5grHdFjp8h9d3I6yFWTZof1Vh/gNXzGlIVeD4c9ac6SIfrwUp
         UBQWhE2kwO7o0xSr0icuX3mk0POWAB8CPJrqoBAFLfqPwODVcZaDfSvA8UA87vZCEkt2
         +iYA+atBEZmpuzx/okx3VkK2LP+mJmZ1KZPzot8JGX0WX0F4qVyWaZ+KF+QwWJbbsML3
         pNQUjWgPOysWBXMLy1T3fCqj6dWV0CGM48pht8xq1a/Y13lPiGPr4QFQmprvGuxg3JAt
         qPe1JTilhubXG/FCQMpNMjpb2sUqT+1jHQq6YT/8+lhGnnZThObSvzumhJalIvfHIM30
         w6Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUHBhuoXUMXDpun0pDqW4vYjy/SL+FOG+01Yr8KTWQkEeXVoNUZp1Pn3rdJ3cH78t3nglPFV4td9ORPvjaTXARpb4iOlVlLUWOWGKCfzLTTJIgC4EnY1PbDfMeAoYVx2ohUylwU9iD9oNs=
X-Gm-Message-State: AOJu0YziKr38bNN/u3v4V7fU6jjemv45DnSxa5yelrM8rxrrnhD64w+8
	p72ILxdbjlmA/qRSCS3WtjHpf0yG3Tpeyy0h87tvdxeaMxxnUWsO
X-Google-Smtp-Source: AGHT+IHORr1w8vtrY1pml1ibsAJCtWtZhnUV5KX/8kT8FZYqyn/0B5wlWzlmISObqN+GkuTCylmuKg==
X-Received: by 2002:a05:651c:1057:b0:2d4:668f:baac with SMTP id x23-20020a05651c105700b002d4668fbaacmr2018504ljm.28.1712335286828;
        Fri, 05 Apr 2024 09:41:26 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id h13-20020a05651c124d00b002d6c93793f1sm218372ljh.77.2024.04.05.09.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 09:41:26 -0700 (PDT)
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sebastian Fricke <sebastian.fricke@collabora.com>
Cc: Ivan Bornyakov <brnkv.i1@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] Wave515 decoder IP support
Date: Fri,  5 Apr 2024 19:41:04 +0300
Message-ID: <20240405164112.24571-1-brnkv.i1@gmail.com>
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


