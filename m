Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481C779E1E0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238508AbjIMIUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbjIMIUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:20:21 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF44CE7F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:20:17 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31c4d5bd69cso6727873f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694593216; x=1695198016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ebvh+OTfikZSo6LNSB0uDYGYHPACmUNeRrjWJEfO/Vo=;
        b=fLOSUz9SxZ3XElVrW205+FrBVZMSvoNQfEyn9sjj/OnR5uhdxmTksgtl5KwW09OUON
         jGc09vVVP6IGHaALLNN3mYjpMeTOmTjqN4uh7AasB5kQCYfbr+1HxpbeWiM0LPNkoPBK
         80aAW5PBng97Y5emDIEJgE+YGpH1Eiz/dQj2HBn1KxhgExsccUrffr7CfHmZopFcoR48
         hjRkDEJNrYXX5c3tz4dKn+I9h/uS+wKX3CFyf8BRu49dv3WUe3OHIsS1ZQL1uXbQahu2
         3hpIuhuJ/dKviw5rd0wafsSvZ4USmWkxq6J1chHJ5TkYNPI4r5RLUUqxbLAm9MnOhqBd
         ds8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694593216; x=1695198016;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ebvh+OTfikZSo6LNSB0uDYGYHPACmUNeRrjWJEfO/Vo=;
        b=sx+YYMOEndm+jgrar7KRrvHLdFrN2r6NPOive1M/jtIzjzNAjIPXPkLbWeXl8qp9B3
         u8+ARbBmw9Y6KAZNKa82ClvP2+g5KN7hPtF+gzl5pWO4CUxHnOk8hjDaDLyhd2D9gdrZ
         WGEFeBzZLKkBWGioQN71U02NrvurEj3s0XyHkWRsLwixvNNf7bAqMiUG+/LWEdDS3il/
         b8hCDkm3wVNakg1nUtClNBfdDzYull0pqYGeXNC/R47Bh5sN0g8l9VMX9wsF3HTCjmsC
         Yd2IgwiMFGC5O+hMkg/CxWQshQi+92AV6g4UonCNFTl0EsJcRMmoohl4Flg4ORaWUOFR
         sYWA==
X-Gm-Message-State: AOJu0Yz/zVHMAXzcSg+zAkzFpkEyiQ655XGulpJsw+9Psu50E0Rrk7AL
        dt8KzJbvPTCUxZ6REo+NZiZLglyULoYBpmsN3vY=
X-Google-Smtp-Source: AGHT+IFGi6oH48U1eGwPJWFX4hkRGcYm33xyNRCZXrFRAn6W1yz6600EEf+4osxfcjSoXX3qS2aM9g==
X-Received: by 2002:a5d:4c90:0:b0:319:7a91:7107 with SMTP id z16-20020a5d4c90000000b003197a917107mr1271860wrs.48.1694593216285;
        Wed, 13 Sep 2023 01:20:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id a5-20020a056000100500b003143867d2ebsm14844756wrx.63.2023.09.13.01.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 01:20:15 -0700 (PDT)
Message-ID: <26a53f62-d8d0-9583-e675-a3db99c60c8a@linaro.org>
Date:   Wed, 13 Sep 2023 10:20:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: aspeed: document board compatibles
Content-Language: en-US
To:     yangchen.openbmc@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     patrick@stwcx.xyz, Jerry.Lin@quantatw.com, Eddie.Chen@quantatw.com,
        EasonChen1@quantatw.com
References: <20230912140532.3797736-1-yangchen.openbmc@gmail.com>
 <20230912140532.3797736-2-yangchen.openbmc@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230912140532.3797736-2-yangchen.openbmc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2023 16:05, yangchen.openbmc@gmail.com wrote:
> From: Yang Chen <yangchen.openbmc@gmail.com>
> 
> Document the new compatibles used on the Facebook Minerva Chassis
> Management Controller (CMC).

How is this related to
https://lore.kernel.org/all/20230907064514.1764010-3-peteryin.openbmc@gmail.com/
? Looks like duplicate :/

Best regards,
Krzysztof

