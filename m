Return-Path: <linux-kernel+bounces-12906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D5081FC6E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 02:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 068EF28590D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 01:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CE323DC;
	Fri, 29 Dec 2023 01:46:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C98623A1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 01:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(636803:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Fri, 29 Dec 2023 09:46:03 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27; Fri, 29 Dec
 2023 09:46:03 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1258.27 via Frontend
 Transport; Fri, 29 Dec 2023 09:46:03 +0800
From: <cy_huang@richtek.com>
To: Mark Brown <broonie@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, ChiYuan Huang <cy_huang@richtek.com>,
	<alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] rtq9128: Fix pm runtime and TDM usage
Date: Fri, 29 Dec 2023 09:46:00 +0800
Message-ID: <cover.1703813842.git.cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: ChiYuan Huang <cy_huang@richtek.com>

This patch series fix rtq9128 pm_runtime and TDM usage.

ChiYuan Huang (2):
  ASoC: codecs: rtq9128: Fix PM_RUNTIME usage
  ASoC: codecs: rtq9128: Fix TDM enable and DAI format control flow

 sound/soc/codecs/rtq9128.c | 73 +++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 32 deletions(-)


base-commit: ceb6a6f023fd3e8b07761ed900352ef574010bcb
-- 
2.34.1


