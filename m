Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C26975CF65
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjGUQcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjGUQcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:32:15 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF144480
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:30:49 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-346392da0d6so10037615ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689956993; x=1690561793;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=f+FyGPDRmoxL2YC1UR+AkzCDS4XQ2NURuK6MfXzpH8g=;
        b=beVRX8xlKEG8j6K58hHhqmUqFmY5Huk4fdeO+Gw5Gil8oPPUr26uxwf/qbE07zB5+x
         yQDJ1Fn2425G8zkazELQKxP3ah6JafEa6URfADOvKo1pp8ted8HUAXlT4klKj9HVJtRa
         5xrn3jGN/fFxmyc1AVcZT3XwWf1Rjx/w26oJ8ZQePhHqhwlP+pdCSkhbWPnm14sQ1bAu
         ENtQmJmYOHoiEHX4hqJ2gs4sd1Imvq/5kH7JLdk/ruj4Ms16omg7xR61/5ntjF6Nz78U
         JQ7IReSiOC12i08UsRvRYdn+2qsXJoB+wRo99g9VGdFSnH1DV+25u6N+1PWunxkjE/BZ
         u6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689956993; x=1690561793;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+FyGPDRmoxL2YC1UR+AkzCDS4XQ2NURuK6MfXzpH8g=;
        b=mI2R5ukEzSKM0vW9Bi4BjPYo88EP9vj6JJdN8F8E8qmUrtpMRLYoESYWtTsFKdpmgM
         ygkpr9YuToaJMH9vgNOlxN+lf0kZgLh+mfDVq0kpYgS0nKyBce/FeCfX8+4gjhhY+Onq
         MdKQr3Wb5lBIujArjqzPyALXQoB6A6R5Ny3/2W2LHqkfevZFI4XXaldOIN9VtrvkP4NE
         JxZXY7iRwiJIDeLh9c43IkKFM5FiH7sHG3gS07W7XdSPJvPyhxUbElfK1XZC69l/JS3p
         s1P+vyj4f5w5/LkEPKF455xivUyDd2SBg+y7CbjVWvrEP3w8GJzODZpo3mZZDgNHjbvW
         jR+g==
X-Gm-Message-State: ABy/qLaOkkw31TPYLSDUXyDgrzqzIWXqrWGkyUngYh5Nt5vlnvejKmLW
        IOdPVHwNl/TzZ6dTzONdXIc=
X-Google-Smtp-Source: APBJJlGllmyzrKIplT3/vybQXfWY6B/wfRZEIIzVqJ+YcglP3MTS9S2ZvWhJOoDT2n9IKFOhqPKnpQ==
X-Received: by 2002:a05:6e02:1a8a:b0:345:d58d:9ade with SMTP id k10-20020a056e021a8a00b00345d58d9ademr490967ilv.3.1689956993074;
        Fri, 21 Jul 2023 09:29:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u7-20020a92da87000000b00345d00dc3fdsm1051573iln.78.2023.07.21.09.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 09:29:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <20b76893-cae3-e17f-99f5-7a0a448799db@roeck-us.net>
Date:   Fri, 21 Jul 2023 09:29:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 2/2] regmap: Reject fast_io regmap configurations with
 RBTREE and MAPLE caches
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 <c9614ffb-7840-6a84-883d-ed4371d75c11@roeck-us.net>
 <205a83df-c67b-457f-a9bf-a9c6def4bb3e@sirena.org.uk>
 <1c90db79-4a1a-d3cb-5250-f30cf6b5a90c@roeck-us.net>
 <e61ebbfd-98d2-4dad-98e7-67d81c0cc04e@kadam.mountain>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <e61ebbfd-98d2-4dad-98e7-67d81c0cc04e@kadam.mountain>
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

On 7/21/23 09:18, Dan Carpenter wrote:
> On Fri, Jul 21, 2023 at 09:01:03AM -0700, Guenter Roeck wrote:
> 
>> Dan, let me know if you don't have time to send a proper patch.
>> I have one based on your suggestion prepared that I could send out
>> if needed.
> 
> I sent it but, aww crud, I forgot to CC you.  Really, get_maintainer.pl
> should add everyone from the tag section to the CC list...
> 
> https://lore.kernel.org/all/58f12a07-5f4b-4a8f-ab84-0a42d1908cb9@moroto.mountain/
> 

No worries.

Thanks,
Guenter

