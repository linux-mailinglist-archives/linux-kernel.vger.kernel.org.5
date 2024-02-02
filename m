Return-Path: <linux-kernel+bounces-50329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C81847779
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD251F26038
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BC815099C;
	Fri,  2 Feb 2024 18:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3LLeq3E"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4755114E2E6;
	Fri,  2 Feb 2024 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898615; cv=none; b=Nhi6eWqOjF1j9eS9pRU9feqJ73NFrTMN0VxvIdeAbeNuhDLuT4GtP7pYE2ga91QdpJEFsceBcxYhksQZdGGA23gj2AMPU0W/NPRvqxc//WF2iplQLiBHd/A9y2IsVQU0LvRe8wQbh1sUafSGo2jL3qlKz8nyCkfKBd3pEu296vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898615; c=relaxed/simple;
	bh=HEqr0Ka0XfhTPzD0Hbv7z55pk+epJSYZPO6YlCuwLtk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JOMofc2+JxJXzQ/1HsrZaKBVtlzMwiXzWnUF/peX759zvgE73yvoBQdIVxyviRJSPTAZ4vJoFhnQoyviNE2FDulT+1JzGFzCeDasZe+OHH+nH0JFoygIFgUKYhimYz7RrESyzST/WilzRERiOLE5cqVGg2cOXdp3XxaoMSGXuVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3LLeq3E; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ce2aada130so2288691a12.1;
        Fri, 02 Feb 2024 10:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706898613; x=1707503413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1+tnDh49EEgOrgjB9N3P+ro3Ir4pX+HnP3v58dVzwIg=;
        b=D3LLeq3EczNM1RtsNu6rxMLrsri7be8NtJ/y1gcmqE1hycFl2HSkZqUkbwM6uL369F
         4G2b4NBgcD2pFgRZv9fvQYzBwjDtoW1wPpczmoF9xp6hb2N9nuCHtgkvLXjvItTfEpkr
         qP+LpS55tZUAJns8XMvkQBco95zRw7qgB186BmCWiS41HtqHzdQ7Gbvmv8werCyulHKo
         YnDzYXWU400ToSiTLjYLB6TToFcF5/MkT4ACz5cbG7cu6xt8tWrezZvbko9l8oyVbhu5
         YPTM1dko9TdY/cXmnfqH7zRDUHFwy7fe1KKu3xhA1P+Ok60l0TVWvJJkl8nBLlAD8HW2
         JfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706898613; x=1707503413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+tnDh49EEgOrgjB9N3P+ro3Ir4pX+HnP3v58dVzwIg=;
        b=n2ynrza1+MDBcEtQ6cxlfyADopJm2xRh+6li5a7xGg8Dm+jLv6WTwzMn4riH4yNjdH
         DeNRbPWjYnNW0lPpRwtE/rcdkHJu6FuDdaLaUew7l0JUuHKVynK2LM68A0pfRs73RYcR
         cVcyhvT/2FelPLeSDbj/FBvK/d4y7H9YZhJO5yC2510FKU8U9NWF0JJY6C0ul0nfWIVN
         Kpg2J7WL1mOL0c9lxmTTNlFkHLxjJhWKp1CRSJMS1wUVYLEC2R9W9oaDTvovg9Mx4ZCK
         eMec8bUXoRI4BlFNkYVx6SUtJVmz+XAvT6X1oiY6XKqAsCrci515TF7JAAEdw0eTJceA
         41hA==
X-Gm-Message-State: AOJu0Yyu8unR+Bs96sJMARk/sRG0KoSU4eHH5SpOfHHxvY4b395BBtq0
	knPTqExA1QOPSRxu/D3gQvVkwJ5aBtdhiCLGuXSgi8y72rJCaXp+lAjJ+UHX
X-Google-Smtp-Source: AGHT+IH9Cae2OPNMcOUQD5VzMSQxLhBjQF8LU4vJEzkCHDFVFVQ80oBQ7bf2/LXbx1T9uK4/E1bu6g==
X-Received: by 2002:a17:90b:68e:b0:295:64de:c443 with SMTP id m14-20020a17090b068e00b0029564dec443mr8827745pjz.21.1706898613430;
        Fri, 02 Feb 2024 10:30:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV7WOh9S0hu5OS3MynphFWP4wJRwW87yKT6JmMesEGIPijHjAm72zZV+4dw13fbLRj8hgzDCUT0Mdry+56tjxvcQ7AzcROR091ZOLC5
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h5-20020a17090adb8500b002904cba0ffbsm338663pjv.32.2024.02.02.10.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:30:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v6.8-rc3
Date: Fri,  2 Feb 2024 10:30:12 -0800
Message-Id: <20240202183012.1607147-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull hwmon fixes for Linux v6.8-rc3 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.8-rc3

Thanks,
Guenter
------

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.8-rc3

for you to fetch changes up to 915644189c22d9c93e9fee7c7c993b58e745bef7:

  hwmon: (pmbus/mp2975) Correct comment inside 'mp2975_read_byte_data' (2024-01-27 08:03:18 -0800)

----------------------------------------------------------------
hwmon fixes for v6.8-rc3

- pmbus/mp2975: Fix driver initialization

- gigabyte_waterforce: Add missing unlock in error handling path

----------------------------------------------------------------
Harshit Mogalapalli (1):
      hwmon: gigabyte_waterforce: Fix locking bug in waterforce_get_status()

Konstantin Aladyshev (2):
      hwmon: (pmbus/mp2975) Fix driver initialization for MP2975 device
      hwmon: (pmbus/mp2975) Correct comment inside 'mp2975_read_byte_data'

 drivers/hwmon/gigabyte_waterforce.c |  2 +-
 drivers/hwmon/pmbus/mp2975.c        | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

