Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A9978546E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjHWJlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbjHWJlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:41:01 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E582D43
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 02:35:28 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so8434115e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 02:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692783327; x=1693388127;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b2WR3Ie0h6RR/yPxDJeAUQR54bpQnAIUQ5XkLuiEbOw=;
        b=aoWioChoG5AbKY6UZJUCEVsha2OqtkBmtIK2rhxcqENKgskrbeqZGz3LFcAIYYfTty
         aHLYMQb53eg+mEC8Y5jJJ11Ih8Vh0cfkf9SQtS7y52hrNwaQlwZppeJ2NAPjB2nrKSBR
         H9/FlUayI9HpUFJFoZCKw/nW7SG/pJr15Znsfpi71NaTrDbtGC7fsAmVxw3DoKmqizUT
         QifYJO4da/Zr7MxnCGo90kWNu9wRZ+0CqPV655v+IHWg75UQLk+I5ZNL4GDYBtZ9BPdk
         +xuezddiQhdD3E7B421ANvjvFgX/Q6WpaafLA0Ze4T7MqX3wShtyygLpOoGqWuQsU1yy
         oYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692783327; x=1693388127;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b2WR3Ie0h6RR/yPxDJeAUQR54bpQnAIUQ5XkLuiEbOw=;
        b=g9NI6HdD6r/70guhAshZtVRyKhW9ykBYhCKYRWOq8+QzfxMOaq9rCjcn50BfWd337Y
         YezlHNt0OggYSJWzEdC6TyftRjA1/LzDE/Y2cdI6NxTHBNGB5xdhGUa5BigGEgCbmhR/
         RLVOxDAzlwjaQiWUMdEfyag0o9WhTD8aErEyUSjGTSLhdS7ZERNldJ19k7F8zVVWuiRJ
         RiGNxBd4VSxlPG218dm3Q0nA5x0JoSvM+M/qZavWgdvmqW62/Mwdwltc7abyahWP2xjd
         +QAB08101to31d/uQI+2hibKsBeOFFlFsPHyrovxESJHAjb+ivNSpwQ7fPmAqpllXzko
         U9JQ==
X-Gm-Message-State: AOJu0YwoZi9xqpIK2X+jPvMP9+9le6jtBG1y9G+STM7Gsy1YOhEAKYlp
        v2ayVCrO37t5WqCwvim1EdROfA==
X-Google-Smtp-Source: AGHT+IGG8ZQMpcasgZT/TlzCMc5uvmu4o8YkKzwHP3aFkVzTO9t2EyjtCSFss5/JI0sVdgKcWAFlFA==
X-Received: by 2002:ac2:4e0c:0:b0:500:7f71:e46b with SMTP id e12-20020ac24e0c000000b005007f71e46bmr7780180lfr.1.1692783326608;
        Wed, 23 Aug 2023 02:35:26 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id s10-20020a056402164a00b0052a3c7c9e8bsm388894edx.56.2023.08.23.02.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 02:35:26 -0700 (PDT)
Message-ID: <61ae58eb-d56c-59c1-81d7-b51322468680@linaro.org>
Date:   Wed, 23 Aug 2023 11:35:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/3] dt-bindings: display: panel: add common
 dual-display schema
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jianhua Lu <lujianhua000@gmail.com>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230823081500.84005-1-krzysztof.kozlowski@linaro.org>
 <20230823083427.GB4143@pendragon.ideasonboard.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230823083427.GB4143@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2023 10:34, Laurent Pinchart wrote:
> Hi Krzysztof,
> 
> Thank you for the patch.
> 
> On Wed, Aug 23, 2023 at 10:14:58AM +0200, Krzysztof Kozlowski wrote:
>> Add schema with common properties shared among dual display panel ICs.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> v2: https://lore.kernel.org/all/20230502120036.47165-1-krzysztof.kozlowski@linaro.org/
>> v1: https://lore.kernel.org/all/20230416153929.356330-1-krzysztof.kozlowski@linaro.org/
>>
>> Changes since v2:
>> 1. New Patch
>> ---
>>  .../display/panel/panel-common-dual.yaml      | 46 +++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/display/panel/panel-common-dual.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/display/panel/panel-common-dual.yaml b/Documentation/devicetree/bindings/display/panel/panel-common-dual.yaml
>> new file mode 100644
>> index 000000000000..83fcd643b5f5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/panel/panel-common-dual.yaml
>> @@ -0,0 +1,46 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/panel/panel-common-dual.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Common Properties for Dual-Display Panels
>> +
>> +maintainers:
>> +  - Thierry Reding <thierry.reding@gmail.com>
>> +  - Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>> +
>> +description:
>> +  Properties common for Panel IC supporting dual display panels.
> 
> Could you elaborate on what you mean by dual display panels ? From what
> I understand of the patch series, this seems to be what I have called
> dual port panels, that is panels that have two input ports to double the
> bandwidth, but still operate as one display.

Indeed, looks like that. I don't have the datasheets so I am trying to
get some pieces of information. Judging by the usage of these panels -
Qualcomm DSI with qcom,dual-dsi-mode - it indeed is one panel with two
links.

I would need to rephrase it.

Best regards,
Krzysztof

