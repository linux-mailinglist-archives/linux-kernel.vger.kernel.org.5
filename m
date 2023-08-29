Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7485778CB3D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237497AbjH2R1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237823AbjH2R1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:27:18 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECEACCF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:26:42 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bcfd3220d3so53500111fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693329960; x=1693934760;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XASF6L+CFT37xAgTRLzvSw5XT/pAT+qRxQqIx8eoTe4=;
        b=kHbU+j63kRJgi19vriktot12nqwsQEFKOH92u6vdDrVpsZweOAUzFYD2jMRVZONtHB
         8oqMSawB5f/rUfbFdyoZZSeSbQNp2Qy7tR6DgybERzmJT83rICzzkoGQk2XZqyk7ctcd
         Qo0qLiW6c+Mhy6O1SSArqwSPnfoadLxFuMEsFg3G5OIFeYHbeEBWIrmo47N/zTLK6vK2
         S/2YVtg1nm66M3w6dqaNW1lkwhijfgcUAld2IqWjubjKAGtF3wRtAGth+yw0t4R+knpp
         9Yrrzco7+yLakp+f28SG+mWHIxXeTmtvIx6njQcK2459fq8ot/epCFFuSlkLUrDBPC65
         rAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693329960; x=1693934760;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XASF6L+CFT37xAgTRLzvSw5XT/pAT+qRxQqIx8eoTe4=;
        b=cI2dXLsDHSEVGcgB2u6pAoMU6nOQBY352BKESz70jpNrZWGPJ8ZntScD8uIn5M4Q4C
         4l0Wg3H7SiLW/7wk19YDB1Mv3o4soZ/LmUe+dgiMnj5GW9QnVjpFhQH50xrmk6Bb4Jgf
         NpFYaiKWc9c010DsEVJf0WmP9HNcjlFaLp09DGrOxZAaqKu6JUXpJAPkS3XaOszemapb
         x4h4FBPvR3AUBZW/8YcPHyZB7rG7Cyb+iUqVmjiHCIbtQOljuC4VvE3ROIQw4JZ5zUn0
         BQvcnFipsuSnSBV+A1gEzkO85PJ73BL88REhezr6/k9DIhN5dOv2+rktWI37suqDmKsq
         6MUQ==
X-Gm-Message-State: AOJu0Yx3lMQ1NtvY8LFOSlkSy3RDoyNJy8+K/+LmQjcxA8JtBdAHXTy4
        4ixzr+RqagQjBbzE2i0eWikgSQ==
X-Google-Smtp-Source: AGHT+IGHdaXGoRpgBFSCCGbMrc9WN2vaolT0HlJjcJrqIeZe/CQVLwYV84VHWJ3Nah14pPFkboyfcA==
X-Received: by 2002:a2e:9649:0:b0:2bc:c28c:a2b8 with SMTP id z9-20020a2e9649000000b002bcc28ca2b8mr17205992ljh.27.1693329959883;
        Tue, 29 Aug 2023 10:25:59 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id vw13-20020a170907058d00b00993664a9987sm6181867ejb.103.2023.08.29.10.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 10:25:59 -0700 (PDT)
Message-ID: <4343e032-aafe-ed57-9374-c21961926184@linaro.org>
Date:   Tue, 29 Aug 2023 19:25:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 17/31] ARM: dts: rockchip: Add CPU resets for RK312x
Content-Language: en-US
To:     Alex Bee <knaerzche@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-clk@vger.kernel.org, linux-phy@lists.infradead.org
References: <20230829171647.187787-1-knaerzche@gmail.com>
 <20230829171647.187787-18-knaerzche@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230829171647.187787-18-knaerzche@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 19:16, Alex Bee wrote:
> Add the reset controls for all 4 cpu cores.

This we see from the diff. Commit should say why.


Best regards,
Krzysztof

