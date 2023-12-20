Return-Path: <linux-kernel+bounces-7429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3187B81A7D2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D3BE1C229F8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 20:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AD5495E9;
	Wed, 20 Dec 2023 20:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1HI8gZH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090D048CD0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 20:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2698eae0a9so7558866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 12:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703105782; x=1703710582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8I8zO43Yl4bfGhZzZqKg/Gg6wP9iJHOVMkeKuIcZamA=;
        b=O1HI8gZHj4ZxwvGujRO0xnZKb+jOoqwp3DS5r3dCvcENscsAodv2uUkCmiAI5jxuxu
         CFKfx57ECx/I5dClkv0z4tmutnEVD5S8QzprUk6/EeMnAnqQPzv1vT7LqOZKF9nRB3Bt
         X+IDC7w9EZRM/qqaZMj3pegK/DFXVDb6y7fEp6GvkvRdZOKqAIBriWDv/O65xmQiAb4p
         kWrL4RTlKe7ewMgeVW8HKlMGD3Ot6baIGiZGDs2rUqhYG993YgXyqN7X2RpQ0P18aTO7
         mK/dXN8Vp9VPAGjfiUyFGIjEFBUKT1VzB5xoN/0oB8q1g60ulCK72gW5cGJsSDwTx0C7
         uhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703105782; x=1703710582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8I8zO43Yl4bfGhZzZqKg/Gg6wP9iJHOVMkeKuIcZamA=;
        b=Dx+hky+sA/Dt9w+iKUgl3vqmDaMAQW/YvmHbRPvsUVk8l4xWuvRlLfHiD17B4gTIql
         U5X5LsIdNrx4ErIeGenO5rtaCADxzxOHKVNGjSfDvDaMK+Kbc7leY3u4omfX39h8PaCY
         mZo39unTcQPD+wo6sekh+rP68v8+gUyEDhr/VjOljwlqaCtZWadIN59kd8GpPQxioB8y
         X4t1297wlHqdGXeaLq5uludupEFg8fbsESsNSsNC41jjCGejW0rEIzHo1qK3znJ8vPqd
         SOb6VIWD05HFDm4wn7dSaAmaP9p+KPBjDSfcYMRbBNqBn3QnLOtD80U+IJ5c9GHpCVYy
         agMA==
X-Gm-Message-State: AOJu0YzrElc36MHXgJKQeU0tpRg6aguGlRj2YLP8Wx5ppwrx5Oi9fnok
	ig0Zd51CP5Bt18eg3yvSftXnETnMo/jY
X-Google-Smtp-Source: AGHT+IEOW6xvr0kD6LygxaRwA5j/3Ti0VAaTJ2iFYInEkyEhDdz+IKy7QWRhTGy+QoFy4oSfCKGf1A==
X-Received: by 2002:a17:906:5190:b0:a23:6058:5925 with SMTP id y16-20020a170906519000b00a2360585925mr2880394ejk.34.1703105782143;
        Wed, 20 Dec 2023 12:56:22 -0800 (PST)
Received: from alex-pc-ubuntu.lan (31-10-153-16.cgn.dynamic.upc.ch. [31.10.153.16])
        by smtp.gmail.com with ESMTPSA id w10-20020a170906d20a00b00a1d9c81418esm204377ejz.170.2023.12.20.12.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 12:56:21 -0800 (PST)
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
To: alex.vinarskis@gmail.com
Cc: andriy.shevchenko@linux.intel.com,
	hdegoede@redhat.com,
	lee@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Fix LPSS clock divider for XPS 9530
Date: Wed, 20 Dec 2023 21:56:19 +0100
Message-Id: <20231220205621.8575-1-alex.vinarskis@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231220073148.19402-1-alex.vinarskis@gmail.com>
References: <20231220073148.19402-1-alex.vinarskis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks to Andy Shevchenko for the review and suggestions. Fixed
accordingly.

---

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

Aleksandrs Vinarskis (2):
  mfd: intel-lpss: Switch to generalized quirk table
  mfd: intel-lpss: Introduce QUIRK_CLOCK_DIVIDER_UNITY for XPS 9530

 drivers/mfd/intel-lpss-pci.c | 25 ++++++++++++++++---------
 drivers/mfd/intel-lpss.c     |  9 ++++++++-
 drivers/mfd/intel-lpss.h     | 14 +++++++++++++-
 3 files changed, 37 insertions(+), 11 deletions(-)

-- 
2.40.1


