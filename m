Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54E1757AF0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjGRLwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjGRLws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:52:48 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B245B1A5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:52:46 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51e29ede885so8009803a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689681165; x=1692273165;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sG7ozDX9NM/o92dg3TXw0CQG4MCfF4i8UsLjn3lS5G0=;
        b=Z1thpY3baZq+vNWRDe7n6I78lo0iEWey746H4WIdm7n2G/qpKhAiP1OiNvTElXJBwg
         RcJ1rRNpB2Gd3buIlDETcE+iOXZ0tSFkob7doB6jT8ujswTv2d0inpsFtPfO8SjqawvD
         el6Hyp09AKo61UqGmNmM5QvD8cH3BwGkVggJ2eL5vE+KCh8AKp9qD8R+11DvJXby817E
         xDDgUI5F04r9m2fFL05HxJN+/xcLnhW6KlyuSR5bh5N5LZ3ReKNuzBxcxFVjU5Ha2auC
         /O0r+o8/4FLw4yG7Q8KbUe9Wc8E4H0vOp/0lzXZwLJhBH+4p4wt09tbhO+DtqtC7DG2t
         wOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689681165; x=1692273165;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sG7ozDX9NM/o92dg3TXw0CQG4MCfF4i8UsLjn3lS5G0=;
        b=jRMuTnzcLsx2+F8eSjtBKV3N/hhEoXY2D0CuLhYFkUHbMzflYe2hUnW18KPD75GxJk
         wUGcBQlxoDMoSg/3LzY69KyRBCeSh805jv13qXh7sZsl/IGBWLVarkLNO6q5gKUyr5d/
         t0ekWeU+SON9OkdwIJt05Wgk0iRWAx8xWKsDntl2khojfNP76Y+V/ioV75Wo/fVa4XkV
         7AQwksvgmMgTEkpw9B2hU5UbD+BO5FJ7fXtNq7BLm/TfjlvBLozsdWrjaOlXDIZH7Fs6
         IhIhkYatp/M0j1mvGwqXuT3LPMkae9ncDipVO3D0P6KdvGufWIo1qDzI9gTA2clwhoNB
         RmqQ==
X-Gm-Message-State: ABy/qLZhvEwp19coOBsWTqQUo0h0fCYKFWL+njbXTfJYcj7lzvUBdRUJ
        1SUMH3Bp8O5Aj63BnVzqbJMW0w==
X-Google-Smtp-Source: APBJJlGRh5VMYFGKAv394CF4+UWzckjHWOKPQTtNJ6e5mbbsz7l5/4gYEjZGwnwOScJexCjtAxsLaA==
X-Received: by 2002:aa7:cb4d:0:b0:51d:8f9b:b6ce with SMTP id w13-20020aa7cb4d000000b0051d8f9bb6cemr13414755edt.1.1689681165230;
        Tue, 18 Jul 2023 04:52:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id w5-20020aa7dcc5000000b005217a24addbsm1122638edu.20.2023.07.18.04.52.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 04:52:44 -0700 (PDT)
Message-ID: <74b666ec-092e-28ea-498b-0efa103d7988@linaro.org>
Date:   Tue, 18 Jul 2023 13:52:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 02/17] dt-bindings: gpu: Add Imagination Technologies
 PowerVR GPU
Content-Language: en-US
To:     Frank Binns <Frank.Binns@imgtec.com>,
        "conor@kernel.org" <conor@kernel.org>,
        Sarah Walker <Sarah.Walker@imgtec.com>
Cc:     "luben.tuikov@amd.com" <luben.tuikov@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "hns@goldelico.com" <hns@goldelico.com>, "afd@ti.com" <afd@ti.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dakr@redhat.com" <dakr@redhat.com>,
        "matthew.brost@intel.com" <matthew.brost@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Donald Robson <Donald.Robson@imgtec.com>,
        "faith.ekstrand@collabora.com" <faith.ekstrand@collabora.com>
References: <20230714142526.111569-1-sarah.walker@imgtec.com>
 <20230715-paramount-straining-6a486f8af20d@spud>
 <a86f6359706485cf595889a07e513e2b9fd6d71b.camel@imgtec.com>
 <4131759e-9474-48f6-cc05-67b6d4b6559b@linaro.org>
 <1cb4f6b57f0826377f0aef85a8abcf0b5f51c07c.camel@imgtec.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1cb4f6b57f0826377f0aef85a8abcf0b5f51c07c.camel@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 13:36, Frank Binns wrote:
> Hi Krzysztof,
> 
> On Tue, 2023-07-18 at 13:10 +0200, Krzysztof Kozlowski wrote:
>> On 18/07/2023 13:08, Frank Binns wrote:
>>>> And this
>>>> items:
>>>>   - const: gpu
>>>> can just be
>>>> const: gpu
>>>>
>>>> Although, if there is only one interrupt this is probably not
>>>> particularly helpful. Are there other implementations of this IP that
>>>> have more interrupts?
>>>
>>> No, all our current GPUs just have a single interrupt. I assume it's more future
>>> proof to keep the name in case that ever changes? 
>>
>> Why do you need name in the first place? If there is single entry, the
>> name is pointless, especially if it repeats the name of the IP block.
>>
>>> As in, by having the name now
>>> we can make it a required property, which I guess we won't be able to do at some
>>> later point.
>>
>> Why even making it required?
> 
> It seems nicer to look up a resource in the driver based on a name rather than
> an index. 

Not really... Slower and confuses people, because then they think order
is flexible.


Best regards,
Krzysztof

