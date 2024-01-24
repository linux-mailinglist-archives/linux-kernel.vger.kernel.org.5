Return-Path: <linux-kernel+bounces-36763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8CD83A633
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8295A1F224F3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ED518624;
	Wed, 24 Jan 2024 10:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YN0JKvz6"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCCC182AB;
	Wed, 24 Jan 2024 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090442; cv=none; b=mPKkyIbV7tQ84pAHZB0mY5P5HD0dL5Q7pGVYPAyO/EvvzffQrIAyeKS/6OTvb9RBvQi+fA3faDANep1tMIqrATFxRxz/HU6HG9dd82KuytmyEyUUIh4v37FBqAWwRnHDoR0j/6H6Vp0Fi61sBuUbe5J8Kjxqr7yQ2K9fFJIG3nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090442; c=relaxed/simple;
	bh=Qcy7KASQpJcfi8VSdmUwGdH1p+9p1Q+pb+US7vRXCTw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WtYp3HrGFjrYSdlFQNYcU8Hf6Aq40WO+BaWxC4QHW65N9R6EqpnmRmw8901hrfa5NYY52CK8G8ZoO8awe0pYw0rjtcF3JiEyt2FuG5txI5IDP2ATCsBPtizr6cBEzLKEnJUoKJBPrZU0RMwW4plmP86xhFe8nwkSd/14w9mbA1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YN0JKvz6; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706090440; x=1737626440;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qcy7KASQpJcfi8VSdmUwGdH1p+9p1Q+pb+US7vRXCTw=;
  b=YN0JKvz6NKLJEP8wf+bTLYxmFb1VaaZLfIeZGTqZcH5ZbcaOazg3opDN
   qEGipeAcAA/1ctapNjSkBlo7brLTvVFsFNyjFSGjoNSOQ0K89JgapkwYp
   qrMCTFXiXmDgajB/kVxrGvQ4HhAMI47WLvpbFXIhgq6mmoNNMD8pNIayD
   PMuvnDGS5g89TwSVknousagYrmQXkKNZ9hmrEW8UIAJFM31N24sTxOMyr
   pWeJnS7RSOw2advx4tq74C2suS4qAsdGrblqgnZY5iXKsTdOOvDuMGri1
   BOp498Lqomd5NLpN1J9V15pkHQYg9jZb4HARAGacAMY0IKKmt6RToEo38
   Q==;
X-CSE-ConnectionGUID: KW48kSavSe+zQ6q8gM/eDg==
X-CSE-MsgGUID: 1qPUaEYFTb6zPV2BNV9RQA==
X-IronPort-AV: E=Sophos;i="6.05,216,1701154800"; 
   d="scan'208";a="16475526"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jan 2024 03:00:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 03:00:31 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 03:00:23 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <sam@ravnborg.org>, <bbrezillon@kernel.org>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lee@kernel.org>, <thierry.reding@gmail.com>,
	<u.kleine-koenig@pengutronix.de>, <linux-pwm@vger.kernel.org>
CC: Dharma Balasubiramani <dharma.b@microchip.com>
Subject: [PATCH v4 0/3] Convert Microchip's HLCDC Text based DT bindings to JSON schema
Date: Wed, 24 Jan 2024 15:30:16 +0530
Message-ID: <20240124100019.290120-1-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Converted the text bindings to YAML and validated them individually using following commands

$ make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/
$ make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/

changelogs are available in respective patches.

As Sam suggested I'm sending the PWM binding as it is in this patch series, clean up patch
will be sent as separate patch.

Dharma Balasubiramani (3):
  dt-bindings: display: convert Atmel's HLCDC to DT schema
  dt-bindings: atmel,hlcdc: convert pwm bindings to json-schema
  dt-bindings: mfd: atmel,hlcdc: Convert to DT schema format

 .../atmel/atmel,hlcdc-display-controller.yaml | 85 ++++++++++++++++
 .../bindings/display/atmel/hlcdc-dc.txt       | 75 --------------
 .../devicetree/bindings/mfd/atmel,hlcdc.yaml  | 97 +++++++++++++++++++
 .../devicetree/bindings/mfd/atmel-hlcdc.txt   | 56 -----------
 .../bindings/pwm/atmel,hlcdc-pwm.yaml         | 44 +++++++++
 .../bindings/pwm/atmel-hlcdc-pwm.txt          | 29 ------
 6 files changed, 226 insertions(+), 160 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/atmel/atmel,hlcdc-display-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt

-- 
2.25.1


