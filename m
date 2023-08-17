Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF04777FC1B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352978AbjHQQ2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353704AbjHQQ2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:28:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BDE2710
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692289708; x=1723825708;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M5vizv/ucjvl18dOwhMFXlFRanUNXU//G2+Phfes9dY=;
  b=FBOcp3fA/go/GPNzrM0KpedI6+56JpFILRrIsDbbrzcUUQMHwN6PBISk
   qkuxGD4+kovUiwJHOcKQokyzLU+8VmQssRE/Mx7xspgmStnXNyfifv3j8
   M9ffxyu8qHzFmc6o8lq2XAAsbk3xO1lqsPATpXVoPb494BuMFJ2Jugl70
   5Wr/00nFGGLsKo13NVcgiX9+PLZsOwoCvSgx1Eb8kuLzBjFqFsEvmq9FT
   dKhmo8VIDUmkU4F9F3PSM2qffQsDXhcCT/f/gonffSBhHIfv/TDzPCRVo
   5pcOrg4k+Xft1KxtZi5kLLwaXu66KU0I2iUohrJRK+yic2XRlmQiBFvhk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="376622318"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="376622318"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 09:28:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="728203369"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="728203369"
Received: from cerondon-mobl1.amr.corp.intel.com (HELO [10.212.36.16]) ([10.212.36.16])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 09:28:25 -0700
Message-ID: <6adf5b5d-fa61-667f-2c6c-6211d28d1ddb@linux.intel.com>
Date:   Thu, 17 Aug 2023 11:28:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v2] ASoC: tas2783: Add source files for tas2783 soundwire
 driver
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Baojun Xu <baojun.xu@ti.com>, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, shenghao-ding@ti.com, kevin-lu@ti.com,
        krzysztof.kozlowski@linaro.org, rf@opensource.cirrus.com,
        shumingf@realtek.com, herve.codina@bootlin.com,
        povik+lin@cutebit.org, ryans.lee@analog.com,
        ckeepax@opensource.cirrus.com, sebastian.reichel@collabora.com,
        fido_max@inbox.ru, wangweidong.a@awinic.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        peeyush@ti.com, navada@ti.com, tiwai@suse.de,
        mengdong.lin@intel.com
References: <20230814121158.4668-1-baojun.xu@ti.com>
 <b28b5187-e775-4c4d-635e-9b867a19588e@linux.intel.com>
 <19414ebc-1c33-4482-965d-681f15f06654@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <19414ebc-1c33-4482-965d-681f15f06654@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/17/23 10:12, Mark Brown wrote:
> On Thu, Aug 17, 2023 at 09:17:50AM -0500, Pierre-Louis Bossart wrote:
> 
>>> +		goto out;
>>> +	}
>>> +	/* Read the primary device as the whole */
>>
>> I can't figure out what this comment means
> 
> It's part of...
> 
>>> +		dev_err(tas_dev->dev, "%s, regmap doesn't exist.\n",
>>> +			__func__);
>>> +		return -EINVAL;
>>> +	}
>>> +	/* Read the primary device */
>>
>> What is a primary device?
> 
> ...a thing where they're trying to present multiple devices as a unified
> device with grouped control, it looks like there's some hardware support
> for this.

Let me clarify the comment: SDCA peripheral can have multiple functions,
each with its own address space and can operate independently. So I am
just trying to have clarity on what 'device' means here.

>>> +	/* Failed got calibration data from EFI. */
> 
>> I don't get what the dependency on EFI is. First time I see a codec
>> needing this.
> 
>> Please describe in details what you are trying to accomplish.
> 
> It seems fairly normal to store calibration details in the device
> firmware?

No objection on the device firmware, but why use an EFI variable?

There is on-going work to standardize with ACPI, and there's also a
request_firmware(). Not sure what the direction is to read from an EFI
variable. I've been in SDCA circles since the beginning and never heard
about this, ever. I am not saying it's bad, just surprised and curious
on a 3rd way of getting information needed for initialization.

>>> +	if (crc == tmp_val[21]) {
>>> +		time64_to_tm(tmp_val[20], 0, tm);
>>> +		dev_dbg(tas_priv->dev, "%4ld-%2d-%2d, %2d:%2d:%2d\n",
>>> +			tm->tm_year, tm->tm_mon, tm->tm_mday,
>>> +			tm->tm_hour, tm->tm_min, tm->tm_sec);
> 
>> What is this about? Why would a codec care about time?
> 
> I can see someone finding it helpful to confirm when the calibration data
> that got applied was generated to make sure they're testing/using what
> they thought they were.

Ah yes, I missed that. I wasn't sure if this was a log on when the
calibration finished, if this is a log on when the calibration data was
generated that's a different story indeed.

>> In addition, it's rather surprising that on attachment there is not a
>> single regmap access?
> 
> Don't know if there's something different with Soundwire but for I2C/SPI
> devices it's a reasonable pattern to only actually start initialising
> the registers when the device actually becomes active.  Not checked that
> this is actually happening.

that's precisely the point, there's an io_init() routine which is when
the peripheral is attached on the bus and the earliest time when the
registers can be initialized.

But there isn't a single initialization happening, which is different to
all existing SoundWire codec drivers. Maybe it's fine, I am just asking
the question if this was intentional.
