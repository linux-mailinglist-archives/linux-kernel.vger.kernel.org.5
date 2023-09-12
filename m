Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC01179C9C6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjILIXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjILIXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:23:44 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EA7E7F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:23:40 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52f31fb26e2so3328617a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694507019; x=1695111819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NecnTNhEs6mk/7xS4+yPxPBE+Iq+otCfvP8k/SUlgdY=;
        b=cTUE7eaKTYcped+fkAc0xrMYniEqxAnfsNugnVq3k0uR0MrE4x+a9d+HCe9BnyIq0s
         lT7JHB0TpdIO4AnaB6p7efaHEX2MXC0MwkSESYSZ1Ld831bSwKpy6O0z65V/ivyqe3Kd
         WxkA6ljlWNUN4/fWnZB0l3qPM/s4vjC9SY5RJTOVUhluyvfMXv9EMB6WStVUmIUXUi1f
         LbM7u5mDaR4RIZmMHzdqbcXff8qlpuyTS9/KJlae50NqXwRLWy5rZpJV8EgxL3LDGkyf
         Ebvxg/b9wwAxMYADVS/fcHXHMneV4q/8GLxCyUm5zZQl5u7l51oHAg8IROUVExaBACcp
         MDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694507019; x=1695111819;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NecnTNhEs6mk/7xS4+yPxPBE+Iq+otCfvP8k/SUlgdY=;
        b=vhgEyeiGNlX7v4l4YclS5ZhaczNKkUswGx6FQVXckxrcPCgQNG0koUBEBJ3M8Aemxn
         jgKpmLk/Yjs/B8cIvUGXjHIAOLojcHYRjAi9+MmcgOczBHFAy0kZ5ooI7vaavVCmaUD/
         hLnt/Db/zcIYvtHyOlT/wERLt2tyuO3eZB7BJvuZcit/N5d6UuWB+P4PgG/OcRkoJW8M
         xqgBLrOVDqYLh4TFxbgoRDnofo/d/nBjFgfafsA2Nzbj5DOJ/E5rmO/ZdVkhbs/3mj9p
         6cvguEVfav0Xv8DP8XGoDR/ndMv8/Dv4EqutEXNClXq94ouUCU9HAfZOli0QZ2arysE3
         I62Q==
X-Gm-Message-State: AOJu0YzU6cu7yAYrkKBuMMIzs03plYi1RdbqdzxRBIquAk5VQY1cPZZr
        2IFd6TSE2BSey2WMlZBkuCebTQ==
X-Google-Smtp-Source: AGHT+IFUhAhviWgQLFU03MSAKRTyIaNN7fIQ2Ll6cz8uur8tvWrxceUtpGTQvZh5kUvI/HNWPpsu2g==
X-Received: by 2002:a17:907:a0c6:b0:9a2:86a:f9b7 with SMTP id hw6-20020a170907a0c600b009a2086af9b7mr9091015ejc.59.1694507018283;
        Tue, 12 Sep 2023 01:23:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id rh16-20020a17090720f000b0098e0a937a6asm6416288ejb.69.2023.09.12.01.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 01:23:37 -0700 (PDT)
Message-ID: <c64efa17-704d-0bb0-da91-5658bc0bf34e@linaro.org>
Date:   Tue, 12 Sep 2023 10:23:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v5 02/14] arm64: dts: mediatek: mt8195: add MDP3 nodes
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230912075805.11432-1-moudy.ho@mediatek.com>
 <20230912075805.11432-3-moudy.ho@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230912075805.11432-3-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2023 09:57, Moudy Ho wrote:
> Add device nodes for Media Data Path 3 (MDP3) modules.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 378 +++++++++++++++++++++++
>  1 file changed, 378 insertions(+)

Why is this targeting media? No, don't. DTS goes via SoC, not media.
Don't mix patches.

Best regards,
Krzysztof

