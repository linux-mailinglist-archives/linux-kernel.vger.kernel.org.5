Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCA0791ADC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjIDPtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241907AbjIDPtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:49:08 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32401F4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 08:49:05 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso2474239e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 08:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693842543; x=1694447343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Mr4a2ALFhDpVZdNIQ8Ux/W/wDhbSFit8lx1g0WE8sQ=;
        b=UomsvTfjstLdo/gi2Lj7h8SdYLrsnsBPIl9lWBVIdiuzPAbq7CWqR8/QyyJOJZ7My4
         cpjgFOUDnVj69O/7o7iEtFQml2oCZzPcpNuD7HzbXi/3gSJXeh0Z7DPMvneHRHFAsg3l
         A6eJ6/jXC+eG/p1SQyJPG4v5I5xQJGHK+xyqVuyPDq0iU8tJz1XYlsVmri/8NqHTVFw5
         5DCCCctYRQAkyxcmanxA7qgWG0aXNVoeufj0hpqQ+PMTX/YKtg8agQdcT6kJb/oA4TF/
         jKYRBc4eVAHzavI4B1TD3OAVNls+0u8R8vCLAiOmte/Y7IfJEJTUscoz43zN8mn7QyKn
         sQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693842543; x=1694447343;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Mr4a2ALFhDpVZdNIQ8Ux/W/wDhbSFit8lx1g0WE8sQ=;
        b=kWsf+8E/pwN6m5kkcRRRX7lWsqKv/h6m6cM5X95P2fbI3kZ71dXMFYiMwnyTZTpaoT
         LSMPTEwt9vajV3DFM8eevLf4m59TQLx3QtS7tsV49msLnFbm4CGvqyz5nEY2nCTq7Ggy
         igSQwbuIBGTqShhCgI3oFfY3FgA0cMi5zPJllr5sKTjjCSk8TRSh6HduqHWaH5Zi7Cgm
         M55sObxxfF+zjxz5wUzlJvz07Y36sRN8bm4c4NBVVNorQInTxswCBq6nKLaXZvAc73x3
         dMSd7Trz08Zv1MmQegOrPmWr0G6X6BZo8C8PE3y6DOXhlwYPzp9sA1prYAftNjCsItoE
         S/HQ==
X-Gm-Message-State: AOJu0YwXmSxd+cmD7EAA4lWgH5X/HwlF9Nu/F88ITQAjyWwTlAtZMaG1
        vsXZ/KQTFOu0IRLtV8r3ORBmwQ==
X-Google-Smtp-Source: AGHT+IE4v4l6ymY3DjZh2dEcApIj4aqYKl5Mc+y05e23cKNGlbJ9nuy4qF058Dp4ZWgy6wbza5M/ZA==
X-Received: by 2002:a05:6512:3446:b0:500:12c6:c91b with SMTP id j6-20020a056512344600b0050012c6c91bmr6396413lfr.40.1693842543157;
        Mon, 04 Sep 2023 08:49:03 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id u11-20020ac2518b000000b005009920b6afsm1791519lfi.9.2023.09.04.08.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 08:49:02 -0700 (PDT)
Message-ID: <11765348-1d5c-41aa-babc-7c6da68cd9f1@linaro.org>
Date:   Mon, 4 Sep 2023 18:49:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 00/12] drm,usb/typec: uABI for USB-C DisplayPort
 connectors
Content-Language: en-GB
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Janne Grunau <j@jannau.net>, Simon Ser <contact@emersion.fr>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org
References: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org>
 <tsvdc6jm7rtnqjcygn7lhzspheomqbwjejoastr7kcfs22btdr@gy2s57cuwsxy>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <tsvdc6jm7rtnqjcygn7lhzspheomqbwjejoastr7kcfs22btdr@gy2s57cuwsxy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2023 18:46, Bjorn Andersson wrote:
> On Mon, Sep 04, 2023 at 12:41:38AM +0300, Dmitry Baryshkov wrote:
>> During the discussion regarding DisplayPort wrapped in the USB-C
>> connectors (via the USB-C altmode) it was pointed out that currently
>> there is no good way to let userspace know if the DRM connector in
>> question is the 'native' DP connector or if it is the USB-C connector.
>>
>> An attempt to use DRM_MODE_CONNECTOR_USB for such connectors was
>> declined, as existing DP drivers (i915, AMD) use
>> DRM_MODE_CONNECTOR_DisplayPort. New drivers should behave in the same
>> way.
>>
> 
> Sorry, didn't see the commit message before posting my complaint about
> USB -> DisplayPort.
> 
>> An attempt to use subconnector property was also declined. It is defined
>> to the type of the DP dongle connector rather than the host connector.
>>
>> This attempt targets reusing the connector's PATH property. Currently
>> this property is only used for the DP MST connectors. This patchset
>> reuses it to point out to the corresponding registered typec port
>> device.
>>
> 
> Still interested in understanding how the path string should look like.

As wrote in the other letter, on RB5 it is 'typec:port0'. If the machine 
has two Type-C ports and two connected DP blocks, one of them will have 
'typec:port0', another one 'typec:port1'. This way one can further look 
under /sys/class/typec/portN/physical_localtion/ and find corresponding 
location, etc.

> Is the path expected to be consumed by machine, or is it only there for
> human convenience?

As with DP MST it is expected that userspace will consume this 
information, possibly renaming the connector. For example, on my laptop 
I have DP-1, ... DP-5 connectors (with DP-2 -- DP-5 being DP MST ones). 
Xorg renames them to DP-1, DP-2, DP-1-1, DP-1-2, DP-1-3, because the MST 
ones are branches for the DP-1.

-- 
With best wishes
Dmitry

