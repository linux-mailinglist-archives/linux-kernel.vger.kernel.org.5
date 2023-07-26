Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FD9763622
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbjGZMU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjGZMUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:20:24 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953B113E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:20:23 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98e39784a85so202059866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690374022; x=1690978822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OnqqKiV/ROZY/0GDhQOQbG/HM4kkWyyFE6/skzOqAXE=;
        b=q44rAZeDdRYJssDalYSZp14Jz1I1FNuACshbpM5tjsJMMTV16VFrm0iNrFkz/n8sC4
         aBEMFBtRgCxkGKUla/qTw6qMv7WZBe/svWHBVT1ZaaoKQksXNiAue8CJX6CuAR1VGJ3e
         m+0YBcbw8k08qkpEx6WuDuBK9EuoYmcT6mx+Zv4+eVo5Y/rh2DVHM/AbFkmYA3LLBymg
         bvbNcEffWI8/zddezdxTdMQiI92IjnyDf4r4k8yQLburK2+j9kc5SLG+MukfzapOk+Ro
         GSqRS2JL04TPbXM8Hw32O/nKiyDfefHpMXlalxNuejDCo8+6lI2yy7twYD4acxpJnnUt
         JrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690374022; x=1690978822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OnqqKiV/ROZY/0GDhQOQbG/HM4kkWyyFE6/skzOqAXE=;
        b=MHArASzraJKEEj9k3uksM/uVNDo6Gd8EVUa+uJzlSOqtcIMI5wAPoMFNOSBjgm+2VP
         8c5MvblPLVpareaKtgfc5NxZCAdtD4CSuyYABElIR0/DYOyJ5+uhhMyyuiPDu/u/JfYr
         fDV2Zgs2yGHwMbnRnUv4PNAKbIrnNu7hsdG5xmwRQOZIQA9+gET86wPxSPn9bz/nv+Y+
         cwvdtCQ7SqZw2dVs9RmfvrAKI9yYIdLSTKPxr/mp/p+4RYVOQX528AEVE6ZtTbyctCxY
         neqj0EnIL789wkUXOH2oiNBrLVa+L8Avz9JYUKhzouU+xYJjFwNFSVdvw75CYd0AaSRD
         Lu3A==
X-Gm-Message-State: ABy/qLZswIfacZqYZWa9Fjsh2Er5SCj369dY+n8BdPNY09JO6roAeiaI
        1CEq0BAhqccxjrLqgXA94l1psA==
X-Google-Smtp-Source: APBJJlHwVDkfg3jPDdHzfW05jPl3iAz0LqDc+HFNfu7tPIdQ7l2h+zW0hN0TBayRq6ilsIuIiXtFjA==
X-Received: by 2002:a17:906:53c3:b0:994:1eb4:6896 with SMTP id p3-20020a17090653c300b009941eb46896mr2296542ejo.25.1690374022094;
        Wed, 26 Jul 2023 05:20:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id x17-20020a170906299100b00989828a42e8sm9497680eje.154.2023.07.26.05.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 05:20:21 -0700 (PDT)
Message-ID: <11620112-ffe4-8df1-6b38-0f3082c5d16f@linaro.org>
Date:   Wed, 26 Jul 2023 14:20:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] hwmon: (hs3001) Fix unused variable compiler warning
Content-Language: en-US
To:     werneazc@gmail.com, jdelvare@suse.com, linux@roeck-us.net,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>,
        kernel test robot <lkp@intel.com>
References: <20230726113605.13966-1-andre.werner@systec-electronic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230726113605.13966-1-andre.werner@systec-electronic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2023 13:36, werneazc@gmail.com wrote:
> From: Andre Werner <andre.werner@systec-electronic.com>
> 
> Delete unused variable in drivers probe function.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307261819.VMDuxZOM-lkp@intel.com/
> 
No blank lines between the tags.

> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>

Was the original patch actually merged? I don't see it in next.


Best regards,
Krzysztof

