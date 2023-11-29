Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602D77FE336
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbjK2WdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjK2WdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:33:22 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F98B2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:33:27 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5c206572eedso260799a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701297207; x=1701902007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/N/aXZg/ugRiTyHLDtv8QsJaetFQFjEErGPMFO4www4=;
        b=UK4BaepYCqK1awXBxLiYTHOZFEH8x3rJGXNpqlo9hyUBypB5u/66xHOtDFphEzQZhR
         UDuIx8NJVURO6niPoa354JDhug2Z+eS+tK9DRyfWMxoEAemYj0QdyoiCMp+oYUjeA32K
         /P5iwoXojwNf9FDbn5tscMEMBSJj5+Z7l8IhIHdHN32/64cjjoaMYIqCO8MhxpHdxaa3
         pqZWBY5ta/4oeKCcY2nZpSi21zKEhKiHdT2i7O7eQWlzY4xVUCF42lediUpEOxmjh7F3
         j89DEZuOa77CjwetZsnVb+a4UCAK1iSfnnYtFFXu2+qmNa3xcJJjLezqBfn42LyUcIsa
         peIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701297207; x=1701902007;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/N/aXZg/ugRiTyHLDtv8QsJaetFQFjEErGPMFO4www4=;
        b=HXxzms8i4aMc3eG1Y85sH8/Gm2v5PFEN5hwgBPUo56zwk1XzzcHV15XsL/q3pv4aOw
         P1SB0m/9/m/Tks2ORUMcK1+8wEDm+7T0r6m+h57ku+HoScvlS9L1HdBOzORTxtz3EOP4
         J8FvQF7fZ2mVlPjrEfbvlsYgGpGaqVHRZdeZE9dLUNLghCgEWNZOLdOsTr9isxiSRy+o
         qRAodmsexZMm+5G5t0aAOHeAfiuQtaHmvJof3kSm5dyhK454TphqA60ZWj58XI6St+b+
         OZAVi0+Mhe1McJ/lvAwTviYVns4KyvYnBECfLmZsnUWlrsj+D9hFrXZxFIV/hyoeXsEH
         shHg==
X-Gm-Message-State: AOJu0YxcpTCEOxPIM8qKraul/olOsab5R+T4kA3vzNqEeUNhlhmjNsta
        v4k47pkvnS54fUOx8LJK56M=
X-Google-Smtp-Source: AGHT+IEHc3ggTtxA9JABbFLXY4x/k4xGK5j5x+tk5+GDx17wDW/cmC88uLz4XvocPsOO1DyltF+x/A==
X-Received: by 2002:a05:6a20:54a7:b0:18b:92b3:7c80 with SMTP id i39-20020a056a2054a700b0018b92b37c80mr27399341pzk.22.1701297207064;
        Wed, 29 Nov 2023 14:33:27 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id g4-20020a17090ace8400b00277560ecd5dsm1879096pju.46.2023.11.29.14.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 14:33:26 -0800 (PST)
Message-ID: <e8e7d4d8-524b-49d1-92c9-bf01fc4cea4c@gmail.com>
Date:   Wed, 29 Nov 2023 14:33:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] scripts/gdb/stackdepot: Rename pool_index to
 pools_num
Content-Language: en-US
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     casper.li@mediatek.com, chinwen.chang@mediatek.com,
        qun-wei.lin@mediatek.com, linux-mm@kvack.org,
        akpm@linux-foundation.org,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231129065142.13375-1-Kuan-Ying.Lee@mediatek.com>
 <20231129065142.13375-3-Kuan-Ying.Lee@mediatek.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231129065142.13375-3-Kuan-Ying.Lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/23 22:51, Kuan-Ying Lee wrote:
> After stackdepot evicting support patchset[1], we rename
> pool_index to pools_num.
> 
> To avoid from the below issue, we rename consistently in
> gdb scripts.
> 
> Python Exception <class 'gdb.error'>: No symbol "pool_index" in current
> context.
> Error occurred in Python: No symbol "pool_index" in current context.
> 
> [1] https://lore.kernel.org/linux-mm/cover.1700502145.git.andreyknvl@google.com/
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

