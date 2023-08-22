Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9D4783FF2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbjHVLsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbjHVLs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:48:28 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848D8CF2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 04:48:03 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so581801466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 04:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692704837; x=1693309637;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=55bIwn2d7j3dnR0hLojkzpFkh9GKaVLHWENI/qttC+Y=;
        b=BaZ1u4I0kXduhaoSIIgRXCfnZP1vXeZq9wbxNFNAC2d0I05kZX2pEC1g59msCdZyZy
         h3+pQkTCydm8ugvPeM+VmZ1VJxp2Rm8XAI5hlBlc0mBeEdgqePZoEfEAb/tpIWHihoEM
         LDIszR8GMnxgFI8O9A9Cd3MaMi/ilwIMhazYclGZ5pjvPG1MoJ/royNiItorFt6yJ2qq
         z0FvWmAJH14Yzx5sROk/MIaLviwTTGvtLrpbHLT4yc3mO7HBW6uHatlme4s8IQz5xOIv
         3G+UT5+qR+T6EVehsGHi/ChOEEthkyH4GL5+SUWs5azWv9NshGFXL4Ba+m8tdkqbTLeg
         EebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692704837; x=1693309637;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=55bIwn2d7j3dnR0hLojkzpFkh9GKaVLHWENI/qttC+Y=;
        b=deOuqbk29N6itsO/jW/RlIuhHmr2QB0DrpYvm/B/j/XMzA4M+8ASU04iYQITMbJVVw
         JZ/4SNXhpd9TJY9ePZZEeq21USGVb2Kksnd0+vvsxnQlFu3uKGkYooI66Wsx6LiEHPt3
         17JFMCpVuRFUs1WxWKVFCuT1v7bsHK1yLmpCA3DghEQQA0KZX1mS25n4rCpnJZYmwNNR
         I1ytXrm+i9b9FPLUGwrLrjKRkFqs4Fxcs29rDCNjHHK8u6lWsjDrlvZGZMDsS+8Fv+Sr
         W55k6GfFpCA04NQYEUvGN5Lq4KWzn4N5FPLpafcSeaVaQbxAF8mSbfcyj/fqPtkto+vs
         99nQ==
X-Gm-Message-State: AOJu0YyhlBJR8HSi7DU7xTlN9Ht2i+YDaenX2to6kjnAj9RyqWE+LLDM
        u2KgqqLy8lgpL5f3K/8i9+Q1Qw==
X-Google-Smtp-Source: AGHT+IHF5Zi2ypBZqCfcQok6ofhRkICDoU4oIEgfBDJunkp2sXwdHtuMYbfri0HDGcQg6FYtYGJaqQ==
X-Received: by 2002:a17:906:109e:b0:99b:4956:e4df with SMTP id u30-20020a170906109e00b0099b4956e4dfmr7858232eju.11.1692704837137;
        Tue, 22 Aug 2023 04:47:17 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id ja24-20020a170907989800b00992b8d56f3asm8097682ejc.105.2023.08.22.04.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 04:47:16 -0700 (PDT)
Message-ID: <bd24990a-9cc4-533a-0443-9e91e3b61a71@linaro.org>
Date:   Tue, 22 Aug 2023 13:47:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v9 1/4] phy: qcom: m31: Fix indentation issues
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, arnd@arndb.de, geert+renesas@glider.be,
        nfraprado@collabora.com, rafal@milecki.pl, peng.fan@nxp.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org
References: <cover.1692699472.git.quic_varada@quicinc.com>
 <6d1638daf9b0616816fdecb529df86a394db7942.1692699472.git.quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6d1638daf9b0616816fdecb529df86a394db7942.1692699472.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2023 12:29, Varadarajan Narayanan wrote:
> * Fix indentation
> * Drop simple success messages
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v9:
> 	Fix line break alignment

I wished we run checkpatch before sending patches, not after :/

Best regards,
Krzysztof

