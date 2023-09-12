Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637DC79D3D2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbjILOfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236054AbjILOfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:35:13 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B4B10CA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:35:02 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso5393103f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694529301; x=1695134101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N3T2cJ5Dg3KIAmwCPxCvyN1h31PBOD8rwtyP0zH6rYc=;
        b=tbJl41484BBofbo1UJWPoUaxvxeUGOUcc9688OHjrxQDQhOwQtXCBK58g0CwNtO0Ua
         8Wh+vOh1EGSEzmx1/pMq0kI8csD5vw3sx8viCkKYiMK2XJLx1oqg1OQhFFZNJQsynZe6
         FE0ucyGKvVP/qd1rTZ5nuoBEWOI5UXL6Bc8yr3zLUaKM4hYlIsErCEpyjwFl6JCV4HI3
         9sXBWV35MF+273hxHvqCyKpISWTu3dXieqT8cIUFIsMoH62yQSXMbOvR8YuLRKBgsud0
         yfVQN+7QW8NhaG8FykEkyQ5rUvftaiVyWhalv7COyZCdmvZyrG7XcEuC4VwmQTxwC2LS
         zY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694529301; x=1695134101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N3T2cJ5Dg3KIAmwCPxCvyN1h31PBOD8rwtyP0zH6rYc=;
        b=ZFTCE31etz/uN4YQFDx3wye45+CRNzHgYym1ZoN9wjEy41yMLJkuD44XPumttc29Yh
         r6Ht3zksIUp7Tees9rSS2dmcF2VZwMNa3lJ6REFOponlDpUWv3+80WPJ6o6gPbWQc+Ip
         FW0bW5BlBEfti1BxCPk+V3GV+HSUUEh5wRTm8cV1R2aei4/jUAlfmw4XF6WpFgeHsXSF
         18WQENbIW0Rd9RcBUBkITcno02bWAZiYXzqv/bnvVo+R+sOdmNi93lYq8CSnk8Zrbq6t
         BXch+5aiFOyvHY0BOJzvpN9+KvMnFEeVp0wLrofyPIVhRM41FcYnMXKpXNrSzMkewztG
         Y+zg==
X-Gm-Message-State: AOJu0YxEp28Ps4Wjwv07E6bnG7Q7keekk+DSoKbn6DPSZWq5mz0drq3w
        pqU0A7VuHE6jZQl6F+jxMmaE+Q==
X-Google-Smtp-Source: AGHT+IGeR8boTA8vqNczXJ0BK+AGIug4TqyTfXy7WOaSTRnGdevow91B/8GXgcQ9xvO1ZycDBEh7Hg==
X-Received: by 2002:a5d:5446:0:b0:317:5849:c2e0 with SMTP id w6-20020a5d5446000000b003175849c2e0mr11385937wrv.9.1694529301359;
        Tue, 12 Sep 2023 07:35:01 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id y17-20020adff151000000b0031c5dda3aedsm13067440wro.95.2023.09.12.07.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 07:35:00 -0700 (PDT)
Message-ID: <f417f936-2f07-b8fd-2b7f-37f4cb287d63@linaro.org>
Date:   Tue, 12 Sep 2023 16:34:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 1/2] dt-bindings: arm64: dts: mediatek: mt8365-evk:
 update compatible
Content-Language: en-US
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>
References: <20230912092444.31635-1-macpaul.lin@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230912092444.31635-1-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2023 11:24, Macpaul Lin wrote:
> Update compatible of 'mediatek,mt8365-evk' from 'enum' to 'const'.

This we see from the diff. But why? Sorry, this change is pointless.
Also not really helpful, as the entry soon should be converted back to
enum...
> 


Best regards,
Krzysztof

