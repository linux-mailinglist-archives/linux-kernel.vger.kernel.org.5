Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33AC792FE0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbjIEUXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjIEUXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:23:42 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1428E;
        Tue,  5 Sep 2023 13:23:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-991c786369cso459288666b.1;
        Tue, 05 Sep 2023 13:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693945417; x=1694550217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W7FEvRnQff1RFIy6G/Scp5VfoqVl8Fl9R26EpZ41ssQ=;
        b=lWrFnxMWH56mAAYRBqSP80rEP7abc/BGdgchUTeroB66ZQO1qonI0wom7R1AWUsWa5
         x+3YlFyh0k32JBmjrSqBLoDg8QFoGzsk+28ELUekaM28Ka1llyut0lzXjHxaqc/cGV3X
         iFzT+0mMogIfBdvY17+qZS3u3/Glf5q0Je6H6mN+w1aq123H3UPuj7wlul70WX0A4bBj
         MxXkRx4XmuePuFw26OU1qHTDCBhNYjTaEvCGEhqJu0sy+QgHhIeGWLae7clGHPyQS/J3
         jITdYSo04bZYQPxFnm49UeJ1iWxVfn6XXj60YlAgoPi08nrKZI13MC29XQxhQcl9tkwI
         ixEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693945417; x=1694550217;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W7FEvRnQff1RFIy6G/Scp5VfoqVl8Fl9R26EpZ41ssQ=;
        b=QsJMO1b/znkhmMmCeMQm6WA7987qkVqKn5btexOM3i5tA2jZViO16219urPVmkW2o3
         JInlp+8hPwOHcmQ/+vACM06boWHN8RdHbZlgi8Gw5ZDSDNXaSp4Z6ZbYe9ycFBTgWTeG
         Fm8p3GDrA6+ET/DqSdD0q2lAfaqykj1QVNumuyd45JKjIDK0U39/N3Av9vQbOz/6inMG
         fmdIgCU4H51s7t1lrV8czmXhccqdZ3vfDRdxxYE2xFUf5iucJglj2kVA2XmtxTqC64q/
         v7QXvVBydbkddPkRSae4O79WxJGwPv9CTloyGeJtRkhVdxOzwtew/RGXyFWXJciuS4RL
         TEMg==
X-Gm-Message-State: AOJu0YwJ70+pPW4ZQ2FtIU7MnXVc1O+cP3aVSrLO/1ugwTgJUvZXKIFU
        WY+dsMwn9e0hfya6JyH2jVbgEdXRNBCSgA==
X-Google-Smtp-Source: AGHT+IG2mFnmzU6dZ1Lll+hMk7JV4ZmDPpxt54hgKUw+BKq9w4jCarie89LEsaJFEj3D1lcN6wDTcA==
X-Received: by 2002:a17:907:b0a:b0:9a1:b705:75d1 with SMTP id h10-20020a1709070b0a00b009a1b70575d1mr579098ejl.51.1693945417163;
        Tue, 05 Sep 2023 13:23:37 -0700 (PDT)
Received: from ?IPV6:2a02:908:8b3:1840:5b7b:492a:c913:71fb? ([2a02:908:8b3:1840:5b7b:492a:c913:71fb])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709066b9200b0099bc08862b6sm8166003ejr.171.2023.09.05.13.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 13:23:26 -0700 (PDT)
Message-ID: <755a2be4-6947-d756-2eee-0ba14086d781@gmail.com>
Date:   Tue, 5 Sep 2023 22:23:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
From:   Maxim Schwalm <maxim.schwalm@gmail.com>
Subject: Re: [PATCH v3 2/5] dt-bindings: display: tegra: nvidia,tegra20-dc:
 Add parallel RGB output port node
To:     Rob Herring <robh@kernel.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230807143515.7882-1-clamor95@gmail.com>
 <20230807143515.7882-3-clamor95@gmail.com>
 <20230821161441.GA1743870-robh@kernel.org>
Content-Language: en-US
In-Reply-To: <20230821161441.GA1743870-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 21.08.23 18:14, Rob Herring wrote:
> On Mon, Aug 07, 2023 at 05:35:12PM +0300, Svyatoslav Ryhel wrote:
>> From: Maxim Schwalm <maxim.schwalm@gmail.com>
>>
>> Either this node, which is optional, or the nvidia,panel property can be
>> present.
>>
>> Signed-off-by: Maxim Schwalm <maxim.schwalm@gmail.com>
>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>> ---
>>  .../display/tegra/nvidia,tegra20-dc.yaml      | 31 +++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
>> index 69be95afd562..102304703062 100644
>> --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
>> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
>> @@ -127,6 +127,37 @@ allOf:
>>                $ref: /schemas/types.yaml#/definitions/phandle
>>                description: phandle of a display panel
>>  
>> +            port:
>> +              $ref: /schemas/graph.yaml#/$defs/port-base
>> +              description: Parallel RGB output port
>> +
>> +              properties:
>> +                endpoint:
>> +                  $ref: /schemas/media/video-interfaces.yaml#
> 
> Just to make sure, what properties are you using from this? Usually 
> we'll list them though not a hard requirement. If none, then you just 
> need to ref graph.yaml#/properties/port instead and can drop the rest.

currently, just bus-width is used in devicetrees, but I don't think that
it is needed at the moment. So perhaps the property can be dropped.

>> +                  unevaluatedProperties: false
>> +
>> +              unevaluatedProperties: false
> 
> In the indented cases, it's easier to read if this is before 
> properties/patternProperties.
> 
>> +
>> +          anyOf:
>> +            - if:
>> +                not:
>> +                  properties:
>> +                    nvidia,panel: false
>> +              then:
>> +                not:
>> +                  properties:
>> +                    port: true
>> +            - if:
>> +                not:
>> +                  properties:
>> +                    port: false
>> +              then:
>> +                not:
>> +                  properties:
>> +                    nvidia,panel: true
> 
> I would prefer to drop this and mark "nvidia,panel" as deprecated. 
> Eventually I plan to add a mode to the tools to warn on using deprecated 
> properties. Having both could be perfectly fine too. You have the 
> "nvidia,panel" for compatibility with an old OS version and 'port' to 
> work with newer users.

The reason for adding this was that just one of them can be utilized at
the same time. Having both could potentially break the display output.
I think that all the other nvidia,* properties could marked as
deprecated as well because they don't seem to be doing much since commit
d9f980ebcd01 ("drm/tegra: output: rgb: Wrap directly-connected panel
into DRM bridge").

>> +
>> +          additionalProperties: false
> 
> Move this up too.
> 

Best regards,
Maxim
