Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A880766764
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjG1IiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbjG1Ihj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:37:39 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2654209
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 01:36:46 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31758eb5db8so1869530f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 01:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690533404; x=1691138204;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BtwvNBoqPreZzrIHNt/kSe+j+nQ7Y0O3XISTfz5OulI=;
        b=vFQXpN02JfsMoWYpIwLMuDCbn0Qez745NESDhZvY9t8YMmRTsET0j7GvKKpiXCkQ/w
         HXzMoM6xiNHyGIuu7Dix/pdoD/fzLlQa1/L9nFM9od6sK4A+HpIJTt6KOGdLPTPNT1pd
         km8aMeN7istZEsXQiXN5srzbEiR0Sy3B/jlGyLE/F9K7VrsNlpG1OtvnlF4i2hDwHbAN
         eQs2ZSrtkROaqoaomokdGeQXuH+aaWwrp58xrkfMqZa0lhng8AZv9QicP9C65ot0mNga
         sxeXOj4HZednJRoJg3fY2K6o1dwv/iAEgNfoRShlQOEkGlVDnJ8gjAU7MN1spRIbZGT1
         MuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690533404; x=1691138204;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BtwvNBoqPreZzrIHNt/kSe+j+nQ7Y0O3XISTfz5OulI=;
        b=jFXxV6/LREhM2lbsbczqBQW1oWyOlJ0QLBj5cfKBAXEczEk5OyXZmMj1ZS3AvUPo17
         1C1IslvSCD3Gujnauj78YBu/drSSklu1JxxQ01dcAZ3zz3LLyqn0BmAcSIs4p7UenD/o
         ksZQ4lx/pNE8X5UvriuRHcQ18EL02mDKpPNG1zfsRO6uSib9qVFIi9Hklq9qaZSd/wX6
         Sv9V2s7rl+zGpmKxacBYOc+5oaH2RnHTKVJtrpJBSU6rpm3xysSMTlACYBzDT5S6q5Eh
         kCdVqUrJKfyZRUG1rf46JSDqUJR/cJR/QvFuNPHN5UjXGrNNJ/UwvKTKdlKF7Hs0GVSo
         uyEQ==
X-Gm-Message-State: ABy/qLaQDj+bV1TggXM54ytit+KSj7l1OUk65CSB94ZqR0qlM0zeyLf5
        G/54Wv2/WFcJT8T/mijXwJdMeZGqZgKZYphBV2hppg==
X-Google-Smtp-Source: APBJJlHMMcwnrlSEE2C7l5Zov4GM6ePQqbR7DDm3U7Bv54eXEkKfSzlMUEICGEWs7EOdoCVFwnhFVg==
X-Received: by 2002:adf:ef8c:0:b0:313:f4e2:901d with SMTP id d12-20020adfef8c000000b00313f4e2901dmr1246487wro.22.1690533404559;
        Fri, 28 Jul 2023 01:36:44 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id s1-20020a5d4ec1000000b003063db8f45bsm4188750wrv.23.2023.07.28.01.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 01:36:44 -0700 (PDT)
Message-ID: <1c8b12b4-79c3-5018-c7df-946fe690e8c8@linaro.org>
Date:   Fri, 28 Jul 2023 10:36:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 0/2] soc: loongson2_pm: add power management support
Content-Language: en-US
To:     =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>, Liu Yun <liuyun@loongson.cn>
References: <20230728074944.26746-1-zhuyinbo@loongson.cn>
 <74a37e9d.9a24.1899b9bea85.Coremail.chenhuacai@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <74a37e9d.9a24.1899b9bea85.Coremail.chenhuacai@loongson.cn>
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

On 28/07/2023 10:27, 陈华才 wrote:
> Reviewd-by: Huacai Chen <chenhuacai@loongson.cn>

...

> 
> 
> 本邮件及其附件含有龙芯中科的商业秘密信息，仅限于发送给上面地址中列出的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制或散发）本邮件及其附件中的信息。如果您错收本邮件，请您立即电话或邮件通知发件人并删除本邮件。 
> This email and its attachments contain confidential information from Loongson Technology , which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this email in error, please notify the sender by phone or email immediately and delete it. 


Ooops!

Are we intended person/entities to receive your Reviewed-by tag? We will
be using it (total/partial disclosure, reproduction, dissemination).
People not on To/Cc will also do it and for sure they are not intended
recipients.

Please talk with your IT that such disclaimers in open-source are not
desired (if not harmful even).

Best regards,
Krzysztof

