Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD997EF704
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 18:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346154AbjKQRgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 12:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjKQRgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 12:36:13 -0500
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FCC90
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 09:36:07 -0800 (PST)
Message-ID: <954e2f85-7ed8-4768-97c4-970315afeec1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700242565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9vWjfYPNGTMvPQmWqPhQYpJv3Ri6BeWVhxBfWZZgUXg=;
        b=baZIDETogy3HPFLmzPPEvP+7Z7rf3XKfKcDs8ueMQdbzIbxthuwI2sJATP245CyZiV9grr
        3NuEfR/r0nJvTnzPQkPme2O5OUYg/it4JBQlUs/64v8uXtGk5dHZqYyD1pMJ3F/5WCdOC5
        tCnAItfZhFH62ftjaGzE8P9WpdfO+4E=
Date:   Sat, 18 Nov 2023 01:35:56 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 8/8] drm/bridge: it66121: Allow link this driver as a lib
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20231114150130.497915-1-sui.jingfeng@linux.dev>
 <20231114150130.497915-9-sui.jingfeng@linux.dev>
 <CAA8EJprQq3aDhzE+yKGZ2-nsuHWcptzMvApsyOi9D63PgeiZ3w@mail.gmail.com>
 <1b59d647-c345-4260-b07b-22abb70ae17a@linux.dev>
 <CAA8EJppY2+ymX0kLY+cuR=SV1Po2J24r=NQecmb3ZhSE9NHG7Q@mail.gmail.com>
 <7b85d057-3d66-435a-a657-dd69067b6bef@linux.dev>
 <b9eacd91-8d6f-4265-931e-bc31cadd54d4@linux.dev>
 <CAA8EJpo1KhzTpaSqjbOuQvNKw4WGaqrtNBtNfdNLn28eZVgwhw@mail.gmail.com>
 <cf27d25a-3e51-4292-af63-37e5bc585d88@linux.dev>
 <CAA8EJprm6FL9_ZOr5uBXNXLBt=scs=FY2o6ZEv5r576iEM5KRw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <CAA8EJprm6FL9_ZOr5uBXNXLBt=scs=FY2o6ZEv5r576iEM5KRw@mail.gmail.com>
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


On 2023/11/17 17:03, Dmitry Baryshkov wrote:
> On Fri, 17 Nov 2023 at 06:24, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>> Hi,
>>
>> On 2023/11/16 23:23, Dmitry Baryshkov wrote:
>>>>>> Then you will need some way (fwnode?) to
>>>>>> discover the bridge chain. And at the last point you will get into the
>>>>>> device data and/or properties business.
>>>>>>
>>>>> No, leave that chance to a more better programmer and forgive me please,
>>>>> too difficult, I'm afraid of not able to solve. Thanks a lot for the
>>>>> trust!
>>>   From my point of view: no.
>>
>> I respect the fact that the community prefer generic mechanisms.
>> If our approach is not what the community want, can I switch back
>> to my previous solution? I can reduce the duplication of our
>> localized it66121 driver to a minimal, rewrite it until it meets
>> the community's requirement. I know our device looks weird and
>> our approach is not elegant. But at the very least, we could not
>> mess the community's design up by localize. Otherwise, I don't know
>> what is the better approach to solve such a problem.
>>
>> Can I switch back or any other ideas?
> I keep on repeating: create the i2c device from your root device
> driver, which parses BIOS data.


You didn't focus on solve the problem, You are focus on solving me.
How does the method that parsing BIOS data can be generic and applied
universally?


