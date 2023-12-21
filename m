Return-Path: <linux-kernel+bounces-8956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD5781BE82
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B797DB23E47
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988256518A;
	Thu, 21 Dec 2023 18:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RM3+xrwO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D124B13D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40c236624edso11456185e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 10:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703184706; x=1703789506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cTMwLfQA7I1tcp2MKhomeGoTKIOw/eHpzCKqi24ItnA=;
        b=RM3+xrwOGBTyfWLlkzfuoDTk6kng+4FLaErG8hUuJSC64/dR4P9r9lfj6YRQbDT/Ap
         N03+FRws3DnbTzT263LMG9f2Kd9rAdtetzwsOo/aL7sSBj+RllkErSLrHA4XeCimc7Ox
         L245EODLmO4NYcHqBfKo12JDXfKuZNcS99Eb0bCZahxbEEvrkHn5CU9FBOuIrN+dGrhP
         kXnaZJwQz+/t9tgEurM9guvS62KEusPre9gxYLoVYsfdJrhayDAk3zU35dJPWQxGzVxz
         ONX06imKTsQEHPrk7LHKDWZxKrFuwXgfc7BQtpBOiq9WoAtIatOoqnvpTBMDoW88TP/i
         6FLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703184706; x=1703789506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTMwLfQA7I1tcp2MKhomeGoTKIOw/eHpzCKqi24ItnA=;
        b=g8wcuajplM9Vg7FL2eUbDzldY2RcV22Z+FmwWPIqHoQ2NZV8VOaPIhcg8IBeGYLgln
         lmRktcltzWBKa2BBAp2DmoN1eHNMQXlpNEIU0F8+cY4BHxk8+cPwCoGaVlTz2PlRRyn+
         PRmCHzdiSLJfA1vLzaAzmAanQ8Ufg13JTZSKWwsx+eQ/hudn5qDxLHAKa8MB0uPzlPsR
         NkknsGa7VB5c/bmTTV7HmOABjWkSvqHKhQHNx6BK15YvcoNwaXKVrFXjzTcA5yyJdEg3
         gccp2jTjqd1aXRC92iT/yA/EX9A3zpAjlfE4OvgMBCPQPDiCewEH78r25eWtdVDehzm+
         NXjQ==
X-Gm-Message-State: AOJu0Yw9fsk7rr0QbVSliFxVgKJpC78FVHwN00CS+N8e55OWfu4oEeeT
	ijcXnuSLl/G7HCmS6OtaH9OjDU4NfZmV
X-Google-Smtp-Source: AGHT+IH15fQUqgRYt0A7DItgSN//r68SsWQFgaj7xDRNuisIQA8lQc+BrEAvuT6+Y5MdYsHTeCO4fg==
X-Received: by 2002:a05:600c:2289:b0:40d:4153:5f1f with SMTP id 9-20020a05600c228900b0040d41535f1fmr89073wmf.159.1703184705458;
        Thu, 21 Dec 2023 10:51:45 -0800 (PST)
Received: from localhost.localdomain (31-10-153-16.cgn.dynamic.upc.ch. [31.10.153.16])
        by smtp.gmail.com with ESMTPSA id e17-20020a5d5311000000b0033672cfca96sm2585632wrv.89.2023.12.21.10.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 10:51:44 -0800 (PST)
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v4 0/2] Fix LPSS clock divider for XPS 9530
Date: Thu, 21 Dec 2023 19:51:40 +0100
Message-Id: <20231221185142.9224-1-alex.vinarskis@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dell XPS 9530 (2023) uses spi-pxa2xx with clock-divider enabled from
intel-lpss with the ratio of 1:32767 (Dell's firmware bug). This caps SPI
controller's speed at very low value of 3051Hz, which makes the interface
practically unusable. Since either spi-pxa2xx or intel-lpss should have
clock divider enabled, not both, and SPI controller can have higher speed
than requested by the device, it is preffered to disable intel-lpss
clock-divider, and let SPI controller handle it.

Fixing this issue directly in Dell firmware by setting lpss divider to 1:1
would've been the ideal solution, but is unlikely to ever happen.

Particular driver already implements customized solution for handling buggy
ACPI tables for select Microsoft devices. This patch series converts it to
a more generic quirk table, and adds a new quirk QUIRK_CLOCK_DIVIDER_UNITY
which forces clock divider to be set to 1:1. In the future, devices with
similar bug (if any) can be easily added to the same pci id lookup table.

Changes since v3:
- Altered "{ PCI.." style of quirk table
- Added CC to  Hans de Goede

Changes since v2:
- Added missing periods, moved variable declaration
- Altered "}, {" style of quirk table
- Confirmed to compile for 32-bit without warnings

Changes since v1:
- Applied suggestions by Andy Shevchenko

Aleksandrs Vinarskis (2):
  mfd: intel-lpss: Switch to generalized quirk table
  mfd: intel-lpss: Introduce QUIRK_CLOCK_DIVIDER_UNITY for XPS 9530

 drivers/mfd/intel-lpss-pci.c | 28 ++++++++++++++++++++--------
 drivers/mfd/intel-lpss.c     |  9 ++++++++-
 drivers/mfd/intel-lpss.h     | 14 +++++++++++++-
 3 files changed, 41 insertions(+), 10 deletions(-)

-- 
2.40.1


