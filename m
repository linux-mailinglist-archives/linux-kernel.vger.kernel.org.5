Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E217E2745
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjKFOmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjKFOmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:42:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB32CD69;
        Mon,  6 Nov 2023 06:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699281718; x=1730817718;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Blf0199Gw4mvSrXSKGGBH3/GGxGUXwzOd/XtE3qOLdM=;
  b=YcLiAzTg2rCFwLuipAZJV2d9ieaQWiY1JZ9jIJy2r8e3/ODopIhWN1g1
   bUf+hVaSj+xCZjS5DuJz6HlraLUarQu8N7yJ2Tao8M4ABVZ+2myncT7y0
   9n9piESIinxY2fmP8GIKFpmuj05EMUMY+JyYOASKzsqZHacqP+lznsBnS
   50k/VC0TtrwxQnYApmRVZMBwglyA1CBXuQfuK1LsqPWQZ2Hv1ykwZyyNX
   tSaNVKBJQRivhaFW6VD0XUvfv8QHQE63ft5VHYXu+Kg07OazF1cyQlZD/
   SD+XVubGPEdFpwli2aJW9CELqSG/QlC6/Ooq/k246HA/WV8QniYxdPCJj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="379677766"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="379677766"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 06:41:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="1093799387"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="1093799387"
Received: from dpidwerb-mobl.amr.corp.intel.com (HELO [10.209.77.27]) ([10.209.77.27])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 06:41:56 -0800
Message-ID: <df6715a5-9e8d-4cbd-a654-2a18a021ff99@linux.intel.com>
Date:   Fri, 3 Nov 2023 10:29:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] soundwire: qcom: drop unneeded DAI .set_stream
 callback
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20231025144601.268645-1-krzysztof.kozlowski@linaro.org>
 <322002af-09e8-4d4c-bc85-81654c6b5f9d@linux.intel.com>
 <7af13415-ca58-4084-9aea-f805cf266bb8@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <7af13415-ca58-4084-9aea-f805cf266bb8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> Qualcomm Soundwire controller drivers do not support multi-link setups,
>>> so DAI .set_stream() callback will not be used.  What's more, if called
>>> it will overwrite the sdw_stream_runtime runtime set in DAI .startup
>>> (qcom_swrm_startup()) causing issues (unsupported multi-link error) when
>>> two Soundwire controllers are passed as codec DAIs.
>>
>> This last sentence is confusing at best.
>>
>> A controller can have one or more managers, each of whom can have one or
>> more peripherals.
>>
>> only peripherals should expose codec DAIs, managers should expose CPU DAIs.
>>
>> Put differently, the controller is the host part while the peripheral is
>> the codec part. "controllers passed as codec DAIs" is not really
>> possible, or this was a typo?
> 
> No, it wasn't a typo. Take a look here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts#n1023
> 
> The <&swr0 0> is the controller, although probably I should call it
> manager, but in case of Qualcomm I think they are 1-to-1.

Is this a case where the SoundWire manager is part of a codec?

In that case, how are the SoundWire peripheral modeled?

The .set_stream callback was really meant to be used when you have a CPU
DAI for the manager and a codec DAI for the peripheral(s). This seems to
be a different configuration where CPU and codec DAIs are mixed.
