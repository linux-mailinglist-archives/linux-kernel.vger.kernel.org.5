Return-Path: <linux-kernel+bounces-165089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A148B879B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC9122884F0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DE75103E;
	Wed,  1 May 2024 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juekkmJt"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE464F898;
	Wed,  1 May 2024 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714555499; cv=none; b=R9HK1sr0cS9YBUtVkDAQ5qed17UbY4ARCBmSEFx02DQ7Bw3jomzWF66dnge4BM5xcWGvKbRl0TaSZq3PA07PLiwynKNNm3HRmxxpNITvpeqJy7GICn6xX3lUqCH/X7g+lzvFvy8pgDS8pvgFaU2rHscZCnW6ScA9i9WDRiyRr2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714555499; c=relaxed/simple;
	bh=mMqQEczyYbL5pHqWFrh45TdPa0xksEIqFdj9snFxA/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=InaczjjRCtSzO+FXtQDOVJ2+sbbktPywUa8uqMcp3FvjRiAdJp1IZnoA6Jru2B5ujGhyUq4cc9K3IGoNFT+JzZL0Nyj3RvF3n/ISZXvKvKPUHbIn7MiX/MSfi/enuFxO0FOTo1pFkPTSG4h3Tc1e9kSYVd8Sf35qS2xY2yL+qhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juekkmJt; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a556d22fa93so721185866b.3;
        Wed, 01 May 2024 02:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714555497; x=1715160297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jwSwC74e0QFgennFNMvJ9WYUak4ZSUwTBMjagZkGBZo=;
        b=juekkmJttOVLAz0SOI/80FzIrVuqAZ7RQk3WkbgVc6wOAyXsz1ZaKz/nTMUhUt7IL4
         Fol4cnbVctmr+WnxTATjz408UmBOU0YICUsgfpLSA+7CslV+ltzq9ihV6R+sJJQH1CBJ
         ZusNdeS4a85BR+PMLnTNca90gDvMmomJKTDj3Js2tP5SuGxagSnhn45miuZtJJYhsrO5
         v6J0xBS1IbWDmY+pvt/WHAeUgASUOy0q68EotKrpN1dGbQj2db/yieeRsBZDZ48G1mR+
         xb/q3x5r3mbahFPEWkxkZwH5stP+sJWtAD4yWWp6fsSSBpg+4TYIZgyO5a5pqHEv8Pog
         vB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714555497; x=1715160297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwSwC74e0QFgennFNMvJ9WYUak4ZSUwTBMjagZkGBZo=;
        b=ZptFclc2zVVmlmsCWk5US/tIFj6yrWXkP/H33ozhpEl5DocMq1euJZigTnf4fEJrST
         7hG12YOAhOkSUisTKgcuZdAuO1ZsfaA7VZmbHbPe0mdW0C54Itb03LPzmmL31HhYT04L
         Mtz+1UhXxhb1yjaOkYeBwb94VQr/zyEhHnW1Kvi2bf4iY1C6+G06Klg+9sOf6YOQrPvS
         UqjDPVCzCAS4AnXb629zuFyc5nvOpWwNzBVo63M+761A4uLggy4fsAn/7MonYaEyEMrC
         e2H9339P4/bJ28dRTwo5M7GYBoumWeoD6HCmpDFh03C8zJ08WCLIhgX2Vgmny1tLLPE4
         RieA==
X-Forwarded-Encrypted: i=1; AJvYcCXzahNczlFiqPD0cxc5viPyAArts+s8fk2HmOKvkFCWbY/STyDd2jy5SyTvr3Ym3aaiAmMslFsmXCas6V0zZVfo9m89gS9+xZEXRBe7wzX3ENAOLVDFEO+4BaegVEuEM6/6XJzKuc6q
X-Gm-Message-State: AOJu0YzC37RO8h6MuLNQ9i6QlWgXsof3XZMXBYNK/l7ZA+acoDwNNJXo
	0mQ1rh5203OuM90SCBVG+yrd/67avMMUeZNqtPs/us/FkEh4Tw0o
X-Google-Smtp-Source: AGHT+IG5Ys9KjZzZHnNsivaQlUQsb7WrenVp/JP/wgpe7Aa248R55XJTLKAL2iTel56i9Kzai3ri4w==
X-Received: by 2002:a17:906:2b06:b0:a59:2e45:f53c with SMTP id a6-20020a1709062b0600b00a592e45f53cmr1449582ejg.23.1714555496673;
        Wed, 01 May 2024 02:24:56 -0700 (PDT)
Received: from fedora.fritz.box (host-95-248-171-25.retail.telecomitalia.it. [95.248.171.25])
        by smtp.gmail.com with ESMTPSA id z6-20020a170906434600b00a518c69c4e3sm16023678ejm.23.2024.05.01.02.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 02:24:56 -0700 (PDT)
From: Francesco Valla <valla.francesco@gmail.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	fabio@redaril.me,
	Francesco Valla <valla.francesco@gmail.com>
Subject: [PATCH v4 0/1] Documentation: networking: document ISO 15765-2
Date: Wed,  1 May 2024 11:24:12 +0200
Message-ID: <20240501092413.414700-1-valla.francesco@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While the in-kernel ISO 15765-2 (ISO-TP) stack is fully functional and
easy to use, no documentation exists for it.

This patch adds such documentation, containing the very basics of the
protocol, the APIs and a basic example.

Thanks,
Francesco

---
Changes in v4:
 - fix typos
 - collect a Reviewed-by 

Changes in v3:
 - drop the :2016 version suffix, as in the mean time ISO 15765-2:2024
   has been released (and is thus referenced as the referenced
   specification)
 - add details on mixed addressing (all the paragraph about the addressing
   format has been reworked)
 - align some descriptions to the specification
 - miscellaneous fixes
 - collected a Reviewed-by

Changes in v2:
 - rename (and re-title) documentation to to align it with KConfig option,
   using ISO 15765-2:2016 instead of ISO-TP (the latter is still used for
   brevity inside the document)
 - address review comments
 - solve warnings coming from checkpatch and make htmldocs

Francesco Valla (1):
  Documentation: networking: document ISO 15765-2

 Documentation/networking/index.rst      |   1 +
 Documentation/networking/iso15765-2.rst | 386 ++++++++++++++++++++++++
 MAINTAINERS                             |   1 +
 3 files changed, 388 insertions(+)
 create mode 100644 Documentation/networking/iso15765-2.rst

-- 
2.44.0


