Return-Path: <linux-kernel+bounces-158129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D3D8B1BEC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451381C23B9D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A316CDCF;
	Thu, 25 Apr 2024 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qcN9XBE0"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A90D3A268
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714030285; cv=none; b=JAkCSFsn/O3wjoiW2dVgWpBLVJD7++EceQ5jM+oQd6ZDnEdJAIW8AJ2iFz9i7JgnmbzNK2+h9JwN9BEhE2r7jIFNrkA5281/g+Gu+60oTFHLEkEaeAo7nyvuH3grJOuZC/VZOkJkXjkKv0aZs3Py7R/DbR8qpsX/Np8hGd/m0YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714030285; c=relaxed/simple;
	bh=O/T/XiUFY2D9jg3rqcf4ZWfhRKHwvIZ+mw6RfUeqZ74=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rQkvlniM1giLZ/cbG3V8dgW05lyUMNN2JVSXCYZ8/Z3km3u68wl12HBOQmunSgf260r4kjLJe9FBgzvSxSanSr8tUkaBZujG/5fCLwakS7pQkfHpcnA5R71u0ZaPohiYAX0s3xYDCnQuSK9NxRthXRGvz+7IBnVDfadVLvtOp5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qcN9XBE0; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2db13ca0363so8918211fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 00:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714030282; x=1714635082; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ul9hzsEcg7DYm2vJuobyphUHRoFSWDx7IAFuHRf9zA4=;
        b=qcN9XBE0BajAwPZrISTVRzoLHHLqnDa9LaC2nj9fGdD8bRrsFJfkPDt4HsL9eriOF7
         NwJpi2D4Vyz/C5eoaXCnlXEfUjoSO3vCPK/bq2c5mGcbecu91ckS0QlqzFg1+ZgH4ojA
         d5C9CkdPSfvGDiV4nf9i+wRmiHupoYmkW/j42lZvBh9qFMmtY7JV9JK2Y8ZrG+59qyJv
         fSs+U/YBjBkho38Bq9iXMYBa1TzgjcqZOeO3jNJlERO0+PNNhVdar4V1HoGXGeA1P7QS
         KL5secs30ocb+2tU/nb26qX4hZLQ+gWWeDtvFU2wibJu1A+rni8k86eFD24un5q1nHvs
         60NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714030282; x=1714635082;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ul9hzsEcg7DYm2vJuobyphUHRoFSWDx7IAFuHRf9zA4=;
        b=uuSc2ZfszS8DzwU0nR+RGFmh9yMF+MC4d8YyB2CLkRLL6KBrcuX2ivUmc7/jocamT1
         YSLUSX0SIv08h4y7bK87/hboUrswH3sVQti6BgbfqDB8xeNUbUqgXKcjowKDeySQSNnY
         y6RASfQaJVpql2xBiRSNOBcMw6pTfbL1kwjWZ4xnooDyI0WzMWcahSTnEDHK80mVHwcx
         hXmEjoMOb3VHqQyXI4iWHQ8wsC+3L1jG8CDlfXBq1ut2UrO1d7rCfEgjRabiTBnMrt+F
         UVFn0rjV23B/SSKyTXV5hnFNv7WWcKT4bW1we4RZhaCyJFkJK+gHTzMjoYxqYVoCBmHP
         fpwQ==
X-Gm-Message-State: AOJu0YwlnwE8KdROqsq/3ZW8X3MG638tgOZ61PUN2Ea34hdKsVx9a7bP
	kOPEkZ8tD72dCg8w0nwuzMZ2s+KXGyTRRjQG7I0cUK3U4czkFdKzKysKHV4cganAxrm0l3zy8MP
	g
X-Google-Smtp-Source: AGHT+IEiRBUviT2k4uhh1UXsujRvJ586KrHxaEdXV0yDDilA0LqYA463l/ieRAYdipdoU5lQ8sa7HA==
X-Received: by 2002:a2e:81c2:0:b0:2d4:6893:24e1 with SMTP id s2-20020a2e81c2000000b002d4689324e1mr3514710ljg.50.1714030281939;
        Thu, 25 Apr 2024 00:31:21 -0700 (PDT)
Received: from rayden (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id bo1-20020a0564020b2100b0056fd89cd52dsm8654055edb.85.2024.04.25.00.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 00:31:21 -0700 (PDT)
Date: Thu, 25 Apr 2024 09:31:19 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] TEE driver for Trusted Services
Message-ID: <20240425073119.GA3261080@rayden>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello arm-soc maintainers,

Please pull these patches that introduces a TEE driver for Trusted
Services. You can see more details below from the signed tag. These
patches have been in for a few weeks.

Thanks,
Jens

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/tee-ts-for-v6.10

for you to fetch changes up to 31611cc8faa082a96009c29822d9906d893cce57:

  MAINTAINERS: tee: tstee: Add entry (2024-04-03 14:03:09 +0200)

----------------------------------------------------------------
TEE driver for Trusted Services

This introduces a TEE driver for Trusted Services [1].

Trusted Services is a TrustedFirmware.org project that provides a
framework for developing and deploying device Root of Trust services in
FF-A [2] Secure Partitions. The project hosts the reference
implementation of Arm Platform Security Architecture [3] for Arm
A-profile devices.

The FF-A Secure Partitions are accessible through the FF-A driver in
Linux. However, the FF-A driver doesn't have a user space interface so
user space clients currently cannot access Trusted Services. The goal of
this TEE driver is to bridge this gap and make Trusted Services
functionality accessible from user space.

[1] https://www.trustedfirmware.org/projects/trusted-services/
[2] https://developer.arm.com/documentation/den0077/
[3] https://www.arm.com/architecture/security-features/platform-security

----------------------------------------------------------------
Balint Dobszay (4):
      tee: optee: Move pool_op helper functions
      tee: tstee: Add Trusted Services TEE driver
      Documentation: tee: Add TS-TEE driver
      MAINTAINERS: tee: tstee: Add entry

Sumit Garg (1):
      tee: Refactor TEE subsystem header files

 Documentation/tee/index.rst         |   1 +
 Documentation/tee/ts-tee.rst        |  71 ++++++
 MAINTAINERS                         |  10 +
 drivers/tee/Kconfig                 |   1 +
 drivers/tee/Makefile                |   1 +
 drivers/tee/amdtee/amdtee_private.h |   2 +-
 drivers/tee/amdtee/call.c           |   2 +-
 drivers/tee/amdtee/core.c           |   3 +-
 drivers/tee/amdtee/shm_pool.c       |   2 +-
 drivers/tee/optee/call.c            |   2 +-
 drivers/tee/optee/core.c            |  66 +----
 drivers/tee/optee/device.c          |   2 +-
 drivers/tee/optee/ffa_abi.c         |   8 +-
 drivers/tee/optee/notif.c           |   2 +-
 drivers/tee/optee/optee_private.h   |  14 +-
 drivers/tee/optee/rpc.c             |   2 +-
 drivers/tee/optee/smc_abi.c         |  11 +-
 drivers/tee/tee_core.c              |   2 +-
 drivers/tee/tee_private.h           |  35 ---
 drivers/tee/tee_shm.c               |  67 ++++-
 drivers/tee/tee_shm_pool.c          |   2 +-
 drivers/tee/tstee/Kconfig           |  11 +
 drivers/tee/tstee/Makefile          |   3 +
 drivers/tee/tstee/core.c            | 480 ++++++++++++++++++++++++++++++++++++
 drivers/tee/tstee/tstee_private.h   |  92 +++++++
 include/linux/tee_core.h            | 306 +++++++++++++++++++++++
 include/linux/tee_drv.h             | 285 +++------------------
 include/uapi/linux/tee.h            |   1 +
 28 files changed, 1095 insertions(+), 389 deletions(-)
 create mode 100644 Documentation/tee/ts-tee.rst
 create mode 100644 drivers/tee/tstee/Kconfig
 create mode 100644 drivers/tee/tstee/Makefile
 create mode 100644 drivers/tee/tstee/core.c
 create mode 100644 drivers/tee/tstee/tstee_private.h
 create mode 100644 include/linux/tee_core.h

