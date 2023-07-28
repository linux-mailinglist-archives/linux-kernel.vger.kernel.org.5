Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408927664CE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbjG1HIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbjG1HIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:08:02 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135F719AF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:08:01 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so6345188a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690528079; x=1691132879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4G0Yt706fhpMXSCAGIIvcxZcJifzL+wDvoJT3SfXuLs=;
        b=ZORaTNGv+CvRM8RV7qTkxrlIZFHoOtX6+YxTu3uPqwJG63mLmbaArl6KZ2PC9+Y+I6
         yxYI6a6fwnQG3ezftJEprJ0ZRA82Gppv2qHWHrOoOBSZMG8ztESAgIMXzFCFuMOnyY/a
         tA5nRupTSPYJo9VspBM8HD+bj5RzSWZ3hFFZJ3INgqlBNXZ9MUSRKkIfwQIWynRzuhUo
         F09XbNC2Vba9KJ/SM+ag4+sawgepaFIfOSiFxn83Xs63D/Rt08F0WQy8zpXR5PEqBjpT
         7Amk1idRZj1h/86kCm/ii/GQtgfzrCZLiDETdB6uUb16ajBWU0JPlhPiAVDURlqYm9xz
         rj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690528079; x=1691132879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4G0Yt706fhpMXSCAGIIvcxZcJifzL+wDvoJT3SfXuLs=;
        b=d2CGkK2UwfW3/5iaXrlrEjLg1DPQ9r1XKuZ0gfDsAM6kKp9kb5azQRD75nPOJodR0A
         ElQYQAc241SGMHM75C9f6nhKcKNhrXCqusrEt8O/JMSI+rU6Q/nYRrXROl2zH4fV6Ha7
         q6D/r7ADg7rItmO8l3UBHiEscYVmDpwcqyHRMA+7pxD3ic7uTkYsDSlV/o7hGjFOv3Hf
         K7UU45QkGWqVzb85pMzEBnf5kQz/OT8KujW5VDgQGf7QNQt8krWq7HWdiW/XM50Rxz1D
         O+DFsN9Y5sRDL234jcgSs6K0StLUpJag/ban4CK0BvEwBc66LOxF1+ATOg45KwBR/RQr
         i72g==
X-Gm-Message-State: ABy/qLZhhVHAy1e/aZ4BZdXmbz7CNNZgbnSqOnIUlY3sJ2NhR9n/BXEx
        lXkzYlm+Q+HiyucfKJRDHyV1/A==
X-Google-Smtp-Source: APBJJlHz5f+AGKQTSCC4NuB4nF8/XIA03njPLrbfP9DLWFV+SdA1EmituWiqyrdUrzBVJ812vNOFcQ==
X-Received: by 2002:aa7:d446:0:b0:521:d2ab:e4df with SMTP id q6-20020aa7d446000000b00521d2abe4dfmr1602220edr.19.1690528079497;
        Fri, 28 Jul 2023 00:07:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id y19-20020aa7ccd3000000b0051d9ee1c9d3sm1469817edt.84.2023.07.28.00.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 00:07:58 -0700 (PDT)
Message-ID: <43076212-f858-9414-0d50-a957dd344f09@linaro.org>
Date:   Fri, 28 Jul 2023 09:07:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/4] dt-bindings: Add bindings for peci-npcm
Content-Language: en-US
To:     Iwona Winiarska <iwona.winiarska@intel.com>,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Tyrone Ting <warp5tw@gmail.com>
References: <20230727202126.1477515-1-iwona.winiarska@intel.com>
 <20230727202126.1477515-2-iwona.winiarska@intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230727202126.1477515-2-iwona.winiarska@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 22:21, Iwona Winiarska wrote:
> From: Tomer Maimon <tmaimon77@gmail.com>
> 
> Add device tree bindings for the peci-npcm controller driver.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> Signed-off-by: Tyrone Ting <warp5tw@gmail.com>
> Co-developed-by: Iwona Winiarska <iwona.winiarska@intel.com>
> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> ---
> Changes v2 -> v3:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

