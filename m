Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32FD75CCF5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjGUQBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjGUQBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:01:08 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D39B2D71
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:01:06 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-78654448524so90847639f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689955265; x=1690560065;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=di9/aclK3hfLnvrgH4+kVFnRPLx8Dm1glX0mwyVou0k=;
        b=H4fSiEiNraah5eON3dL1Ivzn2aBIx3ZMm2ZEAH8Otr0Ul44TMWy/SqXX1lFH9/etOP
         0d070rgURJhRnTMOBOSKlycUuR2szJc1BtYQqnrvAFETAWCggv95oQ5tk2uGcovLfiZf
         cwiuGmOLTppRTL264kI9eirAO3yYFuSKCg2awLueM933X/QIUJOOvXVT4WvacclVBvc5
         OlTc7+OBStK46YJ8z+olDahGdL5v5Y+szmsIOCk+D93d3cA+bHB/K1rJuoyKGhnt8ps+
         nGnTbyNgjdKhTBcILwUeiCFhZ0ILOKZp4sg9jx7R+K8iyV4114mRjMsI0eNZXADWK4SE
         rMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689955265; x=1690560065;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=di9/aclK3hfLnvrgH4+kVFnRPLx8Dm1glX0mwyVou0k=;
        b=fZnmoTfhjcD8B+CJ2kzR2VMndWEjCOiedROq0FLzivdvZ6znPIbQxHTGga7tZMZQju
         vA7bk53zVWBHBVXljKcuSTWmJeSL9UoDFqU352w6h5qiRpIAG4DRqyKbfgv6EC/t8ooR
         9X67tbTO3Lit9DhlvW5YCM9LyUzvRzGglWIVe7sCIKkSe5LcfYBJoR12oa4hHcbYSGHB
         or6KcWUAWKKGEgR+EvZqn0mdake+Pu124IGvpkO6hTf/+uB9rEtUbKqQA9E8S/bkmXY2
         Abd3ojc9tI+foDeJle3Utw6BLZTCQuQCFGgTYif/6KWmoVYlXuSvHZjvPsS2CwFyvhwU
         1+Wg==
X-Gm-Message-State: ABy/qLaQIGAosCIFCF98f36yoQwDOq0rqrPQQGjcfVGF09d8F6J8q4nO
        n6LIkkWWLePHjLY+IHj2WFY=
X-Google-Smtp-Source: APBJJlEXOurJ9bKqvF8rdK9oK18c1yHFpD4ACr5El7QUBXH+yXeCXUK1ScK8ZEbLNo62MFw2qapHag==
X-Received: by 2002:a6b:916:0:b0:777:8e86:7702 with SMTP id t22-20020a6b0916000000b007778e867702mr349307ioi.16.1689955265490;
        Fri, 21 Jul 2023 09:01:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w2-20020a02cf82000000b0042b48e5da4bsm1059358jar.134.2023.07.21.09.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 09:01:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1c90db79-4a1a-d3cb-5250-f30cf6b5a90c@roeck-us.net>
Date:   Fri, 21 Jul 2023 09:01:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Dan Carpenter <dan.carpenter@linaro.org>
References: <20230720032848.1306349-1-linux@roeck-us.net>
 <20230720032848.1306349-2-linux@roeck-us.net>
 <CGME20230721145342eucas1p12e658a54d36d985b2811e2c21f7810ee@eucas1p1.samsung.com>
 <c2bba4df-da1f-5666-89aa-28c6700575ca@samsung.com>
 <fe31bb86-40ec-4b77-9edd-eeaa61bb5e08@sirena.org.uk>
 <c9614ffb-7840-6a84-883d-ed4371d75c11@roeck-us.net>
 <205a83df-c67b-457f-a9bf-a9c6def4bb3e@sirena.org.uk>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH 2/2] regmap: Reject fast_io regmap configurations with
 RBTREE and MAPLE caches
In-Reply-To: <205a83df-c67b-457f-a9bf-a9c6def4bb3e@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/23 08:13, Mark Brown wrote:
> On Fri, Jul 21, 2023 at 08:07:28AM -0700, Guenter Roeck wrote:
>> On 7/21/23 08:03, Mark Brown wrote:
> 
>>> Actually Guenter and Dan have made the required updates to support this
>>> so the warning will be gone soon (hopefully Dan will send his patch
>>> properly shortly).
> 
>> Do you plan to revert this patch ? If not regmap_init() would still fail
>> for the affected drivers, even after my and Dan's patches have been applied.
> 
> Yeah.  You *can* use the dynamically allocating caches safely if you
> ensure that no new cache nodes are allocated during I/O.  I'd not
> realised people were actually doing this.

Ok.

Dan, let me know if you don't have time to send a proper patch.
I have one based on your suggestion prepared that I could send out
if needed.

Thanks,
Guenter

