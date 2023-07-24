Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF0875FCFC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjGXRPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGXRP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:15:29 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD378E64
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:15:27 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so6911057e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690218926; x=1690823726;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tx54cOY+neWzrvf0/88Ir6VNDJKus8S+yogDkessELg=;
        b=axrbNQcYXXe3XWxYcPXZfywT+d4YRo9PRJmGLrntnHvpWQCYeePb0FQh633zalGec8
         C1P2FpDDng2IIyye73IVibZhfsHcni3GhQaoJ/hRtsM7lsUtOUh039jB0RXNz6souzNZ
         xEQDt1p/MyPMkTwAmWbT0pwPc5GrQMccqLB9YwWJyGOZVxUScgsoGZu1aUBx+2W8RfBN
         T11/y4zxkNStzdTOpENm5bBJ3FtlRHbjmT+C4oN28Bcigw/82QiDIkUWfD4y9DwY6IEN
         U3QXG+LNXZ1i0NYf6BOn9tzh2pom+sY9x2tY66XFvuf+4zlFymtdgsiJjxCb1Uf8ppdp
         aKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690218926; x=1690823726;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tx54cOY+neWzrvf0/88Ir6VNDJKus8S+yogDkessELg=;
        b=O1d1xZZlrFoid8VKISxdRPrZe5LoV4sgGqtH20hEQRvGCh6N52o+fLrLubtB+eDTPv
         m+jh6bD7rKnCyu0UnteZv1JEsS1O/SLJMSto0ohyDKVJDe4ZMgtmB4h5I8QSBCYerVYa
         lbYQUThvuaoQb2c92TdZS5x6oIg0uzHprx8n+eFLE6Xzu9cYunaMwKOVQ3X3E6Iww1SD
         afq0e33NKAq6/ZSveK7E4HN89mqVYhl/TZqZevNwYhiiWsZq/zwywEB+X2mr7j0d+Rej
         k3yHFAY/CJ8kjecvuop9+XggJFg76EHteNvVuVGgKwrawgxoIT6jb4MVFot7wHkvmDcU
         BzsQ==
X-Gm-Message-State: ABy/qLasgEY1sFP5v6jseqgnqWn5wCfZTa9SHmd3aS9MQSUP6ouix6fM
        iNMGWhJ/gMuCTtlfkeFsNH0hLbiDG7ARPfn0sQf64w==
X-Google-Smtp-Source: APBJJlHe8pLXiLrwGLxil9/si6KhJS7OlHyG5NCZrIzE8+xVOfSNKHouT+DLprz+aqmn0hYgLD9+ZQ==
X-Received: by 2002:a19:8c59:0:b0:4f9:5592:7450 with SMTP id i25-20020a198c59000000b004f955927450mr6127528lfj.23.1690218926146;
        Mon, 24 Jul 2023 10:15:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id c5-20020a056402100500b0051dd19d6d6esm6504714edu.73.2023.07.24.10.15.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 10:15:24 -0700 (PDT)
Message-ID: <e76df506-4c8c-aaca-93f8-807f09a23613@linaro.org>
Date:   Mon, 24 Jul 2023 19:15:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dt-bindings: input: convert syna,rmi4 to DT schema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Vincent Huang <vincent.huang@tw.synaptics.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230720110008.133359-1-krzysztof.kozlowski@linaro.org>
 <20230724155802.GA3609728-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230724155802.GA3609728-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2023 17:58, Rob Herring wrote:
> On Thu, Jul 20, 2023 at 01:00:08PM +0200, Krzysztof Kozlowski wrote:
>

>> +    required:
>> +      - reg
>> +
>> +  "^rmi4-f[0-9a-z]+@[0-9a-z]+$":
> 
> a-f in both places.
> 

Ack

Best regards,
Krzysztof

