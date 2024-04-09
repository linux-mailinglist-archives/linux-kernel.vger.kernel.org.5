Return-Path: <linux-kernel+bounces-137413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDED89E1B4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 805631C22A5A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D57D156869;
	Tue,  9 Apr 2024 17:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JJjj8H6x"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B988155390
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 17:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712684492; cv=none; b=HWw8TkDa+Oz+YuP4WPWzvtNkSlHX58gW7/J8vAHQw+znBkkQLgTawa1gycusHufWtwIYjw9vGbVIDuIgvS3slerYOnSiBdeEOGhSvhomJFoCRTbSXQ6Od3JftjzO4BMdFgDrOEIdrPSjMsirMQWk2QLdP/ZndwwxMS4RWDjdyT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712684492; c=relaxed/simple;
	bh=unos6c4MHrzRTe2hgteD1gsusU+s2n+AHu5YvsvKRjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hNlfb7xMmUH8kZEAwgOPQiyZKHb1xbDOdkah+d+dQ6sfWpqRbUOS1fGw8EIdrKCa8ERpyjoA8LALHu3HX2qxa6Kcx73l3mp9b5s6hrCuj7TWRH6DhpaX24DQVbJ8ZWvc376TuA17cc8dCz/KKrxUxUgG71q/OumTt1LVTCcVU4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JJjj8H6x; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78d57bd5781so214972485a.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 10:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712684488; x=1713289288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8oYCODPGJ0bN2MpITwTfd+iJcVjHgLaVmvJQk/UGr/o=;
        b=JJjj8H6xs9rHjJi+xJjysxP9DO2wt/fSdQmV36MM427dbVN0QP6yx3tF+uH3+CssJ1
         DA2QCXKzqkC4Iud8CJ3CmoR+zCzu6264nyWjkUCpdmqR7KPs+6xBJGHSC9vwJbj4j0iv
         za1waKvPKm8M0lQFY9ebTKxi2A9RjMAQGL/lwJ8naERzhVtruZPnUKKLxGCwxtr0FUeF
         SDVulDxu9/uJT7ZkiO6U8uxAoebwL+z0fyaGDxvmhPfVIxhpZJOUjnFXuMvcXSI8ZCWP
         YzZzIhTHsSrgf80I5BFva7LIzCJ0Jupb7lXwz7vFQYS8xc2l94f3jhgmrSi+OZf6I7sW
         daNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712684488; x=1713289288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8oYCODPGJ0bN2MpITwTfd+iJcVjHgLaVmvJQk/UGr/o=;
        b=dzTMc2+0QWawkDZ2aA69f7EEtnJNo4+8VX3pzZJ01LyaBIv9EJ+M0Vwtf1TmNMwP2k
         /VYu/fc6oNalqaoqrI0Xlmy6KIp4dkL0ZCoCtkGhhOOTstnOIMxknr5VKhJGKWF9kc3o
         igeFK0kM2SmhWSiTwNnbkGwpqXjjkNK7f1KUuJJuQFErs9zxFftFJos3soVISNH550i1
         +HaFb6lRsP9y77+OOa0DDYUDG3DvzHx76Fkh6puZEF3lpOj1A3bB242XjotoRCE2Ul0q
         ZlAwj1Ox3TFeFqviyi7ugJ0iINLAiASjjzDcsVzzslCqM1eUOfbGn7WBqQu/Axe01N6O
         TsBA==
X-Gm-Message-State: AOJu0Yx+S4t4+zpsTb9NUqZwkBp42wOWeMNS/Y1Nbqm+dQnN2NpIK+CE
	UQbWLQtn0M0BGMUtA1aWSYkyCILkPjySCGr1RQ6Tj67cvuHFHRm0mphO0Ed1E1c=
X-Google-Smtp-Source: AGHT+IHGCEPinBO7Yd4QZECySz5Dt83YBfPMasFzUPQv/+wr7ihZEj/8iTd4uwaGBm0ejbCFoUhTxw==
X-Received: by 2002:a05:6214:20c1:b0:696:9b25:3434 with SMTP id 1-20020a05621420c100b006969b253434mr295726qve.15.1712684488262;
        Tue, 09 Apr 2024 10:41:28 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id o11-20020a0ce40b000000b00699437d4dfbsm3828996qvl.72.2024.04.09.10.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 10:41:28 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	tgamblin@baylibre.com,
	dlechner@baylibre.com
Subject: [PATCH 0/2 v2] pwm: add support for duty_offset
Date: Tue,  9 Apr 2024 13:41:24 -0400
Message-ID: <20240409174126.1296318-1-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series extends the PWM subsystem to support the duty_offset feature
found on some PWM devices. It includes a patch to enable this feature
for the axi-pwmgen driver, which can also serve as an example of how to
implement it for other devices.

The series was tested on actual hardware using a Zedboard. An
oscilloscope was used to validate that the generated PWM signals matched
the requested ones. The libpwm [1] tool was also used for testing the
char device functionality.

Note that in addition to the other patches in this series, the changes
to the axi-pwmgen driver rely on [2] and [3], which haven't been picked
up yet.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/libpwm.git/
[2] https://lore.kernel.org/linux-pwm/20240301173343.1086332-1-tgamblin@baylibre.com/
[3] https://lore.kernel.org/linux-pwm/20240314204722.1291993-1-tgamblin@baylibre.com/

---
v2 changes:
* Address feedback for driver in v1:
  * Remove supports_offset flag in pwm_chip struct, and references to it
    in the axi-pwmgen driver patch
  * Drop pwm_config_full patch entirely
  * Don't return EINVAL when state->duty_offset + state->duty_cycle >
    state->period in __pwm_apply(), since this is valid as long as
    neither is greater than state->period on its own
  * Add a check to disallow setting the PWM signal as inverse and a
    nonzero duty_offset at the same time in __pwm_apply(), with a
    comment explaining why

Link to v1 (RFC): https://lore.kernel.org/linux-pwm/20240405003025.739603-1-tgamblin@baylibre.com/

Trevor Gamblin (2):
  pwm: add duty offset support
  pwm: axi-pwmgen: add duty offset support

 drivers/pwm/core.c           | 82 +++++++++++++++++++++++++++++++++---
 drivers/pwm/pwm-axi-pwmgen.c | 34 +++++++++++----
 include/linux/pwm.h          | 15 +++++++
 include/trace/events/pwm.h   |  6 ++-
 4 files changed, 121 insertions(+), 16 deletions(-)

-- 
2.44.0


