Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3CF7F6D35
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 08:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjKXHvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 02:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjKXHvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 02:51:06 -0500
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F81BEA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 23:51:10 -0800 (PST)
Message-ID: <bb328e16-7815-4518-832f-456cf1b7e704@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700812268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T2O62iXK8AmrP0PskNgQei4FzPVx4CHcZDXwlVzbnRM=;
        b=AC2QrzpI14p5ua6ydJQzQp9HdxP7VxvCGzc6MKN8T+94GqbeR+Um+eXl3/KJx7sqA8dzeK
        hw6ONRUdV/dNb9+RX/UklP99VPVrj7a2+YSzOH2aX9zGp2lFNVJnLVm1hr+HKrtFWgRruI
        tYhIgsAagsmQc1FLvu7J0qTz3GLeGkY=
Date:   Fri, 24 Nov 2023 15:51:00 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 8/8] drm/bridge: it66121: Allow link this driver as a lib
Content-Language: en-US
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20231114150130.497915-1-sui.jingfeng@linux.dev>
 <20231114150130.497915-9-sui.jingfeng@linux.dev>
 <CAA8EJprQq3aDhzE+yKGZ2-nsuHWcptzMvApsyOi9D63PgeiZ3w@mail.gmail.com>
 <79301d04-c0cb-4740-8a6d-27a889b65daf@linux.dev>
 <CAA8EJpom5kAbDkacOdqp6BR7YPfmCSXaQfDYRVcLf9eGmi64CQ@mail.gmail.com>
 <121163c9-0d56-47ad-a12e-e67390fef2b4@linux.dev>
 <CAA8EJpowjhX=LL-9cnQL4pfCei63zNkCGW5wGOeeFxcnFpNCVA@mail.gmail.com>
 <00ba2245-0e48-4b21-bcd4-29dfb728e408@linux.dev>
 <CAA8EJpoiehS2wS3ri_DggzxeEfLY4yK7X6c+bCFKvkwSce6r+A@mail.gmail.com>
 <10c4ae94-525f-4ac1-9d59-80bb4f7d362e@linux.dev>
 <gghxzhkd3hnry6qloc3axzojps7bv7cf7lmpcweu6ucadhelh6@spjfikjfzt23>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <gghxzhkd3hnry6qloc3axzojps7bv7cf7lmpcweu6ucadhelh6@spjfikjfzt23>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/11/24 15:38, Maxime Ripard wrote:
> On Fri, Nov 24, 2023 at 01:52:26AM +0800, Sui Jingfeng wrote:
>> On 2023/11/23 16:08, Dmitry Baryshkov wrote:
>>>> I'm agree with the idea that drm bridges drivers involved toward to a direction
>>>> that support more complex design, but I think we should also leave a way for the
>>>> most frequent use case. Make it straight-forward as a canonical design.
>>> Not having anything connector-related in the drm_bridge driver is a
>>> canonical design.
>> What you said is just for the more complex uses case. I can't agree, sorry.
>>
>> By choosing the word "canonical design", I means that the most frequently used
>> cases in practice are the canonical design, 95+% motherboards I have seen has
>> only one *onboard* display bridges chip. For my driver, I abstract the internal
>> (inside of the chip) encoder as drm_encoder and abstract the external TX chip as
>> drm_bridge, this design still works very well.
>>
>>
>> Originally, I means that this is a concept of the hardware design.
>> You are wrong even through in the software design context, the
>> transparent simple drm bridge drivers(simple-bridge.c) also *allow*
>> to create drm connector manually. I don't think I need to emulate
>> more example, please read the code by youself.

'emulate' -> 'enumerate'


> Ok. That's it. We've been patient long enough. You have been given a
> review and a list of things to fix for your driver to be merged.


This series is not relevant to my driver, can we please *limit*
the discussion to this series?


>   Whether
> you follow them or not is your decision.


I'm not saying that I will not follow, just to make sure what's solution is you want.
I need discussion to figure out.


> We won't tolerate insulting comments though.


There is *no* insulting, please don't misunderstanding before *sufficient* communication, OK?
Originally, I thought Dmitry may ignore(or overlook) what is the current status.


> Maxime
