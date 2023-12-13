Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC892810E4D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbjLMKXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbjLMKXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:23:42 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC16AC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:23:48 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c2c65e6aaso69343185e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702463026; x=1703067826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b3Y9AepTBicceLfnJXPPiR6HbdagL0klZXMtneHZgEA=;
        b=r/UsN1NkObBWRt9DDlw33Zp/fs1afWlKXvbwJ297/668VxK4nre4vK6uH3Y3hxT409
         Z/1bILcr0e3+QWiNO7zvmybEg36I6VspE+xkRnKnUR10VGppMK0Idwc3T3q4T76nHQYY
         z5eA8ZRAAURXhh890mUDvqqW4WSOGHeHvdTqQucNvslViPlBNFj32nKPg711DlaH0zul
         N/4oInv2FD9H1cOlimiNc84IHHPmF7TkZa1BLALVKz+gt7Qzj4XB+rD9aMaQy6meFSgo
         hs7Q7nSxplOxw74jcljIhVblsLfOFuILxavBZKRJf8BEernSp34UxZMK1+FiseMsovBF
         hymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702463026; x=1703067826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b3Y9AepTBicceLfnJXPPiR6HbdagL0klZXMtneHZgEA=;
        b=IstdjHcffogFG/Q9t10ZZSol3q9lLh37UvqmsuEC8yI+gq7B3UaaRLtNngpX6J7Fkr
         cZv7cIjqu6IjBSjBewrj6ZY5GqQwC/Xb3xgT/xL/IQuB2Al4ipr03kceoSzqJUs2jBIA
         zfLa7hVxC/WuBy4E4OQInVFmB0FpnojICkqYFi63ajVkk01W2S/rDnYt5//S8Aa/jKb+
         9AmobSyx1JONkzDnjOP7d2wW+DKmn1Kvqg9/IzBAl1ih4wR++skC0Conx3+TOdqDtqsV
         sjxepesM3Jk7oeF5ZQD5/xnKQrC3zrtvNrg6kFZF1D1e+YNwSv2W0EHTAAxY+0KV9m68
         WgAQ==
X-Gm-Message-State: AOJu0YwzJ1rfK7SkOgHuz+VVWcVPRCCtyNIL45onp5rQfpLeC2NuaiPm
        /kagfazQQxd2C0hu2fsvfRsWaw==
X-Google-Smtp-Source: AGHT+IEz4V8GZSQ/AfMq4yvzuJpArw/WSEoHiOgbrqLDihJh2QPp+nNsBtbNXyYBc4Jka6RFeZfPpQ==
X-Received: by 2002:a05:600c:181b:b0:40c:3dce:b02c with SMTP id n27-20020a05600c181b00b0040c3dceb02cmr3357917wmp.156.1702463026390;
        Wed, 13 Dec 2023 02:23:46 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id w7-20020a05600c474700b0040c41846919sm13705500wmo.41.2023.12.13.02.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 02:23:46 -0800 (PST)
Message-ID: <08788c2a-38c3-4cdd-8cff-e6681481cbef@linaro.org>
Date:   Wed, 13 Dec 2023 11:23:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] thermal: trip: Use for_each_trip() in
 __thermal_zone_set_trips()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
References: <5733564.DvuYhMxLoT@kreacher> <4529720.LvFx2qVVIh@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4529720.LvFx2qVVIh@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2023 20:41, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make __thermal_zone_set_trips() use for_each_trip() instead of an open-
> coded loop over trip indices.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

