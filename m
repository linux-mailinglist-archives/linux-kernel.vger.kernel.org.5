Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7F9774787
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjHHTPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbjHHTPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:15:22 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAB03C22D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:38:11 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bf8e5ab39so870076266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691512673; x=1692117473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rq9CGfMIPSDr9ZlL/JERcR7sYpgjvn+r29Kl2qTSWpE=;
        b=khS11bjZmNIvPBUsXn03/vAuc/rMsMsRLjvdhE+aGwPrW6uuH6ypaIQLLzgLmnqnDQ
         +3uWuon3U30HBMW9zd4R+rOWLafpCLmzrtfgJPM/2Fr2mruytA3sU3fEL3OXQFNkYuWQ
         FFZEpOd57OjDX+/j4yszfjTutM2noIxpfUENgTtG9i1NWNjRzKlGilTKGf7Es/E81Fuo
         6VJTGAqkgjeJQhFRZxMX2oesin3ke0C0XE/a8K5R4N7X8U6RG29JkFQEmPKGWNRWgiSY
         cQo4L6zbvNdTWGueflica8eAV2kJguUjhZoAMHsXGQ6aXRAbl/qxaik1C+1qvKUVgA4w
         Hf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512673; x=1692117473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rq9CGfMIPSDr9ZlL/JERcR7sYpgjvn+r29Kl2qTSWpE=;
        b=HMgXHFd7VNVVkrArJ8MMzf2R+tnCRUsKtvYh/su5mwnUJ7aj7b1QlIwDyjBjF8e/Of
         TYp1UGCga8by04dDB1JcSXad1ahvWY9yVoDyakNO1Lto0aDtOlOrjfkyDiqt/pEZMLL8
         JVA0oaRmy/QOLUuiVwIu6byn1qOUFEVX7jSCmGoQVNAJn3md0b1fGMfJWl1swbUTWETl
         L8nB7A0s5BEaaoq4NPK/uXb0YTscsSNFBu/mOYTOLzmcmaqqPZTp1AHUkpNANDdDVpHu
         bfXm5cn5+VL3NwdQx4/6ejo8IYXcYSX+jjEF6K68loFdoOLDvOhlhc8xd1I9EdbCBgZD
         zgGA==
X-Gm-Message-State: AOJu0YzPkRHmVHjzB9miHOb3mjHGJtS0LjGn/BjNqwDSreMrBmjeMRSb
        BnnzI0Q9GbfXguvQb03CNuU4Dr+Y5lIr9j9Aht0=
X-Google-Smtp-Source: AGHT+IHxzkAXBfNJDNcknbZH6tlIYjJNFyXEZDfCnRpxQMJVfuN4V6svYqKu4KC6ef0+KBpYIwyrmA==
X-Received: by 2002:a2e:9f4b:0:b0:2b9:3db7:322f with SMTP id v11-20020a2e9f4b000000b002b93db7322fmr8508153ljk.18.1691492178941;
        Tue, 08 Aug 2023 03:56:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c378c00b003fd2e89620asm17797634wmr.40.2023.08.08.03.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 03:56:18 -0700 (PDT)
Message-ID: <d7cc1aec-17be-502d-47c1-3163a2766ee4@linaro.org>
Date:   Tue, 8 Aug 2023 12:56:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 11/11] dt-bindings: clock: samsung: remove define with
 number of clocks
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230808082738.122804-1-krzysztof.kozlowski@linaro.org>
 <20230808082738.122804-12-krzysztof.kozlowski@linaro.org>
 <20230808-scarcity-sprung-c0c2abc2971f@spud>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230808-scarcity-sprung-c0c2abc2971f@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 12:53, Conor Dooley wrote:
> On Tue, Aug 08, 2023 at 10:27:38AM +0200, Krzysztof Kozlowski wrote:
>> Number of clocks supported by Linux drivers might vary - sometimes we
>> add new clocks, not exposed previously.  Therefore this number of clocks
>> should not be in the bindings, because otherwise we should not change
>> it.
> 
> This sentence reads super awkwardly, not by any means important to
> change, but I'd likely word it "Therefore these numbers of clocks should
> not be in the bindings, as that prevents changing them".

That's better, thanks.

> 
>> Remove it entirely from the bindings, once Linux drivers stopped
>> using them.
> 
> I figure there are no consumers in other projects then? If so,

Difficult to say, nothing known to me. Anyway these are not clock IDs,
so if anyone actually relied on number of clocks in the bindings, they
would have trouble in the first place.


> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>


Best regards,
Krzysztof

