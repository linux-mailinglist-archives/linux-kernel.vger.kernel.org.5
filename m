Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD2476652D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbjG1HWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbjG1HWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:22:12 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2228BF7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:22:11 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5221cf2bb8cso2408349a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690528929; x=1691133729;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LHDLdEESCjLfjZtmp5s10YbAT+aGJz2CpcqQwun1R0A=;
        b=ydMrkBv3UGAyLB3YqiDyqtrAeuLzqUngTBZgg7uyT6+sBO17SjL+yjB4oCJiRTMS4D
         zWFPeJV7sevWXc6L2CX9og3MWXhURwBJrU/RrY+wtuEnt+OMUs34Ni61fON79QCXvYZC
         +pGhZowtv+Eq3Mc0czMKOj0iK/nQAwgjldIE6iWNssgBlkIz8WollVODcsHJuuSRTbbY
         5bW53J8WVyf/8NRg5oLeHXUsKR6ixRQY5y1F34KUiroPY5XSP1IsiTbHSJAPbq1H1pKe
         CkoqYtJFYDr33WN/GUi9BDR0JtftHC9jJ1VnCtwBZJGawKXVU4GpH+yI8oWhvNE/rk2l
         zIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690528929; x=1691133729;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LHDLdEESCjLfjZtmp5s10YbAT+aGJz2CpcqQwun1R0A=;
        b=dMCPg8OxIYVTwLqkMHysYcfzmZDGMuRLaTbs7XmGCkJD5FqzerGJrIEkv7iSwndtta
         NpaduHmCFsETLcuHytQWdTQH4me74GOHX4WXUgsozN18IpEg8ruLWhc2rehcoBQ12Xyr
         scFANst5HVb/V7+LG0FcOtgYHQMTLUDUAzHzsqMapxYlE5i466o2n8kEm1vc5nOX0z9W
         2bBrDvsdhfI/cbCNhLB+ic8PFI4iED3vMxXy4vvtaorjCW+sCkfuNyDVB+vvfpyun0t4
         suSSpq7eAaf48vMgTn45/ey/AGUYJb0ikIQT9rCPVYJp0iS2UtG5WEsXyfLTWnK/yYj4
         BUMw==
X-Gm-Message-State: ABy/qLZ4OyX/Xy5tI4J6crChTuZEcKxpVY/fkNtB0+KczQb0Htzb9K1C
        n7GyPxS84axmZx4ZwjKgHbbnNg==
X-Google-Smtp-Source: APBJJlEzqjGfgX2NmTh6Z8QsYYzU1kCY6wPXAwFGUh5MAwyOuaLmyon2kf2ATQApaA2l5lNXc1XfcA==
X-Received: by 2002:aa7:d5d0:0:b0:522:2ada:c207 with SMTP id d16-20020aa7d5d0000000b005222adac207mr1234455eds.34.1690528929619;
        Fri, 28 Jul 2023 00:22:09 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id b8-20020aa7c908000000b0052255cbad8dsm1485151edt.94.2023.07.28.00.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 00:22:09 -0700 (PDT)
Message-ID: <42782c4e-1dab-d99c-4ca3-6e0ff12ffd19@linaro.org>
Date:   Fri, 28 Jul 2023 09:22:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 02/14] dt-bindings: display: add st,stih418-vtg compatible
 for sti vtg
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230727215141.53910-1-avolmat@me.com>
 <20230727215141.53910-3-avolmat@me.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230727215141.53910-3-avolmat@me.com>
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

On 27/07/2023 23:51, Alain Volmat wrote:
> Add a new compatible in st,stih4xx.txt in order to support sti vtg on
> stih418 platforms.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

