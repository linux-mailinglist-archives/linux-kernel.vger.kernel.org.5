Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA6F78DFF6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240330AbjH3TTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242031AbjH3HNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:13:07 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7A31B3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:13:04 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a5e37a39ecso32094066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693379582; x=1693984382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TlmWx7J988jUTBD1yCbXKnxEBFJ9/SEsR6ggJelJEyE=;
        b=FBSIcBylaE2+RQM+2MUow7pQDZNwO9c3p0BK5jqFSKbOEk8aQwAhwipORClRgDYxsf
         dJPzx60Ot3pH4aXTcflc7mxnXeeOccacGrdXQzqtp6HHr6FmNGmR0lYJaeqa7djnoGMs
         OpFdHHlF+FyEXmwFEc4AP2iMN3NDL+C6mr4M6pDOzaYdzE+clQjPrpgY35gmDrmcU2nG
         AYAKOXCpUknMNpDm0ti+8jFngeTNdIhVxszdpqT2KMdlfYiP+VGVwMk0zefZmcEBRE2Y
         IHW8qo5VVl+OTkpN5OL9ED9FamEuQUftDLUxi/Ln2/J+SJpZucRsmi1RRYiWC1Q9QuwV
         z+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693379582; x=1693984382;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TlmWx7J988jUTBD1yCbXKnxEBFJ9/SEsR6ggJelJEyE=;
        b=j+dDIYZxN+HixSEBeF8wKlk5KfigJ1So8AF+Q13M1fLPaGSyLh4XLwn4NFGN48oIb5
         pD3Ujzg4sveNa2vfSkKxWKVunMjg0nH4VviEX1KKp7dWxUFPuPF3rDms6arr/XXK9byn
         Xm9NKymR9HfG05TsXdZY6+z/OoWTd+fE+vyhhupuRU9jd1lPdMuXHBoskBS+LHjGpZpg
         zLpzZtRxkQg3l1DNxbuz24HXRfTcC9eMADknMG9hXC+JAozpFSHGhJ7C1zhhm5sm8Wn8
         w3XROqqQtj+3DbNg3MypOQeO4D3OUhZygK08XImjGA3SNeBUNqxuRVzK8pHVH8vd5+Hn
         nJ2g==
X-Gm-Message-State: AOJu0Yw7vL180n6f9bTqJzyghIi6oId/RQEB3lKGtFJnagus8eE+AvCt
        n7UGeI3y+fWon+tSlofZ5r955A==
X-Google-Smtp-Source: AGHT+IF+5DxuHdSG3Q5k7h2CRZvFk49w0bjYx5Ci81wfLZgXylbaTnbHLSxNB0HUo2OaSXh2Mz9HLQ==
X-Received: by 2002:a17:906:5dc1:b0:9a2:86a:f9b7 with SMTP id p1-20020a1709065dc100b009a2086af9b7mr896445ejv.59.1693379582599;
        Wed, 30 Aug 2023 00:13:02 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id hv13-20020a17090760cd00b009a5f1d1564dsm72007ejc.126.2023.08.30.00.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 00:13:02 -0700 (PDT)
Message-ID: <12a0f531-851f-cd09-3d56-828e2aeccae3@linaro.org>
Date:   Wed, 30 Aug 2023 09:13:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/3] dt-bindings: can: xilinx_can: Add ECC property
 'xlnx,has-ecc'
Content-Language: en-US
To:     "Goud, Srinivas" <srinivas.goud@amd.com>,
        Rob Herring <robh@kernel.org>
Cc:     "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "appana.durga.rao@xilinx.com" <appana.durga.rao@xilinx.com>,
        "naga.sureshkumar.relli@xilinx.com" 
        <naga.sureshkumar.relli@xilinx.com>
References: <1693234725-3615719-1-git-send-email-srinivas.goud@amd.com>
 <1693234725-3615719-2-git-send-email-srinivas.goud@amd.com>
 <20230828154309.GA604444-robh@kernel.org>
 <PH8PR12MB6675C31C6D1DCD3281FE8A10E1E6A@PH8PR12MB6675.namprd12.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PH8PR12MB6675C31C6D1DCD3281FE8A10E1E6A@PH8PR12MB6675.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2023 08:06, Goud, Srinivas wrote:
>>> +
>>>  required:
>>>    - compatible
>>>    - reg
>>> @@ -137,6 +141,7 @@ examples:
>>>          interrupts = <GIC_SPI 59 IRQ_TYPE_EDGE_RISING>;
>>>          tx-fifo-depth = <0x40>;
>>>          rx-fifo-depth = <0x40>;
>>> +        xlnx,has-ecc
>>
>> Obviously not tested.
> Will fix it.
> 

Fix it by fixing error or by testing? Can you do both?

Best regards,
Krzysztof

