Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678E6768A15
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 04:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjGaCka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 22:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjGaCk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 22:40:28 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBD2E1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 19:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690771227; x=1722307227;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/zCvpUO3+yntTjDh38Ej4kXqiMhmp7yIaO7/Tr0CFyE=;
  b=O1dJ2FMYHZsYruY90aoFv+qlFXMbBSekH1cIuE4uu8ZROQ0w0SjCCec/
   hSZVZx6Ll5as3slBzW9w5VfeawbBB/NRuwA1LmT6MH9Iy/FXqItquXVzZ
   xMLiscTFhmjzvDW+Xcj6uIebsw5QkTj/uWjITk+zlLe+KO+BtGntA0OMI
   TByMpoRPZwycsp0pV8j1aVyjsg6nvzRSf0xLr8eOK/+mP6PGi+frCN8QE
   yx33Eudqsr0mhmj0IH0zSa/6rdxcob/J56kWPccUGtpqEVYprcs6jtKZ/
   y4RjM/LPf+6VShMtF+GpQVcK88h2QZQ6WHfdsNEE7KbpKiuj8KjavSsY8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="349205989"
X-IronPort-AV: E=Sophos;i="6.01,243,1684825200"; 
   d="scan'208";a="349205989"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2023 19:40:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="678158299"
X-IronPort-AV: E=Sophos;i="6.01,243,1684825200"; 
   d="scan'208";a="678158299"
Received: from brentlu-desktop.itwn.intel.com ([10.5.252.92])
  by orsmga003.jf.intel.com with ESMTP; 30 Jul 2023 19:40:22 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        linux-kernel@vger.kernel.org,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Terry Cheong <htcheong@chromium.org>,
        Uday M Bhat <uday.m.bhat@intel.com>,
        Mac Chiang <mac.chiang@intel.com>,
        "Dharageswari . R" <dharageswari.r@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 0/1] Intel: sof_rt5682: remove quirk flag
Date:   Mon, 31 Jul 2023 18:34:18 +0800
Message-Id: <20230731103419.2536036-1-brent.lu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add a helper function to detect amplifier number according to device instance
in ACPI table so the SOF_MAX98390_TWEETER_SPEAKER_PRESENT flag and a dmi quirk
for 4-amplifier configuration could be safely removed.

Also refactor the max_98390_hw_params() function to use an array to handle the
TDM parameter.

Amplifier number detection and TDM parameter are tested on two Chromebooks. One
with 2 MAX98390 and one with 4 MAX98390 amplifier.

V2 Changes:
- fix some typos in cover letter
- use for_each_acpi_dev_match() macro to simplify the codec
- use 'unsign int' for codec number variable

V3 Changes:
- replace pr_err() with dev_err()

V4 Changes:
- merge two patches to avoid build break
- remove redundant assignment in max_98390_hw_params()
- refactor MAX_98390_DEVX_NAME macros

Brent Lu (2):
  ASoC: Intel: maxim-common: get codec number from ACPI
  ASoC: Intel: sof_rt5682: remove SOF_MAX98390_TWEETER_SPEAKER_PRESENT
    flag

Brent Lu (1):
  ASoC: Intel: maxim-common: get codec number from ACPI table

 sound/soc/intel/boards/sof_maxim_common.c | 170 +++++++++++++---------
 sound/soc/intel/boards/sof_maxim_common.h |  21 ++-
 sound/soc/intel/boards/sof_rt5682.c       |  37 +----
 3 files changed, 111 insertions(+), 117 deletions(-)

-- 
2.34.1

