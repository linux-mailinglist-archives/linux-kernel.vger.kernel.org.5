Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC5379EDBC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjIMPyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjIMPyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:54:45 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75B6CCD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:54:41 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bd0d135ca3so121380931fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694620480; x=1695225280; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PV6H7MY3pYafdYjha+YwxubfEbezxXEhfC2aB0o7/80=;
        b=x+wVeK8BS+ldm/+KS+qKJto6DGwzL2e53/54rVSwwo9gDmZZRvTncASFcyNgM8eGVG
         Gt0wPz32OGJFUNYOrx2N/NZM1gBYuqhNJ53+XPe1t6tngy2jm36mist/mRLAEkkHF2bL
         viLi1I/TtSOwBjhqA3HRawaTaDR4QuJhVe+bLOvOH3bKXRGnDhmIVdmVEPoqu0+2LYjH
         GJb+NetrN69y6ha7bXj5sWEEArDf7Ls8csvM1HPj9tcxrVW+JVpPPUdw9EM85rWjJP5u
         8jKRhI6c8DAboT+o8vHsj796ewHkqOwz4u0LMRwAcJGbg91GFC7cst4SOnUOhlKH2Ssp
         8xKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694620480; x=1695225280;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PV6H7MY3pYafdYjha+YwxubfEbezxXEhfC2aB0o7/80=;
        b=VFlTlkZuoTd4/iQdtDggZFHFOziCQNjga3TTY6fvuUBcxPQWxRwUxMKtBg+f4ZSlvP
         oXXLsT3p8yeYg76EjYofe+JRRZdorYxrkxChmtjZlq7ilUKS/vsIX9ylIV/pxJ55AWup
         8m2NkqPAhjkAXl39Dv8xa5OVhnd2kRQtNWprl23diBMKSyQ21QRczNeLNS9jC1aSMeCh
         7NYoL5shANXnmwRXCgrqT/eoNFkctoQ0lTbERpunXXUsApbcwDxZVr3kpkfa/KuYW44o
         CYzqhti1hr9m9eYMVdjQZdHya8Z8LRZgQNzVfzD6OLBmzDCmQDOnCw7sZHJA90o5LB8R
         ltQQ==
X-Gm-Message-State: AOJu0YzFPWdmdUqZpMbrlNDGEaalSVF47rXo8aZROm9ab1wNDqSmpGGe
        vc+rVVRp9KXoLXlVN3V3PtQPew==
X-Google-Smtp-Source: AGHT+IFl0lyG4rkyAxRanpYoJepUFaViYKTHOyxflLutR7Tdl2sNNCM60S1AVZ3ZIYtlzyC2KV29Uw==
X-Received: by 2002:a2e:a282:0:b0:2bd:16e6:e34e with SMTP id k2-20020a2ea282000000b002bd16e6e34emr2403844lja.1.1694620479822;
        Wed, 13 Sep 2023 08:54:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id lh26-20020a170906f8da00b0099cd1c0cb21sm8594101ejb.129.2023.09.13.08.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 08:54:39 -0700 (PDT)
Message-ID: <48ff2a69-6eaf-78dc-0382-f0b6a6d8cddd@linaro.org>
Date:   Wed, 13 Sep 2023 17:54:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v6 1/4] dt-bindings: remoteproc: k3-m4f: Add K3 AM64x SoCs
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Hari Nagalla <hnagalla@ti.com>
Cc:     linux-kernel@vger.kernel.org, martyn.welch@collabora.com,
        devicetree@vger.kernel.org, andersson@kernel.org,
        linux-remoteproc@vger.kernel.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        mathieu.poirier@linaro.org, p.zabel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org
References: <20230913111644.29889-1-hnagalla@ti.com>
 <20230913111644.29889-2-hnagalla@ti.com>
 <169460861100.2790015.8526656812110915165.robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <169460861100.2790015.8526656812110915165.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 14:36, Rob Herring wrote:
> 
> On Wed, 13 Sep 2023 06:16:41 -0500, Hari Nagalla wrote:
>> K3 AM64x SoC has a Cortex M4F subsystem in the MCU voltage domain.
>> The remote processor's life cycle management and IPC mechanisms are
>> similar across the R5F and M4F cores from remote processor driver
>> point of view. However, there are subtle differences in image loading
>> and starting the M4F subsystems.
>>
>> The YAML binding document provides the various node properties to be
>> configured by the consumers of the M4F subsystem.
>>
>> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
>> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
>> ---
>> Changes since v1:
>>  - Spelling corrections
>>  - Corrected to pass DT checks
>>
>> Changes since v2:
>>  - Missed spelling correction to commit message
>>
>> Changes since v3:
>>  - Removed unnecessary descriptions and used generic memory region names
>>  - Made mboxes and memory-region optional
>>  - Removed unrelated items from examples
>>
>> Changes since v4:
>>  - Rebased to the latest kernel-next tree
>>  - Added optional sram memory region for m4f device node
>>
>> Changes since v5:
>>  - None
>>
>>  .../bindings/remoteproc/ti,k3-m4f-rproc.yaml  | 136 ++++++++++++++++++
>>  1 file changed, 136 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/stericsson,dma40.example.dtb: dma-controller@801c0000: sram:0: [4294967295, 4294967295] is too long
> 	from schema $id: http://devicetree.org/schemas/dma/stericsson,dma40.yaml#

This looks unrelated but it is caused by this patch. Probably by
conflicting type for 'sram'. It seems we need to make exception for
'sram' in dtschema.

Best regards,
Krzysztof

