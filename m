Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B472479E1E4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238519AbjIMIV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjIMIV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:21:27 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30776C3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:21:23 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4013454fa93so74014685e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694593281; x=1695198081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6yV/iPlTqbuR7AJsSEy3NRKH56jsiO3itpIr2ZhKOxI=;
        b=yVfKSei8VNyZkc0L2zghH0JbVEFpkjWBpXkuTkuiMOD3LJUWYCOK1K1qHmHMJ36Jik
         +GZWHiIQnDbYqBjVPHfz7C7TWazrmiqFj9l59T+cTs3PfY//e5O3CKsYiZaMUBud0w24
         7gzqlby2ZyHxFseOJQvXti52lwU4UxbCmWuZvAUB/z5m84saQ2fyl092tuI6LkR9P4rw
         8DPN6KnuG16UqCMa9rQ7FBA0Ckn7EmMDNBpeWlmvuS3R8tfDBBeMJWsQ6XPPNM5zF/GR
         eQethTSBwtC4/1m1Rf+vXUxh4DDQez+Oqd1Ks7l5KTujiTfJaeEXlJZIt6FCxwmGa8sR
         Mpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694593281; x=1695198081;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6yV/iPlTqbuR7AJsSEy3NRKH56jsiO3itpIr2ZhKOxI=;
        b=EJsc96BU1kwQbTyedndp0WpeLAA0jFIbicYeudg7ANIEtrlqpU3yti5qJBoMugbcPc
         I1bJbeTqcN3zHSYepn7/OAKjoj81dHjuJVCZnHUqtF6IHJUBoM4ykA6ErYRxu965jWnf
         W4pRVPULcHppepdAgm0mYZQCtBEGtOfEuHPFM/TjNDqtQ4Oc2cDEo0cV9pbgycdmDIvQ
         LFJWAchodGPKDS3oY6aneAh6ClQ6/qLqZMIuaJGEKVLhwXtKXEC911Kmj73CxO9Fg6KK
         XBbSF4ALi25T/tHR4H9zgIK32LI7KQMpuSnr4CANKypj4L4UelbsXQ5lODgpIc8e3rj+
         KL+g==
X-Gm-Message-State: AOJu0YwnIEbicimHi+eL2g6ZIBnDgLcdBXpWPVqG58obGXxPxplgcuzS
        N8QaZ2BQ6xCUpG4PjH+geXZpUqP9zJ3Hg0M9qfU=
X-Google-Smtp-Source: AGHT+IEdMCGleJenSkST6EFbu5Qz4wEAy04mq+fsiN3qwHV8D/PMO8U98ONfNDNkfas/yiQbKOrXSA==
X-Received: by 2002:a1c:4c16:0:b0:3fe:dcd0:2e32 with SMTP id z22-20020a1c4c16000000b003fedcd02e32mr1357415wmf.19.1694593281687;
        Wed, 13 Sep 2023 01:21:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id t22-20020a7bc3d6000000b003fe1fe56202sm1286245wmj.33.2023.09.13.01.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 01:21:21 -0700 (PDT)
Message-ID: <f3100f6c-926a-7fb8-793a-d930e6b720c5@linaro.org>
Date:   Wed, 13 Sep 2023 10:21:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: Minerva: Add Facebook Minerva CMC
 board
Content-Language: en-US
To:     yangchen.openbmc@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     patrick@stwcx.xyz, Jerry.Lin@quantatw.com, Eddie.Chen@quantatw.com,
        EasonChen1@quantatw.com
References: <20230912140532.3797736-1-yangchen.openbmc@gmail.com>
 <20230912140532.3797736-3-yangchen.openbmc@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230912140532.3797736-3-yangchen.openbmc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2023 16:05, yangchen.openbmc@gmail.com wrote:
> From: Yang Chen <yangchen.openbmc@gmail.com>
> 
> Add linux device tree entry related to the Minerva Chassis Management
> Controller (CMC) specific devices connected to the Aspeed SoC (AST2600).
> 
> Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>

Also looks like a duplicate.

Best regards,
Krzysztof

