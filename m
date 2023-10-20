Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1CE7D0F21
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377225AbjJTLuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377147AbjJTLuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:50:50 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4493C98;
        Fri, 20 Oct 2023 04:50:45 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9b96c3b4be4so110211266b.1;
        Fri, 20 Oct 2023 04:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697802644; x=1698407444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1BXpFmZotobe2WYOp6dHHJadZsngmwLQdTQTaRJwTnA=;
        b=lORszuXInBVjKXkSeimvp8kScDVhD/ILxZPWILk5pcDCFU1qRtJyPZuMMNvoNxRMjx
         4eRQne4tPbH7QFqUQCyEhbsbPq/uegqeTgIWc45vrVPtlg0ORIkchWfVlMXZX0frFwDw
         NyIL5caHlVtprgOt/yyQiArvJ0AZKtNw4ONBM/mi5knM6nuyW0iqQjQZCd3pty9+LiEu
         VbC57N4Z4s03ycZrIyA/PZgwFWGBsVjqdtv0Dqj0jMeC3lIjd9UaipDwOeCVfO2S2OdS
         cLT/zvJTJuWP7uaGSx5GNRVMcQdN3AknELzHCJ0Tu5hfRvid+qi5mbxqz7aMZL5ZkMGY
         5VPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697802644; x=1698407444;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1BXpFmZotobe2WYOp6dHHJadZsngmwLQdTQTaRJwTnA=;
        b=GiQM5w6uFjmuVWfOkIvEntGuBfYuYg4KyU3SA7NpLLui7c5Apx8mEILYYo7DXwKpOf
         a0Iy2iy6Xg7DlJeaDsuH1ticB6m6E8DFapEp2e/AnUio6ZByyi869vB+O2lASbpHXsrZ
         cmO+1orsah7xkGlFHzjGYpOtvzYxb2sT4MQpDAfOBCmGAisDYRU8FqiW/kJNfWgdvFF2
         O1TJHMAPgsf9MVlyjth2OVeXUJkyi7O/NSc/s5ezwHhBJVBhsrcGB3O54oihxNDIr0DU
         7iLeScWTyaqhrZk5YuvZqcdCSCX7ClXPcftwQNyNQNziTsw6nUnrNWJbYcnRsNixmtT0
         9XEg==
X-Gm-Message-State: AOJu0YyYFbVHyZnMxkz7ysy3amORUET7pv12yHk4G61TdznWtw0hT93m
        lP+XRlsxcrDEs7wSu4KxkO8=
X-Google-Smtp-Source: AGHT+IH4SSfPUyyXEXRxntxeV4/0PAyE5eC0Y6HI3UL6kr/sseuOAfWQ9oPrlZX/ARDGNS/RvHZmuw==
X-Received: by 2002:a17:907:d8d:b0:9b2:df16:851d with SMTP id go13-20020a1709070d8d00b009b2df16851dmr1233141ejc.57.1697802643458;
        Fri, 20 Oct 2023 04:50:43 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:974d:4d18:38cf:ab0f? (2a02-a466-68ed-1-974d-4d18-38cf-ab0f.fixed6.kpn.net. [2a02:a466:68ed:1:974d:4d18:38cf:ab0f])
        by smtp.gmail.com with ESMTPSA id i6-20020a17090671c600b009920a690cd9sm1324627ejk.59.2023.10.20.04.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 04:50:42 -0700 (PDT)
Message-ID: <e11ab885-10dc-4efa-8171-ebdb3ca61b24@gmail.com>
Date:   Fri, 20 Oct 2023 13:50:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] gpiolib: acpi: More fixes to the consolidation
 rework
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Hans de Goede <hdegoede@redhat.com>
References: <20231019173457.2445119-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From:   Ferry Toth <fntoth@gmail.com>
In-Reply-To: <20231019173457.2445119-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 19-10-2023 om 19:34 schreef Andy Shevchenko:
> On top what Hans already fixed, Ferry reported a few bugs that pointed
> out to the same consolidation rework done in v6.2.
> 
> The first is most serious issue, that needs to be fixed ASAP.
> 
> The second is good to have.
> 
> And the third one I'm not fully okay with, so open for advice on
> how to improve.
> 
> Note, that long list of parameters to a _find_gpio() functions
> can be hidden in the specifically crafted a new data structure,
> but this is out of scope of the _fixes_ series. I'm all ears as
> well for that one.
> 
> Andy Shevchenko (3):
>    gpiolib: acpi: Add missing memset(0) to acpi_get_gpiod_from_data()
>    gpiolib: Fix debug messaging in gpiod_find_and_request()
>    gpiolib: Make debug messages in gpiod_find_by_fwnode() less confusing

For the series
Tested-by: Ferry Toth <fntoth@gmail.com>

>   drivers/gpio/gpiolib-acpi.c   | 10 ++++-----
>   drivers/gpio/gpiolib-acpi.h   | 13 ++++++------
>   drivers/gpio/gpiolib-of.c     | 13 ++++++------
>   drivers/gpio/gpiolib-of.h     |  8 ++++----
>   drivers/gpio/gpiolib-swnode.c |  4 ++--
>   drivers/gpio/gpiolib-swnode.h |  1 +
>   drivers/gpio/gpiolib.c        | 38 ++++++++++++++++++++---------------
>   7 files changed, 48 insertions(+), 39 deletions(-)
> 

