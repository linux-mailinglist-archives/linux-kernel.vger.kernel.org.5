Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48ABE7BCDF7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 13:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344664AbjJHLJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 07:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjJHLJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 07:09:33 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCD6BA
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 04:09:31 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40684f53ef3so35097175e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 04:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696763370; x=1697368170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1vYilIHh7UzhsRZJbXWjITmqBr2heFnggTX8eCFXyBY=;
        b=DDDN+wLs/RjIeuNroo8Un1QZAPrp0GAHtdOAZu07f6g67AgGQQ3UT5ERYG/lRbH5P/
         uXtPiTmokHoqg5gUOo8F/Fn9L2qucJG9nkKm/OsCRrWu8WMSsVjyLNgHBGggcuTAkfB6
         iIXs8k206BHV2XmoumqhxOsRWDZuFav54OY/IULIz2CXl0B1TQxb5mF/ub5/w+PaE7JJ
         pdGtKiPdv+i4TkV6osNivyTg5sDvTmbJam8VUkRa1OYlfVjSfO/LrJHJ37WQnNI/k9SL
         E8A63gF/l7kf1b3wIQIc74RsBWqE++Ab5f8cmGOWFRekjZUkJq7CJQ+Z4ZkuQmhLp8Bw
         4Ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696763370; x=1697368170;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vYilIHh7UzhsRZJbXWjITmqBr2heFnggTX8eCFXyBY=;
        b=wrot/T1RUbS5qGMBCtopoXxnuX0RH+naP+kwfp0cjGA+qz096qE3dxW+yJxoCgefwh
         XoKo2geuXxkK0Er1dp96PTv82sRirWysgS4wW5hB+0jSPDZpfVs2jmU4Zu+OxuzqJek1
         VLnboN5EYwvVrosbCXb2pkNxHhAp+WyUNZViwSyL/mytA06fYFNriTNj8HDxRSKLCjZF
         18f3cmthtUrLbzoDf/nnC6RplZ3FEL0b4X8PQbc00O3UNIyxU4RjNBwWznr3/TkwQ19m
         BcWQXw1CMYa1U64caWzSac4fFt2DYEEP/da0qV0zrnEEbR2h3e5Jn/ShV4pd5FWgadsB
         Gcdg==
X-Gm-Message-State: AOJu0YwXX5eY0gU2J4zEFF7qEi/RLJT4AWmHGHJV6Vv7Weq7R8YoIWM0
        S57QVaNJkolA1DqsnVLMKGRWNw==
X-Google-Smtp-Source: AGHT+IFXweF/ld2Qv2xYsyJL9P6LEsivjWo+qBqwnSsGKfkAMTTy7nrrLVXlGvF7aGgjvpNWe0YSLA==
X-Received: by 2002:a05:600c:2242:b0:401:2fab:43e8 with SMTP id a2-20020a05600c224200b004012fab43e8mr10982958wmm.15.1696763370076;
        Sun, 08 Oct 2023 04:09:30 -0700 (PDT)
Received: from [192.168.1.197] (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id k14-20020a05600c0b4e00b003fe1fe56202sm8301853wmr.33.2023.10.08.04.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Oct 2023 04:09:29 -0700 (PDT)
Message-ID: <a17782be-6c77-4e1f-b991-2015ee216c68@linaro.org>
Date:   Sun, 8 Oct 2023 13:09:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 00/10] Add multiport support for DWC3 controllers
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, ahalaney@redhat.com,
        quic_shazhuss@quicinc.com
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <d4663197-8295-4967-a4f5-6cc91638fc0d@linaro.org>
 <75db183e-3c47-48e4-ad29-fea785826109@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <75db183e-3c47-48e4-ad29-fea785826109@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/2023 13:01, Krishna Kurapati PSSNV wrote:
> 
> 
> On 10/8/2023 4:13 PM, Krzysztof Kozlowski wrote:
>> On 07/10/2023 17:47, Krishna Kurapati wrote:
>>> Currently the DWC3 driver supports only single port controller which
>>> requires at most two PHYs ie HS and SS PHYs. There are SoCs that has
>>> DWC3 controller with multiple ports that can operate in host mode.
>>> Some of the port supports both SS+HS and other port supports only HS
>>> mode.
>>>
>>> This change primarily refactors the Phy logic in core driver to allow
>>> multiport support with Generic Phy's.
>>>
>>> Changes have been tested on  QCOM SoC SA8295P which has 4 ports (2
>>> are HS+SS capable and 2 are HS only capable).
>>>
>>
>> I think I said it few times on the lists to Qualcomm folks, although I
>> cannot remember whether exactly in this patchset. Please split DTS from
>> USB, because Greg prefers to grab everything and DTS *should go* via
>> Qualcomm SoC.
>>
> Hi Krzyztof,
> 
> Apologies !
> 
> Do you mean to send the DTS just to linux-arm-msm list and not linux-usb 
> list ? 


Not entirely, I meant to create separate patchsets. One for USB drivers
and other one for Qualcomm SoC. The DTS patchset should have link to
lore to USB drivers patchset. You send each of the patchsets to
respective maintainer, lists and everyone necessary using b4 or
scripts/get_maintainers.pl.


I don't think it was posted on this series and I am not on
> linux-arm-msm mailing list, so missed that comment. Sorry for that. I 
> saw some series where DT, Driver and bindings were sent as one set to 
> linux-usb list as well and so wanted to follow suite. Will make sure to 
> send DT just to linux-arm-msm list from now on. Thanks for the comments :-)


Best regards,
Krzysztof

