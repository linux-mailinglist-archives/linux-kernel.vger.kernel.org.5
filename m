Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E676A79D7C2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbjILRj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236827AbjILRjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:39:53 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E9110D3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:39:49 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-500cfb168c6so9697867e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694540387; x=1695145187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qfWN69mP00ualtZXK+0LNWzFxGf625lUtnnMX/7yIhI=;
        b=M+I/RmgU8xsyVSXy0yh8auVtBOcMVq2c+HuwneqMon6pMuLz1n1pljG5OwcZ+uU5k7
         9mV5QoPbIdVATsPtjQ8zTSEiYaIINuFynjLdQIRhwhmGek8oFQQvq3idT+q8L1zTFBQ6
         IV65+0ir+nI9z+kj7ODAket0TTk8lCMcHudxhX1Gp/3t8TRqWO+I4/TtzC+kFYS+PCFb
         cwCkpp7by+Hk6kwWCxd+PDhHsWlvR8eIvkmGx8yiiCiDF0RrAX9oxdqGTRiiNdUIJwQq
         bRGhhfLDuKnQ46wDz75hFV73/Laqi3aL6X9AKbyGW4j6QXGMsMDhlleYMXshJP4ZcfH4
         ZviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694540387; x=1695145187;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qfWN69mP00ualtZXK+0LNWzFxGf625lUtnnMX/7yIhI=;
        b=TTpK/xoetJxAZjV5H9Y/+7c4qoCDaE31JM07qwfx1xU2E6KE+KGBc0M2I7COb9nHXV
         KNiUd6LU3IUf46pQ9C2+fqaITKVH6mqb4+Zi3fOTgOW0FDig6OBdmhRUoI8dCbaUoNm2
         xxkJpI6O52LJklTd6s7BQ+C9LzQlULINxZPpbOtVL9gLLsSk6Siqan1opnKoxOchFpXu
         uDx4h+DAQ8baHOhlSTFAphas5d42ghlu5i3hWyvxYpU/oXPLqiMmxCYunq6S5LazFflb
         KIvcAKvzilqjzHCYd3GdZoJ6dj457BTLCEynTCTlNDi2x47J8ZSh6V6DUCiWl00UNvVB
         ejbQ==
X-Gm-Message-State: AOJu0Yy50AQqMNiC44te2JnYpp3oOvwhv3SZFAAHHyawjpaUR0nEXhEH
        To+ZtP3ZWuo/wsnn+0IWQRd7Iw==
X-Google-Smtp-Source: AGHT+IEQaseG2rf4Y8KarQ54blJ2LOjJc85S2m6s1jkQf4/FdTFjuHmSSpQAwZkzERZ3HZ5LfTcEjw==
X-Received: by 2002:a05:6512:3698:b0:501:bf30:714c with SMTP id d24-20020a056512369800b00501bf30714cmr163908lfs.24.1694540387403;
        Tue, 12 Sep 2023 10:39:47 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id u6-20020ac24c26000000b005008757cd6csm1828256lfq.241.2023.09.12.10.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 10:39:46 -0700 (PDT)
Message-ID: <a97a33f4-71f3-4610-a59e-0c2d5ae86670@linaro.org>
Date:   Tue, 12 Sep 2023 20:39:45 +0300
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
 <6b6bacee-f7b6-4cfe-be3d-24bda44bfbcf@linaro.org>
 <ZQBGD8CY5OVKYX63@kuha.fi.intel.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <ZQBGD8CY5OVKYX63@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2023 14:05, Heikki Krogerus wrote:
> On Tue, Sep 12, 2023 at 12:15:10AM +0300, Dmitry Baryshkov wrote:
>> On 06/09/2023 16:38, Heikki Krogerus wrote:
>>> On Wed, Sep 06, 2023 at 03:48:35PM +0300, Dmitry Baryshkov wrote:
>>>> On Wed, 6 Sept 2023 at 15:44, Heikki Krogerus
>>>> <heikki.krogerus@linux.intel.com> wrote:
>>>>>
>>>>> On Tue, Sep 05, 2023 at 01:56:59PM +0300, Dmitry Baryshkov wrote:
>>>>>> Hi Heikki,
>>>>>>
>>>>>> On Tue, 5 Sept 2023 at 11:50, Heikki Krogerus
>>>>>> <heikki.krogerus@linux.intel.com> wrote:
>>>>>>>
>>>>>>> Hi Dmitry,
>>>>>>>
>>>>>>> On Mon, Sep 04, 2023 at 12:41:39AM +0300, Dmitry Baryshkov wrote:
>>>>>>>> The kdev->fwnode pointer is never set in drm_sysfs_connector_add(), so
>>>>>>>> dev_fwnode() checks never succeed, making the respective commit NOP.
>>>>>>>
>>>>>>> That's not true. The dev->fwnode is assigned when the device is
>>>>>>> created on ACPI platforms automatically. If the drm_connector fwnode
>>>>>>> member is assigned before the device is registered, then that fwnode
>>>>>>> is assigned also to the device - see drm_connector_acpi_find_companion().
>>>>>>>
>>>>>>> But please note that even if drm_connector does not have anything in
>>>>>>> its fwnode member, the device may still be assigned fwnode, just based
>>>>>>> on some other logic (maybe in drivers/acpi/acpi_video.c?).
>>>>>>>
>>>>>>>> And if drm_sysfs_connector_add() is modified to set kdev->fwnode, it
>>>>>>>> breaks drivers already using components (as it was pointed at [1]),
>>>>>>>> resulting in a deadlock. Lockdep trace is provided below.
>>>>>>>>
>>>>>>>> Granted these two issues, it seems impractical to fix this commit in any
>>>>>>>> sane way. Revert it instead.
>>>>>>>
>>>>>>> I think there is already user space stuff that relies on these links,
>>>>>>> so I'm not sure you can just remove them like that. If the component
>>>>>>> framework is not the correct tool here, then I think you need to
>>>>>>> suggest some other way of creating them.
>>>>>>
>>>>>> The issue (that was pointed out during review) is that having a
>>>>>> component code in the framework code can lead to lockups. With the
>>>>>> patch #2 in place (which is the only logical way to set kdev->fwnode
>>>>>> for non-ACPI systems) probing of drivers which use components and set
>>>>>> drm_connector::fwnode breaks immediately.
>>>>>>
>>>>>> Can we move the component part to the respective drivers? With the
>>>>>> patch 2 in place, connector->fwnode will be copied to the created
>>>>>> kdev's fwnode pointer.
>>>>>>
>>>>>> Another option might be to make this drm_sysfs component registration optional.
>>>>>
>>>>> You don't need to use the component framework at all if there is
>>>>> a better way of determining the connection between the DP and its
>>>>> Type-C connector (I'm assuming that that's what this series is about).
>>>>> You just need the symlinks, not the component.
>>>>
>>>> The problem is that right now this component registration has become
>>>> mandatory. And if I set the kdev->fwnode manually (like in the patch
>>>> 2), the kernel hangs inside the component code.
>>>> That's why I proposed to move the components to the place where they
>>>> are really necessary, e.g. i915 and amd drivers.
>>>
>>> So why can't we replace the component with the method you are
>>> proposing in this series of finding out the Type-C port also with
>>> i915, AMD, or whatever driver and platform (that's the only thing that
>>> component is used for)?
>>
>> The drm/msm driver uses drm_bridge for the pipeline (including the last DP
>> entry) and the drm_bridge_connector to create the connector. I think that
>> enabling i915 and AMD drivers to use drm_bridge fells out of scope for this
>> series.
>>
>>
>>> Determining the connection between a DP and its Type-C connector is
>>> starting to get really important, so ideally we have a common solution
>>> for that.
>>
>> Yes. This is what we have been discussing with Simon for quite some time on
>> #dri-devel.
>>
>> Unfortunately I think the solution that got merged was pretty much hastened
>> in instead of being well-thought. For example, it is also not always
>> possible to provide the drm_connector / typec_connector links (as you can
>> see from the patch7. Sometimes we can only express that this is a Type-C DP
>> connector, but we can not easily point it to the particular USB-C port.
>>
>> So, I'm not sure, how can we proceed here. Currently merged patch breaks
>> drm/msm if we even try to use it by setting kdef->fwnode to
>> drm_connector->fwnode. The pointed out `drivers/usb/typec/port-mapper.c` is
>> an ACPI-only thing, which is not expected to work in a non-ACPI cases.
> 
> You really have to always supply not only the Type-C ports and partners,
> but also the alt modes. You need them, firstly to keep things sane
> inside kernel, but more importantly, so they are always exposed to the
> user space, AND, always the same way. We have ABIs for all this stuff,
> including the DP alt mode. Use them. No shortcuts.
> 
> So here's what you need to do. UCSI does not seem to bring you
> anything useful, so just disable it for now. You don't need it. Your
> port driver is clearly drivers/soc/qcom/pmic_glink_altmode.c, so
> that's where you need to register all these components - the ports,
> partners and alt modes. You have all the needed information there.

To make things even more complicate, UCSI is necessary for the USB part 
of the story. It handles vbus and direction.

> Only after you've done that we can start to look at how should the
> connection between the DPs and their USB Type-C connectors be handled.

But sure enough, I can add typec port registration to the altmode 
driver. This will solve the 'port not existing' part of the story.

I'd like to hear your opinion on:

- components. Using them breaks drm/msm. How can we proceed?

- PATH property usage. This way we make USB-C DisplayPort behave like 
the MST ports.

-- 
With best wishes
Dmitry

