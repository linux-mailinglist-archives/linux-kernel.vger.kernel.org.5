Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872F87AC43F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 20:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjIWSCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 14:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjIWSCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 14:02:23 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D21F7
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 11:02:16 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50437c618b4so4045028e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 11:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695492135; x=1696096935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e2+w/hIMeCdP5XObJabV3a0a034s6znbmDpY5rWOZME=;
        b=KPrGB3EZnAN+ABl4oSX71hIMndAD7osVuoTYxpBRx/U9eQ0xqb+tAxr3DfZuAHT2nq
         CkET4dcq3Jcf5qbgAR12eD+xLX58tFdYKl4S9kqJDuumBUYZvarFSVLfRxoIzQynntBe
         iypR3CJ67aN+xL/gaEn73ZOo72ZqO4KmBFLKWi+Cb8zsgUgz3VlIC7f6Uvxa1tczoePl
         676SE0YxzmSF9UN2pPr2PPM9e5ljReG6sH5/rWsqLvfZIpLWoIKjHWBSeOo/dA+GgFJv
         oWjup+PYJ9I+hmbU6bnL4szd16eumfnUSrJmZsDwaQEzCzP7v7lzN40noQLJjwGIBKBh
         qjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695492135; x=1696096935;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e2+w/hIMeCdP5XObJabV3a0a034s6znbmDpY5rWOZME=;
        b=ESd/ECLPZrlHNxCJKuWxkWXhEMXAEQvIstQqfEu3P+6MDvl7ms5iZGesN/DeirZOQ+
         3EXVvXwEqTOE9kymPHdBAdCEnHcGxxWgHHNGmejELpteWB7xPo4DM41KF+d2g93Bpgmg
         mdQOHFdfP1Y9poVtmlpvz2loP444IIzvAHrRE5ZnYnfkSHdZHH13JBhzZ54qWwgs8kQR
         AapBen/DvknmNOyzJptBh7ylOe86zJ3dzCgRlTrFwkQA5q8A3dR13LaUiI4BFNHg7N9e
         VNSCHBLTFqbNh+jihsrB+NkrXza/wy+YQU+2tpxBehQMRjZsLjskVCUozxL0B7Tutj7V
         wAdA==
X-Gm-Message-State: AOJu0YzhfNMOfAUuRHPdBO5KB8g4QWYOUgCxUB3W5IdaXI6aaAq7lnty
        Y05BeaD0Y2sMbGkcehKYVEW2fg==
X-Google-Smtp-Source: AGHT+IE9QFZHI8Y6so7/mo4x5KEZ3eDde8p0i5eSPhIKMUzOwbXushpkR+BjNRjB7kVP3w1OZaAbjA==
X-Received: by 2002:a05:6512:3415:b0:503:3756:9ff1 with SMTP id i21-20020a056512341500b0050337569ff1mr2078800lfr.49.1695492134868;
        Sat, 23 Sep 2023 11:02:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id cb9-20020a0564020b6900b00533ec6c617asm132069edb.54.2023.09.23.11.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 11:02:14 -0700 (PDT)
Message-ID: <797fc698-54d2-4848-3a4d-43ca631eb96d@linaro.org>
Date:   Sat, 23 Sep 2023 20:02:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 03/15] soc: mailbox: Add SPR definition for GCE
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Elvis Wang <Elvis.Wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230918192204.32263-1-jason-jh.lin@mediatek.com>
 <20230918192204.32263-4-jason-jh.lin@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230918192204.32263-4-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/2023 21:21, Jason-JH.Lin wrote:
> GCE has specific purpose registers, abbreviated as SPR.
> Client can us SPR to store data or programs.
> 
> In CMDQ driver, it allows client to STORE or LOAD data into SPR.
> The value stored in SPR will be cleared after reset GCE HW thread.
> 
> There are 4 SPR (register index 0 - 3) in every GCE HW thread.
> SPR is thread-independent and HW secure protected.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
>  include/linux/soc/mediatek/mtk-cmdq.h | 5 +++++

There is no user of this... Why do you add unused defines?

Best regards,
Krzysztof

