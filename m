Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63C67EEB5D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 04:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345651AbjKQDVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 22:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjKQDVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 22:21:04 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3DDB9;
        Thu, 16 Nov 2023 19:21:01 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6c32a20d5dbso1429248b3a.1;
        Thu, 16 Nov 2023 19:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700191261; x=1700796061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=04yJ8YqPKGFpqj3v0iOVI9DtylMq/xzGcXD8UiSYJ3g=;
        b=Kb1Ddgn/HOoMl9tY9JCOZckEZXTVXGOdYBGR67qpX9jj9mfp9YewVIlQmr0NB2RQgq
         eIi3Wyf63UNlVkwvA5qjih9psYB6AnDJ/lHpe+TJoJ3eCiO9ZOnvlsP863cFvBQfKlWH
         nJ9P5gTcHga8jsGITwkDVe07U3nkty5CLbCPJnbPUNmklK7XfdWkZ6/EOhVmj2DnoVs/
         NCkPY8wiIuM+laI824rTgwEb5Mi/upgGgozDOgzRF6iQwF0bPVG08ETz8Nq6i3kgizrl
         PLPXz6GzWE8vTffvdyCzebw+ljCo2KfiumO/TWKcQU0ayzBMtRuhhz+LZB7VOOn+R49T
         2KYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700191261; x=1700796061;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=04yJ8YqPKGFpqj3v0iOVI9DtylMq/xzGcXD8UiSYJ3g=;
        b=o1IZJGLRVpg/ETWgy9CN9o5ORZLX03jMkC/a2/ipI1EvEZEhIR1UKFAOFg+O+iVPri
         lqQv6OUpVjSp2rRwTtLthsrYZCRxoNwyOxOlRYp8z67B3Bwf8y8d0WnD/CqyJhsrekgA
         +j0jj793jWuW3kWw8WVVKXfmFcx/dRI5fmnc9SOehVxghgUrzJFvN8bVJChQis9NF4eq
         u9KWEORBbnXk5lVs2xiXon3rlZSOszbwFgVpfBleD5Qpwr+ryNhmRoFSCY22i2QCzrFg
         Kvq6tmuonh8Y2yvRjd8mU5c4+ULhOlPwlHmJ0Lf52A1fPgU1D5wO9FmuxV7SN6bitS7d
         GVgQ==
X-Gm-Message-State: AOJu0Yx/t9hlMI6RMYagK8/PA7niEYI58s4cq6hGQ5dPj7+ZIF5L/53r
        +D0Ya08+x0ybJEquOwZT5ypbYkhVgQc=
X-Google-Smtp-Source: AGHT+IFjDnrMp2pgy7V0U4koa/oNWvYszgsQ2cUM3Qj+UHiq3IVv4gnZaiFGgPGTKFjFRrGq+pa71Q==
X-Received: by 2002:a05:6a00:4511:b0:6c4:e8a1:8b3b with SMTP id cw17-20020a056a00451100b006c4e8a18b3bmr21681438pfb.25.1700191261004;
        Thu, 16 Nov 2023 19:21:01 -0800 (PST)
Received: from [10.10.14.80] (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id j7-20020aa78007000000b0068ff267f094sm453663pfi.158.2023.11.16.19.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 19:21:00 -0800 (PST)
Message-ID: <69657f96-4849-4134-911d-4785d5d6b8d8@gmail.com>
Date:   Fri, 17 Nov 2023 11:18:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: Add mps mp5990 driver bindings
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joel Stanley <joel@jms.id.au>,
        Chanh Nguyen <chanh@os.amperecomputing.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
References: <20231113155008.2147090-1-peteryin.openbmc@gmail.com>
 <20231113155008.2147090-2-peteryin.openbmc@gmail.com>
 <a3445201-58f2-42c6-bef7-ca6968fd80d6@roeck-us.net>
Content-Language: en-US
From:   PeterYin <peteryin.openbmc@gmail.com>
In-Reply-To: <a3445201-58f2-42c6-bef7-ca6968fd80d6@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Guenter Roeck 於 11/16/23 06:27 寫道:
> On Mon, Nov 13, 2023 at 11:50:07PM +0800, Peter Yin wrote:
>> Add a device tree bindings for mp5990 device.
>>
>> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> What branch is this patch based on ? git fails to apply it.
> 
> Guenter
I think I don't pull the last version. I can rebase it and push the new 
version. Thanks for your feedback.
