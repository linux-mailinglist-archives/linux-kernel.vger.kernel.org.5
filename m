Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687177C7871
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 23:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442889AbjJLVQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 17:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442853AbjJLVQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 17:16:00 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0004C9D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:15:56 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-405361bba99so14549665e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697145355; x=1697750155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fM0DXXboWe5a80zsbvWwo3m0mrD8GmZVCasDLYdIcEM=;
        b=P7WQLGDxIpcgOFEAVxE9bJ75x2ynuqHs+SEd9MknG+R39JD8CTEw4DPxA9Kj/P41GF
         EZ2snNZMhdXe70w+aehWMBpsUXO6+SkAsndXHFa+ZYqACWNaW+wXcO6GPNQC6I0w7rTK
         WRR/EWuG3ntYbdOUexfRsZgBX+t3NfVINGsi64WYBlkMrmEVyYVPHutt+7ED7v7MWsGb
         jp4Jgyc+LuhuCjwxznaVCq5NpQY733o6TJVMNO4i8rkcxyM9Kjkpd8/YRIMiRQLxk0fA
         tt8La86xNxOK91yYh+6mYJZx21T582fluM9whGp8l0PXiuSMiEjR/A38vSisNLsn7vWu
         0avg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697145355; x=1697750155;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fM0DXXboWe5a80zsbvWwo3m0mrD8GmZVCasDLYdIcEM=;
        b=gh28xU16iSuYBZu2xWrEu9iiSj6fiKszxpMIoGvl3BcwCR9xoeD9l76kQw+NPw2FU4
         y31Ze7lRauN7OqS+NcYrxufHrT2ufu37j3vRSvluDx3opGcr9EOQb1LI8rE+K1CqA954
         67Nuua9jXFJBUhhWBmyvXF/hBvZpcyB2ERQe5DhLC0k/elzjhanTRSs/yG0ISzPEnD4o
         F1ud7hKRdnzftIJkSrvOu2MABgR/+fqLefV63mmJUpEqadNuL58eBVufJQ0Wj45IS2vz
         P7FvbmJBoadoW+xgv7/o0xFjOm2ArWb36mypMPcHpJUCkc6Wmy9ZykEGOLVAf2bLRjRu
         SHdQ==
X-Gm-Message-State: AOJu0Yz120rkWgFmdD9gg6a5dLCvsp0lakk57LRsEbIIX3AOFSh/IAev
        g8jtNu3MYoyf3kTwP0Eyr+NwLQ==
X-Google-Smtp-Source: AGHT+IGnhYZy39oYwrq//smjlyz4lEvmT2v2EcPW/pw6yueHBg5L2AuBDkhLP/4ph9q70ITFtaBy4Q==
X-Received: by 2002:a1c:7419:0:b0:3fe:89be:cd3 with SMTP id p25-20020a1c7419000000b003fe89be0cd3mr21652442wmc.22.1697145355443;
        Thu, 12 Oct 2023 14:15:55 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id l25-20020a7bc459000000b004054dcbf92asm779383wmi.20.2023.10.12.14.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 14:15:55 -0700 (PDT)
Message-ID: <561802cb-318c-4a83-92e6-5328be1106d4@linaro.org>
Date:   Thu, 12 Oct 2023 23:15:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] thermal: gov_fair_share: Rearrange
 get_trip_level()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <5734364.DvuYhMxLoT@kreacher> <2176566.irdbgypaU6@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2176566.irdbgypaU6@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2023 20:29, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make get_trip_level() use for_each_trip() to iterate over trip points
> and make it call thermal_zone_trip_id() to obtain the integer ID of a
> given trip point so as to avoid relying on the knowledge of struct
> thermal_zone_device internals.
> 
> The general functionality is not expected to be changed.
> 
> This change causes the governor to use trip pointers instead of trip
> indices everywhere except for the fair_share_throttle() second argument
> that will be modified subsequently along with the definition of the
> governor .throttle() callback.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

