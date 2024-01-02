Return-Path: <linux-kernel+bounces-14289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE71E821AEB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ECCC2831D5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014BBE57E;
	Tue,  2 Jan 2024 11:28:56 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0F3DF78;
	Tue,  2 Jan 2024 11:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(636813:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 02 Jan 2024 19:28:24 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27; Tue, 2 Jan
 2024 19:28:24 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1258.27 via Frontend
 Transport; Tue, 2 Jan 2024 19:28:24 +0800
From: <cy_huang@richtek.com>
To: Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
	ChiYuan Huang <cy_huang@richtek.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] RTQ6056: Add compatible for the same chip family
Date: Tue, 2 Jan 2024 19:28:20 +0800
Message-ID: <cover.1704189363.git.cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: ChiYuan Huang <cy_huang@richtek.com>

RTQ6053 and RTQ6059 are the same RTQ6056 family.
The differences are listed below
- RTQ6053
  Only change chip package type
- RTQ6059
  1. Enlarge the shunt voltage sensing range
  2. Shrink the pinout for VBUS sense pin
  3. Due to 1, the scale value is also changed

Since v3:
- Add Reviewed-by tag in binding document patch
- Resotre the enum for control field.
- Put all the predefined datas/callbacks in dev_data.
- Remove the unused 'rtq6059_info'.
- Change 'default_conv_time' to 'default_conv_time_us'.
- Move the comment for default config above the dev_data setting line.

Since v2:
- Refine the description of 'compatible' property

ChiYuan Huang (2):
  dt-bindings: iio: adc: rtq6056: add support for the whole RTQ6056
    family
  iio: adc: rtq6056: Add support for the whole RTQ6056 family

 .../bindings/iio/adc/richtek,rtq6056.yaml     |   9 +-
 drivers/iio/adc/rtq6056.c                     | 270 ++++++++++++++++--
 2 files changed, 259 insertions(+), 20 deletions(-)


base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a
-- 
2.34.1


