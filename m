Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62BF75F2A0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjGXKRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbjGXKQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:16:56 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB8565B8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 03:09:17 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5221cf2bb8cso2940843a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 03:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690193346; x=1690798146;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fc/OvRwUpGyNbpV42y42cs+Z7tLhRlmCIleilPEkd8I=;
        b=ifYqtACpoq/OKaMWi9ibAvt31nTl2lvhzjRs0zCBz2aakJ+UF2ai0o8hGHSzWo72v3
         bYB6gn7dlftGX1FtBsM7V/ZG+R0tLYyE09nw3xyUkjelZXp1qjaUGVWl4o4m+nOE30Es
         ecYoz1TEoG/YNp6ToeYEYdsSEKMS836tK6MxeIsFqUMmShz2eSQ93sml9Srm0vLpxIu0
         u8eBe3N5KokZsxdpjKVhAp59omTZub32YOz+tebiQ3lsQ+2gpukPFZcheVwhfqrjKwel
         RvvRxpGRbPf0MJPGseQMkqW5+6AOpxfgPE1zD6EITft0rYwdOuLHdIl7HIneKjL2FTN/
         39vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690193346; x=1690798146;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fc/OvRwUpGyNbpV42y42cs+Z7tLhRlmCIleilPEkd8I=;
        b=YxEM1X71sTZjoT5BmroojDDOkZcNXtojsF4bj5OezIOErlYv9NNIYVq9knV3SS0NT2
         trAWWrr/4mDMkUI2Iev4HeEXOg1RANSRP3PpqiVg7zXtxWMrzAlVooHOCK0VmJytLYZV
         abeOux19HpAitARCOiDZacdEo8ylNkAHUvDim87vyqiBtRueE/80UC5cdy1K/aLSA0Yz
         9JnOC+1+yIaTrMlAHV0N4ysCpd1r58cOG2eTSBYicrnvvBHFSEemnuF9i6yU2ib9RHvl
         5wGyatbIJPzK8g7zsJsRb6GYN+lRhTxkFSvp2imIikG6XZUUeBwRhm966JJfjjEqUAC8
         r+oA==
X-Gm-Message-State: ABy/qLbbGOGY8zTUREz6j67xc2TCNuwnN2pHztiglojhBnb3YCfXpUtv
        ItRZ8T4DMP8GwrhQvwRO9BLu3nQLY4OBaXKRrhh6dQ==
X-Google-Smtp-Source: APBJJlEpRpgdbAJTL5ApmUGIBH+DtJus2Kc2vpSE4V3+aD6QuyH1UFLfNwIiCG3thpJjV2SDg0rShA==
X-Received: by 2002:aa7:c982:0:b0:51e:404:1e6d with SMTP id c2-20020aa7c982000000b0051e04041e6dmr9407596edt.38.1690193346327;
        Mon, 24 Jul 2023 03:09:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id q2-20020a056402032200b0051d9de03516sm6011209edw.52.2023.07.24.03.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 03:09:05 -0700 (PDT)
Message-ID: <1ce0d151-466c-3bf6-2cf2-8a98af81152a@linaro.org>
Date:   Mon, 24 Jul 2023 12:09:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Add lltc ltc4286 driver bindings
Content-Language: en-US
To:     Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>, patrick@stwcx.xyz,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230424101352.28117-1-Delphine_CC_Chiu@Wiwynn.com>
 <20230724100514.1028061-1-Delphine_CC_Chiu@Wiwynn.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230724100514.1028061-1-Delphine_CC_Chiu@Wiwynn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2023 12:05, Delphine CC Chiu wrote:
> Add a device tree bindings for ltc4286 driver.
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
> ---
>  .../bindings/hwmon/lltc,ltc4286.yaml          | 49 +++++++++++++++++++
>  MAINTAINERS                                   |  9 ++++
>  2 files changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/lltc,ltc4286.yaml
> 

You already sent it, so why this duplicate? I also don't understand why
this is attached to previous thread.

Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets.

Best regards,
Krzysztof

