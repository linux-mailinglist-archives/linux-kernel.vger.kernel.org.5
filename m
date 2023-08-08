Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9713F773EE5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjHHQii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjHHQhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:37:45 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09D414FC9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:53:37 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-522ab557632so7759764a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510016; x=1692114816;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aScjTZP/j4eF5nEY5ptSyTPcH9eKHlG6UgnJ/+6xLjo=;
        b=nESm3dstvv4+h2yK3mV7sgtTB97KPUaH1sWkyIuOay8fjRF91wQ3gSxlPvosuHxTjf
         NbXvwztiGkkPQAh9LRT08CuQs5J43nNPT2mDGZlZW7tqoFItrSFsVJFdTyVAWOq+AtU5
         VEieBXERJiYZiiaV2aZ7NLwXd2QP0t0ho27464pzJx3XhE9WnCclrwQ+c7xPxxhcgJr/
         nzc+13mc1NWCNy6Q9rONJ86qrtZ6yWLAfVGJJ3CXBn7TXexFNg6zSNix5AcsociIj/+h
         lGU7rxGf8D9m0hzemzJ8ADiJyS6T2HXE9FOWiFT7BUo9q5YWMN5gnZY+rBbn7sXSpFtR
         xpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510016; x=1692114816;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aScjTZP/j4eF5nEY5ptSyTPcH9eKHlG6UgnJ/+6xLjo=;
        b=InEp9lTJen7fDdu2D2YBnmj/xcWtJ57HdasExcsXuRv9sa3i12ozZ4b+PaXxv4ZhV7
         uhbzweibpBa7wl2OmZyJPFQTNFVN0hQdpImxP+uTtfHU5oHmIl++vT9HiBCCOK9IVTh5
         L5m+XdM76l50f9vGWER9Pggngq8Ggo/ucLbFKJ6X2/SCTZ+73D2CkC8D1rHR0r7O3jYc
         3HphbJJfjjxk5DQ/Sq3i3A1pOHAyyTCuePKGAyAq8ZW89erThEKwXFGwq3Yk0cWyM+Vv
         dt0E5gcWzRzLmWmqkgBXNrf5V0TeketgPPJ5wtlSsM2h/aKklQXgy0d+KKtIXvY/NjX6
         vD3g==
X-Gm-Message-State: AOJu0YyPlcblLbweztQvfcFAn4Q80a9vuwofmxMKf+KVOHTZ6fIXXImE
        35CypV9e6e8By/aw8kjxVC+J3zomSUq7ThxUVI4=
X-Google-Smtp-Source: AGHT+IFUhtTnBdD3FE71/pNMOY1Y6z9Jbo+5Bg4ogyJrOop4Rz6UyiKZoppLw28xBiaeF1YEdhU0VQ==
X-Received: by 2002:a17:906:3f4f:b0:99b:5a73:4d09 with SMTP id f15-20020a1709063f4f00b0099b5a734d09mr10065794ejj.43.1691474274417;
        Mon, 07 Aug 2023 22:57:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id gs10-20020a170906f18a00b0097404f4a124sm6146765ejb.2.2023.08.07.22.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 22:57:53 -0700 (PDT)
Message-ID: <d28cf9c5-b914-053a-76df-c15e191c042d@linaro.org>
Date:   Tue, 8 Aug 2023 07:57:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add NanoPC T6
Content-Language: en-US
To:     Thomas McKahan <tmckahan@singleboardsolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230802051441.3106-1-tmckahan@singleboardsolutions.com>
 <20230802051441.3106-3-tmckahan@singleboardsolutions.com>
 <f49a803f-9ff4-794e-265b-a98e3711cca8@linaro.org>
 <20230808002751.00001385@singleboardsolutions.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230808002751.00001385@singleboardsolutions.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 06:32, Thomas McKahan wrote:
>>> +
>>> +		regulators {
>>> +			vdd_gpu_s0: vdd_gpu_mem_s0: dcdc-reg1 {
>>> +				regulator-boot-on;  
>>
>> Boolean properties are not first, but last. regulator-name is the first
>> one. This odd style...
>>
> 
> I agree, however it seems the norm in Rockchip devices. This will
> become an outlier in Rockchip but fall in line with the general case.
> I'll put it in V2 with the other mentioned fixes unless a conflicting 
> opinion is expressed. 

OK, no need to change then.

Best regards,
Krzysztof

