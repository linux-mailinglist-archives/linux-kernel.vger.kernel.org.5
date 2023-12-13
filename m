Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075DE812114
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 22:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjLMV7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 16:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjLMV7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 16:59:33 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FF6F2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 13:59:38 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c41b43e1eso49950285e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 13:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702504777; x=1703109577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5R8Y7jc9NLGPyREc0JUtb8eKm2rIjrA9+VPMF6ejgso=;
        b=rARAAgfggpKaYBcM/H+eaFDB6OIRzvUjMWoS7knwOlkZWyflKfmHqMebXrfScfvond
         faWMupomuwqUe7d8opNtIYgTVM8u9b5NtI0phgapI9bzmBpP3be1ur7XXo0bP1AOcvzC
         a2Nz4K16496ufgzpcmXZ27xDqlGvGDzKX/UOPf6LjAGabLDyd14F3izWsX4EL609X9pb
         FB/qrKN36oYpvz9UaV2AqBoZpHQGt3Ib4AyEwMKzYL2RBt3lK0L0fEsB/bTJUrizz7r6
         ZFs7eZY7gkZqlaEkFufyFhNT1Z1bxC+beVGXRDlubk8EncaQNjQn78wHVP/mqdbZa9d+
         RfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702504777; x=1703109577;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5R8Y7jc9NLGPyREc0JUtb8eKm2rIjrA9+VPMF6ejgso=;
        b=C2OuKWKrMWelwWtiJqLcerpnrk4n+JYkIZ55JrIknra5igyi8YOqZSFyweKwdsTmpI
         PWq0SKinncNQr/jh8xre9aUQcOCsiX2+Zlzz4+lo4AXtcuPLV83MpZMGiqRXB3CGSo6C
         eBDJPFXk+VKYP0NeygbeA231OsPNxjmL+VAYMBmndI8yMRHeFxNUm4WEQ/wCs9Vcz1Ne
         51pi2XjIiBNVApDlxwTkFnugIDGQpO6YPjIPqgZLo8PGkBQLmcHCoSfxhuYa7UAl8xLc
         npiKgdQ++HwZNPmUK1WYNG4/ESab6VOkeSaaqf5PRGernWUOjUQSzYjz8j0x3cCusBJh
         EnuA==
X-Gm-Message-State: AOJu0YwTwIXLJuUcZkCJ2Nvdltc0m49X3aLx9AXnY8ovepf8D/Caj9S8
        Yl3qQXad5dm7mv9wCINaA3uY7w==
X-Google-Smtp-Source: AGHT+IH8WBMrcy2RpgDyVtXzThQj76QcUxVNUDU/RnHWzVkOCspImqThjEx7TAvmErkgFn+mKeaRYg==
X-Received: by 2002:a05:600c:1f1a:b0:40c:314a:42e with SMTP id bd26-20020a05600c1f1a00b0040c314a042emr4345008wmb.246.1702504777134;
        Wed, 13 Dec 2023 13:59:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:ac4e:a5fe:7f71:8d59? ([2a01:e0a:982:cbb0:ac4e:a5fe:7f71:8d59])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0040b45356b72sm24189351wms.33.2023.12.13.13.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 13:59:36 -0800 (PST)
Message-ID: <98e93632-45e2-4d7b-bde2-4326d07b3c25@linaro.org>
Date:   Wed, 13 Dec 2023 22:59:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] Add displays support for bsh-smm-s2/pro boards
Content-Language: en-GB
To:     Rob Herring <robh@kernel.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robert Foss <rfoss@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
References: <20231213140437.2769508-1-dario.binacchi@amarulasolutions.com>
 <20231213175330.GA1582432-robh@kernel.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20231213175330.GA1582432-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 13/12/2023 à 18:53, Rob Herring a écrit :
> On Wed, Dec 13, 2023 at 03:03:41PM +0100, Dario Binacchi wrote:
>> The series adds drivers for the displays used by bsh-smm-s2/pro boards.
>> This required applying some patches to the samsung-dsim driver.
>>
>> Changes in v6:
>> - Drop patches:
>>    - [06/10] drm/panel: Add Synaptics R63353 panel driver
> 
> The binding should have gone with this. I'll apply it then.
> 
> Rob

Oops I missed it,

Thanks for applying it

Neil
