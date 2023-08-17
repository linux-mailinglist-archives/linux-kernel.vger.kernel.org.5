Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA56777F29C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349194AbjHQI6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349196AbjHQI6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:58:05 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D4526A8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:58:03 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bb91c20602so13498995ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1692262683; x=1692867483;
        h=content-transfer-encoding:from:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qhUjNbbQ83RYrqSJximWVV4kplCba9UY1zUF2Y422i4=;
        b=BrGr4fD/erajUaZRkQauvLhN+r9grfKG5b7hpScyJZsjY+4bu4pb1Z+i9IvAoVv0kQ
         nEzkw0n2yYurMmJNke4WqY2tVgBLS/jGsbwnNwzkb/2hxw8gxGk35XEclsyrNGy+rFT+
         ZQfMg0xCB9asnX1u8jTeDaD2wQAxI7neQz0CpWvznwAThlE4kKrvpPJ3g59e5o76vBoM
         Q0MR/Fax4tv7T1zrSmbw59s638P4u8Va1lgHkSjCAJDogecI65Kg0piEzXYP66zzOLLH
         2kiO1SJS3nBPbRlp0LRPVGzwCS2m+uaETQEf4XgPI/o+UavJVzSAbDEKhDGFLkZ6s3y9
         lp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692262683; x=1692867483;
        h=content-transfer-encoding:from:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qhUjNbbQ83RYrqSJximWVV4kplCba9UY1zUF2Y422i4=;
        b=Dndi8UZAFjzTF5QKjMxVDGj5lCXjaEed2TQ83WYh9vxrhjvJ0fzhXPRFoAepw6ZSKC
         vF6QpvxOU0JOpEOerLfC3hgfUVVLz8XITjKTGYuz4s4FtZ6maM2rP7wVkXkqK9K3zH7i
         yVZ/Awi2oP4CWtCrjgmQ86iIrbrlxDKbuWZpOuQDbHev9jEOTsqdlCsB/7Q1z+vqrqK6
         pKMTYxPtxV9g9CO1pkqidEEqNhHRd955iLthWqNw67bWq2pYd0Bk9zBSMnS0e1jAmBc0
         6qK7K2SXQCPNYjPyUPriT6EVPPzHqFR8/Cc/MvEXFcXeANLKCGrDmv+Ah5IQ66fOJOhU
         WAoQ==
X-Gm-Message-State: AOJu0Yw7lcq9c51UjVX4Z+rGGi2fbxT6Y+JoohhGXkBBpeP9KPWs/hlO
        mQJl1AyVr7gY65s4JOeVGBRxnw==
X-Google-Smtp-Source: AGHT+IH2QIMTGh5Tv11WL5VZmk6YIdzrJlV4azw4oDeCEPbWa5hRY6KKIimqiqPWb1tJXu+0gbhKfg==
X-Received: by 2002:a17:902:e803:b0:1b8:9fc4:2733 with SMTP id u3-20020a170902e80300b001b89fc42733mr4877689plg.3.1692262683140;
        Thu, 17 Aug 2023 01:58:03 -0700 (PDT)
Received: from [192.168.0.224] (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902d2c400b001bb6c5ff4edsm14647206plc.173.2023.08.17.01.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 01:58:02 -0700 (PDT)
Message-ID: <ca90fa1b-17aa-fbc2-8ff8-01a77a93a1cc@quanta.corp-partner.google.com>
Date:   Thu, 17 Aug 2023 16:57:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc7180: Reorganize trogdor rt5682
 audio codec dts
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sheng-liang.pan@quanta.corp-partner.google.com
References: <20230816112143.1.I7227efd47e0dc42b6ff243bd22aa1a3e01923220@changeid>
 <20230816112143.2.I29a5a330b6994afca81871f74bbacaf55b155937@changeid>
In-Reply-To: <20230816112143.2.I29a5a330b6994afca81871f74bbacaf55b155937@changeid>
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

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
>    one that was used for rt5682s.
> - Though we no longer have any "/delete-node/", we do still override
>    the "model" in the "sound" node in one case (in pompom) since that
>    uses the "2mic" sound setup.
>
> This is validated to produce the same result (other than a few
> properties being reordered) when taking the dtbs generated by the
> kernel build and then doing:
>
>    for dtb in *trogdor*.dtb; do
>      dtc -I dtb -O dts $dtb -o out/$dtb.dts;
>    done
>
> Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> I'm pretty on the fence about this change. I wrote it up at
> Krzysztof's request. While I don't hate it, I'm not convinced that
> this is truly more understandable and it does cause a bit of extra
> duplication. Happy to let others/Bjorn decide.
>
>   .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |  1 -
>   .../dts/qcom/sc7180-trogdor-homestar.dtsi     |  2 +
>   .../sc7180-trogdor-lazor-limozeen-nots-r5.dts |  1 +
>   .../sc7180-trogdor-lazor-limozeen-nots-r9.dts |  1 +
>   .../qcom/sc7180-trogdor-lazor-limozeen-r4.dts |  2 +
>   .../qcom/sc7180-trogdor-lazor-limozeen-r9.dts |  1 +
>   .../boot/dts/qcom/sc7180-trogdor-lazor-r1.dts |  1 +
>   .../dts/qcom/sc7180-trogdor-lazor-r3-kb.dts   |  1 +
>   .../dts/qcom/sc7180-trogdor-lazor-r3-lte.dts  |  1 +
>   .../boot/dts/qcom/sc7180-trogdor-lazor-r3.dts |  1 +
>   .../dts/qcom/sc7180-trogdor-lazor-r9-kb.dts   |  1 +
>   .../dts/qcom/sc7180-trogdor-lazor-r9-lte.dts  |  1 +
>   .../boot/dts/qcom/sc7180-trogdor-lazor-r9.dts |  1 +
>   .../sc7180-trogdor-pazquel-lte-parade.dts     |  1 +
>   .../qcom/sc7180-trogdor-pazquel-lte-ti.dts    |  1 +
>   .../qcom/sc7180-trogdor-pazquel-parade.dts    |  1 +
>   .../dts/qcom/sc7180-trogdor-pazquel-ti.dts    |  1 +
>   .../boot/dts/qcom/sc7180-trogdor-pompom.dtsi  |  1 +
>   .../qcom/sc7180-trogdor-quackingstick.dtsi    |  1 +
>   .../arm64/boot/dts/qcom/sc7180-trogdor-r1.dts |  1 +
>   .../dts/qcom/sc7180-trogdor-rt5682i-sku.dtsi  | 38 +++++++++++++++++++
>   .../dts/qcom/sc7180-trogdor-rt5682s-sku.dtsi  | 33 +++++++++++++---
>   ...0-trogdor-wormdingler-rev1-boe-rt5682s.dts | 12 +++++-
>   .../sc7180-trogdor-wormdingler-rev1-boe.dts   |  1 +
>   ...0-trogdor-wormdingler-rev1-inx-rt5682s.dts |  6 ++-
>   .../sc7180-trogdor-wormdingler-rev1-inx.dts   |  1 +
>   arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  | 27 -------------
>   27 files changed, 104 insertions(+), 36 deletions(-)
>   create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-rt5682i-sku.dtsi
>
Reviewed-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>

