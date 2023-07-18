Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2111E757446
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjGRGeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjGRGeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:34:14 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1913A13D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:34:13 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-992acf67388so657243666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689662051; x=1692254051;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EPkvjpW78jsIt8CqCb8WWAfnv5G9ccqWF9gc3RVA7fQ=;
        b=UOr7Uub3LaSWhK8uO1L4h1AZl6+leVhaICTT/mDuWVSi/wAXS0nK6H+X3BUcqprPTa
         doQ7OUpubu3ibJ26DJd7H6xJ9FjXqRbSi0ltTS9vuu/ZmkgFm+zB6fBOCe3QaG//fS53
         1M2furBAf4NDEJtMfARGNWBKcShvDQ0SqllnehdPTG6tvxN7nRYrZxoY+JzHpthd7tXd
         bVMAQbdlKUeXG09oGyPTkIEx+iXmIt5Xl9qfFoA9a6QCrn6hXJYpWpo7cmhDa16xaQD3
         DFIUJSyFMw6tWPQ//3LvNLjW/C58JgOx6pBytsJJyK+ipf4oNMu0BI47ZHrC6i73U2xX
         L28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689662051; x=1692254051;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EPkvjpW78jsIt8CqCb8WWAfnv5G9ccqWF9gc3RVA7fQ=;
        b=Yzc1kwfRfZ+2HCA+n8YhrUyg34Cyzflp77nKwt7T2Pv8BmTm5pE3GuGhzFQUFVzCm1
         mAe3trGG09GL2lfcDNNC/Q8B0ockMIbEgWWgE0vvtv7WUYfATGTMW1FdsfGdpmpII//D
         jr74L9nc/U66M5U76CeB//mbOJODe8PRkJzRd1bY/OyyUNcUydWJi2oWW9AjuAwhKsl+
         35GcZmIDCywIAxYCDWIGVIcOzfm8rCGJRGyWA7ZBjN/fpx835vdq8O0enuXfCCWbz6cr
         bkkiCfox2CkToI55V4NGqzvl48i5ss2eS/rklpvL6sE7BixciJxTUTntq1VsttH+CcUB
         YnyQ==
X-Gm-Message-State: ABy/qLawjWhj00epkW6XgzWvWMiIxaKjOx7T8L8IMpfJ2jVyqxpkD8uc
        WwLvss/7EAl8nEsUlambBFhLdw==
X-Google-Smtp-Source: APBJJlGAKB+Gn194UC+gwki4JCiy+b7H5WoMQ6NE7CnVecQZ4rEqmc0p7uKdgj/CJlxFUdJxmNahXg==
X-Received: by 2002:a17:907:7656:b0:993:c267:3612 with SMTP id kj22-20020a170907765600b00993c2673612mr11033201ejc.12.1689662051496;
        Mon, 17 Jul 2023 23:34:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id gs19-20020a170906f19300b00992f81122e1sm612364ejb.21.2023.07.17.23.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 23:34:10 -0700 (PDT)
Message-ID: <2c7b062f-fc9b-7697-1a74-070dead55fb6@linaro.org>
Date:   Tue, 18 Jul 2023 08:34:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] dt-bindings: clock: ast2600: Add I3C and MAC reset
 definitions
Content-Language: en-US
To:     Dylan Hung <kobedylan@gmail.com>, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     BMC-SW@aspeedtech.com, Dylan Hung <dylan_hung@aspeedtech.com>
References: <20230718062616.2822339-1-dylan_hung@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230718062616.2822339-1-dylan_hung@aspeedtech.com>
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

On 18/07/2023 08:26, Dylan Hung wrote:
> Add reset definitions of AST2600 I3C and MAC controllers. In the case of
> the I3C reset, since there is no reset-line hardware available for
> `ASPEED_RESET_I3C_DMA`, a new macro `ASPEED_RESET_I3C` with the same ID
> is introduced to provide a more accurate representation of the hardware.
> The old macro `ASPEED_RESET_I3C_DMA` is kept to provide backward
> compatibility.
> 
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

