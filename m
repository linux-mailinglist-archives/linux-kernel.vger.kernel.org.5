Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAB676FC10
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbjHDIbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbjHDIao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:30:44 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EE9FC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:30:42 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe1d9a8ec6so17706915e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691137840; x=1691742640;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QYrStqEM0cThZwoI/cPXMGOMxkPAFk/7V/s5s/EM5cA=;
        b=KjQAdFIEn7Ro3hrZPKzuvP5ENbD/1v+6fbdMUiYhWbsIWi7LI7xi5v5pdv+rryRX/F
         f+Svl9p8OzyUgCcv4r1/a2vlHsg0qfsT6pVTwBbP5ohmeYfI8MrOJTrIQFAXVPuYIMVr
         29f9fdFn50dUDq9JoFczTMyMb0ow4uCrQ/8STAU/nVxdslsmK3TjrRyVLt/iTzNh+Ns+
         7GNYP4PusvqjkXCaEk7MpBSTIjsgUWUL8GjsIfN+cemFzhIiqSLzZzrehiZMm477iEez
         CjuxiYuMTFjRkGBg/ALnsFVSfQEX3ZzIsSzsnRYfz2ctJvGNcedtln8HIgURbS0aXN9H
         nJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691137840; x=1691742640;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QYrStqEM0cThZwoI/cPXMGOMxkPAFk/7V/s5s/EM5cA=;
        b=XIreLyZtlej3GKKsYSXzPndfwo7cvLKeDynvWuDljoubjCcMbwNDR6SujqwzPNoOUY
         sqBseKS97L2q/j772rpUt79rHDSk554kYNQdCn++7ECCD5rhtaPvvoHN2H35nK8FCwjm
         ghb9+TU0HKCVq8w4DFI4fG6vhoaj55w8gBPrqOWVX/1ksu9Srb7HhYWFEIMhfgbIu+FP
         knBCRUND5AhXjeVSMbRSNgnIxAs+P1zcURsOmRRT4t6caL8zWisfLUTaHrimPwpKKALg
         kDwfcFkZrQAAJ9f6c2VozMAgl7qcO4bAs/O5E4WullJqWBoSW1bkv/NE8tFKsjZgzv1u
         L8zQ==
X-Gm-Message-State: AOJu0YyouqBCqcDA/hAbD/40tBp9znSlTE6bcwf0Cs6ujYQTG8YSZ6xW
        xripMZG3GhHzpksAikbUlYzU5Q==
X-Google-Smtp-Source: AGHT+IGmsm/JtL8yLdEbpyXwX4F3kWfcIGHPa2uTtbJSiv32jPeo95BTCrjkn3fXjABnyLsbFZgumA==
X-Received: by 2002:adf:f008:0:b0:314:1228:c4c1 with SMTP id j8-20020adff008000000b003141228c4c1mr1242706wro.23.1691137840638;
        Fri, 04 Aug 2023 01:30:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b526:9083:f5a6:4af1? ([2a01:e0a:982:cbb0:b526:9083:f5a6:4af1])
        by smtp.gmail.com with ESMTPSA id s18-20020adfeb12000000b0031779a6b451sm1894770wrn.83.2023.08.04.01.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 01:30:40 -0700 (PDT)
Message-ID: <cc854764-805c-a46a-0210-edf7dafde0d1@linaro.org>
Date:   Fri, 4 Aug 2023 10:30:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] Revert "drm/bridge: lt9611: Do not generate HFP/HBP/HSA
 and EOT packet"
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Jagan Teki <jagan@amarulasolutions.com>
References: <20230802-revert-do-not-generate-hfp-hbp-hsa-eot-packet-v1-1-f8a20084e15a@linaro.org>
 <5cf0e3fa-f66d-06c4-cfda-c48efd8c6508@linaro.org>
 <bf95af44-2510-1835-dec9-183144de8413@denx.de>
 <CAA8EJppp_ZJr-DcoZGd1GZmWuo=AECNS+X9zx0dNB4Edn8M2zg@mail.gmail.com>
 <CAF6AEGsfbUMCS4QTfqoyYetqea_ov-AET-iM54B-HvYpwwZvmg@mail.gmail.com>
 <25f3026f-3d97-a5ac-862a-da6dc5f8d830@denx.de>
Organization: Linaro Developer Services
In-Reply-To: <25f3026f-3d97-a5ac-862a-da6dc5f8d830@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On 03/08/2023 20:10, Marek Vasut wrote:
> On 8/2/23 20:49, Rob Clark wrote:
>> On Wed, Aug 2, 2023 at 11:16 AM Dmitry Baryshkov
>> <dmitry.baryshkov@linaro.org> wrote:
>>>

<snip>

>>>
>>> Can we please end the argument, land the fix (this revert) for 6.5 and
>>> work on the solution for 6.6 or 6.7?
>>>
>>
>> Even if they were in-tree, breaking existing hw means revert and
>> try-again.  Especially as we get into later -rc's
> 
> Then just apply the revert, I don't have time to debug this right this moment, and it is anyway meaningless until I can look at the bus with DSI bus analyzer.

I'm applying it, then I'll like to find an explanation when you'll be able to run the DSI bus analyzer.

I'll be able to test for regressions on the db845c board if you require, just ping me on irc.

We should clearly define those flags actions and probably add new flags to reflect the way the qcom
dsi controller acts.

Thanks,
Neil
