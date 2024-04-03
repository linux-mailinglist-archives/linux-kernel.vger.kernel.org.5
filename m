Return-Path: <linux-kernel+bounces-129791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56CE896FF6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51AE428FFA3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1668147C96;
	Wed,  3 Apr 2024 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvCPfL53"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AF7147C6C;
	Wed,  3 Apr 2024 13:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150137; cv=none; b=eLAMmBw06ERAEVNKiKVEtJiSyx02yPV4UK/sYdsDLjcO2g3N++gzcxKeAqAu/GZYqEfGSFvgcZ9g7mbwiPrvuZIyAHwWSDxyA85hyS6pEpGL26KRD0WcmQ3YJtq3BfpYZo4uheL0Uv3eCywV9+iymHQBevOayg1NT1/tCXSmZkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150137; c=relaxed/simple;
	bh=99Sd3x5Xh1f02Tnql1T2bE/GVVfEXYhK1ySRwme2Zjk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CIx2xL8IurZzNFBHkZH7nCU0XgEcMLUauFWEQdk2+9aWHidlb9IuveAbZSyG6PlQVpMiCdU10iLDI0PxaXnO85+TkXiJ1mdA+fLwlxjVBAMmkggoVzbGeQTtpyM9h8cToNOteHim2bPaIDo6fTGS4r6JBijePlXTpBQ/F0PYZ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvCPfL53; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e0878b76f3so7857475ad.0;
        Wed, 03 Apr 2024 06:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712150135; x=1712754935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vryS7oL+jDPlvXHR7J1pUsOMtwPuprIobWABdrxaKrA=;
        b=SvCPfL53OeFmmMQw3kueZMNRaZ153pVDUthDgeqQ6RlOFJuoEGCErie4d7aq5be77F
         FcFgUHE/z82o/JO+ocmmFt6Z4zAi80XHl4V2QQiQJvWP+lt+ufOqHb/iNPYkxiQPseVa
         QGGunckiL/ksOo7j/6XdK1cBRksir7Hn+zpUFDcjS4t+GQCPEfi8ganiHAfi2nyF/3LT
         zKR24ZOKvs02Yi4w8R6cc2xOpnh/3HPjeN9hHKeF9PEPNtdHH0mrZ7vSl4Ip8285es98
         minxJBLQKpLinUeGjF5D8DnTONPhfvR4JJb/ZN/pcI7z/yAi/ypAaGWwHBZdmZy2XuIp
         ZFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712150135; x=1712754935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vryS7oL+jDPlvXHR7J1pUsOMtwPuprIobWABdrxaKrA=;
        b=addCamtdt+PB26oeNKqjhr/6ipU6OhfG76jRbMWb/83FcjOtNXlWbW2i9gkHIVJVY6
         /HGnyhIqirmotofyNHgt3F1bqA4UlIGHesKiXaVjlTzjtIYMfcP86opeURjlcQOkRAWc
         r1qxHBvcoXHsVxYGmOwZnmI08SYKYI9BQnqwLwEyhErMmdFPIqZpthcWBMDdK0Oo07E7
         MWZ3O44VgkZEWC7g7ZqqBTZmHflvyspXrFRRqm0NKmRk1VgBp+PreVovq6qw6zz/y1qw
         mphvR+RTXCWU1PI+XDm212zWBJMzCdjj8bzjTImoFV+jegz1l9EJbY3Sad8hj+grZwvW
         QEHA==
X-Forwarded-Encrypted: i=1; AJvYcCWpXTQkbqlW8kpEjuXnMW9pSdhYF7EM8du/uyBWrZZw0nAOQbfktjH/fOfuZWWTQvyGYU1/Qjwr6agvun8iPdZ2UJ16qM/bfUO3Qw==
X-Gm-Message-State: AOJu0YyNz80Ye08GiXEJg6azlgHov6NLPbhqcJ4DAlbmzgZJbrco4c/n
	DhMS5NJUMJfbJe1zQjVbDIPOZt54YxJbJc9WHJSB+8S5gXasDQP2t2n3PPO6
X-Google-Smtp-Source: AGHT+IH/o/OdeDTGk0CkkreQTj2PkHzoSqNF4sSYyOvqPozKaQCJbacYUHOEK+/1WMkqnsr3tvWSdQ==
X-Received: by 2002:a17:902:dacd:b0:1e2:6482:db0f with SMTP id q13-20020a170902dacd00b001e26482db0fmr3247603plx.29.1712150134970;
        Wed, 03 Apr 2024 06:15:34 -0700 (PDT)
Received: from rigel.home.arpa (194-223-186-215.tpgi.com.au. [194.223.186.215])
        by smtp.gmail.com with ESMTPSA id e14-20020a170902784e00b001e010c1628fsm13417604pln.124.2024.04.03.06.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 06:15:34 -0700 (PDT)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 0/2] gpio: cdev: label sanitization fixes
Date: Wed,  3 Apr 2024 21:15:16 +0800
Message-Id: <20240403131518.61392-1-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a couple of bugs in the sanitization of labels
being passed to irq.

Patch 1 fixes a missed path in the sanitization changes that can result
in memory corruption.

Patch 2 fixes the case where userspace provides empty labels.

I've placed my Patch 1 before Bart's Patch 2 as it has to relocate
make_irq_label() and free_irq_label(), while Bart's patch modifies
them. This order keeps the patch sizes minimal and the attribution
where it belongs.  Patch 2 has been very lightly modified to rebase it
onto Patch 1, including extending it to cover the modified error
return for the debounce_setup() case.

Cheers,
Kent.

Bartosz Golaszewski (1):
  gpio: cdev: check for NULL labels when sanitizing them for irqs

Kent Gibson (1):
  gpio: cdev: fix missed label sanitizing in debounce_setup()

 drivers/gpio/gpiolib-cdev.c | 48 ++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 16 deletions(-)


base-commit: 782f4e47ffc19622bf80b3c0cf9cadd2b0b9a644
-- 
2.39.2


