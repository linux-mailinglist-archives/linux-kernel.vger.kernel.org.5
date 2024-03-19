Return-Path: <linux-kernel+bounces-107539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E429A87FDDA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21DB01C21CF1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F38E3F9EC;
	Tue, 19 Mar 2024 12:55:06 +0000 (UTC)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5983A1B9;
	Tue, 19 Mar 2024 12:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710852905; cv=none; b=Bp1Inxu3yp4pAmVWhdLmWC/GBPCku5FNEYMh7AYfB5D/7DJSBHsR1tgNx3+sdlhYiQQZ886KOOM5RH1ArKVDTXcDXQY0CwciUDLQ0X3zBGJ0Uo1LdzPjbdH3AE782SzLoo3Zix5Xmc7ERFfbJ886Rp0E+LTGW3dIALoUwEXCodQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710852905; c=relaxed/simple;
	bh=Xi3/8H7AtZy593o0zTJ2QBjsf5/ZS6dt9hp+LeefQjw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iAkWwohEDuBpFE1j4y8dUUm60YUIkJjsESVlN3iYKUPmE7Gjdz001c/5ChL/P3g5U5iVXr1OW+LWaXnK2eBA/FjJROmCKqR15Q6A1sYKaRajerKlbFulWsuIQKZz228f561/wSBEHPK6Tj6FdvA0OmOn87YK5DUWiEHJly5rt7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a4930d9c48so903376eaf.1;
        Tue, 19 Mar 2024 05:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710852903; x=1711457703;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FItAIc+unigztXlSaF2FIfikzP4jYYgdXVJjLkQFdr4=;
        b=F8ew6fX08SC/QupbOaJYtd3KcsNMQ/5fjr+HDcmIWXovcdaXpJT2Ox3qVMJgMV1UhA
         QR8zf9gloVW9d2esH7ZD3qbKhYu8T03z8pCDiNgs468Y5Gct16AzsVws6Ijqyy4jY+Nz
         Sn+iqp1oxuxoynBN6AifyvVqveSERSauSFFpu2SW4KDCy6aikF3NqIK2WlbWa9XFEaD2
         R7fnkE49AFr3Y33O+u2bseCLkeag/WGbQkZJkozE8aYCXQbwUlz7mgmFUzjv/q1pSMzO
         CaEjaqxsP+8mH53KlZ9KbPJKL+bSPZjS2M9qxhHZm6S9aTlB8/ixZ28uLseDHQRYuaYW
         eZGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqXKDrVlhjzYeD55eD/aTP6XMX4uu7Q7eUMsZKldj3PGf87tw5IyLVx9PNXK+gu5q6OTwd2/HT+iJBQz1eMsv+hTMRAqKnoeyn30+j
X-Gm-Message-State: AOJu0Yy/LcWCfGbt/m/bGHu/AoZpgCf8U0IxiTIv4xfufeR/Kb41G3Me
	BrgQNyl7mNEvJFBtB/SGPYhis4V5B4415Uj2zJZJsrJSmN1k7DEuvncH8EShce2l2UqemGXmA6k
	lB53WIn5O1bn4+5Bb8wZjGVZADxI=
X-Google-Smtp-Source: AGHT+IETY1Srkw0/ICfLWOLO3fBd+t2GRbhCo9SgbCpO2e2KDScbk7XoVD3j2M6m2n9/sX/P7gMoQCSzqAZaRIo7AGQ=
X-Received: by 2002:a05:6820:26c1:b0:5a4:6e23:e335 with SMTP id
 da1-20020a05682026c100b005a46e23e335mr9943829oob.0.1710852903395; Tue, 19 Mar
 2024 05:55:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 Mar 2024 13:54:52 +0100
Message-ID: <CAJZ5v0gf1UYSyEYKTpsaNFuaL4gEgzGm2715qKoSKKQA233+qA@mail.gmail.com>
Subject: [GIT PULL] More thermal control updates for v6.9-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.9-rc1-2

with top-most commit 4e7193acdecd53e79e341b0f6ab7b19596266f35

 Merge tag 'thermal-v6.9-rc1' of
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux

on top of commit 259f7d5e2baf87fcbb4fabc46526c9c47fed1914

 Merge tag 'thermal-6.9-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more thermal control updates for 6.9-rc1.

These update thermal drivers for ARM platforms by adding new hardware
support (r8a779h0, H616 THS), addressing issues (Mediatek LVTS, Mediatek
MT7896, thermal-of) and cleaning up code.

Specifics:

 - Fix memory leak in the error path at probe time in the Mediatek LVTS
   driver (Christophe Jaillet).

 - Fix control buffer enablement regression on Mediatek MT7896 (Frank
   Wunderlich).

 - Drop spaces before TABs in different places: thermal-of, ST drivers
   and Makefile (Geert Uytterhoeven).

 - Adjust DT binding for NXP as fsl,tmu-range min/maxItems can vary
   among several SoC versions (Fabio Estevam).

 - Add support for the H616 THS controller on Sun8i platforms (Martin
   Botka).

 - Don't fail probe due to zone registration failure because there is
   no trip points defined in the DT (Mark Brown).

 - Support variable TMU array size for new platforms (Peng Fan).

 - Adjust the DT binding for thermal-of and make the polling time not
   required and assume it is zero when not found in the DT (Konrad
   Dybcio).

 - Add r8a779h0 support in both the DT and the rcar_gen3 driver (Geert
   Uytterhoeven).

Thanks!


---------------

Andre Przywara (3):
      soc: sunxi: sram: export register 0 for THS on H616
      thermal/drivers/sun8i: Explain unknown H6 register value
      thermal/drivers/sun8i: Add SRAM register access code

Christophe JAILLET (1):
      thermal/drivers/mediatek/lvts_thermal: Fix a memory leak in an
error handling path

Duy Nguyen (1):
      dt-bindings: thermal: rcar-gen3-thermal: Add r8a779h0 support

Fabio Estevam (1):
      dt-bindings: thermal: qoriq-thermal: Adjust fsl,tmu-range min/maxItems

Frank Wunderlich (1):
      thermal/drivers/mediatek: Fix control buffer enablement on MT7896

Geert Uytterhoeven (2):
      thermal: Drop spaces before TABs
      thermal/drivers/rcar_gen3: Add support for R-Car V4M

Konrad Dybcio (2):
      dt-bindings: thermal-zones: Don't require polling-delay(-passive)
      thermal/of: Assume polling-delay(-passive) 0 when absent

Maksim Kiselev (1):
      thermal/drivers/sun8i: Extend H6 calibration to support 4 sensors

Mark Brown (1):
      thermal/drivers/sun8i: Don't fail probe due to zone registration failure

Martin Botka (2):
      dt-bindings: thermal: sun8i: Add H616 THS controller
      thermal/drivers/sun8i: Add support for H616 THS controller

Peng Fan (1):
      thermal/drivers/qoriq: Fix getting tmu range

---------------

 .../bindings/thermal/allwinner,sun8i-a83t-ths.yaml |  34 +++--
 .../devicetree/bindings/thermal/qoriq-thermal.yaml |   3 +-
 .../bindings/thermal/rcar-gen3-thermal.yaml        |   2 +
 .../devicetree/bindings/thermal/thermal-zones.yaml |   2 -
 drivers/soc/sunxi/sunxi_sram.c                     |  22 ++++
 drivers/thermal/Makefile                           |   2 +-
 drivers/thermal/mediatek/auxadc_thermal.c          |   3 +
 drivers/thermal/mediatek/lvts_thermal.c            |   4 +-
 drivers/thermal/qoriq_thermal.c                    |  12 +-
 drivers/thermal/rcar_gen3_thermal.c                |   4 +
 drivers/thermal/st/st_thermal.h                    |  18 +--
 drivers/thermal/st/st_thermal_memmap.c             |   2 +-
 drivers/thermal/sun8i_thermal.c                    | 139 +++++++++++++++++----
 drivers/thermal/thermal_of.c                       |  14 ++-
 14 files changed, 203 insertions(+), 58 deletions(-)

