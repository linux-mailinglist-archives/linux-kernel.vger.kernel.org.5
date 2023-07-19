Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE48F75A16C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjGSWJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjGSWJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:09:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4941A1FED;
        Wed, 19 Jul 2023 15:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689804589; x=1721340589;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ftsOd0/msTRbiPjXA/7AII+Hzrj2S9DmY8KrU3qmrxg=;
  b=YAb8KTihPAou3KzSAqrdwwQ6S4X7qnVw2cv5MDrVYSjbb7SXCz7JiRYy
   oR7EgEIpFz0XJerBRCPptpTtfjyOya39HMIoRHbcWzUcqKfFsR+/oNsld
   10QDugJ1DsDzlaoTrI5DqCn+OK09Q3A7rUyqCim8KfNBCaLA2KVxYr/LW
   tnC4qX1SwlIDsn8VPA/w4QQzRL+rn3F4I8P1Dluww32Qa9MgPEShtDOMK
   g0+0oih8e0mjvxU4FxpxXODWXtVboOfwXR0gCZS1rD9BzRmpMKZUHeZk6
   zG29osSV48pagNANP/PpPw/YO6O68hJ8jBjD0J85A6e6VCXZmBqlMsSh5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="369232105"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="369232105"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 15:09:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="970782060"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="970782060"
Received: from patroagn-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.131.68])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 15:09:28 -0700
From:   Iwona Winiarska <iwona.winiarska@intel.com>
To:     openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Iwona Winiarska <iwona.winiarska@intel.com>
Subject: [PATCH 0/4] Add support for PECI Nuvoton
Date:   Thu, 20 Jul 2023 00:08:49 +0200
Message-Id: <20230719220853.1029316-1-iwona.winiarska@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The series adds support for PECI on Nuvoton-based BMC boards.
It is based on patches that were sent by Tomer Maimon from
Nuvoton [1].
Similar to Aspeed driver, unused (as in, default values were used in
all of the available DTS files) vendor-specific properties were
removed.
If there is a use-case for such properties, they can be added in
a separate series.

Thank you Tomer for testing this series on Nuvoton hardware.

Thanks
-Iwona

[1] https://lore.kernel.org/openbmc/CAP6Zq1jnbQ8k9VEyf9WgVq5DRrEzf5V6kaYP30S7g9BV9jKtaQ@mail.gmail.com/

Iwona Winiarska (2):
  ARM: dts: nuvoton: Add PECI controller node
  arm64: dts: nuvoton: Add PECI controller node

Tomer Maimon (2):
  dt-bindings: Add bindings for peci-npcm
  peci: Add peci-npcm controller driver

 .../devicetree/bindings/peci/peci-npcm.yaml   |  56 ++++
 .../dts/nuvoton/nuvoton-common-npcm7xx.dtsi   |   9 +
 .../dts/nuvoton/nuvoton-common-npcm8xx.dtsi   |   9 +
 drivers/peci/controller/Kconfig               |  16 +
 drivers/peci/controller/Makefile              |   1 +
 drivers/peci/controller/peci-npcm.c           | 298 ++++++++++++++++++
 6 files changed, 389 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/peci/peci-npcm.yaml
 create mode 100644 drivers/peci/controller/peci-npcm.c

-- 
2.40.1

