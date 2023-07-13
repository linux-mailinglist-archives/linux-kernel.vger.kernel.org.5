Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD558751FB0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbjGMLQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjGMLQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:16:24 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E08211C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 04:16:23 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbc244d384so5197985e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 04:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689246982; x=1691838982;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/t01C0EN/QpTHgEBz222IZKPLFehmewtEJJGjauLMaI=;
        b=eRP3N/6ImevwUzf9czr7Mdt+g6cvqkQ7wpsBpGJHV8fbjaClh7al/4pY9OBafDFXYA
         D5TdzfwwF2JW1E/2TjAQmgik9OXcJalB1dLjaOeaO2ITcgq3u2mxIoqJlZ1B/PdvVULq
         jbEAGF9XLNZZpgq9dS/BlGBYpEVagd0o9mskBHewBAV95kCHgUzR3XylysPYiz+frBXz
         glgLnxxraooy6deqE2iRPcirfNU3mtSea43nn7beyTfS5aD1PbQ51yh64ceH8hJtJWZo
         La54GOgtvu8KVi7v78PRVbsRls5NHtkdWRIOZVeyWopj/iIw0gT8dFXTeOAhnieXx7oJ
         MgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689246982; x=1691838982;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/t01C0EN/QpTHgEBz222IZKPLFehmewtEJJGjauLMaI=;
        b=NtMJ/iyJQLRlhzowtfssQiK/xph7jSckMUILOjaqBNFBzhc2MfsO5u/C3p3ikPl6RK
         FdZCkDpPHWjKIt3K2QYXCAIFKdydZeX8w16AzMNO/Umu5FxfUnudCT8kPfS577MDxIl3
         UomwZ49ZMrR7/RIeibFxoy+AwgxM/a116oPea8Dn0spyq9wsWZ13RnJfNTrbLfi3j3NR
         2OFiOjvtLq1yUs27o3379qQiq/yMOa+RdcYEPMGkznC5wfi34cUKHdtZn9aSi7LZ0QU4
         YqV2neIb3tkB8XP2wfEGSkodXVREpNl3TLuNjXxv56kBCPJgVGQuUswLTkc/Ocq6iz/Y
         Am7A==
X-Gm-Message-State: ABy/qLai1E2q4LGNPo2X8j/wXUfScPo7J+pJ99HkmAFTdyG3j+EvsfNt
        WZtKgJ8j4V8ExtH/Hct7ZS+RWWW0EJN5dORM9kI25A==
X-Google-Smtp-Source: APBJJlGmlptlgLgKMVcHCZdHYBHYEoZEjp0eeJuOJ8LpxrUplb1P3+Uoj54fMqYDX19vmUDfuXT51w==
X-Received: by 2002:a05:6000:181b:b0:313:f86f:2851 with SMTP id m27-20020a056000181b00b00313f86f2851mr1336211wrh.3.1689246982433;
        Thu, 13 Jul 2023 04:16:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id k4-20020a056000004400b00314326c91e2sm7702997wrx.28.2023.07.13.04.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 04:16:21 -0700 (PDT)
Message-ID: <f2cf63ac-9bf4-157a-b24e-58dc31336d63@linaro.org>
Date:   Thu, 13 Jul 2023 13:16:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 net-next 1/9] dt-bindings: net: mediatek,net: add
 missing mediatek,mt7621-eth
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>,
        =?UTF-8?Q?Bj=c3=b8rn_Mork?= <bjorn@mork.no>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Ungerer <gerg@kernel.org>
References: <cover.1689012506.git.daniel@makrotopia.org>
 <c472c5611c9c7133978b312a766295a975a0e91a.1689012506.git.daniel@makrotopia.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c472c5611c9c7133978b312a766295a975a0e91a.1689012506.git.daniel@makrotopia.org>
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

On 13/07/2023 04:17, Daniel Golle wrote:
> Document the Ethernet controller found in the MediaTek MT7621 MIPS SoC
> family which is supported by the mtk_eth_soc driver.
> 
> Fixes: 889bcbdeee57 ("net: ethernet: mediatek: support MT7621 SoC ethernet hardware")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

