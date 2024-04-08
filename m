Return-Path: <linux-kernel+bounces-135708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6D189CA0F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBF361C22498
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EB9142E9F;
	Mon,  8 Apr 2024 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="GKl0rt1J"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880431E532;
	Mon,  8 Apr 2024 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712595001; cv=none; b=K7/6qn89LW6RVtwLeQU0aeTbFHQKvNLRVcEl1l6V5eQxZMt0oZdgVO1D4F5zrmJ/wZgEMFOrRK8DrkLTs/fmaxVegjt+H1LNp2lpIi9EHU+GjIoJv177UZ9a+eFJcpbA1yKyX0atzhdTaGQ2Xec9sGNt/IC0FSt0eHpwlP0RDJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712595001; c=relaxed/simple;
	bh=1TwjqB1I0raub8VPyrmdRKHURhBFHprQC67n8Xq0EhY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GblEDg2ALATgdgmIA2JfzLYLb14Wq8kC1e/67iPQZOZ7YAinicEDk0C3lnkSRFFqalFyt6WgFAqtk1otbdol13PTvIDTIutitgfGlbPwf/woqvf4QViMy3mG8b8f/7I72XGFUAh8VFbCg228e6oAt/RvIqSzkzBw9QBLa+kJWl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=GKl0rt1J; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 9103F120023;
	Mon,  8 Apr 2024 19:49:54 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9103F120023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1712594994;
	bh=GVKo6znhMy5c2DD7Af70VLwRzPogSN+CP1wNv/Gt+K0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=GKl0rt1Jj2HYmfyKyUjhNSb/kz4hyLxsaa/jopgRVQ/gw0Paprmnt287VkE/rRfoH
	 REmEizIKeseLRD60c482kp0flYdlWsjOk441rFXVXHkOhpfdX/CSjpDAg0/uy3iLzx
	 BEtgao8PC1EKsXa/qgVn+530uet9waOyOQtZKm8HqptZuC4L1T6wbF4AEsyR/kXWDI
	 DhqeviGKT0GgzB8Lh/EeKUwgO6EskWAqX3ZHpTmrMIXeMsyGH4QTOK4NYNAfjYA+bD
	 PRKiICVaXkblhNOhVq9Rfeq3PbLYlSByxmvVAID5KzL+j/6jAL4zXyVd64qIK4IE6i
	 Go2JZZdr+sw8A==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon,  8 Apr 2024 19:49:54 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Apr 2024 19:49:53 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <lgirdwood@gmail.com>,
	<jbrunet@baylibre.com>, <broonie@kernel.org>, <conor+dt@kernel.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>, <perex@perex.cz>,
	<tiwai@suse.com>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>
CC: <kernel@salutedevices.com>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v1 0/2] ASoC: meson: implement link-name optional property in meson audio card
Date: Mon, 8 Apr 2024 19:49:38 +0300
Message-ID: <20240408164947.30717-1-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184624 [Apr 08 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 15 0.3.15 adb41f89e2951eb37b279104a7abb8e79494a5e7, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/08 12:02:00 #24709100
X-KSMG-AntiVirus-Status: Clean, skipped

The 'link-name' is optional feature in the Device Tree that allows users
to customize the name associated with the DAI link and PCM stream.  This
feature provides enhanced flexibility in DAI naming conventions, leading
to improved system integration and a better user experience.

Dmitry Rokosov (2):
  ASoC: dt-bindings: meson: introduce link-name optional property
  ASoC: meson: implement link-name optional property in meson card utils

 .../bindings/sound/amlogic,axg-sound-card.yaml       |  6 ++++++
 .../bindings/sound/amlogic,gx-sound-card.yaml        |  6 ++++++
 sound/soc/meson/meson-card-utils.c                   | 12 ++++++++----
 3 files changed, 20 insertions(+), 4 deletions(-)

-- 
2.43.0


