Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A837C7090
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377620AbjJLOop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344026AbjJLOon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:44:43 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0033D7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 07:44:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3247cefa13aso949169f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 07:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697121879; x=1697726679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o9asKau6xoapZEljIo4ZrEWtiWouf5mZpRdMQ3x02rc=;
        b=HIYB8TAidmb+Hm+mDswrp1bJPsZ45MVDdm4bVNUcsPG6yvnahv8ZnMsUszUbQVzVIW
         x5pFAvVx+/5G3NMYzluFOUSZyp4AyZmv21Bm6vWiBXhaDV/tw9P/ItmUVe3NwjfmWqQm
         HOPvbSHSEn5oUx6TKXHGQuiuw6lf+eB6z0cxI/zq/bUH77bl0/WDs1jiB5fSU2dixScQ
         SAqccj5R0dSgSDEsVSlP57MK3kgyzzZAyY3RZXGjRg7FDHIl9tBgXD0CwxGUjeeMQ351
         VOALxdjLV3zlJsJdlPdWEW/6V5/ggsjpQy1/S/0TXM4RYQOfNBY6EmOZ2lcSoa+Z1aYU
         vGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697121879; x=1697726679;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o9asKau6xoapZEljIo4ZrEWtiWouf5mZpRdMQ3x02rc=;
        b=eZElfTe2w5u0fnGcOhNdsBCba0SgAOOQoBri5cwa4I/bdTL9V1/KkuLbhHlF65t7wf
         nDAMURpmnh32TvSHm4kkTFjd2/XuX8OTScOK/jDp5QRk3A6HiG/oeCXtJvXOFFgsgIiW
         HkD/8Ei38a9NSEJALgdFCm2yFzAtK2JJ5nqk+aatQdsnE7mBFP46TsWL1793M3zUEpQP
         +7eYqXDDyWUM1wc8Iezbxs7vE99InXEVV4pE2xbiQvFh0h39vRUpnTI5F6etyEAwRKgl
         EGPqHvlnq+DMKIdlum9FpRTqrLnA2Q4oOFEgyDexl2Xfn0mJkzmEFbN0nkFhE3j5Hh03
         eVNg==
X-Gm-Message-State: AOJu0YyY6XAOj2F4HqZvkXup10fOIfZwWLyHbyLqhV1aAnNoy0Q+J+u8
        ovD4AO52OUtBB11FCuL/MjHaPQ==
X-Google-Smtp-Source: AGHT+IEuh559MBDM+zPObkepajl9Y2JP//zUG//qYA51FA6rW1A8nGOy/d5Y7eRMLMZVApBr2veYgw==
X-Received: by 2002:adf:f34a:0:b0:319:7428:9ca0 with SMTP id e10-20020adff34a000000b0031974289ca0mr19781987wrp.61.1697121879058;
        Thu, 12 Oct 2023 07:44:39 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id v11-20020a5d6b0b000000b00324853fc8adsm18465025wrw.104.2023.10.12.07.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 07:44:38 -0700 (PDT)
Message-ID: <54a6a7e4-3720-403d-823b-7f0efe0b4567@linaro.org>
Date:   Thu, 12 Oct 2023 16:44:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/6] thermal: trip: Define for_each_trip() macro
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <13365827.uLZWGnKmhe@kreacher> <8282829.T7Z3S40VBb@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <8282829.T7Z3S40VBb@kreacher>
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

On 06/10/2023 19:41, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Define a new macro for_each_trip() to be used by the thermal core code
> and thermal governors for walking trips in a given thermal zone.
> 
> Modify for_each_thermal_trip() to use this macro instead of an open-
> coded loop over trips.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

