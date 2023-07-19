Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21207758F5C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjGSHn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjGSHmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:42:52 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897F7272C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:41:41 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51e99584a82so8971074a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689752500; x=1692344500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TLrUGW85rpv90KzHtLXkb3CjWAhIiWzODGEwCQgbYyw=;
        b=VLWkzTZTiw6QWblM20qIpPImHMsRxPnT5eefbx2Z8hO9YWoGsJh2wCoeoqlany0JrL
         7i4PpRYVfg/1CiMwh9OQmj8mj/QevqS4YDOMlzfYlUZOKGO1wysSMoSMxsplsoM/GAGC
         Au6s0krl6/EBG4aH2Uqy8rhVRIZ3odOwj8SKaqP36JBdPr2I+oT6mCbujaAqPntnWTQL
         4r/ggcd/K4C8ONpqXGbfeJ2Pn3B8aqTrOLxANLH5JNWx04Ws9uGGOlPitTXQRVAT/ZQ1
         EsFvAbKLY8IlUukbGidDAFv/d4czgCJZDx8z63WeN71jV0+ujKfTtne3Wu0NxnDI58ys
         2EcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689752500; x=1692344500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TLrUGW85rpv90KzHtLXkb3CjWAhIiWzODGEwCQgbYyw=;
        b=EeYVsxcL1lzlvU9Ah79mQqKmyWKhuKy7HXyLj3yohKrcvDQPBhpqhKav8u//R7izuU
         bjEKxeFAYGGYFNt4tAvcCq44b80C9AsOdQBwa6+rYPQU1YWPXi1VaIePWQ2+XZ2aDDwT
         cbm8IRdBqVpFWeUn83dee+WUu06y5P/9P/5bPKf+iD49nA7wqV0s/0wnafE77x3awRik
         hCB7nvuJPawSvcKDzRpGnhKQSCbq/p/PG/sC27IjdMBqDrkmapqHreFlBP7akj/qqrPc
         MpVYrdGJzY3/QfXr1ZBlSW0sSrThKzRelTC9rzdMyTJxD8oOCcZSRq8Yh7RwkvqxIhh6
         QV9w==
X-Gm-Message-State: ABy/qLYlN4zAMW8eF9ovXoZFwr0+i7hiAqwDAmqiDBcH6x089mesFc7+
        78AjmgKB7vDGs1jSBxAbACfQpA==
X-Google-Smtp-Source: APBJJlFD3Lq9Qk5gW+xseTg2pSlh8AFtuKQYxkcDUNt6C47LWETman+o6eD+TmJz8h6zmpCB3YsxwA==
X-Received: by 2002:a17:906:319b:b0:965:d18b:f03a with SMTP id 27-20020a170906319b00b00965d18bf03amr1775787ejy.58.1689752500075;
        Wed, 19 Jul 2023 00:41:40 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id gj19-20020a170906e11300b00992ea405a79sm1935164ejb.166.2023.07.19.00.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 00:41:39 -0700 (PDT)
Message-ID: <8dec9f94-9a84-68f2-4cc7-18fde97119c5@linaro.org>
Date:   Wed, 19 Jul 2023 09:41:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/3] dt-bindings: reset: Add compatible and DT bindings
 for Amlogic C3 Reset Controller
Content-Language: en-US
To:     zelong dong <zelong.dong@amlogic.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, kelvin.zhang@amlogic.com
References: <20230719060954.14864-1-zelong.dong@amlogic.com>
 <20230719060954.14864-2-zelong.dong@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230719060954.14864-2-zelong.dong@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 08:09, zelong dong wrote:
> From: Zelong Dong <zelong.dong@amlogic.com>
> 
> Add new compatible and DT bindings for Amlogic C3 Reset Controller
> 
> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

