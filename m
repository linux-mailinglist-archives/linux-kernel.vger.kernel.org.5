Return-Path: <linux-kernel+bounces-103368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8698F87BEA2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31495B21134
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611096FE10;
	Thu, 14 Mar 2024 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJsd3Zb3"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0042D5811C;
	Thu, 14 Mar 2024 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710425686; cv=none; b=gajxxpH2VyVDTY3mySWqNjTNZ8UX3t3BJIg8/nxhi//xOQNLCzmS4idqtFs48e+jjyy83fuUyKes0eks/PN8/HSAtSBD9Tm+WAwurYdPPg2vGy4Gt/Hx0yB6kNGbqgqZL2L9y3U79V0jk6HLBl/s7RHJO4kgYYCxj0kpszjnGBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710425686; c=relaxed/simple;
	bh=x5CVPbF28WQ1DpJCoL+U1c14mF1GOV9N6BoJa/JW2Ig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YXwTpPWDkVtkMZcrKJjobzMorMFHmcoVgIr84+eL+/wZBFxkUQ/CPkjHtBSrUksVWSb8E3iRQY/3wSQnQraFtYtwgcqRw2JuSTMPEHEc5IcwMC7Vu/X2dpZ7Fb+jJ/d+fU4EsRBZ5zqMYtslB56F0B5pX5VH1I6waDvKI32JpTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJsd3Zb3; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5131a9b3d5bso1328461e87.0;
        Thu, 14 Mar 2024 07:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710425683; x=1711030483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PAAoGUwJhKHSM53yVC1A2s8QbjT/aWBxy9la5JymCLA=;
        b=ZJsd3Zb3knbapts/qUS1n8+Cr1zJDrfYyAWKjpEnRQBXAf11lwv0PPrE6T1SEiFVI2
         RIQAEWtMQpVQl6Z8g0ETLEet2rrkcbkpuB7XSob9s7KuiAcSROVIJVKO2IPuqfh7QnwG
         oNGRnCc123z/E2P77r3bVzLMxDIOEu9av83BGjJzjAzAQl39H+nV6RZKZILS2Tls1DCg
         /iKKqScJIbqxut19j52uNvr/YYR3z0pTXtAaG4ii+kuZBwj2rjBAdMWmSxASI5SdNaXN
         jGNW3VR8ORfiVDqf0P7VZA8pq9eO52fxLEEv7nsFY0D/4Tjn7xhlEWWc3KlXP15OCvun
         z6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710425683; x=1711030483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PAAoGUwJhKHSM53yVC1A2s8QbjT/aWBxy9la5JymCLA=;
        b=b+NDUPDZgVBqg2155TwPuUGMnp2PSCmmCVvLtPeZBlQ/lOdAqNGrdfSVYcCvKPseFp
         FD2u1CGYNOYqMV1z9FHfU56d53VMoSTP1k3TxrimONQ6ZXJ6Ws6PRMBQ9WcTlWhUacLM
         U6E0Oa6ThoLLKkvhYklazPsuz+jY098y1QV/Ov+6er1ER0Xu/xmVzPF7J2Xcf5r7cQpw
         4yMsGhDrNe53XJsanQHu6q7//o6J0xMPviAGwfnW9i8LKr4XvEYDv130/QcQsOojniyR
         vrDHIUDQZU5sZelJSuOgY3/ZUMfzCo61scp99dnW0NH6WxFUL7w2KmE+bTRh+IHJ6XSw
         X+cw==
X-Gm-Message-State: AOJu0YyPqsT0ZIt7T/lhhIdMki3t8rdJbzGDiH3sTp0Gg2zBQM6juwE/
	dB/uSmLdLA+HvGz8wlEe8uH5VwRj6Lp83OmJG7JuWzGyo0igEyugdg4YXAv9uRk=
X-Google-Smtp-Source: AGHT+IHthsBH5+FP1OlF3bK3BRi/RkDevyBhf348milcB9Hjy3iU8bN00i0ea1eQVxPIyvEfUPJFvA==
X-Received: by 2002:ac2:598c:0:b0:513:a732:4878 with SMTP id w12-20020ac2598c000000b00513a7324878mr1346057lfn.41.1710425682283;
        Thu, 14 Mar 2024 07:14:42 -0700 (PDT)
Received: from skhimich.dev.yadro.com (avpn01.yadro.com. [89.207.88.243])
        by smtp.gmail.com with ESMTPSA id a19-20020ac25e73000000b005135bd71d6fsm286538lfr.276.2024.03.14.07.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 07:14:41 -0700 (PDT)
From: Sergey Khimich <serghox@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Jyan Chou <jyanchou@realtek.com>
Subject: [PATCH v6 0/2] mmc: sdhci-of-dwcmshc: Add CQE support
Date: Thu, 14 Mar 2024 17:14:38 +0300
Message-Id: <20240314141440.3305802-1-serghox@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello!

This is implementation of SDHCI CQE support for sdhci-of-dwcmshc driver.
For enabling CQE support just set 'supports-cqe' in your DevTree file
for appropriate mmc node.

Also, while implementing CQE support for the driver, I faced with a problem
which I will describe below.
According to the IP block documentation CQE works only with "AMDA-2 only"
mode which is activated only with v4 mode enabled. I see in dwcmshc_probe()
function that v4 mode gets enabled only for 'sdhci_dwcmshc_bf3_pdata'
platform data.

So my question is: is it correct to enable v4 mode for all platform data
if 'SDHCI_CAN_64BIT_V4' bit is set in hw?

Because I`m afraid that enabling v4 mode for some platforms could break
them down. On the other hand, if host controller says that it can do v4
(caps & SDHCI_CAN_64BIT_V4), lets do v4 or disable it manualy by some
quirk. Anyway - RFC.


v2:
 - Added dwcmshc specific cqe_disable hook to prevent losing
   in-flight cmd when an ioctl is issued and cqe_disable is called;

 - Added processing 128Mb boundary for the host memory data buffer size
   and the data buffer. For implementing this processing an extra
   callback is added to the struct 'sdhci_ops'.

 - Fixed typo.

v3:
 - Fix warning reported by kernel test robot:
        | Reported-by: kernel test robot <lkp@intel.com>
        | Closes: https://lore.kernel.org/oe-kbuild-all/202309270807.VoVn81m6-lkp@intel.com/
        | Closes: https://lore.kernel.org/oe-kbuild-all/202309300806.dcR19kcE-lkp@intel.com/

v4:
 - Data reset moved to custom driver tuning hook.
 - Removed unnecessary dwcmshc_sdhci_cqe_disable() func
 - Removed unnecessary dwcmshc_cqhci_set_tran_desc. Export and use
   cqhci_set_tran_desc() instead.
 - Provide a hook for cqhci_set_tran_desc() instead of cqhci_prep_tran_desc().
 - Fix typo: int_clok_disable --> int_clock_disable

v5:
 - Fix warning reported by kernel test robot:
	| Reported-by: kernel test robot <lkp@intel.com>
	| Closes: https://lore.kernel.org/oe-kbuild-all/202312301130.itEZhhI5-lkp@intel.com/

v6:
 - Rebase to master branch
 - Fix typo;
 - Fix double blank line;
 - Add cqhci_suspend() and cqhci_resume() functions
   to support mmc suspend-to-ram (s2r);
 - Move reading DWCMSHC_P_VENDOR_AREA2 register under "supports-cqe"
   condition as not all IPs have that register;
 - Remove sdhci V4 mode from the list of prerequisites to init cqhci.


Sergey Khimich (2):
  mmc: cqhci: Add cqhci set_tran_desc() callback
  mmc: sdhci-of-dwcmshc: Implement SDHCI CQE support

 drivers/mmc/host/Kconfig            |   1 +
 drivers/mmc/host/cqhci-core.c       |  11 +-
 drivers/mmc/host/cqhci.h            |   4 +
 drivers/mmc/host/sdhci-of-dwcmshc.c | 188 +++++++++++++++++++++++++++-
 4 files changed, 199 insertions(+), 5 deletions(-)

-- 
2.30.2


