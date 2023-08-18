Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408A3781073
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378665AbjHRQgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358707AbjHRQgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:36:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D223C0F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 09:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692376583; x=1723912583;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nU+PYoRb2aLoPBQUdYTgkTX6GiAk6mSXJt392VHyqBs=;
  b=cRqZbBfuA/dlKpSicJMjYEnC8Xm3v2zhpDoILFDB4GWwPu39NReHz1P7
   b8sTGfoqzJnBmDZQfpDrWrqymhcQ18zVld4GZyjF9hNtGjU/jzrXzUM0H
   LQz7IT3Bh3vTYWCmJohQDHqA0ipxvqKkOPU9bafq6cIly7GAk5bEEthUc
   rqGAj4HvQSEFJgsV8bH8oJxxETQ2Qv00pQebmYmrjS1+4476pACmLLwL+
   Z7T83Xe69+UyIIuXLZvvaKbgEiZz1Htf+6J+iJZdaow+xzjrqhQkb0Fsp
   SVVsgR9fwygFfMq5NNn4H+f24uhrk5S39ee93LYhpGzJfljRRFyCvW9J8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="370599339"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="370599339"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 09:36:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="728649714"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="728649714"
Received: from enewberr-mobl.amr.corp.intel.com (HELO [10.212.37.100]) ([10.212.37.100])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 09:36:17 -0700
Message-ID: <72960354-3f69-e2fa-e7b0-dc8b61ca4940@linux.intel.com>
Date:   Fri, 18 Aug 2023 11:36:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 1/2] ALSA: hda/tas2781: Add tas2781 HDA driver
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>, Shenghao Ding <shenghao-ding@ti.com>
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        kevin-lu@ti.com, 13916275206@139.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
        mengdong.lin@intel.com, baojun.xu@ti.com,
        thomas.gfeller@q-drop.com, peeyush@ti.com, navada@ti.com,
        broonie@kernel.org, gentuser@gmail.com
References: <20230818085836.1442-1-shenghao-ding@ti.com>
 <87pm3kk63a.wl-tiwai@suse.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <87pm3kk63a.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/23 05:17, Takashi Iwai wrote:
> On Fri, 18 Aug 2023 10:58:35 +0200,
> Shenghao Ding wrote:
>>
>> Integrate tas2781 configs for Lenovo Laptops. All of the tas2781s in the
>> laptop will be aggregated as one audio device. The code support realtek
>> as the primary codec. Rename "struct cs35l41_dev_name" to
>> "struct scodec_dev_name" for all other side codecs instead of the certain
>> one.
>>
>> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
> 
> Now I applied both patches to for-next branch.
> 
> The patch 2 needed some minor adjustment in Kconfig to be applied to
> the latest branch, but I resolved it locally.

There are a number of issues I just reported, I guess they will have to
be handled with a follow-up patch now?
