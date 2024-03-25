Return-Path: <linux-kernel+bounces-116782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F0288A3D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15802C1434
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6F817F399;
	Mon, 25 Mar 2024 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="JpVBnGXX"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D881181814
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361048; cv=none; b=Ua+l7bD4KE4J+o1Wdcll389UpLH8xlOSIQAXB54UF7RD5HBSQyDdDgzfuhCieoWULtvylG/MXqyUjfeUaBNivDvdKWQaItNfIioYbXzXN9g7xNk8nLbAfhscRtatCCL6b2S6yABv+ibJ55T8uECTS4KeHmFzjlu8b+CXIm/wxvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361048; c=relaxed/simple;
	bh=MfTLVwBpHmT3NhU5IyU2HA2DGd9BDnhPRzctKeGkWdU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tgskOR0ayV+S1xhT8o6rL/NkWmZRawPYSiLToYR2B3EQr1pAj9a/vc0na7NqCF4nLFiIvfWPJYHItOxhk9dYZRvbVlwQ5hwmOrYCUNRbFbr4CXVPVa3jAc0vJSHSq6t2B2p1CDVvGKfIdCNTpIGdO7pDRSWRBYnyJXyzoz6w9iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=JpVBnGXX; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-341cf77b86bso355213f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711361044; x=1711965844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sodtg05G0+kvZkJVm8IsH+PblHBiK83uT7JTQwgljWI=;
        b=JpVBnGXX8Kns4ZaR5LwA5sLy4ES4iGLJHt+AhnGL2s4tJt/VGOkAW/5JGiKqfO/65g
         +8IT0ujtMFbS3TWEY0fiTi6qFh0fA70eAppEn/g1znNUFYq5aIfGSHC5elFV3j2u0t3s
         N8E8dcFMXp9yuWBhrI1paXCGOD2R5Y1wykSsSBaj8Q0lp5g/hR5DZ2sPuT4hLTa/t793
         NkmEv1LGbSBueawBRzNyqNdrcmUEI4eFz6P6eIezMb1iHsRNB3n1eE2q6DrEKVIdZtz8
         d4JNoZh57rlNSp6uWbnz/JLIIdA/vArRc9bEYCGP7vB7p/EpeQaF8ALQ6MqtrjTy7ijX
         8m2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711361044; x=1711965844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sodtg05G0+kvZkJVm8IsH+PblHBiK83uT7JTQwgljWI=;
        b=PKm9/1PtbXX+1YBGZWrLkDL2lDh37jVlf0j77QvwXtyITFxf5ugnZoyxFs/kuf4uvg
         higF+RlFgYrpsn4nm5UuGYoqPKsfmxMYRFnR1vsxdfVrs9ptk27mEJ5kzyw4r/s3W2dM
         UYoIhCHjD388rlkGu/cHOZRyvEiciq70J5h+o/Bb3757INI8LOe9vx5n0+h7F2+4I/Vu
         MIWxNkAP4ByW5MUtWYs/jv2CW13NPgoZcC0dxKp2cKCADcFhAbsmV5h6fCM/CXGL4hWW
         oBqpLvsu5q9lCTO319m7Deoqzteoqswunt2rw7NoZ7aJW6ZgFC9dTZ+ajwVppeH5QJX4
         758Q==
X-Forwarded-Encrypted: i=1; AJvYcCXv7moSnXmZASNb427bvU4LCelgRruVJWf2oHy0LYfVFcTPlwKk795SYQdO5Iv1IkLvQPQKD1vcqeYtkOsUDs3Nnwcq3zTiEjtg6G9k
X-Gm-Message-State: AOJu0YyvWICKEVst9SvI7TTmcFjprgxjpOkkUFZxrylnkqHSeHL3/lIQ
	yyi8YQ1S6F77OxC9ycyUQISyGNlNFLvva0cEJvaAA5P4JZqwI0oV3hAvv+ytsgY=
X-Google-Smtp-Source: AGHT+IH9hNJMfuKzvyPHJBrng5Xrl9wYKvbD96GFL2/KXJNt3vhICaZtozKnmZTUp0Yy1nmHR4e1Sg==
X-Received: by 2002:a5d:4612:0:b0:33e:7f51:c2f7 with SMTP id t18-20020a5d4612000000b0033e7f51c2f7mr3962132wrq.52.1711361044516;
        Mon, 25 Mar 2024 03:04:04 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:861d:8b72:a859:4ce9])
        by smtp.gmail.com with ESMTPSA id dv13-20020a0560000d8d00b0033e25c39ac3sm9086874wrb.80.2024.03.25.03.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:04:04 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Guru Das Srinagesh <quic_gurus@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@quicinc.com,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v9 00/13] firmware: qcom: qseecom: convert to using the TZ allocator
Date: Mon, 25 Mar 2024 11:03:46 +0100
Message-Id: <20240325100359.17001-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

SCM calls that take memory buffers as arguments require that they be
page-aligned, physically continuous and non-cachable. The same
requirements apply to the buffer used to pass additional arguments to SCM
calls that take more than 4.

To that end drivers typically use dma_alloc_coherent() to allocate memory
of suitable format which is slow and inefficient space-wise.

SHM Bridge is a safety mechanism that - once enabled - will only allow
passing buffers to the TrustZone that have been explicitly marked as
shared. It improves the overall system safety with SCM calls and is
required by the upcoming scminvoke functionality.

The end goal of this series is to enable SHM bridge support for those
architectures that support it but to that end we first need to unify the
way memory for SCM calls is allocated. This in itself is beneficial as
the current approach of using dma_alloc_coherent() in most places is quite
slow.

First let's add a new TZ Memory allocator that allows users to create
dynamic memory pools of format suitable for sharing with the TrustZone.
Make it ready for implementing multiple build-time modes.

Convert all relevant drivers to using it. Add separate pools for SCM core
and for qseecom.

Finally add support for SHM bridge and make it the default mode of
operation with the generic allocator as fallback for the platforms that
don't support SHM bridge.

Tested on db410c, RB5, sm8550-qrd. Previous iteration tested also on
sa8775p-ride and lenovo X13s (please do retest on those platforms if you
can).

v8 -> v9:
- split the qseecom driver rework into two parts: first convert it to using
  the __free() helper and then make it switch to tzmem
- use QCOM_SCM_PERM_RW instead of (QCOM_SCM_PERM_WRITE | QCOM_SCM_PERM_READ)
- add the TZMEM MAINTAINERS entry in correct alphabetical order
- add a missing break; in a switch case in the tzmem module

v7 -> v8:
- make the pool size dynamic and add different policies for pool growth
- improve commit messages and the cover letter: describe what the SHM
  bridge is and why do we need it and the new allocator, explain why it's
  useful to merge these changes already, independently from scminvoke
- improve kerneldoc format
- improve the comment on the PIL SCM calls
- fix license tags, drop "or-later" for GPL v2
- add lockdep and sleeping asserts
- minor tweaks and improvements

v6 -> v7:
- fix a Kconfig issue: TZMEM must select GENERIC_ALLOCATOR

v5 -> v6:
Fixed two issues reported by autobuilders:
- add a fix for memory leaks in the qseecom driver as the first patch for
  easier backporting to the v6.6.y branch
- explicitly cast the bus address stored in a variable of type dma_addr_t
  to phys_addr_t expected by the genpool API

v4 -> v5:
- fix the return value from qcom_tzmem_init() if SHM Bridge is not supported
- remove a comment that's no longer useful
- collect tags

v3 -> v4:
- include linux/sizes.h for SZ_X macros
- use dedicated RCU APIs to dereference radix tree slots
- fix kerneldocs
- fix the comment in patch 14/15: it's the hypervisor, not the TrustZone
  that creates the SHM bridge

v2 -> v3:
- restore pool management and use separate pools for different users
- don't use the new allocator in qcom_scm_pas_init_image() as the
  TrustZone will create an SHM bridge for us here
- rewrite the entire series again for most part

v1 -> v2:
- too many changes to list, it's a complete rewrite as explained above

Bartosz Golaszewski (13):
  firmware: qcom: add a dedicated TrustZone buffer allocator
  firmware: qcom: scm: enable the TZ mem allocator
  firmware: qcom: scm: smc: switch to using the SCM allocator
  firmware: qcom: scm: make qcom_scm_assign_mem() use the TZ allocator
  firmware: qcom: scm: make qcom_scm_ice_set_key() use the TZ allocator
  firmware: qcom: scm: make qcom_scm_lmh_dcvsh() use the TZ allocator
  firmware: qcom: scm: make qcom_scm_qseecom_app_get_id() use the TZ
    allocator
  firmware: qcom: qseecom: convert to using the cleanup helpers
  firmware: qcom: qseecom: convert to using the TZ allocator
  firmware: qcom: scm: add support for SHM bridge operations
  firmware: qcom: tzmem: enable SHM Bridge support
  firmware: qcom: scm: clarify the comment in qcom_scm_pas_init_image()
  arm64: defconfig: enable SHM Bridge support for the TZ memory
    allocator

 MAINTAINERS                                   |   8 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/firmware/qcom/Kconfig                 |  31 ++
 drivers/firmware/qcom/Makefile                |   1 +
 .../firmware/qcom/qcom_qseecom_uefisecapp.c   | 285 ++++-------
 drivers/firmware/qcom/qcom_scm-smc.c          |  30 +-
 drivers/firmware/qcom/qcom_scm.c              | 182 ++++---
 drivers/firmware/qcom/qcom_scm.h              |   6 +
 drivers/firmware/qcom/qcom_tzmem.c            | 455 ++++++++++++++++++
 drivers/firmware/qcom/qcom_tzmem.h            |  13 +
 include/linux/firmware/qcom/qcom_qseecom.h    |   4 +-
 include/linux/firmware/qcom/qcom_scm.h        |   6 +
 include/linux/firmware/qcom/qcom_tzmem.h      |  56 +++
 13 files changed, 813 insertions(+), 265 deletions(-)
 create mode 100644 drivers/firmware/qcom/qcom_tzmem.c
 create mode 100644 drivers/firmware/qcom/qcom_tzmem.h
 create mode 100644 include/linux/firmware/qcom/qcom_tzmem.h

-- 
2.40.1


