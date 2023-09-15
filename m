Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17ED7A1D0B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjIOLCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbjIOLCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:02:35 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62A32D51
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:00:14 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-401d6f6b2e0so19829965e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694775613; x=1695380413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fpbQlB4mjb78rjSUP8bafejWuvtuI54lBSHWWYp8cUk=;
        b=UCfXukospgjvAoNUKbNkhmfqlUFpn/hNNdyLCcMvwCsEIow/G6zupX5nigvTkaNUzE
         8Zpmbi9a2v+CNa3K9qxlqeFEgb8e3LD0CAq7L1JuSnfIpukO/hEtQ7sZrkWuWmjqHYoV
         N/ISWZw/Tq3u3nSFNYvx6g+KE8T/JYHkr/adJLuNkVXqnGZUhlvh+OMmqLHkumN2qDz/
         gcuDKK4sp4ecMQibt8Mz1vf54pjwr+UV/vXbru4iItjrgJPyf+dnQc0My4taw7ZLQzKU
         iQbS3pyxCmVlCK6fzoEGWfo6mZe/YCRq/nYA8Xzy4C6OVcqe9FGpQiR2QrBZ3HA+UgXP
         zzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694775613; x=1695380413;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fpbQlB4mjb78rjSUP8bafejWuvtuI54lBSHWWYp8cUk=;
        b=oNe/FJVSv/vzhGqI+zhg0c/saKjtZGhhZxA0k4ik8s9vAeBI4oX08a9j34SQid88IJ
         ZEoDiX03NSsaaEiAISnLGprw7CcVWVOAcdmuGTs0BYgOBRBPzAfdzYjHLo2nXZVwfXlQ
         4Qq3mCnnw8J4RAAVVYzfYmaWY/dMP9FJkEwzBmHCOzWTZlt5Rrv7k4h0GAC81MOBmAsN
         jJUiHi8OpmUSFYVN4URrOpxODaMBrTkrDxsluevVHyH//S/Rpf5MjckXdaiaPJ0EeGXq
         lvLaWNo3Y/RR/XwPd0oubiT1BzsDsCdnNZKMpeP92VkesiN231qEIwMRMaWn66D1Gndo
         pljA==
X-Gm-Message-State: AOJu0YyAEpoDKA1ruNXbRKlHaAmYZCmSvlmIczDOZDfaQ41gJAwHIIH1
        0f6tKPps+1pIdbdjVy5hL3TFbQ==
X-Google-Smtp-Source: AGHT+IEos45Zc8390rDkKHePbKN2uLHi9tDs+24aSbHmPKAWNb7n2370dfdwOZtcYbU8OWdym81xJQ==
X-Received: by 2002:a05:6000:8c:b0:31f:335b:f436 with SMTP id m12-20020a056000008c00b0031f335bf436mr2973131wrx.22.1694775613014;
        Fri, 15 Sep 2023 04:00:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id ci8-20020a5d5d88000000b0031fedb25b85sm1843665wrb.84.2023.09.15.04.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 04:00:12 -0700 (PDT)
Message-ID: <0a218ff4-9ef8-d18d-9310-4446dcf05795@linaro.org>
Date:   Fri, 15 Sep 2023 13:00:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 25/42] dt-bindings: mtd: Add ts7200 nand-controller
Content-Language: en-US
To:     nikita.shubin@maquefel.me,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
 <20230915-ep93xx-v4-25-a1d779dcec10@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915-ep93xx-v4-25-a1d779dcec10@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 10:11, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Add YAML bindings for ts7200 NAND Controller.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

