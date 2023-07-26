Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CDA762B33
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjGZGPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjGZGPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:15:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F177410B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690352099; x=1721888099;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=js5eLjuH8dKH2vHgVoNL1hwwICaDvEgaMk24LXytU+c=;
  b=FUqkaIOLDSVVPm0P0sG14/AmeZH7JrzolAZ/YNOoz3NGU59bnlt75cRU
   szfymFtZElkKYRxJ5di/SlyY4LRLpy6aUZVZfJLE8tqsh63c5rzPZIzPs
   HF/u6Y5e8c1lvTNSM3iMqzseol00660jmwNELu4WHYs7bL6bHNGw1A72o
   1Wk8jhUTC2kBWLfobm6vdAcPWaZBGptoP+4e0NxAQinW+8mJjQMzlyuwE
   Q62DUbtoUUIy8M4qmnB3VuWL96R3ZeEyN5NOThLSUfmqBG1XJC6Y5CIs9
   bsAQm9zXj0TG+teejWF2uRMy0iuY42L3WZnTcMX1Cfvlb6GIgtXipiCWw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="367950236"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="367950236"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 23:14:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="703606278"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="703606278"
Received: from brentlu-desktop.itwn.intel.com ([10.5.252.92])
  by orsmga006.jf.intel.com with ESMTP; 25 Jul 2023 23:14:54 -0700
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
Subject: [PATCH v2 0/2] Intel: sof_rt5682: remove quirk flag
Date:   Wed, 26 Jul 2023 22:08:46 +0800
Message-Id: <20230726140848.2267568-1-brent.lu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Brent Lu (2):
  ASoC: Intel: maxim-common: get codec number from ACPI
  ASoC: Intel: sof_rt5682: remove SOF_MAX98390_TWEETER_SPEAKER_PRESENT
    flag

 sound/soc/intel/boards/sof_maxim_common.c | 171 +++++++++++++---------
 sound/soc/intel/boards/sof_maxim_common.h |  21 ++-
 sound/soc/intel/boards/sof_rt5682.c       |  37 +----
 3 files changed, 112 insertions(+), 117 deletions(-)

-- 
2.34.1

