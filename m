Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347097A17CF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjIOHwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjIOHwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:52:41 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F755A1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:52:36 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52889bc61b6so2172984a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694764355; x=1695369155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1DmNveiP8xHX58IAf7GJRRnmwEbVvFnwIttOiAgQ004=;
        b=L4RaL8CdamXJ1n961ofptOQG6ridNxCCg5vq0sHVgSbBVHxurZNySoZqTjeKRBs/5H
         TzR3JULwJo3R0RGeUhiNKjwtn20QYnTFfpRvQw22B9AclekwX7HaPirYX5u5EYxmK8tf
         iyKTRDgjlO4m7eQt1c7bjHNnHvbxlXwPvD98TOn1GNXH/M6pWKUMKmfBiIJl7oTIwZvj
         T9b9Mk9e835KG+DFnjpCXkWlMd4rhWMqn+LtWkd7GW1oJdIWaK3MVwc/VtcL047nrBIW
         0mKKaS31UfhxiyzAPNwuO3i945KBDuWxyjzIYD7GctivBHf/QFQBBDBfxdYuaiwWZbm5
         UEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694764355; x=1695369155;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1DmNveiP8xHX58IAf7GJRRnmwEbVvFnwIttOiAgQ004=;
        b=WeW7oOt4JF/PrJAzG4p06V5fiVOPkEaNvGPrUGth11c63Q98uZNxWVWl1yWtH+ju2A
         OT1pTY0z0wLsx060/RzXmmjcnM0tqK1BsQFEWiJsHn3D3zRbTMOQP1ICvC5S0y+SUCxm
         qciMKBUZv2YW++UNV7wzJlcu7FOIKmNaU0agnbDdniZhzIQIMkK3ndsn8KY40tZePaB7
         pkQ+DsXnim3N70X5Yj3zbuidAZJUv7SKQfnN2ajwE+eQiUYPCmUjHfTKtcu9DgdTvDSx
         uxkRVmu6TWfTftqyNDksMDiw9xqPTOExDtKILVVb6FUAJhiZIbHGf55xnhlB4AjlqT1Q
         Yufg==
X-Gm-Message-State: AOJu0Yx8vo8U1hW9c868j7AuSbgN/QPo7cxjC1L8Ae5yd7lU4ZDQGXPr
        lxI/05mIppY3aHJ13FIAjFokdQ==
X-Google-Smtp-Source: AGHT+IG3viMjTUAP25MuwtYIdv3N1ev0u+/SYqVBSVH0BOrYl2RsGa4IaFywaU+81yE3KsWBeGeP+A==
X-Received: by 2002:a05:6402:14c4:b0:52a:1c3c:2ecc with SMTP id f4-20020a05640214c400b0052a1c3c2eccmr687838edx.25.1694764355070;
        Fri, 15 Sep 2023 00:52:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id dm6-20020a05640222c600b0053090e2afafsm328735edb.22.2023.09.15.00.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 00:52:34 -0700 (PDT)
Message-ID: <83142b6a-90da-b705-5170-5468175cf23d@linaro.org>
Date:   Fri, 15 Sep 2023 09:52:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v1 1/2] dt-bindings: soc: mediatek: add mt8188 svs
 dt-bindings
Content-Language: en-US
To:     Mark Tseng <chun-jen.tseng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Roger Lu <roger.lu@mediatek.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230915075003.1552-1-chun-jen.tseng@mediatek.com>
 <20230915075003.1552-2-chun-jen.tseng@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915075003.1552-2-chun-jen.tseng@mediatek.com>
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

On 15/09/2023 09:50, Mark Tseng wrote:
> Add mt8188 svs compatible in dt-bindings.
> 
> Signed-off-by: Mark Tseng <chun-jen.tseng@mediatek.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

