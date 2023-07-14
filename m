Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE5D753076
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 06:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbjGNERO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 00:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbjGNERN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 00:17:13 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FC2272A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 21:17:11 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbc12181b6so14291835e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 21:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689308229; x=1691900229;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xB/IGZDPnnKzBMS/uR9nCWt1rTBAIheIt2NnWe/dYHI=;
        b=UNYIAl0vsymRIV81hpbAM66PgpgMTE89AFouUWLP1w1RraUDKL9AvjeiYIumNQwc29
         svyZaYTBvy/b1O7qxhoTGLCGlueRkm90gCIbBaj+ctopiT9P0fp4UaH/VdEkk8uBKNam
         pnoa7lhg4Re/qsnUu/tH8l/aRlpa3sYXkDZLiz49CID4eOdzRIcuZdWPPRltQ0XA5Jzo
         fUeH6GdsYvrJgdKZUzbsFcpXbR3kritk4CX7KtLt11FWVerJPuoNNMDGG96a/dRUXnP+
         SAAuKA3n14tOiSVYjJkH1almbhqT1yOXW5cQF/2UX+yq9CC6zUGeSf6yZw52IPaCruYU
         Uv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689308229; x=1691900229;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xB/IGZDPnnKzBMS/uR9nCWt1rTBAIheIt2NnWe/dYHI=;
        b=dd7tjvybp+Ffs82xEzU3pDVTb0ZkYY1RlUkjkBu43viQsiuATPxWB5NeLNmta/JKSv
         Y7nAphiAZ4FgnDsCVCa1ZpvZc4KVjk3+Mw+6A2LurlXyMHHfuKOrCJ//pwjH3KqDDmGw
         5VpHwnqLKDRJvm80NI1DhW5E1hHc4W0gxwfiGEc0J8s7YpkcpGI8zfWKyL3jK60+0Wrf
         wM5Y7nKF1O3pB8/U4MBq8rcy5dOzna6iSQticORj6fJKHuk8EPc5TLk8nPBcAvX42myL
         T+gw5T86V1G8mfSrOO6MKBqAFBQyboM4HEfGChLnElbrAwogzWO7vO8LgMMs7PcqZ14j
         JRjA==
X-Gm-Message-State: ABy/qLZQw14tWRGSZu9pnb15hQ4P0L14nd95zynLbDsyhNurePMrq7tB
        ADUg9zONT7BlPmXTzxuYjvAyQw==
X-Google-Smtp-Source: APBJJlGMTT+Q4sPyu75nqGgHG+kkV8epB2p2rGKmjJwUcZIt6Tzxsk9RJHs91dM0VdrCYvMc8ap/lQ==
X-Received: by 2002:a1c:7c0b:0:b0:3fb:ce46:c0b3 with SMTP id x11-20020a1c7c0b000000b003fbce46c0b3mr3107048wmc.35.1689308229457;
        Thu, 13 Jul 2023 21:17:09 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id z16-20020a05600c221000b003fbaa2903f4sm480617wml.19.2023.07.13.21.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 21:17:08 -0700 (PDT)
Message-ID: <391132d5-de6b-8208-8996-bb3db250d9c4@linaro.org>
Date:   Fri, 14 Jul 2023 06:17:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dt-bindings: net: xilinx_gmii2rgmii: Convert to json
 schema
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Pranavi Somisetty <pranavi.somisetty@amd.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, michal.simek@amd.com, harini.katakam@amd.com,
        git@amd.com, radhey.shyam.pandey@amd.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230713103453.24018-1-pranavi.somisetty@amd.com>
 <f6c11605-56d7-7228-b86d-bc317a8496d0@linaro.org>
 <a17b0a4f-619d-47dd-b0ad-d5f3c1a558fc@lunn.ch>
 <ebd30cd0-5081-f05d-28f7-5d5b637041e4@linaro.org>
 <cd0fb281-b621-4d6b-be94-be6095e35328@lunn.ch>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <cd0fb281-b621-4d6b-be94-be6095e35328@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2023 21:30, Andrew Lunn wrote:
> On Thu, Jul 13, 2023 at 08:53:34PM +0200, Krzysztof Kozlowski wrote:
>> On 13/07/2023 17:59, Andrew Lunn wrote:
>>>>> +examples:
>>>>> +  - |
>>>>> +    mdio {
>>>>> +        #address-cells = <1>;
>>>>> +        #size-cells = <0>;
>>>>> +        phy: ethernet-phy@0 {
>>>>> +            reg = <0>;
>>>>> +        };
>>>>
>>>> Drop this node, quite obvious.
>>>
>>> Dumb question. Isn't it needed since it is referenced by phy-handle =
>>> <&phy> below. Without it, the fragment is not valid DT and so the
>>> checking tools will fail?
>>
>> No, because the example is compiled with silencing missing phandles.
> 
> Ah, thanks.
> 
> This is a rather odd device, there is no other like it in mainline, so
> i think having that PHY is useful, even if you think it is obvious
> what is going on here.

For almost all other devices in other subsystems we do not provides such
nodes. The "ethernet-phy" node should be obvious because nothing else is
expected to be in "phy-handle". However, if you find it useful, then I
am also fine with it.

Best regards,
Krzysztof

