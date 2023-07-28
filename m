Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC2A766936
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjG1JqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbjG1Jpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:45:55 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F7C26BC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:45:53 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b93fba1f62so29357221fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690537552; x=1691142352;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FgMNDG4ongin98+9dkOLLQ9bJohCnPv4w5zxnG49dk4=;
        b=Tim5gIJVQuPTDV1qsl6ufALej5ONI6uuREeU7Hvc5WbfNtmNiNIwZgLY28e6moZOiB
         kKqYcbRsYtQKL95RG44vNT+LkA6a0qdoleTerLlZ2rjlXV/c2od4u0MrD6SdJ/ZGeLsk
         h7vR4+kFIgLK1D5C1q+0tLNgqRHiI9P0IjJMFdfYDxg2Xf0eVNUlXjrpMyV4VI6+p9Wb
         MXrwjxQUS6eFKkx7c+813w6SS/ShzwqlZqW+cfQHNMv6eFnOC+FiRyT5GaLROF0P78fB
         ygcPIf8/6cokVlAJcXDW5f1WfQrRhwNDQRdVA/alEXSqP6DIhX0iePrgc1+ho0TOjBIR
         AzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690537552; x=1691142352;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FgMNDG4ongin98+9dkOLLQ9bJohCnPv4w5zxnG49dk4=;
        b=Mh/JQ4HzaEfiLISGwM3xcszNX7h8nqPkt9XPzdvwStIYTIAOA0uh977tVfm5a7/niq
         Vdh7yc0yixvnm5VQbYid7VXYqa2EbAYhDqvNKWKyVa4aHH+Im2MMsGpz7SK6SVo3fwHw
         Kx51oH+jAsbqbCg5Qck9sDyGlw+5RrC5XD2W7+wlBSHzbvD1maHT+GzrpwVw8eSXkbx1
         fpCeM+2RWh07D79S0pYjrirmEiSpoEZwbl1z5r096/4U/n4Sd3rJXtBJbRuZeykh46sg
         ZJi5HLeT0DvU40bJgZbYf7vpCXU3QG0vClf+I/39h4Qa9bdnkMBIzUWsYfVw2ekeuJP6
         w9Bg==
X-Gm-Message-State: ABy/qLaGDqKXATDS/0/yi/98Tv72NRszNQDfAzQZGPlVj6+P5FMaJdS9
        9AfghpkCfXVIf0lmZ2d/l+sV6g==
X-Google-Smtp-Source: APBJJlFooh1vUVlzLog4m8502Xt0bVDloiQgURR9dNrDuxY5+dTqA0S0UQ0HJtLhy0tZBzjlZGJiTg==
X-Received: by 2002:a2e:7d15:0:b0:2b5:9e51:2912 with SMTP id y21-20020a2e7d15000000b002b59e512912mr1240030ljc.24.1690537551819;
        Fri, 28 Jul 2023 02:45:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id a4-20020a2e8304000000b002b6ad323248sm863180ljh.10.2023.07.28.02.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 02:45:51 -0700 (PDT)
Message-ID: <7986a634-63b2-28d6-5f17-7b982ae56bcf@linaro.org>
Date:   Fri, 28 Jul 2023 11:45:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 0/2] soc: loongson2_pm: add power management support
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>, Liu Yun <liuyun@loongson.cn>
References: <20230728074944.26746-1-zhuyinbo@loongson.cn>
 <74a37e9d.9a24.1899b9bea85.Coremail.chenhuacai@loongson.cn>
 <1c8b12b4-79c3-5018-c7df-946fe690e8c8@linaro.org>
 <20230728-pessimism-exclaim-de0dd7f4bb64@wendy>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728-pessimism-exclaim-de0dd7f4bb64@wendy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 11:18, Conor Dooley wrote:
> On Fri, Jul 28, 2023 at 10:36:42AM +0200, Krzysztof Kozlowski wrote:
>> On 28/07/2023 10:27, 陈华才 wrote:
>>> Reviewd-by: Huacai Chen <chenhuacai@loongson.cn>
>>
>> ...
>>
>>>
>>>
>>> 本邮件及其附件含有龙芯中科的商业秘密信息，仅限于发送给上面地址中列出的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制或散发）本邮件及其附件中的信息。如果您错收本邮件，请您立即电话或邮件通知发件人并删除本邮件。 
>>> This email and its attachments contain confidential information from Loongson Technology , which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this email in error, please notify the sender by phone or email immediately and delete it. 
>>
>>
>> Ooops!
>>
>> Are we intended person/entities to receive your Reviewed-by tag?
> 
> It's okay, you only got a "Reviewd-by" tag ;)

I guess so, especially that this disclaimer should be useless. But on
the other hand, do I want to deal with it if once Loongson sends me
Cease-and-desist letter for something? Why even thinking about this
should be my problem? Why should I even consider this topic: is it
harmless or is there any risk?

Best regards,
Krzysztof

