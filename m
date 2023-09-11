Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8AD79C2D6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238426AbjILC3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237447AbjILC3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:29:05 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D4D527D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:53:01 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5029ace4a28so4737028e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694483580; x=1695088380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EzaancVSFfUidUOe21cHWlakGP7DZJNGuUTO/mcEdwE=;
        b=lDoUcnGNFEA+UpueNEH16iXK/vmjShg2NaPl/gteHVqddiMYEvKFV5NxUjSrzWADq2
         q1ho57XaA2HeFQa/lN/XuCiUnTOdMO8meJeTynN2Pw4lPIccoKp4f1HTq0QD0wy0oRAT
         OltL9gSjABfrVc9cUbrypK7Wugg5xyJ/aouvWtVyzuEqeXG8zdwA0oczEloQtCBXOIAG
         KeKjvInQ1yofzm/lSn4Gvn99unp/9dYVsk20+uS6vD0OiyuvJyHRmQ8qfxhEBta6BCDJ
         h53ET4cLqWAPP0OGgyGo+aRrNXSVf2R4A3Q82eRj/SMhXqibCevdlT0XOtKcTdtaib+g
         okDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694483580; x=1695088380;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EzaancVSFfUidUOe21cHWlakGP7DZJNGuUTO/mcEdwE=;
        b=glTEm9Y09Aq3N9SdGD93u/+CSX/xBHyLGAjjUtaAn9X2Kp9I3TMvQRoqhXnjf1luNi
         Hs0u3U+5U2UQzHFLiKChHUUY6FDo940aysbqSuJl+Vv+HQ/kTQSpdHxpzltVpTDCWEUZ
         UwAW5M4PCjkSGHtSJtymDczunsN0tl3wtKxKxWHEpU8NKkVpfISsl7zWG7w3M2+4ZVJT
         aKJEdJLGsGMZIc9e0DegT+XsdLN/R4z626HITUz+jpXzMJbZVhCO8h4qVx1w8Sy7LAVR
         uvESmqSKygdct1d7lClOlJzFxua9M0hNJxJ7/Bb/+FlgQ7WUwBi/W3rDsabG3F8p9LP8
         PohQ==
X-Gm-Message-State: AOJu0YzakIFJO4C9Sfg7Tgjdm5js/KYiLSMQs0mTQpO4yEZbbCYmT1nb
        ttTQ7HRAT5sSU9/W8llcAZsf78U1cPJJ9DVTlxM=
X-Google-Smtp-Source: AGHT+IETWWawdiEO2xkwIL7nt23BxWlpmnqPOF3sikig+xaeKeM9I+kDLN/rZ03iVnX9tQbikD28Ig==
X-Received: by 2002:a05:6512:3d0d:b0:502:a964:84b1 with SMTP id d13-20020a0565123d0d00b00502a96484b1mr302575lfv.25.1694466911540;
        Mon, 11 Sep 2023 14:15:11 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id 23-20020ac24837000000b005008286c06bsm1483944lft.91.2023.09.11.14.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 14:15:11 -0700 (PDT)
Message-ID: <6b6bacee-f7b6-4cfe-be3d-24bda44bfbcf@linaro.org>
Date:   Tue, 12 Sep 2023 00:15:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 01/12] Revert "drm/sysfs: Link DRM connectors to
 corresponding Type-C connectors"
Content-Language: en-GB
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
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
        Janne Grunau <j@jannau.net>, Simon Ser <contact@emersion.fr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org, Won Chung <wonchung@google.com>
References: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org>
 <20230903214150.2877023-2-dmitry.baryshkov@linaro.org>
 <ZPbrtAlO2Y+bjDhf@kuha.fi.intel.com>
 <CAA8EJpqUg2-k7LLBL38RHU1sThkXB54ca68xEMd1yMnHQcQ++w@mail.gmail.com>
 <ZPh0Ps9UJ3HLzdeR@kuha.fi.intel.com>
 <CAA8EJpratbBybgk8woD3maA=J_HuQis44Unq0n+c_UvaFs__AA@mail.gmail.com>
 <ZPiAwOf00RREiYPr@kuha.fi.intel.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <ZPiAwOf00RREiYPr@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2023 16:38, Heikki Krogerus wrote:
> On Wed, Sep 06, 2023 at 03:48:35PM +0300, Dmitry Baryshkov wrote:
>> On Wed, 6 Sept 2023 at 15:44, Heikki Krogerus
>> <heikki.krogerus@linux.intel.com> wrote:
>>>
>>> On Tue, Sep 05, 2023 at 01:56:59PM +0300, Dmitry Baryshkov wrote:
>>>> Hi Heikki,
>>>>
>>>> On Tue, 5 Sept 2023 at 11:50, Heikki Krogerus
>>>> <heikki.krogerus@linux.intel.com> wrote:
>>>>>
>>>>> Hi Dmitry,
>>>>>
>>>>> On Mon, Sep 04, 2023 at 12:41:39AM +0300, Dmitry Baryshkov wrote:
>>>>>> The kdev->fwnode pointer is never set in drm_sysfs_connector_add(), so
>>>>>> dev_fwnode() checks never succeed, making the respective commit NOP.
>>>>>
>>>>> That's not true. The dev->fwnode is assigned when the device is
>>>>> created on ACPI platforms automatically. If the drm_connector fwnode
>>>>> member is assigned before the device is registered, then that fwnode
>>>>> is assigned also to the device - see drm_connector_acpi_find_companion().
>>>>>
>>>>> But please note that even if drm_connector does not have anything in
>>>>> its fwnode member, the device may still be assigned fwnode, just based
>>>>> on some other logic (maybe in drivers/acpi/acpi_video.c?).
>>>>>
>>>>>> And if drm_sysfs_connector_add() is modified to set kdev->fwnode, it
>>>>>> breaks drivers already using components (as it was pointed at [1]),
>>>>>> resulting in a deadlock. Lockdep trace is provided below.
>>>>>>
>>>>>> Granted these two issues, it seems impractical to fix this commit in any
>>>>>> sane way. Revert it instead.
>>>>>
>>>>> I think there is already user space stuff that relies on these links,
>>>>> so I'm not sure you can just remove them like that. If the component
>>>>> framework is not the correct tool here, then I think you need to
>>>>> suggest some other way of creating them.
>>>>
>>>> The issue (that was pointed out during review) is that having a
>>>> component code in the framework code can lead to lockups. With the
>>>> patch #2 in place (which is the only logical way to set kdev->fwnode
>>>> for non-ACPI systems) probing of drivers which use components and set
>>>> drm_connector::fwnode breaks immediately.
>>>>
>>>> Can we move the component part to the respective drivers? With the
>>>> patch 2 in place, connector->fwnode will be copied to the created
>>>> kdev's fwnode pointer.
>>>>
>>>> Another option might be to make this drm_sysfs component registration optional.
>>>
>>> You don't need to use the component framework at all if there is
>>> a better way of determining the connection between the DP and its
>>> Type-C connector (I'm assuming that that's what this series is about).
>>> You just need the symlinks, not the component.
>>
>> The problem is that right now this component registration has become
>> mandatory. And if I set the kdev->fwnode manually (like in the patch
>> 2), the kernel hangs inside the component code.
>> That's why I proposed to move the components to the place where they
>> are really necessary, e.g. i915 and amd drivers.
> 
> So why can't we replace the component with the method you are
> proposing in this series of finding out the Type-C port also with
> i915, AMD, or whatever driver and platform (that's the only thing that
> component is used for)?

The drm/msm driver uses drm_bridge for the pipeline (including the last 
DP entry) and the drm_bridge_connector to create the connector. I think 
that enabling i915 and AMD drivers to use drm_bridge fells out of scope 
for this series.


> Determining the connection between a DP and its Type-C connector is
> starting to get really important, so ideally we have a common solution
> for that.

Yes. This is what we have been discussing with Simon for quite some time 
on #dri-devel.

Unfortunately I think the solution that got merged was pretty much 
hastened in instead of being well-thought. For example, it is also not 
always possible to provide the drm_connector / typec_connector links (as 
you can see from the patch7. Sometimes we can only express that this is 
a Type-C DP connector, but we can not easily point it to the particular 
USB-C port.

So, I'm not sure, how can we proceed here. Currently merged patch breaks 
drm/msm if we even try to use it by setting kdef->fwnode to 
drm_connector->fwnode. The pointed out `drivers/usb/typec/port-mapper.c` 
is an ACPI-only thing, which is not expected to work in a non-ACPI cases.

-- 
With best wishes
Dmitry

