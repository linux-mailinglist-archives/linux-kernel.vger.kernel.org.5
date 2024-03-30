Return-Path: <linux-kernel+bounces-125692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 508E4892ABD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 060141F22019
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635E72C861;
	Sat, 30 Mar 2024 11:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoCO+RS5"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E54847B;
	Sat, 30 Mar 2024 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711797877; cv=none; b=QgPMvIw4mfbh9VMpvmv8TZ151Z+oGtt+6XC04JjYZ9QLYvT5uQe6T64HkymW5cob8XrRl+B4LoF0rCyoQkdtY2TnF8Z9utJjTL3QVLF69PeUP6FZtBU9DMufI53WuDf8niRTuyjolr3gT2Bce50ks3O32c770Hr4sa+85Z1kw4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711797877; c=relaxed/simple;
	bh=I02NGCnaxRi9by2gF42e6EGB3pDQOAJ19b/1+lVtkMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kzQQY+NUXDXtgdinSgnPXbTREKTRsx58BjfW8TKIdL+gw01vUuRFNaUzqGiQTPNGr0mxCsX0HfIHuKsaW09c/wTACo7FzDm4bkhxBfzeeeRDRqi12CCYo9fZviaqEBkvzTg9G+mBKc0cdXK3paz8qLHIhovEkK5V1z2RpxAdOIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoCO+RS5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4155bdc0bf5so932015e9.1;
        Sat, 30 Mar 2024 04:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711797874; x=1712402674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x4e1X6/wtbBZaSSH3NYFtpZ3MgjRKbwmGNZdau5FbQ0=;
        b=SoCO+RS538EsPEgEZvBKVe+qqIOxcq+Lpc4DCDqMhwTX2SxGUcUSQd0DscGvUaKEE4
         IAU0EWd6+aXKK5Na23CO6j6t7xmXAcUU8gqnAy4xnm1WU2VeTuDaMrPgKVlCl8UvoewL
         pix9T2QMPhgMRdbMG37XlOKsck+uh3zjzTtCbPTWlwJ5ih981/LEk7yYA52SsAF+mNqB
         UzLckere3/oR+Fjv6r6vFk16uxDWM//cQpxi8wxy7YHCcDOAlPqq83IElFaqQMsYQH+T
         mYuYZg+hqVVC6siKFuTsvoM2F7S1ZrU5czuBLHjLAcLPlQr2o/35BnKenjjc94GYUJko
         jKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711797874; x=1712402674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x4e1X6/wtbBZaSSH3NYFtpZ3MgjRKbwmGNZdau5FbQ0=;
        b=MSLHXhCaifZperEn2F1nTvq+/896m4Wn+Wsqto2zabHEnro9EwaM90ui72Ssvoy34u
         Jf5TlndKpN9NwfBH2asNAnJ3ayWl0O91XrgRRI8Ay/bjSGMimIp8Zy5BE3VmHNpZYzNK
         021paK9z/S9RrofkKuJiWwaSrMGUAt3HKjKTpKABxjtFvy7pqZsSGrTaV2o9z/Uhxb+4
         DoKSWQ6uWAz1Veaiq6R3lxTAiRlXqoxNgqUOo9Hgr30+q8pIewsPFh6ozF+TS9eaHfnl
         350TnliwoYGBOa+9U+3H17YrNM8Q8qFrMQMEGH4coDqF7LOM3RSqbvUYJ4Prrl/HRg22
         HYpw==
X-Forwarded-Encrypted: i=1; AJvYcCXqFB7PXwU4/KiDyFUGCJ/8CwAAmDGGE1s+8BQQdCSgtwQNAyAsipmjWytqj774rJxTRoIsMnloVpSKHwN/neobeycivU+WIB5X+PVRoQFfA0fzARnLaGcmNwFP+0tsadci8NTW5q8+8z/8tN7g/L06QiaJOfX7hCwe3+Jzi8LFwmkp1WoBCnT44CBP65kx
X-Gm-Message-State: AOJu0YyGmfjVmH83uYiaZMkqdc7jXxrFdElFTIPZNKr7C0Etm8Hjx+z5
	gSQPReYTGNKxyswinoh44M1xHc2hdPRnLXUAWLfx2NBS+WpkGl/cIaRaEh++
X-Google-Smtp-Source: AGHT+IFe1w7BdVt6IWldVDlgzg+Pmkd1rmqFcvaqx+zpCRs9G6L6k5G8GIt4alPGs7zC8zHYsLfW3g==
X-Received: by 2002:a05:600c:35c5:b0:413:f4d0:c233 with SMTP id r5-20020a05600c35c500b00413f4d0c233mr2865778wmq.35.1711797873961;
        Sat, 30 Mar 2024 04:24:33 -0700 (PDT)
Received: from xws.fritz.box ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id m31-20020a05600c3b1f00b004146750314csm11441775wms.3.2024.03.30.04.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 04:24:33 -0700 (PDT)
From: Maximilian Luz <luzmaximilian@gmail.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>
Cc: Ivor Wanders <ivor@iwanders.net>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 0/3] Add thermal sensor driver for Surface Aggregator
Date: Sat, 30 Mar 2024 12:23:59 +0100
Message-ID: <20240330112409.3402943-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for reading thermal sensors connected via the
Surface Aggregatgor Module (the embedded controller found on all modern
Microsoft Surface devices).

The EC can have up to 16 thermal sensors connected via a single
sub-device, each providing temperature readings and a label string.

This has been developed together with Ivor Wanders. For more details,
see the following links:

- https://github.com/linux-surface/surface-aggregator-module/issues/59
- https://github.com/linux-surface/surface-aggregator-module/pull/68

Maximilian Luz (3):
  hwmon: Add thermal sensor driver for Surface Aggregator Module
  hwmon: surface_temp: Add support for sensor names
  platform/surface: aggregator_registry: Add support for thermal sensors
    on the Surface Pro 9

 MAINTAINERS                                   |   6 +
 drivers/hwmon/Kconfig                         |  10 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/surface_temp.c                  | 243 ++++++++++++++++++
 .../surface/surface_aggregator_registry.c     |   7 +
 5 files changed, 267 insertions(+)
 create mode 100644 drivers/hwmon/surface_temp.c

-- 
2.44.0


