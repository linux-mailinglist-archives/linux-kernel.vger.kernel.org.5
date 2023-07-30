Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B8B7684CC
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 12:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjG3KN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 06:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjG3KNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 06:13:25 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D6C189
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 03:13:22 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so9951748a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 03:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690712001; x=1691316801;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mUIpalybnyNZGM7m37yQpOMZS097BrfIytGo6aYsQJk=;
        b=TARhLjvjexOmPMBQ2eWGFYVDYxr20CqJxGLHdw8WuUi6qh2HFY1Xr3MvWfOyVaVC1u
         bu4jZtQWs9JceDRXmwABMqFVBMz1wLeC68Pp+pb+BvE3Qtm9FRL3Y4dInRuN7bEnTsV2
         kmX6IEjEL3MD8iG3Aw7W+hRNwmx0kusl7+sWpFpiZniwlr4mln7exmMKgaEY0mEP6hNf
         W8+hv5UfVTtdivQ2bsYrb1KNKsmnZmpg02+uy5lVRVSTTS+fbeyQtUTkqYcIkkZw2nNe
         0Z+q2fWix+X9PSUBuu2J5dX2XEixXTtKNRwp4hfvvkmUByB//4PddiArKBeEOfT/pXvV
         c04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690712001; x=1691316801;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mUIpalybnyNZGM7m37yQpOMZS097BrfIytGo6aYsQJk=;
        b=K/IW2abc7f2oBWrS6KQG9teauGzJl6YzBvHMQjsrqz+baYKoj+pR7UOVKX/W/cM+Js
         bz8HHbqpswbkkq7w15KsHtBfeuLaSP0qwycdQ9X8nE4dovkl/KBX6vgDui7vlvI5Wgd5
         3vTR5mcGSyjAJ6OwwZbEYRYca74Y8uQBIYvPFRSv+0wEWK7NC04kaaWBGU9PJxaQex2s
         57FmOiFHj3EAmu7VneTpiNJvAr7qq3tsSG1IMYS1oFb1hwCmqqCyKDgxwytEXiolKLgI
         xoV9QLWNzJsX/S0JXGytc5HDkzgh4tYsq9KPNkYnTna/ovriEj2ZhKz1ky6LKCoeo5fC
         QyYA==
X-Gm-Message-State: ABy/qLY4vTuSVL2HMoBkdmOQYohFIwyhi/tj2BGvQcyha8910c7UmAQV
        z4vp1XUBJcLllUZtRPXnzyvl2/opSPfiYGnY0jU=
X-Google-Smtp-Source: APBJJlFZ3wYP/rI7D5Oz71dJDhBVM2ZfhYomsADL9hmNt8xm8/qpGkVdVghkrJnOoXreZb2+tyE9Bg==
X-Received: by 2002:a05:6402:3508:b0:51d:cf7b:c9f0 with SMTP id b8-20020a056402350800b0051dcf7bc9f0mr11812010edd.12.1690712001238;
        Sun, 30 Jul 2023 03:13:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id p17-20020aa7d311000000b005224f840130sm3914851edq.60.2023.07.30.03.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 03:13:20 -0700 (PDT)
Message-ID: <8ee50871-e299-7a2e-2ece-a43e8263f6b5@linaro.org>
Date:   Sun, 30 Jul 2023 12:13:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v4 1/4] arm64: dts: lx2160a: describe the SerDes block #2
To:     Josua Mayer <josua@solid-run.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230730092422.16771-1-josua@solid-run.com>
 <20230730092422.16771-2-josua@solid-run.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230730092422.16771-2-josua@solid-run.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2023 11:24, Josua Mayer wrote:
> Add description for the LX2160A second SerDes block.
> It is functionally identical to the first one already added in:
> 
> 3cbe93a "arch: arm64: dts: lx2160a: describe the SerDes block #1"

Please use proper commit xxx syntax as asked by checkpatch.



Best regards,
Krzysztof

