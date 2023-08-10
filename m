Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD59F776F87
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjHJF0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHJF0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:26:50 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C22710C0;
        Wed,  9 Aug 2023 22:26:49 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so7672501fa.3;
        Wed, 09 Aug 2023 22:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691645207; x=1692250007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsI9x9IG1bZ+yuBcthHpugjdGbTissZjzHwL0IEq2KM=;
        b=ahIVUzL5+RiPeiISxrpkHnmwyQr+FaVWWbUkIpXxWl04TNQRQxg8u0h5Bup7dxmHWd
         +tRXsOuuYITfxl8lf08PBOLCz6yoQiXmOPuHA27ytmWzDPToG20+Vwd0sfcaVUHS2DJ6
         rvG1p7EGckRmAWi2VZ13l17kwS0sz468BXkydS58g6qlzuTmksemdX7I0JYMMLh04KlF
         w858neyxYypnPbg32KrBl9tLTFgCd8cr6ITS2/5F+85LkuDTBK3lp+3OYL+EceGusNWt
         33q+4IKPiXQsmracfbldtxeQa8oYredakN0YDdW7ekD1oxOuKyH9dnfwNyqJh0xa8rM/
         xb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691645207; x=1692250007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SsI9x9IG1bZ+yuBcthHpugjdGbTissZjzHwL0IEq2KM=;
        b=dLBa4vmr0ZMuT9D9hLKrBmHJlvJ+dCAvQLUp3cn/SmQ1Yi5bI/EtWnYR67OrZT3E4p
         4oac5Dyzt1QI9XGFSCrdSLzZrCJ0UltYbzH36OOS9EGlsMw52w7GR9zojpWfrPhurLLW
         vC3sMz84w6nnpiPS+mdFDhQ6HJTXfUwAc1ehXiPzI4kDOmCV2Q0ycw2f4+l72fQk5nhz
         f3KX1/UxmVd1WeqIxXxN80ZUdLTVKxFmqNICgTCBO1YC2CZ2Zb61w+TKP5ee6HHQS0/n
         scfL6uUtiF4uCtajO6wZr1Hr5C2gislJkcpU0VbKHEwc0mM8NqdXZ0TXf/eTclr+wYTF
         /vpg==
X-Gm-Message-State: AOJu0YxGtjfABclmdkNpFOk0gZUra8kjck4Haxxu90H4iHBHQzijhyPr
        +3FCz4ulWKp3ggRutF7TLv1xBKQignmtcNplYJg=
X-Google-Smtp-Source: AGHT+IF6jGVS8OlkOIUiTlTU9GIZYc5iiSDw1TUPAGdTnqivCp5efm3WIKxCrDFyZB76Vsf2De59zyp1yq8ftFPgkro=
X-Received: by 2002:a2e:731a:0:b0:2b9:d0dc:53a9 with SMTP id
 o26-20020a2e731a000000b002b9d0dc53a9mr858991ljc.27.1691645207165; Wed, 09 Aug
 2023 22:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230806-xiaomi-star-v1-0-0c384e8b5737@gmail.com>
 <20230806-xiaomi-star-v1-2-0c384e8b5737@gmail.com> <3f3f7d1b-d850-7d93-6f92-f16797f5b081@linaro.org>
In-Reply-To: <3f3f7d1b-d850-7d93-6f92-f16797f5b081@linaro.org>
From:   Sophon Wu <wuxilin123@gmail.com>
Date:   Thu, 10 Aug 2023 13:26:35 +0800
Message-ID: <CAEPPPKvS4G5RUs1Fb0anGUELC8_5eVvG+2ORd_xYupuu1SKGww@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: arm: qcom: Add Xiaomi Mi 11 Ultra
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E4=BA=8E2023=E5=B9=B4=
8=E6=9C=886=E6=97=A5=E5=91=A8=E6=97=A5 04:11=E5=86=99=E9=81=93=EF=BC=9A

>On 05/08/2023 19:03, Xilin Wu via B4 Relay wrote:
>> From: Xilin Wu <wuxilin123@gmail.com>
>>
>> Add support for Xiaomi Mi 11 Ultra. This commit brings support for:
>> * Front and rear display panels (initialized by bootloader)
>> * USB
>> * UFS
>> * PCIe0
>> * Thermistor sensors
>> * ADSP/CDSP/Modem/SLPI
>> * IR Transmitter
>> * RTC provided by PMK8350
>> * Buttons
>>
>
>...
>
>
>> +/*
>> + * Delete following upstream (sm8350.dtsi) reserved
>> + * memory mappings which are different on this device.
>
>
>> + */
>> +/delete-node/ &pil_adsp_mem;
>> +/delete-node/ &pil_slpi_mem;
>> +/delete-node/ &pil_cdsp_mem;
>> +/delete-node/ &pil_ipa_fw_mem;
>> +/delete-node/ &pil_ipa_gsi_mem;
>> +/delete-node/ &pil_gpu_mem;
>> +/delete-node/ &pil_spss_mem;
>> +/delete-node/ &pil_modem_mem;
>> +/delete-node/ &rmtfs_mem;
>> +/delete-node/ &pil_trustedvm_mem;
>> +/delete-node/ &removed_mem;
>> +
>> +/ {
>> +    model =3D "Xiaomi Mi 11 Ultra";
>> +    compatible =3D "xiaomi,star", "qcom,sm8350";
>> +    chassis-type =3D "handset";
>> +
>> +    chosen {
>> +        #address-cells =3D <2>;
>> +        #size-cells =3D <2>;
>> +        ranges;
>> +
>> +        framebuffer0: framebuffer-front@ea600000 {
>
>framebuffer@
>
>> +            compatible =3D "simple-framebuffer";
>> +            reg =3D <0 0xea600000 0 (1440 * 3200 * 4)>;
>> +
>> +            width =3D <1440>;
>> +            height =3D <3200>;
>> +            stride =3D <(1440 * 4)>;
>> +            format =3D "a8r8g8b8";
>> +        };
>> +
>> +        framebuffer1: framebuffer-rear@eb79c000 {
>
>framebuffer@
>
>> +            compatible =3D "simple-framebuffer";
>> +            reg =3D <0 0xeb79c000 0 (126 * 294 * 4)>;
>> +
>> +            width =3D <126>;
>> +            height =3D <294>;
>> +            stride =3D <(126 * 4)>;
>> +            format =3D "a8r8g8b8";
>> +        };
>> +    };
>> +
>

Will fix in v2.

>
>
>> +            reg =3D <0 0x86100000 0 0x3900000>;
>> +            no-map;
>> +        };
>> +
>> +        pil_slpi_mem: memory@89a00000 {
>> +            reg =3D <0 0x89a00000 0 0x2f00000>;
>> +            no-map;
>> +        };
>> +
>> +        pil_cdsp_mem: memory@8c900000 {
>> +            reg =3D <0 0x8c900000 0 0x1e00000>;
>> +            no-map;
>> +        };
>> +
>> +        pil_ipa_fw_mem: memory@8e700000 {
>> +            reg =3D <0 0x8e700000 0 0x10000>;
>> +            no-map;
>> +        };
>> +
>> +        pil_ipa_gsi_mem: memory@8e710000 {
>> +            reg =3D <0 0x8e710000 0 0xa000>;
>> +            no-map;
>> +        };
>> +
>
>...
>
>> +&pm8350c_gpios {
>> +    gpio-line-names =3D "VDD_BOOST_5V_EN",
>> +              "NC",
>> +              "OTG_OVP_EN",
>> +              "WL_TXON",
>> +              "NC",
>> +              "NC",
>> +              "NC",
>> +              "NC",
>> +              "NC";
>> +};
>> +
>> +&pmk8350_adc_tm {
>> +    status =3D "okay";
>> +
>> +    pm8350-skin-therm@0 {
>
>Hm, didn't we change the node names to generic "channel" and started
>using labels? At least in next or ongoing patches? Or was it only for VADC=
?

I thought it was only for VADC. "channel" is not used in binding as well.
