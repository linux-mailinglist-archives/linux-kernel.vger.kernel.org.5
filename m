Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5689179BAE8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237242AbjIKWJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237015AbjIKLvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:51:24 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37363CC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:51:19 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-401ec23be82so48532965e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694433077; x=1695037877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ww454ABm0e8trsLnc33ejqXe5wnztAS93RgRcAuT70E=;
        b=iHcWb6Q0Weh3TX9Iko7hnaVemDE641OC1ixRBW37Sla8ecj/IeqSvyNoZty/uLUt6N
         qYgyAv8uAZT1XZ98waNnqwBHOZRcGuGfZ944zmaCO7Yw54HRm999H/vLGxALJQy/2zft
         n53V9SgJFUNtecjTDtQ9j7VlXezEfdknybkAnn/LHv2CucB2Xd5eokITuDqjrVainGxn
         voSBQfZDkjMrdAHcvM4casLCbcFWy7JF9C2VNjix6w5ocAKCfGbVvf4xelEpeDFRaWgP
         6JWWActnLH02fmGmiw9D37yuGZLD2227qXXMjEOXYku/d3EFw2IDMfz6mLBReqTD0JUh
         eRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694433077; x=1695037877;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ww454ABm0e8trsLnc33ejqXe5wnztAS93RgRcAuT70E=;
        b=KcF00UW/Jj7pk2F3oxn0xkePUbNjqxXwtoMnophS2BXNX6S9KueFd75kE4QmHJNDHe
         CiZofIbwENjIppJUJK7pMZv8B6kcYwHPEHwpzaPgctW+SYaqUphhy84LXjjJ6l7ZdXbI
         VyqbRnfK60nhYrKiJ5HKTiN1T/y/cNTWpg03N4/+CjKubBMm+qoYrKmYVONd1ivt68GN
         yojcAvlJ3TAeZRbVj2Y2Ou1tAEWGZfRuSa1FvoBr2G8johCeliHpzKHKa4Y041xi2Ewz
         BgkcCsyMEjbbGyUrONkS5F5vAVEp8Mw4r04Iz9X0QUvHlstAXaJpDXUl0aWwKsHNUtUk
         8HWQ==
X-Gm-Message-State: AOJu0Yxx2ZxaUjpvHvemLcMhYaWqacgm7+IjRdS2Kmo35g6Vd+SPVVHt
        Iv35n1p9P57K0iqsTQiI94srAQ==
X-Google-Smtp-Source: AGHT+IEC51HEOzB8YLu5pRlRlfDq6GnSU+STLPmLRPMCzXSUm1O2JEARrpIN5nbrnIAngXmVrT+ruA==
X-Received: by 2002:a7b:c7c6:0:b0:3fe:f726:4a94 with SMTP id z6-20020a7bc7c6000000b003fef7264a94mr8824039wmk.14.1694433077663;
        Mon, 11 Sep 2023 04:51:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id s14-20020a05600c044e00b003feff926fc5sm9750210wmb.17.2023.09.11.04.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 04:51:16 -0700 (PDT)
Message-ID: <a5321150-4ace-9bd2-fc5b-462a4ccc130c@linaro.org>
Date:   Mon, 11 Sep 2023 13:51:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] arm64: defconfig: Enable DA9211 regulator
Content-Language: en-US
To:     Vignesh Raman <vignesh.raman@collabora.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     angelogioacchino.delregno@collabora.com, helen.koike@collabora.com,
        guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
        david.heidelberg@collabora.com, daniels@collabora.com,
        gustavo.padovan@collabora.com, emma@anholt.net,
        robclark@freedesktop.org, robdclark@google.com, anholt@google.com,
        robdclark@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, mripard@kernel.org,
        dmitry.baryshkov@linaro.org, matthias.bgg@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, geert+renesas@glider.be, arnd@arndb.de,
        konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl, peng.fan@nxp.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230911104139.617448-1-vignesh.raman@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230911104139.617448-1-vignesh.raman@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2023 12:41, Vignesh Raman wrote:
> Mediatek mt8173 board fails to boot with DA9211 regulator disabled.
> Enabling CONFIG_REGULATOR_DA9211=y in drm-ci fixes the issue.
> 
> So enable it in the defconfig since kernel-ci also requires it.
> 
> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>


Your CC list is a bit too big... Just Cc Mediatek SoC maintainers and
that's it.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

