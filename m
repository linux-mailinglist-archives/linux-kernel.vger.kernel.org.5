Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6BB7FD65C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjK2MOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjK2MOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:14:15 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B60B91
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:14:21 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-332ed02ccd9so3323182f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701260060; x=1701864860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AsQvimBOnTjXGdKhEAnGYzR8KiGWDUYPadmCZZ7TXho=;
        b=gTNSr+HrG/QwEBmtDbp+q7SRM8xQA21O1oKOnkYyaUBRGrY7GEtgbqeasLBtHHTRBz
         +SuoISl4aCzbwy0LTxBRLdO7F8n86VnbZYLQcx5VSoeRK9TfX7/sn5GSCgwksIdYYRfv
         aoi+fHMmv1oFjUARbFl+lKCZ/5REIBR/gj9UvJsoWmKqwNT7+QpPUoJP4AWtCQObxM8x
         wNqZkMSKh7H4jP+7Tp34TneLO6fPtq0MKJb0/4a+J4Kqok2q4Pb9RTjAinigsUAmTmCW
         7zVNdYNtg4hM8IPLAsu45cQvqzrANVcX+ljV63Y5qkn5o4Grd2mpcalWH3gGCbRY9cuU
         yGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701260060; x=1701864860;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AsQvimBOnTjXGdKhEAnGYzR8KiGWDUYPadmCZZ7TXho=;
        b=qtXWVZ3LSSdB0VlT6rntm3S29Mdet4rKCJ89qxyEbxXAOo0UKn2CQA9WgEaJaRhcf4
         Y3/BF6ggSnRoXSdSiTfUvUgR3Gt2+1fY3g+2gZco1gIKYR02zdSnvkWjaxK21QmhoMnd
         4g4E05wcAim9LmpgHExrC/R+mKbCN2TGflwdqk2M5q996Wo9y6xIPfZkpT0QHyrnZvO6
         X2AihNdAySoNO6gs+ppUv8V3U0CoMwf9as3n+a1JkzF6G5jp4CDnCNoEslBr3opU2xr2
         rlwoic5UjZZhYDLtu992AN7kl1NBPWeAqap5kereK2IpniFfo+MjL5Z8W3mSI4nkOg5J
         84eQ==
X-Gm-Message-State: AOJu0YyXzJ4ndEV2DqN3Ew2RJMkYUzEZZbw1Ll7zrtCjT++dhvDJQ/fv
        hPCZ4uwXZyVAmjpBu4afPVewdQ==
X-Google-Smtp-Source: AGHT+IH4VTkrd6SDnt/sTDh9R9XPApG7O61ItmfuFh5MunMzdqfZlrOGpBMpkKqBpf907RBXyT1V9A==
X-Received: by 2002:adf:eb41:0:b0:333:727:2ff5 with SMTP id u1-20020adfeb41000000b0033307272ff5mr5299207wrn.9.1701260059703;
        Wed, 29 Nov 2023 04:14:19 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:38f1:13b7:9b7a:2d6b? ([2a05:6e02:1041:c10:38f1:13b7:9b7a:2d6b])
        by smtp.googlemail.com with ESMTPSA id f5-20020adffcc5000000b003313a1e0ba1sm14998254wrs.89.2023.11.29.04.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 04:14:19 -0800 (PST)
Message-ID: <673c06e7-61a8-450f-96c9-35bb0e1fe111@linaro.org>
Date:   Wed, 29 Nov 2023 13:14:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] dt-bindings: thermal: convert Mediatek Thermal to the
 json-schema
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20231117052214.24554-1-zajec5@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231117052214.24554-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2023 06:22, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This helps validating DTS files. Introduced changes:
> 1. Improved title
> 2. Simplified description (dropped "This describes the device tree...")
> 3. Dropped undocumented "reset-names" from example
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---

Applied, thanks



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

