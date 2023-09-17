Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF71A7A3469
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 10:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbjIQIbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 04:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236043AbjIQIbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 04:31:36 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3100019F
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 01:31:29 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50307759b65so1236514e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 01:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694939487; x=1695544287; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=drDjgL0hgos/meU0CMqnv5ge6VNpucOKs27UgCJcW4o=;
        b=uOiLD6iKN4x+LSt5vO0ho8vgWY745YqO4HDowXRJaCd4BRwDpkqYroJh4Z6HehmGBr
         +mYb1ydM1lLdzpkO3yAfSz5Wb3YnHIeSzxN2xYUeENVkvQT63oPyPIFs1H+4nnlR9Oye
         WHueW5N4pBFU+hFxEWDAwItD4rlp9pqGQLjcOKN/V3QPcFPdPLwyz7LUPrJOWhugXmoM
         HEQMETigu5kA52351Kg2iXEytF0BVUi1huKM4xBqjNPY1MtPVi01ylTrYPuq6yMlCHjX
         gZKJjsFu4qUAa/D1j5nPTb8hNmNHDlJ5eha4//qA5x+BcpqB4Txt6m6ruSTMKl2XWH0c
         Myig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694939487; x=1695544287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=drDjgL0hgos/meU0CMqnv5ge6VNpucOKs27UgCJcW4o=;
        b=H6RIygxKqUP2l8YT3XDshqtKUWr0spJQ/pytlMb230zIm3R6WPExM15zjolmwgnzbb
         n/pfY+c8enFOMLOSlNrYnSFy1eAphnelemN6JfYwLKRjaw/NZGWVv86xoCp1IPrd4zPu
         prxekLkOtQ3YEdhpms/f0bryFqJb6yVP/KT4QKUzCIq7Kt6PhNCJ+uwTFBUWFIe/giZv
         ah0JkHnfiKVGjCxdHhCn37T29e6H3XrqktNGbuDKyUpJmuIeZWOKnawVvNfeRQHqxFqw
         UmGjryDSGMfgMFD8o5yKxU2rJyLkMu9NjiqTMdN8mG8Vkz5PEhDOqqv0GwWxDU0tzT6I
         AGDg==
X-Gm-Message-State: AOJu0Yz+j8ZA2o15fj0qIddaAWjNigAC30AO1KswXr1aOglgicB6E6nC
        SaeqTMDTau8mt7RuHVt9NBkzpA==
X-Google-Smtp-Source: AGHT+IHFmHHrwMXcnFf/9Ysu9VlD73MTmqu/TrOJBBdfu+3YjbX5GvgssgHy0T7TnBmG+oi1KuCbqw==
X-Received: by 2002:ac2:54a5:0:b0:4fd:d08c:fa3e with SMTP id w5-20020ac254a5000000b004fdd08cfa3emr4659614lfk.42.1694939487357;
        Sun, 17 Sep 2023 01:31:27 -0700 (PDT)
Received: from [192.168.1.77] (150-140-187-31.ftth.glasoperator.nl. [31.187.140.150])
        by smtp.gmail.com with ESMTPSA id i8-20020a0564020f0800b005309eb7544fsm2672737eda.45.2023.09.17.01.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 01:31:26 -0700 (PDT)
Message-ID: <3dbff750-c430-04a7-1c53-f2e327e54f2e@linaro.org>
Date:   Sun, 17 Sep 2023 10:31:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 0/3] mtk-socinfo driver implementation
Content-Language: en-US
To:     William-tw Lin <william-tw.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230915152607.18116-1-william-tw.lin@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915152607.18116-1-william-tw.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 17:26, William-tw Lin wrote:
> This purpose of the patches is for soc-related information retrival.
> Such information includes manufacturer information, SoC name, SoC 
> segment name, and SoC marketing name.
> 
> Based on tag: next-20230915, linux-next/master
> 
> Changes in v2:
> - Remove mtk-socinfo.h
> - Consolidate different compatibles into mediatek,socinfo
> - Move socinfo node out of MMIO bus
> - Move mtk-socinfo.yaml to hwinfo
> - Fix reviewer's comments

This is way to vague, especially that you did not fix them. You need to
list all of them. Then we will nicely see what you ignored.


Best regards,
Krzysztof

