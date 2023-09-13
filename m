Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6201F79E97A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240999AbjIMNh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239451AbjIMNh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:37:28 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C37F19B1;
        Wed, 13 Sep 2023 06:37:24 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-573921661a6so4056379eaf.1;
        Wed, 13 Sep 2023 06:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694612243; x=1695217043; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=mcgD0Ewsr/9q6i+3hzurksNbRO1+jgjaSl9HYyWGZo4=;
        b=sq1v/bzsGLWkRRucN9AvRSWrGkHXufwQt2+ar+VNlLzlavth5jdHynhsv+IpWKB1dx
         x4S1xg0ub4G6kaWLYLN/YwL47UXWBlEjfI5Q74f7AnkZ+QhwATETj512IVs7IdiXuAkT
         Es6O82KIt/6KhIP+643nL4GAixB0w08i8gL10QxDFObogNhN2UIAwXA+ffRZuAlJe6Hs
         ztAVqcgq6jAVb9gz7aYmhKgVl4qQt0bwSgoosiaZCi7NAfw29BzF7r5mQHPJDyUHa0oM
         OICm+TKGiRLquW7y+0jfRz52B3jVIs97TGVQre+zNkM3JVVg4ul/bW1nEGR7Ch9uNLa/
         i9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694612243; x=1695217043;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mcgD0Ewsr/9q6i+3hzurksNbRO1+jgjaSl9HYyWGZo4=;
        b=GJe9F1xzEuC77jhQuCKRRunKSahD0RK6qhtClTIU3FB5+ccJx11HeWwCdOPetURdY1
         10Zf3TUx/iUJr0aS4Lu9ZKxIDn9sdB2hftS2iM9apnk4U0OYVv93RiMb7eGUyPtHwUIv
         TvPJ4KCjWzBt2cJAiNKb3sDjlng2A5+E+DufQOxXCUIONhE5+AVwQ2oVkesBe+G52cCs
         j5aQtPVLLYMctgEhhxaW3fEMVNCNZBDArrFFL74gIh3knogeLAKssqW2qwh/wlGOcAkb
         OlCHawwfz4D/Y6GPeBB6c4lmWhrTV4cfAhhLB4TlIZr9vn+msemT384jLgRwKvXLRJKm
         /Z1Q==
X-Gm-Message-State: AOJu0YwU0TIT7P0zsCfJ/UIGx6E4bLJYooF2rGuMDFqAFsfNlymE/9IO
        AaIY4iriXyN+UKQgBWYCv7h9xxVPPIQ=
X-Google-Smtp-Source: AGHT+IFQ3x6iFxJ+MomknNL5UtqI+O6dlEwbOiZeDCE0/go3o7I3KRFg1tVQtPfDbFVV3sme9riTOw==
X-Received: by 2002:a05:6358:99a1:b0:140:ff29:7057 with SMTP id j33-20020a05635899a100b00140ff297057mr2640539rwb.7.1694612243328;
        Wed, 13 Sep 2023 06:37:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h8-20020a62b408000000b0068a0b5df6b2sm9128737pfn.196.2023.09.13.06.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 06:37:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <29e27f2a-3347-b6f4-2dd9-4c93afea87b7@roeck-us.net>
Date:   Wed, 13 Sep 2023 06:37:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] hwmon: max31790: support to config PWM as TACH
Content-Language: en-US
To:     Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>,
        "patrick@stwcx.xyz" <patrick@stwcx.xyz>,
        Jean Delvare <jdelvare@suse.com>
Cc:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230906084837.3043030-1-Delphine_CC_Chiu@wiwynn.com>
 <20230906084837.3043030-3-Delphine_CC_Chiu@wiwynn.com>
 <8a3b41a2-0ab2-6213-04a1-54ab7263c647@roeck-us.net>
 <TYZPR04MB58533E15AA65FCDA0F603FA3D6F0A@TYZPR04MB5853.apcprd04.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <TYZPR04MB58533E15AA65FCDA0F603FA3D6F0A@TYZPR04MB5853.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/23 01:51, Delphine_CC_Chiu/WYHQ/Wiwynn wrote:

[ ... ]

>>
>> This assumes that the channel is configured as pwm.
>> What if the BIOS / ROMMON configured another channel which you want as
>> pwm channel as fan input channel ?
>>
> This will config the channel as TACH.
> Could you provide more information about the scenario you mentioned?
> In our system, there is only BMC that will set the config of fan device.

Please keep in mind that upstream code is not intended to only support
your specific use case, but the use case of others as well. Your system
(the one you have today) may only use the chip for fan speed
measurement. Others may use it use it to control fans, or your hardware
might tomorrow build another system where the chip us used to control
the fans as well. Those use cases should be covered by your patch as well.

Guenter

