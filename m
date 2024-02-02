Return-Path: <linux-kernel+bounces-50502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2788479F8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160D01F274CD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299F580635;
	Fri,  2 Feb 2024 19:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nR/Rc+Nv"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9A58175F;
	Fri,  2 Feb 2024 19:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706903607; cv=none; b=cjV7w2H7INHfjNL4u93SMDlSXQriMjC6ASIlQ9q0YRSmnI52MkU1HQofdft44VLhgbdRjN8HAGEUipSEVVCV9JHZiJwivmdy2+nATMULvZvIefOmrvKzItis0ITn5MkiN45ah0WDg1ma43DQ/EbFRKdMRYzly7Hd6V8+3/lbtPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706903607; c=relaxed/simple;
	bh=y9CPof6+weJZ90idQr8vFZCmimYUO08YPbLC5Rk2XFM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V2Dv8xcr5rLVMp9KZ3v0GE0tr95X/F+BOYsnlAv0jiHVT9KzXp8B8xQSwRr+yxi+y8AYKChfKVdWKMOjRCTQ/87ISXMB22qMGLAIXCRQSzygP5JKUxO/CwPPM+NQC6PmNd9ZExenRQQyUgMnKrl50L8zah35Uy/LDfC0zmWAkCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nR/Rc+Nv; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6de287449f1so1735648b3a.2;
        Fri, 02 Feb 2024 11:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706903596; x=1707508396; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pEX04GHs2TY1yrUpMLFp489utbKDIJ1QmjpEDT80Li8=;
        b=nR/Rc+NvdZYrQGhI/1VvjFNb21PceZmG8Q0cF3/tFGS1KQF5SsN6R/rhEmsC6e5v5E
         kLZa9RuOkfhwy7pjztLx4LH6BQwB2Iv4J5kHDK8/sCaPXmaxvl+N10qndebXdbwvCT+e
         MGsE9YVsuCErFAu1r4sSYjGSxllPjx5B7z7DvXfmds/Qk6ggBwbjg3JQBoEdNZbd5FE6
         tNpXl/9V1FRnEvBe3+7ZTnGgOTGTjKyOidKDmyKl3zvALoEdjP5H7GhOesy/liBbsvXK
         sjnlQJ6tr835XhrIuKHXlBMyWUQEh5lH5bWJ3xdV9A4vsCXncF6pJu58eJKre0WbTZJ8
         HQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706903596; x=1707508396;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pEX04GHs2TY1yrUpMLFp489utbKDIJ1QmjpEDT80Li8=;
        b=AiH662mv04+K1ae1mmuckPEFtF4lJzvBVCo3mJkuIHxRExajQ5hBKFKXZCcgJh00Sl
         gZdx+qUCywWmWMFQwVhAHwyPOh2RPfE4JWbwXfYrq5yy9upFOoILP5tXuRtjk7cK4YO4
         wH4BAPTNpaJ3JaOFVtAy/jMOVk+krDplOfZ1VNPW9BLlBTR7s/KU4JtuBsyY89SGHqRs
         g98gFQTWsplBvxYxog1ikqwlL37gDN40cmVtUs7lIpdyox1qo0vJYs3/uXV7+4mjV+cs
         YS1dgAZhw1t7M0ozl+1R4FgWQrBl7pdlOgGVxXAQDW/YdwOwxnsbjrf4dOgNuX1XeO0M
         zsWw==
X-Gm-Message-State: AOJu0YzQxs2Zy3HP//OlsAKyVusmvQTsLDkn1FZlrlxW4WdlLtOG/pKK
	nA98ZceL+xslB9ucXdJvEabieiBkPi2wvniHtqm2SbwiI9wpwVLi
X-Google-Smtp-Source: AGHT+IFsrhQ86WJEX11iXZxHiEA7cKVixtXRAzDz5v8qGUQSJ1SAe6vH89vYUKa+vGhhNECIm4DW3Q==
X-Received: by 2002:aa7:8c48:0:b0:6d9:b9b4:8ca with SMTP id e8-20020aa78c48000000b006d9b9b408camr8765723pfd.28.1706903596462;
        Fri, 02 Feb 2024 11:53:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUcA24CxtkUNk1HKIW57bt2Yn8/sgrl3vr3/NEnFXZX3YNZHGoJ519CEhWXtYlVHDIkIAa2CjTGCs3E5SztkqCXa4rvUxN26y2OZ3Jf/g/3LmI7t+R44IxnWBL/Ep7tUdMyo1ni2gU=
Received: from google.com ([2620:15c:9d:2:d093:a15e:90dc:f5f8])
        by smtp.gmail.com with ESMTPSA id b23-20020aa78717000000b006dfed5251easm2010164pfo.76.2024.02.02.11.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 11:52:23 -0800 (PST)
Date: Fri, 2 Feb 2024 11:51:32 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v6.8-rc2
Message-ID: <Zb1HxLM3Vs9p4MiG@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.8-rc2
 
to receive updates for the input subsystem. You will get:

- a fix for the fix to deal with newer laptops which get confused by the
  "GET ID" command when probing for PS/2 keyboards

- a couple of tweaks to i8042 to handle Clevo NS70PU and Lifebook U728
  laptops

- a change to bcm5974 to validate that the device has appropriate
  endpoints

- an addition of new product ID to xpad driver to recognize Lenovo
  Legion Go controllers

- a quirk to Goodix controller to deal with extra GPIO described in ACPI
  tables on some devices.

Changelog:
---------

Brenton Simpson (1):
      Input: xpad - add Lenovo Legion Go controllers

Hans de Goede (3):
      Input: goodix - accept ACPI resources with gpio_count == 3 && gpio_int_idx == 0
      Input: atkbd - skip ATKBD_CMD_SETLEDS when skipping ATKBD_CMD_GETID
      Input: atkbd - do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID

Javier Carrasco (1):
      Input: bcm5974 - check endpoint type before starting traffic

Szilard Fabian (1):
      Input: i8042 - add Fujitsu Lifebook U728 to i8042 quirk table

Werner Sembach (1):
      Input: i8042 - fix strange behavior of touchpad on Clevo NS70PU

Diffstat:
--------

 drivers/input/joystick/xpad.c         |  2 ++
 drivers/input/keyboard/atkbd.c        | 14 +++++++++-----
 drivers/input/mouse/bcm5974.c         | 20 ++++++++++++++++++++
 drivers/input/serio/i8042-acpipnpio.h | 14 ++++++++++++++
 drivers/input/touchscreen/goodix.c    |  3 ++-
 5 files changed, 47 insertions(+), 6 deletions(-)

Thanks.


-- 
Dmitry

