Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3925E76589A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbjG0Q0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjG0Q0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:26:32 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2911984;
        Thu, 27 Jul 2023 09:26:31 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742eso12993215e9.3;
        Thu, 27 Jul 2023 09:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690475190; x=1691079990;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tchYlHZMwfEha29OltN4SIaODl/6Qjb64Vc3sLHb8+Y=;
        b=PXB4tyAG2ehkamoaVnyGUUno9lFYnR4PLwIvLkeH9s+c9DaGYGMFY9sU9EEPhcYp/s
         C12h9gajnR6cC68M+ooloClgqVAOZCF1NQpy1/GN6EsKIbzsdheC2VZco0Kq3dUcvG8r
         JibXeFuWi9kOX37MkNjQe+oRYElXvpVPZUR6DugrwiZGDof5PKEcsdbXl2ASC5TraxyH
         Pw1fDLOp1cGq6QtqPLz1aCqdsv68kEWGLkY8K5T+qPP5jLZOxWlwaZ0OXVSkFHgiDG1n
         Qi5jK/UUjyLf/Fz8Hu+avkQXHSNxR4penrtFx11PAjDwYeivcYAh/hFZ1mQREaQq9Sj+
         QXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690475190; x=1691079990;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tchYlHZMwfEha29OltN4SIaODl/6Qjb64Vc3sLHb8+Y=;
        b=JmpBeCccUtfRZ/TxFYLf5CgY/0TIGu8IODfwYa57+UX2Ri+fdVjT2gTeWQjHBI9s8Q
         /Ec5NhTTIIOlHMoxE7DrS/12kSC9GzHIGpiAz/6usjztHk1cAgxNACOHyv9VB1DsY6Q8
         TiOk2eo4drp5G9xlf8I1giOQtvV4nTHHFrOMoxZOjR0PtrmoBYmtTErnIKSlLzYGSOlG
         KU8/AbNunePUJuhmA7bl67kd+BEPju3AaNwbv2JNClYhlcSmGalSMioJ8K+kXIV/UyNJ
         D8OuikXu8Fd9b6KxfLB511xm8g4CQCaGuA+XH7+puAJZn6AAxVd5FvMZDwP2TEj4F9Pa
         COKA==
X-Gm-Message-State: ABy/qLYQOP5Dpt0VHAiM/cYeSa0qtPDSnIywRLrunlydgixokCSwRYar
        OB3N7bmndpy1bUyez/21eAA=
X-Google-Smtp-Source: APBJJlGawCHttDuITQqdJcf15YH9xdR1nYtbyMSt+zes+gOlZU/94bNaWVZtNPWSoQzctCMMY7lURg==
X-Received: by 2002:a7b:ce08:0:b0:3fa:99d6:4798 with SMTP id m8-20020a7bce08000000b003fa99d64798mr2126312wmc.37.1690475189887;
        Thu, 27 Jul 2023 09:26:29 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.28.141])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c260e00b003fbca942499sm5118934wma.14.2023.07.27.09.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 09:26:29 -0700 (PDT)
Date:   Thu, 27 Jul 2023 19:26:28 +0300
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/2] ARM: tegra: transformers: add connector node
User-Agent: K-9 Mail for Android
In-Reply-To: <ZMKJE1G87-jWeg2_@orome>
References: <20230618085046.10081-1-clamor95@gmail.com> <20230618085046.10081-3-clamor95@gmail.com> <ZMKJE1G87-jWeg2_@orome>
Message-ID: <5A2447D3-DB49-4788-AA05-182AF0F04ED2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



27 =D0=BB=D0=B8=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 18:11:15 GMT+03:00, Thier=
ry Reding <thierry=2Ereding@gmail=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=B2(-=D0=BB=D0=B0):
>On Sun, Jun 18, 2023 at 11:50:46AM +0300, Svyatoslav Ryhel wrote:
>> All ASUS Transformers have micro-HDMI connector directly available=2E
>> After Tegra HDMI got bridge/connector support, we should use connector
>> framework for proper HW description=2E
>>=20
>> Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo=2Ecom> # ASUS TF T30
>> Tested-by: Robert Eckelmann <longnoserob@gmail=2Ecom> # ASUS TF101 T20
>> Tested-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom> # ASUS TF201 T30
>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>> ---
>>  arch/arm/boot/dts/tegra20-asus-tf101=2Edts      | 22 ++++++++++++++++-=
--
>>  =2E=2E=2E/dts/tegra30-asus-transformer-common=2Edtsi  | 21 +++++++++++=
+++++--
>>  2 files changed, 38 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/arch/arm/boot/dts/tegra20-asus-tf101=2Edts b/arch/arm/boot=
/dts/tegra20-asus-tf101=2Edts
>> index c2a9c3fb5b33=2E=2E97350f566539 100644
>> --- a/arch/arm/boot/dts/tegra20-asus-tf101=2Edts
>> +++ b/arch/arm/boot/dts/tegra20-asus-tf101=2Edts
>> @@ -82,9 +82,11 @@ hdmi@54280000 {
>>  			pll-supply =3D <&hdmi_pll_reg>;
>>  			hdmi-supply =3D <&vdd_hdmi_en>;
>> =20
>> -			nvidia,ddc-i2c-bus =3D <&hdmi_ddc>;
>> -			nvidia,hpd-gpio =3D <&gpio TEGRA_GPIO(N, 7)
>> -				GPIO_ACTIVE_HIGH>;
>> +			port@0 {
>> +				hdmi_out: endpoint {
>> +					remote-endpoint =3D <&connector_in>;
>> +				};
>> +			};
>
>Does this need a bindings change? nvidia,tegra20-hdmi currently doesn't
>support OF graphs, so this would probably fail to validate if we merge
>it without a corresponding DT bindings update=2E

drm/tegra patch is backwards compatible and connector node is optional=2E

>Thierry
