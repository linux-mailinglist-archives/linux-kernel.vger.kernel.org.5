Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC36789535
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 11:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjHZJgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 05:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjHZJgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 05:36:22 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4065268A
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 02:36:19 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4ff09632194so2613614e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 02:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693042578; x=1693647378;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OCMQQVAThpg4cktkHsLJd5VTMF+/8FIQx9hXTMNLROo=;
        b=Mag1nH7pIwQ3PKXndp0v1jxaUnowxXf1RVyNphHJ7kOsgDNhM3dZMCi0WiEOpD2Uld
         hg3B9WHu77RN99CxH0DCZ0jAVMARFkXvPy9FNMaqs0lms3htv0ykBiAJxqT2EiyxJW3D
         yTS0OnNf6rPYJ/A9Wjkaqq4FPr38Ec06pBcLymH2v7OioCgqBq8jehl9C+U0v5FbGrLk
         ntOWmkaIZuC06fzdtmoTrQH/qc6dHPVhJIw4TPyk4QWOONBQcfyH4ONqb/H9ZCudJOzm
         4h8OdMq5rOx0lm+G3Z14LWpR4VLR+aFJ0xN08lf1F4PNX1LRrjF1jxLIJ4rt4pyPQE2/
         UcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693042578; x=1693647378;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OCMQQVAThpg4cktkHsLJd5VTMF+/8FIQx9hXTMNLROo=;
        b=GBqxAnnfa73kJeRXsBtsCmWzVPUhzTwU4eZy0qoWaSUeV2Rd/iaMIHJ5NjV23NzlcC
         WjLldbrRbjZC2ihJ4g5sZ9FUiIsJTb65LXDhrXZ/7FCgpMSlxIpKnwJYrpfzS0Xrwo24
         HTnjRTdCQILUPSFwcBDHCDibD0+MK/Wjb+QwLqj5qty56B5YUfljxFXzYFeqJ3RtHVmX
         AIrnMKCzduvadWkz9tinNuGBoiybAvcfhnGJMoNGGLd3BC/YVmeGcBsPIkRocDLlfTlS
         BE4MzZ9M26XvPZQ7xc3eXd4a+8HFkZhb5/b7hb8mHwJmCMHg9zRDCLuok531ox04RW60
         ynMQ==
X-Gm-Message-State: AOJu0Yw6GjLYGMeDs4nmtr+kygIPJRxAFoRhowsqmn6/k+Ie6KdfzIUI
        s1904XSbS+GSU3HGwQWraKSQqg==
X-Google-Smtp-Source: AGHT+IHPmoAMpdZ5QRcd+q569cVeptJqGiSj7K7phHrweT0OX1bFrnwpOZpCLZyCiokqD1MobnEhiQ==
X-Received: by 2002:a19:e051:0:b0:500:ac0b:8d52 with SMTP id g17-20020a19e051000000b00500ac0b8d52mr1820113lfj.7.1693042578171;
        Sat, 26 Aug 2023 02:36:18 -0700 (PDT)
Received: from [192.168.1.101] (abyl74.neoplus.adsl.tpnet.pl. [83.9.31.74])
        by smtp.gmail.com with ESMTPSA id w19-20020a19c513000000b004fe15a2f0f6sm645453lfe.62.2023.08.26.02.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 02:36:17 -0700 (PDT)
Message-ID: <610a1b08-ced2-4e07-8b69-b2dd2749293e@linaro.org>
Date:   Sat, 26 Aug 2023 11:36:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc7180: Reorganize trogdor rt5682
 audio codec dts
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230816112143.1.I7227efd47e0dc42b6ff243bd22aa1a3e01923220@changeid>
 <20230816112143.2.I29a5a330b6994afca81871f74bbacaf55b155937@changeid>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230816112143.2.I29a5a330b6994afca81871f74bbacaf55b155937@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.08.2023 20:21, Douglas Anderson wrote:
> It was asserted that the "/delete-property/ VBAT-supply;" that we
> needed to do in the rt5682s dts fragment was ugly. Let's change up all
> the trogdor device trees to make it explicit which version of "rt5682"
> we have and avoid the need for the "delete-property".
> 
> As a side effect, this nicely gets rid of the need for a delete-node
> in coachz, which doesn't use "rt5682" at all.
> 
> A few notes:
> - This doesn't get rid of every "/delete-node/" in trogdor, just the
>   one that was used for rt5682s.
> - Though we no longer have any "/delete-node/", we do still override
>   the "model" in the "sound" node in one case (in pompom) since that
>   uses the "2mic" sound setup.
> 
> This is validated to produce the same result (other than a few
> properties being reordered) when taking the dtbs generated by the
> kernel build and then doing:
> 
>   for dtb in *trogdor*.dtb; do
>     dtc -I dtb -O dts $dtb -o out/$dtb.dts;
>   done
> 
> Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
[...]

> +&mdss_dsi0_phy {
> +	qcom,phy-rescode-offset-top = /bits/ 8 <31 31 31 31 (-32)>;
> +	qcom,phy-rescode-offset-bot = /bits/ 8 <31 31 31 31 (-32)>;
> +	qcom,phy-drive-ldo-level = <450>;
> +};
> +
> +&panel {
> +	compatible = "boe,tv110c9m-ll3";
> +};
This is odd

Konrad

