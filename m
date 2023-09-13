Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA6579E7A4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240284AbjIMMKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239172AbjIMMKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:10:46 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B9919AC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:10:41 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso116990011fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694607039; x=1695211839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SQIM+kqMG9ytOOMoiN7yuL7xJYjBwxdRQr4Do42aFXE=;
        b=mCdOxodGzfbOAhIXjY+KogNqwrxUJr5TxT7bHhdDnhclvsBUSgcBB9B/r6bqqAwH9L
         V/1K4u1NkWPtirunMj9/2TzQ2yZmhNgy/wlUzyc2FXjbdLqaAewnZcyx5fYwav8ufK/J
         FSyFmKv3g0vLYph9rwUT4IQmJ3lSKCFZR2T1wDuj6nOuQ+FhO7Ey3JvKpjmvFdRyZ2rH
         NTtJ7cNY/tFTFSbsbhNjML2YMKT+6aHZ3CJwGJZBDwcgdhlfuUoGNzEwfkehWODLsztZ
         qmg0saGEs6qH4l2AO2L0dbhQ/qpiZrdOS68eIT+mtPYuQ5NqPpc/m4hXO0Ayaii8HtgS
         1xQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694607039; x=1695211839;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQIM+kqMG9ytOOMoiN7yuL7xJYjBwxdRQr4Do42aFXE=;
        b=xSYkxpf3H4iuOtup+d371exNBF5mqPE7rf6YYxvLQ9c33IbmHYhOy6xyoHazL2vwHY
         rm8NcsFKB21/hT5KRdCXkpMFiLddywOxsL0ED3kSYf5UaXrZ7ssUXt/QmZXEPZ/g3yaa
         i/TnOhjQBjBN+tkK8zqT4gKLc3nh/Sa68Uh+KgXxM7SGa8fvFc3euJM5si+JGvyJ6MMq
         /wmm+tUMJbJqufzx9/7qXwPbHU0OVzCniuEd2nEVIIIRvjAA4vjYJBJ5eS/FUiTbR6kk
         pWRmlcBnS4D38Ef3gkoqJQ5hwhqDGYzgXiBf+iqjTs6AKUTN57Bz+JuSg5L3G/EZ1AG9
         qs5g==
X-Gm-Message-State: AOJu0Yy5Mjo3Isoz11CLZn1VtRoHE/lqLK4zlxXRmRw6W3ZDKtsE0sRW
        RclIZCIFv/IwN9B2DNVY3IIvLnFL+9LhCqPAphX+lA==
X-Google-Smtp-Source: AGHT+IEHVECWvv1uWhyOqRUFyoZhQUOvMAPZZoteTJ5oOo8s3pvcNbh9qxE07ML7hsTq55A+nMZokw==
X-Received: by 2002:a2e:9606:0:b0:2bd:2260:46ab with SMTP id v6-20020a2e9606000000b002bd226046abmr1943754ljh.50.1694607039359;
        Wed, 13 Sep 2023 05:10:39 -0700 (PDT)
Received: from [192.168.37.232] (178235177106.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.106])
        by smtp.gmail.com with ESMTPSA id p21-20020a170906229500b00992b8d56f3asm8319579eja.105.2023.09.13.05.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 05:10:38 -0700 (PDT)
Message-ID: <3920bc96-fe58-4e3b-96ab-706f00edb2ee@linaro.org>
Date:   Wed, 13 Sep 2023 14:10:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 13/13] arm64: dts: qcom: sa8540-ride: Enable first
 port of tertiary usb controller
Content-Language: en-US
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, ahalaney@redhat.com,
        quic_shazhuss@quicinc.com
References: <20230828133033.11988-1-quic_kriskura@quicinc.com>
 <20230828133033.11988-14-quic_kriskura@quicinc.com>
 <f19fa545-0ccb-4670-af77-7c034b1016ef@linaro.org>
 <e7bd3aa9-b8ee-4b8a-2354-e786f9a9ff47@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <e7bd3aa9-b8ee-4b8a-2354-e786f9a9ff47@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.09.2023 05:36, Krishna Kurapati PSSNV wrote:
> 
> 
> On 9/6/2023 10:28 PM, Konrad Dybcio wrote:
>> On 28.08.2023 15:30, Krishna Kurapati wrote:
>>> From: Andrew Halaney <ahalaney@redhat.com>
>>>
>>> There is now support for the multiport USB controller this uses so
>>> enable it.
>>>
>>> The board only has a single port hooked up (despite it being wired up to
>>> the multiport IP on the SoC). There's also a USB 2.0 mux hooked up,
>>> which by default on boot is selected to mux properly. Grab the gpio
>>> controlling that and ensure it stays in the right position so USB 2.0
>>> continues to be routed from the external port to the SoC.
>>>
>>> Co-developed-by: Andrew Halaney <ahalaney@redhat.com>
>>> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
>>> [Krishna: Rebased on top of usb-next]
>>> Co-developed-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>> ---
>> Is there any benefit to removing the other ports?
>>
>> i.e. are ports 1-3 not parked properly by the dwc3 driver if
>> they're never connected to anything?
>>
> Hi Konrad,
> 
>  Whether or not the phy is connected to a port, the controller would modify the GUSB2PHYCFG/GUSB3PIPECTL registers. But if we don't specify only one phy and let phys from base DTSI take effect (4 HS / 2 SS), we would end up initializing and powering on phy's which are never connected to a port. To avoid that we need to specify only one phy for this platform.
And does that have any major effect on power use?

Do these PHYs not have some dormant/low power mode?

Konrad
