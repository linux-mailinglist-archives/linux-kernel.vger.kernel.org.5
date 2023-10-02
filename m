Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA25C7B4B8F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 08:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbjJBGkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 02:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbjJBGkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:40:16 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D20D9E
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 23:40:13 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so2131734966b.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 23:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1696228812; x=1696833612; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zc23Ml6s281iYcprl/tAvfX+YAKmlfawnLlUSvbGAsw=;
        b=a9aI1P6cq7Ijpu1/FDHEklBYUmNXr3T7UGImQIyyMhbvVWCeILBsLX9eY2XXb5fODg
         SWFxzRH3i+ycc50g9+QEai8wNguZm4zAcd/B9O/zvggFkSfphnAyF++6s0+CavagEX5g
         6knrqzB9C9ZpvZ3ReACWO7yhli9cpAC5cotlYOqprWqUzqfo5yrNH0giZ2VOlzAULXj9
         UFgksZzSmzZVXnu81TfwhF40BXOZqd12vn7xJOyNXnj15glQpsgVbTiOW51lePFRCXty
         elzJs4CadfuzxGUaUqk3Mu7TqdNrIfduy8PdqQeHgpNVrHl2+C/QNxhQZbjG+QRQtlqp
         mtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696228812; x=1696833612;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zc23Ml6s281iYcprl/tAvfX+YAKmlfawnLlUSvbGAsw=;
        b=KpaLqGGHTTLgMNFoA7jzddNlZnj8BtPNaREd7vXwsvV3Aii6s/7Ua5ur/WpJgINrsw
         FKygtfSx2INTKfK+v0YqUe93rNsE+oI0Xyxp03Jlpp+UlWgTuoj4l43UqnXh79e5Iffz
         8DMWu6OzHJsgGABoJzYDlvzuFQ2M2oqcC3JUC5N0bQ+UmxOXzL8HCAPZQ8GrcqY+ITQN
         Erbk8X4ON5fQd9igGPyZjyaBbN7XgmThmw19rP8KjgSxgsK/6jpOpd4x5d23v7M+G5aP
         D5Mjh5hFy9QmBqlSj9VlgHUL5oAdP34TxfIpGh1q5FcjAInQc9NjQ0UfMicMbC4kpr/E
         fUSA==
X-Gm-Message-State: AOJu0YxNleWa29g0vOSn7bQwFEoGzxp+HYE0vYkO4JW14b34pC/crWhP
        tHJZjhswztW6wLRF1oWsMGiaNw==
X-Google-Smtp-Source: AGHT+IEbfMSd1KQGutXy0/VQkgg3rL0bTo/Rz41LYjg+kFwRNU61ZSgXer1jAT8aCtRG/RaEmdxrSw==
X-Received: by 2002:a17:906:311b:b0:9a2:28dc:4168 with SMTP id 27-20020a170906311b00b009a228dc4168mr8602028ejx.61.1696228811729;
        Sun, 01 Oct 2023 23:40:11 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id kg28-20020a17090776fc00b0099b921de301sm16491457ejc.159.2023.10.01.23.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Oct 2023 23:40:11 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 02 Oct 2023 08:40:10 +0200
Message-Id: <CVXQXI5E053J.386OVO28LNSYT@otso>
Cc:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: mfd: qcom,spmi-pmic: Update gpio
 example
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Stephen Boyd" <sboyd@kernel.org>
X-Mailer: aerc 0.15.2
References: <20230929-pm7250b-gpio-fixup-v1-0-ef68543c1d3b@fairphone.com>
 <20230929-pm7250b-gpio-fixup-v1-1-ef68543c1d3b@fairphone.com>
 <510d6407-8033-4f2e-aabf-bd3fb84875a9@linaro.org>
In-Reply-To: <510d6407-8033-4f2e-aabf-bd3fb84875a9@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Sep 30, 2023 at 5:06 PM CEST, Krzysztof Kozlowski wrote:
> On 29/09/2023 10:17, Luca Weiss wrote:
> > As per commit ea25d61b448a ("arm64: dts: qcom: Use plural _gpios node
> > label for PMIC gpios") all dts files now use the plural _gpios instead
> > of the singular _gpio as label. Update the schema example also to match=
.
> >=20
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml =
b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> > index 55e931ba5b47..e4842e1fbd65 100644
> > --- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> > @@ -245,7 +245,7 @@ examples:
> >              #address-cells =3D <1>;
> >              #size-cells =3D <0>;
> > =20
> > -            pmi8998_gpio: gpio@c000 {
> > +            pmi8998_gpios: gpio@c000=20
>
> This does no=C2=A0make sense... you update label only here, but not in an=
y
> user of it which proves that label is not used. If it is not used, it
> should be dropped, not changed...

Okay, I will drop the label instead of updating it in v2.

Regards
Luca

>
> Best regards,
> Krzysztof

