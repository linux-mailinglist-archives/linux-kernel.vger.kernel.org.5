Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EC8765D20
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 22:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjG0UWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 16:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjG0UWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 16:22:39 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091BD19BA;
        Thu, 27 Jul 2023 13:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690489358; x=1722025358;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jWY2yyiMhHHy9qCZqmFdBV9+9C89ec7lr5dV5JithXU=;
  b=ikAPpRH00fC//GcJJccu20+ibtpoKD5xobyYG3LWatGrOat0dWHgwuBp
   7PRSypKZPBJFi1rMi8bpIQ92t36h2P87cLdOMc+QnTykgDO1f9gGiFnL+
   gzz1LsC+86OtzXXUx3A9h2ionmjVEaT2lT8/NYd8MtspDqOApe3LAoEZw
   0ysGlhT0Qyurm660z6OdDqGF2oLXgdSWVEfe/n5T0P1H2j7yCx2itWEWh
   kCb+sSHTiHabSo9Eyc11na4EMu28xR3JnVBEVkxJTY0WVlmf3BefX/X+8
   MN0r13SY5KhnV1hTKEx5Bvv+6J+t0fWA8R9dhiij8+m6ksv5goRogLlrX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="358441101"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="358441101"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 13:22:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="850915689"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="850915689"
Received: from mtyszka-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.133.203])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 13:22:34 -0700
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
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Iwona Winiarska <iwona.winiarska@intel.com>
Subject: [PATCH v3 0/4] Add support for PECI Nuvoton
Date:   Thu, 27 Jul 2023 22:21:22 +0200
Message-Id: <20230727202126.1477515-1-iwona.winiarska@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Thank you Tomer for testing this series on Nuvoton hardware [2].

Please note that PECI Nuvoton was previously submitted as part of PECI
subsystem series [3] that was never merged upstream.
It was never included in the current in-tree PECI subsystem [4].

[1] https://lore.kernel.org/openbmc/CAP6Zq1jnbQ8k9VEyf9WgVq5DRrEzf5V6kaYP30S7g9BV9jKtaQ@mail.gmail.com/
[2] https://lore.kernel.org/openbmc/CAP6Zq1h1if4hyubyh6N8EOdGOu+zp0qVUimF-9L2eXZ-QFAYjw@mail.gmail.com/
[3] https://lore.kernel.org/all/20191211194624.2872-1-jae.hyun.yoo@linux.intel.com/
[4] https://lore.kernel.org/all/20220208153639.255278-1-iwona.winiarska@intel.com/

Changes v2 -> v3:

* Fixed dt_binding_check error (Rob)

Changes v1 -> v2:

* Renamed binding filename to match compatible (Krzysztof)
* Removed period from the end of copyright (Paul)

Thanks
-Iwona

Iwona Winiarska (2):
  ARM: dts: nuvoton: Add PECI controller node
  arm64: dts: nuvoton: Add PECI controller node

Tomer Maimon (2):
  dt-bindings: Add bindings for peci-npcm
  peci: Add peci-npcm controller driver

 .../bindings/peci/nuvoton,npcm-peci.yaml      |  56 ++++
 .../dts/nuvoton/nuvoton-common-npcm7xx.dtsi   |   9 +
 .../dts/nuvoton/nuvoton-common-npcm8xx.dtsi   |   9 +
 drivers/peci/controller/Kconfig               |  16 +
 drivers/peci/controller/Makefile              |   1 +
 drivers/peci/controller/peci-npcm.c           | 298 ++++++++++++++++++
 6 files changed, 389 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/peci/nuvoton,npcm-peci.yaml
 create mode 100644 drivers/peci/controller/peci-npcm.c

-- 
2.40.1

