Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB237F2597
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 07:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbjKUGCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 01:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjKUGCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 01:02:42 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00429CA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 22:02:38 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5446c9f3a77so7494781a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 22:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700546557; x=1701151357; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wPi0ei9zIN7cw0UozDtXu7c9EU4Lneb2safJ+jL5Iak=;
        b=mFmEZLGu9ZUfRHeECBNo4Q4+nww7+hcNzdc1+fyqWVSQYBAJ6i5rez82D7kfNHs70G
         T9inqz5fJe1F1SnNWamQSDy9DBj7I/qxX3+xcZq6o71S/FmOQP0HUSJiQkiFpx6s8ypW
         gJcn0EqUIaU7EIQkmgvyW5I0hdlQowZwkzu1WP3Ujjk8bF1AQKnAiRHOjXlFKDefCMH5
         t1sb/dGdpGxcRj/QlRQv8OxGIps8MZr0qnd94bE8AdJfDIY+atVku1caubJaR7KPMxav
         +sqGpU+D03OphRaITFGbOu9NVGadXgsPNx/VBAu/wKuPXELWwyknClHbGXouehTqP+hp
         g6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700546557; x=1701151357;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wPi0ei9zIN7cw0UozDtXu7c9EU4Lneb2safJ+jL5Iak=;
        b=wfv8s7lAPSdAUwT3gp1dbYl75uF8jGFt3gg6XU97KxyWJmQKFk1U2fAa5HzQxRgBzT
         LKvK+Bq5A56wRWWZt+FnFZWkWERLG/lnXt19OOY1A9fG/iAPCBtk63W1IrXCN3hGpdH9
         osH/zwjScKFXvEnng74AxG3GxR0AluQskUwnejd0pMMwN7xZzD5S5rx4JLnGa5cBNGz7
         KluWZDmtu2x4dE/iQ8GjGI20IwZvZ+4o7YQiasnZ2hbf/WjLZqnY17UPzxqySCngxumQ
         hKKx0VZsAC59gnsn7KMkOvAjuUF+C84q/xgcoqtX6+6bHyq7gBXfPY01RghNkfR1UuXX
         fjXw==
X-Gm-Message-State: AOJu0Yyt9rFWP3taeplay8C4HxfntuGM++0FCfWQ4oP+tkqQdRzlVqVf
        FAKC86SZHggs7upmTCuWEZW/fg==
X-Google-Smtp-Source: AGHT+IEcokN5bpe9MCOGFGvwjCApmFKGwVt6ycHk073VTF+yo+Ns0lKpuZSUnYha0vTCbGngINjNOQ==
X-Received: by 2002:a17:906:68c5:b0:9fc:3a70:4430 with SMTP id y5-20020a17090668c500b009fc3a704430mr6097006ejr.70.1700546557189;
        Mon, 20 Nov 2023 22:02:37 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.3])
        by smtp.gmail.com with ESMTPSA id h11-20020a170906530b00b009d23e00a90esm4805556ejo.24.2023.11.20.22.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 22:02:36 -0800 (PST)
Message-ID: <2545ffad-e970-499e-9192-ff89776e1946@tuxon.dev>
Date:   Tue, 21 Nov 2023 08:02:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] net: ravb: Make write access to CXR35 first before
 accessing other EMAC registers
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
        geert+renesas@glider.be, wsa+renesas@sang-engineering.com,
        biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        sergei.shtylyov@cogentembedded.com,
        mitsuhiro.kimura.kc@renesas.com, masaru.nagai.vx@renesas.com
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
 <20231120084606.4083194-4-claudiu.beznea.uj@bp.renesas.com>
 <c27d5dd1-bcdc-a79e-bf0b-a7e93f5d9545@omp.ru>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <c27d5dd1-bcdc-a79e-bf0b-a7e93f5d9545@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.11.2023 21:44, Sergey Shtylyov wrote:
> On 11/20/23 11:45 AM, Claudiu wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Hardware manual of RZ/G3S (and RZ/G2L) specifies the following on the
>> description of CXR35 register (chapter "PHY interface select register
>> (CXR35)"): "After release reset, make write-access to this register before
>> making write-access to other registers (except MDIOMOD). Even if not need
>> to change the value of this register, make write-access to this register
>> at least one time. Because RGMII/MII MODE is recognized by accessing this
>> register".
>>
>> The setup procedure for EMAC module (chapter "Setup procedure" of RZ/G3S,
>> RZ/G2L manuals) specifies the E-MAC.CXR35 register is the first EMAC
>> register that is to be configured.
>>
>> Note [A] from chapter "PHY interface select register (CXR35)" specifies
>> the following:
>> [A] The case which CXR35 SEL_XMII is used for the selection of RGMII/MII
>> in APB Clock 100 MHz.
>> (1) To use RGMII interface, Set ‘H’03E8_0000’ to this register.
>> (2) To use MII interface, Set ‘H’03E8_0002’ to this register.
>>
>> Take into account these indication.
>>
>> Fixes: 1089877ada8d ("ravb: Add RZ/G2L MII interface support")
> 
>    The bug fixes should be submitted separately and against the net.git repo...

OK, thanks for pointing it.

> 
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> [...]
> 
> MBR, Sergey
