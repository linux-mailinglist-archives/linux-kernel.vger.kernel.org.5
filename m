Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C2F75CAE4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjGUPFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjGUPFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:05:53 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C91030D2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:05:52 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6687446eaccso1800229b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689951951; x=1690556751;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=J9t01tW//Y6gnQbuHCuY82CsGI5YDsJjCU5CUuuUpoE=;
        b=rXCT7zqYzdLCND5aqcr5GTp7x9G6pdO4FzrpiZ2KNLoeERbFMAsG1wAUwplKh61/7V
         MK8P7RgwY0moT1kYsXl1rnf2cStBEAdP1qIbRF7VQ5wqWN6sz2f2bXFFhL23AajxUVEk
         mTDumd5sm0KKHTWDfxPiWuVynPGUmOVXclguRTmODsW9oa1ga7e2RIeiWm6fTtP4bSlb
         moCRNr6uDO8iarO1Y9GQV1kqxmQDExLbkMhIumBZf1JV4VC7z6oUIV9B8333vTTQdfwV
         EHsUAY8biAJfqdKr0G+454NFq1Ez43lw2wlGRkzx1by/BxCObFGrmbyAj/IXOSWVfJzd
         zyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689951951; x=1690556751;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J9t01tW//Y6gnQbuHCuY82CsGI5YDsJjCU5CUuuUpoE=;
        b=NV1KQoypej6gFH+Xm0RL31uEFnOUPcqlNoNn74JHdA071JsBTsRJU1ymYklhDUNCnC
         Nltjea5XYXn8TvNCCxWdDTmuJ+khFpZpu8PAfpwTO0jUOGj6cxkJrmRiu488r1Ev9/oj
         AaBY92F2Eye3dCB440+WD8FIouv69NVwkxe14DTvSbbqm3lC/Mo+pKr+E7o5v/e8YqvS
         9Rr3izQvr8POthZcKe7SZBgURQ7oKatEQjJLVfxyJdmPJydE4Ein1otgzcktMczXN1fN
         mFfNWPplGjUSPJUEtpOUIYH5a4rJQPvlP62M1ChD9MflDzFOMHmPZasiWz/aTkk8MGzy
         yUqw==
X-Gm-Message-State: ABy/qLZfHSx2nUZtfkr1TJ9ds8vyi4QB7qRRGPOQZ5UNNbfJP+ROX/PG
        OOc+zLxub7DpNjzG0n8Xd2E=
X-Google-Smtp-Source: APBJJlGLjfetE/RgN+oM5Re8ZUebhuRS7XfGImhqYtc42yxWtNTYlACvUxIP7Uy+l098LSbdbOM6XA==
X-Received: by 2002:a05:6a00:2486:b0:682:37be:c9fe with SMTP id c6-20020a056a00248600b0068237bec9femr411699pfv.10.1689951951460;
        Fri, 21 Jul 2023 08:05:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s15-20020a62e70f000000b0063d2dae6247sm3110766pfh.77.2023.07.21.08.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 08:05:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e79bcf87-472d-f785-d4bc-d7c744b23781@roeck-us.net>
Date:   Fri, 21 Jul 2023 08:05:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 2/2] regmap: Reject fast_io regmap configurations with
 RBTREE and MAPLE caches
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
References: <20230720032848.1306349-1-linux@roeck-us.net>
 <20230720032848.1306349-2-linux@roeck-us.net>
 <CGME20230721145342eucas1p12e658a54d36d985b2811e2c21f7810ee@eucas1p1.samsung.com>
 <c2bba4df-da1f-5666-89aa-28c6700575ca@samsung.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <c2bba4df-da1f-5666-89aa-28c6700575ca@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/23 07:53, Marek Szyprowski wrote:
> Hi,
> 
> On 20.07.2023 05:28, Guenter Roeck wrote:
>> REGCACHE_RBTREE and REGCACHE_MAPLE dynamically allocate memory for regmap
>> operations. This is incompatible with spinlock based locking which is used
>> for fast_io operations. Reject affected configurations.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> This seems prudent, given that accesses will be protected by spinlock
>> but may allocate memory with GFP_KERNEL. Another option might be to use
>> WARN_ON instead of rejecting the configuration to avoid hard regressions
>> (and I think both drivers/net/ieee802154/mcr20a.c and
>> sound/soc/codecs/sti-sas.c may be affected, though I can not test it).
> 
> This patch, which landed in today's linux-next, breaks operation of the
> RockChip's VOP2 DRM driver
> (drivers/gpu/drm/rockchip/rockchip_drm_vop2.c). I'm not sure what is the
> proper fix in this case. Should one change the cache type to REGCACHE_FLAT?
> 

Ah, I missed regcache_init_mmio() when looking for affected drivers.
This affects a larger number of drivers than I thought. In addition
to the drivers mentioned above,

  drivers/soc/qcom/icc-bwmon.c
  sound/soc/bcm/bcm2835-i2s.c
  sound/soc/codecs/jz4740.c
  sound/soc/fsl/fsl_aud2htx.c
  sound/soc/fsl/fsl_easrc.c
  sound/soc/fsl/fsl_micfil.c

all use unsafe locking (spinlock with REGCACHE_RBTREE).

Thanks,
Guenter

> 
>>    drivers/base/regmap/regmap.c | 9 +++++++++
>>    1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
>> index 89a7f1c459c1..b4640285c0b9 100644
>> --- a/drivers/base/regmap/regmap.c
>> +++ b/drivers/base/regmap/regmap.c
>> @@ -777,6 +777,15 @@ struct regmap *__regmap_init(struct device *dev,
>>    	} else {
>>    		if ((bus && bus->fast_io) ||
>>    		    config->fast_io) {
>> +			/*
>> +			 * fast_io is incompatible with REGCACHE_RBTREE and REGCACHE_MAPLE
>> +			 * since both need to dynamically allocate memory.
>> +			 */
>> +			if (config->cache_type == REGCACHE_RBTREE ||
>> +			    config->cache_type == REGCACHE_MAPLE) {
>> +				ret = -EINVAL;
>> +				goto err_name;
>> +			}
>>    			if (config->use_raw_spinlock) {
>>    				raw_spin_lock_init(&map->raw_spinlock);
>>    				map->lock = regmap_lock_raw_spinlock;
> 
> Best regards

