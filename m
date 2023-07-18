Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CAB757AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjGRLvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjGRLvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:51:45 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCFDB3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:51:44 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52173d4e9f9so4810245a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689681103; x=1692273103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3quue5muaabi4CozXaKq5cpAvjxqIHPBQ6qXUTBWbdw=;
        b=ai7bmqZWsoaWrpXI4H8t8ZMrZD7gYqG8TxIaP6A/L/kVtcTnV3PDNmK7VH1sFevrn4
         pHZiJp2X6jGyxaaHBuB1/HjuHO8HCfWE5CFmt2QoXooyNuTL8mgOBUHtHhhDfcVR40p/
         3nSifm44M09L5YisCb3cyB5olsUuOx+o5WH9gElgndkdtR1pTRnMqI/tp0yrzI7vZEBa
         o+IhS3jFBmJSo33v6lDFeMbClfSfmu/1bVJ6cxadTubj4bNhYhywI6fEN/HEprvlcjf0
         ZLY4mKnS4vFVx7r5DVL9BsL4g41wko3/QBY3GKAMhFTsWCq2rJUp8xb1X7He2pX+PapL
         5Y7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689681103; x=1692273103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3quue5muaabi4CozXaKq5cpAvjxqIHPBQ6qXUTBWbdw=;
        b=YvDkttht+4P6sVH5vbtKlpKyEXbxEBv/SEgp1xbNqNql6/ciI863TCOOCCcKTttwxh
         ZDv/Y+n4CiJIa/p9WVm0cT9BYqT6GCZp/3LZfFHfOVWvxhRviLgdCmxzrQ1fVpuxADVT
         nYGS714U62ouQqLxLm5cWNHAwALauJGDg85lwg98qtwp5jVbId49F8L+eOWzk175bL3K
         bs8RURnesER2OrA2S9zwJAeceFnNUcE8OIHxn7BqzQwA8pzNinbZmmcv8stvjmHhRfGc
         zguWefDkVyQw9+HaEqGFuNKQFfCQQk/7BbnjOHdk5/USGRG13hp+VOUKbB19XVfpA2on
         j1VQ==
X-Gm-Message-State: ABy/qLaTh9EbTgtsIyebEvrXBMNhu4AkqLS2D1FuLEBDi5rIV3BBOR+Q
        vSu+BprLmSqCVjfhVrpDxZldfg==
X-Google-Smtp-Source: APBJJlEPo8s5sbjPHwSDG/7oatXTr5mKLCpvbizDsLHDd6nf2YqkStcYaR8mA4ooxcBG7nnqL/dqUw==
X-Received: by 2002:aa7:c6d3:0:b0:51b:d567:cfed with SMTP id b19-20020aa7c6d3000000b0051bd567cfedmr14504401eds.5.1689681102733;
        Tue, 18 Jul 2023 04:51:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id c15-20020aa7df0f000000b005219de74217sm1110977edy.43.2023.07.18.04.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 04:51:42 -0700 (PDT)
Message-ID: <5cc44894-2309-b432-72e4-e65bcebb2b06@linaro.org>
Date:   Tue, 18 Jul 2023 13:51:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] arm64: dts: Add node for chip info driver
Content-Language: en-US
To:     William-tw Lin <william-tw.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230718112143.14036-1-william-tw.lin@mediatek.com>
 <20230718112143.14036-4-william-tw.lin@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230718112143.14036-4-william-tw.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 13:21, William-tw Lin wrote:
> Add dts node for socinfo retrieval. This includes the following projects:
> MT8173
> MT8183
> MT8186
> MT8192
> MT8195

Please
wrap
your
lines. :)

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

Anyway, your commit suggests even more that you add driver. Drivers do
not have place in DTS nor in bindings. Your code in patch 2 is very poor
quality, so considering this "driver approach" I think you just send
some random downstream driver. Don't.

Entire concept is NAK.



Best regards,
Krzysztof

