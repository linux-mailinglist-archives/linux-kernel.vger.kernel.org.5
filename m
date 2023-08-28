Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA9878A66F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjH1H04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 03:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjH1H0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:26:45 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050A5115
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:26:43 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52a4b62c2f5so3785137a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1693207601; x=1693812401;
        h=in-reply-to:references:from:subject:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lD+bH3AMRurEOkbO1lVj8kynQTkw3OHuE6DLrk9W2+w=;
        b=HanQgw/owHxOSJ9ZXO5SKNKPj9oygSSaieibswIOOpOlWGgaCgZ3+Rwn5NlkJc+Rm9
         p7S43H3BVVv32KfTsR0zMHuiGn881L+Z4ECw6BeambSg/nDc+EtQdPJWEcEHbM5k/bwg
         PrfCHnIQ9hkmENzV91xXUJYohiOEYUMxT5TWkF4KQbA58Ui3wYvL+AO3aPmW8hFTaHMJ
         DWTkBwsELhTtLNKOAObKKX5zq2dV8iqYW6US9qLwectQ2jcN53eVkUReNA8222odpdLZ
         DFEuTniyuO/XJ6W14gwVdIl2qvRNsX8wDHeHRxKCgLdBjTmTIy/qiLwNLoHFrzx+3aaP
         WOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693207601; x=1693812401;
        h=in-reply-to:references:from:subject:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lD+bH3AMRurEOkbO1lVj8kynQTkw3OHuE6DLrk9W2+w=;
        b=S4pLs8ZGusFqCzKK29Hat0O/vK+0PlYDhtqTAPwV1OkGenPDlDdPY0H9kVaw1FYMg0
         ObPjLhbkaUPspZtqpl4cBPy/eWvOpiE+6eT+Anx/3Wp6C7n9AYcrytgBFM4ZASSLY8gF
         WeuKxsydxziePwQOXcrRNXSLp4GnL1cTMqAvdqT2BcBjo7fV624a5WmLex44eDdHmMEc
         Io8GilF1WwSmzehUYKpxMsveGtrxj1Z8zuAAXv9AwmdU6C26aDpWPJjIL70u3XrUKozf
         kQGzsxpkgYJ4GDtUdYEueK9SO0IF2BCrbwAv4vebM+NqckqQAxDNy7+B1sn02Jr0ENAU
         AlFg==
X-Gm-Message-State: AOJu0YwxdZ9Di7DJYDHoYViZgCNv+Cz3cW7wn9l9HfFtvbJy/NhNMiED
        4RBF/c3wihncbg1ylFMGoSjHHQ==
X-Google-Smtp-Source: AGHT+IECQi/+bCK/FrctXnpXooL6ck48hvBin19hwEds/rInCzSAhpQkXhFZ1B01lhVS1rWBX7KFxA==
X-Received: by 2002:aa7:d9d8:0:b0:525:734a:bf30 with SMTP id v24-20020aa7d9d8000000b00525734abf30mr21317244eds.36.1693207601453;
        Mon, 28 Aug 2023 00:26:41 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id k3-20020aa7d8c3000000b005224d960e66sm4139697eds.96.2023.08.28.00.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 00:26:41 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 28 Aug 2023 09:26:40 +0200
Message-Id: <CV4001I45VX3.O7ZEXEDZTHAR@otso>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm7225-fp4: Revert "arm64: dts:
 qcom: sm7225-fairphone-fp4: Add AW8695 haptics"
From:   "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.15.2
References: <20230827122842.63741-1-krzysztof.kozlowski@linaro.org>
 <20230827122842.63741-3-krzysztof.kozlowski@linaro.org>
 <CV3ZCVK29BLY.D7Y8AEEOYLO3@otso>
 <7859abb1-ae99-d33f-a8fc-c76304057df9@linaro.org>
In-Reply-To: <7859abb1-ae99-d33f-a8fc-c76304057df9@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Aug 28, 2023 at 9:00 AM CEST, Krzysztof Kozlowski wrote:
> On 28/08/2023 08:56, Luca Weiss wrote:
> > Hi Krzysztof,
> >=20
> > On Sun Aug 27, 2023 at 2:28 PM CEST, Krzysztof Kozlowski wrote:
> >> This reverts commit 413821b7777d062b57f8dc66ab088ed390cbc3ec because i=
t
> >> was never reviewed, was buggy (report from kernel test robot:
> >> https://lore.kernel.org/all/202204090333.QZXMI2tu-lkp@intel.com/) and
> >=20
> > (I wouldn't say this part is accurate, the robot just didn't use a tree
> > with the i2c10 node already present, it was sent in an earlier patch
> > IIRC, but whatever)
> >=20
> >> used undocumented, broken bindings.  Half of the properties in this
> >> device are questioned, thus adding DTS node causes only errors and doe=
s
> >> not make the device usable without the bindings and driver part:
> >>
> >>   sm7225-fairphone-fp4.dtb: haptics@5a: failed to match any schema wit=
h compatible: ['awinic,aw8695']
> >>   sm7225-fairphone-fp4.dtb: haptics@5a: awinic,tset: b'\x12' is not of=
 type 'object', 'array', 'boolean', 'null'
> >>   sm7225-fairphone-fp4.dtb: haptics@5a: awinic,r-spare: b'h' is not of=
 type 'object', 'array', 'boolean', 'null'
> >>
> >> Since bindings were abandoned (4 months since review), revert the comm=
it
> >> to avoid false sense of supporting something which is not supported.
> >=20
> > I've been avoiding touching this topic again since I'm really not sure
> > how to resolve.
>
> Happens, but the DTS should not have been applied in such case.

True, back when it was applied I told Bjorn but I also thought I'd get
the driver in soon also. Obviously this hasn't happened. So fine with me
to revert now, and I'll add it back once the new bindings are in.

>
> >=20
> > There's a bunch of magic registers being written to in the downstream
> > driver, I don't have any documentation for that so I'm not exactly sure
> > what I can do to make nice bindings with proper properties.
> >=20
> > Would you recommend just hardcoding some of these properties in the
> > driver, assuming they're constant for every AW8695, even though the
> > downstream driver has these properties in devicetree? Because of that I
> > assumed these properties could differ per implementation / usage of the
> > AW8695 in different devices.
>
> Yes, keep them in the driver.

Okay.. I'll make sure to document this in the driver or commit message
or somewhere so other people using the same AW8695 will know that this
is hardcoded.

Regards
Luca

>
> Best regards,
> Krzysztof

