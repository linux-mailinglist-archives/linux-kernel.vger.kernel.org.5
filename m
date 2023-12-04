Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764A5802E04
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbjLDIst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjLDIss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:48:48 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C13FA4;
        Mon,  4 Dec 2023 00:48:54 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so2223192a12.1;
        Mon, 04 Dec 2023 00:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701679734; x=1702284534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ST2h/PONfnZyu/0urr3vsm15K/qMqFc6bAJOz5sjZGk=;
        b=Nh487HWxZUe0V8piH/6NUCYPy5Kpo2TZ+i+xPkH9zByf2DfataNHfLwMr3gwXN/mL8
         TBEeVu2+uXBIHENyXyBY701g4w0A9BD6+7fpdnfBzscHNLoHmw+QVWMrvFopo6isf77K
         03cla3tdgks4MkzLXkBDsHfQtWxT1O+X/CV4zSF9cpY2ldT0+F/53SUr9UJh9NYj7HYF
         CqdVy5/XPx86wdcimYKKgSTCVAXi22BIDzWzxi3Ve3KFWKx2+0qcamPLNa8SC90EwUig
         Z5yh6YTaiAMwES/6lHhTSqpVc/ZadHfndmYukVidHiyHgkqyb1dBA/dBUZreOEzlK1nJ
         hEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701679734; x=1702284534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ST2h/PONfnZyu/0urr3vsm15K/qMqFc6bAJOz5sjZGk=;
        b=IXpJD69djRe54eZpLe/mlMLQCHhXtLooStxA6/vVAIGguIpRzV7yQdNw6U/TrdRXan
         Q8qFke8Yu2ccYu381rqpgtQSzGMklISRFgOgiYjpwGN9SVcjDPDUMHMop0wEvItDGrQT
         s5rP5KrIr8+jXAMeUiYcMLYuhq89f/+5mVs0ZWii9LxfwY+V0LmoaflxzYKI3sa5PPL8
         Nrtt1VJ1OEia+0Pun5YxR9P3hOUIqiXkxX0QJQc+n7EvO9WbT9MaksQTQ/wVTlspvGP3
         SifMjOK/pqyZkr2KBIzVPl4tzFAy6HQ4jwkFgj4EyFjx3SzTYr/bo7GtpUDoAmRygAH3
         6zFA==
X-Gm-Message-State: AOJu0YyjBeJT0bmvLuiCwcQjyLbKA/VDr2ciwyjrkglIVJg+GR+HfATa
        Kl4WRLm+DEQgbq4FdRT/OH4=
X-Google-Smtp-Source: AGHT+IFn9+aaDvJQIaTTT9fhCQOFpYf2DG2sHOPojRJV8T11hDylXF7KIzTFFXItytXtfbP6QIHFjw==
X-Received: by 2002:a05:6a21:1cb0:b0:18f:97c:8a3a with SMTP id sf48-20020a056a211cb000b0018f097c8a3amr3614507pzb.101.1701679733801;
        Mon, 04 Dec 2023 00:48:53 -0800 (PST)
Received: from [10.10.14.80] (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id v4-20020a634644000000b0058901200bbbsm7186819pgk.40.2023.12.04.00.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 00:48:53 -0800 (PST)
Message-ID: <3ff5dcd7-69a3-4098-92c6-ed1e8f0bd8f9@gmail.com>
Date:   Mon, 4 Dec 2023 16:46:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] Add Facebook Minerva Harma (AST2600) BMC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20231204081029.2272626-1-peteryin.openbmc@gmail.com>
 <fddcbad4-5368-4c2a-ba87-f4c4326a8385@linaro.org>
Content-Language: en-US
From:   PeterYin <peteryin.openbmc@gmail.com>
In-Reply-To: <fddcbad4-5368-4c2a-ba87-f4c4326a8385@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Krzysztof Kozlowski 於 12/4/23 16:20 寫道:
> On 04/12/2023 09:10, Peter Yin wrote:
>> Summary:
>> Add linux device tree entry related to Minerva Harma
>> specific devices connected to BMC SoC.
>>
>> v4:https://lore.kernel.org/all/20231204054131.1845775-3-peter.yin@quantatw.com/
>> v3:https://lore.kernel.org/all/20231123050415.3441429-3-peteryin.openbmc@gmail.com/
>> v2:https://lore.kernel.org/all/cdbc75b9-3be1-4017-9bee-c8f161b6843c@linaro.org/
>> v1:https://lore.kernel.org/all/20231024082404.735843-3-peteryin.openbmc@gmail.com/
>>
>> Change log
>> v4 -> v5
>>    - Rename document and file from minerva-harma to harma.
> 
> You must explain that you dropped people's review for some reason.
> 
> Best regards,
> Krzysztof
> 
Due to changes in the project name and content, please assist in 
reviewing it.

Thanks,
Peter.
