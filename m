Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9743F7521E2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbjGMMxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbjGMMwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:52:55 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01EB19BC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:52:53 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbf1b82de7so4148745e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689252772; x=1691844772;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xs/7FADKnAXVjA8+DrUAlRSwNfgpNlGEVv20ZizM5qc=;
        b=KkCvrT36OXgG6AbaVd8y5Of2o3Kv7d1CGiRewm70RhIUk5kLjxtLh4ej+PWIN/uIPY
         UZW0d3DA6EyKL1upS2Z6i3MxXe9tnt90xJuezbrcsst5wLFxkYfn9BlrgS8ZZAQOyXYN
         EILOKEi2jp3PdRGK4BqlViWGX37UENVU2rn9u+OV9/WhHFYlUU9wjtsvi2YU23Fvbvxw
         vKu2jDH1toKrda7AdUkQcF1b2wE3bZBfO8yYuDHVVfW3iOyL2S5Bbq97Uhsgp8ucO1sM
         QulKQ0ttjTaDpB78QOQPf7+Gra7HaLBfeDEIwTGkm/l/XWewfTRP333lXVGu/K0v4eNK
         MVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689252772; x=1691844772;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xs/7FADKnAXVjA8+DrUAlRSwNfgpNlGEVv20ZizM5qc=;
        b=coq+SoFtSUYnaA4/BsC7yV09KE5HabJefkdhXCf3Dl0xzkX2hXIAD3kqn/G4COmp9W
         wl37+2hK7pGX/JIqImleD3Dcc1IhOv79rjReY6GbaOLccSRsu+N+Lmed4agKPseqz5Xf
         V4hxch5Rc/gfCljQq3LBuQ3Jn0pnvY/FqiOPGonA/fQdZC65275lXvqF2/HS0ux1FDmw
         nVc/UWooOf9SZBzqeunGx3VUHQofwcnFkHDBqn57L606t4YbXH/H67PUK58Nmts2hI4I
         mhnrx3MluQOyMwOscLjxm7WQd0Uubn1L+iC75g1IUJ0ELsUWZcHDtvO1wqFUM38KIahx
         C6WQ==
X-Gm-Message-State: ABy/qLap+C421+MerM9HTFEzvW2e5Bxx5hpljZQA225cj2eYkgfg1cVr
        vkbqaMbwxeB9dlrwHO4TWxbwXQ==
X-Google-Smtp-Source: APBJJlFlYVGLn5ZtuMlM6FqknkVkHBz4bHT5FPfVlu1i8FVSGT9W4R/7cv4R9s5sitEpmnIc88Zw8Q==
X-Received: by 2002:a05:600c:444d:b0:3fa:91d0:8ddb with SMTP id v13-20020a05600c444d00b003fa91d08ddbmr4138119wmn.14.1689252772241;
        Thu, 13 Jul 2023 05:52:52 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id t9-20020a5d5349000000b003143b7449ffsm7929562wrv.25.2023.07.13.05.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 05:52:51 -0700 (PDT)
Message-ID: <913eebe1-1b84-ba34-7ed5-de3154ece666@linaro.org>
Date:   Thu, 13 Jul 2023 14:52:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] thermal: of: fix double-free on unregistration
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        kernel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230708112720.2897484-1-a.fatoum@pengutronix.de>
 <20230708112720.2897484-2-a.fatoum@pengutronix.de>
 <CAJZ5v0jS-VVjj7AS-W4dGNY2E=hAiXS-ZtNbj6mNSzCVFXxCwg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0jS-VVjj7AS-W4dGNY2E=hAiXS-ZtNbj6mNSzCVFXxCwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2023 20:05, Rafael J. Wysocki wrote:
> On Sat, Jul 8, 2023 at 1:27 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>
>> Since commit 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal
>> zone parameters structure"), thermal_zone_device_register() allocates
>> a copy of the tzp argument and frees it when unregistering, so
>> thermal_of_zone_register() now ends up leaking its original tzp and
>> double-freeing the tzp copy. Fix this by locating tzp on stack instead.
>>
>> Fixes: 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone parameters structure")
>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> 
> Daniel, this looks like a genuine fix to me, so I'm inclined to pick
> it up directly.
> 
> Any objections?
> 

No objection

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

