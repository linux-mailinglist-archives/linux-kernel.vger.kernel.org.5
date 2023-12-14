Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE50B812F76
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444137AbjLNLxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444112AbjLNLxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:53:30 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6B5B7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:53:36 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50bdec453c8so9447691e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702554814; x=1703159614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KttnO4PIiCaAGSytE92u74iuSMSOKJ5regNQ/EC5WuQ=;
        b=dUcRY+xcez7rKlURdw2AFGWcNBBuRihJ9ggWBlAMEw9RizFwTpyX8PyDEezOXkPFub
         Xkg/t2pA8rxDeWbxrP8RnPS5Y/2yre721nd1j/1cFbhQC+P3jrTx8ZuBn8+oeyT3NSkE
         lxsBqMDvhPASxFGvS1IusI72EXuYJdFrSHeGhTv+cLyiPXLKZz+082IjfqZWVgxQczWa
         Z1kx6ONvpsCF49wx1usk/VJmAMiDltXf1pn4Hh+idWI1V8CcGnQtO2s4uWwJVTnKu1XA
         P6n8gakR5YKuPSTLNCNPqz+DUNA2XTktgPFzrhZqeTa8at/pER4a0RV4TWwBazoywj2x
         MD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702554814; x=1703159614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KttnO4PIiCaAGSytE92u74iuSMSOKJ5regNQ/EC5WuQ=;
        b=tIrn0EHXV9Tvl70p7f1drXqroOad5+58OyVPNccBwK6E/OUd7+/TzacerRKBrrqua1
         R9st6MeCSz4xoDE2qpgi+VI8WSVshPIeWV69InsIfiOoENdPs6Nr/b2jxBMkrAGgkVki
         b+h19RCIHIh01suEBFCmRmHyBeQP+vh64e0KwAYduOaLkaWKxCHrOCzQbW8bE3+/20+J
         itD3ETronAo9tplEz+I/D1k65Qzxk+kiYMcc8op1RbIEskA78r7nzp7/mg9pQM/cSLIc
         66YddrEYsQQRGkQPQoWxX+Akx74p4fdHdTQ2lzGJPieeEWF4sz3Bfbbhw8+dHXsfhxg1
         +NCw==
X-Gm-Message-State: AOJu0Yw7x3DuIUGIl1+c0P9BPzU6GdMcEyrJMZaIIia9X7KdRWCfarMx
        rlu/6NyxV8K9A4ZPg/BI8Q3O1Q==
X-Google-Smtp-Source: AGHT+IFKAUpNpfuAuwpUiHGvkKtTTxlNLOoY8GwwQiOzDKup6y8DvTMvl5/GS7Uobt3Q4SD5/EbY3A==
X-Received: by 2002:ac2:4219:0:b0:50b:f305:7802 with SMTP id y25-20020ac24219000000b0050bf3057802mr3932763lfh.129.1702554814419;
        Thu, 14 Dec 2023 03:53:34 -0800 (PST)
Received: from [172.30.204.158] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id y14-20020ac2446e000000b0050e1633748dsm183444lfl.206.2023.12.14.03.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 03:53:34 -0800 (PST)
Message-ID: <2890ae71-aed0-451d-a7fb-7db30c30b72b@linaro.org>
Date:   Thu, 14 Dec 2023 12:53:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/6] arm: arm64: dts: Enable cros-ec-spi as wake source
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Hasemeyer <markhas@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Raul Rangel <rrangel@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Andy Gross <agross@kernel.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Bjorn Andersson <andersson@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@amd.com>,
        Paul Barker <paul.barker@sancloud.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20231213110009.v1.1.Ifd0903f1c351e84376d71dbdadbd43931197f5ea@changeid>
 <20231213110009.v1.2.I274b2d2255eb539cc9d251c9d65a385cc4014c79@changeid>
 <e5625051-e9e2-4a75-a11a-cf5b40606fa4@collabora.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <e5625051-e9e2-4a75-a11a-cf5b40606fa4@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/23 11:55, AngeloGioacchino Del Regno wrote:
> Il 13/12/23 19:00, Mark Hasemeyer ha scritto:
>> The cros_ec driver currently assumes that cros-ec-spi compatible device
>> nodes are a wakeup-source even though the wakeup-source property is not
>> defined.
>>
>> Add the wakeup-source property to all cros-ec-spi compatible device
>> nodes to match expected behavior.
>>
>> Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
> 
> I received only patch [2/6] - please send the entire series to the relevant
> maintainers, as otherwise it's difficult to understand what's going on.
> 
> As for this patch alone:
>   1. arch/arm stuff goes to a different commit
>   2. I would prefer if you split per-arch and per-SoC.
+1, otherwise *somebody* will get merge conflicts that - even
if trivial - take additional time to resolve :(

Konrad
