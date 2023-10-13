Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA687C7DC9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 08:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjJMGkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 02:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJMGkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 02:40:33 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2B1BC;
        Thu, 12 Oct 2023 23:40:32 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6b5673a685cso9354b3a.2;
        Thu, 12 Oct 2023 23:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697179232; x=1697784032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dJYgBUfn3JyABPlo6kuxWrpZ75y0tXyEmz+uIYcP7cM=;
        b=fAewwhi/XYFNHJrJmv2WaB21bzlrE6bcedKb3SokDwIWT2TOdCkQcyElMlpVLoJBEi
         Lk7X1X9zbO+td8+nFans1I5m5YWUotTMxD8tcRS55x1dwN1d4z90st6/A3lOBrIIasWs
         ALH3GR5Df3nsCSnSpTDCWW1Oj1vzG6MM0qKoar/gYLDQ4nBiJnMiN4ES4mGV+beiUK9Y
         rwx3KMAqGgKPt3aP0vNTXjA51tCi3evChRczKiPXqy54ldfXzhQG0maxyGgHWpOFBniH
         cXZeYb4AUEJjwr1fdAs8eTR7Ye3qX9ahbFTtI/TR0MXqCOLwqyff2yHEdgKG/m0w9hKR
         geLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697179232; x=1697784032;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJYgBUfn3JyABPlo6kuxWrpZ75y0tXyEmz+uIYcP7cM=;
        b=voe4tZVRskYOo40uQDlctAMwuSPOWSPfansDddekmmW7ueh8bROaZVIije0Q+kd1/0
         tYfZdmykj8g9jlx1B8YTq3R+4AbYlUd5Ll7R08Y/dUN26QiFuCUaRHSsWDAjhkk274VB
         JmHZzdsaHPAaV4WZbIqNL5baCk/ouBOiezEZFyiSyGuF7uXQMrdDxu6gHt8nh6jGUxxN
         j9YlFgs0sL6rt/316YRbCF8YolR52VObe/kNzk6hhIRcEfMIYuHc6Ya+Fmk0DMRnrUox
         Ftq5ojHOBw4rrUh/jkw9PPo20Mm8eieukC0s2bMllD3CWlY3O/boA6BJcwY/JdPvR6VX
         IeWg==
X-Gm-Message-State: AOJu0YzxhPuG4grMJzAdEKuSie3P2zOEuSPCAqcyw5g3idYcB04eL2Fr
        vl+I3llXP9VqoLyxiKFx/C4=
X-Google-Smtp-Source: AGHT+IHl7DHaVweH2LzrPvfmwvBbj9lbHxnbrjT77Hgk0+DvIPJqdE09qkDz8LZTwaU+fJIYlFG61Q==
X-Received: by 2002:a05:6a20:4420:b0:153:78c1:c40f with SMTP id ce32-20020a056a20442000b0015378c1c40fmr29626412pzb.15.1697179231861;
        Thu, 12 Oct 2023 23:40:31 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902934c00b001b9da42cd7dsm3034551plp.279.2023.10.12.23.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 23:40:31 -0700 (PDT)
Message-ID: <331e7f14-579c-4a5b-9d35-36b93b2a0b11@gmail.com>
Date:   Fri, 13 Oct 2023 14:40:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: reset: Add syscon to nuvoton ma35d1
 system-management node
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, p.zabel@pengutronix.de, j.neuschaefer@gmx.net,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20231011090510.114476-1-ychuang570808@gmail.com>
 <20231011090510.114476-2-ychuang570808@gmail.com>
 <20231012203944.GA1699468-robh@kernel.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <20231012203944.GA1699468-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Rob,

Thank you for the review.

On 2023/10/13 上午 04:39, Rob Herring wrote:
> On Wed, Oct 11, 2023 at 09:05:07AM +0000, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> Add compatible 'syscon' to the system-management node.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>   .../devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml        | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
>> index 34c5c1c08ec1..3ce7dcecd87a 100644
>> --- a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
>> +++ b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
>> @@ -18,6 +18,7 @@ properties:
>>     compatible:
>>       items:
>>         - const: nuvoton,ma35d1-reset
>> +      - const: syscon
> Presumably you already have a driver for nuvoton,ma35d1-reset, so just
> make it create a regmap. I assume this is the reason you want to add
> 'syscon'?
>
> Rob

Yes, we have a driver for 'nuvoton,ma35d1-reset' with a register space 
mapped to
the system control registers. The other ma35d1 drivers may also require 
access
to the system control registers. I added 'syscon' to this node so that 
other drivers
can utilize 'regmap' via the phandle of this node.

Best Regards,
Jacky Huang



