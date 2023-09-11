Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7772079A599
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 10:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbjIKIJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 04:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjIKIJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:09:22 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA04AE51
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:09:11 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40061928e5aso47073505e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694419750; x=1695024550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EbUzjiy4o1vK6+eGTRCo3FmI8I3JuBmYotzF+QEDbUg=;
        b=G5pIpSUlLgrywcZWVhzKgWYPT26G6N/WUlfY/qJQVA+MbiO8BHJdZW46oar0f+qHvC
         BMC1yzrf57EMuCMCMPv2cGVUJkdbOp3hsOB4mYFtz0Yvx1xfNtVFrU1SgF1zlap3A9I6
         MbMhYTzX6FumWOORTqccuKJa5ZemtD1EuX30Hr9gHBrvMQzocW4CD2g6m1C80fS7jTvL
         wZAkg9fTY73ek15pkCs4IQoqDDk/vnZPXOFkULdufboBwdD2asAkIc/Bp+kN0rrAmrzX
         Q5Gslp30yhkVZ+NyzqyGHsFpjCGYNKNowWTUvKVVw0olHYl0AYotXJWIwXyK+1mDT/Yw
         V9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694419750; x=1695024550;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EbUzjiy4o1vK6+eGTRCo3FmI8I3JuBmYotzF+QEDbUg=;
        b=uzMYfdG/0sWQyM8FCArAdbj6Wdr2AA7ufqoDZizy5V8weEAFen9rGFM6m0Bs/ulRvj
         QBOUuZ0FMcSpSJz7yC9+ozeFure+wGkQmtym7mrOvnPCGznOqxS4bwlOfw+IsiZfXQQ+
         S7c7+STfQ/Ont9w1cxKQHn3ygNMO3AU06qt6UNGQTO5jhrby2UyiycQQEhSbz8qFOag6
         E6DKVtrSyxPE9F2wHKOVt03hRHRLzaGtN66b1dOeiz1+H6Ly6aZv9+JsLVlBOvDOxdy4
         /GgoVa/eapZy2ast01suLYevwGu3Hss0wDWHQCQfKML4QUkxWFDRb/iM47KsC15hez0F
         9RDg==
X-Gm-Message-State: AOJu0YzhWcFiW4rShzk2fbK5AvMYEd1PK73lMhOOtor8U/6zeeEtthdB
        Wnfpsr5QcMoXoMWuof553DwoxQ==
X-Google-Smtp-Source: AGHT+IH17NjBNGmOzEesnEW9tcv/zDzsg0kaDQGZfVp6yr4OvabsTsarBsJUqtBSDTS43yE6uYtPtQ==
X-Received: by 2002:a05:600c:b5a:b0:3fe:15f0:dfbc with SMTP id k26-20020a05600c0b5a00b003fe15f0dfbcmr7767575wmr.12.1694419750151;
        Mon, 11 Sep 2023 01:09:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id w18-20020a5d6092000000b0031c52e81490sm9359869wrt.72.2023.09.11.01.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 01:09:09 -0700 (PDT)
Message-ID: <9476d20e-a0f2-e8cf-db4f-d07dda86bb28@linaro.org>
Date:   Mon, 11 Sep 2023 10:09:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 2/9] arm64: dts: qcom: apq8016-sbc: Add overlay for usb
 host mode
Content-Language: en-US
To:     Vignesh Raman <vignesh.raman@collabora.com>,
        dri-devel@lists.freedesktop.org
Cc:     helen.koike@collabora.com, guilherme.gallo@collabora.com,
        sergi.blanch.torne@collabora.com, david.heidelberg@collabora.com,
        daniels@collabora.com, gustavo.padovan@collabora.com,
        angelogioacchino.delregno@collabora.com, emma@anholt.net,
        robclark@freedesktop.org, robdclark@google.com, anholt@google.com,
        robdclark@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, mripard@kernel.org,
        dmitry.baryshkov@linaro.org, matthias.bgg@gmail.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-msm@vger.kernel.org
References: <20230908152225.432139-1-vignesh.raman@collabora.com>
 <20230908152225.432139-3-vignesh.raman@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230908152225.432139-3-vignesh.raman@collabora.com>
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

On 08/09/2023 17:22, Vignesh Raman wrote:
> Due to the presence of the fastboot micro cable in the CI farm,
> it causes the hardware to remain in gadget mode instead of host mode.
> So it doesn't find the network, which results in failure to mount root
> fs via NFS.
> 
> Add an overlay dtso file that sets the dr_mode to host, allowing
> the USB controllers to work in host mode. This dtso file will be used
> in drm-ci, mesa-ci.
> 
> Overlay DT file uses the sugar syntax [suggested by Dmitry Baryshkov and Maxime Ripard]
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> Signed-off-by: David Heidelberg <david.heidelberg@collabora.com>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v3:
>   - New patch in the series to add device tree overlay in arch/arm64/boot/dts/qcom
> 
> ---
>  arch/arm64/boot/dts/qcom/apq8016-sbc-usb-host.dtso | 8 ++++++++
>  1 file changed, 8 insertions(+)

Split unrelated patches to separate patchsets. This has nothing to do
with DRM CI system.

Best regards,
Krzysztof

