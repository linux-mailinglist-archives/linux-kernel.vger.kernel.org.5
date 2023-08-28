Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B3878A612
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 08:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjH1Guz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 02:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjH1Gur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 02:50:47 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F351610D
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 23:50:44 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52a4b62c2f5so3742175a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 23:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693205443; x=1693810243;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rpIeeMqt1NLo0grI9YIWzRKrep1/kjmHHkzp8+x9//g=;
        b=W6uJ30dKG/Das5v/TNC5c17ulSdSZNoQ1q/3ouSW50L/psreaDvU7HhTVYreF5mrtb
         KDgpQVg6Esk3wLMRW1yvwAurQ/XS83OIUhrfbQqnm8zEciKRaSAXL35NGOz/KYSaLOCp
         0BzT6ztFDB7b4LqBXP0PpcJg0MZgd5ya1rqz1c6MxcU9wjegY0lPYvCF1MzFSLMVQIlu
         vuOQ9Xg0oHLt53r/uKZlc8njQi7wt+59M9bXxJtBlKq/2l21doKx26kBRTphlgYlp0jv
         aFD7KjNyUzjYRdLHqFlbbTszP1Te+0HIhexT/RJtkW3dWtyjNvySVrPli8OuU9VdNTJE
         Clyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693205443; x=1693810243;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rpIeeMqt1NLo0grI9YIWzRKrep1/kjmHHkzp8+x9//g=;
        b=lJ64IvulyRX9YmxCTEyx9JfxnOqn64qbGY4ueO7WSKYO4+p3+/JeI2TQsm6awZBd02
         0stIlgo0ySQcf36xpqfgnC786luFLd6qIDpwb7JTo2PqvkI3ng7QfzSI9MfxKvKWM5AA
         21kUS9a+Pc6PNzxnjMDzcQba9xy4VufpVjuUX9CQbXDz98r2v4cI7TwzLpoNjAsyIMBc
         n5VYo/Lgm8olEHEfAz39UipBo0Zym2l+xvLap4C/cwjP39jAB2D+uFtUImhrjKvXZdLw
         8wypiLKJW/jtxqGeQqiQNZbRolYt1TH+d7Avj/WAE7hHk3MMN963BLTjkttqKjf0qKoO
         t1jw==
X-Gm-Message-State: AOJu0Yzn9e9OmU5xROdfuh9fI1xHOg+w/7XG0s0VlwSCTejhGcw7WVp6
        ZR1KTkgG+WMEr3B0LUw7MPhav6bNRUlpv8KbWyg=
X-Google-Smtp-Source: AGHT+IGurpQrZEy3X49gFow8zRA9SDTeDSsML8wtlTFlqUUBzEZvwp2Q6sQ+S6iZn45VltI8g5Hoag==
X-Received: by 2002:a17:906:cc0e:b0:9a5:852f:10bd with SMTP id ml14-20020a170906cc0e00b009a5852f10bdmr4500123ejb.62.1693205443354;
        Sun, 27 Aug 2023 23:50:43 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906059100b0098963eb0c3dsm4263545ejn.26.2023.08.27.23.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 23:50:42 -0700 (PDT)
Message-ID: <d3c9e032-e20f-97e1-2d08-9bd87691d43c@linaro.org>
Date:   Mon, 28 Aug 2023 08:50:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] riscv: dts: allwinner: d1: Add PMU event node
To:     Inochi Amaoto <inochiama@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>, Wei Fu <wefu@redhat.com>,
        Pei Chen <cp0613@linux.alibaba.com>,
        Wenhan Chen <chenwenhan.cwh@alibaba-inc.com>,
        Guo Ren <guoren@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230828-cupid-muck-130c4ef218f6@wendy>
 <IA1PR20MB49533ABEA8426D21C00311F8BBE0A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <IA1PR20MB49533ABEA8426D21C00311F8BBE0A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 08:41, Inochi Amaoto wrote:
>> On Mon, Aug 28, 2023 at 12:30:22PM +0800, Inochi Amaoto wrote:
>>> D1 has several pmu events supported by opensbi.
>>> These events can be used by perf for profiling.
>>>
>>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>>> Link: https://dl.linux-sunxi.org/D1/Xuantie_C906_R1S0_User_Manual.pdf
>>> Link: https://github.com/T-head-Semi/openc906/blob/main/C906_RTL_FACTORY/gen_rtl/pmu/rtl/aq_hpcp_top.v#L657
>>> ---
>>> changed from v3:
>>> 1. remove wrong event mapping of 0x0000a
>>> 2. add reference url of c906 events implementation (D1 only support events
>>> described in R1S0 user manual, but event mapping is the same)
>>
>> Why'd you drop my ack? There's nothing here that'd invalidate it AFAICT.
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>>
>> Thanks,
>> Conor.
> 
> Sorry for this, I am not sure whether to preserve the ack.
> Thank you for your ack again, and I will reserve this if no big change
> happens.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577

Best regards,
Krzysztof

