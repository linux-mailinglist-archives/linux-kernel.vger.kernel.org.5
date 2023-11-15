Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0747EC906
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjKOQuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjKOQuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:50:44 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62463D6E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:50:36 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c7c7544c78so84877751fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700067034; x=1700671834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h2tcXaJjFH/8KrsTwvA6FjU/HB+3Vakyi0P3qd2Rw2k=;
        b=F6BpYH2wSyCCnfEamGa5nnlSvzEpNT8T5zLCmZLE4BGjodQmJnq79t+Eve/fRoNe8B
         7Iu2dsP5uTqLdcevxNcq7xjQRIYPvraak1NfouY65j0TsTKyih4SeBms5lNsA1rkH1HI
         yjynPmrIbxC9FLHs+dgmlX6+lEOoSxCfDzRpTxWhpv0oUyt2UvZNg9YBCZlpy3g1qnN8
         pKzXC/HjG4K2kcimPu9/itz3E/qqdFRtSmtmXZiEAEU7ixFRB1SpSEIDzppak3twKCWG
         jpenwb7+GRR1KhZ9QJLj71JcTI5jHg9NfxQihfwxtNIbt4/cz1ayyIRBRziaS7h8twUj
         o5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700067034; x=1700671834;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h2tcXaJjFH/8KrsTwvA6FjU/HB+3Vakyi0P3qd2Rw2k=;
        b=N8twqszOG+5tulg/OtyOmb/sqfy3UCR25Vdwyi44kcALmKl/AHZecwDwP5G1LF2xvD
         rJeOxz1Ip+Z7K5C+ncRRz8osK6xlgrNTXU8R1GjdCqdkBQ61C5UFK75ht7cqgwLwtDMp
         057jUlHhtYH8ThxbjpQF/qM/SYkBGZ0shUoi8yZNw4KE2m+PLCADSzshQb8xl7ySkNLc
         aGiJ7YBnQtB5en/CJthOZ6wgkhjKPNdgatT4lHvvZo8GBSefbMnU3oeW/M/DJ1G1uDVa
         EHzR+9G76M6DAMxl4LhEyxer55NhtvQ6U98yn07WeJBTXb8oB2zpzrL3maHO68wXHHmp
         zMDw==
X-Gm-Message-State: AOJu0YwjYsdAsNN0C7S860tAg5Iie5cCl+Vpk1YkNPf39o38SEd98yXH
        MxEcpSHXM6UHiX7laTQQITKM/A==
X-Google-Smtp-Source: AGHT+IFHbmzb/CUGh89uInTlWtAWdiKRuOF96YRyjerfnlzkcfXgyUS8s+sBJZnLKJWivddd6G4kXg==
X-Received: by 2002:a2e:a48e:0:b0:2c0:21b6:e82e with SMTP id h14-20020a2ea48e000000b002c021b6e82emr5443954lji.4.1700067034631;
        Wed, 15 Nov 2023 08:50:34 -0800 (PST)
Received: from [172.30.204.150] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id a13-20020a2ebe8d000000b002c12c2094e4sm1705775ljr.74.2023.11.15.08.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 08:50:34 -0800 (PST)
Message-ID: <3d341271-ffed-46cd-853b-6b7b4029bf3b@linaro.org>
Date:   Wed, 15 Nov 2023 17:50:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ARM: dts: qcom: ipq8064: drop unused reset-names from
 DWC3 node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231112080136.12518-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231112080136.12518-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/23 09:01, Krzysztof Kozlowski wrote:
> The Qualcomm DWC3 USB controller bindings do not allow "reset-names" and
> Linux driver does no use it.  This fixes dtbs_check warning:
> 
>    qcom-ipq8064-ap148.dtb: usb@100f8800: 'reset-names' does not match any of the regexes: '^usb@[0-9a-f]+$', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
