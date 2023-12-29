Return-Path: <linux-kernel+bounces-13042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EDD81FED6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 11:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4EED2845B2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 10:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C49F10A30;
	Fri, 29 Dec 2023 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgsSt5PC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597C110A1B;
	Fri, 29 Dec 2023 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e7b51b0ceso3452029e87.1;
        Fri, 29 Dec 2023 02:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703844695; x=1704449495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+HveFA/qMiFQFg+iCyHUSw323L9d+b4jAzJ+pz8yYlk=;
        b=XgsSt5PCeARQjc4PaofZW2EKUVjKtDEcuz5lcvGl6h4ZCVNR98ITlSoWDQ5L85LdxX
         /B4cmy1KuQ4MeXzrL6A8BfQOY+KaK1XoBT5t4IDhRIyOUx3vrwT1jEtSJZkpKS2S6miY
         YDT5+rsMTtpv1jJzDTIK/W372iOdYyCUdRSWYdrtPbZz+UcDFYLxW8YYJRBQ6FEgnk3U
         lWdWTsM+bA9XczK48Fg0S/vdVseBeKF+8ouz9bGm+VFD+w/sf/a11TNw6qzQAyCiH4wy
         U1N6J9PBdkw9+HrwDvJvxQINFDmZmZ71DWejb/ayXRDCgpfSsA68Tn7aruyGC2nYv0qD
         l8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703844695; x=1704449495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HveFA/qMiFQFg+iCyHUSw323L9d+b4jAzJ+pz8yYlk=;
        b=bHrgszTkM98vXBsNirlyzyRnzDTzfTKRtFu+dQuX+J3OT0nwRHHaV1Xo5w95RxSW95
         8CW2uGSatTjYEo0X62QvwspjCnTION6SJWzihb2wQZhZTgUbb0Xmc9y3d7DWbr8mRYCj
         i/Wt4Yb610kYjoBTxHpFLUAC8cOWZ/U4QxOrDsV1wHY7FXh9eJDWj6r6UqdINaaachqX
         or4aLUdzUnmUfM5VUbZp3ng6AYxWzR3eXTWFTMUqaQ79WwWsnVxPZF60bkQvLUAPdyZX
         9p65WXIgvyAv0pPzkqcSEZIt9p3rx/qr9L4FpKo0h9SAx8UPrDhRc3HJV00TTRPFf8IO
         cy+Q==
X-Gm-Message-State: AOJu0Yz6xrWlGlg6h0Qy+NagxUBd/A2l/1QF/HUxssQblvpM7YvC8L4y
	aFVBOSINh+L8hNj+QQSFd9ka2KcnbCM2Mw==
X-Google-Smtp-Source: AGHT+IHE3pa9PVvC1Cma8PDZb3am/dCLMoecEwRWixC1755FUBEzjs3AMaM0LNs7YF2tnYiCWf7X2Q==
X-Received: by 2002:a05:6512:2821:b0:50e:80d7:370f with SMTP id cf33-20020a056512282100b0050e80d7370fmr3759012lfb.32.1703844694810;
        Fri, 29 Dec 2023 02:11:34 -0800 (PST)
Received: from skhimich.dev.yadro.com ([185.15.172.210])
        by smtp.gmail.com with ESMTPSA id a2-20020a19ca02000000b0050e6bf2b452sm2181734lfg.105.2023.12.29.02.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 02:11:34 -0800 (PST)
From: Sergey Khimich <serghox@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Jyan Chou <jyanchou@realtek.com>
Subject: [PATCH v4 0/2] mmc: sdhci-of-dwcmshc: Add CQE support
Date: Fri, 29 Dec 2023 13:11:26 +0300
Message-Id: <20231229101128.392089-1-serghox@gmail.com>
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


Thanks in advance, Sergey.


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


