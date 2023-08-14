Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B009277C0F7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjHNTle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbjHNTlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:41:20 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FD210FA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:41:18 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe2fb9b4d7so42775935e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692042077; x=1692646877;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UlkRphW99TUQjmsLQhZVnE2TXQQ32GbCiM/RRZT7IL0=;
        b=TZwIG9hlRrAaevAKoGITPcyiUCy9/dOP/RfJNRnD8rCEY64TEMkk1dqlPM88cKrDTL
         ueDj5TjLkeglROwOO1zYus7MaMO4aNSAJe/9LcPGePJ71h36Eouy0oy5szJLNsOVKtWJ
         2uYPscPayIA4YVZQkW+l93f+FkVSF6F5FFw7L9RJrNmi1hEgKtFi525ZzwIOMJROdXow
         Hgqe4mkM44ZGY7ug7OqQsg+DXxBVFHRzMjJysZHirpqG6dExNur+J23TX+dm6JeTkG0b
         mxekx1U6HHryASrvDDhOfQsgzxid0fa7ZTyGhqSID+mArig9aA5gyNtStjGA7wzYRl7I
         /DuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692042077; x=1692646877;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UlkRphW99TUQjmsLQhZVnE2TXQQ32GbCiM/RRZT7IL0=;
        b=UC3t80QS6rK2jvji1jCMQxjj2O+lyOBpm9zsrd0qL/TgNs8YOHBit8PgXQs0WAHLk6
         NHJ863xudB1uCaKhUPKF2M3oh0+yYjAD2I6/iJJ4CyCutcykWDNb+5VZZ/Bs6Wpnhjas
         eWIfd3ll1Z3fFiI/B4dpRtvdCwl8L4eg44Y5si8Qyw0DZjcqf4lMnhuhs8h+c+AOOlwL
         TadCW7V8xlsGAbBKPSxZOhjCHJOrdwcjpyXlnkqNgBPbpR+t0k/FLxjyvGL0kX1BZuPH
         jgrIVOkVKGrdcEoRo2VS/+jklIv8Gt6BUzfEmFTCv3ezh2lriBVjWtlyh6oX/0VsOTdE
         LrDg==
X-Gm-Message-State: AOJu0YzBCocygu/pry2OroYTWu2Fbo+ytJmdnTUvlPxCF8HsarPPZB0E
        V4TG9HdSb5yPo9T4zT2k4esaFw==
X-Google-Smtp-Source: AGHT+IF5YrLzgnKux/XfX0ddvCVBGHZoDjc5aUCzOkanpW7tRsK6Gst2cYveMpl0sstGRpKdZK++WA==
X-Received: by 2002:a1c:7717:0:b0:3fb:dbd0:a7ea with SMTP id t23-20020a1c7717000000b003fbdbd0a7eamr8370041wmi.37.1692042076983;
        Mon, 14 Aug 2023 12:41:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id k13-20020a7bc40d000000b003fe1cb874afsm15043180wmi.18.2023.08.14.12.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 12:41:16 -0700 (PDT)
Message-ID: <1ada88be-45db-1f38-5e08-daf4b544bb6b@linaro.org>
Date:   Mon, 14 Aug 2023 21:41:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 4/4] arm64: dts: fsd: Add Ethernet support for PERIC
 Block of FSD SoC
Content-Language: en-US
To:     Sriranjani P <sriranjani.p@samsung.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, richardcochran@gmail.com,
        alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        mcoquelin.stm32@gmail.com, alim.akhtar@samsung.com,
        linux-fsd@tesla.com, pankaj.dubey@samsung.com,
        swathi.ks@samsung.com, ravi.patel@samsung.com
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jayati Sahu <jayati.sahu@samsung.com>
References: <20230814112539.70453-1-sriranjani.p@samsung.com>
 <CGME20230814112625epcas5p1e1d488a590bfc10d4e2a06dcff166037@epcas5p1.samsung.com>
 <20230814112539.70453-5-sriranjani.p@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230814112539.70453-5-sriranjani.p@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2023 13:25, Sriranjani P wrote:
> The FSD SoC contains two instances of Synopsys DWC QoS Ethernet IP, one in
> FSYS0 block and other in PERIC block.
> 
> Adds device tree node for Ethernet in PERIC Block and enables the same for
> FSD platform.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Jayati Sahu <jayati.sahu@samsung.com>
> Signed-off-by: Swathi K S <swathi.ks@samsung.com>
> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
> ---
>  arch/arm64/boot/dts/tesla/fsd-evb.dts      |  9 ++++
>  arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 56 ++++++++++++++++++++++
>  arch/arm64/boot/dts/tesla/fsd.dtsi         | 29 +++++++++++
>  3 files changed, 94 insertions(+)

Looks duplicated.

Best regards,
Krzysztof

