Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AC3780838
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359049AbjHRJZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359050AbjHRJY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:24:59 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BDA35A4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:24:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe1a17f983so6741075e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20221208.gappssmtp.com; s=20221208; t=1692350685; x=1692955485;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dGeud8/LCN66PtLt+JkTQZpCvrnUyZTBaR7+fmpgOZQ=;
        b=RWm0QTDvw9f41zFPdUGKkb4IJbKr6MTveOi/uWPyhS4F1kO3Orv7ApuiD5PGllFr6w
         /+xsiTCtivnl+OZ5aV3KkKvPFGFgmX8MpS7kKn/KZmACOHGWjqTeXPWzfgmRHx66gny5
         jIuL1NESET1iSbUmmX0AnXibEMnSKe4i6JPIzfpa59jeM5Q6FD8JmoOqKXyNc3ltCnwc
         Ark2wHTAozDmj5LNuiYe0POAkKcB0ZTPYPAzy/XxM+0HYb6EZl0jNqEHCV64eGBCfobd
         vDNGMttOKiRjgm8+9Hi+QQN2XOt0vVwtOuJKm1tbghDN43kuwNHFq/ZYZOV3/eF/wopJ
         9YIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692350685; x=1692955485;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dGeud8/LCN66PtLt+JkTQZpCvrnUyZTBaR7+fmpgOZQ=;
        b=TBNYdML44BSIntj9b3fkhpNoVoidzih4jrnBQMEhkGZCqj5GEyti/gvZTElWUZb4pF
         MkkqyQ6oRd19Ns1sC185kGUCx0jHbo5rzc+CyVPdn2JaWWAFGHN/eNkGWXHN0NWblCMY
         loLnfuff7smGAqHoQRlbymDapXfgE9DEfNTMn7H7eSUowtlhjzEyPzeMJf0I3BwzvRsV
         3YW4VSrY1wx4NXVdddtMPiqzgoYz9iKfAfJufs+OBwNgm2cBws8/Ojj4oCj0MyspkU95
         08krq8RnwHe3XzyVUXb2HcRsx+uEG17/gTHgT/LfadcIX7DOgWTuOwN7DnBOnLK9dMUp
         ayJw==
X-Gm-Message-State: AOJu0YxDiRrDO2NjddYSD5KtigRFcwWxEJl4KOLiMRomC7r/5W9+G9cu
        9tPOvuj0crQfcS5ATJmUwURoE5HJNQGmV4+pDIo=
X-Google-Smtp-Source: AGHT+IFTvP3Wf65NjXpx47x/yisJ7n5vuQ+OEFbehrvfi4VTsb45m2Zk3RNJbV/U6pmRWt7sWCtDlQ==
X-Received: by 2002:adf:f043:0:b0:315:a1f9:8667 with SMTP id t3-20020adff043000000b00315a1f98667mr1446492wro.23.1692350684666;
        Fri, 18 Aug 2023 02:24:44 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id t12-20020a5d6a4c000000b003179d5aee63sm2114923wrw.91.2023.08.18.02.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 02:24:44 -0700 (PDT)
Message-ID: <7d932461-bb81-5a6e-4252-fa56ddf2ace5@nexus-software.ie>
Date:   Fri, 18 Aug 2023 10:24:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arm64: dts: qcom: Use QCOM_SCM_VMID defines for qcom,vmid
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230818-qcom-vmid-defines-v1-1-45b610c96b13@fairphone.com>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <20230818-qcom-vmid-defines-v1-1-45b610c96b13@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2023 09:06, Luca Weiss wrote:
> Since we have those defines available in a header, let's use them
> everywhere where qcom,vmid property is used.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi          | 2 +-
>   arch/arm64/boot/dts/qcom/msm8996.dtsi                        | 3 ++-
>   arch/arm64/boot/dts/qcom/msm8998.dtsi                        | 3 ++-
>   arch/arm64/boot/dts/qcom/sc7180.dtsi                         | 3 ++-
>   arch/arm64/boot/dts/qcom/sc7280.dtsi                         | 3 ++-
>   arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts          | 3 ++-
>   arch/arm64/boot/dts/qcom/sc8180x-primus.dts                  | 3 ++-
>   arch/arm64/boot/dts/qcom/sdm630.dtsi                         | 3 ++-
>   arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi               | 2 +-
>   arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi          | 2 +-
>   arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 2 +-
>   arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts           | 2 +-
>   arch/arm64/boot/dts/qcom/sdm845.dtsi                         | 2 +-
>   arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts            | 3 ++-
>   arch/arm64/boot/dts/qcom/sm8150.dtsi                         | 3 ++-
>   arch/arm64/boot/dts/qcom/sm8350.dtsi                         | 3 ++-
>   arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi      | 2 +-
>   arch/arm64/boot/dts/qcom/sm8450.dtsi                         | 3 ++-
>   arch/arm64/boot/dts/qcom/sm8550.dtsi                         | 3 ++-
>   19 files changed, 31 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
> index bcd2397eb373..baa7472b7a28 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
> @@ -117,7 +117,7 @@ rmtfs@f6c00000 {
>   			no-map;
>   
>   			qcom,client-id = <1>;
> -			qcom,vmid = <15>;
> +			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
>   		};
>   
>   		/delete-node/ mba@91500000;
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index c8e0986425ab..6ba9da9e6a8b 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -9,6 +9,7 @@
>   #include <dt-bindings/clock/qcom,rpmcc.h>
>   #include <dt-bindings/interconnect/qcom,msm8996.h>
>   #include <dt-bindings/interconnect/qcom,msm8996-cbf.h>
> +#include <dt-bindings/firmware/qcom,scm.h>
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/power/qcom-rpmpd.h>
>   #include <dt-bindings/soc/qcom,apr.h>
> @@ -538,7 +539,7 @@ rmtfs_mem: rmtfs {
>   			no-map;
>   
>   			qcom,client-id = <1>;
> -			qcom,vmid = <15>;
> +			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
>   		};
>   
>   		mpss_mem: mpss@88800000 {
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index f180047cacb0..aac23a8ef6c8 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -6,6 +6,7 @@
>   #include <dt-bindings/clock/qcom,gpucc-msm8998.h>
>   #include <dt-bindings/clock/qcom,mmcc-msm8998.h>
>   #include <dt-bindings/clock/qcom,rpmcc.h>
> +#include <dt-bindings/firmware/qcom,scm.h>
>   #include <dt-bindings/power/qcom-rpmpd.h>
>   #include <dt-bindings/gpio/gpio.h>
>   
> @@ -56,7 +57,7 @@ rmtfs_mem: memory@88f00000 {
>   			no-map;
>   
>   			qcom,client-id = <1>;
> -			qcom,vmid = <15>;
> +			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
>   		};
>   
>   		spss_mem: memory@8ab00000 {
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index a79c0f2e1879..d57418113b36 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -11,6 +11,7 @@
>   #include <dt-bindings/clock/qcom,lpasscorecc-sc7180.h>
>   #include <dt-bindings/clock/qcom,rpmh.h>
>   #include <dt-bindings/clock/qcom,videocc-sc7180.h>
> +#include <dt-bindings/firmware/qcom,scm.h>
>   #include <dt-bindings/interconnect/qcom,icc.h>
>   #include <dt-bindings/interconnect/qcom,osm-l3.h>
>   #include <dt-bindings/interconnect/qcom,sc7180.h>
> @@ -687,7 +688,7 @@ rmtfs_mem: memory@94600000 {
>   			no-map;
>   
>   			qcom,client-id = <1>;
> -			qcom,vmid = <15>;
> +			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 925428a5f6ae..042908048d09 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -13,6 +13,7 @@
>   #include <dt-bindings/clock/qcom,rpmh.h>
>   #include <dt-bindings/clock/qcom,videocc-sc7280.h>
>   #include <dt-bindings/dma/qcom-gpi.h>
> +#include <dt-bindings/firmware/qcom,scm.h>
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/interconnect/qcom,osm-l3.h>
>   #include <dt-bindings/interconnect/qcom,sc7280.h>
> @@ -156,7 +157,7 @@ rmtfs_mem: memory@9c900000 {
>   			no-map;
>   
>   			qcom,client-id = <1>;
> -			qcom,vmid = <15>;
> +			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
> index abc66613ccaa..3ea07d094b60 100644
> --- a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
> @@ -6,6 +6,7 @@
>   
>   /dts-v1/;
>   
> +#include <dt-bindings/firmware/qcom,scm.h>
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/input/gpio-keys.h>
>   #include <dt-bindings/input/input.h>
> @@ -130,7 +131,7 @@ rmtfs_mem: rmtfs-region@85500000 {
>   			no-map;
>   
>   			qcom,client-id = <1>;
> -			qcom,vmid = <15>;
> +			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
>   		};
>   
>   		wlan_mem: wlan-region@8bc00000 {
> diff --git a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
> index 834e6f9fb7c8..fd2fab4895b3 100644
> --- a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
> @@ -6,6 +6,7 @@
>   
>   /dts-v1/;
>   
> +#include <dt-bindings/firmware/qcom,scm.h>
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/input/gpio-keys.h>
>   #include <dt-bindings/input/input.h>
> @@ -135,7 +136,7 @@ rmtfs_mem: rmtfs-region@85500000 {
>   			no-map;
>   
>   			qcom,client-id = <1>;
> -			qcom,vmid = <15>;
> +			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
>   		};
>   
>   		wlan_mem: wlan-region@8bc00000 {
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index ec6003212c4d..c17719086085 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -8,6 +8,7 @@
>   #include <dt-bindings/clock/qcom,gpucc-sdm660.h>
>   #include <dt-bindings/clock/qcom,mmcc-sdm660.h>
>   #include <dt-bindings/clock/qcom,rpmcc.h>
> +#include <dt-bindings/firmware/qcom,scm.h>
>   #include <dt-bindings/interconnect/qcom,sdm660.h>
>   #include <dt-bindings/power/qcom-rpmpd.h>
>   #include <dt-bindings/gpio/gpio.h>
> @@ -453,7 +454,7 @@ rmtfs_mem: memory@85e00000 {
>   			no-map;
>   
>   			qcom,client-id = <1>;
> -			qcom,vmid = <15>;
> +			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
>   		};
>   
>   		smem_region: smem-mem@86000000 {
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> index f942c5afea9b..99dafc6716e7 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> @@ -111,7 +111,7 @@ rmtfs_mem: memory@f0801000 {
>   			no-map;
>   
>   			qcom,client-id = <1>;
> -			qcom,vmid = <15>;
> +			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
>   		};
>   
>   		/* rmtfs upper guard */
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> index 122c7128dea9..b523b5fff702 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> @@ -90,7 +90,7 @@ rmtfs_mem: rmtfs-mem@f5b01000 {
>   			no-map;
>   
>   			qcom,client-id = <1>;
> -			qcom,vmid = <15>;
> +			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
>   		};
>   		rmtfs_upper_guard: rmtfs-upper-guard@f5d01000 {
>   			no-map;
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> index 9d6faeb65624..93b1582e807d 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> @@ -111,7 +111,7 @@ rmtfs_mem: memory@f6301000 {
>   			no-map;
>   
>   			qcom,client-id = <1>;
> -			qcom,vmid = <15>;
> +			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> index 6db12abaa88d..e386b504e978 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> @@ -108,7 +108,7 @@ rmtfs_mem: memory@f6301000 {
>   			no-map;
>   
>   			qcom,client-id = <1>;
> -			qcom,vmid = <15>;
> +			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 055ca80c0075..eede4b18fb98 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -813,7 +813,7 @@ rmtfs_mem: rmtfs@88f00000 {
>   			no-map;
>   
>   			qcom,client-id = <1>;
> -			qcom,vmid = <15>;
> +			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
>   		};
>   
>   		qseecom_mem: qseecom@8ab00000 {
> diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> index 18171c5d8a38..136e273d09a7 100644
> --- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> +++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> @@ -8,6 +8,7 @@
>   /* PMK8350 (in reality a PMK8003) is configured to use SID6 instead of 0 */
>   #define PMK8350_SID 6
>   
> +#include <dt-bindings/firmware/qcom,scm.h>
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
>   #include <dt-bindings/input/input.h>
> @@ -75,7 +76,7 @@ memory@efe01000 {
>   			no-map;
>   
>   			qcom,client-id = <1>;
> -			qcom,vmid = <15>;
> +			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index a7c3020a5de4..fd5c3139f4ce 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -5,6 +5,7 @@
>    */
>   
>   #include <dt-bindings/dma/qcom-gpi.h>
> +#include <dt-bindings/firmware/qcom,scm.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/power/qcom-rpmpd.h>
>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> @@ -720,7 +721,7 @@ rmtfs_mem: memory@89b00000 {
>   			no-map;
>   
>   			qcom,client-id = <1>;
> -			qcom,vmid = <15>;
> +			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
>   		};
>   
>   		camera_mem: memory@8b700000 {
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index 00604bf7724f..4989a3971c94 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -10,6 +10,7 @@
>   #include <dt-bindings/clock/qcom,gpucc-sm8350.h>
>   #include <dt-bindings/clock/qcom,rpmh.h>
>   #include <dt-bindings/dma/qcom-gpi.h>
> +#include <dt-bindings/firmware/qcom,scm.h>
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/interconnect/qcom,sm8350.h>
>   #include <dt-bindings/mailbox/qcom-ipcc.h>
> @@ -503,7 +504,7 @@ rmtfs_mem: memory@9b800000 {
>   			no-map;
>   
>   			qcom,client-id = <1>;
> -			qcom,vmid = <15>;
> +			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
>   		};
>   
>   		hyp_reserved_mem: memory@d0000000 {
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
> index 001fb2723fbb..8b29fcf483a3 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
> @@ -80,7 +80,7 @@ rmtfs_mem: memory@f3300000 {
>   			no-map;
>   
>   			qcom,client-id = <1>;
> -			qcom,vmid = <15>;
> +			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
>   		};
>   
>   		ramoops@ffc00000 {
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 2a60cf8bd891..09a0c35dd514 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -10,6 +10,7 @@
>   #include <dt-bindings/clock/qcom,sm8450-dispcc.h>
>   #include <dt-bindings/clock/qcom,sm8450-videocc.h>
>   #include <dt-bindings/dma/qcom-gpi.h>
> +#include <dt-bindings/firmware/qcom,scm.h>
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/mailbox/qcom-ipcc.h>
>   #include <dt-bindings/phy/phy-qcom-qmp.h>
> @@ -540,7 +541,7 @@ rmtfs_mem: memory@9fd00000 {
>   			no-map;
>   
>   			qcom,client-id = <1>;
> -			qcom,vmid = <15>;
> +			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
>   		};
>   
>   		xbl_sc_mem2: memory@a6e00000 {
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index d115960bdeec..1a3bbd62e540 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -10,6 +10,7 @@
>   #include <dt-bindings/clock/qcom,sm8550-tcsr.h>
>   #include <dt-bindings/clock/qcom,sm8550-dispcc.h>
>   #include <dt-bindings/dma/qcom-gpi.h>
> +#include <dt-bindings/firmware/qcom,scm.h>
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/interconnect/qcom,sm8550-rpmh.h>
> @@ -570,7 +571,7 @@ rmtfs_mem: rmtfs-region@d4a80000 {
>   			no-map;
>   
>   			qcom,client-id = <1>;
> -			qcom,vmid = <15>;
> +			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
>   		};
>   
>   		mpss_dsm_mem: mpss-dsm-region@d4d00000 {
> 
> ---
> base-commit: 7271b2a530428b879443b274c191b34536a4ea11
> change-id: 20230818-qcom-vmid-defines-adc1794c6d01
> 
> Best regards,

Obvioiusly correct

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
