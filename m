Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0617F785517
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjHWKOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbjHWISZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:18:25 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9094D173A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:13:28 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bf1876ef69so6943425ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1692778408; x=1693383208;
        h=content-transfer-encoding:from:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uPYZRiCWdfcBmVk4Z2ZSZmkEBJcTzAi37FD8SmtDKSQ=;
        b=COr884OY7Ti6LzBFMzohHrlTiyM9nEGBBZ829FMP8mdRS5G9NS5Ly6JjlSplLQSbmA
         IzWoRRVSsId+RDCAm97h928CfZtt709/8FUrCroI7ePzXFS4VT8sRfgWAqF0+Ifgdjc/
         NXYiqYCYA9d69g32qF64AI7vv1vj/KqTnUhxRU9LIofOFJ6IOXolga8WqgWm3Wl200TL
         imcZJdcTR1ogbkB9zfFRZeKnRtGqmjGz+qml427AZIjaoOkdMywwZNxqH6rseIkCxLHZ
         y0/QfaAZdhngAkjSYd/0JKAtuA1vEu83PSKkBVAOQ75A//oXwLIA6RSwGWS6tnO4dLob
         USgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778408; x=1693383208;
        h=content-transfer-encoding:from:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uPYZRiCWdfcBmVk4Z2ZSZmkEBJcTzAi37FD8SmtDKSQ=;
        b=ljAaNsP4lIFP8zaIOYAnZYktfO/WjaoYangEL26nf7ApeTUR9WdzLTyYxdrHSJeh+m
         kVzv5FsoIt/NZDdLct0trL0EozlYIEsBUfnSb+zHNImQN99NiTYChvvzZVQ82FOQmY7p
         lvmKSPKTxkNDHcinQEbAXiaedwzNRyvEEUmAfzux1Gi9m4rX1cTR1H8muh76DUfMO5AC
         bsMQXMyJdKPELhG0AIkcFGU8W49dGlXBxNgnXr6NOzGrwxPbxaB1aBorxC7yohhfiyO3
         aJ1NYnlrAAKOgFuQzZpiQBKsLNMbRxoXi1xqBAgdBVFQDZue/jVUQoMQJiQ/2C/e5xP5
         ywfw==
X-Gm-Message-State: AOJu0Yxfjg7u0JHzYkEi0/iTnI+TnBh1Cm9GjzXi8O14HtVYFjJvUFmg
        30/WszLbgUhycBD3gwXXLTMfig==
X-Google-Smtp-Source: AGHT+IFPpiv+dTOOaBaAhaKP/zWhWpdgtDNFuvpOw7a96FKFMPrgt6OkW0V+V/isPVgw3ijApW3WRg==
X-Received: by 2002:a17:903:32c2:b0:1bf:1a9e:85f7 with SMTP id i2-20020a17090332c200b001bf1a9e85f7mr13240095plr.1.1692778407984;
        Wed, 23 Aug 2023 01:13:27 -0700 (PDT)
Received: from [192.168.0.224] (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id b23-20020a170902b61700b001b86492d724sm10284799pls.223.2023.08.23.01.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 01:13:27 -0700 (PDT)
Message-ID: <701e84ba-3388-347a-369b-aa707e86ff06@quanta.corp-partner.google.com>
Date:   Wed, 23 Aug 2023 16:13:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 2/2] arm64: dts: qcom: sc7180: Add sku_id and board id
 for lazor/limozeen
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230822100359.124282-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20230822180054.v5.2.I8f20fdfe34a2e8a38373bbd65587754b324f3dcb@changeid>
 <CAD=FV=U5XZn_BXuYrkZbr2JqiPptKt=JsyhYjciBzjKhmTdPDw@mail.gmail.com>
In-Reply-To: <CAD=FV=U5XZn_BXuYrkZbr2JqiPptKt=JsyhYjciBzjKhmTdPDw@mail.gmail.com>
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> Hi,
>
> On Tue, Aug 22, 2023 at 3:04 AM Sheng-Liang Pan
> <sheng-liang.pan@quanta.corp-partner.google.com> wrote:
>> SKU ID 10: Lazor LTE+Wifi, no-esim (Strapped 0 X 0)
>> SKU ID 15: Limozeen LTE+Wifi, TS, no esim (Strapped 1 X 0)
>> SKU ID 18: Limozeen LTE+Wifi, no TS, no esim (Strapped X 0 0)
>>
>> Even though the "no esim" boards are strapped differently than
>> ones that have an esim, the esim isn't represented in the
>> device tree so the same device tree can be used for LTE w/ esim
>> and LTE w/out esim.
>>
>> add BRD_ID(0, Z, 0) = 10 for new board with ALC5682i-VS
>>
>> Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
>> ---
> You should add a note here ("after the cut", in other words after the
> "---" above but before your changelog) explaining that your patch
> absolutely requires my patch [1] in order to compile. Please provide a
> link to my patch (AKA include link [1]), too. I _think_ that maybe
> you're using "patman" to format your patch? If so then this would be
> done using "Commit-notes:". Maintainers have a lot of patches to apply
> and we need to make it really easy for them to figure out what order
> they need to apply patches in and which patches depend on others.
>
> [1] https://lore.kernel.org/r/20230816112143.1.I7227efd47e0dc42b6ff243bd22aa1a3e01923220@changeid/
>
Patch v6 add dependent patch link.
>> Changes in v5:
>> - include rt5682s node for new board version 10
> This isn't quite what you did in v5. I would say:
> - rebased on patch moving rt5682s to a fragment
>
done.
>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dts
>> index 1c4f0773a242..cabe99c23a7c 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dts
>> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dts
>> @@ -14,8 +14,8 @@
>>   #include "sc7180-lite.dtsi"
>>
>>   / {
>> -       model = "Google Lazor (rev9+) with KB Backlight";
>> -       compatible = "google,lazor-sku2", "qcom,sc7180";
>> +       model = "Google Lazor (rev9) with KB Backlight";
>> +       compatible = "google,lazor-rev9-sku2", "qcom,sc7180";;
> nit: the above line has two ";". Remove one.
>
> IMO this is something you should spin a quick v6 for. Once that's fixed:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
done.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Sheng-Liang

