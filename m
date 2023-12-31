Return-Path: <linux-kernel+bounces-13715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653CA820B8E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 15:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C41CCB211CC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 14:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5776FBC;
	Sun, 31 Dec 2023 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Peu4/Tsc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6046120;
	Sun, 31 Dec 2023 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ccecef2631so22684651fa.2;
        Sun, 31 Dec 2023 06:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704033981; x=1704638781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=69j3Yzp8lMszQFVq5HYjnhUYYy5SLwln9P4F4WepkCM=;
        b=Peu4/TscI40vycaUcgOQ6cjWs8TBoFwREGbOQOMr+rPQex1O5Hi9VAZ1HqsXsWwLKb
         aP+9o0LZBcv+QDSrSNUqnjAY3qcYDhXadTtItj1ua+2Iqb4sSjBFYaPz9ScibWcOc6UJ
         rsWNA+yyFgjG/RAA2my8ARWn6iMJ/BFdAf8v6iGj78J/vPsefhOpQhiPRv9lGRB/jutU
         11o5DHK+aduChRKyubTQdRXvcegqveIiaH8TcQfZAIGDi1vQgsdBeg691XtlzJLl/efc
         Bx/jIvQSHM3NNlh5igAJQoiBU7sSr6tJ15qOC6DFrKgsIinBI/XH7JBok8WXIB0Qdaal
         cZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704033981; x=1704638781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=69j3Yzp8lMszQFVq5HYjnhUYYy5SLwln9P4F4WepkCM=;
        b=sDlPhS5Sj+Ye4S0ZNBgvKqrv1CBEddE/xq/GeF1wB1a7Abh99hKhMfGPi9jTRaZTGl
         XRx5F3zBB3sCfFNE+9CJ9k8AT27dq5XUbtLS4bvZIaraUZwjSfP9Qimb33G5yJJgODDq
         g/QduFoRN712F1mxp0LTPn4Q+qMWnaihcmoMXoYhkogyiLvbrHAVZrY4eCTsbVr5/KWa
         7uzC0eRIcu/BTrcCT6OIVC42edICYl3wQXkYCkUGv5LCz6adSmCgFbOrnTYix7dgpFhv
         Nw/CKftLVGqaUM5jAE8zsPIKXVeud5HxHJ/Jlj4IneUHOXtTfk9mH5lgVCob6clAyOc3
         n6Mw==
X-Gm-Message-State: AOJu0YzG4J8hdcuaCgHK1GAoh0JgzkBNOtJSxR6IeGhPSPkPVr+BRlo1
	mwe+eWpD2toM22WCKZHOz6/5zDic0WJV0Q==
X-Google-Smtp-Source: AGHT+IHshuk3+kc/U/MYtgdjWzgmSBvm7V6YCjepbGgffymbUvjePLJ94m6N6zgqb1uEriNOvMhUFA==
X-Received: by 2002:a05:6512:159a:b0:50e:7c0e:57d0 with SMTP id bp26-20020a056512159a00b0050e7c0e57d0mr4483888lfb.7.1704033980610;
        Sun, 31 Dec 2023 06:46:20 -0800 (PST)
Received: from skhimich.dev.yadro.com ([185.15.172.210])
        by smtp.gmail.com with ESMTPSA id l9-20020ac24a89000000b0050e7ec49881sm1854423lfp.21.2023.12.31.06.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 06:46:20 -0800 (PST)
From: Sergey Khimich <serghox@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Jyan Chou <jyanchou@realtek.com>
Subject: [PATCH v5 0/2] mmc: sdhci-of-dwcmshc: Add CQE support
Date: Sun, 31 Dec 2023 17:46:17 +0300
Message-Id: <20231231144619.758290-1-serghox@gmail.com>
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




Sergey Khimich (2):
  mmc: cqhci: Add cqhci set_tran_desc() callback
  mmc: sdhci-of-dwcmshc: Implement SDHCI CQE support

 drivers/mmc/host/Kconfig            |   1 +
 drivers/mmc/host/cqhci-core.c       |  10 +-
 drivers/mmc/host/cqhci.h            |   5 +
 drivers/mmc/host/sdhci-of-dwcmshc.c | 181 +++++++++++++++++++++++++++-
 4 files changed, 192 insertions(+), 5 deletions(-)

-- 
2.30.2


