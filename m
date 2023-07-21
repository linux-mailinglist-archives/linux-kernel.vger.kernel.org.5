Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF7D75C3DA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjGUJ6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjGUJ5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:57:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804883A86
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689933447; x=1721469447;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bhA2Wac8b35OMVZeZH3cwBC9dodh2jsNgsqPsAZy4eI=;
  b=FD36VlDkgq187Rh8Zzp7IHPRnrw0xdcEGwA6+q1Ofbjv+fyUBrtALq97
   gzPzdMFVBoz/o2QmDuQKqHRQoZRuM4OYZNIvRDEPO4JDFdT8bcBSuo5YY
   dHLTe/qGKuerNTOKjI+6WqERti+Hjh3y+wVB0RdqBahuvXYdSv1atOTJm
   8eBWRy8tMWNYIMbll26VZj3GpJF+OTaTWNWSWJLw6qcS8mvsZ2SB+P4xE
   yWilUFM+E1iqr2fQk8HjZJgFwREx73pUdyfhFJZtX2/C8mXGzzIWJndR8
   5n69jY1VFND6aaWExf2bIwmdAzscGKmJ4wCr7+7nqMP89HqbmSGOdgidM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="367023674"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="367023674"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 02:57:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="718762469"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="718762469"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 02:57:04 -0700
Date:   Fri, 21 Jul 2023 12:53:43 +0300 (EEST)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     Brent Lu <brent.lu@intel.com>
cc:     Alsa-devel <alsa-devel@alsa-project.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Yong Zhi <yong.zhi@intel.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Uday M Bhat <uday.m.bhat@intel.com>,
        Terry Cheong <htcheong@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        "Dharageswari . R" <dharageswari.r@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 0/2] Intel: sof_rt5682: remove quirk flag
In-Reply-To: <20230720092628.758834-1-brent.lu@intel.com>
Message-ID: <alpine.DEB.2.22.394.2307211249190.3532114@eliteleevi.tm.intel.com>
References: <20230720092628.758834-1-brent.lu@intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 20 Jul 2023, Brent Lu wrote:

> We add a helper funcion to detect amplifier number according to device instance
> in ACPI table so the SOF_MAX98390_TWEETER_SPEAKER_PRESENT flag and a dmi quirk
> for 4-amplifier configuration could be safely removed.
> 
> Also refactory the max_98390_hw_params() function to use an array to handle the
> TDM parameter.
> 
> Amplifier number detection and TDM parameter are tested on two Chromebooks. One
> with 2 MAX98390 and one with 4 MAX98390 amplifier.
> 
> 
> *** BLURB HERE ***

this looks like a nice cleanup, thanks Brent. For the series:

Acked-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Minor nit: some spelling erros in cover letter (funcion->function, 
refactory->refactor, BLURB HERE left), but I think the intent 
comes across.

Br, Kai
