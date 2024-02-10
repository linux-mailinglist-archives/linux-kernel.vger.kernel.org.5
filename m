Return-Path: <linux-kernel+bounces-60547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A3085068F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 22:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B611F22BF5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09EB5FDC2;
	Sat, 10 Feb 2024 21:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sf3LnEpL"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398575C022;
	Sat, 10 Feb 2024 21:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707601957; cv=none; b=rhiqgo07sVk359A5hETrilPtbUGzSx+MeOCWo10/jVZS4mzXPxJapNN/DXRKLB6wdo/m04XBGvf/85RysF30O1Gghk8pXtdhX+3POSt/zw12c9k8L0vwO+wq+uwyoO3paOt9q+AY7ULYStocEx8Doc2ChFHVtqd/reUPDfGM+k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707601957; c=relaxed/simple;
	bh=Ys1+3odTiU5YLEkSLRubYMf/IEMzPTkwTdS/Nel+O8k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HMiMRZPqAYbEYBm0cyYqMXgXypxrhxTCmy6SUHeR8fTGo2oUDsEERzS8UXvZKbdrZp2gs/FErpaDQin/B+CQZNErtbFQSi+quNCrvnXVCS3h3RYdqGAkZmWbfisx85woK3z2YtJgXoLDoLdbDQyBAZTr+8lWzrQ87CNj3Nhg1N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sf3LnEpL; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5116b540163so3043573e87.1;
        Sat, 10 Feb 2024 13:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707601954; x=1708206754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LmCihYrQQrWYTreHIvikjN3i8HFfYK6bdj8vueCUR0A=;
        b=Sf3LnEpLaSDbBhnXEAsf0s/64g7xc6Fe1eH+iwVw4r3EjJMjFocMlWCv8zLgd3G0Uc
         JXXKkM3S1lubrRHDyC+T6KUeMaway3CFZNieIpv3UCS71SpIiZky4Ww7kYv7Uxfpm8Sk
         HxYo3TtaR48ktyIIlL/0n0xx2+PfHAvgH1wmkNuJjQVO3Ub+N+CB4a8Qd50/pS/0Wpv0
         8gfijPqh4LTA2g1m5ijq+Igcf2dpzLGGEa4mSc+yuUc3E0FRE+JYI189x6mrvfePUSh+
         4GAuJW2VWTX/zI58+SHZ2Wjb2mNiuby3l7f4LWqlH0C+5LaU1l10JpHCqWkqbNX46GvP
         ikQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707601954; x=1708206754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LmCihYrQQrWYTreHIvikjN3i8HFfYK6bdj8vueCUR0A=;
        b=jQ4uWMdrXrgSsYcIkkNqS1eQjWQhD3WpLluoVA3Kd8zZ1n9lsbJWxqFVRVOFGOe+lQ
         B0ph0PPMUMl/0PoFt9/NTmVVOlPW4dSxICpUdhSnfILBHovIts8scy32lA3iXIYh2SXC
         6DZPeAsC8sAxD5/KQCc4E/n03r59Vq+uX1xpow+xEgioQNppPmDkXMKpRrJq0JOmoAFu
         lw1XdLow40wQeMHumwA4GTmLcPZ9UZllAoYBiGT2e/4hgKsmFzpY/60FGMJ62w6KBcst
         iXGHYcfwqyCyKRkSs8ci9QxU3HYd2wS6PBKlVbWrtW9zO+t7Q2/pOTgWX6bKqBiQYc5K
         +SSw==
X-Forwarded-Encrypted: i=1; AJvYcCXZpCIEvwDGtHc40xkYf4NEql6V6qtEdPxHMk7pWzW7zDk8VjzB9Lwldtpl5ULDifGHv9nSsGYAaV1VYqfTBTJJ1mG6+gXyv3+epiriyskSIOyr9f83z49FcvZcA8JqmGtCm4S90AZV6EM=
X-Gm-Message-State: AOJu0YwW46Fnz1U4UeMuAedmJ6vpUE5j0qdCPn62ryZYnBQnmqc97PHz
	jXTlws3+D3aLcJyvNGfy+5Tj29h/1wjy/JUUxz4I2wha/QWWGOtK
X-Google-Smtp-Source: AGHT+IH2CP4Zj6CN+HgjYeEwvcCUyz1iGzkVAiHL9+6dGzOAf38xvhQTZCs/zh/jUGHoxfWZEFCr1g==
X-Received: by 2002:a19:691c:0:b0:511:720b:6c93 with SMTP id e28-20020a19691c000000b00511720b6c93mr1361638lfc.27.1707601953906;
        Sat, 10 Feb 2024 13:52:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUAc9M5DbfswW3g4ma45Q6szTF106PQ8Qs0T3p2yYo3Ss8KED7kJzMkicqo5YfovZ+3UadZUweVNzeI5fUHXR6z+bdkp84do/YV+UnPDx2MCXxEUkOUqaG5SPRmCTZG8o39Y7b/bx4aHv0oCnjckzDwF7TWI65VhUSEJUKAe+QoEsYVdBZFWbLf9/tZZiHnHe6/Fw9J9LQXyMCW5ES7EVKCHX2XigRoj2oPyfOOv6t+7Cx3kOJ4W8OpQVMyfN7y09Rjg5O/I5uvUSAWe80PkGBrkMRTOATOZO7oRotqUtUphIQf59r1/V3uh6SUpuOygFQdqoJ6KLqai/ThmTXDmN0iKx+xg5xbNRuOhL9+WGIxtoU7PIDSjg==
Received: from m2.. (89-139-223-180.bb.netvision.net.il. [89.139.223.180])
        by smtp.googlemail.com with ESMTPSA id a7-20020a19ca07000000b0051189b53f93sm24005lfg.302.2024.02.10.13.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 13:52:33 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: chrysh@christina-quast.de,
	daniel.beer@igorinstitute.com,
	jikos@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	johan@kernel.org,
	gregkh@linuxfoundation.org,
	equinox@diac24.net,
	michael.zaidman@gmail.com
Subject: [PATCH v1 00/19] hid-ft260: Fixes for serial driver patch v4
Date: Sat, 10 Feb 2024 23:51:28 +0200
Message-Id: <20240210215147.77629-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Modifications on top of "[PATCH v4 RESEND] hid-ft260: Add serial driver"
https://lore.kernel.org/all/20231218093153.192268-1-contact@christina-quast.de/

They are mostly the fixes to the original v4 patch and should be melded into
the v5 patch rather than upstreamed as separate patches.

Michael Zaidman (19):
  hid-ft260: fix incompatible-pointer-types error
  hid-ft260: fix Wformat warning
  hid-ft260: fix i2c driver regression in ft260_raw_event
  hid-ft260: remove dead code in ft260_uart_receive_chars
  hid-ft260: fix unprotected write_buf concurrent access
  hid-ft260: uart: enable wakeup workaround
  hid-ft260: depend wakeup workaround activation on uart baud rate
  hid-ft260: depend wakeup workaround activation on eeprom config
  hid-ft260: uart: wakeup device early to not lose rx data
  hid-ft260: uart: do not configure baud rate twice
  hid-ft260: uart: do not disable wakeup workaround twice
  hid-ft260: uart: use kfifo_avail for fifo write room check
  hid-ft260: improve usb interface type detection logic
  hid-ft260: uart: cleanup and refactoring
  hid-ft260: uart: remove FIXME for wake-up workaround
  hid-ft260: uart: suppress unhandled report 0xb1 dmesg
  hid-ft260: uart: arm wake-up timer unconditionally on tty session start
  hid-ft260: uart: fix rx data loss after device reopening
  hid-ft260: uart: improve write performance

 drivers/hid/hid-ft260.c | 330 ++++++++++++++++++++++------------------
 1 file changed, 185 insertions(+), 145 deletions(-)

-- 
2.40.1


