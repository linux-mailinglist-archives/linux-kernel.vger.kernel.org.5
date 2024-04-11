Return-Path: <linux-kernel+bounces-140118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5F38A0B9C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C8FC2846FF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE88E14389F;
	Thu, 11 Apr 2024 08:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JngeEH8F"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F77E35F18;
	Thu, 11 Apr 2024 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712825358; cv=none; b=PJFTOeuIXTL79YwgNjzIWe/qsiV+WTCzArQ0M9EO1WSUIJHgS1+E3i5znVG4Gf7rvOvaztoHAybTY+2B/QmLm3ISIv3m2Fsin5fXnG937IM0xi/7nvAt7/1veJaS7vezuTx+3nQFLJBilIaCoX93u5+wy1NDicEueeOobKbILgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712825358; c=relaxed/simple;
	bh=chQTnWSlVUh4fTmtbvWlQnO2lU0Riy/R0Hldxq1A9w0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cEGn9WX2amiNEXy+iQTSPbMi3PFWkKoE6XY+p6PYjAVPHVw25LQJjvZmyw7L2EDATC261Ic1J7NRYnVt9gIomzsGFwSrgmhIKneveFSKU+drbvdCJYHPVYJUI/xyI8eX9uY/XTeCKm1iLQQrPk+zlFktJ6R80I2kTAZ2Vsxh3+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JngeEH8F; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516d09bd434so8485835e87.1;
        Thu, 11 Apr 2024 01:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712825354; x=1713430154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ce3+OUkZq40m+efQaypNKgk9aBlLNcnyZ4pRprOWxa0=;
        b=JngeEH8FcygieFZIybLvy+v/qv2YHzjtstDbkcy2gaGMGVNzUy1pouuBR7N0PTMn7v
         JadufODpyDkdCgsOpulzGF38ZPj9fsVEVwfM2vgqQNXoGBNyD1KrsdVv++deurDtgn78
         iIQP+Tcc+gAClHkTMxFwcVyUZ4hvPNakXs7kLr2NeT6++wgiKA9JCmvSZk0O61ZP5PD9
         VPcqajLwy9Ofzi30+kQHZFt6R/5G8ehlXYeRq8rAR+OZm1anmcQQb9vvkx459f5FWPKX
         17qU6RcejF0qiks6AcdjChHj6/i+Qap1qsBo1lUQThibKqFpQr64CN/HZ86bTim446WI
         4Cog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712825354; x=1713430154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ce3+OUkZq40m+efQaypNKgk9aBlLNcnyZ4pRprOWxa0=;
        b=kAKDWJZY4Yt5gmPhVVRan1tAOJRy5U0RUox2Ik8fRj9KqIlzquHnVNhza/NVuqnoRy
         HpGSXI1thDUjgmctfOw+x3qdCSbUF9mpyMBWEktuFnvw2xkb1DPfGVxOI7BBrys/Wa9w
         IPjPUfJIlulvTYTaPeEwtF8BjtMG5tEJLfKOz4U/tWfT2afe3BrZ9A4/qH1mwZxl46jk
         YOJue39SaYTVHsvgABtYl7T3Od6ML0SiBFGEJmRq/3Smp9k582msrzoEguY7AtzHKV1J
         dHbnLWY0sEmjm4HtesLwuvqdVacOJCo5pgFHlYZKWvqktZfY9TrfxjdCrFbxaKibIHg+
         oJmg==
X-Forwarded-Encrypted: i=1; AJvYcCWo2pe5gwPGwajFvfvzkakJ3ZgKHNgy8rDVEQUOxxBnaMwtAphJRcWAsF+2OzaSW65DmQ37dlQGYEEVNNUnJ9kaNod0NMDvrpT2mqtu1zhxTzg2ocBzFJbBLcNdcMxYYNVzvWQt3XowTXRf8UDX
X-Gm-Message-State: AOJu0Yy/NMotELB3ajEeMqSV3dU0k3s7gznJUkXibu1jnih7nGWwKGz9
	9xdJGjRxU3roriLZf/ZTcfoboUN/uNq8TusEZOoxL1E0RO+IPacku4R0DTLA
X-Google-Smtp-Source: AGHT+IFmzoMFrQQ2KSPtvwMFPgsLDBPqZH4WpawT8dEaC3sMYw4joUMwdrJBv9YtUNXWhi3CE4XYYw==
X-Received: by 2002:a05:6512:68c:b0:515:c195:d6b8 with SMTP id t12-20020a056512068c00b00515c195d6b8mr3852456lfe.60.1712825354309;
        Thu, 11 Apr 2024 01:49:14 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id b11-20020adfe30b000000b0034625392416sm1237204wrj.104.2024.04.11.01.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 01:49:13 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] tpm/eventlog: remove redundant assignment to variabel ret
Date: Thu, 11 Apr 2024 09:49:13 +0100
Message-Id: <20240411084913.305780-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Variable ret is being assigned and error code that is never read, it is
either being re-assigned in an error exit path or never referenced again
on the non-error path. The assignment is redundant and can be removed.

Cleans up clang scan build warning:
drivers/char/tpm/eventlog/acpi.c:145:2: warning: Value stored to 'ret'
is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/char/tpm/eventlog/acpi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
index bd757d836c5c..69533d0bfb51 100644
--- a/drivers/char/tpm/eventlog/acpi.c
+++ b/drivers/char/tpm/eventlog/acpi.c
@@ -142,7 +142,6 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 
 	log->bios_event_log_end = log->bios_event_log + len;
 
-	ret = -EIO;
 	virt = acpi_os_map_iomem(start, len);
 	if (!virt) {
 		dev_warn(&chip->dev, "%s: Failed to map ACPI memory\n", __func__);
-- 
2.39.2


