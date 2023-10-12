Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7989F7C716E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379418AbjJLP3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjJLP3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:29:17 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0408BE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:29:15 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40566f89f6eso13509565e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697124554; x=1697729354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BQ1+RhaoyXyyELCn9uQBRvQoNPlNs+ucZspdlusCgJA=;
        b=T8bBA0TNmLgq4ZmM8DBvKJgf010upYZfUNa/EdQ4ApjSx3usAYTJGHA8J8Yoix+vLr
         3AJ9pzvHgSkOWTIhPTO0YH7Kb9x8wJPhSEHJ8I2ITl49L4kZmMbYw7GFWNnj2N31Xa8T
         m5G1GsjJeo9DcoeeUWaMLgr9p7h3AVXi176KBX3Ddr2uIafQEhD3nXP29HDCDhbs/gIU
         lsh0c/CqZb4klAt+GW66vSEK9GL6YoVyyGe1BSSvYLafgnYwre5Z/6xqNv5OrN1xCTgN
         WtjRbf9+9ogL1+p079FSgQWZbwfGJf7TOz+ssTrRwmhNrZkreAwmkc2DPhGdjr1Tfqdv
         rklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697124554; x=1697729354;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQ1+RhaoyXyyELCn9uQBRvQoNPlNs+ucZspdlusCgJA=;
        b=tGUQY10JBQ8vQ7DOAX4PxjSUZi1Fe7fjcq6sgd8mX+SBG85Eugm52qQPScb0STIf0S
         VioEU2FbPEDw0IeY5oaSWwJnslB2d/upXF/sDSpq/0DS0V/3jAu/KqQ1fqiuOu7Dh1qM
         u58OOY8VGGEHCXPMjSUMD4bax46qNfDNPAZwsQ7AiCLUpuNvCAg30pjRgPrlGFQDqul1
         nP0h2+63Jkr1l2pAI1sz/a5cykOEqxN91J9xh6deJhxDi5Iqg5JKk2c12cTTiE7vtm0p
         +BPreYZ1uP82qsiuIpZXh6zIaovBpIKkqN9p/e9or0Dh1V/4C572FuI/8Tp+aScheiGA
         rjCQ==
X-Gm-Message-State: AOJu0Ywk4E92IIY4s05WNdC2KW2EJRHQqt0xahEL1L92rIW/IcSAIXgL
        TvB3wvSE2huqlEkeb/6yRl6h8w==
X-Google-Smtp-Source: AGHT+IFfnY0Qtk6GHBRhUneTLYcTKP+nhIrRBIebLGnqZtVKgFQlzcOE9y7cZLqekAExlYA05ALD0A==
X-Received: by 2002:a5d:65c4:0:b0:321:4c58:7722 with SMTP id e4-20020a5d65c4000000b003214c587722mr20763432wrw.69.1697124554395;
        Thu, 12 Oct 2023 08:29:14 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id q15-20020a5d574f000000b00323384e04e8sm18610609wrw.111.2023.10.12.08.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 08:29:13 -0700 (PDT)
Message-ID: <a2524f00-eb5f-4771-9734-2a71335c9d37@linaro.org>
Date:   Thu, 12 Oct 2023 17:29:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/6] thermal: core: Pass trip pointer to governor
 throttle callback
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <13365827.uLZWGnKmhe@kreacher> <5877301.MhkbZ0Pkbq@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <5877301.MhkbZ0Pkbq@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2023 19:51, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Modify the governor .throttle() callback definition so that it takes a
> trip pointer instead of a trip index as its second argument, adjust the
> governors accordingly and update the core code invoking .throttle().
> 
> This causes the governors to become independent of the representation
> of the list of trips in the thermal zone structure.
> 
> This change is not expected to alter the general functionality.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

