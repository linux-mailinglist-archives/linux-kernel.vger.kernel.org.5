Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF067A4969
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbjIRMRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241971AbjIRMRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:17:11 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7528EFE
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:16:51 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52a39a1c4d5so5446412a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695039410; x=1695644210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pNv1FDwVT3hMnnPhWO3xcQr1aUeDgxmwwA9dkUiq1gI=;
        b=qc95taDBjEAqfD4twunA1NE/fn6b2KKBIJ67SOttxLNUrL3e5YquEC5qHcm7qDijy2
         Jrb2XKRvUEgtFomNNYRz69883mWGWFPWoHUn6aNKBSBtQNDAawjufWcaVRae2DmclFC+
         +LAbuow2Mit0IRCEVorp7YvfNOf9iGj8LwVDfl7q3g9ZLDxZBjV0eABPvLkCoO3eP9rk
         f4ov9EXsK/27l6sVH5Y3VnrW5Q5d2zR3sbXAQ8c2DgVeJb2M3gh+HuhE1tHf5+ur4s+g
         JtFIoQkqbOjeCrOdXnEr6KajkcaZjWrBfDiqNXsBBNP6JQ4e5u+iyXVkepeTDl5MnZ2s
         Dkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695039410; x=1695644210;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pNv1FDwVT3hMnnPhWO3xcQr1aUeDgxmwwA9dkUiq1gI=;
        b=piceq5Ku3U8Kjr+rmHNptNoHdCh5w8tYg+LdijAgr5MW7bfIvQZXgiYi8av0hIX3ts
         Q5Z37jpV4imca3355mhEvteDT9Ea+cFN6l6TxB+1GaHM4NIiVbB/EDrIGJJHktpqwgQF
         HW01/+RGDZkKFMCDoTLq6tu0yIH84IS75yfXVL/aguqgakUgmHRZ1NtHS09rf8fhgBSb
         fMYXgzm684QiTpIZD1OLd/VAS2v6IfV3B/Bq1rvyrbIxLF9kTccPa+e3S78550zL3m+t
         30gMQNCyJdLitVR60d+Uu6Wof5m17jca70+lP8UffyOcPUhT08gtTjTqkkVQYFAnU8Df
         n+mw==
X-Gm-Message-State: AOJu0Yy039mfcK9Mg2A8pBT2ybR9N9AmOqXtcU0WQWQWdtqYw4hQRgC3
        IdC25D25ftnSxhf9cCRcfgU3qQ==
X-Google-Smtp-Source: AGHT+IHjEzmDf8sH8wfhuBGiqE680D7tr59P6K14bIMYabWiXD52tF+e9xu/8MVoljBZIxA6w9Tptw==
X-Received: by 2002:aa7:d394:0:b0:525:691c:cd50 with SMTP id x20-20020aa7d394000000b00525691ccd50mr8530961edq.24.1695039409909;
        Mon, 18 Sep 2023 05:16:49 -0700 (PDT)
Received: from [172.25.80.114] ([217.67.225.27])
        by smtp.gmail.com with ESMTPSA id a3-20020aa7cf03000000b0052e1959db1csm5962284edy.20.2023.09.18.05.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 05:16:49 -0700 (PDT)
Message-ID: <1f9cfc55-bb63-92f2-7e22-26d31ad16e96@linaro.org>
Date:   Mon, 18 Sep 2023 14:16:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 3/8] dt-bindings: clock: rk3188: Add binding id for
 ACLK_CPU_PRE
Content-Language: en-US
To:     Elaine Zhang <zhangqing@rock-chips.com>, mturquette@baylibre.com,
        sboyd@kernel.org, kever.yang@rock-chips.com, heiko@sntech.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangtao@rock-chips.com,
        xxx@rock-chips.com, xf@rock-chips.com
References: <20230918073151.7660-1-zhangqing@rock-chips.com>
 <20230918073151.7660-4-zhangqing@rock-chips.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230918073151.7660-4-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/2023 09:31, Elaine Zhang wrote:
> export clk id ACLK_CPU_PRE.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

