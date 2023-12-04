Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB66803A9B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjLDQoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjLDQoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:44:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB3AAC;
        Mon,  4 Dec 2023 08:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701708250; x=1733244250;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8gQdgndpZFQZb2gJqlOJ/xwgQA+emZiGmAjbrIpj5Xs=;
  b=J9Bep8zsjFMdehpyfTpx1Jy9YHC+B8Th5yFVqqxod2mm+1RSIgHVRQEG
   +nOxHCdb7GWvDMlqTLBO9+GlYdaWm1R6fNU9PWz3xnpYiifnTjZJ9Mr9S
   i5Ul7NCM8Hde7Tc6ecCcCzW/CqDVqSNDF8QymqGwOWcGq8i/RcqLBbZua
   eUmck8VKivrRNsckGujhOBqaulPml5Ns6cwew6zSAZ1uK+5886QMAx5Cj
   W9P71dqyeNIhYiJrzc1RvMNoVSbsuR5B11JNCil/dQmbNZ5Zrbx9ntSrR
   QSSgs2zS3UYys3tqAeC8501eCAtWqe1RQQVT+Fsy3aBtuGswz74LGdZuk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="12476131"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="12476131"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 08:44:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="836641461"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="836641461"
Received: from sdneilso-mobl1.amr.corp.intel.com (HELO [10.212.147.197]) ([10.212.147.197])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 08:44:09 -0800
Message-ID: <041f60ab-a90a-4654-afd2-c2a296a25c46@linux.intel.com>
Date:   Mon, 4 Dec 2023 10:44:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ASoC: Intel: soc-acpi-intel-tgl-match: add cs42l43 and
 cs35l56 support
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, broonie@kernel.org,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com
Cc:     kai.vehmanen@linux.intel.com, cezary.rojewski@intel.com,
        ranjani.sridharan@linux.intel.com, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20231204135614.2169624-1-rf@opensource.cirrus.com>
 <8510b464-9352-480d-88cf-857597e16cbc@linux.intel.com>
 <f2dec209-6bc7-49ab-9dff-57a2ca4efb03@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <f2dec209-6bc7-49ab-9dff-57a2ca4efb03@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Don't we need the same change of name_prefix for
>> soc-acpi-intel-mtl-match.c? I see this in the existing code:
>>
> 
> The chain that Peter sent only has CS35L56 added to tgl-match.
> 
> I've checked the history of mtl-match and the patch that added CS35L56
> there was not cc'd to any cirrus.com email address so we didn't notice
> it. Otherwise we would have picked this up earlier. alsa-devel is noisy.
> 
> I haven't got a MTL platform to test on but I can send a separate patch
> to change mtl-match if you are happy with this prefix change.

That would be nice, best to align on all platforms and use the same the
same prefix.
