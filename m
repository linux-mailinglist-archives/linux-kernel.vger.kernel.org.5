Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CB47B689D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjJCMJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjJCMJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:09:18 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E06ABF;
        Tue,  3 Oct 2023 05:09:14 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bf6ea270b2so6068295ad.0;
        Tue, 03 Oct 2023 05:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696334954; x=1696939754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CmBs73lcWD9k98KqGPVGwvpI7hbBVTH4u02wod8lyZo=;
        b=ixFNqrNHH3d4CrSin6INAObfBGGxgmbK7HqdAx4ud8rBYdPyXLbhxPt64A1kgPeEi6
         lsKxjOSfc7SAh792T27QuuvMNzVsT3O7IRCUA//waIJxfnpSak39NF/0LnefvBSLE/WN
         2U0rNmljK4mEPWd42D+nzjWlCVIlHCblcAIh7G+SpwKwacm2HGEvtbyA/Sw7CgROfOy4
         yYFfM/Hd82XQ6Q3Stf0ukCtX6an3wEwfo++SfqBHhQHrz6uZy/kSWCGa87cgRs3oHss8
         QnYQyMBQzHR6FPUgsqE/4w6rOz3Iv/70B+VSL7g6FD/VdqHgm4b82vDGLzCqhv+tTPJ0
         LJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696334954; x=1696939754;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CmBs73lcWD9k98KqGPVGwvpI7hbBVTH4u02wod8lyZo=;
        b=P5IdWhht/+MdSZuNzQCarr8fYSv1v4irakX2YDsO/6sNVlBZ7nbjpkGfTlgpmSptQA
         2Nk5kYwmPYIjEjWIaDTblNTru9BqJ9pY0SQoqKP1c399FYHA7mcjinUHXKIWBUZcQYkJ
         g5bUi7/3bWdX8tGYfLltPZdtGxYnYpqPJ/FGUXzfEunMMU4il81Ae52aD3HTdymSh5uk
         J5/YoHfSwSNVhT9yIJtdN5LhYc3LQQeZ10V9vCYgzNA+3w+d0BU/TQ+8G7wsAFq1HgOL
         022ZcJVlbQhbtAdSPbtIQcpCeAtIXliSOqiCXfEMl8F4DMUvSOLTh7f8cP3tfYa0TXwl
         qKqA==
X-Gm-Message-State: AOJu0Ywx1aHYJ5Ql4k+uzGLdFjUzTdsDgYaLRRlj3fzA2qh98mSgHEiy
        ovAc/gHtg5XNeesRVvQCspE=
X-Google-Smtp-Source: AGHT+IEvC0m8WS0q071UtHrbTqvrtJ1b6c+LAX2fqhcw9n+G09+3gQmOUEgpwf0QKSpzk4WcWWzTNw==
X-Received: by 2002:a17:902:8649:b0:1c3:5f05:922a with SMTP id y9-20020a170902864900b001c35f05922amr11025143plt.60.1696334953970;
        Tue, 03 Oct 2023 05:09:13 -0700 (PDT)
Received: from [172.16.116.58] ([103.15.228.93])
        by smtp.gmail.com with ESMTPSA id ja7-20020a170902efc700b001bf846dd2d0sm1393813plb.13.2023.10.03.05.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 05:09:13 -0700 (PDT)
Message-ID: <2105b93c-0502-e909-ea09-dba73d43b912@gmail.com>
Date:   Tue, 3 Oct 2023 17:39:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 1/3] dt-bindings: Add beaglecc1352
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        greybus-dev@lists.linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, vaishnav@beagleboard.org,
        jkridner@beagleboard.org, nm@ti.com,
        krzysztof.kozlowski+dt@linaro.org, vigneshr@ti.com,
        kristo@kernel.org, robh+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20231002182454.211165-1-ayushdevel1325@gmail.com>
 <20231002182454.211165-2-ayushdevel1325@gmail.com>
 <55f63415-781a-4107-8643-9f77c7ee38d1@linaro.org>
From:   Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <55f63415-781a-4107-8643-9f77c7ee38d1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> driver.
>>
>> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
>> ---
>>   .../devicetree/bindings/net/ti,cc1352p7.yaml  | 48 +++++++++++++++++++
>>   MAINTAINERS                                   |  6 +++
>>   2 files changed, 54 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
>> new file mode 100644
>> index 000000000000..57bc2c43e5b1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
>> @@ -0,0 +1,48 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/ti,cc1352p7.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Texas Instruments Simplelink CC1352P7 wireless MCU
>> +
>> +description:
>> +  The cc1352p7 mcu can be connected via SPI or UART.
> If over SPI, then the binding is incomplete. This is fine for now, I guess.
>
> Best regards,
> Krzysztof

Well, I added the line about SPI because the data sheet states that 
CC1352P7 can be connected over SPI or UART when used as wireless MCU. 
But yes, I do not have much knowledge about SPI itself, so the bindings 
might be incomplete for SPI usage. Should I remove it or leave it be?


Sincerely,

Ayush Singh

