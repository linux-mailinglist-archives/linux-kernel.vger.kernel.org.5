Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910738112E4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379062AbjLMNbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378978AbjLMNbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:31:20 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C792FE3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:31:23 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3333131e08dso7389562f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702474282; x=1703079082; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gT1+x2jNVKALOWKjd6FkOQOQNIpKL6HodGq+cYC6MoM=;
        b=qamF2V5PuQKFeC4U/9RO4DQ5g1CTlQrC9LpLjwo5ZY51pPFIUWO1gKuWWXFb55DxWh
         DWQcEnTZW8qg+yM/moCYvmu/+GnrWk5Db4WKmR6IEelFjmt9USwwzp1b9gG3PQ4QQJcQ
         h67wU+vlQnTmrOXQKqa0VSknRlL/Z5x+zn8RjC4jxTXgxBvWItd3jTI5j8YAj5ymHPmy
         Si/ZJCGye5VqS5Vi84PvJaCdF+c2dG/obaJ99biIRNt31hxZPXahuhEBob6Qx239uR08
         Mot+GhV/S8ZbLjvS72jtaBBCO4NuM55fa9+dNelWD9CrZ6eNBrtZBsdI2rYXOmF5KNIF
         o27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702474282; x=1703079082;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gT1+x2jNVKALOWKjd6FkOQOQNIpKL6HodGq+cYC6MoM=;
        b=qM3Uc5arwYttlB1gc+s0vo+Yev/vlGRGA8jAzc25Q0wMibUjplkN4y32NBbSeIsoqn
         ln5YkdZ9oJC3oqVwcP63XX+humIw1620hn/JI/cq3ONeYetUVfXRuh0Hc9xTJaRbtCor
         qM7tXhL5PAn5rwLgNO8NyuGUQA0Vcql3BVtW8q2n2ujdYFkGYveC3cM7sozDAQ2UvDKT
         L75tMMbGvnOREadUWeUkEcubs6UBj5ZkOsEEyQGurJxwXcuibM/6BDOiumMIHKmYv1xj
         z3X1twTJpbXkTimHBdZ2YKlY/Ef2OvupllZRcunC3USFvI31t5pAtxo/SyON12SmfLa4
         gSdw==
X-Gm-Message-State: AOJu0Yxqz3wTrSnazF3vxTnnRd2InJlWof2mMpGc/1HEhBuzq9EpOy6T
        DhrVqpKwWCtZzDJQ5yS9tbUMDg==
X-Google-Smtp-Source: AGHT+IE+E11nyqtn0hlYZuSK8aM31EzC/BzujBRteSYaLrs3lmlbx+QqDB2/JYVsDQYVeP2ePPFp+Q==
X-Received: by 2002:a05:600c:43d4:b0:40b:5e21:bde9 with SMTP id f20-20020a05600c43d400b0040b5e21bde9mr3652331wmn.120.1702474282158;
        Wed, 13 Dec 2023 05:31:22 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id fc7-20020a05600c524700b0040c44cb251dsm12863860wmb.46.2023.12.13.05.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 05:31:21 -0800 (PST)
Message-ID: <c7e4a344-ef15-4316-ac41-6ec9c062eabe@linaro.org>
Date:   Wed, 13 Dec 2023 14:31:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/core: Check get_temp ops is present when
 registering a tz
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20231213121322.2486967-1-daniel.lezcano@linaro.org>
 <CAJZ5v0gjeiCb9wBjdG+yWp5E_g2SPUMNNf-Stm_xkGau0Cbr2g@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gjeiCb9wBjdG+yWp5E_g2SPUMNNf-Stm_xkGau0Cbr2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2023 13:46, Rafael J. Wysocki wrote:
> On Wed, Dec 13, 2023 at 1:13 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> Initially the check against the get_temp ops in the
>> thermal_zone_device_update() was put in there in order to catch
>> drivers not providing this method.
>>
>> Instead of checking again and again the function if the ops exists in
>> the update function, let's do the check at registration time, so it is
>> checked one time and for all.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Looks good.  Do you want me to pick it up?

Yes please

Thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

