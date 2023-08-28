Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440B578A638
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjH1HAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 03:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjH1HA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:00:28 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C199010D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:00:24 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52a069edca6so4040064a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693206023; x=1693810823;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pf0wRFcbL4aMUzhOgl330QqnoThqb8W2rL7xxb0kxd8=;
        b=EF17grfKST859AXxoziBXteUD2v3MLDQPINYg40woqOpSLYfMkAbGRrQzLiNPFgGpu
         2lokci78mVM0kZSrt2djoIriNhK2XBIdZeA7FufxwI5xPRmbcYLUSCmEya4J4lbBT7i3
         qUm9S/CYv4WO4ECCY7IFg0MNKmuBb1qNGJAJX862tb4RfijZu6gIcOdPOqkIvIGnLn/L
         aDw3rt7WndHZmtiMWCByjpA1T06PhHuYA3luSS6NZuNzJmfod0ZFf56/UoDmLu4gOWOx
         nNM/rHxKEd/CHqOg39V4cTDYTPjYPrCSFlNJcbsmSBIFkZkjtLF3+b3Sn4n9N6AHQ3A7
         Rd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693206023; x=1693810823;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pf0wRFcbL4aMUzhOgl330QqnoThqb8W2rL7xxb0kxd8=;
        b=BzFMN1NgVC3/RAxvfxz8TFdMDeI16V1BPtr2lD7leuzsGotjyMPZMEA/62va9VLUvw
         QH02xko/aNh1v5QyGQc8lWM/sb08G7+vTxtZ6ZgXmr1iHnEo1CSbPJTIuWrlJXR3T6wQ
         BGOmti1r9d9Iysuv+A8cyotLGp2tYIw2MjVLWsJ71kCZiPe5u2dSm1WzUibBlhVZelQn
         hwP4vfRdFq51OGzGC6I/MSE8E28jS58TK1D3x1j7PxUyzz/gtyHLGyHnQpfqS/QnDJ60
         ryOSm3gRIUNBvJOw2RxOQz78UGr785+CoiLz/STTujXeGZTfLefZtBxbhmUah1b0g6Vk
         8vWg==
X-Gm-Message-State: AOJu0Yxi5nJx2OnIxZ+1LUH/V0ddagGLw05wK9jF8bJg7YU3AGR+BvCA
        gUz6CaReLbNAudqUOQb831iPCg==
X-Google-Smtp-Source: AGHT+IHJIJHbmAUXWTWOFrG36GyISApUvcmXozjbLuJzr5rzOPmIqVa1Z+iqbTN0a+JO/lztEB3ulQ==
X-Received: by 2002:a17:906:32c2:b0:9a1:c495:66bb with SMTP id k2-20020a17090632c200b009a1c49566bbmr11676537ejk.60.1693206023201;
        Mon, 28 Aug 2023 00:00:23 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id lx16-20020a170906af1000b0098de7d28c34sm4302280ejb.193.2023.08.28.00.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 00:00:22 -0700 (PDT)
Message-ID: <7859abb1-ae99-d33f-a8fc-c76304057df9@linaro.org>
Date:   Mon, 28 Aug 2023 09:00:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm7225-fp4: Revert "arm64: dts:
 qcom: sm7225-fairphone-fp4: Add AW8695 haptics"
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230827122842.63741-1-krzysztof.kozlowski@linaro.org>
 <20230827122842.63741-3-krzysztof.kozlowski@linaro.org>
 <CV3ZCVK29BLY.D7Y8AEEOYLO3@otso>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CV3ZCVK29BLY.D7Y8AEEOYLO3@otso>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 08:56, Luca Weiss wrote:
> Hi Krzysztof,
> 
> On Sun Aug 27, 2023 at 2:28 PM CEST, Krzysztof Kozlowski wrote:
>> This reverts commit 413821b7777d062b57f8dc66ab088ed390cbc3ec because it
>> was never reviewed, was buggy (report from kernel test robot:
>> https://lore.kernel.org/all/202204090333.QZXMI2tu-lkp@intel.com/) and
> 
> (I wouldn't say this part is accurate, the robot just didn't use a tree
> with the i2c10 node already present, it was sent in an earlier patch
> IIRC, but whatever)
> 
>> used undocumented, broken bindings.  Half of the properties in this
>> device are questioned, thus adding DTS node causes only errors and does
>> not make the device usable without the bindings and driver part:
>>
>>   sm7225-fairphone-fp4.dtb: haptics@5a: failed to match any schema with compatible: ['awinic,aw8695']
>>   sm7225-fairphone-fp4.dtb: haptics@5a: awinic,tset: b'\x12' is not of type 'object', 'array', 'boolean', 'null'
>>   sm7225-fairphone-fp4.dtb: haptics@5a: awinic,r-spare: b'h' is not of type 'object', 'array', 'boolean', 'null'
>>
>> Since bindings were abandoned (4 months since review), revert the commit
>> to avoid false sense of supporting something which is not supported.
> 
> I've been avoiding touching this topic again since I'm really not sure
> how to resolve.

Happens, but the DTS should not have been applied in such case.

> 
> There's a bunch of magic registers being written to in the downstream
> driver, I don't have any documentation for that so I'm not exactly sure
> what I can do to make nice bindings with proper properties.
> 
> Would you recommend just hardcoding some of these properties in the
> driver, assuming they're constant for every AW8695, even though the
> downstream driver has these properties in devicetree? Because of that I
> assumed these properties could differ per implementation / usage of the
> AW8695 in different devices.

Yes, keep them in the driver.

Best regards,
Krzysztof

