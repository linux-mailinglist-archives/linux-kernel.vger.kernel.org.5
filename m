Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CC8762F61
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjGZIN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbjGZIMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:12:55 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9B583DE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:04:09 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99313a34b2dso931955466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690358647; x=1690963447;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m+zsyzNYz9FAU8jbvq8Yfs8EVFQYIBgp5+Rqr1cmN7s=;
        b=GHZFnkzROBSdNcHcXcNx5xi/6nAuJzEwztKDT+XrMvrcyo2jMquScj3r8BdpmGWjay
         rd+5c2CSLtteUZdHjidbKu6HXqXaOenXg4AIdW9X/cx6PZ+wf4aAE5gARmtrsicH8q6d
         E8kuHrx4+oj+OmEYqyjuWuIIZT3hxKyudvVUorMJaIOEFvod/178JFfmeMSKXnWptYUJ
         vkEgWSiVHjgsFOWKhPKmppZN9DIkonwI+D2vHbP/znkAwYIBrSK/2vlEc1TxYvaTjNiS
         U28hlZRKz6FM9K1jjaRldwUtuY4nFvFWlOCWmYcRB0KhjA8SkVLDbWtAsTvA5y3K2n1G
         Fk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690358647; x=1690963447;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m+zsyzNYz9FAU8jbvq8Yfs8EVFQYIBgp5+Rqr1cmN7s=;
        b=KuCb/Gb3eqwzLC1h9LHrtp8do0e53TZD2bM8PzI7lF1Pwgmk8BEmc1obUcyGpzw+Fr
         xTS6JR0AImSIuHczyWHHwG2H704qTYoOV1wnjTbAZ25jNyh4YIZrqlE/Fte0Q5gn5EQH
         MKedKXu0sk1N+9cARDxGpxiRzZhlV0T+jYb71s8yDDpwKtGOcrBnVp3JieZn3qUhAoti
         o8YAjOPG7kA4CWZJRc66d4ZfFsVwj3gCcHhk5neeEqCuUkWOPvKbhbJpz3QOu0/Iv0S2
         KoaCheOplQPdJ2f0qL21KEBCzb4vQtpCA434NUZUhjGOcYour6oc9yvharD0L/+mFVBT
         oQUA==
X-Gm-Message-State: ABy/qLZQiAXR8rsBg9r32IaV/n1kImTrktPAfrp/m4yfsjtErFjnM/L/
        AnH92uyHf/DD20mFW+/PP2FskQ==
X-Google-Smtp-Source: APBJJlHpjCzsxNj2AmgFgATEajxr4WjmK20X9OhqxKVjfHuWBZb/miYZ3x+Py+HFwBMUW88QYdyscg==
X-Received: by 2002:a17:907:b13:b0:993:a379:6158 with SMTP id h19-20020a1709070b1300b00993a3796158mr867973ejl.17.1690358647581;
        Wed, 26 Jul 2023 01:04:07 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id l2-20020a170906230200b00997e52cb30bsm9135120eja.121.2023.07.26.01.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 01:04:07 -0700 (PDT)
Message-ID: <eedb17a4-b7bb-2552-9a07-761f2d07685f@linaro.org>
Date:   Wed, 26 Jul 2023 10:04:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/7] arm64: defconfig: Enable SND_SOC_J721E_EVM for audio
 support
Content-Language: en-US
To:     Udit Kumar <u-kumar1@ti.com>, vigneshr@ti.com, nm@ti.com,
        catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, arnd@arndb.de, geert+renesas@glider.be,
        onrad.dybcio@linaro.org, nfraprado@collabora.com, rafal@milecki.pl,
        peng.fan@nxp.com, john.garry@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Jayesh Choudhary <j-choudhary@ti.com>
References: <20230725105346.1981285-1-u-kumar1@ti.com>
 <20230725105346.1981285-5-u-kumar1@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230725105346.1981285-5-u-kumar1@ti.com>
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

On 25/07/2023 12:53, Udit Kumar wrote:
> From: Jayesh Choudhary <j-choudhary@ti.com>
> 
> Enable CONFIG_SND_SOC_J721E_EVM which is required to enable
> audio in J721E Platform.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---

Do not enable configs one-by-one. Squash most of your patches.

Best regards,
Krzysztof

