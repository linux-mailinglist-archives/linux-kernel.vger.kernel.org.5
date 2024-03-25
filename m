Return-Path: <linux-kernel+bounces-116591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13115889EE4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9659D1F378DA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00286147C88;
	Mon, 25 Mar 2024 08:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbRJUv2x"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237BC15EFDF;
	Mon, 25 Mar 2024 06:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711348880; cv=none; b=ILtTBJ4g5jf2Yq3383nnvsLvKvO51miidoBc9vopCYQ24j2rpppLwvU3jDUbRKX12xd7KnrzXoIi8GCL9TtgB1jqdjh9u+iN/+ucLjFJQA1SJGU8YO/T58ZiUAMoSCDeKvULomdhmtHZ0n1KCY0URMSM4S9Aa7Fjvz3vRTaMFI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711348880; c=relaxed/simple;
	bh=mELGYMOH7A8TPort+ryvunaY+WZx5lfgIl8yCl37ICA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bpkDyeGj2Jz8wHaID5uUWOAHmR1EkAWgK93jXZc2DcNHZg0TgPcTyfQNRb44yR4/t6sCDYVzaG83g4fCWNqa2TVZfj3XCSY2+sRDJl3tV/0vDCug3pACnCUKNrOMgIjoZmFZ/UI+IpNJbM5E9mkFrCmLRRbAc5UgHA4N2X4jTb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbRJUv2x; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-513d4559fb4so5328714e87.3;
        Sun, 24 Mar 2024 23:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711348877; x=1711953677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RPiEj48KDcJmqB3zbNMJmIq6jw3YQzX8n++ebbQjH5g=;
        b=fbRJUv2xrJ/esnNBdl2OUFWnCd9f/Ej1kVZ0KHAoUiyyc3WzGOfV/NkdZEu7lug+7Q
         adS79uGIR2sG323SjEI5bT2Jeg+wKc7NRlN9MBgsCR+0NinZvxOZQ2pB2AJjRBji83Sc
         3K2lZK3i//cz+5BhbYRwKd4zI61Fqro+yULdXEN1rKBctaeioRtGBdsQWAEP+weKhQRf
         iaIn+aO6ivVjQaxqnR1EweB//mflt66IrWmQWe0mo8e2ugVxLHhGxMADsm04LWQ88bov
         estBL/oPkaYIZ78CD7OiKoq6uymM/PABfL2IqtQEBHHXbH1SGLCK1BCUS0H7F4mNnurW
         /rJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711348877; x=1711953677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RPiEj48KDcJmqB3zbNMJmIq6jw3YQzX8n++ebbQjH5g=;
        b=PC5+oyxx37sSlV/ybUcHweaG78IT+pGCCVf2qONNr1KT5BiGYS1ZTrGgIzj9SOEZzs
         wHXj+jKg5SOzK06MLirkN3wmKZWAuGW2sjNEACxHTWd+zOUOrTXnd4uaY9LElkDU9wEl
         jmctWIiOh8vEhZtHBomunBADXSikayzCVBtyoSeNi6qL+fkw2ZMdG9kFYoFHDG0B+gHA
         6XbYTdMNlSbiGe3uuw5ryJSAuRMd040L0x+8YtumykjN1Q3iJ5mMgW3KGEdZGoBp4DOL
         8yHf9ewCEiGSTL3XbYvYlXIIcOACjywKH1bQOVsvJWK/CX/eQUGW76d6YUvpDJxwTRBh
         5+xw==
X-Forwarded-Encrypted: i=1; AJvYcCUMBlXataeKTMj1Ah4Rs95mFMkFkJJmOyguaiHW5wclwhh8WL49EhkhCDxfvjfsdjvtLUlUZydBC+WRsdS0Q0BYBRy40pPJ/Xwg2lBKyzJ8WpPWlBhuq7+nO4kkqAq50Np5iwvDE79eRXY=
X-Gm-Message-State: AOJu0Yzw1OAhWBWlPZCmt95++mzb5kbouQQW8wOS5oLlIK1quonplS+P
	IFaO/W2tzQnONWJHjYTHfEHudHKJvFeLtRrAvasOjBW9RRjVuUG6Qw/Y7O1pLBQ=
X-Google-Smtp-Source: AGHT+IHb35nKqssD+usvMbeAXao5HMvzR0wpz14PnshdPnDWUxwp/51YROxA+X+DGBC+yyVy9cog7Q==
X-Received: by 2002:a19:e055:0:b0:513:952d:ac62 with SMTP id g21-20020a19e055000000b00513952dac62mr4358838lfj.52.1711348876964;
        Sun, 24 Mar 2024 23:41:16 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id h12-20020a0565123c8c00b00515a411fd20sm828229lfv.105.2024.03.24.23.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 23:41:16 -0700 (PDT)
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Ivan Bornyakov <brnkv.i1@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Wave515 decoder IP support
Date: Mon, 25 Mar 2024 09:40:55 +0300
Message-ID: <20240325064102.9278-1-brnkv.i1@gmail.com>
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

ChangeLog:
  v1:
https://lore.kernel.org/linux-media/20240318144225.30835-1-brnkv.i1@gmail.com/
  v2:
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

Ivan Bornyakov (5):
  media: chips-media: wave5: support decoding HEVC Main10 profile
  media: chips-media: wave5: support reset lines
  media: chips-media: wave5: separate irq setup routine
  media: chips-media: wave5: drop "sram-size" DT prop
  media: chips-media: wave5: support Wave515 decoder

 .../platform/chips-media/wave5/wave5-helper.c |   3 +-
 .../platform/chips-media/wave5/wave5-hw.c     | 296 +++++++++++++-----
 .../chips-media/wave5/wave5-regdefine.h       |   5 +
 .../platform/chips-media/wave5/wave5-vdi.c    |  27 +-
 .../chips-media/wave5/wave5-vpu-dec.c         |  44 ++-
 .../platform/chips-media/wave5/wave5-vpu.c    |  31 +-
 .../platform/chips-media/wave5/wave5-vpuapi.h |   4 +-
 .../chips-media/wave5/wave5-vpuconfig.h       |  11 +-
 .../media/platform/chips-media/wave5/wave5.h  |   1 +
 9 files changed, 303 insertions(+), 119 deletions(-)

-- 
2.44.0


