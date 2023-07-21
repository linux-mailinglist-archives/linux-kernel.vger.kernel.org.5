Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F57C75CAEE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjGUPHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjGUPHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:07:32 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37385272E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:07:31 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bb119be881so14945175ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689952050; x=1690556850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=U3ydrPiZouE89GGffikcepwvN6uL1WoSKBuPJRtgx+M=;
        b=G7MS5T5GSki2Fb3anydrMEWUshpROHu8KywfFHjGd9Cy6sQBaxpy+PuD/HiVBVsDay
         kuy4wrjDQv2+/l+lYgsW7dvzjicOjd+lWwDaXvqIc4cVGLlCIgiIrmSviVs6TGaTVq/a
         sCcFcFK997BXHU6WN7mn1r1janIIVn0kUTdplvI831mKp4k54iigMxxNXYgnlXIlXp4e
         sovjkEn9Vaf+WMJvILpmtOFmDfpkQIdchZXCGWbg2vXp9ZH7/q1Vdli1c/9P01dwXRED
         b9NCZmtRjkxHtNkyUdFpNtX4FKNlU24oxk+dw1zuX5O/kdb+F0eJobt1WFNjW8bF6VXs
         7rtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689952050; x=1690556850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U3ydrPiZouE89GGffikcepwvN6uL1WoSKBuPJRtgx+M=;
        b=X59hvpBJoxk3XlgBIrGfQ3WXymRJgOq6rt6yOaf8I2wxTczdC6dYw9m630xvshbqRI
         +az+sIZQ2dItlYocDhDlJ4y046NQEdf+yV5SReyGfgnglwvOmOMfqZrdIK61jMQqn8yx
         MktSbFB9MbgiR3QyQTMrcd2IK8UVzX4/0J2EN7VijASSJ8e+gOFnxDYVP4bMmQnH7C2i
         JWUI5zgHW+Ydy9ZPGy9ZvzuOqk5LEsktqZH7vqRcR+9epfFjBsfpv5nV81zlGEiEGOg4
         C3G/iFaEpm4yu4r3/U+JdPXWUiRjAcp/qE+ctlweDXJenD+F7X0QPXga/f4VX5RyyDLs
         OpEA==
X-Gm-Message-State: ABy/qLYW1fHMIZIRt05twCuru/pPjBRuuRicM16YK5msqKncqHzkrHTp
        bie8iQf6U0wnizMbVT5JZj4=
X-Google-Smtp-Source: APBJJlHudh4wzA65C2mvfuLrWs5wS7f3QSeF22ZcYPqbCqnkpAg5l6/x7pjcNudcamopOCVeNZ8Ccg==
X-Received: by 2002:a17:902:d505:b0:1b6:76ee:190b with SMTP id b5-20020a170902d50500b001b676ee190bmr2409039plg.35.1689952050613;
        Fri, 21 Jul 2023 08:07:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c1-20020a170903234100b001b03a1a3151sm3647497plh.70.2023.07.21.08.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 08:07:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c9614ffb-7840-6a84-883d-ed4371d75c11@roeck-us.net>
Date:   Fri, 21 Jul 2023 08:07:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 2/2] regmap: Reject fast_io regmap configurations with
 RBTREE and MAPLE caches
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
References: <20230720032848.1306349-1-linux@roeck-us.net>
 <20230720032848.1306349-2-linux@roeck-us.net>
 <CGME20230721145342eucas1p12e658a54d36d985b2811e2c21f7810ee@eucas1p1.samsung.com>
 <c2bba4df-da1f-5666-89aa-28c6700575ca@samsung.com>
 <fe31bb86-40ec-4b77-9edd-eeaa61bb5e08@sirena.org.uk>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <fe31bb86-40ec-4b77-9edd-eeaa61bb5e08@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/23 08:03, Mark Brown wrote:
> On Fri, Jul 21, 2023 at 04:53:42PM +0200, Marek Szyprowski wrote:
> 
>> This patch, which landed in today's linux-next, breaks operation of the
>> RockChip's VOP2 DRM driver
>> (drivers/gpu/drm/rockchip/rockchip_drm_vop2.c). I'm not sure what is the
>> proper fix in this case. Should one change the cache type to REGCACHE_FLAT?
> 
> Actually Guenter and Dan have made the required updates to support this
> so the warning will be gone soon (hopefully Dan will send his patch
> properly shortly).

Do you plan to revert this patch ? If not regmap_init() would still fail
for the affected drivers, even after my and Dan's patches have been applied.

Thanks,
Guenter

