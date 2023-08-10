Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A90776F93
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjHJFae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjHJFad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:30:33 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCB3B2;
        Wed,  9 Aug 2023 22:30:32 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9f48b6796so7751681fa.3;
        Wed, 09 Aug 2023 22:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691645431; x=1692250231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30amGjfvJTBzHpSdNGSq5W5BFRV06ZH4E2JkfkUbGj0=;
        b=ZmVa8rCr+dvmS3vj3BPvScvgeR/ZiX/cqxvm7kxyMVAqK5bV+JSmyF+XlyElCxgO/P
         hqOFRMZZlvGfKYsYYXG+LGloeAw9BD0A8omUWfDhJTAJFtHYIBruvRCa4MLY22wPldfl
         IfP0+Qk+husTCeuQrvBZ6v9j1MZTgx7+kXPG5tOhaRHnRwIJ6ijR7Onuz9ov2zN6UszD
         q77+/bcCFgjAVgtrkzNl8S/cpHtCpLy0uVC1o1anQbPHOC466M8AXVroc4rPjaZthGSb
         9PCshHcrwoKXIWtJRQ5JVsm0WM1OWg7ShiIYMkRG47w1fTqVvinE532E0XvpKr2lP8Yv
         ZV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691645431; x=1692250231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30amGjfvJTBzHpSdNGSq5W5BFRV06ZH4E2JkfkUbGj0=;
        b=Y1kVx6W8xMQXiZxH4Voupo3HYrkoFDRdvk8/eZs324Xo3QpEVvw1PDtBB1/zEJF9/y
         2yQN+9FP0HFWUS2NTgkeCokHUnFYm8hvgupxm6mllaOFa+qPSjWbDdE58A4x03bnI+E3
         So4gzKu2MUFWjxHu/HQFjTTA87z3K4MCZZPpQ7QqJ/rmSkmYrPrc+WBs1Tj+KMgB1AnP
         Ha2OgwpZquqCZ+gP8IOAIf8cwOpx9HfPHIietrtnTCADeCvOh8rS8uQJajhepK7CEzbu
         kwimc9DEDmWPerYRTqWSBLULpuu5NKKCo901fzU9EDgpZk6qTVRWnGi5fiyXJw9ru+/h
         Qj1Q==
X-Gm-Message-State: AOJu0YxS2x32TJKApxzTa1I3KmDTt4iIizCk45IvqsRdFNxV4dq6pZ+o
        wjpqJdkRk2u48fTfm0eSJ/U+XyWNSMUIh+cSS0RAq9uwwBW7o7SeK3YnMg==
X-Google-Smtp-Source: AGHT+IHfIIaAt4Zm3bvW7BH2Jug1KxkIscHSFYA+CcqWDev6fLSwFJGvk59WYPUywyFiJV5blZ74LF8UblovZYzzlyc=
X-Received: by 2002:a2e:8756:0:b0:2b9:c864:9e3f with SMTP id
 q22-20020a2e8756000000b002b9c8649e3fmr933560ljj.39.1691645430516; Wed, 09 Aug
 2023 22:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230806-xiaomi-star-v1-0-0c384e8b5737@gmail.com>
 <20230806-xiaomi-star-v1-3-0c384e8b5737@gmail.com> <27bd3a9e-192f-43e9-b417-784c6d9c3ecd@linaro.org>
In-Reply-To: <27bd3a9e-192f-43e9-b417-784c6d9c3ecd@linaro.org>
From:   Sophon Wu <wuxilin123@gmail.com>
Date:   Thu, 10 Aug 2023 13:30:18 +0800
Message-ID: <CAEPPPKsOTJkfd8sn=ApUKPf6MqQOEmVk9EC8OJd-Ln82cF0Xnw@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: Add device tree for Xiaomi Mi 11 Ultra
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
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

Konrad Dybcio <konrad.dybcio@linaro.org> =E4=BA=8E2023=E5=B9=B48=E6=9C=888=
=E6=97=A5=E5=91=A8=E4=BA=8C 00:05=E5=86=99=E9=81=93=EF=BC=9A
>On 5.08.2023 19:03, Xilin Wu via B4 Relay wrote:
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
>> To create a working boot image, you need to run:
>> cat arch/arm64/boot/Image.gz arch/arm64/boot/dts/qcom/sm8350-xiaomi-\
>> star.dtb > .Image.gz-dtb
>>
>> mkbootimg \
>> --kernel .Image.gz-dtb \
>> --ramdisk some_initrd.img \
>> --pagesize 4096 \
>> --base 0x0 \
>> --kernel_offset 0x8000 \
>> --ramdisk_offset 0x1000000 \
>> --tags_offset 0x100 \
>> --cmdline "SOME_CMDLINE" \
>> --dtb_offset 0x1f00000 \
>> --header_version 1 \
>> --os_version 14.0.0 \
>> --os_patch_level 2099-12 \
>> -o boot.img-xiaomi-star
>>
>> Then, you can flash it to slot b on the device:
>>
>> // You have to either pull vbmeta{"","_system"} from
>> // /dev/block/bootdevice/by-name/ or build one as a part of AOSP build p=
rocess
>> fastboot --disable-verity --disable-verification flash vbmeta_b vbmeta.i=
mg
>> fastboot --disable-verity --disable-verification flash vbmeta_system_b \
>> vbmeta_system.img
>>
>> fastboot flash boot_b boot.img-xiaomi-star
>> fastboot erase dtbo_b
>> fastboot set_active b
>> fastboot reboot
>>
>> Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
>> ---
>[...]
>
>
>> +&adsp {
>> +    status =3D "okay";
>> +    firmware-name =3D "qcom/sm8350/xiaomi/star/adsp.mbn";
>> +};
>Please keep status as the last property, everywhere.
>
>BTW, is the rear screen connected via DSI, or is it some stupid
>SPI display?
>
>Konrad

Thanks. Will fix in v2. The rear screen is connected via DSI.
