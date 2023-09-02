Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2072F7907A1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 13:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352060AbjIBLps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 07:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352049AbjIBLpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 07:45:44 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66F010F6
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 04:45:39 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bd0bc8b429so50156801fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 04:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693655138; x=1694259938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zorMJs2VMBIVf26DDqKbZ6mYOJqpHE4v3AzFjSkIo58=;
        b=C0VvNqwy+HFtsTOr0QwqPfaErpnJ+j+gbK+OgW5cm8ltddV0QZzA7EHkoRC0OZf5SR
         rNU8NR/WmaKCdy8A/hKkysdtTlVFdesRIBgA/UASNPamtiTP2KtDTRBMhlaeT8YLdehX
         TX1gF2g7KRZBBSE4OfaWG35xZGNzWFX0+Vv1RcZgH7ONyqsKxeggXkb16H4iHsZgXTkv
         d2xg8J2UXSSbA9DkSVIyE4lAE/EJq/bFI2B8e9bwML/vMg2+HQA8tm20C5TzFl6zYUUt
         uxHkBwsSdws+/5gDBNvz+LqVZuU6KnrF3wOtnm0DRJmPtVkUKEOw3yxiJvmD6/xYGAki
         zvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693655138; x=1694259938;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zorMJs2VMBIVf26DDqKbZ6mYOJqpHE4v3AzFjSkIo58=;
        b=V9L+dASZ+X6IhKfd+ZzEfrYVTVz/+IkPlTwxv5lrXMg/ft7ISVSZbF2mt86/8XzIR0
         1yVvNMwkWTIsBUP7V/tj4cbZ/LbPUI0NSgCy10o1vaxQfa1yhSa5Q3gda8zPsNvBIvk5
         IgWFdWLzPJFrVB/wK2qB5AaD94XhFFOJNcU/VplfhFn1xbppOVoRgGO5yIb+6odB7O1b
         CPE1N9G6DpNNndiKKVIcspPBjtw0R/1FuiPBgfmfQ9O+8WRXTmW6MlRo2pGGqs+QCTBX
         B98iZFYx4cFoE6ABYwQtmfwG+ao1cOjkqDoS0/gYLzxBXexuGIENfLdnepWrl0rEFtmc
         onfQ==
X-Gm-Message-State: AOJu0Yyt+cgS22lIBXFV8oVD2QNVqDqo51YVr12D91UmzusJNokTe6Rd
        6LN+4WC2vM7bVIZFDg6pAFwNww==
X-Google-Smtp-Source: AGHT+IFqP05K7+DSnGRKSlA7ReM081tFrZrwpnWX1jlZNOk+CT3xMfqqzeSpSMMca0sSWBFoIRRtUQ==
X-Received: by 2002:a2e:7d18:0:b0:2bc:e1a3:fbaa with SMTP id y24-20020a2e7d18000000b002bce1a3fbaamr3630421ljc.22.1693655137988;
        Sat, 02 Sep 2023 04:45:37 -0700 (PDT)
Received: from [192.168.1.101] (abxi170.neoplus.adsl.tpnet.pl. [83.9.2.170])
        by smtp.gmail.com with ESMTPSA id v2-20020a2e9602000000b002b9fe77d00dsm1168719ljh.93.2023.09.02.04.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Sep 2023 04:45:37 -0700 (PDT)
Message-ID: <5f05c76e-e74e-4954-a729-3ed2a1d33605@linaro.org>
Date:   Sat, 2 Sep 2023 13:45:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] arm64: dts: qcom: qcm6490: Add device-tree for
 Fairphone 5
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
 <20230830-fp5-initial-v1-11-5a954519bbad@fairphone.com>
 <72c2fd33-613b-49be-b394-0663f459f0c5@linaro.org>
 <CV7NGPVH4U0W.PN2NOIO19Z7U@otso>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CV7NGPVH4U0W.PN2NOIO19Z7U@otso>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1.09.2023 16:27, Luca Weiss wrote:
> On Wed Aug 30, 2023 at 12:45 PM CEST, Konrad Dybcio wrote:
>> On 30.08.2023 11:58, Luca Weiss wrote:
>>> Add device tree for the Fairphone 5 smartphone which is based on
>>> the QCM6490 SoC.
>>>
>>> Supported features are, as of now:
>>> * Bluetooth
>>> * Debug UART
>>> * Display via simplefb
>>> * Flash/torch LED
>>> * Flip cover sensor
>>> * Power & volume buttons
>>> * RTC
>>> * SD card
>>> * USB
>>> * Various plumbing like regulators, i2c, spi, etc
>>>
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> ---
[...]

>>> +	panel: panel {
>>> +		compatible = "boe,rm692e5";
>> Undocumented compatbile
> 
> Not quite sure how to document this properly. This dummy panel node is
> used for the simplefb/simpledrm so that user space can get panel
> dimensions already.
> 
> This approach of a separate panel node was apparently preferred when the
> functionality was upstreamed but of course as can be seen this panel
> node is very barebones where many properties are not present which would
> be needed with the full panel driver (once it's working).
> 
> Also for example for the bindings I think width-mm and height-mm won't
> be needed anymore since that information will be provided by the driver
> then.
> 
> Please let me know how/where to document this.
As discussed offline, the workflow here would be to oneOf: (wink)

- wait until there's a proper driver and create a binding based on
  what you know (because you have a working driver and can test it)
  is necessary for it to function

- create the binding for that display panel + driver ic combo in
  advance and pray that whatever you put there will be enough when
  you take upon yourself to write the driver

I'd suggest dropping these properties (or keeping them downstream or
something) for now, the display should not be terribly hard to bring
up properly, let's hope that can be done soon!

> I'm aware, but will work on this later since it's not useful without
> USB-C role switching and working audio.
You can still peek at it in like sysfs or so, but up to you.


Konrad
