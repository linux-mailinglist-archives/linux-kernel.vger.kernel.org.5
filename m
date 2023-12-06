Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3A5807A4E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379650AbjLFVZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjLFVZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:25:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C40CF7;
        Wed,  6 Dec 2023 13:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=3j90ZFbMF32YiYwLgeelVPftRxouXRUNKvFk7M5BhLM=; b=OElDPuUj0WoPSBTrYyBEQZNUdV
        BKlCdrNoMn+A7LAzguP4PBqyQhSrYYhBP9qGZYgDZgsAHmneZpWqFHzuXBqQnqtTSLunseEL34TsN
        R7nsFasCYWQKzGoEdn+aOxrALz4rj/9uyItZelAzmXVjTagnuIWChlylvJ5g4MK6jN60KYuwU0d4D
        oalJQSu+6L/rf2UC4sblvoLt4c1ygpnZFtZkjWbr73OFoDI8tP7NtPv3cJcVEKYoa8QndEuaA/lkE
        H/d/Ew7jPqagBjA2jjIuJUPshEc9wM/QhjLip5POPp0cVi9g8qivxtnB20VFvar2gdfi37T7YlNUZ
        YcZjPD0g==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAzOz-00BJSw-31;
        Wed, 06 Dec 2023 21:25:53 +0000
Message-ID: <b2ba3809-81b1-4da7-a441-9ce161a06505@infradead.org>
Date:   Wed, 6 Dec 2023 13:25:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: qcom-pmic: add CONFIG_OF dependency
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>
References: <20231206172037.12072-1-rdunlap@infradead.org>
 <d0323841-a3a7-45b7-b702-0a08f9250c55@roeck-us.net>
 <0c1bb5e8-1ad2-4bda-b038-456d9791f9b7@infradead.org>
 <a058827a-b025-4ee5-b2a4-d6c8963a6b73@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <a058827a-b025-4ee5-b2a4-d6c8963a6b73@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/23 13:21, Bryan O'Donoghue wrote:
> On 06/12/2023 20:46, Randy Dunlap wrote:
>>
>>
>> On 12/6/23 10:49, Guenter Roeck wrote:
>>> On Wed, Dec 06, 2023 at 09:20:37AM -0800, Randy Dunlap wrote:
>>>> DRM_AUX_BRIDGE depends on CONFIG_OF, so that is also needed here
>>>> to fix a kconfig warning:
>>>>
>>>> WARNING: unmet direct dependencies detected for DRM_AUX_HPD_BRIDGE
>>>>    Depends on [n]: HAS_IOMEM [=y] && DRM_BRIDGE [=y] && OF [=n]
>>>>    Selected by [y]:
>>>>    - TYPEC_QCOM_PMIC [=y] && USB_SUPPORT [=y] && TYPEC [=y] && TYPEC_TCPM [=y] && (ARCH_QCOM || COMPILE_TEST [=y]) && (DRM [=y] || DRM [=y]=n) && DRM_BRIDGE [=y]
>>>>
>>>
>>> All but impossible for me to determine if this patch or
>>> https://lore.kernel.org/all/20231205-drm_aux_bridge-fixes-v1-2-d242a0ae9df4@kernel.org/
>>> is more appropriate.
>>>
>>> Guenter
>>
>> I guess that Bryan is the person to ask about that.
>>
>> I don't see anything wrong with Nathan's patch. It should clear up the kconfig warning,
>> so as long as it builds cleanly, it seems OK.
>>
> 
> So, I see both versions of this fix
> 
> Nathan's
> drivers/gpu/drm/renesas/rcar-du/Kconfig

No, please see https://lore.kernel.org/all/20231205-drm_aux_bridge-fixes-v1-2-d242a0ae9df4@kernel.org/

> 
> Yours
> drivers/gpu/drm/tve200/Kconfig

No, please see https://lore.kernel.org/linux-usb/a058827a-b025-4ee5-b2a4-d6c8963a6b73@linaro.org/T/#m034fb56a750522f18813642259b18bb4867ceb46

> 
> and virtually equivalent commit text. I think we agree its 1:1
> 
> So, maybe stick with Nathan's since he posted first.

Sure, I'm OK with that.

-- 
~Randy
